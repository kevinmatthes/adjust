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

fn test_add_characters() {
	mut s := Status{}

	s.add('t')

	assert s.cb == 't'
	assert s.m == .view

	s.add('e')

	assert s.cb == 'te'
	assert s.m == .view

	s.add('s')

	assert s.cb == 'tes'
	assert s.m == .view

	s.add('t')

	assert s.cb == 'test'
	assert s.m == .view
}

fn test_add_string() {
	mut s := Status{}

	s.add('test')

	assert s.cb == 'test'
	assert s.m == .view
}

fn test_backspace_empty() {
	mut s := Status{}

	s.backspace()

	assert s.cb == ''
	assert s.m == .view
}

fn test_backspace_one_character() {
	mut s := Status{}

	s.add(':')
	s.backspace()

	assert s.cb == ':'
	assert s.m == .view
}

fn test_backspace_text() {
	mut s := Status{}

	s.add(':test')
	s.backspace()

	assert s.cb == ':tes'
	assert s.m == .view
}

fn test_command() {
	mut s := Status{}

	s.command()

	assert s.cb == ''
	assert s.m == .command
}

fn test_default_configuration() {
	s := Status{}

	assert s.cb == ''
	assert s.m == .view
}

fn test_insert() {
	mut s := Status{}

	s.insert()

	assert s.cb == ''
	assert s.m == .insert
}

fn test_reset_command_mode_empty() {
	mut s := Status{}

	s.command()
	s.reset()

	assert s.cb == ':'
	assert s.m == .command
}

fn test_reset_command_mode_with_text() {
	mut s := Status{}

	s.command()
	s.add(':test')
	s.reset()

	assert s.cb == ':'
	assert s.m == .command
}

fn test_reset_default() {
	mut s := Status{}

	s.reset()

	assert s.cb == ''
	assert s.m == .view
}

fn test_reset_not_command_mode_with_text() {
	mut s := Status{}

	s.add(':test')
	s.reset()

	assert s.cb == ''
	assert s.m == .view
}

fn test_view() {
	mut s := Status{}

	s.command()
	s.view()

	assert s.cb == ''
	assert s.m == .view
}

////////////////////////////////////////////////////////////////////////////////
