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

struct Status {
mut:
	cb string
	m  Mode = .view
}

fn (mut s Status) add(t string) {
	s.cb += t
}

fn (mut s Status) backspace() {
	mut runes := s.cb.runes()

	if runes.len > 1 {
		runes.delete_last()
		s.cb = runes.string()
	}
}

fn (mut s Status) command() {
	s.m = .command
}

fn (mut s Status) insert() {
	s.m = .insert
}

fn (mut s Status) reset() {
	if s.m == .command {
		s.cb = ':'
	} else {
		s.cb = ''
	}
}

fn (mut s Status) view() {
	s.m = .view
}

////////////////////////////////////////////////////////////////////////////////
