package oop_log_flows;
use Moose;

=head2 Default  lines for   

 logging flows 

=cut

my @log_flows;

$log_flows[0] =

  "\t" . '$log->file($flow[1]);' . "\n\n";

sub section {
    my ($self) = @_;
    return ( \@log_flows );
}

1;
