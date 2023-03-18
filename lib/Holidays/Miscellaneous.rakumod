unit module Holidays::Miscellaneous;

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
use Date::Event;

class Holiday is Date::Event {};

# holidays are divided into two categories:
#   traditional (same every year)
#   calculated by some formula

# Valentines Day
# Flag Day
# St Patricks Day
# Mothers Day
# Fathers Day
# Perl Harbor Day
# Armed Forces Day


our %holidays is export = [
    # traditional (fixed) dates
    # Groundhog Day - February 2
    ground => {
        name => "Groundhog Day",
        date => "0000-02-02",
        date-observed => "",
        short-name => "",
        id => 'ground',
    },
    # Valentine's Day - February 14
    val => {
        name => "Valentine's Day",
        date => "0000-02-14",
        date-observed => "",
        short-name => "",
        id => 'val',
    },

    # St. Patrick's Day - March 17
    pat => {
        name => "St. Patrick's Day",
        date => "0000-03-17",
        date-observed => "",
        short-name => "",
        id => 'pat',
    },
    # Flag Day - June 14
    flag => {
        name => "Flag Day",
        date => "0000-06-14",
        date-observed => "",
        short-name => "",
        id => 'flag',
    },
    # Halloween - October 31
    # Pearl Harbor Day - December 7
    pearl => {
        name => "Pearl Harbor Day",
        date => "0000-12-07",
        date-observed => "",
        short-name => "",
        id => 'pearl',
    },

    #===================================================
    # calculated (actual and observed date are the same)
    #===================================================
    # Mother's Day - second Sunday in May
    moth => {
        name => "Mother's Day",
        date => "",
        date-observed => "",
        short-name => "",
        id => 'moth',
    },
    # Armed Forces Day - third Saturday in May
    arm => {
        name => "Armed Forces Day",
        date => "",
        date-observed => "",
        short-name => "",
        id => "arm",
    },
    # Father's Day - third Sunday in June
    fath => {
        name => "Father's Day",
        date => "",
        date-observed => "",
        short-name => "",
        id => "fath",
    },
];

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
    # directed or calculated rule and their actual and observed dates
    # are the same.

    my $name          = %holidays{$id}<name>;
    my $date          = %holidays{$id}<date>;
    my $date-observed = %holidays{$id}<date-observed>;
    my $short-name    = %holidays{$id}<short-name>;
    my $check-id      = %holidays{$id}<id>;

    # directed date
    if $date ~~ /^ '0000-' (\S\S) '-' (\S\S) / {
        my $month = ~$0;
        my $day   = ~$1;
        # the actual date
        $date = Date.new("$year-$month-$day");
        $date-observed = $date;
    }
    else {
        # calculated date:
        # date and observed are the same and must be calculated
        $date = calc-date :$name, :$year, :$debug;
        $date-observed = $date;
    }
    Holiday.new: :$date, :$date-observed, :$id, :$name, :$short-name;
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

