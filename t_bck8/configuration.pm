package configuration;

=head1 DOCUMENTATION

=head2 SYNOPSIS 
program to add appropriate configuration
files and directors for the user: "tester"
for conducting tests of perl programs
May 2021

Pre-process some configuration files
so that the environment variable is correct
$L_SU must be correct.
June 2021

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

=head2 Declare Modules

=cut

use Moose;
our $VERSION = '0.0.2';
use File::Slurp;
use L_SU_global_constants;


=head2 Instantiation

=cut

my $get = L_SU_global_constants->new();

=head2 Private variables

=cut

my $var           = $get->var();
my $test_dir_name = $var->{_test_dir_name};
my $username      = $var->{_username};

sub get_instructions {

	my ($self) = @_;

	# L_SU is a global variable for locating the  main folder
	my $L_SU = $ENV{'L_SU'};

	my ( @instruction, @message );

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export L_SU=/usr/local/pl/L_SU ";

	} else {

		# print("\$L_SU = $L_SU \n");
	}

	my $PATH                  = $L_SU . '/' . $test_dir_name;
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
	# replace

	$instruction[4]  = ("sudo cp $L_SU/t/Project.config4Servilleta_demos $active_directory[0]/$Project_configuration");
	$instruction[5]  = ("sudo cp $L_SU/t/Project.config4Servilleta_demos  $latent_directory[0]/$Project_configuration");
	$instruction[6]  = ("sudo cp $L_SU/t/Project.config4demos $latent_directory[1]/$Project_configuration");
	$instruction[7]  = ("sudo cp -r $L_SU/demo_projects/Servilleta_demos $L_SU/t/$username");
	$instruction[8]  = ("sudo cp -r $L_SU/demo_projects/demos $L_SU/t/$username");
	$instruction[9]  = ("sudo chmod -R 755  $L_SU/t/$username");
	$instruction[10] = ("sudo chown -R $username $L_SU/t/$username");
	$instruction[11] = ("sudo chgrp -R $username $L_SU/t/$username");

	$message[0] = ("   \nconfiguration.pm\n    2. Create configuration subdirectories and files");
	$message[1] = "\t--Create Servilleta_demos project in active directory";
	$message[2] = "\t--Create Servilleta_demos project in latent directory";
	$message[3] = "\t--Create demos project in latent directory";

	# A latent configuration exists for demos and Servilleta_demos
	$message[4]  = ("\t--Copy $active_directory[0]/$Project_configuration");
	$message[5]  = ("\t--Copy $latent_directory[0]/$Project_configuration");
	$message[6]  = ("\t--Copy $latent_directory[1]/$Project_configuration");
	$message[7]  = ("\t--Copy $L_SU/demo_projects/Servilleta_demos to $L_SU/t/$username");
	$message[8]  = ("\t--Copy $L_SU/demo_projects/demos to $L_SU/t/$username");
	$message[9]  = ("\t--Make $username\'s directory exectubale and writable for the owner");
	$message[10] = ("\t--Make $username\'s files belong the owner");
	$message[11] = ("\t--Make $username\'s files belong to their own group");

	return ( \@message, \@instruction );

}

=head2 sub set_preparations
Pre-process file content.
Confirm location of L_SU installation.
Update configuration files with 
correct L_SU installation directory.

=cut

sub set_preparations {
	my ($self) = @_;

	my $result;
	my ( @active_directory, @latent_directory );
	my @lines;

	# L_SU is a global variable for locating the  main folder
	my $L_SU     = $ENV{'L_SU'};
	my $username = 'tester';

	if ( not length($L_SU) ) {

		print "global variable L_SU must be set";
		print "e.g. in .bashrc: ";
		print " export L_SU=/usr/local/pl/L_SU ";

	} else {

		# print("\$L_SU = $L_SU \n");
	}

	my $PATH = $L_SU . '/' . $test_dir_name;
	my $HOME = $PATH . '/' . $username;

	# slurp a whole file
	my $file = $L_SU . '/t/Project.config4Servilleta_demos';

	if ( -e $file ) {

		@lines = read_file($file);
		$lines[0] =~ s/\$HOME/$HOME/;
		$lines[1] =~ s/\$HOME/$HOME/;
		write_file( $file, @lines );

	} else {
		print("configuration, set_preparations, filename does not exist\n");
	}

	#	$L_SU/t/Project.config4Servilleta_demos

	return ($result);
}

1;
