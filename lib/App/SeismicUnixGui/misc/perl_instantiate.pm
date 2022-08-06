package App::SeismicUnixGui::misc::perl_instantiate;
use Moose;

=head2 Default perl lines for instantiation
       of imported packages 

=cut

my @instantiate;

$instantiate[0] = ' 
 my $log 				= message->new();
 my $run    			= flow->new();
';

sub section {
    return ( \@instantiate );
}

1;
