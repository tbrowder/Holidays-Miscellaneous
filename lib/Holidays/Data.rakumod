unit module Holidays::Data;

#
# holidays are divided into two categories:
#   traditional or fixed (same every year)
#   calculated by some formula

# Groundhog Day
# Valentines Day
# St Patricks Day
# Flag Day
# Halloween
# Perl Harbor Day

# Mothers Day
# Fathers Day
# Armed Forces Day
# National Grandparents' Day - first Sunday after Labor Day (US)
# Election Day - Tuesday after the first Monday of November in even years (US)
#   source: Wikipedia

our %misc-holidays is export = %(
    # traditional (fixed) dates
    # Groundhog Day - February 2
    ground => {
        name => "Groundhog Day",
        date => "0000-02-02",
        short-name => "G'hog Day",
        id => 'ground',
    },
    # Valentine's Day - February 14
    val => {
        name => "Valentine's Day",
        date => "0000-02-14",
        short-name => "Valentine",
        id => 'val',
    },

    # St. Patrick's Day - March 17
    pat => {
        name => "St. Patrick's Day",
        date => "0000-03-17",
        short-name => "St Patty's Day",
        id => 'pat',
    },
    # Flag Day - June 14
    flag => {
        name => "Flag Day",
        date => "0000-06-14",
        short-name => "",
        id => 'flag',
    },
    # Halloween - October 31
    hallo => {
        name => "Halloween",
        date => "0000-10-31",
        short-name => "",
        id => 'hallo',
    },

    # Pearl Harbor Day - December 7
    pearl => {
        name => "Pearl Harbor Day",
        date => "0000-12-07",
        short-name => "Pearl Harbor",
        id => 'pearl',
    },

    #===================================================
    # calculated
    #===================================================
    # Mother's Day - second Sunday in May
    moth => {
        name => "Mother's Day",
        is-calculated => True,
        short-name => "",
        id => 'moth',
        # data for nth day of month
        nth-value        => 2,
        nth-dow          => 7, # day-of-week number (1..7 Monday..Sunday)
        nth-month-number => 5, # 1..12 Jan..Dec
    },
    # Armed Forces Day - third Saturday in May
    arm => {
        name => "Armed Forces Day",
        is-calculated => True,
        short-name => "",
        id => "arm",
        # data for nth day of month
        nth-value        => 3,
        nth-dow          => 6, # day-of-week number (1..7 Monday..Sunday)
        nth-month-number => 5, # 1..12 Jan..Dec
    },
    # Father's Day - third Sunday in June
    fath => {
        name => "Father's Day",
        is-calculated => True,
        short-name => "",
        id => "fath",
        # data for nth day of month
        nth-value        => 3,
        nth-dow          => 7, # day-of-week number (1..7 Monday..Sunday)
        nth-month-number => 6, # 1..12 Jan..Dec
    },

    # National Grandparents' Day - first Sunday after Labor Day (US)
    grandp => {
        name => "National Grandparents' Day",
        is-calculated => True,
        short-name => "Grandparents Day",
        id => "grandp",
        # data for nth day of month
        nth-value        => 0,
        nth-dow          => 7, # day-of-week number (1..7 Monday..Sunday)
        nth-month-number => 9, # 1..12 Jan..Dec
    },
    # Election Day - Tuesday after the first Monday of November in even years (US)
    #   source: Wikipedia
    elect => {
        name => "Election Day",
        is-calculated => True,
        short-name => "",
        id => "elect",
        # data for nth day of month
        nth-value        => 0,
        nth-dow          => 0, # day-of-week number (1..7 Monday..Sunday)
        nth-month-number => 0, # 1..12 Jan..Dec
    },
);
