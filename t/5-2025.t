use Test;
use Holidays::Miscellaneous;
use UUID::V4;

my $year = 2025;

my $set-id = uuid-v4;
my %h = get-misc-holidays :$year, :$set-id;

# keys are the combination of "$set-id|traditional date"
my @d = %h.keys.sort({$^a cmp $^b});
for @d -> $D {
    my Date $date .= new: $D;
    my %hh = %h{$date};
    # value of %hh is another hash keyed by "$set-id|$id
    #    %h{$h.date}{$key} = $h;
    my ($d, $h);
    for %hh.keys -> $key {
        $h  = %hh{$key};
        $d  = $h.date;
        with $h.name {

            # fixed dates
            when /:i ground  / {
                is $date, $d;
                is $d.month, 2; # always
                is $d.day, 2;   # always
            }
            when /:i valent  / {
                is $date, $d;
                is $d.month, 2; # always
                is $d.day, 14;  # always
            }
            when /:i patric  / {
                is $date, $d;
                is $d.month, 3; # always
                is $d.day, 17;  # always
            }
            when /:i flag    / {
                is $date, $d;
                is $d.month, 6; # always
                is $d.day, 14;  # always
            }
            when /:i hallo   / {
                is $date, $d;
                is $d.month, 10; # always
                is $d.day, 31;   # always
            }
            when /:i pearl   / {
                is $date, $d;
                is $d.month, 12; # always
                is $d.day, 7;    # always
            }

            # calculated dates
            when /:i mother  / {
                is $date, $d;
                is $d.month, 5; # always
                is $d.day,  11; # calculated
            }
            when /:i armed   / {
                is $date, $d;
                is $d.month, 5; # always
                is $d.day, 17;  # calculated
            }
            when /:i father  / {
                is $date, $d;
                is $d.month, 6; # always
                is $d.day, 15;  # calculated
            }
            when /:i grandp  / {
                is $date, $d;
                is $d.month, 9; # always
                is $d.day, 7;   # calculated
            }
            # not in odd years
            when /:i elect   / {
                is $date, $d;
                is $d.month, 11; # always
                is $d.day, 0;    # calculated
            }
            default {
                die "FATAL: Unexpected 'when' \$_: '$_'";
            }
        }
    }
}

done-testing;
