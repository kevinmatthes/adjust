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
import term
import term.ui as terminal

struct Adjust {
mut:
	command_buffer string
	current_file   int
	cursor         term.Coord
	data           []string
	files_to_edit  []string
	mode           Mode = .view
	window         &terminal.Context = unsafe { nil }
}

fn (mut a Adjust) execute_command() {
	match a.command_buffer {
		':cancel', ':view' {
			a.mode = .view
			a.command_buffer = ''
		}
		':edit', ':insert' {
			a.mode = .insert
			a.command_buffer = ''
		}
		':exit', ':quit' {
			exit(0)
		}
		':save', ':write' {
			a.save_file()
			a.command_buffer = ':'
		}
		else {
			a.command_buffer = ':'
		}
	}
}

fn (mut a Adjust) go_to_next_file() {
	if a.files_to_edit.len > 1 {
		a.save_file()

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
		a.save_file()

		if a.current_file == 0 {
			a.current_file = a.files_to_edit.len - 1
		} else {
			a.current_file--
		}

		a.load_file()
	}
}

fn (mut a Adjust) load_file() {
	if content := os.read_lines(a.files_to_edit[a.current_file]) {
		a.data.clear()
		a.data << content
	}
}

fn (a Adjust) save_file() {
	file := a.files_to_edit[a.current_file]
	content := a.data.join('\n') + '\n'
	os.write_file(file, content) or { panic(err) }
}

////////////////////////////////////////////////////////////////////////////////
