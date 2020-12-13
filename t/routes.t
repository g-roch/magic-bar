=begin pod

=NAME    routes.t of MagicBar
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

use Cro::HTTP::Test;
use Test;
use MagicBar::Routes;
use MagicBar;
use Config;


my $config = Config.new({
    port => 8888,
    host => "0.0.0.0",
    name => "MagicBar",
}, :name<magicbar>);

my MagicBar $bar .= new: |$config.get;

test-service routes($bar), {
    test get('/'),
            status => 200,
            body-text => *.contains($bar.discovery-link);
}

done-testing;
