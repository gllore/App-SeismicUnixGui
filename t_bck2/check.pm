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
use Test::Simple tests => 235;

# L_SU is a global variable for locating the  main folder

sub get_instructions {
	my ($self) = @_;

	# L_SU is a global variable for locating the  main folder
	my $L_SU = $ENV{'L_SU'};

	my $username = 'tester';
	my ( @instruction, @message );
#	my $password = 'a!efg101$-_qop5';
	my $password = '5';
	
	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export L_SU=/usr/local/pl/L_SU ";

	} else {
		print("\$L_SU = $L_SU \n");
	}

	my $PATH = $L_SU . '/L_SU/t';
	my $HOME = $PATH . '/' . $username;

	$instruction[0] = "sudo su -l $username \
								  L_SU ";

	$message[0] = ("\ncheck.pm\n    Test functionality of each demonstration script");
#	$message[1] = ("   Create temporary account for tester");
	
	return ( \@message, \@instruction );

}

1;