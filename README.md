<!---------------------- GNU General Public License 3.0 ------------------------
--                                                                            --
-- Copyright (C) 2023 Kevin Matthes                                           --
--                                                                            --
-- This program is free software: you can redistribute it and/or modify       --
-- it under the terms of the GNU General Public License as published by       --
-- the Free Software Foundation, either version 3 of the License, or          --
-- (at your option) any later version.                                        --
--                                                                            --
-- This program is distributed in the hope that it will be useful,            --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of             --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              --
-- GNU General Public License for more details.                               --
--                                                                            --
-- You should have received a copy of the GNU General Public License          --
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.     --
--                                                                            --
------------------------------------------------------------------------------->

<!------------------------------------------------------------------------------
--
--  AUTHOR      Kevin Matthes
--  BRIEF       Important information regarding this project.
--  COPYRIGHT   GPL-3.0
--  DATE        2023
--  FILE        README.md
--  NOTE        See `LICENSE' for full license.
--
------------------------------------------------------------------------------->

<!----------------------------------------------------------------------------->

[blog-flag]:  https://github.com/vlang/v/discussions/18051
[blog-tests]:  https://github.com/vlang/v/discussions/18144
[ci]:  https://github.com/kevinmatthes/adjust/workflows/ci/badge.svg
[geo]:  https://github.com/hungrybluedev/geo
[gpl3]:  https://github.com/kevinmatthes/adjust/blob/main/LICENSE
[last]:  https://img.shields.io/github/last-commit/kevinmatthes/adjust
[license]:  https://img.shields.io/github/license/kevinmatthes/adjust
[linguist]:  https://github.com/github-linguist/linguist
[moe]:  https://github.com/fox0430/moe
[renovate]:  https://img.shields.io/badge/renovate-enabled-brightgreen.svg
[repository]:  https://github.com/kevinmatthes/adjust

<!----------------------------------------------------------------------------->

# adjust

## Summary

[![][ci]][repository]
[![][last]][repository]
[![][license]][repository]
[![][renovate]][repository]

Yet another text editor for the terminal, written in V.

## License

This project's license is **GPL-3.0**.  The whole license text can be found
in [`LICENSE`][gpl3] in the repository root.  The brief version is as
follows:

> Copyright (C) 2023 Kevin Matthes
>
> This program is free software: you can redistribute it and/or modify
> it under the terms of the GNU General Public License as published by
> the Free Software Foundation, either version 3 of the License, or
> (at your option) any later version.
>
> This program is distributed in the hope that it will be useful,
> but WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> GNU General Public License for more details.
>
> You should have received a copy of the GNU General Public License
> along with this program.  If not, see <https://www.gnu.org/licenses/>.

## Acknowledgments

- [fox0430/moe][moe], especially its non-Vim commands, inspired the general
  design of `adjust`.
- [github-linguist/linguist][linguist] defines a mapping of coding languages to
  colours which is used to render the "Languages" statistics for each GitHub
  repository, making it a well-known convention also applied to the design of
  `adjust`'s status bar.
- [hungrybluedev/geo][geo] demonstrates both the [`flag` module][blog-flag] of
  the V standard library as well as the creation of [unittests][blog-tests] in
  V.

<!----------------------------------------------------------------------------->
