
=head2 SYNOPSIS

PACKAGE NAME: convert2V07

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
my @path4gui;
my @file4gui;
my @path4su;
my @file4su;
my @path4gen;
my @file4gen;

my $line2find_use = '\s*use\s';
my $file_name     = 'test_file.pl';

#print("parent_directory_gui_number_of=$parent_directory_gui_number_of\n");
#print("child_directory_gui_number_of=$child_directory_gui_number_of\n");

=head2 private shared hash

=cut

my $convert2V07 = {

	_file_name => '',

};

=head2 

=cut

$manage_files_by2->set_file_in($file_name);
$manage_files_by2->set_directory('./');
my $slurp_ref = manage_files_by2->get_whole($file_name);

my @slurp           = @$slurp_ref;
my $length_of_slurp = scalar @slurp;

for ( my $j = 0 ; $j < $length_of_slurp ; $j++ ) {

	my $string = $slurp[$j];
	chomp $string;    # remove all newlines
	my @next_string;
	my @raw_string;
	my @temp_string;

	if ( $string =~ m/$line2find_use/ ) {

		my $module_name;
		$string =~ s/;//;
		$string =~ s/\(\)//;
		@temp_string = split( /\s+/, $string );
		my $line = $j + 1;

		if ( $temp_string[1] eq 'use' ) {

			$module_name = $temp_string[2];

			#			print("Fixed: module name within $file_name=$module_name...\n");

			# Bad module names to avoid
			if (   $module_name ne 'Moose'
				or length $module_name
				or $module_name ne ''
				or $module_name ne 'null' )
			{

				print("substitute line=$slurp[$j]\n");
				use LSeismicUnix::misc::L_SU_global_constants;
				my $L_SU_global_constants = L_SU_global_constants->new();

				my $module_name_pm = $module_name . '_spec.pm';
				#	print("module name_pm = $module_name_pm\n");
				
				$L_SU_global_constants->set_file_name($module_name_pm);
				my $path = $L_SU_global_constants->get_path4spec_file();
				
				my $pathNmodule_pm = $path . '/' . $module_name_pm;
				print("pathNmodule_pm = $pathNmodule_pm\n");

			}
			else {
				print("convert2V07, bad module\n");
			}

		}    # catches good modules
		elsif ( $temp_string[0] eq 'use' ) {

			#		$module_name = $temp_string[1];
			#		print("module name within $file_name=$module_name...\n");
			print("use is in unexpected location WARNING...\n");

		}
		else {
			# CATCH the UNUSUAL
			my $string_number_of = scalar @temp_string;
			print("convert2V07, unexpected module name\n");
			print("\nconvert2V07, string=$string \n");
			print("convert2V07, string_number_of=$string_number_of\n");
			print("convert2V07, temp_string=@temp_string \n");
			print("convert2V07, temp_string[0]=$temp_string[0] \n");
			print("convert2V07, temp_string[1]=$temp_string[1] \n");
			$module_name = 'null';
		}

	}
	else {    # for each line containing "use"
			  # print("convert2V07, skip line\n");
	}

}    # for each line in a slurped file

# write out the corrected or uncorrected file
#my $length_of_slurp = $length_of_slurp;

my $outbound = $file_name;

print("writing to $outbound\n");
print("number of lines in output file = $length_of_slurp\n");

if ( $length_of_slurp == 0 ) {

	print("convert2V07, unexpected empty file\n");
	print("Hit Enter to continue\n");
	<STDIN>;

}
elsif ( $length_of_slurp > 0 ) {

	print "Press Writing a new file with a changed line";

	#			<STDIN>;

	#	open( OUT, ">$outbound" )
	#	  or die("File $file_name not found");

	# add \n!!!!
	for ( my $i = 0 ; $i < $length_of_slurp ; $i++ ) {

		#		print $slurp[$i] . "\n";

	}

	#	close(OUT);
}

#sub _set_file_name {
#
#	my ($file_name) = @_;
#
#	if ( length $file_name ) {
#
#		$convert2V07->{_file_name} = $file_name;
#
#		#		print("_set_file_name = convert2V0.7->{_file_name}\n");
#
#	}
#	else {
#		print("convert2V07,_set_file_name,missing variable");
#	}
#
#}
