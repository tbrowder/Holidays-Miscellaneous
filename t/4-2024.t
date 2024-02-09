use Test;
use Holidays::Miscellaneous;
use Holidays::Data;
use UUID::V4;

my ($o, $name, $is-calculated, $id, $year, $set-id);
$year = 2024;
$set-id = uuid-v4;

is is-uuid-v4($set-id), True;

my %h = get-misc-holidays :$year, :$set-id;

# keys are the combination of "$set-id|traditional date"
my @d = %h.keys.sort({$^a cmp $^b});
my $i = 0;
for @d -> $D {
    my Date $date .= new: $D;
    my %hh = %h{$date};
    # value of %hh is another hash keyed by "$set-id|$id
    #    %h{$h.date}{$key} = $h;
    # for this test there should only be one entry
    my $h;
    my $uid;
    for %hh.keys -> $key {
        ++$i;
        $h   = %hh{$key};
        my $d  = $h.date;
        my $n  = $h.name;
        say "$i name: $n $d";
        with $name {
            when /:i     / {
                is $date, $d;
            }
            default {
                die "FATAL: Unexpected 'when' \$_: '$_'";
            }
        }
    }
}

done-testing;
