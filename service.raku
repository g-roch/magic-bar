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
use MagicBar;
use Config;

my $config = Config.new({
    port => 8888,
    host => "0.0.0.0",
    name => "MagicBar",
}, :name<magicbar>);

my MagicBar $bar .= new: |$config.get;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => $config<host>,
    port => $config<port>,
    application => routes($bar),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at http://$config<host>:$config<port>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
