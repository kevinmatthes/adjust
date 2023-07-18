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

import flag { new_flag_parser }
import os { execute }
import term.ui { init }

fn main() {
	mut cli := new_flag_parser(os.args)
	cli.application(cli_name)
	cli.arguments_description('<file> [file ...]')
	cli.description(cli_desc)
	cli.version(cli_vrsn)
	cli.skip_executable()

	nightly := cli.bool('nightly', 0, false, 'self-update and exit')

	if nightly {
		execute(install)
		execute(compile)
	} else {
		files := cli.finalize()!

		if files.len == 0 {
			println(cli.usage())
		} else {
			mut adjust := &Adjust{
				files_to_edit: files
			}

			adjust.load_file()
			adjust.v.win = init(
				capture_events: true
				event_fn: event_loop
				frame_fn: render
				user_data: adjust
			)

			adjust.v.win.run()!
		}
	}
}

////////////////////////////////////////////////////////////////////////////////
