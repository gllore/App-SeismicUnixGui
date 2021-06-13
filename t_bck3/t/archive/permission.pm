package permission;

=head1 DOCUMENTATION

=head2 SYNOPSIS 
program to add a new user in preparation
for conducting tests of perl programs

 PERL module NAME: user.pm
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

# L_SU is a global variable for locating the  main folder

sub get_instructions {
	my ($self) = @_;

	my $L_SU = $ENV{'L_SU'};

	my $username = 'tester';
	my ( @instruction, @message );
	my $password = 'a!efg101$-_qop5';

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export L_SU=/usr/local/pl/L_SU ";

	} else {
		print("\$L_SU = $L_SU \n");
	}

	my $PATH = $L_SU . '/L_SU/t';
	my $HOME = $PATH . '/' . $username;

	$instruction[0] = "sudo chown $username $HOME/.*";
	$instruction[1] = "sudo chgrp $username $HOME/.*";
	$instruction[2] = "sudo su - $username";

	$message[0] = ("   Give tester ownwership of new files");
	$message[1] = ("   Assign tester's group name to new files");
	$message[2] = ("   Log into temporary account as the new user: 'tester' &");

	return(\@message,\@instruction);

}

1;
