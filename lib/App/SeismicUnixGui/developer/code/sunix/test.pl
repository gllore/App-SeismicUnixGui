use Moose;

use aliased 'App::SeismicUnixGui::misc::manage_files_by2';

my $inbound = 'data_tbd.pl';

my $manage_files_by2 = manage_files_by2->new();
$manage_files_by2->set_pathNfile($inbound);
my $slurp_ref = manage_files_by2->get_whole();

my @slurp           = @$slurp_ref;
my $length_of_slurp = scalar @slurp;

my $look = 'apple';

for ( my $line_idx = 0 ; $line_idx < $length_of_slurp ; $line_idx++ ) {

	my $text = $slurp[$line_idx];
	print $text. "\n";

	if ( $text =~ m/$look/ ) {
		print "yes\n";
	}
	else {
		print "no\n";
	}
}

