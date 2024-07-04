
=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: BakupProject 
 AUTHOR:  Juan Lorenzo

=head2 CHANGES and their DATES

 DATE:    July 2024
 Version  1.0 
 

=head2 DESCRIPTION

         Backup (tar -czvf) a Project plus
         its Project.config file

=head2 USE

perl BackupProject.pl

=head2 Steps

1. Read the BackupProject.config file in the user's 
Project directory. This Project directory does not have to 
be the same one that is being tarred

2. Read configuration file to determine the directory that is being 
tarred

3. Confirm that the directory is a project. Otherwise output a warning.

4. tar -czvf

5. Message that process is complete 


=head2 NOTES 

 We are using Moose.
 Moose already declares that you need debuggers turned on
 so you don't need a line like the following:
 use warnings;


=cut

use Moose;
our $VERSION = '0.1.0';

use aliased 'App::SeismicUnixGui::misc::L_SU_local_user_constants';
use aliased 'App::SeismicUnixGui::configs::big_streams::BackupProject_config';
use File::Copy;

=head2 Instantiate classes:

 Create a new versions of the packages 

=cut

my $BackupProject_config = BackupProject_config->new();
my $L_SU_local_user_constants = L_SU_local_user_constants->new();

=head2

  Internal definitions
  
=cut

my $success_counter = 0;

=head2 Get configuration information

=cut

my ( $CFG_h, $CFG_aref ) = $BackupProject_config->get_values();
my $project_directory = $CFG_h->{BackupProject}{1}{directory_name};

#print("BackupProject.pl, project_directory = $project_directory \n");

$project_directory = 'LiClipse';
my $HOME           = $L_SU_local_user_constants->get_home();
my $tar_input      = $HOME . '/'. $project_directory;

=head2 Verify project is a true SUG project

collect project names
compare backup project against project names

=cut

my @PROJECT_HOME_aref = $L_SU_local_user_constants->get_PROJECT_HOMES_aref();
my @project_name_aref = $L_SU_local_user_constants->get_project_names();
my $CONFIGURATION     = $L_SU_local_user_constants->get_CONFIGURATION();

my @project_pathNname = @{ $PROJECT_HOME_aref[0] };
my @project_name      = @{ $project_name_aref[0] };

my $length             = scalar @project_pathNname;

#print("BackupProject.pl,project_pathNnames are=@project_pathNname\n");
print("BackupProject.pl,project names=@project_name\n");
print("BackupProject.pl,There are $length existant projects in /.L_SU/configuration\n");

=pod
 
 check to see that the project directory exists
 
=cut

 $L_SU_local_user_constants->set_PROJECT_name($project_directory);
 my $project_exists = $L_SU_local_user_constants->get_PROJECT_exists();
# print("BackupProject.pl,projects exists? ans=$ans\n");
 
#for ( my $i = 0 ; $i < $length ; $i++ ) {
#	my $x = $project_name[$i];
#
#	if ( $x =~ m/$project_directory/ ) {
#		$success_counter++;
#
#	}
#	else {
#		#		print ("no\n");
#	}
#
#}

=pod
 
 check to see that the project directory contains Project.config
 If Project.config exists then
 copy configuration directory as well to the Project for backup
 
=cut

if ( $project_exists ) {

	my $Project_configuration_exists = $L_SU_local_user_constants->user_configuration_Project_config_exists();

	if ($Project_configuration_exists) {

#		print("Found a real SeismicUnixGui project!\n");
		my $from = $L_SU_local_user_constants->get_user_configuration_Project_config();
		my $to   = $tar_input;
		
		copy( $from, $to );
		
        print("BackupProject.pl, copying $from to $to \n");
	}
	else {
		print("BackupProject.pl,unsuccessful\n");
		print("Not a real SeismicUnixGui project!\n");
	}

}

=head2 Tarring a project

=cut

my $tar_options      = '-czvf';

my $perl_instruction = ("tar $tar_options $tar_input.tz $tar_input");

print("$perl_instruction\n");

system($perl_instruction);
