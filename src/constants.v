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

import term.ui { Color }
import v.vmod { from_file }

const (
	cli_desc = v_mod.description
	cli_name = v_mod.name
	cli_vrsn = v_mod.version
	install  = 'v install --git https://github.com/kevinmatthes/adjust'
	v_mod    = from_file('v.mod') or { panic(err) }
)

const (
	black                = Color{0x00, 0x00, 0x00}
	konsole_green        = Color{0x11, 0xD1, 0x16}
	linguist_asymptote   = Color{0xFF, 0x00, 0x00}
	linguist_bibtex      = Color{0x77, 0x88, 0x99}
	linguist_c           = Color{0x55, 0x55, 0x55}
	linguist_c_plus_plus = Color{0xF3, 0x4B, 0x7D}
	linguist_git         = Color{0xF4, 0x4D, 0x27}
	linguist_json5       = Color{0x26, 0x7C, 0xB9}
	linguist_just        = Color{0x38, 0x4D, 0x54}
	linguist_markdown    = Color{0x08, 0x3F, 0xA1}
	linguist_nim         = Color{0xFF, 0xC2, 0x00}
	linguist_perl        = Color{0x02, 0x98, 0xC3}
	linguist_rust        = Color{0xDE, 0xA5, 0x84}
	linguist_shell       = Color{0x89, 0xE0, 0x51}
	linguist_tex         = Color{0x3D, 0x61, 0x17}
	linguist_v           = Color{0x4F, 0x87, 0xC4}
	linguist_yaml        = Color{0xCB, 0x17, 0x1E}
	white                = Color{0xFF, 0xFF, 0xFF}
)

////////////////////////////////////////////////////////////////////////////////
