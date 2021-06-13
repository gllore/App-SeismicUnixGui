package configuration;

=head1 DOCUMENTATION

=head2 SYNOPSIS 
program to add appropriate configuration
files and directors for the user: "tester"
for conducting tests of perl programs
May 2021

 PERL module NAME: configuration.pm
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

sub get_instructions {

	my ($self) = @_;

	# L_SU is a global variable for locating the  main folder
	my $L_SU = $ENV{'L_SU'};

	my $username = 'tester';
	my ( @instruction, @message );

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export L_SU=/usr/local/pl/L_SU ";

	} else {
		# print("\$L_SU = $L_SU \n");
	}

	my $PATH                  = $L_SU . '/t';
	my $HOME                  = $PATH . '/' . $username;
	my $Project_configuration = 'Project.config';
	my ( @active_directory, @latent_directory );

	# only one active directory can exist at a time
	$active_directory[0] = $HOME . '/.L_SU/configuration/active';

	$latent_directory[0] = $HOME . '/.L_SU/configuration/Servilleta_demos';
	$latent_directory[1] = $HOME . '/.L_SU/configuration/demos';

	$instruction[0] = "sudo mkdir -pv $HOME/.L_SU/configuration/active";
	$instruction[1] = "sudo mkdir -pv $active_directory[0]";
	$instruction[2] = "sudo mkdir -pv $latent_directory[0]";
	$instruction[3] = "sudo mkdir -pv $latent_directory[1]";

	# write out the active Project.config file into the active and latent directory
	$instruction[4] = ("sudo cp $L_SU/t/Project.config4Servilleta_demos $active_directory[0]/$Project_configuration");
	$instruction[5] = ("sudo cp $L_SU/t/Project.config4Servilleta_demos  $latent_directory[0]/$Project_configuration");
	$instruction[6] = ("sudo cp $L_SU/t/Project.config4demos $latent_directory[1]/$Project_configuration");
	$instruction[7] = ("sudo cp -r $L_SU/demo_projects/Servilleta_demos $L_SU/t/$username");
	$instruction[8] = ("sudo cp -r $L_SU/demo_projects/demos $L_SU/t/$username");	

	$message[0] = ("   \nconfiguration.pm\n    2. Create configuration subdirectories and files");
	$message[1] = "\t--Create Servilleta_demos project in active directory";
	$message[2] = "\t--Create Servilleta_demos project in latent directory";
	$message[3] = "\t--Create demos project in latent directory";

	# A latent configuration exists for demos and Servilleta_demos
	$message[4] = ("\t--Write $active_directory[0]/$Project_configuration");
	$message[5] = ("\t--Write $latent_directory[0]/$Project_configuration");
	$message[6] = ("\t--Write $latent_directory[1]/$Project_configuration");
    $message[7] = ("\t--Copy $L_SU/demo_projects/Servilleta_demos $L_SU/t/$username");
    $message[8] = ("\t--Copy $L_SU/demo_projects/demos $L_SU/t/$username");
    
	return ( \@message, \@instruction );

}
1;
