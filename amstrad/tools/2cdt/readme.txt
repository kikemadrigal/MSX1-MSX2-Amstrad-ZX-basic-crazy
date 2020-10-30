2CDT
====

(c) Kevin Thacker

(Original code written in May 2000, fixed and released in May 2001)

2CDT is a utility to transfer files into a ".CDT" Tape-Image.

A ".CDT" is a tape-image file which describes the data stored on a cassette tape.
 
This file format is very powerful and can describe fast and custom loaders as well
as standard operating system formats.

The ".CDT" file format is identical to the ".TZX" format. The extension is used
to differentiate between Spectrum and Amstrad Tape-Images.

The ".TZX" file format was originally designed to store Spectrum tape programs,
it's format can be found from various sources, one of these is "World Of Spectrum":
http://www.void.jump.org/

There are a number of tools which already create .TZX files, Taper, Voc2TZX and MakeTZX.
However, these are designed to recognise Spectrum tape loaders, and so do not do well
at creating a tape-image for Amstrad formats.

This tool has been designed as a starting point for furthur Amstrad CDT tools,
and as a program to generate reference tape-images which can be used by emulator
authors to support this tape-image format in their programs.

This tool is designed to "inject" a file into a ".CDT" in the format written by the Amstrad
operating system. The tool allows the user to define the ".CDT" "recording" method and baud
rate.

2CDT	[parameters]	<input filename> <output filename>

parameters:

	-s0		= Write data with speed write 0 (1000 baud)
	-s1		= Write data with speed write 1 (2000 baud)
	-b <baud rate>  = Specify Baud Rate.
	-t		= Use TZX Turbo Loading Data Block to store data
	-p		= Use TZX Pure Data Block to store data

This archive contains a Windows command-line executable that will run under Win95, Win98,
Win2000 and WinNT.

License:

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.