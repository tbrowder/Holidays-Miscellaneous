use Test;
use Holidays::Miscellaneous;
use Holidays::Data;

my ($o, $name, $is-calculated, $id, $year);
$year = 2024;

for %misc-holidays.keys -> $k {
    my %h = %(%misc-holidays{$k});
    $name = %h<name>;
    $is-calculated = %h<is-calculated> // False;
    $id = %h<id>;
    my $h = MiscHoliday.new: :$name, :$is-calculated, :$id;
    isa-ok $h, MiscHoliday;
}

my %h = get-misc-holidays :$year;

done-testing;

=begin comment
sub get-holidays(:$year!, :$debug --> Hash) is export {

sub calc-holiday-dates(:$year!, :$id!, :$debug --> Holiday) is export {

sub calc-date(:$name!, :$year!, :$debug --> Date) is export {
=end comment

