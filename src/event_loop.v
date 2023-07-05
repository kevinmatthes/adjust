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
					.escape {
						adjust.mode = .view
					}
					else {}
				}
			}
			.view {
				match event.code {
					.colon {
						adjust.mode = .command
						adjust.command_buffer += ':'
					}
					.greater_than {
						adjust.go_to_next_file()
					}
					.i {
						adjust.mode = .insert
					}
					.less_than {
						adjust.go_to_previous_file()
					}
					else {}
				}
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////
