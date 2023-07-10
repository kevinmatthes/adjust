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

import math { log10 }
import term { Coord }
import term.ui { Context }

struct Viewport {
mut:
	fst int
	lnf int
	pos Coord
	win &Context = unsafe { nil }
}

fn (mut v Viewport) align() {
	v.pos.x = v.lnf + 6
}

fn (mut v Viewport) refill(n int) {
	v.lnf = int(log10(n))
}

fn (mut v Viewport) reset(n int) {
	a.v.fst = 0
	a.v.refill(n)
	a.v.align()
	a.v.pos.y = 1
}

////////////////////////////////////////////////////////////////////////////////
