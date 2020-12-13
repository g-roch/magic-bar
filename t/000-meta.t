#
# Copyright 2020 Gabriel Roch
#
# This file is part of MagicBar.
#
# MagicBar is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# MagicBar is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Foobar.  If not, see <https://www.gnu.org/licenses/>.
#

use Test;
use Test::META;
use Concurrent::File::Find;

plan 2;

meta-ok;

subtest "Project don't use old Perl6 extensions", {
    plan 3;
    nok find("lib/", :extension("pm6")), "no .pm6 extension in lib/ directory";
    nok find(".", :extension("p6")), "no .p6 extension in the project directory";
    nok find(".", :extension("pod")), "no .pod extension in the project directory";
}

done-testing;
