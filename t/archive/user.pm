package App::SeismicUnixGui::t::user;

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

=head2 Declare Modules

=cut

use Moose;
our $VERSION = '0.0.1'; 
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';

=head2 Instantiation

=cut

my $get = L_SU_global_constants->new();

=head2 Private variables

=cut

my $var           = $get->var();
my $test_dir_name = $var->{_test_dir_name};
my $username      = $var->{_username};

# L_SU is a global variable for locating the  main folder

sub get_instructions {
	my ($self) = @_;

	# program to add a new user in preparation
	# for conducting tests of perl programs
	# L_SU is a global variable for locating the  main folder
	my $L_SU = $ENV{'L_SU'};

	my ( @instruction, @message );

	#my $password = 'a!efg101$-_qop5';
	my $password = '5';

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export SeismicUnixGui=/usr/local/pl/SeismicUnixGui ";

	} else {
		print("\$L_SU = $L_SU \n");
	}

	my $PATH = $L_SU . '/' . $test_dir_name;
	my $HOME = $PATH . '/' . $username;

	$instruction[0] = ( "
	username=$username
	getent passwd $username > /dev/null		\
	if [ \$\? -eq 0 ]; then											\
    	echo \"A user = tester already exists. Can not continue\"	\
    	echo \"Must change test user name\"							\
		exit 0														\
																	\
	else															\
	    echo \"A user= tester does not exist. OK to continue\"		\
	fi													   			\
	" );

	$instruction[1] = (
		"sudo /usr/sbin/luseradd --directory=$HOME --plainpassword=$password -g=$username --shell=/bin/bash $username");
	$instruction[2] = ("sudo  chmod 755 $HOME ");
	$instruction[3] = (
		"											\
	while [ !  -f  $HOME/.bashrc ]    								\
     	do 															\
     		echo 'waiting to find .bashrc'   						\
     	done														\
     	# echo 'found it' 											\
     	sudo chmod 777 $HOME/.bashrc 								\
     	sudo cat $PATH/bashrc_local >> $HOME/.bashrc  				\
     	sudo chmod 744 $HOME/.bashrc 								\
     	sudo  chmod 700 $HOME 										\
"
	);
	$message[0] = ("   \nuser.pm\n    1. Create user directory and files");
	$message[1] = ("\t--Clear any pre-existing account information and files belonging to 'tester'");
	$message[2] = ("\t--Create temporary account for tester");
	$message[3] = ("\t--Change permissions for tester");
	$message[4] = ("\t--Append environmental variables to tester's '.bashrc' file");

	return ( \@message, \@instruction );

}

1;
