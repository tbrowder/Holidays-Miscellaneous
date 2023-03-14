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

    # all we need is the Hebrew year for the Gregorian
    # year at the beginning of November
    my Date $us .= new: $year, 11, 1;
    my Date::Calendar::Hebrew $he .= new-from-date: $us;

    # Hanukkah is $he.year-09-25
    # BUT we want the Gregorian day so we ask for
    #   the day before
    my $he-day = 24; # <= day before
    my $he-year = $he.year;
    $he .= new: :year($he-year), :month(9), :day($he-day);
    $us  = $he.to-date;

    say "US date:  {$us.year}-{$us.month}-{$us.day}";
    say "  He date:  {$he.year}-{$he.month}-{$he.day}";
    say "  He names: {$he.day} {$he.month-name} {$he.year}";
    say "  First day of Hanukkah";
}

sub get-hanukkah-start(:$year!, :$debug --> Date) is export {
    # Hanukkah in the Hebrew calendar is: 25 Kislev
    #   Kislev is month 9
    my Date $us .= new: $year, 11, 1;
    my Date::Calendar::Hebrew $he .= new-from-date: $us;
}


