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

struct TextLine {
mut:
	t string
}

fn (mut t TextLine) add(tl &TextLine) {
	t.t += tl.t
}

fn (mut t TextLine) del(i int) bool {
	mut r := t.t.runes()

	return if i < 0 || i >= r.len {
		false
	} else {
		r.delete(i)
		t.t = r.string()
		true
	}
}

fn (mut t TextLine) ins(i int, s string) bool {
	mut r := t.t.runes()

	return if i < 0 || i > r.len {
		false
	} else {
		r.insert(i, s.runes())
		t.t = r.string()
		true
	}
}

fn (t &TextLine) len() int {
	return t.t.len_utf8()
}

fn (mut t TextLine) sep(i int) ?TextLine {
	mut r := t.t.runes()

	return if i < 0 || i > r.len {
		none
	} else if i == r.len {
		TextLine{}
	} else {
		t.t = t.t.limit(i)
		TextLine{r[i..].string()}
	}
}

////////////////////////////////////////////////////////////////////////////////
