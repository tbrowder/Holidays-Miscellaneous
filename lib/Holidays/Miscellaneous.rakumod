unit module Holidays::Miscellaneous;

use Holidays::Data;

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

use Date::Utils;

class Holiday is export {
    has Str  $.name          is required; #  => "Mother's Day",
    has Bool $.is-calculated;             #  => True,
    has Str  $.id            is required; #  => 'moth',
    has Date $.date;
    has Str  $.short-name = "";
    # data for nth day of month
    has UInt $.nth-value = 0;              #         => 2,
    has UInt $.nth-dow     = 0;            # day-of-week number (1..7 Monday..Sunday)
    has UInt $.nth-month-number = 0;       # 1..12 Jan..Dec

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
}

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

sub get-holidays(:$year!, :$debug --> Hash) is export {
    my %h;
    for %holidays.keys -> $id {
        my Holiday $h = calc-holiday-dates :$year, :$id, :$debug;
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

sub calc-holiday-dates(:$year!, :$id!, :$debug --> Holiday) is export {
    # Holidays defined in the %holidays hash with attribute
    # date => "0000-nn-nn" have traditional, designated dates.
    #
    # Holidays with attribute date => "" (empty) are subject to the
    # calculated rule and their actual and observed dates
    # are the same.

    my $name           = %holidays{$id}<name>;
    my $date           = %holidays{$id}<date>;
    my $short-name     = %holidays{$id}<short-name>;
    my $check-id       = %holidays{$id}<id>;
    # for calculated dates
    my $nth-value      = %holidays{$id}<nth-value>;
    my $nth-dow        = %holidays{$id}<nth-dow>;
    my $nth-month      = %holidays{$id}<nth-month>;

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
    Holiday.new: :$date, :$id, :$name, :$short-name;
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
