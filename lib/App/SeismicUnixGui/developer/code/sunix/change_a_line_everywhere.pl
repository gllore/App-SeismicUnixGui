
=head2 SYNOPSIS

PACKAGE NAME: change_a_line_everywhere

AUTHOR:  

DATE: Jun 15 2022

DESCRIPTION: replace Perl directory
structure within all files

Version: 0.1

=head2 USE

=head3 NOTES

The is a grandparent:parent:child relationship for
two of the sets of directories

but only a grandparent:parent relationship for the
remaining third directory set.

Based on change_a_line V0.1

=head4 Examples

=head2 SYNOPSIS

Look at every file with a .pm and .pl extension
Requires looking at all files within the 
following categories (See L_SU_global_constants) 
SU, GEN, SPECS, GUI

1. for each of 4 categories get
CATEGORY[ABS_PATHs][FILmy $line2find_use = '\s*use\s';E_NAMEs] = 'full path and file name'
(from L_SU_global_constants)

2. Search every file for the lines of interest (loi)
CATEGORY_lines_of_interest[ABS_PATHs][FILE_NAMES] = array_ref 
e.g.: lines 1 and 2
	slurp file
	test every line
	write loi to array

3. For each CATEGORY[ABS_PATHs][FILE_NAMEs],look at loi
	slurp file again
	
	  Review conditions
	   Replace the line with proper hierarchy
	    relative_path::file_name
       Add other special lines
       
     replace old with new file
    
=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.2';

use aliased 'App::SeismicUnixGui::misc::manage_dirs_by';
use aliased 'App::SeismicUnixGui::misc::manage_files_by2';
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';

my $manage_dirs_by   		= manage_dirs_by->new();
my $manage_files_by2 		= manage_files_by2->new();
my $L_SU_global_constants 	= L_SU_global_constants->new();


=head2 Important definitions

=cut

my $line2find_use = '\s*use\s';

=head2 Important definitions 

of directory structure

=cut 

my $SeismicUnixGui 	= 'App-SeismicUnixGui/lib/App/SeismicUnixGui';
my $PL_DIR 			= '/usr/local/pl';
my $GRANDPARENT_DIR = $PL_DIR . '/' . $SeismicUnixGui;


=head2 Get all the files and their paths

from the SU category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('SU');
$L_SU_global_constants->set_PARENT_DIR_type('SU');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ($su_pathNfile_aref, $su_dimension_aref ) = $L_SU_global_constants->get_pathNfile2search();


=head2 Get all the files and their full paths

from the GEN category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('GEN');
$L_SU_global_constants->set_PARENT_DIR_type('GEN');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ($gen_pathNfile_aref, $gen_dimension_aref ) = $L_SU_global_constants->get_pathNfile2search();


=head2 Get all the files and their full paths

from the SPECS category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('SPECS');
$L_SU_global_constants->set_PARENT_DIR_type('SPECS');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ($specs_pathNfile_aref, $specs_dimension_aref ) = $L_SU_global_constants->get_pathNfile2search();


=head2 Get all the files and their full paths

from the GUI category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('GUI');
$L_SU_global_constants->set_PARENT_DIR_type('GUI');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ($gui_pathNfile_aref, $gui_dimension_aref ) = $L_SU_global_constants->get_pathNfile2search();


=head2 search for lines of interest

in SU-type files

=cut 

my @dimension_su 				  = @$su_dimension_aref;
my $parent_directory_su_number_of = $dimension_su[0];
my $child_directory_su_number_of  = $dimension_su[1];

print("parent_directory_su_number_of=$parent_directory_su_number_of\n");
print("child_directory_su_number_of=$child_directory_su_number_of\n");

my @su_pathNfile              = @$su_pathNfile_aref;
my $parent_dir                = 0;
my $child_dir				  = 0;
my @array                     = @{$su_pathNfile[$parent_dir][$child_dir]};

foreach my $pathNfile (@array) {
	print("pathNfile, SU-type pathNfile=$pathNfile\n");
}


=head2 search for lines of interest

in GEN-type files

=cut 

my @dimension_gen 				   = @$gen_dimension_aref;
my $parent_directory_gen_number_of = $dimension_gen[0];
my $child_directory_gen_number_of  = $dimension_gen[1];

#print("parent_directory_gen_number_of=$parent_directory_gen_number_of\n");
#print("child_directory_gen_number_of=$child_directory_gen_number_of\n");


=head2 search for lines of interest

in SPECS-type files

=cut 

my @dimension_specs 				 = @$specs_dimension_aref;
my $parent_directory_specs_number_of = $dimension_specs[0];
my $child_directory_specs_number_of  = $dimension_specs[1];

#print("parent_directory_specs_number_of=$parent_directory_specs_number_of\n");
#print("child_directory_specs_number_of=$child_directory_specs_number_of\n");


=head2 search for lines of interest

in GUI-type files

=cut 

my @dimension_gui 				   = @$gui_dimension_aref;
my $parent_directory_gui_number_of = $dimension_gui[0];
my $child_directory_gui_number_of  = $dimension_gui[1];
#print("parent_directory_gui_number_of=$parent_directory_gui_number_of\n");
#print("child_directory_gui_number_of=$child_directory_gui_number_of\n");


=head2 private shared hash

=cut

my $change_a_line = {

	_file_name => '',

};
#
## Files in 3 subdirectories
#my $result_aref3           = _get_files4directories();
#my @result_aref2           = @$result_aref3;
#my @directory_contents_gui = @{ $result_aref2[0] };
#my @directory_contents_su  = @{ $result_aref2[1] };
#my @directory_contents_gen = @{ $result_aref2[2] };

=head2 Start

with gui-related directories

=cut


#}    # for each file in one subdirectory


=head2 Step1

Search SU-based directories

=cut


=head2 Step3

GEN-based directories

No children. Only grandparent and parent

=cut

#for (
#	my $parent = 0, my $count = 0 ;
#	$parent < $parent_directory_gen_number_of ;
#	$parent++
#  )
#{
#	# print("starting inner count=$count; parent=$parent\n");
#	my $directory_list_aref = $directory_contents_gen[$parent];
#	my @directory_list      = @$directory_list_aref;
#	my $list_length         = scalar @directory_list;
#
#	my $path = $GRANDPARENT_DIR . '/' . $PARENT_DIR_GEN[$parent] . '/';
#
#	for ( my $i = 0, my $j = $count ; $i < $list_length ; $i++, $j++ ) {
#
#		$file4gen[$j] = $directory_list[$i];
#		$path4gen[$j] = $path;
#		$count        = $j;
#
#		# print ("count=$count\n");
#
#	}
#
#	# print("@{$directory_contents_gen[$parent][$child]}\n");
#
#	#		print("file4gen[count]=$file4gen[$count]\n");
#
#}
#
#my $path4gen_number_of = scalar @path4gen;
#my $file4gen_number_of = scalar @file4gen;    # should be the same
#
## $path4gen_number_of
## fix this number to a low value when testing
#
#for ( my $i = 0 ; $i < $path4gen_number_of ; $i++ ) {
#
#	#CASES: *.pm files, *.pl files
#	# immodpg is fortran binary
#	# su_param.pm is weird
#	print("\n######## WORKING on $path4gen[$i]/$file4gen[$i] ######## \n");
#
#	if (
#		$file4gen[$i] ne 'immodpg.out'
#		and $file4gen[$i] ne 'su_param.pm'		
#		and (  $file4gen[$i] =~ m/\.pm/
#			or $file4gen[$i] =~ m/\.pl/ )
#	  )
#	{
#		# SKIP files fortran binary file
#
#		$manage_files_by2->set_file_in( $file4gen[$i] );
#		$manage_files_by2->set_directory( $path4gen[$i] );
#		my $inbound         = $path4gen[$i] . '/' . $file4gen[$i];
#		my $slurp_ref       = manage_files_by2->get_whole($inbound);
#		my @slurp           = @$slurp_ref;
#		my $length_of_slurp = scalar @slurp;
#
#		print("length of slurp = $length_of_slurp\n");
#		print("inbound=$inbound\n");
#
#		for ( my $j = 0 ; $j < $length_of_slurp ; $j++ ) {
#
#			#CASE within each *.pm file
#
#			# print("change_a_line, slurp=slurp[$j]\n");
#			my $string = $slurp[$j];
#			chomp $string;    # remove all newlines
#			my @next_string;
#			my @raw_string;
#			my $module_name;
#
#			if ( $string =~ m/$line2find_use/ ) {
#
#				my $version;
#				$string =~ s/;//;
#				$string =~ s/\(\)//;
#				my @temp_string = split( /\s+/, $string );
#				my $line        = $j + 1;
#
#				if ( $temp_string[1] eq 'use' ) {
#
#					$module_name = $temp_string[2];
#					print(
#"Fixed: module name within $file4gen[$i]=$module_name...\n"
#					);
#
#				}
#				elsif ( $temp_string[0] eq 'use' ) {
#
#					$module_name = $temp_string[1];
#					print("module name within $file4gen[$i]=$module_name...\n");
#
#				}
#				else {
#					# CATCH the UNUSUAL
#					my $string_number_of = scalar @temp_string;
#					print("change_a_line, unexpected module name\n");
#					print("\nchange_a_line, string=$string \n");
#					print(
#						"change_a_line, string_number_of=$string_number_of\n");
#					print("change_a_line, temp_string=@temp_string \n");
#					print("change_a_line, temp_string[0]=$temp_string[0] \n");
#					print("change_a_line, temp_string[1]=$temp_string[1] \n");
#					$module_name = 'null';
#				}
#
#				my $string_number_of = scalar @temp_string;
#
#				# exceptions to the search for am module name
#				if (   $module_name eq 'Moose'
#					or $module_name eq ' #'
#					or $module_name eq 'null' )
#				{
#
#					print("$module_name will be skipped\n");
#
#				}
#
#				#			print(
#				#							"change_a_line,found\n $string at line# $line \n
#				#								 in $path4gen[$i]/$file4gen[$i]\n"
#				#						);
#
#				else {
#
#					print("module name = $module_name\n");
#					my $full_module_name = $module_name . '.pm';
#					_set_file_name($full_module_name);
#					my $module_path = _get_path4file();
#
#					if ( length $module_path ) {
#
#						# CASE with version numbers; e.g. use module version
#						if ( $string_number_of == 3 ) {
#
#							$version = $temp_string[2];
#
#							# print(" version=$version\n");
#
#							if ( $version =~ m/\d+\.\d+.\d+/ ) {
#
#								my $new_version = ("'$version'");
#
#								#prepare output
#								$string =~ s/;//;
#								$string =~ s/use\s/use $module_path/g;
#								$string =~ s/$version/$new_version/g;
#
#					 #							print("change_a_line, new version=$new_version\n");
#								$slurp[$j] = $string . ';';
#
#								#							print("substitute line=$slurp[$j]\n");
#
#							}
#
#						}
#						elsif ( $string_number_of <= 2 ) {
#
#							# CASE: No version number
#
#					   #	print(
#					   #	"change_a_line,found $file4gen[$i] in $module_path\n");
#
#							#prepare output
#							$string =~ s/;//;
#							$string =~ s/use\s/use $module_path/g;
#
#							# print("substitute line=$string;\n");
#							$slurp[$j] = $string . ';';
#
#							# print("substitute line=$slurp[$j]\n");
#
#						}
#						elsif ( $string_number_of > 3 ) {
#
#							# CASE: SeismicUnix imports many variables
#
#							#prepare output
#							$string =~ s/;//;
#							$string =~ s/use\s/use $module_path/g;
#
#							# print("substitute line=$string;\n");
#							$slurp[$j] = $string . ';';
#
#							# print("substitute line=$slurp[$j]\n");
#
#						}
#						else {
#							print("change_a_line, unexpected\n");
#						}
#
#					}    # module path exists
#
#					else {
#						print(
#"change_a_line, did not find a match for module name\n"
#						);
#					}
#				}
#			}
#			else {    # for each line in a slurp
#					  #print("change_a_line, skip line\n");
#			}
#		}    # for each line in a slurped file
#
#		# write out the corrected or uncorrected file
#		my $number_of_lines = $length_of_slurp;
#
#		my $outbound = $path4gen[$i] . '/' . $file4gen[$i];
#
#		print("writing to $outbound\n");
#		print("number of lines in output file = $number_of_lines\n");
#		if ( $number_of_lines == 0 ) {
#
#			print("change_a_line, unexpected empty file\n");
#			print("Hit Enter to continue\n");
#			<STDIN>;
#
#		}
#		elsif ( $number_of_lines > 0 ) {
#
##			print "Press ENTER to write a new file with a changed line";
##			<STDIN>;
#
#			open( OUT, ">$outbound" )
#			  or die("File $file4gen[$i] not found");
#
#			# add \n!!!!
#			for ( my $i = 0 ; $i < $number_of_lines ; $i++ ) {
#
#				printf OUT $slurp[$i] . "\n";
#
#			}
#			close(OUT);
#		}
#		else {
#			print("change_a_line, unexpected empty file\n");
#		}
#
#	}
#	else {
#		print(" skipping an unwanted file\n");
#	}
#
#}    # for each file in one subdirectory
#
##########################################################################
#
#sub _get_files4directories {
#
#	my ($self) = @_;
#
#	my @result_aref2;
#
#=head2 SEARCH GUI-related matters first
#
#=cut
#
#	my $parent_directory_gui_number_of = scalar @PARENT_DIR_GUI;
#	my $child_directory_gui_number_of  = scalar @CHILD_DIR_GUI;
#
#	my @directory_contents_gui;
#
#	for (
#		my $parent = 0 ;
#		$parent < $parent_directory_gui_number_of ;
#		$parent++
#	  )
#	{
#
#		for (
#			my $child = 0 ;
#			$child < $child_directory_gui_number_of ;
#			$child++
#		  )
#		{
#
#			my $SEARCH_DIR =
#				$GRANDPARENT_DIR . '/'
#			  . $PARENT_DIR_GUI[$parent] . '/'
#			  . $CHILD_DIR_GUI[$child];
#
#			$manage_dirs_by->set_directory($SEARCH_DIR);
#			my $directory_list_aref = $manage_dirs_by->get_list_aref();
#			my @directory_list      = @$directory_list_aref;
#
#			$directory_contents_gui[$parent][$child] = $directory_list_aref;
#
#			#		print("@{$directory_contents_gui[$parent][$child]}\n");
#
#		}
#	}
#
##	my $parent_gui = 1;
##	my $child_gui  = 1;
##	print(
##"\nFor gui directory paths: $PARENT_DIR_GUI[$parent_gui]::$CHILD_DIR_GUI[$child_gui]::\n"
##	);
##	print("@{$directory_contents_gui[$parent_gui][$child_gui]}\n");
#
#	$result_aref2[0] = \@directory_contents_gui;
#
#=head2 SEARCH SU-related matters first
#
#=cut
#
#	my $parent_directory_su_number_of = scalar @PARENT_DIR_SU;
#	my $child_directory_su_number_of  = scalar @CHILD_DIR_SU;
#
#	my @directory_contents_su;
#
#	for (
#		my $parent = 0 ;
#		$parent < $parent_directory_su_number_of ;
#		$parent++
#	  )
#	{
#
#		for (
#			my $child = 0 ;
#			$child < $child_directory_su_number_of ;
#			$child++
#		  )
#		{
#
#			my $SEARCH_DIR =
#				$GRANDPARENT_DIR . '/'
#			  . $PARENT_DIR_SU[$parent] . '/'
#			  . $CHILD_DIR_SU[$child];
#
#			$manage_dirs_by->set_directory($SEARCH_DIR);
#			my $directory_list_aref = $manage_dirs_by->get_list_aref();
#			my @directory_list      = @$directory_list_aref;
#
#			$directory_contents_su[$parent][$child] = $directory_list_aref;
#
#			#		print("@{$directory_contents_gui[$parent][$child]}\n");
#
#		}
#	}
#
## test
##	my $parent_su = 0;
##	my $child_su  = 1;
##	print(
##"\nFor su directory paths: $PARENT_DIR_SU[$parent_su]::$CHILD_DIR_SU[$child_su]::\n"
##	);
##	print("@{$directory_contents_su[$parent_su][$child_su]}\n");
#
#	$result_aref2[1] = \@directory_contents_su;
#
#=head2 SEARCH general matters last
#
#=cut
#
#	my $parent_directory_gen_number_of = scalar @PARENT_DIR_GEN;
#	my @directory_contents_gen;
#
#	for (
#		my $parent = 0 ;
#		$parent < $parent_directory_gen_number_of ;
#		$parent++
#	  )
#	{
#
#		my $SEARCH_DIR = $GRANDPARENT_DIR . '/' . $PARENT_DIR_GEN[$parent];
#
#		$manage_dirs_by->set_directory($SEARCH_DIR);
#		my $directory_list_aref = $manage_dirs_by->get_list_aref();
#		my @directory_list      = @$directory_list_aref;
#
#		$directory_contents_gen[$parent] = $directory_list_aref;
#
#	}
#
#	#	my $parent_gen = 5;
#	#	print("\nFor general directory paths: $PARENT_DIR_GEN[$parent_gen]::\n");
#	#	print("@{$directory_contents_gen[$parent_gen]}\n");
#
#	$result_aref2[2] = \@directory_contents_gen;
#
#	return ( \@result_aref2 );
#
#}
#
#=head2 Find a path given a file
#
#=cut
#
#sub _get_path4file {
#
#	my (@self) = @_;
#
#	if ( length $change_a_line->{_file_name} ) {
#
#		my $file_name = $change_a_line->{_file_name};
#		my $result;
#
#		my $result_aref3 = _get_files4directories();
#
#		my @result_aref2           = @$result_aref3;
#		my @directory_contents_gui = @{ $result_aref2[0] };
#		my @directory_contents_su  = @{ $result_aref2[1] };
#		my @directory_contents_gen = @{ $result_aref2[2] };
#
## test  For @directory_contents_gui
##	my $parent = 0;
##	my $child  = 0;
##	print @{ $directory_contents_gui[$parent][$child] };
##	print(
##"\nFull path is $GRANDPARENT_DIR . '/' . $PARENT_DIR_GUI[$parent] . '/'. $CHILD_DIR_GUI[$child]"
##	);
#
### test For @directory_contents_su
##	my $parent_su = 0;
##	my $child_su  = 0;
##	print @{ $directory_contents_su[$parent_su][$child_su] };
##	print(
##"\nFull path is $GRANDPARENT_DIR . '/' . $PARENT_DIR_GUI[$parent_su] . '/'. $CHILD_DIR_GUI[$child_su]"
##	);
##
## test For @directory_contents_general
##	my $parent_gen= 0;
##	print @{ $directory_contents_gen[$parent_gen] };
##	print(
##"\nFull path is $GRANDPARENT_DIR . '/' . $PARENT_DIR_GUI[$parent_gen] "
##	);
#
#		my $parent_directory_gui_number_of = scalar @PARENT_DIR_GUI;
#		my $child_directory_gui_number_of  = scalar @CHILD_DIR_GUI;
#		my $parent_directory_su_number_of  = scalar @PARENT_DIR_SU;
#		my $child_directory_su_number_of   = scalar @CHILD_DIR_SU;
#		my $parent_directory_gen_number_of = scalar @PARENT_DIR_GEN;
#
#=head2 Search all directory listings
#
#start with gui drectory listings
#
#=cut
#
#		for (
#			my $parent = 0 ;
#			$parent < $parent_directory_gui_number_of ;
#			$parent++
#		  )
#		{
#
#			for (
#				my $child = 0 ;
#				$child < $child_directory_gui_number_of ;
#				$child++
#			  )
#			{
#
#				my $directory_list_aref =
#				  $directory_contents_gui[$parent][$child];
#				my @directory_list = @$directory_list_aref;
#
#				my $length_directory_list = scalar @directory_list;
#
#				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#					if ( not $file_name eq $directory_list[$i] ) {
#
#						next;
#
#					}
#					elsif ( $file_name eq $directory_list[$i] ) {
#
#				  #						print(
#				  #"change_a_line,_get_path4file,found the file $file_name in
#				  #			  					$PARENT_DIR_GUI[$parent]::$CHILD_DIR_GUI[$child]\n"
#				  #						);
#						$result =
#							$SeismicUnixGui . '::'
#						  . $PARENT_DIR_GUI[$parent] . '::'
#						  . $CHILD_DIR_GUI[$child] . '::';
#					}
#					else { print("change_a_line, unexpected value\n") }
#				}
#
#			}
#		}
#
#		# next su directory listings
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
#				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#					if ( not $file_name eq $directory_list[$i] ) {
#
#						next;
#
#					}
#					elsif ( $file_name eq $directory_list[$i] ) {
#
#					 #						print(
#					 #"change_a_line,_get_path4file,found the file $file_name in
#					 #					$PARENT_DIR_SU[$parent]::$CHILD_DIR_SU[$child]::\n"
#					 #						);
#						$result =
#							$SeismicUnixGui . '::'
#						  . $PARENT_DIR_SU[$parent] . '::'
#						  . $CHILD_DIR_SU[$child] . '::';
#					}
#					else { print("change_a_line, unexpected value\n") }
#				}
#
#			}
#		}
#
#		# finally general directory listings
#
#		for (
#			my $parent = 0 ;
#			$parent < $parent_directory_gen_number_of ;
#			$parent++
#		  )
#		{
#
#			my $directory_list_aref = $directory_contents_gen[$parent];
#			my @directory_list      = @$directory_list_aref;
#
#			my $length_directory_list = scalar @directory_list;
#
#			for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {
#
#				if ( not $file_name eq $directory_list[$i] ) {
#
#					next;
#
#				}
#				elsif ( $file_name eq $directory_list[$i] ) {
#
#					#					print(
#					#"change_a_line,_get_path4file,found the file $file_name in
#					#					$PARENT_DIR_GEN[$parent]::\n"
#					#					);
#					$result = $SeismicUnixGui . '::' . $PARENT_DIR_GEN[$parent] . '::';
#				}
#				else { print("change_a_line, unexpected value\n") }
#			}
#
#		}
#
#		if ( length $result ) {
#
#			return ($result);
#
#		}
#		else {
#			print("change_a_line,_get_path4file, file not found\n");
#		}
#		return ();
#	}
#	else {
#		print("change_a_line,_get_path_for_file,file_name_missing\n");
#		return ();
#	}
#
#}
#
#sub _set_file_name {
#	my ($file_name) = @_;
#
#	if ( length $file_name ) {
#
#		$change_a_line->{_file_name} = $file_name;
#
#		#		print("_set_file_name = $change_a_line->{_file_name}\n");
#
#	}
#	else {
#		print("change_a_line,_set_file_name,missing variable");
#	}
#
#}
