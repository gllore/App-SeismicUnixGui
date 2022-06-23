
=head2 SYNOPSIS

PACKAGE NAME: convert2V7

AUTHOR:  

DATE: Jun 15 2022

DESCRIPTION: Convert perl gui scripts
by including full path to modules

Version: 0.1

=head2 USE

=head3 NOTES

Before conversion: use L_SU_global_constants:
After conversion:   use LSeismicUnix:misc:L_SU_global_constants;

=head4 Examples

=head2 SYNOPSIS

changed files: 

configs:


correct oop_text
oop_run_flows


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

#use LSeismicUnix::misc::manage_dirs_by;
use LSeismicUnix::misc::manage_files_by2;

#my $manage_dirs_by   = manage_dirs_by->new();
my $manage_files_by2 = manage_files_by2->new();

=head2 Define

local variables

=cut

my ( @INBOUND, @SUBDIR );
my @directories;
my @line;
my $number_of_lines;
my @path4gui;
my @file4gui;
my @path4su;
my @file4su;
my @path4gen;
my @file4gen;

my $line2find_use = '\s*use\s';
my $file_name = 'test_file.pl';

#print("parent_directory_gui_number_of=$parent_directory_gui_number_of\n");
#print("child_directory_gui_number_of=$child_directory_gui_number_of\n");

=head2 private shared hash

=cut

my $convert2V7 = {

	_file_name => '',

};

##############################################################

=head2 

=cut

$manage_files_by2->set_file_in( $file_name );

my $inbound         = $file_name;
my $slurp_ref       = manage_files_by2->get_whole($inbound);
my @slurp           = @$slurp_ref;
my $length_of_slurp = scalar @slurp;

print("length of slurp = $length_of_slurp\n");
print("inbound=$inbound\n");

for ( my $j = 0 ; $j < $length_of_slurp ; $j++ ) {

	# print("change_a_line, slurp=slurp[$j]\n");
	my $string = $slurp[$j];
	chomp $string;    # remove all newlines
	my @next_string;
	my @raw_string;
	my $module_name;

	if ( $string =~ m/$line2find_use/ ) {

		my $version;
		$string =~ s/;//;
		$string =~ s/\(\)//;
		my @temp_string = split( /\s+/, $string );
		my $line        = $j + 1;

		if ( $temp_string[1] eq 'use' ) {

			$module_name = $temp_string[2];
			print("Fixed: module name within $file_name=$module_name...\n");

		}
		elsif ( $temp_string[0] eq 'use' ) {

			$module_name = $temp_string[1];
			print("module name within $file_name=$module_name...\n");

		}
		else {
			# CATCH the UNUSUAL
			my $string_number_of = scalar @temp_string;
			print("change_a_line, unexpected module name\n");
			print("\nchange_a_line, string=$string \n");
			print("change_a_line, string_number_of=$string_number_of\n");
			print("change_a_line, temp_string=@temp_string \n");
			print("change_a_line, temp_string[0]=$temp_string[0] \n");
			print("change_a_line, temp_string[1]=$temp_string[1] \n");
			$module_name = 'null';
		}

		my $string_number_of = scalar @temp_string;

		# exceptions to the search for am module name
		if (   $module_name eq 'Moose'
			or $module_name eq ' #'
			or $module_name eq 'null' )
		{

			print("$module_name will be skipped\n");

		}

		#			print(
		#							"change_a_line,found\n $string at line# $line \n
		#								 in $path4gen[$i]/$file_name\n"
		#						);

		else {

			print("module name = $module_name\n");
			my $full_module_name = $module_name . '.pm';
			_set_file_name($full_module_name);
			my $module_path = _get_path4file();

			if ( length $module_path ) {

				# CASE with version numbers; e.g. use module version
				if ( $string_number_of == 3 ) {

					$version = $temp_string[2];

					# print(" version=$version\n");

					if ( $version =~ m/\d+\.\d+.\d+/ ) {

						my $new_version = ("'$version'");

						#prepare output
						$string =~ s/;//;
						$string =~ s/use\s/use $module_path/g;
						$string =~ s/$version/$new_version/g;

					 #							print("change_a_line, new version=$new_version\n");
						$slurp[$j] = $string . ';';

						#							print("substitute line=$slurp[$j]\n");

					}

				}
				elsif ( $string_number_of <= 2 ) {

					# CASE: No version number

					#	print(
					#	"change_a_line,found $file_name in $module_path\n");

					#prepare output
					$string =~ s/;//;
					$string =~ s/use\s/use $module_path/g;

					# print("substitute line=$string;\n");
					$slurp[$j] = $string . ';';

					# print("substitute line=$slurp[$j]\n");

				}
				elsif ( $string_number_of > 3 ) {

					# CASE: SeismicUnix imports many variables

					#prepare output
					$string =~ s/;//;
					$string =~ s/use\s/use $module_path/g;

					# print("substitute line=$string;\n");
					$slurp[$j] = $string . ';';

					# print("substitute line=$slurp[$j]\n");

				}
				else {
					print("change_a_line, unexpected\n");
				}

			}    # module path exists

			else {
				print("change_a_line, did not find a match for module name\n");
			}
		}
	}
	else {    # for each line in a slurp
			  #print("change_a_line, skip line\n");
	}
}    # for each line in a slurped file

# write out the corrected or uncorrected file
my $number_of_lines = $length_of_slurp;

my $outbound = $path4gen[$i] . '/' . $file_name;

print("writing to $outbound\n");
print("number of lines in output file = $number_of_lines\n");
if ( $number_of_lines == 0 ) {

	print("change_a_line, unexpected empty file\n");
	print("Hit Enter to continue\n");
	<STDIN>;

}
elsif ( $number_of_lines > 0 ) {

	#			print "Press ENTER to write a new file with a changed line";
	#			<STDIN>;

	open( OUT, ">$outbound" )
	  or die("File $file_name not found");

	# add \n!!!!
	for ( my $i = 0 ; $i < $number_of_lines ; $i++ ) {

		printf OUT $slurp[$i] . "\n";

	}
	close(OUT);
}
else {
	print("change_a_line, unexpected empty file\n");
}

}
else {
  print(" skipping an unwanted file\n");
}

sub _set_file_name {
	my ($file_name) = @_;

	if ( length $file_name ) {

		convert2V0 .7->{_file_name} = $file_name;

		#		print("_set_file_name = convert2V0.7->{_file_name}\n");

	}
	else {
		print("change_a_line,_set_file_name,missing variable");
	}

}
