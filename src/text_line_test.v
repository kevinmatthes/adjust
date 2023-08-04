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

fn test_text_line_add_empty_empty() {
	mut tl := TextLine{}
	tl.add(&TextLine{})

	assert tl.t == ''
}

fn test_text_line_add_empty_not_empty() {
	mut tl := TextLine{}
	tl.add(&TextLine{'cd'})

	assert tl.t == 'cd'
}

fn test_text_line_add_not_empty_empty() {
	mut tl := TextLine{'ab'}
	tl.add(&TextLine{})

	assert tl.t == 'ab'
}

fn test_text_line_add_not_empty_not_empty() {
	mut tl := TextLine{'ab'}
	tl.add(&TextLine{'cd'})

	assert tl.t == 'abcd'
}

fn test_text_line_default_configuration() {
	assert TextLine{}.t == ''
}

fn test_text_line_del_empty_1() {
	mut tl := TextLine{}

	assert !tl.del(-1)
}

fn test_text_line_del_empty_2() {
	mut tl := TextLine{}

	assert !tl.del(0)
}

fn test_text_line_del_empty_3() {
	mut tl := TextLine{}

	assert !tl.del(1)
}

fn test_text_line_del_not_empty() {
	mut tl := TextLine{'123'}

	assert !tl.del(-1)
	assert tl.t == '123'
	assert tl.del(0)
	assert tl.t == '23'
	assert tl.del(1)
	assert tl.t == '2'
	assert !tl.del(2)
	assert tl.t == '2'
}

fn test_text_line_ins_empty() {
	mut tl := TextLine{}

	assert !tl.ins(-1, '')
	assert tl.t == ''
	assert tl.ins(0, '1')
	assert tl.t == '1'
	assert tl.ins(1, '2')
	assert tl.t == '12'
	assert tl.ins(0, '0')
	assert tl.t == '012'
	assert !tl.ins(42, '42')
	assert tl.t == '012'
	assert tl.ins(3, '345')
	assert tl.t == '012345'
	assert tl.ins(0, '')
	assert tl.t == '012345'
}

fn test_text_line_ins_not_empty() {
	mut tl := TextLine{'abc'}

	assert !tl.ins(-1, '')
	assert tl.t == 'abc'
	assert tl.ins(0, '1')
	assert tl.t == '1abc'
	assert tl.ins(1, '2')
	assert tl.t == '12abc'
	assert tl.ins(0, '0')
	assert tl.t == '012abc'
	assert !tl.ins(42, '42')
	assert tl.t == '012abc'
	assert tl.ins(3, '345')
	assert tl.t == '012345abc'
	assert tl.ins(0, '')
	assert tl.t == '012345abc'
}

fn test_text_line_len_ascii() {
	assert TextLine{'?'}.len() == 1
}

fn test_text_line_len_empty() {
	assert TextLine{}.len() == 0
}

fn test_text_line_len_non_ascii() {
	assert TextLine{'§'}.len() == 1
}

fn test_text_line_sep_empty_invalid_1() {
	mut tl := TextLine{}
	s := tl.sep(-1)

	assert s == none
}

fn test_text_line_sep_empty_invalid_2() {
	mut tl := TextLine{}
	s := tl.sep(1)

	assert s == none
}

fn test_text_line_sep_empty_valid() {
	mut tl := TextLine{}

	assert tl.sep(0)? == TextLine{}
	assert tl.t == ''
}

fn test_text_line_sep_not_empty_begin() {
	mut tl := TextLine{'abcd'}

	assert tl.sep(0)? == TextLine{'abcd'}
	assert tl.t == ''
}

fn test_text_line_sep_not_empty_end() {
	mut tl := TextLine{'abcd'}

	assert tl.sep(4)? == TextLine{}
	assert tl.t == 'abcd'
}

fn test_text_line_sep_not_empty_invalid_1() {
	mut tl := TextLine{'abcd'}
	s := tl.sep(-1)

	assert s == none
}

fn test_text_line_sep_not_empty_invalid_2() {
	mut tl := TextLine{'abcd'}
	s := tl.sep(5)

	assert s == none
}

fn test_text_line_sep_not_empty_mid() {
	mut tl := TextLine{'abcd'}

	assert tl.sep(2)? == TextLine{'cd'}
	assert tl.t == 'ab'
}

////////////////////////////////////////////////////////////////////////////////
