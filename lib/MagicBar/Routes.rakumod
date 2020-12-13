=begin pod

=NAME    MagicBar/Routes.rakumod
=VERSION 0.0.1
=AUTHOR  Gabriel Roch <gabriel@g-roch.ch>

=begin LICENSE
Copyright © 2020 Gabriel Roch

This file is part of MagicBar.

MagicBar is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MagicBar is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with Foobar.  If not, see <https://www.gnu.org/licenses/>.
=end LICENSE

=end pod

use Cro::HTTP::Router;

sub routes() is export {
    route {
        get -> {
            content 'text/html', "<h1> MagicBar </h1>";
        }
    }
}