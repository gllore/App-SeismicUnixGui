use Moose;

use test2;

my $test2 = test2->new();

my $return = $test2->get("here");

print $return;
