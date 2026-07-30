package App::SeismicUnixGui::messages::iVelocityAnalysis_messages;

use Moose;
our $VERSION = '0.0.1';

use aliased 'App::SeismicUnixGui::configs::big_streams::Project_config';

=head2 Instantiate classes:

 Option to create a new version of the package 
 with a unique name

=cut

my $Project            = Project_config->new();

=head2

 Import directory definitions

=cut

my ($DATA_SEISMIC_TXT)= $Project->DATA_SEISMIC_TXT();

sub get {
    my ( $self) = @_;
    my @message;

    $message[0] = (
" Old velocity picks already exist. Delete or save old picks.\n"
." To delete:"
."\n  \"cd $DATA_SEISMIC_TXT\"\n"
."  \" rm -rf ivpicks\* \"\ \n"
." and then restart.\n");

    $message[1] = ("Warning:   (iVelocityAnalysis_messages=1)\n");

    return ( \@message );
}

1;

