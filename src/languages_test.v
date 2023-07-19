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

import term.ui { Color }

fn mktst_lang(bg Color, fg Color, tab int, f string) {
	mut l := Language{}

	l.init(f)

	assert l.bg == bg
	assert l.fg == fg
	assert l.tab == tab
}

fn mktst_lang_extensions(bg Color, fg Color, tab int, extensions []string) {
	for e in extensions {
		mktst_lang(bg, fg, tab, './path/to/something.${e}')
	}
}

fn mktst_lang_names(bg Color, fg Color, tab int, names []string) {
	for n in names {
		mktst_lang(bg, fg, tab, './path/to/${n}')
	}
}

fn test_init_asy() {
	mktst_lang_extensions(linguist_asymptote, white, 4, ['asy'])
}

fn test_init_bib() {
	mktst_lang_extensions(linguist_bibtex, black, 4, ['bib'])
}

fn test_init_c() {
	mktst_lang_extensions(linguist_c, white, 4, ['c', 'h', 'i'])
}

fn test_init_cfg() {
	mktst_lang_extensions(linguist_configuration, black, 4, ['cfg', 'ini'])
}

fn test_init_cpp() {
	mktst_lang_extensions(linguist_c_plus_plus, black, 4, ['C', 'CPP', 'H', 'HPP', 'c++', 'cc',
		'cp', 'cpp', 'cxx', 'h++', 'hh', 'hp', 'hpp', 'hxx', 'ii', 'tcc'])
}

fn test_init_default() {
	mktst_lang_extensions(konsole_green, white, 4, [''])
	mktst_lang_names(konsole_green, white, 4, [''])
}

fn test_init_git() {
	mktst_lang_names(linguist_git, white, 4, ['.gitattributes', '.gitconfig', '.gitignore'])
}

fn test_init_json5() {
	mktst_lang_extensions(linguist_json5, white, 4, ['json5'])
}

fn test_init_just() {
	mktst_lang_names(linguist_just, white, 4, ['.justfile', 'justfile'])
}

fn test_init_md() {
	mktst_lang_extensions(linguist_markdown, white, 4, ['markdown', 'md', 'mdown', 'mdwn', 'mkd',
		'mkdn', 'mkdown'])
}

fn test_init_nim() {
	mktst_lang_extensions(linguist_nim, white, 2, ['nim', 'nimble', 'nimrod', 'nims'])
	mktst_lang_names(linguist_nim, white, 2, ['nim.cfg'])
}

fn test_init_pl() {
	mktst_lang_extensions(linguist_perl, white, 4, ['pl'])
}

fn test_init_rs() {
	mktst_lang_extensions(linguist_rust, black, 4, ['rs'])
}

fn test_init_sh() {
	mktst_lang_extensions(linguist_shell, black, 4, ['bash', 'sh'])
}

fn test_init_tex() {
	mktst_lang_extensions(linguist_tex, white, 4, ['tex'])
}

fn test_init_v() {
	mktst_lang_extensions(linguist_v, black, 8, ['v', 'vsh', 'vv'])
	mktst_lang_names(linguist_v, black, 8, ['v.mod'])
}

fn test_init_yml() {
	mktst_lang_extensions(linguist_yaml, white, 2, ['cff', 'yaml', 'yml'])
}

////////////////////////////////////////////////////////////////////////////////
