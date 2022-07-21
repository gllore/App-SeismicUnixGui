package App::SeismicUnixGui::misc::new_pkg;
use Moose;

=head2 Default perl lines for instantiation
       of imported packages 

=cut

my @use;

$use[0] = "\n\t" . 'use message;' . "\n\t" . 'use flow;' . "\n";

sub section {
    my ($self) = @_;

    # print("perl/new_pkg,@use\n");
    return ( \@use );
}

1;
