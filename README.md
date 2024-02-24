[![Actions Status](https://github.com/tbrowder/Holidays-Miscellaneous/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Holidays-Miscellaneous/actions) [![Actions Status](https://github.com/tbrowder/Holidays-Miscellaneous/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Holidays-Miscellaneous/actions) [![Actions Status](https://github.com/tbrowder/Holidays-Miscellaneous/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Holidays-Miscellaneous/actions)

NAME
====

**Holidays::Miscellaneous** - Provides perpetual data for miscellaneous holidays

SYNOPSIS
========

```raku
use Holidays::Miscellaneous;
use UUID::V4;

my $year = 2025;
my $set-id = uuid-v4; # A unique ID for the set of holidays so they can be
                      # merged with other C<Date::Event> sets for calendar
                      # generation;
my %mh = get-misc-holidays :$year, :$set-id;
# Keys of the '%us' hash are the C<$year>'s dates with holidays
my @d = %mh.keys.sort({$^a cmp $^b}); # Get array in date order
for @d -> $D {
    my Date $date .= new: $D; # Get the Date
    my %h = %mh{$date};
    # The value of %h is another hash keyed by: ($set-id ~ '|' ~ $id)
    # but we only break that key down for testing.
    #    %h{$h.date}{$key} = $holiday;
    my $holiday;
    for %h.keys -> $key {
        $holiday = %h{$key}; # The C<MiscHoliday> class object (a C<Date::Event>)
        # use the data for a calendar day cell
        my $d  = $holiday.date;
        my $n  = $holiday.name;
        my $ns = $holiday.short-name;
    }
}
```

For simpler use, we can get a hash also keyed by Date, but whose values are lists of holiday events:

    my %mh = get-misc-holidays-hashlist :$year;
    for %mh.keys.sort -> $date {
        for @(%ms{$date}) -> $holiday {
            my $n = $holiday.name;
        }
    }

DESCRIPTION
===========

**Holidays::Miscellaneous** is a collection of holiday data the author uses for *perpetual* calendar creation. (The term *perpetual* is used to mean the source code to generate the calendar's holiday dates is valid for any given year since the code uses the documented rules for determining those dates and no additional data need be inserted in the code annually.)

Note the names and dates of the holidays are those customarily used in the U.S., but several of those holidays are commonly celebrated in other countries around the world.

Current holiday list
--------------------

  * Groundhog Day - February 2

  * Valentine's Day - February 14

  * St. Patrick's Day - March 17

  * *Mother's Day - second Sunday in May

  * *Armed Forces Day - third Saturday in May

  * Flag Day - June 14

  * *Father's Day - third Sunday in June

  * *National Grandparents' Day - (Sept) first Sunday after US Labor Day

  * Halloween - October 31

  * *Election Day - Tuesday after the first Monday of November in even years (US)

  * Pearl Harbor Day - December 7

  * Christmas Eve - December 24

  * New Year's Eve - December 31

Holidays marked with a leading '*' are classified as 'calculated' holidays since their observed dates vary from year to year. This module uses module **Date::Utils** for that calculation.

The holidays without the leading asterisk are classified as 'directed' or 'fixed' since they are always on fixed dates.

SEE ALSO
========

Related Raku modules by the author:

  * **Date::Christian::Advent**

  * **Date::Easter**

  * **Holidays::US::Federal**

  * **Date::Event**

  * **Date::Utils**

  * **Calendar**

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

