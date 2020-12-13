=begin pod

=NAME    000-meta.t of MagicBar
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

use Test;
use Test::META;
use Concurrent::File::Find;
use Pod::Literate;

plan 3;

meta-ok;

subtest "Project don't use old Perl6 extensions", {
    plan 3;
    nok find("lib/", :extension("pm6")), "no .pm6 extension in lib/ directory";
    nok find(".", :extension("p6")), "no .p6 extension in the project directory";
    nok find(".", :extension("pod")), "no .pod extension in the project directory";
}

subtest "All file in project as =LICENSE section", {
    class Actions {
        method TOP($/) {
            make $<pod>».made
        }
        method pod($/) {
            my @data;
            my Bool $abbr = False;
            for $/.caps {
                my $d = $_.value.made;
                if $abbr {
                    @data.push: Pair.new: |$d.trim.split(" ", 2)».trim;
                } else {
                    @data.push: $d if $d.defined;
                }
                $abbr = $_.key eq "pod-abbreviated-block-line";
            }
            make ~$0 => @data;
        }
        method non-pod-line($/) {
            make $/.trim
        }
        method pod-paragraph-line($/) {
            make $/.trim
        }
    }


    for find(".", :extension({ .contains('raku') }, "t")) -> $file {
        my @data = Pod::Literate.parsefile($file, :actions(Actions)).made;
        my @keys = ();
        while @data {
            given @data.pop {
                for @$_ {
                    when Pair {
                        @keys.push: .key;
                        @data.push: .value;
                    }
                }
            }
        }
        ok "LICENSE" ∈ @keys, "$file has =LICENSE section";
    }
}

done-testing;
