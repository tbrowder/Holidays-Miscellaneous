#!/usr/bin/env raku

use Date::Calendar::Hebrew;

if not @*ARGS.elems {
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} go

    Exercises module 'Date::Calendar::Hebrew'.
    HERE
    exit;
}

my @us = 2023..2030;
for @us -> $year {
    my Date $us .= new: $year, 12, 1;
    my Date::Calendar::Hebrew $he .= new-from-date: $us;
    say "US date: {$us.year}-{$us.month}";
    say "He date: {$he.year}-{$he.month}-{$he.day}";
    for 1..31 -> $day {
        $us .= new: $year, 12, $day;
        say "  US day: {$us.day}";
        $he .= new-from-date($us);
        say "    He date";
        say "      day {.day-name} {.day} {.month-name} {.month} {.year}" with $he;
    }
}

sub get-hanukkah-start(:$year!, :$debug --> Date) is export {
    # scheme is to do the following:
    #   start with the first day of December
    #   get the Hebrew y/m/d equivalent of that Date
    #   while hebrew date not first day of hanukkah {
    #       get next Date
    #   }
    my Date $us .= new: $year, 1, 1;
    my Date::Calendar::Hebrew $he .= new-from-date: $us;
}


