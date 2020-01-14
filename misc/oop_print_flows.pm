package oop_print_flows;
use Moose;

=head2 Default 

	print flow lines  

=cut

my @print_flows;

$print_flows[0] =

  "\t" . 'print $flow[1];' . "\n";

sub section {
    my ($self) = @_;
    return ( \@print_flows );
}

1;
