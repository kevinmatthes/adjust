//////////////////////// GNU General Public License 3.0 ////////////////////////
//                                                                            //
// Copyright (C) 2023 Kevin Matthes                                           //
//                                                                            //
// This program is free software: you can redistribute it and/or modify       //
// it under the terms of the GNU General Public License as published by       //
// the Free Software Foundation, either version 3 of the License, or          //
// (at your option) any later version.                                        //
//                                                                            //
// This program is distributed in the hope that it will be useful,            //
// but WITHOUT ANY WARRANTY; without even the implied warranty of             //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              //
// GNU General Public License for more details.                               //
//                                                                            //
// You should have received a copy of the GNU General Public License          //
// along with this program.  If not, see <https://www.gnu.org/licenses/>.     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module main

import term.ui as terminal

const (
	black              = terminal.Color{0x00, 0x00, 0x00}
	konsole_green      = terminal.Color{0x11, 0xD1, 0x16}
	linguist_gitconfig = terminal.Color{0xF4, 0x4D, 0x27}
	linguist_json5     = terminal.Color{0x26, 0x7C, 0xB9}
	linguist_markdown  = terminal.Color{0x08, 0x3F, 0xA1}
	linguist_nim       = terminal.Color{0xFF, 0xC2, 0x00}
	linguist_rust      = terminal.Color{0xDE, 0xA5, 0x84}
	linguist_tex       = terminal.Color{0x3D, 0x61, 0x17}
	linguist_v         = terminal.Color{0x4F, 0x87, 0xC4}
	linguist_yaml      = terminal.Color{0xCB, 0x17, 0x1E}
	white              = terminal.Color{0xFF, 0xFF, 0xFF}
)

const help_message = 'Yet another text editor for the terminal, written in V.

Usage:
  adjust <FILE_TO_EDIT> [<FILE_TO_EDIT> [<FILE_TO_EDIT> ...]]

Options:
  -h, --help   Show this help message and exit.'

////////////////////////////////////////////////////////////////////////////////
