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
import os

struct Language {
mut:
	bg  terminal.Color = konsole_green
	fg  terminal.Color = white
	tab int = 4
}

fn (mut l Language) calculate() {
	l.tab = match l.bg {
		linguist_nim, linguist_yaml {
			2
		}
		linguist_v {
			8
		}
		else {
			4
		}
	}
}

fn (mut l Language) deduce(f string) {
	l.bg, l.fg = match os.file_ext(f) {
		'.cff', '.yaml', '.yml' {
			linguist_yaml, white
		}
		'.json5' {
			linguist_json5, white
		}
		'.markdown', '.md', '.mdown', '.mdwn', '.mkd', '.mkdn', '.mkdown' {
			linguist_markdown, white
		}
		'.nim', '.nimble', '.nimrod', '.nims' {
			linguist_nim, white
		}
		'.rs' {
			linguist_rust, black
		}
		'.tex' {
			linguist_tex, white
		}
		'.v', '.vsh', '.vv' {
			linguist_v, black
		}
		else {
			match f {
				'.gitattributes', '.gitconfig', '.gitignore' {
					linguist_gitconfig, white
				}
				'nim.cfg' {
					linguist_nim, white
				}
				'v.mod' {
					linguist_v, black
				}
				else {
					konsole_green, white
				}
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////