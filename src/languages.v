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
import os { execute, file_ext, file_name }

struct Language {
mut:
	bg  Color = konsole_green
	fg  Color = white
	tab int   = 4
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
	l.bg, l.fg = match file_name(f) {
		'.gitattributes', '.gitconfig', '.gitignore' {
			linguist_git, white
		}
		'.justfile', 'justfile' {
			linguist_just, white
		}
		'.latexmkrc', 'LatexMk', 'latexmkrc' {
			linguist_perl, white
		}
		'nim.cfg' {
			linguist_nim, white
		}
		'v.mod' {
			linguist_v, black
		}
		else {
			match file_ext(f) {
				'.C', '.CPP', '.H', '.HPP', '.c++', '.cc', '.cp', '.cpp', '.cxx', '.h++', '.hh',
				'.hp', '.hpp', '.hxx', '.ii', '.tcc' {
					linguist_c_plus_plus, black
				}
				'.asy' {
					linguist_asymptote, white
				}
				'.bash', '.sh' {
					linguist_shell, black
				}
				'.bib' {
					linguist_bibtex, black
				}
				'.c', '.h', '.i' {
					linguist_c, white
				}
				'.cff', '.yaml', '.yml' {
					linguist_yaml, white
				}
				'.cfg', '.ini' {
					linguist_configuration, black
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
				'.pl' {
					linguist_perl, white
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
					konsole_green, white
				}
			}
		}
	}
}

fn (mut l Language) init(f string) {
	l.deduce(f)
	l.calculate()
}

fn (l &Language) reformat(f string) {
	match l.bg {
		linguist_c, linguist_c_plus_plus { execute('indent ${f}') }
		linguist_nim { execute('nimpretty ${f}') }
		linguist_rust { execute('rustfmt ${f}') }
		linguist_tex { execute('latexmk') }
		linguist_v { execute('v fmt -w ${f}') }
		else {}
	}
}

////////////////////////////////////////////////////////////////////////////////
