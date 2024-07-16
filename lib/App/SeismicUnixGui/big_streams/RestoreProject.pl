
=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: RestoreProject 
 AUTHOR:  Juan Lorenzo

=head2 CHANGES and their DATES

 DATE:    July 2024
 Version  1.0 
 

=head2 DESCRIPTION

         Restore (tar -xzvf) a Project plus
         its Project.config file
         and restore the Project configuration
         file and its associated directory
         into the .L_SU foldder

=head2 USE

perl RestoreProject.pl

=head2 Steps


1.  Apply tar -czvf to the compressed and tarred Project file in the user's 
directory.

2. Confirm that the Project.config directory is present. Otherwise output a warning.

5. replace original user name (e.g., "gllore") with the current user name.

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
use aliased 'App::SeismicUnixGui::configs::big_streams::RestoreProject_config';
use aliased 'App::SeismicUnixGui::misc::config_superflows';
use aliased 'App::SeismicUnixGui::misc::control';
use aliased 'App::SeismicUnixGui::misc::readfiles';
use File::Copy;

=head2 Instantiate classes:

 Create a new versions of the packages 

=cut

my $RestoreProject_config     = RestoreProject_config->new();
my $L_SU_local_user_constants = L_SU_local_user_constants->new();
my $readfiles                 = readfiles->new();
my $config_superflows         = config_superflows->new();
my $control                   = control->new();

=head2

  Internal definitions
  
=cut

my $success_counter  = 0;
my $current_username = getpwuid($<);
my $prog_name        = 'Project';

=head2 Get configuration information

=cut

my ( $CFG_h, $CFG_aref ) = $RestoreProject_config->get_values();
my $new_project_name = $CFG_h->{RestoreProject}{1}{directory_name};

$control->set_infection($new_project_name);
$new_project_name = $control->get_ticksBgone();

print("RestoreProject.pl,  new_project_name = $new_project_name \n");

my $HOME            = $L_SU_local_user_constants->get_home();
my $tar_input       = $HOME . '/' . $new_project_name;
my $ACTIVE_PROJECT  = $L_SU_local_user_constants->get_ACTIVE_PROJECT();
my $CONFIGURATION   = $L_SU_local_user_constants->get_CONFIGURATION();
my $old_active_file = $tar_input . '/Project.config';
my $new_active_file =
  $CONFIGURATION . '/' . $new_project_name . '/Project.config';

#print(" RestoreProject.pl,ACTIVE_PROJECT=$ACTIVE_PROJECT\n");

=head2 head1

Untar a project

=cut

my $tar_options      = '-xzvf';
my $perl_instruction = ("cd $HOME; tar $tar_options $tar_input.tz");
system($perl_instruction);

=head2 Verify project is a true SUG project

  1. Collect existant project names
  2. Confirm that SUG configuration system exists
  If SUG configuration folders do not exist then
  this the first time that the user is running
  SeismicUnixGui. And folders need to be generated

=cut

my @PROJECT_HOME_aref = $L_SU_local_user_constants->get_PROJECT_HOMES_aref();
my @project_pathNname = @{ $PROJECT_HOME_aref[0] };
my $length_projects   = scalar @project_pathNname;

#print(
#"RestoreProject.pl,There are $length_projects existant projects in /.L_SU/configuration\n"
#);

=pod
 
 check to see that an old project directory does not exist
 to prevent overwriing an older project.
 
=cut

$L_SU_local_user_constants->set_PROJECT_name($new_project_name);
my $same_project_exists = $L_SU_local_user_constants->get_PROJECT_exists();

#print(
#"RestoreProject.pl,Does a new Project.config file exist for project $new_project_name? ans=$same_project_exists\n"
#);

=head2 prepare useful instructions

=cut

my $instruction1 = 'mkdir -p '.$ACTIVE_PROJECT;
my $instruction2 = 'mkdir -p '.$CONFIGURATION.'/' . $new_project_name;

=head2
 
 CASE 1: First time that any Project is built for this user
 in their Home directory

 If there are no prior SeismicUnixGui configurations, then create
 the directories
 
=cut

if ( $length_projects == 0 ) {

	system($instruction1);
	system($instruction2);
	print("$instruction1\n");
	print("$instruction2\n");
	#print("First time a SUG Project is created\n");

	$length_projects = 1;
}

=head2

 CASE 2
 N.B. At least one previous project directory
 (just created or not) must exist
A Project.config file does not exist
 
=cut

if ( $length_projects >= 1
	and not $same_project_exists )
{

	print("This seems like a real SeismicUnixGui project!\n");

=head2

For all newly restored folders,
replace folder names = username with the current username

STEPS
1. Find old user name, in backed-up Project.config file
2. Find the current user's name ( see start of this module)
3. Replace the old with current user's name in the  Project.config file
4. Replace any restored folder names to the current user's name
5. Create folder in the configuration directory
6. Copy new Project.config file to the configuration directory
 


=pod 
Make configuration directory
Copy the backed-up copy of
Project.config into the configuration
subfolder

=cut

	system($instruction2);
    print("$instruction2\n");
	my $from = $old_active_file;
	my $to   = $new_active_file;
	copy($from,$to);
	
#    print("RestoreProject.pl, Copying from $from to $to\n");

	my ( $ref_parameter, $ref_value ) = $readfiles->configs($old_active_file);
	my @value                    = @$ref_value;
	my $old_username_from_backup = $value[7];

#	print(" RestoreProject.pl,old username=$value[7]\n");
#	print(" RestoreProject.pl,old old_username_from_backup=$old_username_from_backup\n");

=head2
	
	Replace old username from backup-up Project.config file
	with the name of the current username
	
	config_superflows has a special configuration file 
	for program with a name=Project
	
=cut

	$config_superflows->set_program_name( \$prog_name );    # needed

	$control->set_infection( $value[0] );
	my $home_value          = $control->get_ticksBgone();

	$control->set_infection( $value[1] );
	my $project_value       = $control->get_ticksBgone();

	$control->set_infection( $value[7] );
	my $subuser_value       = $control->get_ticksBgone();

	$control->set_infection($old_username_from_backup);
	$old_username_from_backup = $control->get_ticksBgone();

	my $dir2find             = $old_username_from_backup;

	$home_value    =~ s/$old_username_from_backup/$current_username/;
	$project_value =~ s/$old_username_from_backup/$current_username/;
	$subuser_value =~ s/$old_username_from_backup/$current_username/;

	#	print(" home_value   = $home_value\n");
	#	print(" project_value= $project_value\n");
	#	print(" subuser_value = $subuser_value\n");

	# restore ticks to the strings
	$control->set_first_name_string($home_value);
	$home_value = $control->get_w_single_quotes();

	$control->set_first_name_string($project_value);
	$project_value = $control->get_w_single_quotes();

	$control->set_first_name_string($subuser_value);
	$subuser_value = $subuser_value;

	$value[0] = $home_value;
	$value[1] = $project_value;
	$value[7] = $subuser_value;

	my $hash_ref = {
		_names_aref     => $ref_parameter,
		_values_aref    => \@value,
		_prog_name_sref => \$prog_name,
	};

	$config_superflows->save($hash_ref);

	# Replace old folder names with current username
	my $starting_point = $HOME . '/' . $new_project_name;
	print(" RestoreProject.pl,project_directory=$new_project_name\n");

#	print(" Looking for directories within the project to be restored...\n");
	print("old_username_from_backup=$old_username_from_backup\n");


	my @original_list = `(find $starting_point -name $dir2find -type d -print 2>/dev/null)`;
	my $original_list_length = scalar @original_list;
	my @new_list             = @original_list;

	print("list is $original_list_length\n");
    my $instruction3;
    
    
	# perform replacement here
	
#	print("current_username = $current_username\n");
#	print("dir2find= $dir2find\n");
	
	for ( my $i = 0 ; $i < $original_list_length ; $i++ ) {
		
        my $old_directory = $original_list[$i];
        my $new_directory = $original_list[$i];
        print("old_directory= $old_directory\n");

	    # remove ambiguous substitutions by makign sure
	    # the directory name found has no extra letters
	    # at the start or the end
		$new_directory =~ s/(?<=\b)(?=$dir2find\b)$dir2find/$current_username/g;
		chomp $old_directory;
	    $instruction3 = ("mv $old_directory $new_directory ");
	    system($instruction3);
	     print(" new_directory=$new_directory\n");
		print("$instruction3\n");
		
	}

#	print("replaced list is @new_list\n");



}
else {
	print("RestoreProject.pl,unsuccessful\n");
	print("You either have never run SUG before or\n");
	print("you are trying to overwrite another project with the same name\n");
}

