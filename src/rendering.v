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

import math

fn render(mut adjust Adjust) {
	adjust.window.clear()
	adjust.render_lines()
	adjust.render_status_bar()
	adjust.render_command_bar()
	adjust.render_cursor()
	adjust.window.flush()
}

fn (mut a Adjust) render_command_bar() {
	a.window.draw_text(0, a.window.window_height, a.command_buffer)
}

fn (mut a Adjust) render_cursor() {
	a.window.set_cursor_position(a.viewport_cursor.x, a.viewport_cursor.y)
}

fn (mut a Adjust) render_line(i int) bool {
	return if i - 1 < a.data.len {
		times := a.line_number_filling - int(math.log10(i + 1))
		number := '${' '.repeat(times)}${i}'
		line := ' ${number} │ ${a.data[i - 1]}'.limit(a.window.window_width)

		a.window.draw_text(0, i - a.first_line, line)

		true
	} else {
		false
	}
}

fn (mut a Adjust) render_lines() {
	for i in 1 .. a.window.window_height - 1 {
		if !a.render_line(i + a.first_line) {
			break
		}
	}
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
	position := ' ${a.text_cursor.x} : ${a.text_cursor.y} @ ${file} '

	a.window.set_bg_color(a.l.bg)
	a.window.set_color(a.l.fg)
	a.window.draw_text(x, y, position)
	a.window.reset()

	return x + position.len
}

fn (mut a Adjust) render_status_bar_filling(x int, y int) {
	a.window.set_bg_color(a.l.bg)
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
