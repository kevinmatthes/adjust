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
import os.cmdline as cmd
import term.ui as terminal

fn main() {
	if os.args.len > 1 {
		args := os.args[1..]
		options := cmd.only_options(args)
		files := cmd.only_non_options(args)

		if options.any(it == '--nightly') {
			os.execute('v install --git https://github.com/kevinmatthes/adjust')
		} else if options.any(it in ['-h', '--help']) || files.len == 0 {
			println(help_message)
		} else {
			mut adjust := &Adjust{
				files_to_edit: files
			}

			adjust.load_file()
			adjust.v.win = terminal.init(
				capture_events: true
				event_fn: event_loop
				frame_fn: render
				user_data: adjust
			)

			adjust.v.win.run()!
		}
	} else {
		println(help_message)
	}
}

////////////////////////////////////////////////////////////////////////////////
