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

 BASED ON:

=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES

=cut 

use Moose;
our $VERSION = '0.0.1';
use L_SU_global_constants;

=head2 Instantiation

=cut

my $get = L_SU_global_constants->new();

=head2 Declare Variables

=cut

my $var          = $get->var();
my $empty_string = $var->{_empty_string};

=head2 sub get_test_results
Where testing gets done

=cut

sub get_test_results {

	my ($self) = @_;

	use Test::Most tests => 2, 'die';
	use File::Compare;

=head2 Instantiation 

=cut

=head2 Variable declaration
 $L_SU is a global variable for locating 
 the  main folder.
 
 REF_DATA_SEISMIC_SU is the reference 
 for comparison.
 
=cut

	my @file_name;
	my @PATH_n_file_name;

	my $L_SU = $ENV{'L_SU'};

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print "export L_SU=/usr/local/pl/L_SU ";

	} else {
		print("\n$L_SU = $L_SU \n");
	}

	my $REF_DATA_SEISMIC_SU  = $L_SU . '/demo_projects/Servilleta_demos/seismics/data/loma_blanca/053018/H/1/su/gom';
	my $TEST_DATA_SEISMIC_SU = $L_SU . '/t/tester/Servilleta_demos/seismics/data/loma_blanca/053018/H/1/su/gom';
	my $PL_SEISMIC           = $L_SU . '/t/tester/Servilleta_demos/seismics/pl/loma_blanca/053018/H/1/su/gom';

	my $ref_instructions = _get_instructions();
	my @instruction      = @$ref_instructions;

	$file_name[0]        = 'L28Hz_Ibeam_geom2.su';
	$PATH_n_file_name[0] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[0];

	$file_name[1]        = $empty_string;
	$PATH_n_file_name[1] = $TEST_DATA_SEISMIC_SU . '/' . $file_name[1];

	my $number_of_op_files = scalar @file_name;

	for ( my $i = 0; $i < $number_of_op_files; $i++ ) {

		if ( length( $file_name[$i] ) ) {

			# CASE 1
			system(" $instruction[$i] ");
			my $compare  = compare( $file_name[0], $file_name[0] );
			my $response = $PATH_n_file_name[0] . ' equals ' . $file_name[0];

			if ( $? eq 0 ) {

				print "\nSuccessful run \n";

			} else {
				print("Unsuccessful run \n");
			}
			
			ok $compare, $response;
			
			

		} elsif ( not( length( $file_name[$i] ) ) ) {

			# CASE 2 NADA

			if ( length( $instruction[$i] ) ) {

				system(" $instruction[$i] ");

			}

			if ( $? eq 0 ) {

				print "\nSuccessful run \n";
				ok($? == 0);

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

=head2 sub get_instructions

=cut

sub get_instructions {
	my ($self) = @_;

	my @message;
	my $ref_instruction = _get_instructions();

	$message[0] = ("   \ncheck.pm\n    4. Test functionality of each demonstration script");
	$message[1] = ("\t--Leave account");

	return ( \@message, $ref_instruction );

}

=head2 sub _set_instructions

=cut

sub _get_instructions {
	my ($self) = @_;

	my $username = 'tester';
	my @instruction;

	my $L_SU = $ENV{'L_SU'};

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export L_SU=/usr/local/pl/L_SU ";

	} else {

		#		print("\$L_SU = $L_SU \n");
	}

	my $PATH = $L_SU . '/t';
	my $HOME = $PATH . '/' . $username;

	#	my $REF_DATA_SEISMIC_SU = $L_SU . '/demo_projects/Servilleta_demos/seismics/data/loma_blanca/050318/H/1/su/gom';
	#	my $TEST_DATA_SEISMIC_SU   =  $L_SU . '/t/tester/Servilleta_demos/seismics/data/loma_blanca/050318/H/1/su/gom';
	my $PL_SEISMIC = $HOME . '/Servilleta_demos/seismics/pl/loma_blanca/053018/H/1/gom';

	$instruction[0] = (" sudo --user=$username --login perl $PL_SEISMIC/suop2.pl ");
	$instruction[1] = (" sudo --user=$username --login perl $PL_SEISMIC/plot_traclVsoffset.pl ");

	$instruction[2] = ( "
		echo 'done'			\
	      				" );

	return ( \@instruction );
}

1;
