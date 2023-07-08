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
import math

struct Adjust {
mut:
	background          terminal.Color = konsole_green
	command_buffer      string
	current_file        int
	data                []string
	files_to_edit       []string
	first_line          int
	foreground          terminal.Color = white
	line_number_filling int
	mode                Mode = .view
	text_cursor         term.Coord
	viewport_cursor     term.Coord
	window              &terminal.Context = unsafe { nil }
}

fn (mut a Adjust) determine_language_colours() {
	file := a.files_to_edit[a.current_file]

	a.background, a.foreground = match os.file_ext(file) {
		'.cff', '.yaml', '.yml' {
			linguist_yaml, white
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
		'.v', '.vsh', '.vv' {
			linguist_v, black
		}
		else {
			match file {
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
		':exit', ':leave', ':quit' {
			a.save_file()

			for file in a.files_to_edit {
				if os.file_ext(file) == '.v' {
					os.execute('v fmt -w .')
					break
				}
			}

			exit(0)
		}
		':exit unchanged', ':leave unchanged', ':quit unchanged' {
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

fn (mut a Adjust) insert_text(s string) {
	if a.viewport_cursor.x < a.window.window_width {
		index := a.text_cursor.y - 1
		mut line := a.data[index].runes()

		line.insert(a.text_cursor.x, s.runes())
		a.data[index] = line.string()
		a.text_cursor.x++
		a.viewport_cursor.x++
	}
}

fn (mut a Adjust) load_file() {
	a.data.clear()
	a.determine_language_colours()

	if content := os.read_lines(a.files_to_edit[a.current_file]) {
		a.data << content
	}

	if a.data.len == 0 {
		a.data << ''
	}

	for i, line in a.data {
		a.data[i] = line.replace('\t', ' '.repeat(8))
	}

	a.line_number_filling = int(math.log10(a.data.len + 1))
	a.text_cursor.x = 0
	a.text_cursor.y = 1
	a.viewport_cursor.x = a.line_number_filling + 6
	a.viewport_cursor.y = 1
}

fn (mut a Adjust) remove_text(r RemoveKey) {
	line := a.text_cursor.y - 1
	mut runes := a.data[line].runes()

	match r {
		.backspace {
			if runes.len > 0 && a.text_cursor.x > 0 {
				runes.delete(a.text_cursor.x - 1)
				a.data[line] = runes.string()
				a.text_cursor.x--
				a.viewport_cursor.x--
			}
		}
		.delete {}
	}
}

fn (a Adjust) save_file() {
	file := a.files_to_edit[a.current_file]
	content := a.data.join('\n') + '\n'
	os.write_file(file, content) or { panic(err) }
}

////////////////////////////////////////////////////////////////////////////////
