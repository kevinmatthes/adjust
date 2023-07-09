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

fn event_loop(event &terminal.Event, mut adjust Adjust) {
	if event.typ == .key_down {
		match adjust.mode {
			.command {
				match event.code {
					.backspace {
						mut runes := adjust.command_buffer.runes()

						if runes.len > 1 {
							runes.delete_last()
							adjust.command_buffer = runes.string()
						}
					}
					.enter {
						adjust.execute_command()
					}
					.escape {
						adjust.mode = .view
						adjust.command_buffer = ''
					}
					else {
						adjust.command_buffer += event.utf8
					}
				}
			}
			.insert {
				match event.code {
					.backspace {
						adjust.remove_text(.backspace)
					}
					.delete {
						adjust.remove_text(.delete)
					}
					.down {
						adjust.move_cursor_down()
					}
					.end {
						adjust.move_cursor_end()
					}
					.enter {
						adjust.split_line()
						adjust.move_cursor_start()
						adjust.move_cursor_down()
						adjust.update_viewport_cursor()
					}
					.escape {
						adjust.mode = .view
					}
					.home {
						adjust.move_cursor_start()
					}
					.left {
						adjust.move_cursor_left()
					}
					.right {
						adjust.move_cursor_right()
					}
					.up {
						adjust.move_cursor_up()
					}
					else {
						adjust.insert_text(event.utf8)
					}
				}
			}
			.view {
				match event.code {
					.colon {
						adjust.mode = .command
						adjust.command_buffer += ':'
					}
					.down {
						adjust.move_cursor_down()
					}
					.end {
						adjust.move_cursor_end()
					}
					.greater_than {
						adjust.go_to_next_file()
					}
					.home {
						adjust.move_cursor_start()
					}
					.i {
						adjust.mode = .insert
					}
					.left {
						adjust.move_cursor_left()
					}
					.less_than {
						adjust.go_to_previous_file()
					}
					.right {
						adjust.move_cursor_right()
					}
					.up {
						adjust.move_cursor_up()
					}
					else {}
				}
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////
