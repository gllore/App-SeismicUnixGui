package App::SeismicUnixGui::misc::use_pkg;
use Moose;

=use2 Default perl lines for start of instantiation
       of imported packages 

=cut

my @use;
$use[0] = "\t" . 'use Moose;' . "\n";
$use[1] = "\t"
	. 'use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);'
	. "\n";
$use[2] = "\t" . 'use App::SeismicUnixGui::configs::big_streams::Project_config;' . "\n\n";
$use[3] = "\t" . 'my $Project'. "\t\t" . '= new Project_config();' . "\n";
$use[4] =
	"\t" . 'my $DATA_SEISMIC_SU' . "\t" . '= $Project->DATA_SEISMIC_SU;' . "\n";
$use[5] = "\t"
	. 'my $DATA_SEISMIC_BIN' . "\t"
	. '= $Project->DATA_SEISMIC_BIN;' . "\n\n";
$use[6] = "\t" . 'use App::SeismicUnixGui::misc::message;' . "\n" . "\t" . 'use App::SeismicUnixGui::misc::flow;' . "\n";

sub section {
	return ( \@use );
}

1;
