use Test;
use Holidays::Miscellaneous;
use Holidays::Data;
use UUID::V4;

my ($o, $name, $is-calculated, $id, $year, $set-id);
$year = 2024;
$set-id = uuid-v4;

is is-uuid-v4($set-id), True;

my %h = get-misc-holidays :$year, :$set-id;
isa-ok %h, Hash, "is hash of Date";
isa-ok %h.keys.head, Str, "keys are Date strings";

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
    is %hh.elems, 1, "only one element as expected";
    for %hh.keys -> $key {
        my @w = $key.split('|');
        my $sid = @w.head;
        is $sid, $set-id, "set-id checks";
        $uid = @w.tail;
        $h   = %hh{$key};
        last;
    }
    ++$i;
    my $d  = $h.date;
    my $do = $h.date-observed;
    my $n  = $h.name;
    my $ns = $h.short-name;
    my $id = $h.id;
    is $uid, $id, "individual id checks";

    is $h.etype, "Holiday", "type (EType) is 100 (holiday)";
}

done-testing;

=finish
for %us0.keys -> $date {
    for %us0{$date}.kv -> $uid, $v {
        %us1{$date}{$uid} = $v;
    }
}
