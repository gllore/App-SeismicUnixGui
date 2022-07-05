package check;

=head1 DOCUMENTATION

=head2 SYNOPSIS 
program runs programs and checks
for conistency with expected pre-run
results

 PERL module NAME: check.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 1 2021

DESCRIPTION 
For testing perl scripts in:
demos and Servilleta_demos
 L_SU_global_constants
 BASED ON:

=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES

=cut 

use Moose;
our $VERSION = '0.0.1';
use LSeismicUnix::misc::L_SU_global_constants;

=head2 Instantiation

=cut

my $get = L_SU_global_constants->new();

=head2 Private variables

=cut

my $var           = $get->var();
my $test_dir_name = $var->{_test_dir_name};
my $empty_string  = $var->{_empty_string};
my $username      = $var->{_username};

=head2 private hash

=cut

my $check = {
	_filename_aref => '',
};

=head2 sub get_test_results
Where testing gets done

=cut

sub get_test_results {

	my ($self) = @_;

	use Test::Most tests => 7, 'die';
	use File::Compare;

=head2 Variable declaration
 $L_SU is a global variable for locating 
 the  main folder.
 
 REF_DATA_SEISMIC_SU is the reference 
 for comparison.
 
=cut

	my $L_SU = $ENV{'L_SU'};

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print "export LSeismicUnix=/usr/local/pl/LSeismicUnix ";

	} else {
		print("\n$L_SU = $L_SU \n");
	}

	my $PL_SEISMIC
		= $L_SU . '/'
		. $test_dir_name . '/'
		. $username
		. '/Servilleta_demos/seismics/pl/loma_blanca/053018/H/1/su/gom';

	my ( $PATH_n_file_name_aref, $file_name_aref, $instructions_aref ) = _get_instructions();
	my @instruction      = @$instructions_aref;
	my @file_name        = @$file_name_aref;
	my @PATH_n_file_name = @$PATH_n_file_name_aref;

	my $number_of_op_files = scalar @file_name;

	for ( my $i = 0; $i < $number_of_op_files; $i++ ) {

		if ( length( $file_name[$i] ) ) {

			# CASE 1-- file generated
			system(" $instruction[$i] ");
			my $compare  = compare( $file_name[0], $file_name[0] );
			my $response = $PATH_n_file_name[0] . ' equals ' . $file_name[0];

			if ( $? eq 0 ) {

				print "\nFile created \n";

			} else {
				print("WARNING: File not created \n");
			}

			ok $compare, $response;

		} elsif ( not( length( $file_name[$i] ) ) ) {

			# CASE 2 only graphics generated

			if ( length( $instruction[$i] ) ) {

				system(" $instruction[$i] ");

			}

			if ( $? eq 0 ) {

				print "\nSuccessful run \n";
				ok( $? == 0 );

			} else {
				print("Unsuccessful run \n");
			}

		} else {
			print("check, get_test_results, unexpected value\n");
		}

		#	is 2, 2, '... as should all passing tests';
		#	eq_or_diff [3], [4], '... but failing tests should die';
		#	ok 4, '... will never get to here';
	}

}    # end sub get_test_results

=head2 sub _get_instructions

=cut

sub _get_instructions {
	my ($self) = @_;

	my @instruction;
	my @file_name;

	my $L_SU = $ENV{'L_SU'};

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export LSeismicUnix=/usr/local/pl/LSeismicUnix ";

	} else {
		#		print("\$L_SU = $L_SU \n");
	}

	my $PATH = $L_SU . '/' . $test_dir_name;
	my $HOME = $PATH . '/' . $username;
	my @PATH_n_file_name;

	my $PL_SEISMIC          = $HOME . '/Servilleta_demos/seismics/pl/loma_blanca/053018/H/1/gom';
	my $REF_DATA_SEISMIC_SU = $L_SU . '/demo_projects/Servilleta_demos/seismics/data/loma_blanca/053018/H/1/su/gom';
	my $TEST_DATA_SEISMIC_SU
		= $L_SU . '/'
		. $test_dir_name . '/'
		. $username
		. '/Servilleta_demos/seismics/data/loma_blanca/053018/H/1/su/gom';

	$instruction[0]      = (" xhost +");
	$file_name[0]        = $empty_string;
	$PATH_n_file_name[0] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[0];

	$instruction[1]      = (" sudo --user=$username --login perl $PL_SEISMIC/suop2.pl ");
	$file_name[1]        = 'L28Hz_Ibeam_geom2.su';
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[1];

	$file_name[2]        = $empty_string;
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[2];
	$instruction[2]      = (" sudo --user=$username --login perl $PL_SEISMIC/plot_traclVsoffset.pl ");

	$file_name[3]        = $empty_string;
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[3];
	$instruction[3]      = (" sudo --user=$username --login xk");

	$file_name[4]        = $empty_string;
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[4];
    $instruction[4] = (" sudo --user=$username --login perl $PL_SEISMIC/Suclean_geom.pl ");
    
    $file_name[5]        = $empty_string;
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[5];
	$instruction[5] = (" sudo --user=$username --login perl $PL_SEISMIC/SuGeom2.pl ");
    
    $file_name[6]        = $empty_string;
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[6];	
	$instruction[6] = (" sudo --user=$username --login perl $PL_SEISMIC/SuGeom3.pl ");
    
    $file_name[7]        = $empty_string;
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[7];	
	$instruction[7] = (" sudo --user=$username --login perl $PL_SEISMIC/view_L28Hz_Ibeam.pl");
    
#    $file_name[8]        = $empty_string;
#	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[8];	
#	$instruction[8] = (" sudo --user=$username --login perl $PL_SEISMIC/SuPlotHeader.pl");
	#    $instruction[4] = (" sudo --user=$username --login perl $PL_SEISMIC/sunmo_stack.pl");
	#    $instruction[4] = (" sudo --user=$username --login perl $PL_SEISMIC/sunmo_stack_mig.pl");
	#     $instruction[4] = (" sudo --user=$username --login perl $PL_SEISMIC/Sudiff.pl");
	#     $instruction[4] = (" sudo --user=$username --login perl $PL_SEISMIC/Suclean_geom.pl");
	#     $instruction[4] = (" sudo --user=$username --login perl $PL_SEISMIC/make_cmp.pl");

	$instruction[99] = ( "
		echo 'done'			\
	      				" );

	return ( \@PATH_n_file_name, \@file_name, \@instruction );
}

=head2 sub get_instructions

=cut

sub get_instructions {
	my ($self) = @_;

	my @message;

	my $instructions_aref = _get_instructions();
	my @instructions      = @$instructions_aref;

	$message[0] = ("   \ncheck.pm\n    4. Test functionality of each demonstration script");
	$message[1] = ("\t--Permit \'$username\' to share X11window");
	$message[2] = ("\t--Leave account");

	return ( \@message, $instructions_aref );

}

1;
