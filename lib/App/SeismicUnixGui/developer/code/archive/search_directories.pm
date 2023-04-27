package App::SeismicUnixGui::developer::code::sunix::search_directories;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PROGRAM NAME: search_directories
 AUTHOR: 	Juan Lorenzo
 DATE: 		Nov. 26 2022

 DESCRIPTION 
 Find key directories

 BASED ON:
 Version App::SeismicUnixGui::misc::search_directories 
 
=cut

=head2 USE

=head3 NOTES

It is assumed that developer programs are used
ONLY after full installation of App::SeismicUnixGui
and that the appropriate environment variables
are also working.

=head4 Examples

=head2 CHANGES and their DATES

=cut 

use Moose;
our $VERSION = '0.0.1';
use Carp;

my $path4SeismicUnixGui;
$path4SeismicUnixGui = $ENV{'SeismicUnixGui'};

BEGIN {

	if ( length $ENV{'SeismicUnixGui'} ) {

		$path4SeismicUnixGui = $ENV{'SeismicUnixGui'};

	}
	else {
		my $dir = 'App-SeismicUnixGui/lib/App/SeismicUnixGui';
		my $pathNfile =
		  'App-SeismicUnixGui/lib/App/SeismicUnixGui/sunix/data/data_in.pm';
		my $look  = `locate $pathNfile`;
		my @field = split( $dir, $look );
		$path4SeismicUnixGui = $field[0] . $dir;

	   #		print(
	   #"\nL22. Using default search_directories, L_SU = $path4SeismicUnixGui\n"
	   #		);
	}
}

#my $path4SeismicUnixGui_lib = $L_SU;

#   print ("search_directories,SeismicUnixGui_lib = $path4SeismicUnixGui_lib\n");
#	print("search_directories,SeismicUnixGui = $path4SeismicUnixGui\n");

=head2 Declare modules

=cut 

use aliased 'App::SeismicUnixGui::misc::manage_dirs_by';

=head2 Instantiate modules

=cut

my $manage_dirs_by = manage_dirs_by->new();

=head2 private hash

=cut

my $search_directories = {

	_CHILD_DIR          => '',
	_CHILD_DIR_CONVERT  => '',
	_CHILD_DIR_GUI      => '',
	_CHILD_DIR_TOOLS    => '',
	_CHILD_DIR_SPECS    => '',
	_CHILD_DIR_SU       => '',
	_GRANDPARENT_DIR    => '',
	_PARENT_DIR         => '',
	_PARENT_DIR_CONVERT => '',
	_PARENT_DIR_GEN     => '',
	_PARENT_DIR_GUI     => '',
	_PARENT_DIR_TOOLS   => '',
	_PARENT_DIR_SPECS   => '',
	_PARENT_DIR_SU      => '',
	_file_name          => '',
	_program_name       => '',

};

# Locate environment variables automatically
my @PARENT_DIR_CONVERT = ( "sunix",   "misc", "configs" );
my @PARENT_DIR_GUI     = ( "configs", "specs" );
my @PARENT_DIR_TOOLS   = ("big_streams");
my @PARENT_DIR_SPECS   = ("specs");
my @PARENT_DIR_SU      = ("sunix");

my @PARENT_DIR_GEN =
  ( "misc", "geopsy", "messages", 
  "developer/code/sunix", "script" );

my @CHILD_DIR_CONVERT = (
	"",          "big_streams", "data",      "datum",
	"filter",    "header",      "inversion", "migration",
	"model",     "NMO_Vel_Stk", "par",       "plot",
	"shapeNcut", "shell",       "statsMath", "transform",
	"well"
);

my @CHILD_DIR_GEN = ( "", );

my @CHILD_DIR_GUI = (
	"big_streams", "data",      "datum",     "filter",
	"header",      "inversion", "migration", "model",
	"NMO_Vel_Stk", "par",       "plot",      "shapeNcut",
	"shell",       "statsMath", "transform", "well"
);

my @CHILD_DIR_TOOLS = ("");

my @CHILD_DIR_SPECS = (
	"big_streams", "data",      "datum",     "filter",
	"header",      "inversion", "migration", "model",
	"NMO_Vel_Stk", "par",       "plot",      "shapeNcut",
	"shell",       "statsMath", "transform", "well"
);

my @CHILD_DIR_SU = (
	"data",      "datum",     "filter",    "header",
	"inversion", "migration", "model",     "NMO_Vel_Stk",
	"par",       "plot",      "shapeNcut", "shell",
	"statsMath", "transform", "well"
);

$search_directories->{_PARENT_DIR_CONVERT} = \@PARENT_DIR_CONVERT;
$search_directories->{_PARENT_DIR_GUI}     = \@PARENT_DIR_GUI;
$search_directories->{_PARENT_DIR_TOOLS}   = \@PARENT_DIR_TOOLS;
$search_directories->{_PARENT_DIR_SPECS}   = \@PARENT_DIR_SPECS;
$search_directories->{_PARENT_DIR_SU}      = \@PARENT_DIR_SU;
$search_directories->{_PARENT_DIR_GEN}     = \@PARENT_DIR_GEN;
$search_directories->{_CHILD_DIR_CONVERT}  = \@CHILD_DIR_CONVERT;
$search_directories->{_CHILD_DIR_GEN}      = \@CHILD_DIR_GEN;
$search_directories->{_CHILD_DIR_GUI}      = \@CHILD_DIR_GUI;
$search_directories->{_CHILD_DIR_TOOLS}    = \@CHILD_DIR_TOOLS;
$search_directories->{_CHILD_DIR_SPECS}    = \@CHILD_DIR_SPECS;
$search_directories->{_CHILD_DIR_SU}       = \@CHILD_DIR_SU;

##		print("L1042, search_directories, global_libs, L_SU was missing\n");
##		print(
##"\nL1044. search_directories, Using default  L_SU = $path4SeismicUnixGui\n"
##		);

#
#sub _get_path4SeismicUnixGui {
#	my ($self) = @_;
#	if ( length $path4SeismicUnixGui ) {
#
#		my $result = $path4SeismicUnixGui;
#		return ($result);
#
#	}
#	else {
#		print(
#			"search_directories, _get_path4SeismicUnixGui,missing variable\n"
#		);
#	}
#	return ();
#}
#
#=head2 sub _get_path4spec_file
#
#Find a path for
#
#a given spec file
#
#=cut
#
#sub _get_path4spec_file {
#
#	my (@self) = @_;
#
#	if ( length $search_directories->{_file_name} ) {
#
#		my $file_name = $search_directories->{_file_name};
#		my $result;
#
#=head2 Collect parameters from local hash
#
#=cut
#
#		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
#		my @PARENT_DIR_SPECS = @{ $search_directories->{_PARENT_DIR_SPECS} };
#		my @CHILD_DIR_SPECS  = @{ $search_directories->{_CHILD_DIR_SPECS} };
#
#=head2 Collect relevant "spec"
#
# project paths and files
#
#=cut
#
#		my ( $result_aref3, $dimensions_aref ) = _get_specs_pathNfile2search();
#		my @result_aref2                     = @$result_aref3;
#		my @directory_contents_specs         = @{ $result_aref2[0] };
#		my @dimension                        = @$dimensions_aref;
#		my $parent_directory_specs_number_of = $dimension[0];
#		my $child_directory_specs_number_of  = $dimension[1];
#
## test
##		my $parent_specs = 1;
##		my $child_specs  = 1;
##		print(
##"\nFor specs directory paths: $PARENT_DIR_SPECS[$parent_specs]::$CHILD_DIR_SPECS[$child_specs]::\n"
##		);
##		print("@{$directory_contents_specs[$parent_specs][$child_specs]}\n");
#
#=head2 Search all "spec"-relevant
#
#directories start with
#gui drectory listing
#
#=cut
#
#		for (
#			my $parent = 0 ;
#			$parent < $parent_directory_specs_number_of ;
#			$parent++
#		  )
#		{
#
#			for (
#				my $child = 0 ;
#				$child < $child_directory_specs_number_of ;
#				$child++
#			  )
#			{
#
#				my $directory_list_aref =
#				  $directory_contents_specs[$parent][$child];
#				my @directory_list = @$directory_list_aref;
#
#				my $length_directory_list = scalar @directory_list;
#
#				#				print("@{$directory_contents_specs[$parent][$child]}\n");
#				#				print("file_name=$file_name\n");
#				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#					if ( not $file_name eq $directory_list[$i] ) {
#
#						next;
#
#					}
#					elsif ( $file_name eq $directory_list[$i] ) {
#
#		#						print(
#		#"search_directories,_get_path4spec_file,found the file $file_name in
#		#				  			  $PARENT_DIR_SPECS[$parent]::$CHILD_DIR_SPECS[$child]\n"
#		#						);
#						$result =
#							$path4SeismicUnixGui . '/'
#						  . $PARENT_DIR_SPECS[$parent] . '/'
#						  . $CHILD_DIR_SPECS[$child];
#
#						return ($result);
#					}
#					else {
#						print("change_a_line, unexpected value\n");
#						return ();
#					}
#				}
#
#			}
#		}
#
#	}
#	else {
#		print("search_directories,__get_path4spec_file,file_name_missing\n");
#		return ();
#	}
#}
#
#=head2 sub _get_path4su_file
#
#Find a path for
#
#a given spec file
#
#=cut
#
#sub _get_path4su_file {
#
#	my (@self) = @_;
#
#	if ( length $search_directories->{_file_name} ) {
#
#		my $file_name = $search_directories->{_file_name};
#		my $result;
#
#=head2 Collect parameters from local hash
#
#=cut
#
#		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
#		my @PARENT_DIR_SPECS = @{ $search_directories->{_PARENT_DIR_SPECS} };
#		my @CHILD_DIR_SPECS  = @{ $search_directories->{_CHILD_DIR_SPECS} };
#
#=head2 Collect relevant "spec"
#
# project paths and files
#
#=cut
#
#		my ( $result_aref3, $dimensions_aref ) = _get_su_pathNfile2search();
#		my @result_aref2                  = @$result_aref3;
#		my @directory_contents_su         = @{ $result_aref2[0] };
#		my @dimension                     = @$dimensions_aref;
#		my $parent_directory_su_number_of = $dimension[0];
#		my $child_directory_su_number_of  = $dimension[1];
#
## test
##		my $parent_su = 1;
##		my $child_su  = 1;
##		print(
##"\nFor su directory paths: $PARENT_DIR_SPECS[$parent_su]::$CHILD_DIR_SPECS[$child_su]::\n"
##		);
##		print("@{$directory_contents_su[$parent_su][$child_su]}\n");
#
#=head2 Search all "spec"-relevant
#
#directories start with
#gui drectory listing
#
#=cut
#
#		for (
#			my $parent = 0 ;
#			$parent < $parent_directory_su_number_of ;
#			$parent++
#		  )
#		{
#
#			for (
#				my $child = 0 ;
#				$child < $child_directory_su_number_of ;
#				$child++
#			  )
#			{
#
#				my $directory_list_aref =
#				  $directory_contents_su[$parent][$child];
#				my @directory_list = @$directory_list_aref;
#
#				my $length_directory_list = scalar @directory_list;
#
#				#				print("@{$directory_contents_su[$parent][$child]}\n");
#				#				print("file_name=$file_name\n");
#				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#					if ( not $file_name eq $directory_list[$i] ) {
#
#						next;
#
#					}
#					elsif ( $file_name eq $directory_list[$i] ) {
#
#		#						print(
#		#"search_directories,_get_path4spec_file,found the file $file_name in
#		#				  			  $PARENT_DIR_SPECS[$parent]::$CHILD_DIR_SPECS[$child]\n"
#		#						);
#						$result =
#							$path4SeismicUnixGui . '/'
#						  . $PARENT_DIR_SPECS[$parent] . '/'
#						  . $CHILD_DIR_SPECS[$child];
#
#						return ($result);
#					}
#					else {
#						print("change_a_line, unexpected value\n");
#						return ();
#					}
#				}
#
#			}
#		}
#
#	}
#	else {
#		print("search_directories,__get_path4spec_file,file_name_missing\n");
#		return ();
#	}
#}

#sub _set_file_name {
#
#	my ($self) = @_;
#
#	if ( length $self ) {
#
#		$search_directories->{_file_name} = $self;
#
##		print("search_directories,set_file_name,_set_file_name = $search_directories->{_file_name}\n");
#
#	}
#	else {
#		print("search_directories,_set_file_name, missing variable");
#	}
#
#}

#=head2 sub get_colon_pathNmodule
#
#=cut
#
#sub get_colon_pathNmodule {
#
#	my ($self) = @_;
#
#	if ( length $search_directories->{_program_name} ) {
#
#		my $program_name = $search_directories->{_program_name};
#
#		my $module_spec    = $program_name . '_spec';
#		my $module_spec_pm = $program_name . '_spec.pm';
#
#		_set_file_name($module_spec_pm);
#		my $path4spec = _get_path4spec_file();
#
#		my $path4SeismicUnixGui = _get_path4SeismicUnixGui;
#
#		#		my $pathNmodule_pm   = $path4spec . '/' . $module_spec_pm;
#		my $pathNmodule_spec = $path4spec . '/' . $module_spec;
#
#		# carp"pathNmodule_pm = $pathNmodule_pm";
#
#		$pathNmodule_spec =~ s/$path4SeismicUnixGui//g;
#		$pathNmodule_spec =~ s/\//::/g;
#		my $new_pathNmodule_spec = 'App::SeismicUnixGui' . $pathNmodule_spec;
#
#		my $result = $new_pathNmodule_spec;
#		return ($result);
#
#	}
#	else {
#		carp "missing program name";
#		return ();
#	}
#
#}
#
#=head2 sub get_colon_pathNmodule_spec
#
#=cut
#
#sub get_colon_pathNmodule_spec {
#
#	my ($self) = @_;
#
#	if ( length $search_directories->{_program_name} ) {
#
#		my $program_name = $search_directories->{_program_name};
#
#		my $module_spec    = $program_name . '_spec';
#		my $module_spec_pm = $program_name . '_spec.pm';
#
#		_set_file_name($module_spec_pm);
#		my $path4spec = _get_path4spec_file();
#
#		my $path4SeismicUnixGui = _get_path4SeismicUnixGui;
#
#		#		my $pathNmodule_pm   = $path4spec . '/' . $module_spec_pm;
#		my $pathNmodule_spec = $path4spec . '/' . $module_spec;
#
#		# carp"pathNmodule_pm = $pathNmodule_pm";
#
#		$pathNmodule_spec =~ s/$path4SeismicUnixGui//g;
#		$pathNmodule_spec =~ s/\//::/g;
#		my $new_pathNmodule_spec = 'App::SeismicUnixGui' . $pathNmodule_spec;
#
#		my $result = $new_pathNmodule_spec;
#		return ($result);
#
#	}
#	else {
#		carp "missing program name";
#		return ();
#	}
#
#}

#
#=head2 sub get_pathNmodule_spec
#
#=cut
#
#sub get_pathNmodule_spec {
#	my ($self) = @_;
#
#	if ( length $search_directories->{_program_name} ) {
#
#		my $program_name   = $search_directories->{_program_name};
#		my $module_spec    = $program_name . '_spec';
#		my $module_spec_pm = $module_spec . '.pm';
#		_set_file_name($module_spec_pm);
#
#		my $path4spec = _get_path4spec_file();
#
#		my $pathNmodule_spec = $path4spec . '/' . $module_spec;
#
#		# carp "pathNmodule_pm = $pathNmodule_pm";
#		my $result = $pathNmodule_spec;
#		return ($result);
#
#	}
#	else {
#		carp "missing program name";
#		return ();
#	}
#
#}
#
#=head2 sub get_pathNmodule_spec_pm
#
#=cut
#
#sub get_pathNmodule_spec_pm {
#	my ($self) = @_;
#
#	if ( length $search_directories->{_program_name} ) {
#
#		my $program_name   = $search_directories->{_program_name};
#		my $module_spec_pm = $program_name . '_spec.pm';
#		_set_file_name($module_spec_pm);
#
#		my $path4spec = _get_path4spec_file();
#
#		my $pathNmodule_spec_pm = $path4spec . '/' . $module_spec_pm;
#
#		# carp"pathNmodule_pm = $pathNmodule_pm";
#		my $result = $pathNmodule_spec_pm;
#		return ($result);
#
#	}
#	else {
#		carp "missing program name";
#		return ();
#	}
#
#}

=head2 sub get_pathNfile2search

Useful directories to search

=cut

sub get_pathNfile2search {

	my ($self) = @_;

	if (    length $search_directories->{_CHILD_DIR}
		and length $search_directories->{_GRANDPARENT_DIR}
		and length $search_directories->{_PARENT_DIR} )
	{

		my $CHILD_DIR       = $search_directories->{_CHILD_DIR};
		my $GRANDPARENT_DIR = $search_directories->{_GRANDPARENT_DIR};
		my $PARENT_DIR      = $search_directories->{_PARENT_DIR};

=head2 Define

 variables

=cut

		my @directory_contents;
		my @dimensions;

=head2 Define

 directory search arrays

=cut

		my @PARENT_DIR = @{ $search_directories->{_PARENT_DIR} };
		my @CHILD_DIR  = @{ $search_directories->{_CHILD_DIR} };

		my $parent_directory_number_of = scalar @PARENT_DIR;
		my $child_directory_number_of  = scalar @CHILD_DIR;

		@dimensions =
		  ( $parent_directory_number_of, $child_directory_number_of );

=head2 SU-related matters

=cut

		for (
			my $parent = 0 ;
			$parent < $parent_directory_number_of ;
			$parent++
		  )
		{

			for (
				my $child = 0 ;
				$child < $child_directory_number_of ;
				$child++
			  )
			{

				my $SEARCH_DIR =
					$GRANDPARENT_DIR . '/'
				  . $PARENT_DIR[$parent] . '/'
				  . $CHILD_DIR[$child];

   #   	  	  			print(
   #   	  	  "search_directories, get_pathNfile2search,SEARCH_DIR=$SEARCH_DIR\n"
   #   	  	  			);
				$manage_dirs_by->set_directory($SEARCH_DIR);
				my $directory_list_aref = $manage_dirs_by->get_file_list_aref();
				my @directory_list      = @$directory_list_aref;
				my $files_number_of     = scalar @directory_list;
				my @pathNfile;

				for ( my $i = 0 ; $i < $files_number_of ; $i++ ) {

					$pathNfile[$i] = $SEARCH_DIR . '/' . $directory_list[$i];

				}

				$directory_contents[$parent][$child] = \@pathNfile;

#				print("search_directories,get_pathNfile2search,dir contents:@{$directory_contents[$parent][$child]}\n");
#
			}
		}

		my $result_aref2 = \@directory_contents;

		return ( $result_aref2, \@dimensions );
	}
	else {
		print("get_pathNfile2search, missing variable(s)\n");
		print("CHILD_DIR=$search_directories->{_CHILD_DIR}\n");
		print("GRANDPARENT_DIR=$search_directories->{_GRANDPARENT_DIR}\n");
		print("PARENT_DIR=$search_directories->{_PARENT_DIR}\n");
	}

}

#=head2 sub _get_convert_pathNfile2search
#
#Useful directories to search when
#converting old perl files to new perl
#files (> 0.7)
#
#=cut
#
#sub _get_convert_pathNfile2search {
#
#	my ($self) = @_;
#
#=head2 import modules
#
#=cut
#
#	use Carp;
#
#=head2 Instantiate modules
#
#=cut
#
#	my $manage_dirs_by = manage_dirs_by->new();
#
#=head2 Define
#
# variables
#
#=cut
#
#	my @result_aref2;
#	my @directory_contents_convert;
#	my @dimensions;
#
#=head2 Define
#
# directory search arrays
#
#=cut
#
#	my $GRANDPARENT_DIR = $path4SeismicUnixGui;
#
##	print ("search_directories,_get_convert_pathNfile2search,SeismicUnixGui = $path4SeismicUnixGui\n");
#
#	my @PARENT_DIR_CONVERT = @{ $search_directories->{_PARENT_DIR_CONVERT} };
#	my @CHILD_DIR_CONVERT  = @{ $search_directories->{_CHILD_DIR_CONVERT} };
#
#	#	print("search_directories,PARENT_DIR_CONVERT=@PARENT_DIR_CONVERT\n");
#	#	print("search_directories,CHILD_DIR_CONVERT=@CHILD_DIR_CONVERT\n");
#
#	my $parent_directory_convert_number_of = scalar @PARENT_DIR_CONVERT;
#	my $child_directory_convert_number_of  = scalar @CHILD_DIR_CONVERT;
#
#	@dimensions = (
#		$parent_directory_convert_number_of,
#		$child_directory_convert_number_of
#	);
#
#	#	$parent_directory_convert_number_of = 2;
#	#	$child_directory_convert_number_of  = 2;
#
##		print("search_directories,parent_directory_convert_number_of=$parent_directory_convert_number_of\n");
##	    print("search_directories,child_directory_convert_number_of=$child_directory_convert_number_of\n");
#
#=head2 CONVERT-related matters first
#
#=cut
#
#	for (
#		my $parent = 0 ;
#		$parent < $parent_directory_convert_number_of ;
#		$parent++
#	  )
#	{
#
#		for (
#			my $child = 0 ;
#			$child < $child_directory_convert_number_of ;
#			$child++
#		  )
#		{
#
#			my $SEARCH_DIR =
#				$GRANDPARENT_DIR . '/'
#			  . $PARENT_DIR_CONVERT[$parent] . '/'
#			  . $CHILD_DIR_CONVERT[$child];
#
#			$manage_dirs_by->set_directory($SEARCH_DIR);
#			my $directory_list_aref = $manage_dirs_by->get_file_list_aref();
#
#			if ( length $directory_list_aref ) {
#
#				$directory_contents_convert[$parent][$child] =
#				  $directory_list_aref;
#
##				  print("search_directories,print search_dir = $SEARCH_DIR\n");
##				  print("search_directories,directory_list_aref=@{$directory_list_aref}\n");
#
#			}
#			else {
#	 #				print(
#	 #"search_directories, _get_convert_pathNfile2search,missing directory\n"
#	 #				);
#	 #				print("print search_dir = $SEARCH_DIR\n");
#			}
#
#		}
#
#	}
#
##	my $parent_convert = 0;
##	my $child_convert  = 0;
##
##	print(
##"\nsearch_directories, get_pathNfile2search, For convert directory paths: $PARENT_DIR_CONVERT[$parent_convert]::$CHILD_DIR_CONVERT[$child_convert]::\n"
##	);
##
##	print("@{$directory_contents_convert[$parent_convert][$child_convert]}\n");
#
#	$result_aref2[0] = \@directory_contents_convert;
#
#	return ( \@result_aref2, \@dimensions );
#
#}
#
#=head2 sub _get_specs_pathNfile2search
#
#Useful directories to search
#
#=cut
#
#sub _get_specs_pathNfile2search {
#
#	my ($self) = @_;
#
#=head2 Instantiate modules
#
#=cut
#
#	my $manage_dirs_by = manage_dirs_by->new();
#
#=head2 Define
#
# variables
#
#=cut
#
#	my @result_aref2;
#	my @directory_contents_specs;
#	my @dimensions;
#
#=head2 Define
#
# directory search arrays
#
#=cut
#
#	my $GRANDPARENT_DIR = $path4SeismicUnixGui;
#
#	my @PARENT_DIR_SPECS = @{ $search_directories->{_PARENT_DIR_SPECS} };
#	my @CHILD_DIR_SPECS  = @{ $search_directories->{_CHILD_DIR_SPECS} };
#
#	my $parent_directory_specs_number_of = scalar @PARENT_DIR_SPECS;
#	my $child_directory_specs_number_of  = scalar @CHILD_DIR_SPECS;
#
#	@dimensions =
#	  ( $parent_directory_specs_number_of, $child_directory_specs_number_of );
#
##	print(
##		"search_directories,$parent_directory_specs_number_of, $child_directory_specs_number_of\n"
##	);
#
#=head2 SPECS-related matters
#
#=cut
#
#	for (
#		my $parent = 0 ;
#		$parent < $parent_directory_specs_number_of ;
#		$parent++
#	  )
#	{
#
#		for (
#			my $child = 0 ;
#			$child < $child_directory_specs_number_of ;
#			$child++
#		  )
#		{
#
#			my $SEARCH_DIR =
#				$GRANDPARENT_DIR . '/'
#			  . $PARENT_DIR_SPECS[$parent] . '/'
#			  . $CHILD_DIR_SPECS[$child];
#
##  			print(
##  "search_directories, _get_specs_pathNfile2search,SEARCH_DIR=$SEARCH_DIR\n"
##  			);
#			$manage_dirs_by->set_directory($SEARCH_DIR);
#			my $directory_list_aref = $manage_dirs_by->get_file_list_aref();
#			my @directory_list      = @$directory_list_aref;
#
#			$directory_contents_specs[$parent][$child] = $directory_list_aref;
#
#			#			print("@{$directory_contents_specs[$parent][$child]}\n");
#
#		}
#
#	}
#
##	my $parent_specs = 1;
##	my $child_specs  = 1;
##	print(
##"\nsearch_directories, get_pathNfile2search, For specs directory paths: $PARENT_DIR_GUI[$parent_specs]::$CHILD_DIR_GUI[$child_gui]::\n"
##	);
##	print("@{$directory_contents_specs[$parent_specs][$child_specs]}\n");
#
#	$result_aref2[0] = \@directory_contents_specs;
#
#	return ( \@result_aref2, \@dimensions );
#
#}
#
#=head2 sub _get_tools_pathNfile2search
#
#Useful directories to search
#
#=cut
#
#sub _get_tools_pathNfile2search {
#
#	my ($self) = @_;
#
#=head2 Instantiate modules
#
#=cut
#
#	my $manage_dirs_by = manage_dirs_by->new();
#
#=head2 Define
#
# variables
#
#=cut
#
#	my @result_aref2;
#	my @directory_contents_tools;
#	my @dimensions;
#
#=head2 Define
#
# directory search arrays
#
#=cut
#
#	my $GRANDPARENT_DIR = $path4SeismicUnixGui;
#
#	#	my @PARENT_DIR_GUI = @{ $search_directories->{_PARENT_DIR_GUI} };
#	#	my @CHILD_DIR_GUI  = @{ $search_directories->{_CHILD_DIR_GUI} };
#	my @PARENT_DIR_TOOLS = @{ $search_directories->{_PARENT_DIR_TOOLS} };
#	my @CHILD_DIR_TOOLS  = @{ $search_directories->{_CHILD_DIR_TOOLS} };
#
#	#	my @PARENT_DIR_SU  = @{ $search_directories->{_PARENT_DIR_SU} };
#	#	my @CHILD_DIR_SU   = @{ $search_directories->{_CHILD_DIR_SU} };
#	#	my @PARENT_DIR_GEN = @{ $search_directories->{_PARENT_DIR_GEN} };
#
#	#	print("PARENT_DIR_GUI=@PARENT_DIR_GUI\n");
#
#	#	my $parent_directory_gui_number_of = scalar @PARENT_DIR_GUI;
#	#	my $child_directory_gui_number_of  = scalar @CHILD_DIR_GUI;
#	my $parent_directory_tools_number_of = scalar @PARENT_DIR_TOOLS;
#	my $child_directory_tools_number_of  = scalar @CHILD_DIR_TOOLS;
#
#	#	my $parent_directory_su_number_of  = scalar @PARENT_DIR_SU;
#	#	my $child_directory_su_number_of   = scalar @CHILD_DIR_SU;
#	#	my $parent_directory_gen_number_of = scalar @PARENT_DIR_GEN;
#
#	@dimensions =
#	  ( $parent_directory_tools_number_of, $child_directory_tools_number_of );
#
#	#	$parent_directory_su_number_of, $child_directory_su_number_of,
#	#	  $parent_directory_gen_number_of $parent_directory_gui_number_of,
#	#	  $child_directory_gui_number_of,
#
#=head2 TOOLS-related matters first
#
#=cut
#
#	for (
#		my $parent = 0 ;
#		$parent < $parent_directory_tools_number_of ;
#		$parent++
#	  )
#	{
#
#		for (
#			my $child = 0 ;
#			$child < $child_directory_tools_number_of ;
#			$child++
#		  )
#		{
#
#			my $SEARCH_DIR =
#				$GRANDPARENT_DIR . '/'
#			  . $PARENT_DIR_TOOLS[$parent] . '/'
#			  . $CHILD_DIR_TOOLS[$child];
#
##  			print(
##  "search_directories, _get_tools_pathNfile2search,SEARCH_DIR=$SEARCH_DIR\n"
##  			);
#			$manage_dirs_by->set_directory($SEARCH_DIR);
#			my $directory_list_aref = $manage_dirs_by->get_file_list_aref();
#			my @directory_list      = @$directory_list_aref;
#
#			$directory_contents_tools[$parent][$child] = $directory_list_aref;
#
#			#			print("@{$directory_contents_TOOLS[$parent][$child]}\n");
#
#		}
#
#	}
#
##	my $parent_TOOLS = 1;
##	my $child_TOOLS  = 1;
##	print(
##"\nsearch_directories, get_tools_pathNfile2search, For TOOLS directory paths: $PARENT_DIR_TOOLS[$parent_TOOLS]::$CHILD_DIR_TOOLS[$child_tools]::\n"
##	);
##	print("@{$directory_contents_tools[$parent_tools][$child_tools]}\n");
#
#	$result_aref2[0] = \@directory_contents_tools;
#
#	return ( \@result_aref2, \@dimensions );
#
#}
#
#=head2 Find a path for
#
#a given perl file
#generated by the convert
#
#=cut
#
#sub get_path4convert_file {
#
#	my (@self) = @_;
#
#	if ( length $search_directories->{_file_name} ) {
#
#		my $file_name = $search_directories->{_file_name};
#		my $result;
#
#=head2 Collect parameters from local hash
#
#=cut
#
#		my $GRANDPARENT_DIR = $path4SeismicUnixGui;
#		my @PARENT_DIR_CONVERT =
#		  @{ $search_directories->{_PARENT_DIR_CONVERT} };
#		my @CHILD_DIR_CONVERT =
#		  @{ $search_directories->{_CHILD_DIR_CONVERT} };
#
#=head2 Collect relevant "convert"
#
# project paths and files
#
#=cut
#
#		my ( $result_aref3, $dimensions_aref ) =
#		  _get_convert_pathNfile2search();
#		my @result_aref2                       = @$result_aref3;
#		my @directory_contents_convert         = @{ $result_aref2[0] };
#		my @dimension                          = @$dimensions_aref;
#		my $parent_directory_convert_number_of = $dimension[0];
#		my $child_directory_convert_number_of  = $dimension[1];
#
## test
##		my $parent_convert = 0;
##		my $child_convert  = 0;
##		print(
##"\nsearch_directories,get_path4convert_file, For convert directory paths: App::SeismicUnixGui::$PARENT_DIR_CONVERT[$parent_convert]::$CHILD_DIR_CONVERT[$child_convert]\n"
##		);
##		print(
##			"_SU_global_constants,get_path4convert_file,@{$directory_contents_convert[$parent_convert][$child_convert]}\n"
##		);
#
#=head2 Search all "convert"-relevant
#
#directories start with
#convert derectory listing
#
#=cut
#
#		for (
#			my $parent = 0 ;
#			$parent < $parent_directory_convert_number_of ;
#			$parent++
#		  )
#		{
#
#			for (
#				my $child = 0 ;
#				$child < $child_directory_convert_number_of ;
#				$child++
#			  )
#			{
#
#				my $directory_list_aref =
#				  $directory_contents_convert[$parent][$child];
#
#				if ( length $directory_list_aref ) {
#
#					my @directory_list        = @$directory_list_aref;
#					my $length_directory_list = scalar @directory_list;
#
#	   #					print(
#	   #"L_SU_global_contents,@{$directory_contents_convert[$parent][$child]}\n"
#	   #					);
#	   #					print("L_SU_global_contents,file_name=$file_name\n");
#
#					for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#	#						print("search_directories, directory list=$directory_list[$i]\n");
#						;
#						if ( not $file_name eq $directory_list[$i] ) {
#
#							next;
#
#						}
#						elsif ( $file_name eq $directory_list[$i] ) {
#
#	  #							print(
#	  #"search_directories,get_path4convert_file,found the file $file_name in
#	  #	   					$PARENT_DIR_CONVERT[$parent]::$CHILD_DIR_CONVERT[$child]\n"
#	  #							);
#							$result =
#								$path4SeismicUnixGui . '/'
#							  . $PARENT_DIR_CONVERT[$parent] . '/'
#							  . $CHILD_DIR_CONVERT[$child];
#
#							return ($result);
#						}
#						else {
#							print("change_a_line, unexpected value\n");
#							return ();
#						}
#					}
#
#				}
#				else {
##					print(
##						"search_directories, get_path4convert_file, missing directory; NADA\n"
##					);
#				}
#
#			}
#		}
#
#	}
#	else {
#		print(
#			"search_directories,_get_path_4convert_file,file_name_missing\n"
#		);
#		return ();
#	}
#}
#
#=head2 sub get_path4spec_file
#
#Find a path for
#
#a given spec file
#
#=cut
#
#sub get_path4spec_file {
#
#	my (@self) = @_;
#
#	if ( length $search_directories->{_file_name} ) {
#
#		my $file_name = $search_directories->{_file_name};
#		my $result;
#
#=head2 Collect parameters from local hash
#
#=cut
#
#		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
#		my @PARENT_DIR_SPECS = @{ $search_directories->{_PARENT_DIR_SPECS} };
#		my @CHILD_DIR_SPECS  = @{ $search_directories->{_CHILD_DIR_SPECS} };
#
#=head2 Collect relevant "spec"
#
# project paths and files
#
#=cut
#
#		my ( $result_aref3, $dimensions_aref ) = _get_specs_pathNfile2search();
#		my @result_aref2                     = @$result_aref3;
#		my @directory_contents_specs         = @{ $result_aref2[0] };
#		my @dimension                        = @$dimensions_aref;
#		my $parent_directory_specs_number_of = $dimension[0];
#		my $child_directory_specs_number_of  = $dimension[1];
#
## test
##		my $parent_specs = 1;
##		my $child_specs  = 1;
##		print(
##"\nFor specs directory paths: $PARENT_DIR_SPECS[$parent_specs]::$CHILD_DIR_SPECS[$child_specs]::\n"
##		);
##		print("@{$directory_contents_specs[$parent_specs][$child_specs]}\n");
#
#=head2 Search all "spec"-relevant
#
#directories start with
#gui drectory listing
#
#=cut
#
#		for (
#			my $parent = 0 ;
#			$parent < $parent_directory_specs_number_of ;
#			$parent++
#		  )
#		{
#
#			for (
#				my $child = 0 ;
#				$child < $child_directory_specs_number_of ;
#				$child++
#			  )
#			{
#
#				my $directory_list_aref =
#				  $directory_contents_specs[$parent][$child];
#				my @directory_list = @$directory_list_aref;
#
#				my $length_directory_list = scalar @directory_list;
#
#				#				print("@{$directory_contents_specs[$parent][$child]}\n");
#				#				print("file_name=$file_name\n");
#				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#					if ( not $file_name eq $directory_list[$i] ) {
#
#						next;
#
#					}
#					elsif ( $file_name eq $directory_list[$i] ) {
#
#		 #						print(
#		 #"search_directories,get_path4spec_file,found the file $file_name in
#		 #				  			  $PARENT_DIR_SPECS[$parent]::$CHILD_DIR_SPECS[$child]\n"
#		 #						);
#						$result =
#							$path4SeismicUnixGui . '/'
#						  . $PARENT_DIR_SPECS[$parent] . '/'
#						  . $CHILD_DIR_SPECS[$child];
#
#						return ($result);
#					}
#					else {
#						print("change_a_line, unexpected value\n");
#						return ();
#					}
#				}
#
#			}
#		}
#
#	}
#	else {
#		print("search_directories,_get_path4spec_file,file_name_missing\n");
#		return ();
#	}
#}
#
#=head2 Find a path for
#
#a given tools file
#You need to pre-determine
#you have a "Tools" file
#
#=cut
#
#sub get_path4tools_file {
#
#	my (@self) = @_;
#
#	if ( length $search_directories->{_file_name} ) {
#
#		my $file_name = $search_directories->{_file_name};
#		my $result;
#
#=head2 Collect parameters from local hash
#
#=cut
#
#		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
#		my @PARENT_DIR_TOOLS = @{ $search_directories->{_PARENT_DIR_TOOLS} };
#		my @CHILD_DIR_TOOLS  = @{ $search_directories->{_CHILD_DIR_TOOLS} };
#
#=head2 Collect relevant "tools"
#
# project paths and files
#
#=cut
#
#		my ( $result_aref3, $dimensions_aref ) = _get_tools_pathNfile2search();
#		my @result_aref2                     = @$result_aref3;
#		my @directory_contents_tools         = @{ $result_aref2[0] };
#		my @dimension                        = @$dimensions_aref;
#		my $parent_directory_tools_number_of = $dimension[0];
#		my $child_directory_tools_number_of  = $dimension[1];
#
## test
##		my $parent_tools = 1;
##		my $child_tools  = 1;
##		print(
##"\nFor tools directory paths: $PARENT_DIR_TOOLS[$parent_tools]::$CHILD_DIR_TOOLS[$child_tools]::\n"
##		);
##		print("@{$directory_contents_tools[$parent_tools][$child_tools]}\n");
#
#=head2 Search all "spec"-relevant
#
#directories start with
#gui drectory listing
#
#=cut
#
#		for (
#			my $parent = 0 ;
#			$parent < $parent_directory_tools_number_of ;
#			$parent++
#		  )
#		{
#
#			for (
#				my $child = 0 ;
#				$child < $child_directory_tools_number_of ;
#				$child++
#			  )
#			{
#
#				my $directory_list_aref =
#				  $directory_contents_tools[$parent][$child];
#				my @directory_list = @$directory_list_aref;
#
#				my $length_directory_list = scalar @directory_list;
#
#				#				print("@{$directory_contents_tools[$parent][$child]}\n");
#				#				print("file_name=$file_name\n");
#				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#					if ( not $file_name eq $directory_list[$i] ) {
#
#						next;
#
#					}
#					elsif ( $file_name eq $directory_list[$i] ) {
#
#		#						print(
#		#"search_directories,get_path4tools_file,found the file $file_name in
#		#				  			  $PARENT_DIR_TOOLS[$parent]::$CHILD_DIR_TOOLS[$child]\n"
#		#						);
#						$result =
#							$path4SeismicUnixGui . '/'
#						  . $PARENT_DIR_TOOLS[$parent] . '/'
#						  . $CHILD_DIR_TOOLS[$child];
#
#						return ($result);
#					}
#					else {
#						print("change_a_line, unexpected value\n");
#						return ();
#					}
#				}
#
#			}
#		}
#
#	}
#	else {
#		print("search_directories,_get_path4tools_file,file_name_missing\n");
#		return ();
#	}
#}

#sub set_file_name {
#
#	my ( $self, $file_name ) = @_;
#
#	if ( length $file_name ) {
#
#		$search_directories->{_file_name} = $file_name;
#
##		print("search_directories,set_file_name,set_file_name = $search_directories->{_file_name}\n");
#
#	}
#	else {
#		print("search_directories,set_file_name,missing variable");
#	}
#
#}
#

=head2 sub set_CHILD_DIR_type

=cut

sub set_CHILD_DIR_type {

	my ( $self, $type ) = @_;

	if ( length $type ) {

		my $CHILD_DIR = '_CHILD_DIR_' . $type;

		$search_directories->{_CHILD_DIR} = $search_directories->{$CHILD_DIR};

#		print(
#"search_directories,set_CHILD_DIR,set_CHILD_DIR_type = @{$search_directories->{_CHILD_DIR}}\n"
#		);

	}
	else {
		print(
"search_directories,set_CHILD_DIR_type, type=$type is missing variable"
		);
	}

}

=head2 sub set_GRANDPARENT_DIR

=cut

sub set_GRANDPARENT_DIR {

	my ( $self, $GRANDPARENT_DIR ) = @_;

	if ( length $GRANDPARENT_DIR ) {

		$search_directories->{_GRANDPARENT_DIR} = $GRANDPARENT_DIR;

#		print("search_directories,set_GRANDPARENT_DIR,set_GRANDPARENT_DIR = $search_directories->{_GRANDPARENT_DIR}\n");

	}
	else {
		print("search_directories,set_GRANDPARENT_DIR,missing variable");
	}

}

=head2 sub set_PARENT_DIR_type

=cut

sub set_PARENT_DIR_type {

	my ( $self, $type ) = @_;

	if ( length $type ) {

		my $PARENT_DIR = '_PARENT_DIR_' . $type;
		$search_directories->{_PARENT_DIR} = $search_directories->{$PARENT_DIR};

#		print(
#"search_directories,set_PARENT_DIR,set_PARENT_DIR_type = @{$search_directories->{_PARENT_DIR}}\n"
#		);

	}
	else {
		print(
"search_directories,set_PARENT_DIR_type, type=$type is missing variable"
		);
	}

}

#=head2 sub set_program_name
#
#=cut
#
#sub set_program_name {
#
#	my ( $self, $program_name ) = @_;
#
#	if ( length $program_name ) {
#
#		$search_directories->{_program_name} = $program_name;
#
#	}
#	else {
#		carp "missing program_name";
#		print("search_directories,set_program_name,missing program_name\n");
#	}
#
#}

1;
