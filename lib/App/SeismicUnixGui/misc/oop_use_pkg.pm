package App::SeismicUnixGui::misc::oop_use_pkg;
use Moose;

=use2 Default perl lines for start of instantiation
       of imported packages 

=cut

my @use;
$use[0] = "\t" . 'use Moose;' . "\n";
$use[1] = "\t" . 'use App::SeismicUnixGui::misc::SeismicUnix qw($in $out $on $go $to $suffix_ascii $off $suffix_segd $suffix_segy $suffix_sgy $suffix_su $suffix_segd $suffix_txt $suffix_bin);' . "\n";
$use[2] = "\t" . 'use aliased \'App::SeismicUnixGui::configs::big_streams::Project_config\';' . "\n\n";
$use[3] = "\t" . 'my $Project' . "\t\t" . '= Project_config->new();' . "\n";
$use[4] = "\t" . 'my $DATA_SEISMIC_BIN' . "\t". '= $Project->DATA_SEISMIC_BIN;' . "\n";
$use[5] = "\t" . 'my $DATA_SEISMIC_SEGD' . "\t" . '= $Project->DATA_SEISMIC_SEGD;' . "\n";
$use[6] = "\t" . 'my $DATA_SEISMIC_SEGY' . "\t" . '= $Project->DATA_SEISMIC_SEGY;' . "\n";
$use[7] = "\t" . 'my $DATA_SEISMIC_SU' . "\t" . '= $Project->DATA_SEISMIC_SU;' . "\n";
$use[8] = "\t" . 'my $DATA_SEISMIC_TXT' . "\t" . '= $Project->DATA_SEISMIC_TXT;' . "\n\n";
$use[9] = "\t" . 'use aliased \'App::SeismicUnixGui::misc::message\';'."\n";
$use[10] = "\t" . 'use aliased \'App::SeismicUnixGui::misc::flow\';' . "\n";


sub section {
	my ($self) = @_;
	
	return ( \@use );
}

1;
