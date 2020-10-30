/* 
 *  2CDT Copyright (c) Kevin Thacker
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */


/* The following program is designed to create a .tzx/.cdt from a tape-file stored
on the PC */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef UNIX
#include <sys/io.h>
#else
#include <io.h>
#endif
#include "defs.h"
#include "tzxfile.h"

static int FileBaudRate;
static int FileWriteMethod;
static int SampleRate;


/* I am using a enum, so that I can poke data into structures without
worrying how the compiler has aligned it */
enum
{
	CPC_TAPE_HEADER_FILENAME_BYTE0 = 0,
	CPC_TAPE_HEADER_FILENAME_BYTE1,
	CPC_TAPE_HEADER_FILENAME_BYTE2,
	CPC_TAPE_HEADER_FILENAME_BYTE3,
	CPC_TAPE_HEADER_FILENAME_BYTE4,
	CPC_TAPE_HEADER_FILENAME_BYTE5,
	CPC_TAPE_HEADER_FILENAME_BYTE6,
	CPC_TAPE_HEADER_FILENAME_BYTE7,
	CPC_TAPE_HEADER_FILENAME_BYTE8,
	CPC_TAPE_HEADER_FILENAME_BYTE9,
	CPC_TAPE_HEADER_FILENAME_BYTE10,
	CPC_TAPE_HEADER_FILENAME_BYTE11,
	CPC_TAPE_HEADER_FILENAME_BYTE12,
	CPC_TAPE_HEADER_FILENAME_BYTE13,
	CPC_TAPE_HEADER_FILENAME_BYTE14,
	CPC_TAPE_HEADER_FILENAME_BYTE15,
	CPC_TAPE_HEADER_BLOCK_NUMBER,
	CPC_TAPE_HEADER_LAST_BLOCK_FLAG,
	CPC_TAPE_HEADER_FILE_TYPE,
	CPC_TAPE_HEADER_DATA_LENGTH_LOW,
	CPC_TAPE_HEADER_DATA_LENGTH_HIGH,
	CPC_TAPE_HEADER_DATA_LOCATION_LOW,
	CPC_TAPE_HEADER_DATA_LOCATION_HIGH,
	CPC_TAPE_HEADER_FIRST_BLOCK_FLAG,
	CPC_TAPE_HEADER_DATA_LOGICAL_LENGTH_LOW,
	CPC_TAPE_HEADER_DATA_LOGICAL_LENGTH_HIGH,
	CPC_TAPE_HEADER_DATA_EXECUTION_ADDRESS_LOW,
	CPC_TAPE_HEADER_DATA_EXECUTION_ADDRESS_HIGH,
} CPC_TAPE_HEADER_ENUM;

/* size of header */
#define CPC_TAPE_HEADER_SIZE	64

/* load a file into memory */
BOOL	Host_LoadFile(char *Filename, unsigned char **pLocation, unsigned long *pLength)
{
	FILE	*fh;
	unsigned char	*pData;

	*pLocation = NULL;
	*pLength = 0;

	if (Filename!=NULL)
	{
		if (strlen(Filename)!=0)
		{
			fh = fopen(Filename,"rb");

			if (fh!=NULL)
			{
				int FileSize;

#ifdef WIN32
				int FNo;
				
				FNo = _fileno(fh);
				FileSize = _filelength(FNo);
#else
				unsigned long CurrentPosition;
				CurrentPosition = ftell(fh);
				fseek(fh, 0, SEEK_END);
				FileSize = ftell(fh);
				fseek(fh, CurrentPosition, SEEK_SET);
#endif		
				if (FileSize!=0)
				{
					pData = (unsigned char *)malloc(FileSize);

					if (pData!=NULL)
					{
						fread(pData,1,FileSize,fh);
					
						*pLocation = pData;
						*pLength = FileSize;
					
						fclose(fh);
						return TRUE;
					}
				}

				fclose(fh);
			}
		}
	}

	return FALSE;
}

			
/* calculate checksum as AMSDOS would for the first 66 bytes of a datablock */
/* this is used to determine if a file has a AMSDOS header */
unsigned int AMSDOS_CalculateChecksum(unsigned char *pHeader)
{
        unsigned int Checksum;
        int i;

        Checksum = 0;

        for (i=0; i<67; i++)
        {
                unsigned int CheckSumByte;

                CheckSumByte = pHeader[i] & 0x0ff;

                Checksum+=CheckSumByte;
        }

        return Checksum;
}

/* CRC code shamelessly taken from Pierre Guerrier's AIFF decoder! */
#define kCRCpoly  4129  /* used for binary long division in CRC */

/* CRC polynomial: X^16+X^12+X^5+1 */
unsigned int CRCupdate(unsigned int CRC, unsigned char new)
{
 unsigned int aux = CRC ^ (new << 8);
 int i;

 for(i=0; i<8; i++)
   if (aux & 0x8000)
       aux = (aux <<= 1) ^ kCRCpoly;
     else
       aux <<= 1;

 return(aux);
}

/*
ID : 11  -  Turbo loading data block
-------
        This block is very similar  to  the  normal  TAP  block but  with  some
        additional   info  on  the  timings  and  other  important differences.
        The same tape encoding is used as for the standard speed data block.
        If a  block should  use some  non-standard  sync or  pilot  tones  (for
        example all sorts of protection schemes) then use the next three blocks
        to describe it.

00 2  Length of PILOT pulse                                              [2168]
02 2  Length of SYNC First pulse                                          [667]
04 2  Length of SYNC Second pulse                                         [735]
06 2  Length of ZERO bit pulse                                            [855]
08 2  Length of ONE bit pulse                                            [1710]
0A 2  Length of PILOT tone (in PILOT pulses)           [8064 Header, 3220 Data]
0C 1  Used bits in last byte (other bits should be 0)                       [8]
      i.e. if this is 6 then the bits (x) used in last byte are: xxxxxx00
0D 2  Pause After this block in milliseconds (ms)                        [1000]
0F 3  Length of following data
12 x  Data; format is as for TAP (MSb first)

- Length: [0F,10,11]+12
*/

/* 2 pulses per bit, tone is composed of 1 bits */
#define CPC_PILOT_TONE_NUM_WAVES	(2048)
#define CPC_PILOT_TONE_NUM_PULSES (CPC_PILOT_TONE_NUM_WAVES*2)

#define CPC_NOPS_PER_FRAME (19968)
#define CPC_NOPS_PER_SECOND	(CPC_NOPS_PER_FRAME*50)
#define CPC_T_STATES	(CPC_NOPS_PER_SECOND*4)

#define T_STATE_CONVERSION_FACTOR (TZX_T_STATES<<8)/(CPC_T_STATES>>8)
/* pause between each block */
#define CPC_PAUSE_AFTER_BLOCK_IN_MS	1000
/* pause between tape header and data for block */
#define CPC_PAUSE_AFTER_HEADER_IN_MS 14

void	CPC_InitialiseTurboLoadingDataBlock(TZX_BLOCK *pBlock, int BaudRate,int Pause)
{
	unsigned char *pHeader = TZX_GetBlockHeaderPtr(pBlock);

	if (pHeader!=NULL)
	{
		/* check it is a turbo-loading data block */
		if (pHeader[0] == TZX_TURBO_LOADING_DATA_BLOCK)
		{
			int ZeroPulseLengthInMicroseconds;
			int ZeroPulseLengthInCPCTStates;
			int OnePulseLength;
			int ZeroPulseLength;

			pHeader++;
			/* equation from CPC firmware guide: 
			Average baud rate: = 1 000 000/(3*half zero length) = 333 333/Half zero length
			*/

			ZeroPulseLengthInMicroseconds = 333333/BaudRate;
			ZeroPulseLengthInCPCTStates = ZeroPulseLengthInMicroseconds<<2;
			
			ZeroPulseLength = (ZeroPulseLengthInCPCTStates>>8)*
							(T_STATE_CONVERSION_FACTOR>>8);

			/* one pulse is twice the size of a zero pulse */
			OnePulseLength = ZeroPulseLength<<1;

			/* PILOT pulse on CPC is a one bit */
			pHeader[0x00] = (unsigned char)OnePulseLength;
			pHeader[0x01] = (unsigned char)(OnePulseLength>>8);
					   
			/* SYNC on CPC is a zero bit, both sync pulses will be the same */
			pHeader[0x02] = pHeader[0x04] = (unsigned char)ZeroPulseLength;
			pHeader[0x03] = pHeader[0x05] = (unsigned char)(ZeroPulseLength>>8);

			/* write zero pulse length */
			pHeader[0x06] = (unsigned char)ZeroPulseLength;
			pHeader[0x07] = (unsigned char)(ZeroPulseLength>>8);

			/* write one pulse length */
			pHeader[0x08] = (unsigned char)OnePulseLength;
			pHeader[0x09] = (unsigned char)(OnePulseLength>>8);

			/* PILOT pulse is same as 1 Pulse */
			/* pilot tone is 2048 bits long */
			pHeader[0x0a] = CPC_PILOT_TONE_NUM_PULSES & 0x0ff;
			pHeader[0x0b] = (CPC_PILOT_TONE_NUM_PULSES>>8);

			/* the end of the block will be the trailer bytes. Say all bits are
			used, although, because it doesn't contain useful data it doesn't matter */
			pHeader[0x0c] = 8;

			pHeader[0x0d] = (Pause & 0x0ff);
			pHeader[0x0e] = (Pause>>8);


		}
	}
}




#define CPC_DATA_CHUNK_SIZE 256
#define CPC_DATA_BLOCK_SIZE 2048

/* write a block of data to a file */
void	CPC_WriteTurboLoadingDataBlock(TZX_FILE *pFile, unsigned char SyncPattern, unsigned char *pData, int DataSize, int Pause)
{
	TZX_BLOCK *pBlock;
	unsigned char *pBlockData;
					
	int NumChunks;
	int TZX_DataBlockSize;

	/* divide into complete 256 byte blocks */
	NumChunks = (DataSize+255)>>8;

	/* each tape block is split into 256 chunks, each chunk has a CRC */

	/* size of all chunks, plus CRC's for each block */
	TZX_DataBlockSize = 
		/* size of all chunks */
		(NumChunks<<8) + 
		/* size of CRC's for all chunks */
		(NumChunks<<1) +
		/* size of trailer in bytes */
		4 +
		/* size of sync pattern */
		1;

	

	pBlock = TZX_CreateBlock(TZX_TURBO_LOADING_DATA_BLOCK);
	CPC_InitialiseTurboLoadingDataBlock(pBlock, FileBaudRate,Pause);


	if (pBlock!=NULL)
	{
		/* add block to end of file */
		TZX_AddBlockToEndOfFile(pFile,pBlock);
		
		/* allocate data in block */
		TZX_AddDataToBlock(pBlock, TZX_DataBlockSize);
					
		pBlockData= TZX_GetBlockDataPtr(pBlock);

		if (pBlockData!=NULL)
		{
			int i,j;
			unsigned char *pDataPtr;
			int DataSizeRemaining;
			unsigned char *pBlockPtr;
			unsigned short CRC;
			
			pDataPtr = pData;
			DataSizeRemaining = DataSize;
			pBlockPtr = pBlockData;

			/* write pattern */
			pBlockPtr[0] = SyncPattern;
			pBlockPtr++;

			/* write each chunk in turn and calculate CRC */
			for (i=0; i<NumChunks; i++)
			{
				/* copy data into block */
				if (DataSizeRemaining<CPC_DATA_CHUNK_SIZE)
				{
					/* less than CPC_DATA_CHUNK_SIZE */
					/* copy data, and fill rest with zeros */

					/* copy less than 256 bytes */
					memcpy(pBlockPtr, pDataPtr, DataSizeRemaining);
					/* fill reset of chunk with zero's */
					memset(pBlockPtr + DataSizeRemaining, 0, CPC_DATA_CHUNK_SIZE-DataSizeRemaining);
					/* update source pointer */
					pDataPtr+=DataSizeRemaining;
					/* update size remaining - nothing */
					DataSizeRemaining = 0;
				}
				else
				{
					/* greater or equal to CPC_DATA_CHUNK_SIZE */
					/* copy CPC_DATA_CHUNK_SIZE max */
					memcpy(pBlockPtr, pDataPtr, CPC_DATA_CHUNK_SIZE);
					/* update source pointer */
					pDataPtr += CPC_DATA_CHUNK_SIZE;
					/* update size remaining */
					DataSizeRemaining-=CPC_DATA_CHUNK_SIZE;
				}

				/* reset CRC */
				CRC = 0x0ffff;

				/* calculate CRC for block */
				for (j=0; j<CPC_DATA_CHUNK_SIZE; j++)
				{
					char ch;

					ch = pBlockPtr[0];
					pBlockPtr++;
					CRC = CRCupdate(CRC, ch);
				}
				
				/* store CRC inverted */
				pBlockPtr[0] = (CRC>>8)^0x0ff;
				pBlockPtr++;
				pBlockPtr[0] = CRC^0x0ff;
				pBlockPtr++;
			}


			/* write trailer */
			memset(pBlockPtr, 0x0ff, 4);
		}
	}
}

/*
ID : 14  -  Pure data block
-------
        This is the same as in the turbo loading data block, except that it has
        no pilot or sync pulses.

00 2  Length of ZERO bit pulse
02 2  Length of ONE bit pulse
04 1  Used bits in LAST Byte
05 2  Pause after this block in milliseconds (ms)
07 3  Length of following data
0A x  Data
*/

void	CPC_InitialisePureDataBlock(TZX_BLOCK *pBlock, int BaudRate, int Pause)
{
	unsigned char *pHeader = TZX_GetBlockHeaderPtr(pBlock);

	if (pHeader!=NULL)
	{
		/* check it is a turbo-loading data block */
		if (pHeader[0] == TZX_PURE_DATA_BLOCK)
		{
			int ZeroPulseLengthInMicroseconds;
			int ZeroPulseLengthInCPCTStates;
			int OnePulseLength;
			int ZeroPulseLength;

			pHeader++;
			/* equation from CPC firmware guide: 
			Average baud rate: = 1 000 000/(3*half zero length) = 333 333/Half zero length
			*/

			ZeroPulseLengthInMicroseconds = 333333/BaudRate;
			ZeroPulseLengthInCPCTStates = ZeroPulseLengthInMicroseconds<<2;
			
			ZeroPulseLength = (ZeroPulseLengthInCPCTStates>>8)*
							(T_STATE_CONVERSION_FACTOR>>8);

			/* one pulse is twice the size of a zero pulse */
			OnePulseLength = ZeroPulseLength<<1;
			/* write zero pulse length */
			pHeader[0x00] = ZeroPulseLength;
			pHeader[0x01] = ZeroPulseLength>>8;

			/* write one pulse length */
			pHeader[0x02] = OnePulseLength;
			pHeader[0x03] = OnePulseLength>>8;
			
			/* the end of the block will be the trailer bytes. Say all bits are
			used, although, because it doesn't contain useful data it doesn't matter */
			pHeader[0x04] = 8;

			/* write pause */
			pHeader[0x05] = (Pause & 0x0ff);
			pHeader[0x06] = (Pause>>8) & 0x0ff;


		}
	}
}


/* the following is for a bitstream */
unsigned char *pData;
unsigned long ByteCount;
unsigned long BitCount;

/* initialise bit stream with buffer to write data to */
void	BitStream_Initialise(unsigned char *pBuffer)
{
	pData = pBuffer;
	ByteCount = 0;
	BitCount = 0;
}

/* write bit to stream */
void	BitStream_WriteBit(int Bit)
{
	unsigned char Data;

	/* get current data written */
	Data = pData[ByteCount];
	Data &= ~(1<<(7-BitCount));
	Data |= (Bit<<(7-BitCount));
	pData[ByteCount] = Data;

	/* increment bit count */
	BitCount++;
	/* if we overrun 8-bits, then bit 3 will be set, add this on */
	ByteCount += (BitCount>>3);
	/* mask off bit count */
	BitCount &= 0x07;
}

/* write byte to stream */
void	BitStream_WriteByte(unsigned char Byte)
{
	int b;
	int Bit;
	unsigned char LocalByte;

	LocalByte = Byte;

	for (b=0; b<8; b++)
	{
		Bit = LocalByte & 0x080;
		Bit = Bit>>7;
		BitStream_WriteBit(Bit);
		LocalByte = LocalByte<<1;
	}
}



/* write a block of data to a file */
void	CPC_WritePureDataBlock(TZX_FILE *pFile, unsigned char SyncPattern, unsigned char *pData, int DataSize, int Pause)
{
	TZX_BLOCK *pBlock;
	unsigned char *pBlockData;
					
	int NumChunks;
	int TZX_DataBlockSize;

	/* divide into complete 256 byte blocks */
	NumChunks = (DataSize+255)>>8;

	/* each tape block is split into 256 chunks, each chunk has a CRC */

	/* size of all chunks, plus CRC's for each block */
	TZX_DataBlockSize = 
		/* size of all chunks */
		(NumChunks<<8) + 
		/* size of CRC's for all chunks */
		(NumChunks<<1) +
		/* size of trailer in bytes */
		4 +
		/* size of sync pattern */
		1;

	TZX_DataBlockSize+=
		/* pilot tone - CPC_PILOT_TONE_NUM_WAVES 1 bit's, a zero bit then data as before ... */
		((CPC_PILOT_TONE_NUM_WAVES + 1)+7)>>3;
	
	pBlock = TZX_CreateBlock(TZX_PURE_DATA_BLOCK);
	CPC_InitialisePureDataBlock(pBlock, FileBaudRate,Pause);


	if (pBlock!=NULL)
	{
		/* add block to end of file */
		TZX_AddBlockToEndOfFile(pFile,pBlock);
		
		/* allocate data in block */
		TZX_AddDataToBlock(pBlock, TZX_DataBlockSize);
					
		pBlockData= TZX_GetBlockDataPtr(pBlock);

		if (pBlockData!=NULL)
		{
			int i,j;
			unsigned char *pDataPtr;
			int DataSizeRemaining;
			unsigned char *pBlockPtr;
			unsigned short CRC;

			pDataPtr = pData;
			DataSizeRemaining = DataSize;
			pBlockPtr = pBlockData;

			BitStream_Initialise(pBlockPtr);

			/* write leader */
			for (i=0; i<CPC_PILOT_TONE_NUM_WAVES; i++)
			{
				BitStream_WriteBit(1);
			}

			BitStream_WriteBit(0);


			BitStream_WriteByte(SyncPattern);

			/* write each chunk in turn and calculate CRC */
			for (i=0; i<NumChunks; i++)
			{
				int BlockSizeToWrite;
				
				/* copy data into block */
				if (DataSizeRemaining<CPC_DATA_CHUNK_SIZE)
				{
					BlockSizeToWrite = DataSizeRemaining;
				}
				else
				{
					BlockSizeToWrite = CPC_DATA_CHUNK_SIZE;
				}

				CRC = 0x0ffff;

				for (j=0; j<BlockSizeToWrite; j++)
				{
					char ch;

					/* get byte */
					ch = pDataPtr[0];
					pDataPtr++;
					/* update CRC */
					CRC = CRCupdate(CRC, ch);
					/* write byte to stream */
					BitStream_WriteByte(ch);
				}

				if (BlockSizeToWrite!=CPC_DATA_CHUNK_SIZE)
				{
					/* write padding zero's */
					for (j=0; j<(CPC_DATA_CHUNK_SIZE-BlockSizeToWrite); j++)
					{
						char ch;

						ch = 0;
						/* update CRC */
						CRC = CRCupdate(CRC, ch);
						/* write byte to stream */
						BitStream_WriteByte(ch);
					}
				}

				DataSizeRemaining-=BlockSizeToWrite;

				CRC = CRC^0x0ffff;

				BitStream_WriteByte((CRC>>8));
				BitStream_WriteByte(CRC);
			}

			/* write trailer */
			for (i=0; i<32; i++)
			{
				BitStream_WriteBit(1);
			}
		}
	}
}

/* write a data block in format specified */
void	CPC_WriteDataBlock(TZX_FILE *pFile, unsigned char SyncByte, unsigned char *pData, unsigned long DataSize, int Pause)
{
	switch (FileWriteMethod)
	{
		case TZX_TURBO_LOADING_DATA_BLOCK:
		{
			CPC_WriteTurboLoadingDataBlock(pFile, SyncByte, pData, DataSize,Pause);
		}
		break;

		case TZX_PURE_DATA_BLOCK:
		{
			/* write header */
			CPC_WritePureDataBlock(pFile, SyncByte, pData, DataSize,Pause);
		}
		break;
	}
}

#define UTILITY_NAME "2CDT"

typedef struct ARGUMENT_HANDLER
{
	/* count of current argument */
	int Count;
	
	/* number of args */
	int argc;
	/* argument array */
	char **argv;

	/* error code 0= no error, 1 = error */
	int error_code;

} ARGUMENT_HANDLER;

typedef struct OPTION
{
	/* name of option */
	char *option_string;
	/* number of parameters taken by option */
	int	num_parameters;

	BOOL (*pHandlerFunction)(struct ARGUMENT_HANDLER *pHandler);
} OPTION;

BOOL	SpecifyBaudRate(struct ARGUMENT_HANDLER *pHandler);
BOOL	SpecifySpeedWrite0(struct ARGUMENT_HANDLER *pHandler);
BOOL	SpecifySpeedWrite1(struct ARGUMENT_HANDLER *pHandler);
BOOL	SpecifyPureDataBlock(struct ARGUMENT_HANDLER *pHandler);
BOOL	SpecifyTurboLoadingDataBlock(struct ARGUMENT_HANDLER *pHandler);

/* table of options supported */
OPTION OptionTable[]=
{
	{"b", 1, SpecifyBaudRate},
	{"s0", 0, SpecifySpeedWrite0},
	{"s1", 0, SpecifySpeedWrite1},
	{"p", 0, SpecifyPureDataBlock},
	{"t", 0, SpecifyTurboLoadingDataBlock},
};

#define NUM_OPTIONS (sizeof(OptionTable)/sizeof(OPTION))

/* locate option data in list */
OPTION *ArgumentList_LookupOption(char *pOptionName)
{
	int i;
	OPTION *pOption;

	pOption = OptionTable;

	for (i=0; i<NUM_OPTIONS; i++)
	{
		/* name matches? */
		if (strcmp(pOption->option_string,pOptionName)==0)
		{
			/* return this option */
			return pOption;
		}
		
		pOption++;
	}

	/* option not found! */
	return NULL;
}

/* initialise argument list handler */
void	ArgumentList_Initialise(ARGUMENT_HANDLER *pHandler,int argc, char *argv[])
{
	/* setup count - argument 0 is the name of the program run */
	pHandler->Count = 1;
	/* number of arguments specified */
	pHandler->argc = argc;
	/* pointer to each argument */
	pHandler->argv = argv;
}

/* get next non-option, i.e. without preceeding "-" */
char *ArgumentList_GetNextNonOption(ARGUMENT_HANDLER *pHandler)
{
	pHandler->error_code = 0;

	/* while there are arguments remaining */
	while (pHandler->Count<pHandler->argc)
	{
		/* is an option? */
		if (pHandler->argv[pHandler->Count][0]=='-')
		{
			/* yes */
			OPTION *pOption;

			/* look up */
			pOption = ArgumentList_LookupOption(&pHandler->argv[pHandler->Count][1]);

			/* found? */
			if (pOption!=NULL)
			{
				/* yes */
				pHandler->Count+=pOption->num_parameters+1;
			}
			else
			{
				pHandler->error_code = 1;

				/* error! */
				return NULL;
			}

		}
		else
		{
			pHandler->Count++;

			return pHandler->argv[pHandler->Count-1];
		}
	}

	/* no more available */
	return NULL;
}


/* get next option, i.e. with preceeding "-" */
OPTION *ArgumentList_GetNextOption(ARGUMENT_HANDLER *pHandler)
{
	pHandler->error_code = 0;

	/* while there are arguments remaining */
	while (pHandler->Count<pHandler->argc)
	{
		/* is an option? */
		if (pHandler->argv[pHandler->Count][0]=='-')
		{
			/* yes */
			OPTION *pOption;

			/* look up */
			pOption = ArgumentList_LookupOption(&pHandler->argv[pHandler->Count][1]);

			/* found? */
			if (pOption!=NULL)
			{
				/* yes */
				pHandler->Count+=pOption->num_parameters + 1;

				/* return */
				return pOption;
			}
			else
			{
				pHandler->error_code = 1;

				/* error! */
				return NULL;
			}

		}
		else
		{
			pHandler->Count++;
		}

	}

	/* no more available */
	return NULL;
}

char *ArgumentList_GetNext(ARGUMENT_HANDLER *pHandler)
{
	/* while there are arguments remaining */
	while (pHandler->Count<pHandler->argc)
	{
		pHandler->Count++;
		
		return pHandler->argv[pHandler->Count-1];
	}

	/* no more available */
	return NULL;
}


/* execute all options - FALSE if error occured, TRUE if no error */
BOOL ArgumentList_ParseOptions(ARGUMENT_HANDLER *pHandler)
{
	OPTION *pOption;

	do
	{
		pOption = ArgumentList_GetNextOption(pHandler);
		
		if (pOption!=NULL)
		{
			if (pOption->pHandlerFunction!=NULL)
			{
				if (!pOption->pHandlerFunction(pHandler))
				{
					return FALSE;
				}

			}
		}
		else
		{
			/* option was present, but not recognised! */
			if (pHandler->error_code == 1)
			{
				/* display error */
				printf("Option \"%s\" not recognised!\r\n", pHandler->argv[pHandler->Count]);
				/* error */
				return FALSE;
			}
		}

	}
	while (pOption!=NULL);

	/* no errors */
	return TRUE;
}




BOOL SpecifyBaudRate(struct ARGUMENT_HANDLER *pHandler)
{
	ARGUMENT_HANDLER LocalHandler;
	char *pParameter;
    int BaudRate;

	memcpy(&LocalHandler, pHandler, sizeof(ARGUMENT_HANDLER));
	
	pParameter = ArgumentList_GetNext(&LocalHandler);
	
	if (pParameter[0]=='-')
	{
		return FALSE;
	}

	/* convert string to int */
	BaudRate =  strtol( pParameter, NULL, 10);

	/* check it is valid! */
	if (BaudRate>0)
	{
		FileBaudRate = BaudRate;

		return TRUE;
	}

	return FALSE;
}



BOOL	SpecifySpeedWrite0(struct ARGUMENT_HANDLER *pHandler)
{
	FileBaudRate = 1000;

	return TRUE;
}

BOOL	SpecifySpeedWrite1(struct ARGUMENT_HANDLER *pHandler)
{
	FileBaudRate = 2000;

	return TRUE;
}

BOOL	SpecifyPureDataBlock(struct ARGUMENT_HANDLER *pHandler)
{
	FileWriteMethod = TZX_PURE_DATA_BLOCK;

	return TRUE;
}
	
BOOL	SpecifyTurboLoadingDataBlock(struct ARGUMENT_HANDLER *pHandler)
{
	FileWriteMethod = TZX_TURBO_LOADING_DATA_BLOCK;
	
	return TRUE;
}

void	DisplayInfo()
{
		printf("%s will transfer files into a .CDT/.TZX tape image, in Amstrad CPC/CPC+\r\n", UTILITY_NAME);
		printf("KC Compact form.\r\n\r\n");
		printf("Usage: %s [arguments] <source tape-file> <dest .cdt image>\r\n\r\n", UTILITY_NAME);
		printf("-b <number>	= Specify Baud rate (default 2000)\r\n");
		printf("-s0			= Specify Speed Write 0\r\n");
		printf("-s1			= Specify Speed Write 1\r\n");
		printf("-p			= Write data with Pure Data Block\r\n");
		printf("-t			= Write data with Turbo Loading Data Block (default)\r\n");
}

int		main(int argc, char *argv[])
{
	if (argc==1)
	{
		DisplayInfo();
	}
	else
	{
		TZX_FILE *pTZXFile;
		ARGUMENT_HANDLER Handler;
		unsigned char *pSourceFilename;
		unsigned char *pDestFilename;
		unsigned char *pData;
		unsigned long DataLength;

		/* initialise defaults */
		FileBaudRate = 2000;
		FileWriteMethod = TZX_TURBO_LOADING_DATA_BLOCK;
		SampleRate = 22050;
	
		ArgumentList_Initialise(&Handler, argc, argv);
			
		if (!ArgumentList_ParseOptions(&Handler))
		{
			DisplayInfo();
		
			exit(1);

		}
	
		ArgumentList_Initialise(&Handler, argc, argv);
	
		pSourceFilename = (unsigned char *)ArgumentList_GetNextNonOption(&Handler);

		if (pSourceFilename==NULL)
		{
			printf("Error. No input filename specified!\r\n\r\n");

			DisplayInfo();

			exit(1);
		}

		pDestFilename = (unsigned char *)ArgumentList_GetNextNonOption(&Handler);

		if (pDestFilename==NULL)
		{
			printf("Error. No output filename specified!\r\n\r\n");

			DisplayInfo();

			exit(1);
		}


		if (Host_LoadFile(pSourceFilename, &pData, &DataLength))
		{
			/* create TZX file */
			pTZXFile = TZX_CreateFile(TZX_VERSION_MAJOR,TZX_VERSION_MINOR);

			if (pTZXFile!=NULL)
			{
			

				int FileOffset;
				int FileLengthRemaining;
				int TapeBlockSize;
				BOOL FirstBlock,LastBlock;
				int BlockIndex;
				unsigned short BlockLocation;

				/* header for tape file */
				unsigned char TapeHeader[CPC_TAPE_HEADER_SIZE];

				/* calculate checksum from loaded file */
				unsigned short CalculatedChecksum = (unsigned short)AMSDOS_CalculateChecksum(pData);

				/* get stored checksum */
				unsigned short StoredChecksum = 
									(pData[67] & 0x0ff) |
									 (pData[68] & 0x0ff)<<8;

				FileOffset = 0;
				FileLengthRemaining = DataLength;
				BlockIndex = 1;
				FirstBlock =TRUE;

				/* insert a pause block - 1 second */
				{

					TZX_BLOCK *pBlock;

					pBlock = TZX_CreateBlock(TZX_PAUSE_BLOCK);
					
					if (pBlock!=NULL)
					{
						TZX_SetupPauseBlock(pBlock, 1000);
					}
				}

				/* clear tape header */
				memset(TapeHeader, 0, CPC_TAPE_HEADER_SIZE);

				/* setup initial file type - binary */
				TapeHeader[CPC_TAPE_HEADER_FILE_TYPE] = (1<<1);
				
				/* checksum's match? */
				if (CalculatedChecksum==StoredChecksum)
				{
					unsigned char TapeFilename[16];

					/* copy file type */
					TapeHeader[CPC_TAPE_HEADER_FILE_TYPE] = pData[CPC_TAPE_HEADER_FILE_TYPE];
					/* copy execution address */
					TapeHeader[CPC_TAPE_HEADER_DATA_EXECUTION_ADDRESS_LOW] = pData[CPC_TAPE_HEADER_DATA_EXECUTION_ADDRESS_LOW];
					TapeHeader[CPC_TAPE_HEADER_DATA_EXECUTION_ADDRESS_HIGH] = pData[CPC_TAPE_HEADER_DATA_EXECUTION_ADDRESS_HIGH];
					/* copy data location */
					TapeHeader[CPC_TAPE_HEADER_DATA_LOCATION_LOW] = pData[CPC_TAPE_HEADER_DATA_LOCATION_LOW];
					TapeHeader[CPC_TAPE_HEADER_DATA_LOCATION_HIGH] = pData[CPC_TAPE_HEADER_DATA_LOCATION_HIGH];

					FileOffset+=128;
					FileLengthRemaining-=128;

					/* convert AMSDOS filename to a valid tape filename */
					{
						char ch;
						int count;

						/* copy filename from header */				
						memcpy(TapeFilename, pData+1, 16);
					
						/* copy up to space, or 8 chars */
						count = 0;
						do
						{
							/* get char */
							ch = TapeFilename[count];
							/* transfer char */
							TapeHeader[count] = ch;

							count++;
						}
						while ((ch!=' ') && (count<8));

						/* if we quit on a space, go back */
						if (ch==' ')
							count--;

						/* has an extension? */
						if (TapeFilename[8]!=' ')
						{
							/* yes. Put . seperator */
							TapeHeader[8] = '.';
							
							/* copy extension */
							do
							{
								ch = TapeFilename[8+count];
								/* transfer char */
								TapeHeader[count] = ch;

								count++;
							}
							while ((ch!=' ') && (count<3));
						}

						TapeHeader[count] = '\0';
					}
				}
				else
				{
					char DummyFilename[16]="DUMMY";

					/* does not have a amsdos header */
					memcpy(TapeHeader, DummyFilename, 5);
				}

				TapeHeader[CPC_TAPE_HEADER_DATA_LOGICAL_LENGTH_LOW] = (FileLengthRemaining & 0x0ff);
				TapeHeader[CPC_TAPE_HEADER_DATA_LOGICAL_LENGTH_HIGH] = (FileLengthRemaining>>8) & 0x0ff;
	

				BlockLocation = TapeHeader[CPC_TAPE_HEADER_DATA_LOCATION_LOW] | 
								(TapeHeader[CPC_TAPE_HEADER_DATA_LOCATION_HIGH]<<8);
				do
				{
					/* calc size of tape data block */
					if (FileLengthRemaining>CPC_DATA_BLOCK_SIZE)
					{
						TapeBlockSize = CPC_DATA_BLOCK_SIZE;
						LastBlock = FALSE;
					}
					else
					{
						TapeBlockSize = FileLengthRemaining;
						LastBlock = TRUE;
					}

					{

						unsigned char Flag;
						
						/**** HEADER ****/
						/* SETUP TAPE RELATED DATA */
						/* block index */
						TapeHeader[CPC_TAPE_HEADER_BLOCK_NUMBER] = BlockIndex;

						/* first block? */
						if (FirstBlock)
						{
							FirstBlock = FALSE;

							Flag = 0x0ff;
						}
						else
						{
							Flag = 0;
						}

						TapeHeader[CPC_TAPE_HEADER_FIRST_BLOCK_FLAG] = Flag;

						/* last block? */
						if (LastBlock)
						{
							Flag = 0x0ff;
						}
						else
						{
							Flag = 0;
						}
						
						TapeHeader[CPC_TAPE_HEADER_LAST_BLOCK_FLAG] = Flag;

						/* size of data following */
						TapeHeader[CPC_TAPE_HEADER_DATA_LENGTH_LOW] = (unsigned char)TapeBlockSize;
						TapeHeader[CPC_TAPE_HEADER_DATA_LENGTH_HIGH] = (unsigned char)(TapeBlockSize>>8);

						/* location of block */
						TapeHeader[CPC_TAPE_HEADER_DATA_LOCATION_LOW] = (unsigned char)BlockLocation;
						TapeHeader[CPC_TAPE_HEADER_DATA_LOCATION_HIGH] = (unsigned char)(BlockLocation>>8);

						/* write header */
						CPC_WriteDataBlock(pTZXFile, 0x02c, TapeHeader, CPC_TAPE_HEADER_SIZE,0);
						
						/* write data into block */
						CPC_WriteDataBlock(pTZXFile, 0x016, &pData[FileOffset], TapeBlockSize,CPC_PAUSE_AFTER_BLOCK_IN_MS);

			
					}

					BlockLocation+=TapeBlockSize;
					BlockIndex++;
					FileOffset+=TapeBlockSize;
					FileLengthRemaining -= TapeBlockSize;
				}
				while (FileLengthRemaining!=0);


				/* write file */
				TZX_WriteFile(pTZXFile, pDestFilename);
			
				/* free it */
				TZX_FreeFile(pTZXFile);

			}
			else
			{
				printf("Failed to open output file!\r\n");
				exit(1);
			}
		}
		else
		{
			printf("Failed to open input file!\r\n");
			exit(1);
		}

	}
	exit(0);

	return 0;
}
