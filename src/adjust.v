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

import term { Coord }

struct Adjust {
mut:
	current_file  int
	data          []string
	files_to_edit []string
	l             Language
	s             Status
	text_cursor   Coord
	v             Viewport
}

fn (mut a Adjust) delete_current_line() {
	if a.data.len > 1 {
		line := a.text_cursor.y - 1
		a.data.delete(line)

		if a.text_cursor.y > a.data.len {
			a.text_cursor.y = a.data.len

			if a.v.pos.y == 1 {
				a.v.fst--
			} else {
				a.v.pos.y--
			}
		} else if a.text_cursor.x > a.data[line].len_utf8() {
			a.move_cursor_end()
		}
	} else if a.data.len == 1 {
		a.data[0] = ''
	}
}

fn (mut a Adjust) execute_command() {
	match a.s.cb {
		':cancel', ':view' {
			a.s.view()
			a.s.reset()
		}
		':edit', ':insert' {
			a.s.insert()
			a.s.reset()
		}
		':exit', ':leave', ':quit' {
			a.quit()
		}
		':exit unchanged', ':leave unchanged', ':quit unchanged' {
			a.quit_unchanged()
		}
		':format', ':reformat' {
			a.reformat_file()
			a.s.reset()
		}
		':save', ':write' {
			a.save_file()
			a.s.reset()
		}
		else {
			a.s.reset()
		}
	}
}

fn (mut a Adjust) init_language() {
	a.l.init(a.files_to_edit[a.current_file])
}

fn (mut a Adjust) insert_text(s string) {
	if a.v.pos.x < a.v.win.window_width {
		index := a.text_cursor.y - 1
		mut line := a.data[index].runes()
		runes := s.runes()

		line.insert(a.text_cursor.x, runes)
		a.data[index] = line.string()
		a.text_cursor.x += runes.len
		a.v.pos.x += runes.len

		if a.v.pos.x > a.v.win.window_width {
			a.move_cursor_end()
		}
	}
}

fn (mut a Adjust) quit() {
	a.close_file()
	exit(0)
}

fn (a &Adjust) quit_unchanged() {
	exit(0)
}

fn (mut a Adjust) reformat_file() {
	a.close_file()
	a.load_file()
}

fn (mut a Adjust) remove_text(r RemoveKey) {
	line := a.text_cursor.y - 1
	mut runes := a.data[line].runes()

	match r {
		.backspace {
			if a.text_cursor.x > 0 {
				runes.delete(a.text_cursor.x - 1)
				a.data[line] = runes.string()
				a.text_cursor.x--
				a.v.pos.x--
			} else if a.text_cursor.x == 0 && line > 0 {
				previous := a.data[line - 1]
				this := a.data[line]

				a.data[line - 1] = previous + this
				a.data.delete(line)
				a.text_cursor.x = previous.len
				a.text_cursor.y--
				a.v.pos.x = a.v.lnf + 6 + previous.len
				a.v.pos.y--

				if a.v.pos.x > a.v.win.window_width {
					a.move_cursor_end()
				}
			}
		}
		.delete {
			end_of_line := a.text_cursor.x == a.data[line].len_utf8()
			not_last_line := a.text_cursor.y < a.data.len

			if a.text_cursor.x < a.data[line].len_utf8() {
				runes.delete(a.text_cursor.x)
				a.data[line] = runes.string()
			} else if end_of_line && not_last_line {
				a.data[line] += a.data[line + 1]
				a.data.delete(line + 1)
			}
		}
	}
}

fn (mut a Adjust) split_line() {
	line := a.text_cursor.y - 1
	new := a.data[line].runes()[a.text_cursor.x..].string()

	a.data[line] = a.data[line].limit(a.text_cursor.x)
	a.data.insert(a.text_cursor.y, new)
	a.v.refill(a.data.len + 1)
}

////////////////////////////////////////////////////////////////////////////////
