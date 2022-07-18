package perl_instantiate;
use Moose;

=head2 Default perl lines for instantiation
       of imported packages 

=cut

my @instantiate;

$instantiate[0] = ' 
 my $log 				= new message();
 my $run    			= new flow();
';

sub section {
    return ( \@instantiate );
}

1;
