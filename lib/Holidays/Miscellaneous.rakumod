unit module Holidays::Miscellaneous;

use Holidays::Data;
use Date::Event;
use Date::Utils;

# Valentines Day
# Flag Day
# St Patricks Day
# Mothers Day
# Fathers Day
# Perl Harbor Day
# Armed Forces Day

# National Grandparents' Day - first Sunday after Labor Day (US)
# Election Day - Tuesday after the first Monday of November in even years (US)
#   source: Wikipedia
#
# ===== LATER:
# Hanukkah - [use Raku module Date::Calendar::Hebrew by @jforget ]
#    Jewish festival that begins at the 25th day of Kislev, lasts
#       eight days, and concludes on the second or third day of
#       Tevet (Kislev can have 29 or 30 days). Note the Jewish day
#       begins at sunset.
#   source: Wikipedia


class MiscHoliday is Date::Event is export {}

=begin comment
    submethod TWEAK {
        if not $!date.defined {
            $!is-calculated = True;
        }
        if $!is-calculated {
            $!nth-value        = %holidays{$!id}<nth-value>;
            $!nth-dow          = %holidays{$!id}<nth-dow>;
            $!nth-month-number = %holidays{$!id}<month-number>;
        }
    }
=end comment

# holidays are divided into two categories:
#   traditional or fixed (same every year)
#   calculated by some formula

# Valentines Day
# Flag Day
# St Patricks Day
# Mothers Day
# Fathers Day
# Perl Harbor Day
# Armed Forces Day

sub get-misc-holidays(:$year!, :$debug --> Hash) is export {
    my %h;
    for %misc-holidays.keys -> $id {
        my MiscHoliday $h = calc-misc-holiday-dates :$year, :$id, :$debug;
        %h{$h.date}          = $h;
    }
    %h
}

# Routines for calculating dates observed
# There are two types:
#   1. Those holidays designated as a certain day of the month.
#   2. Those holidays with assigned dates that may fall on
#      weekends. When the date for a year falls on a Saturday,
#      it is observed on the previous Friday. When the date falls
#      on a Sunday, it is observed on the following Monday.

sub calc-misc-holiday-dates(:$year!, :$id!, :$debug --> Holiday) is export {
    # Holidays defined in the %holidays hash with attribute
    # date => "0000-nn-nn" have traditional, designated dates.
    #
    # Holidays with attribute date => "" (empty) are subject to the
    # calculated rule and their actual and observed dates
    # are the same.

    my $name           = %misc-holidays{$id}<name>;
    my $date           = %misc-holidays{$id}<date>;
    my $short-name     = %misc-holidays{$id}<short-name>;
    my $check-id       = %misc-holidays{$id}<id>;
    # for calculated dates
    my $nth-value      = %misc-holidays{$id}<nth-value>;
    my $nth-dow        = %misc-holidays{$id}<nth-dow>;
    my $nth-month      = %misc-holidays{$id}<nth-month>;

    # fixed or directed date
    if $date ~~ /^ '0000-' (\d\d) '-' (\d\d) / {
        my $month = ~$0;
        my $day   = ~$1;
        # the actual date
        $date = Date.new("$year-$month-$day");
    }
    else {
        # calculated date:
        $date = calc-date :$name, :$year, :$debug;
    }
    MiscHoliday.new: :$date, :$id, :$name, :$short-name;
}

sub calc-date(:$name!, :$year!, :$debug --> Date) is export {
    my Date $date;
    with $name {
        my ($month, $nth, $dow);
        when $_.contains("") {
            $month = 0;
            $dow   = 0;
            $nth   = 0;
            $date  = nth-day-of-week-in-month :$year, :$month,
                     :day-of-week($dow), :$nth, :$debug;
        }
        default {
            die "FATAL: Unknown holiday '$name'";
        }
    }
    $date
}

=begin comment
sub get-hanukkah-start(:$year!, :$debug --> Date) is export {
    # scheme is to do the following:
    #   start with the first day of November
    #   get the Hebrew y/m/d equivalent of that Date
    #   while hebrew date not first day of hanukkah {
    #       get next Date
    #   }
    my Date $us .= new: $year, 11, 1;
    my Date::Calendar::Hebrew $he .= new-from-date: $us;
}
=end comment
