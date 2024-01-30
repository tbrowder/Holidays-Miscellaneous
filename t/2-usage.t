use Test;
use Holidays::Miscellaneous;

my ($o, $name, $is-calculated, $id);
for %holidays.keys -> $k {
    my %h = %(%holidays{$k});
    $name = %h<name>;
    $is-calculated = %h<is-calculated> // False;
    $id = %h<id>;
    my $h = Holiday.new: :$name, :$is-calculated, :$id;
}

done-testing;

=begin comment
sub get-holidays(:$year!, :$debug --> Hash) is export {

sub calc-holiday-dates(:$year!, :$id!, :$debug --> Holiday) is export {

sub calc-date(:$name!, :$year!, :$debug --> Date) is export {
=end comment

done-testing;
