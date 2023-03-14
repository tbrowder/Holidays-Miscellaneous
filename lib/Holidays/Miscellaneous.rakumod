unit module Holidays::Miscellaneous;

# Valentines Day
# Flag Day
# St Patricks Day
# Mothers Day
# Fathers Day
# Perl Harbor Day
# Armed Forces Day

# ===== LATER:
# Hanukkah (see Hebrew calendar)
# National Grandparents' Day - first Sunday after Labor Day (US)
# Election Day - Tuesday after the first Monday of November in even years (US)
#   source: Wikipedia
# Groundhog Day - February 2
# Halloween - October 31
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
    # Valentine's Day - February 14
    val => {
        name => "Valentine's Day",
        date => "0000-01-01",
        date-observed => "",
        short-name => "",
        id => 'val',
    },

    # St. Patrick's Day - March 17
    pat => {
        name => "St. Patrick's Day",
        date => "0000-01-01",
        date-observed => "",
        short-name => "",
        id => 'pat',
    },
    # Flag Day - June 14
    flag => {
        name => "Flag Day",
        date => "0000-01-01",
        date-observed => "",
        short-name => "",
        id => 'flag',
    },
    # Pearl Harbor Day - December 7
    pearl => {
        name => "Pearl Harbor Day",
        date => "0000-01-01",
        date-observed => "",
        short-name => "",
        id => 'pearl',
    },


    # calculated actual (and observed date is the same)
    # Mother's Day - second Sunday in May
    moth => {
        name => "",
        date => "0000-01-01",
        date-observed => "",
        short-name => "",
        id => 'moth',
    },
    # Armed Forces Day - third Saturday in May
    ? => {
        name => "",
        date => "0000-01-01",
        date-observed => "",
        short-name => "",
        id => 1,
    },
    # Father's Day - third Sunday in June
    ? => {
        name => "",
        date => "0000-01-01",
        date-observed => "",
        short-name => "",
        id => 1,
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

sub calc-holiday-dates(:$year!, :$id!, :$debug --> FedHoliday) is export {
    # FedHolidays defined in the %fedholidays hash with attribute date => "0000-nn-nn" are subject to the weekend
    # rule and have two dates: actual and observed (which are the same
    # if the actual date is NOT on a weekend).
    #
    # FedHolidays with attribute date => "" (empty) are subject to the
    # directed or calculated rule and their actual and observed dates
    # are the same.

    my $name          = %fedholidays{$id}<name>;
    my $date          = %fedholidays{$id}<date>;
    my $date-observed = %fedholidays{$id}<date-observed>;
    my $short-name    = %fedholidays{$id}<short-name>;
    my $check-id      = %fedholidays{$id}<id>;

    # directed date
    if $date ~~ /^ '0000-' (\S\S) '-' (\S\S) / {
        my $month = ~$0;
        my $day   = ~$1;
        # the actual date
        $date = Date.new("$year-$month-$day");
        # check if it's on a weekend
        my $dow = $date.day-of-week; # 1..7 Mon..Sun
        if $dow == 6 {
            # use previous day (Friday)
            $date-observed = $date.pred;
        }
        elsif $dow == 7 {
            # use next day (Monday)
            $date-observed = $date.succ;
        }
        else {
            $date-observed = $date;
        }
    }
    else {
        # calculated date:
        # date and observed are the same and must be calculated
        $date = calc-date :$name, :$year, :$debug;
        $date-observed = $date;
    }
    FedHoliday.new: :$date, :$date-observed, :$id, :$name, :$short-name;
}

sub calc-date(:$name!, :$year!, :$debug --> Date) is export {
    my Date $date;
    with $name {
        my ($month, $nth, $dow);
        when $_.contains("Martin") {
            # Birthday of Martin Luther King, Jr.
            # third Monday of January
            $month = 1;
            $dow   = 1;
            $nth   = 3;
            $date  = nth-day-of-week-in-month :$year, :$month,
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Washington") {
            # Washington's Birthday
            # third Monday of February
            $month = 2;
            $dow   = 1;
            $nth   = 3;
            $date  = nth-day-of-week-in-month :$year, :$month,
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Memorial") {
            # Memorial Day
            # last Monday in May
            $dow   = 1;
            $nth   = -1;
            $month = 5;
            $date  = nth-day-of-week-in-month :$year, :$month,
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Labor") {
            # Labor Day
            # first Monday in September
            $dow   = 1;
            $month = 9;
            $nth   = 1;
            $date  = nth-day-of-week-in-month :$year, :$month,
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Columbus") {
            # Columbus Day
            # second Monday in October
            $dow   = 1;
            $month = 10;
            $nth   = 2;
            $date  = nth-day-of-week-in-month :$year, :$month,
                     :day-of-week($dow), :$nth, :$debug;
        }
        when $_.contains("Thanksgiving") {
            # Thanksgiving Day
            # fourth Thursday in November
            $dow   = 4;
            $month = 11;
            $nth   = 4;
            $date  = nth-day-of-week-in-month :$year, :$month,
                     :day-of-week($dow), :$nth, :$debug;
        }
        default {
            die "FATAL: Unknown holiday '$name'";
        }
    }
    $date
}

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

