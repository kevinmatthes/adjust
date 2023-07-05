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

struct Adjust {
mut:
	command_buffer string
	current_file   int
	files_to_edit  []string
	mode           Mode = .view
	window         &terminal.Context = unsafe { nil }
}

fn (mut self Adjust) execute_command() {
	match self.command_buffer {
		':exit', ':quit' {
			exit(0)
		}
		else {}
	}

	self.command_buffer = ':'
}

fn (mut self Adjust) render_command_bar() {
	self.window.draw_text(0, self.window.window_height, self.command_buffer)
}

fn (mut self Adjust) render_status_bar() {
	mut x := 0
	y := self.window.window_height - 1

	x = self.render_status_bar_mode_name(x, y)
	x = self.render_status_bar_file_name(x, y)

	self.render_status_bar_filling(x, y)
}

fn (mut self Adjust) render_status_bar_file_name(x int, y int) int {
	file := self.files_to_edit[self.current_file]

	self.window.set_bg_color(green)
	self.window.set_color(white)
	self.window.draw_text(x, y, ' ${file} ')
	self.window.reset()

	return x + file.len + 2
}

fn (mut self Adjust) render_status_bar_filling(x int, y int) {
	self.window.set_bg_color(green)
	self.window.draw_line(x, y, self.window.window_width, y)
	self.window.reset()
}

fn (mut self Adjust) render_status_bar_mode_name(x int, y int) int {
	mode := self.mode.string()

	self.window.set_bg_color(white)
	self.window.set_color(black)
	self.window.draw_text(x, y, ' ${mode} ')
	self.window.reset()

	return x + mode.len + 3
}

////////////////////////////////////////////////////////////////////////////////
