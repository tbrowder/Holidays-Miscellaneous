#!/usr/bin/env raku

use Date::Calendar::Hebrew;

if not @*ARGS.elems {
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} go

    Exercises module 'Date::Calendar::Hebrew'.
    HERE
    exit;
}

my $year = 2023; #..2030;
my Date $us .= new: $year, 11, 1;
while $us.year == $year {
    say "US date:  {$us.year}-{$us.month}-{$us.day}";
    my Date::Calendar::Hebrew $he .= new-from-date: $us;
    say "  He date:  {$he.year}-{$he.month}-{$he.day}";
    say "  He names: {$he.day} {$he.month-name} {$he.year}";
    if $he.day == 25 and $he.month-name eq 'Kislev' {
        say "  First day of Hanukkah";
        last;
    }
    $us += 1;
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


