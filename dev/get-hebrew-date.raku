#!/usr/bin/env raku

use Date::Calendar::Hebrew;

if not @*ARGS.elems {
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} go

    Exercises module 'Date::Calendar::Hebrew'.
    HERE
    exit;
}

for 2023..2029 -> $year {
my Date $us .= new: $year, 11, 1;
while $us.year == $year {
    my Date::Calendar::Hebrew $he .= new-from-date: $us;
    if $he.day == 24 and $he.month-name eq 'Kislev' {
        say "US date:  {$us.year}-{$us.month}-{$us.day}";
        say "  He date:  {$he.year}-{$he.month}-{$he.day}";
        say "  He names: {$he.day} {$he.month-name} {$he.year}";
        say "  First day of Hanukkah";
        last;
    }
    $us += 1;
}
}

sub get-hanukkah-start(:$year!, :$debug --> Date) is export {
    # Hanukkah in the Hebrew calendar is: 25 Kislev
    #   Kislev is month 9
    # scheme is to do the following:
    #   start with the first day of December
    #   get the Hebrew y/m/d equivalent of that Date
    #   while hebrew date not first day of hanukkah {
    #       get next Date
    #   }
    my Date $us .= new: $year, 1, 1;
    my Date::Calendar::Hebrew $he .= new-from-date: $us;
}


