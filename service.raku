=begin pod

=NAME    service.rakue of MagicBar
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

use Cro::HTTP::Log::File;
use Cro::HTTP::Server;
use MagicBar::Routes;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => %*ENV<MAGICBAR_HOST> ||
        die("Missing MAGICBAR_HOST in environment"),
    port => %*ENV<MAGICBAR_PORT> ||
        die("Missing MAGICBAR_PORT in environment"),
    application => routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at http://%*ENV<MAGICBAR_HOST>:%*ENV<MAGICBAR_PORT>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
