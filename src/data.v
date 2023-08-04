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

struct Data {
mut:
	cur int
	fte []string
	pos Coord = Coord{0, 1}
	txt []TextLine
}

fn (d &Data) file() ?&string {
	return if d.cur < d.fte.len { &d.fte[d.cur] } else { none }
}

fn (d Data) has_reached_bottom() ?bool {
	return d.line_idx()? == d.line_cnt() - 1
}

fn (d Data) has_reached_top() ?bool {
	return d.line_idx()? == 0
}

fn (d &Data) line() ?&TextLine {
	i := d.line_idx()

	return if i == none || i? >= d.txt.len {
		none
	} else {
		&d.txt[i?]
	}
}

fn (d &Data) line_cnt() int {
	return d.txt.len
}

fn (d &Data) line_len() ?int {
	return d.line()?.len()
}

fn (d &Data) line_idx() ?int {
	r := d.pos.y - 1

	return if r < 0 { none } else { r }
}

////////////////////////////////////////////////////////////////////////////////
