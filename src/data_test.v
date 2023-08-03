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

fn test_data_default_configuration() {
	d := Data{}

	assert d.cur == 0
	assert d.fte == []
	assert d.pos == Coord{0, 1}
	assert d.txt == []
}

fn test_data_file_none() {
	f := Data{}.file()

	assert f == none
}

fn test_data_file_some() {
	assert Data{
		fte: ['']
	}.file()? == ''
}

fn test_data_line_idx_default() {
	assert Data{}.line_idx()? == 0
}

fn test_data_line_idx_none() {
	d := Data{
		pos: Coord{0, 0}
	}
	i := d.line_idx()

	assert i == none
}

fn test_data_line_len_none_default() {
	n := Data{}.line_len()

	assert n == none
}

fn test_data_line_len_none_invalid_position() {
	n := Data{
		pos: Coord{0, 0}
	}.line_len()

	assert n == none
}

fn test_data_line_len_some_ascii() {
	assert Data{
		txt: ['?']
	}.line_len()? == 1
}

fn test_data_line_len_some_empty() {
	assert Data{
		txt: ['']
	}.line_len()? == 0
}

fn test_data_line_len_some_non_ascii() {
	assert Data{
		txt: ['§']
	}.line_len()? == 1
}

fn test_data_line_none_default() {
	l := Data{}.line()

	assert l == none
}

fn test_data_line_none_invalid_position() {
	l := Data{
		pos: Coord{0, 0}
		txt: ['']
	}.line()

	assert l == none
}

fn test_data_line_some() {
	assert Data{
		txt: ['']
	}.line()? == ''
}

////////////////////////////////////////////////////////////////////////////////
