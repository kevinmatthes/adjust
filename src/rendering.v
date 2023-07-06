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

fn render(mut adjust Adjust) {
	adjust.window.clear()
	adjust.render_status_bar()
	adjust.render_command_bar()
	adjust.render_cursor()
	adjust.window.flush()
}

fn (mut a Adjust) render_command_bar() {
	a.window.draw_text(0, a.window.window_height, a.command_buffer)
}

fn (mut a Adjust) render_cursor() {
	a.window.set_cursor_position(a.cursor.x, a.cursor.y)
}

fn (mut a Adjust) render_status_bar() {
	mut x := 0
	y := a.window.window_height - 1

	x = a.render_status_bar_mode_name(x, y)
	x = a.render_status_bar_file_name(x, y)

	a.render_status_bar_filling(x, y)
}

fn (mut a Adjust) render_status_bar_file_name(x int, y int) int {
	file := a.files_to_edit[a.current_file]

	a.window.set_bg_color(a.background)
	a.window.set_color(a.foreground)
	a.window.draw_text(x, y, ' ${file} ')
	a.window.reset()

	return x + file.len + 2
}

fn (mut a Adjust) render_status_bar_filling(x int, y int) {
	a.window.set_bg_color(a.background)
	a.window.draw_line(x, y, a.window.window_width, y)
	a.window.reset()
}

fn (mut a Adjust) render_status_bar_mode_name(x int, y int) int {
	mode := a.mode.str()

	a.window.set_bg_color(white)
	a.window.set_color(black)
	a.window.draw_text(x, y, ' ${mode} ')
	a.window.reset()

	return x + mode.len + 3
}

////////////////////////////////////////////////////////////////////////////////
