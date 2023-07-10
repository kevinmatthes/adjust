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

import os

fn (mut a Adjust) close_file() {
	file := a.files_to_edit[a.current_file]

	a.save_file()

	match a.l.bg {
		linguist_nim {
			os.execute('nimpretty ${file}')
		}
		linguist_rust {
			os.execute('rustfmt ${file}')
		}
		linguist_v {
			os.execute('v fmt -w ${file}')
		}
		else {}
	}
}

fn (mut a Adjust) go_to_next_file() {
	if a.files_to_edit.len > 1 {
		a.close_file()

		if a.current_file == a.files_to_edit.len - 1 {
			a.current_file = 0
		} else {
			a.current_file++
		}

		a.load_file()
	}
}

fn (mut a Adjust) go_to_previous_file() {
	if a.files_to_edit.len > 1 {
		a.close_file()

		if a.current_file == 0 {
			a.current_file = a.files_to_edit.len - 1
		} else {
			a.current_file--
		}

		a.load_file()
	}
}

fn (mut a Adjust) load_file() {
	a.data.clear()
	a.init_language()

	if content := os.read_lines(a.files_to_edit[a.current_file]) {
		a.data << content
	}

	if a.data.len == 0 {
		a.data << ''
	}

	for i, line in a.data {
		a.data[i] = line.normalize_tabs(a.l.tab)
	}

	a.v.reset(a.data.len + 1)
	a.text_cursor.x = 0
	a.text_cursor.y = 1
}

fn (a Adjust) save_file() {
	file := a.files_to_edit[a.current_file]
	content := a.data.join_lines() + '\n'
	os.write_file(file, content) or { panic(err) }
}

////////////////////////////////////////////////////////////////////////////////
