package user;

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

	# program to add a new user in preparation
	# for conducting tests of perl programs

	# L_SU is a global variable for locating the  main folder
	my $L_SU = $ENV{'L_SU'};

	my $username = 'tester';
	my ( @instruction, @message );
	#my $password = 'a!efg101$-_qop5';
    	my $password = '5';

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export L_SU=/usr/local/pl/L_SU ";

	} else {
		print("\$L_SU = $L_SU \n"); 
	}

	my $PATH = $L_SU . '/t';
	my $HOME = $PATH . '/' . $username;

	$instruction[0] = ( "
	username='tester'
	getent passwd $username > /dev/null		\
	if [ \$\? -eq 0 ]; then											\
    	echo \"A user = tester already exists. Can not continue\"	\
		exit 0														\
																	\
	else															\
	    echo \"A user= tester does not exist. OK to continue\"		\
    	sudo /usr/sbin/userdel -r $username   						\
	fi													   			\
	");

	$instruction[1] = ( "sudo /usr/sbin/luseradd --directory=$HOME --plainpassword=$password -g=$username --shell=/bin/bash $username");
	$instruction[2] = ("sudo  chmod 755 $HOME ");
    $instruction[3] = ("											\
	while [ !  -f  $HOME/.bashrc ]    								\
     	do 															\
     		echo 'waiting to find .bashrc'   						\
     	done														\
     	# echo 'found it' 											\
     	sudo chmod 777 $HOME/.bashrc 								\
     	sudo cat $PATH/bashrc_local >> $HOME/.bashrc  				\
     	sudo chmod 744 $HOME/.bashrc 								\
     	sudo  chmod 700 $HOME 										\
	fi																\
");

	$message[0] = ("--Clear any pre-existing account information and files belonging to 'tester'");
	$message[1] = ("--Create temporary account for tester");
	$message[2] = ("--Change permissions for tester");	
	$message[3] = ("--Append environmental variables to tester's '.bashrc' file");
	
	return ( \@message, \@instruction );

}

1;
