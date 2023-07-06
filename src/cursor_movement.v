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

fn (mut a Adjust) move_cursor_down() {
	if a.text_cursor.y < a.data.len {
		a.move_cursor_start()
		a.text_cursor.y++

		if a.viewport_cursor.y == a.window.window_height - 2 {
			a.first_line++
		} else {
			a.viewport_cursor.y++
		}
	}
}

fn (mut a Adjust) move_cursor_left() {
	if a.text_cursor.x > 0 {
		a.text_cursor.x--
		a.viewport_cursor.x--
	}
}

fn (mut a Adjust) move_cursor_right() {
	end_of_line := a.data[a.text_cursor.y - 1].len
	end_of_window := a.window.window_width - 1

	if a.text_cursor.x < end_of_line && a.viewport_cursor.x < end_of_window {
		a.text_cursor.x++
		a.viewport_cursor.x++
	}
}

fn (mut a Adjust) move_cursor_start() {
	if a.text_cursor.x != 0 {
		a.text_cursor.x = 0
		a.viewport_cursor.x = a.line_number_filling + 6
	}
}

fn (mut a Adjust) move_cursor_up() {
	if a.text_cursor.y > 1 {
		a.move_cursor_start()
		a.text_cursor.y--

		if a.viewport_cursor.y > 1 {
			a.viewport_cursor.y--
		} else if a.first_line > 0 {
			a.first_line--
		}
	}
}

////////////////////////////////////////////////////////////////////////////////