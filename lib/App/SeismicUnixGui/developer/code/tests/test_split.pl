use Moose;

my $SeismicUnixGui = ` echo \$SeismicUnixGui`;
chomp $SeismicUnixGui;

use File::Find;
use App::SeismicUnixGui::misc::L_SU_global_constants;
my $L_SU_global_constants = L_SU_global_constants->new();

my $search_directories_aref3 = $L_SU_global_constants->get_search_directories();

my @search_directories_aref2 = @{$search_directories_aref3};
my @directory_contents_gui   = @{ $search_directories_aref2[0] };
my @directory_contents_su    = @{ $search_directories_aref2[1] };
my @directory_contents_gen   = @{ $search_directories_aref2[2] };

find( \&_findfiles, @directory_contents_gui );

sub _findfiles {

	my ($self) = @_;

	use Shell qw(echo);

	my $pathNfile;
	my $file_name;

	my $SeismicUnixGui = ` echo \$SeismicUnixGui`;
	chomp $SeismicUnixGui;

	$pathNfile = $File::Find::name;
	my @string = split( /$SeismicUnixGui/, $pathNfile);

	#	print("string= $string[1]\n");
	my @string2 = split( '\/', $string[-1] );

	#	print("test_name=$string2[-1]\n");
	$file_name = $string2[-1];

	if ( $file_name eq 'susplit_spec.pm' ) {

		require $pathNfile;

	}
	else {
		#	print("file not found this time\n");
		# NADA
	}

}
