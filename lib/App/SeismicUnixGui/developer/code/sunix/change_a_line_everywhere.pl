
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
SU, GEN, SPECS, GUI, TOOLS

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

my $manage_dirs_by        = manage_dirs_by->new();
my $manage_files_by2      = manage_files_by2->new();
my $L_SU_global_constants = L_SU_global_constants->new();

=head2 Important definitions

=cut

#type1
#my $line2find    = '^package\s\w+\;';

#type2
#my $line2find       = '^use\sApp::SeismicUnixGui(.+\w)+::(?!SeismicUnix)';

#type 3
#my $line2find       = '=\snew\s\w+';

#type 4
my $line2find = 'use\saliased\s\'App';

=head2 Important definitions 

of directory structure

=cut 

my $SeismicUnixGui  = 'App-SeismicUnixGui/lib/App/SeismicUnixGui';
my $PL_DIR          = '/usr/local/pl';
my $GRANDPARENT_DIR = $PL_DIR . '/' . $SeismicUnixGui;

=head2 privately shared hash

=cut

my $change_a_line = {
	_child_directory_su_number_of  => '',
	_file_name                     => '',
	_line_of_interest_aref         => '',
	_parent_directory_su_number_of => '',
	_pathNfile_aref                => '',
};

=head2 Get all the files and their paths

from the SU category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('SU');
$L_SU_global_constants->set_PARENT_DIR_type('SU');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ( $su_pathNfile_aref, $su_dimension_aref ) =
  $L_SU_global_constants->get_pathNfile2search();

=head2 search for lines of interest

in SU-type files and replace them

=cut 

my @dimension_su                  = @$su_dimension_aref;
my $parent_directory_su_number_of = $dimension_su[0];
my $child_directory_su_number_of  = $dimension_su[1];

#print("parent_directory_su_number_of=$parent_directory_su_number_of\n");
#print("child_directory_su_number_of=$child_directory_su_number_of\n");
#
#
#my @su_pathNfile = @$su_pathNfile_aref;
#
#_set_parent_directory_number_of($parent_directory_su_number_of);
#_set_child_directory_number_of($child_directory_su_number_of);
#_set_pathNfile_aref($su_pathNfile_aref);
#my $su_aref = _get_line_of_interest_aref();
#my @line_of_interest_su_aref =@$su_aref;
#_set_line_of_interest_aref($su_aref);
#_set_replacement_type1();
#_set_replacement_type2();

=head2 Get all the files and their full paths

from the GEN category and replace them(

=cut

$L_SU_global_constants->set_CHILD_DIR_type('GEN');
$L_SU_global_constants->set_PARENT_DIR_type('GEN');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ( $gen_pathNfile_aref, $gen_dimension_aref ) =
  $L_SU_global_constants->get_pathNfile2search();

=head2 search for lines of interest

in GEN-type files and replace them

=cut 

my @dimension_gen                  = @$gen_dimension_aref;
my $parent_directory_gen_number_of = $dimension_gen[0];
my $child_directory_gen_number_of  = $dimension_gen[1];

#print("parent_directory_gen_number_of=$parent_directory_gen_number_of\n");
#print("child_directory_gen_number_of=$child_directory_gen_number_of\n");

#my @gen_pathNfile = @$gen_pathNfile_aref;
#$parent_directory_gen_number_of=1;
#$child_directory_gen_number_of=1;
#_set_parent_directory_number_of($parent_directory_gen_number_of);
#_set_child_directory_number_of($child_directory_gen_number_of);
#_set_pathNfile_aref($gen_pathNfile_aref);
#my $gen_aref = _get_line_of_interest_aref();
#my @line_of_interest_gen_aref =@$gen_aref;
#_set_line_of_interest_aref($gen_aref);
#_set_replacement_type2();
#_set_replacement_type3();

=head2 Get all the files and their full paths

from the SPECS category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('SPECS');
$L_SU_global_constants->set_PARENT_DIR_type('SPECS');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ( $specs_pathNfile_aref, $specs_dimension_aref ) =
  $L_SU_global_constants->get_pathNfile2search();

=head2 search for lines of interest

in SPECS-type files and replace them

=cut 

my @dimension_specs                  = @$specs_dimension_aref;
my $parent_directory_specs_number_of = $dimension_specs[0];
my $child_directory_specs_number_of  = $dimension_specs[1];

print("parent_directory_specs_number_of=$parent_directory_specs_number_of\n");
print("child_directory_specs_number_of=$child_directory_specs_number_of\n");

my @gspecs_pathNfile = @$specs_pathNfile_aref;

_set_parent_directory_number_of($parent_directory_specs_number_of);
_set_child_directory_number_of($child_directory_specs_number_of);
_set_pathNfile_aref($specs_pathNfile_aref);
my $specs_aref                  = _get_line_of_interest_aref();
my @line_of_interest_specs_aref = @$specs_aref;
_set_line_of_interest_aref($specs_aref);

#_set_replacement_type1();
#_set_replacement_type3();
_set_replacement_type4();

=head2 Get all the files and their full paths

from the GUI category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('GUI');
$L_SU_global_constants->set_PARENT_DIR_type('GUI');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ( $gui_pathNfile_aref, $gui_dimension_aref ) =
  $L_SU_global_constants->get_pathNfile2search();

=head2 search for lines of interest

in GUI-type files and replace them

=cut 

my @dimension_gui                  = @$gui_dimension_aref;
my $parent_directory_gui_number_of = $dimension_gui[0];
my $child_directory_gui_number_of  = $dimension_gui[1];

#print("parent_directory_gui_number_of=$parent_directory_gui_number_of\n");
#print("child_directory_gui_number_of=$child_directory_gui_number_of\n");
#
#_set_parent_directory_number_of($parent_directory_gui_number_of);
#_set_child_directory_number_of($child_directory_gui_number_of);
#_set_pathNfile_aref($gui_pathNfile_aref);
#my $gui_aref = _get_line_of_interest_aref();
#my @line_of_interest_gui_aref =@$gui_aref;
#_set_line_of_interest_aref($gui_aref);
##_set_replacement_type1();
#_set_replacement_type2();

=head2 Get all the files and their full paths

from the TOOLS category

=cut

$L_SU_global_constants->set_CHILD_DIR_type('TOOLS');
$L_SU_global_constants->set_PARENT_DIR_type('TOOLS');
$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
my ( $tools_pathNfile_aref, $tools_dimension_aref ) =
  $L_SU_global_constants->get_pathNfile2search();

=head2 search for lines of interest

in TOOLS-type files and replace them

=cut 

my @dimension_tools                  = @$tools_dimension_aref;
my $parent_directory_tools_number_of = $dimension_tools[0];
my $child_directory_tools_number_of  = $dimension_tools[1];

#print("parent_directory_tools_number_of=$parent_directory_tools_number_of\n");
#print("child_directory_tools_number_of=$child_directory_tools_number_of\n");
#
#_set_parent_directory_number_of($parent_directory_tools_number_of);
#_set_child_directory_number_of($child_directory_tools_number_of);
#_set_pathNfile_aref($tools_pathNfile_aref);
#my $tools_aref = _get_line_of_interest_aref();
#my @line_of_interest_tools_aref =@$tools_aref;
#_set_line_of_interest_aref($tools_aref);
#_set_replacement_type2();
#_set_replacement_type3();

=head2 _get_line_of_interest_aref

=cut

sub _get_line_of_interest_aref {

	my ($self) = @_;

	my $child_directory_number_of =
	  $change_a_line->{_child_directory_number_of};
	my $parent_directory_number_of =
	  $change_a_line->{_parent_directory_number_of};
	my @pathNfile = @{ $change_a_line->{_pathNfile_aref} };

	my @line_of_interest_aref;

	for (
		my $parent = 0, my $count_idx = 0 ;
		$parent < $parent_directory_number_of ;
		$parent++
	  )
	{
		for ( my $child = 0 ; $child < $child_directory_number_of ; $child++ ) {

			# print("starting inner count=$count; parent=$parent\n");
			my @pathNfile_list        = @{ $pathNfile[$parent][$child] };
			my $pathNfile_list_length = scalar @pathNfile_list;

			for (
				my $i = 0, my $j = $count_idx ;
				$i < $pathNfile_list_length ;
				$i++, $j++
			  )
			{
				$count_idx = $j;

				my @line_of_interest4file;

#			print("total count index =$count_idx\n");
#	  			print ("parent=$parent;child=$child;numer=$i;pathNfile:$pathNfile_list[$i]\n");

				# slurp every file
				$manage_files_by2->set_pathNfile( $pathNfile_list[$i] );
				my $slurp_ref =
				  manage_files_by2->get_whole( $pathNfile_list[$i] );
				my @slurp           = @$slurp_ref;
				my $length_of_slurp = scalar @slurp;

				for ( my $j = 0 ; $j < $length_of_slurp ; $j++ ) {

					# CASE within each *.pm file
					my $string = $slurp[$j];
					chomp $string;    # remove all newlines

					if ( $string =~ m/$line2find/ ) {

						push @line_of_interest4file, $j;

						print("string=$string loi=$j at $pathNfile_list[$i]\n");

					}
				}    # lines in a file

				$line_of_interest_aref[$parent][$child][$i] =
				  \@line_of_interest4file;

			}    #for files in a list

		}    # for each child directory

	}    #for each parent directory

	my $result = \@line_of_interest_aref;
	return ($result);
}

=head2 sub _set_child_directory_number_of 

=cut

sub _set_child_directory_number_of {

	my ($self) = @_;

	$change_a_line->{_child_directory_number_of} = $self;

	#	print ("_set_child_directory_number_of=$self\n");

	return ();
}

=head2 sub _set_line_of_interest_aref 

=cut

sub _set_line_of_interest_aref {

	my ($self) = @_;

	$change_a_line->{_line_of_interest_aref} = $self;

	#	print ("_set_line_of_interest_aref=$self\n");
	return ();
}

=head2 sub _set_parent_directory_number_of 

=cut

sub _set_parent_directory_number_of {

	my ($self) = @_;

	$change_a_line->{_parent_directory_number_of} = $self;

	#    print ("_set_parent_directory_number_of=$self\n");
	return ();
}

=head2 sub _set_pathNfile_aref 

=cut

sub _set_pathNfile_aref {
	my ($self) = @_;

	$change_a_line->{_pathNfile_aref} = $self;
	return ();
}

=head2 set_replacement_type1

replace line of interest

=cut

sub _set_replacement_type1 {

	my ($self) = @_;

	my $child_directory_number_of =
	  $change_a_line->{_child_directory_number_of};
	my $parent_directory_number_of =
	  $change_a_line->{_parent_directory_number_of};
	my @pathNfile             = @{ $change_a_line->{_pathNfile_aref} };
	my @line_of_interest_aref = @{ $change_a_line->{_line_of_interest_aref} };

	for ( my $parent = 0 ; $parent < $parent_directory_number_of ; $parent++ ) {

		for ( my $child = 0 ; $child < $child_directory_number_of ; $child++ ) {

			my @pathNfile_list        = @{ $pathNfile[$parent][$child] };
			my $pathNfile_list_length = scalar @pathNfile_list;

			for ( my $i = 0 ; $i < $pathNfile_list_length ; $i++ ) {

				# slurp every file
				$manage_files_by2->set_pathNfile( $pathNfile_list[$i] );
				my $slurp_ref =
				  manage_files_by2->get_whole( $pathNfile_list[$i] );
				my @slurp = @$slurp_ref;

				my @line_number =
				  @{ $line_of_interest_aref[$parent][$child][$i] };
				my $line_number_of = scalar @line_number;

				#			print("child directory=$child\n");
				#			print $pathNfile_list[$i]." file number =$i\n";
				#			print("line_number_of=$line_number_of\n");

				if ( $line_number_of > 0 ) {

					#				print("line_number=@line_number\n");
					#				print("line_number_of=$line_number_of\n");

					foreach my $line (@line_number) {

						chomp $slurp[$line];
						my $path = $pathNfile_list[$i];
						$path =~
						  s/\/usr\/local\/pl\/App-SeismicUnixGui\/lib\///;

						# substitute "/" with ":"
						$path =~ s/(\/)+/::/g;
						$path =~ s/.pm//g;
						$slurp[$line] = 'package' . ' ' . $path . ';';
						print("hierarchical path =$slurp[$line]\n");

					}

					print("Hit Enter to continue\n");
					<STDIN>;

					open( OUT, ">$pathNfile_list[$i]" )
					  or die("File $pathNfile_list[$i] not found");

					foreach my $text (@slurp) {
						printf OUT $text . "\n";    # add \n!!!!
													# print("$text \n");
					}

					close(OUT);

				}
				else {
					#				print("\npathNfile_list=$pathNfile_list[$i]\n");
					#				print("main,no matching lines detected\n");
				}

			}    # for files in a list

		}    # for each child directory

	}    #for each parent directory

}    # sub replace line of interest

=head2 set_replacement_type2

replace line of interest

=cut

sub _set_replacement_type2 {

	my ($self) = @_;

	my $child_directory_number_of =
	  $change_a_line->{_child_directory_number_of};
	my $parent_directory_number_of =
	  $change_a_line->{_parent_directory_number_of};
	my @pathNfile             = @{ $change_a_line->{_pathNfile_aref} };
	my @line_of_interest_aref = @{ $change_a_line->{_line_of_interest_aref} };

	for ( my $parent = 0 ; $parent < $parent_directory_number_of ; $parent++ ) {

		for ( my $child = 0 ; $child < $child_directory_number_of ; $child++ ) {

			my @pathNfile_list        = @{ $pathNfile[$parent][$child] };
			my $pathNfile_list_length = scalar @pathNfile_list;

			for ( my $i = 0 ; $i < $pathNfile_list_length ; $i++ ) {

				# slurp every file
				$manage_files_by2->set_pathNfile( $pathNfile_list[$i] );
				my $slurp_ref =
				  manage_files_by2->get_whole( $pathNfile_list[$i] );
				my @slurp = @$slurp_ref;

				my @line_number =
				  @{ $line_of_interest_aref[$parent][$child][$i] };
				my $line_number_of = scalar @line_number;

				if ( $line_number_of > 0 ) {

					foreach my $line (@line_number) {

						chomp $slurp[$line];
						print $slurp[$line] . "\n";

						if ( not( $slurp[$line] =~ m/\'/ ) )
						{    #skip version cases

					   # substitute "use App ....;" with "use aliased 'App...';"
							$slurp[$line] =~ s/use\sApp/use aliased 'App/g;
							$slurp[$line] =~ s/;/\';/;
							print("new line =$slurp[$line]\n");

						}

					}

					print("Hit Enter to continue\n");
					<STDIN>;

					open( OUT, ">$pathNfile_list[$i]" )
					  or die("File $pathNfile_list[$i] not found");

					foreach my $text (@slurp) {
						printf OUT $text . "\n";    # add \n!!!!

						#					print("$text \n");
					}

					close(OUT);

				}
				else {
					#				print("\npathNfile_list=$pathNfile_list[$i]\n");
					#				print("main,no matching lines detected\n");
				}

			}    # for files in a list

		}    # for each child directory

	}    #for each parent directory

}    # sub replace line of interest

=head2 set_replacement_type3

replace line of interest

=cut

sub _set_replacement_type3 {

	my ($self) = @_;

	my $child_directory_number_of =
	  $change_a_line->{_child_directory_number_of};
	my $parent_directory_number_of =
	  $change_a_line->{_parent_directory_number_of};
	my @pathNfile             = @{ $change_a_line->{_pathNfile_aref} };
	my @line_of_interest_aref = @{ $change_a_line->{_line_of_interest_aref} };

	for ( my $parent = 0 ; $parent < $parent_directory_number_of ; $parent++ ) {

		for ( my $child = 0 ; $child < $child_directory_number_of ; $child++ ) {

			my @pathNfile_list        = @{ $pathNfile[$parent][$child] };
			my $pathNfile_list_length = scalar @pathNfile_list;

			for ( my $i = 0 ; $i < $pathNfile_list_length ; $i++ ) {

				# slurp every file
				$manage_files_by2->set_pathNfile( $pathNfile_list[$i] );
				my $slurp_ref =
				  manage_files_by2->get_whole( $pathNfile_list[$i] );
				my @slurp = @$slurp_ref;

				my @line_number =
				  @{ $line_of_interest_aref[$parent][$child][$i] };
				my $line_number_of = scalar @line_number;

				if ( $line_number_of > 0 ) {

					foreach my $line (@line_number) {

						chomp $slurp[$line];

						# substitute "= module" with "= module->new->new()"
						print("3. found line $slurp[$line]\n");
						$slurp[$line] =~ s/=\snew\s/=\ /g;
						$slurp[$line] =~ s/\(\)//g;
						$slurp[$line] =~ s/;/->new\(\);/g;
						print("new line =$slurp[$line]\n");

					}

					print("Hit Enter to continue\n");
					<STDIN>;

					#				open( OUT, ">$pathNfile_list[$i]" )
					#				  or die("File $pathNfile_list[$i] not found");
					#
					#				foreach my $text (@slurp) {
					#					printf OUT $text . "\n";    # add \n!!!!
					#					print("$text \n");
					#				}
					#
					#				close(OUT);

				}
				else {
					#				print("\npathNfile_list=$pathNfile_list[$i]\n");
					#				print("main,no matching lines detected\n");
				}

			}    # for files in a list

		}    # for each child directory

	}    #for each parent directory

}    # sub replace line of interest

=head2 set_replacement_type4

replace line of interest

=cut

sub _set_replacement_type4 {

	my ($self) = @_;

	my $child_directory_number_of =
	  $change_a_line->{_child_directory_number_of};
	my $parent_directory_number_of =
	  $change_a_line->{_parent_directory_number_of};
	my @pathNfile             = @{ $change_a_line->{_pathNfile_aref} };
	my @line_of_interest_aref = @{ $change_a_line->{_line_of_interest_aref} };

	for ( my $parent = 0 ; $parent < $parent_directory_number_of ; $parent++ ) {

		for ( my $child = 0 ; $child < $child_directory_number_of ; $child++ ) {

			my @pathNfile_list        = @{ $pathNfile[$parent][$child] };
			my $pathNfile_list_length = scalar @pathNfile_list;

			for ( my $i = 0 ; $i < $pathNfile_list_length ; $i++ ) {

				# slurp every file
				$manage_files_by2->set_pathNfile( $pathNfile_list[$i] );
				my $slurp_ref =
				  manage_files_by2->get_whole( $pathNfile_list[$i] );
				my @slurp = @$slurp_ref;

				my @line_number =
				  @{ $line_of_interest_aref[$parent][$child][$i] };
				my $line_number_of = scalar @line_number;

				if ( $line_number_of > 0 ) {

					for ( my $line = 0 ; $line < $line_number_of ; $line++ ) {

						# CASE only when the search item lies
						# on first line
						my @temp_string;

						if ( $line == 0 ) {
							chomp $slurp[$line];

							# double check
							@temp_string = split( /\s+/, $slurp[$line] );

							if ( $temp_string[0] ne 'package' ) {

								print("4.$temp_string[0],$temp_string[1]\n");
								print(
									"4. current file is $pathNfile_list[$i]\n");
								print(
									"4.found line $slurp[$line] on line=$line\n"
								);

								$slurp[$line] =~ s/use\ aliased\ \'/package\ /g;
								print("new line =$slurp[$line]\n");

								print("Hit Enter to continue\n");
								<STDIN>;

								open( OUT, ">$pathNfile_list[$i]" )
								  or die("File $pathNfile_list[$i] not found");

								foreach my $text (@slurp) {
									printf OUT $text . "\n";    # add \n!!!!

									# print("$text \n");
								}

								close(OUT);

							}
							else {
								print(
"exception to type4 search are: @temp_string\n"
								);
							}
						}
						else {
							# NADA conditional line index=0
						}

					}    # for each line in the file
				}
				else {
					# NADA conditional if search cases exist
				}

			}    # for each file in a list
		}    # for each child direcroty
	}    # for each parent directory
}    # sub replace line of interest
