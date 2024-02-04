use Test;
use Holidays::Miscellaneous;
use Holidays::Data;
use UUID::V4;

my ($o, $name, $is-calculated, $id, $year, $set-id);
$year = 2024;
$set-id = uuid-v4;

is is-uuid-v4($set-id), True;

for %misc-holidays.keys -> $k {
    my %h = %(%misc-holidays{$k});
    $name = %h<name>;
    $is-calculated = %h<is-calculated> // False;
    $id = %h<id>;
    my $h = MiscHoliday.new: :$name, :$is-calculated, :$id;
    isa-ok $h, MiscHoliday, "is a  MiscHoliday class instance";
}

my %h = get-misc-holidays :$year, :$set-id;
isa-ok %h, Hash, "is hash of Date";
isa-ok %h.keys.head, Str, "keys are Date strings";

done-testing;

