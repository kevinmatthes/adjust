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
	adjust.v.win.clear()
	adjust.render_lines()
	adjust.render_status_bar()
	adjust.render_command_bar()
	adjust.render_cursor()
	adjust.v.win.flush()
}

fn (mut a Adjust) render_command_bar() {
	a.v.win.draw_text(0, a.v.win.window_height, a.command_buffer)
}

fn (mut a Adjust) render_cursor() {
	a.v.win.set_cursor_position(a.v.pos.x, a.v.pos.y)
}

fn (mut a Adjust) render_line(i int) bool {
	return if i - 1 < a.data.len {
		times := a.v.lnf - int(math.log10(i + 1))
		number := '${' '.repeat(times)}${i}'
		line := ' ${number} │ ${a.data[i - 1]}'.limit(a.v.win.window_width)

		a.v.win.draw_text(0, i - a.v.fst, line)

		true
	} else {
		false
	}
}

fn (mut a Adjust) render_lines() {
	for i in 1 .. a.v.win.window_height - 1 {
		if !a.render_line(i + a.v.fst) {
			break
		}
	}
}

fn (mut a Adjust) render_status_bar() {
	mut x := 0
	y := a.v.win.window_height - 1

	x = a.render_status_bar_mode_name(x, y)
	x = a.render_status_bar_file_name(x, y)

	a.render_status_bar_filling(x, y)
}

fn (mut a Adjust) render_status_bar_file_name(x int, y int) int {
	file := a.files_to_edit[a.current_file]
	position := ' ${a.text_cursor.x} : ${a.text_cursor.y} @ ${file} '

	a.v.win.set_bg_color(a.l.bg)
	a.v.win.set_color(a.l.fg)
	a.v.win.draw_text(x, y, position)
	a.v.win.reset()

	return x + position.len
}

fn (mut a Adjust) render_status_bar_filling(x int, y int) {
	a.v.win.set_bg_color(a.l.bg)
	a.v.win.draw_line(x, y, a.v.win.window_width, y)
	a.v.win.reset()
}

fn (mut a Adjust) render_status_bar_mode_name(x int, y int) int {
	mode := a.mode.str()

	a.v.win.set_bg_color(white)
	a.v.win.set_color(black)
	a.v.win.draw_text(x, y, ' ${mode} ')
	a.v.win.reset()

	return x + mode.len + 3
}

////////////////////////////////////////////////////////////////////////////////
