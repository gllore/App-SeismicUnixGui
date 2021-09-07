
=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  sudoc2pm_update.pl							

 AUTHOR: Juan Lorenzo
 DATE:   September 4 2021 
 DESCRIPTION: minor changes to 
program_config.pm
 program_spec.pm
 and program.pm files

=head2 USE

=head3 NOTES

=head4 Examples

=head3 NOTES

 	Program group array and the directory names:
 		
$developer_sunix_categories[0]  = 'data';
$developer_sunix_categories[1]  = 'datum';
$developer_sunix_categories[2]  = 'plot';
$developer_sunix_categories[3]  = 'filter';
$developer_sunix_categories[4]  = 'header';
$developer_sunix_categories[5]  = 'inversion';
$developer_sunix_categories[6]  = 'migration';
$developer_sunix_categories[7]  = 'model';
$developer_sunix_categories[8]  = 'NMO_Vel_Stk';
$developer_sunix_categories[9]  = 'par';
$developer_sunix_categories[10] = 'picks';
$developer_sunix_categories[11] = 'shapeNcut';
$developer_sunix_categories[12] = 'shell';
$developer_sunix_categories[13] = 'statsMath';
$developer_sunix_categories[14] = 'transform';
$developer_sunix_categories[15] = 'well';
$developer_sunix_categories[16] = '';
  	
 	QUESTION 1:
Which group number do you want to use to update
for *.pm, *.config, and *_spec.pm files ?

e.g., for transforms use:
$group_no = 15

QUESTION 2:
Which program do you want to work on?

For example=
'sugetgthr';
'sugain';
'suputgthr';
'suifft';
'sufctanismod'
'vel2stiff
'unif2aniso'
'transp'
'suflip'


	my $program_name = 'suhistogram';

=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

use L_SU_global_constants;
use sudoc;
use sunix_package;
use prog_doc2pm;

my $get         = L_SU_global_constants->new();
my $sudoc       = sudoc->new();
my $package     = sunix_package->new();
my $prog_doc2pm = prog_doc2pm->new();

my $var   = $get->var();
my $true  = $var->{_true};
my $false = $var->{_false};

my (@file_in);
my ($i);
my @file;
my ( @path_out4configs,         @path_out4developer, @path_out4specs, @path_out4sunix );
my ( @path_in4configs,          @path_in4developer,  @path_in4specs,  @path_in4sunix );
my ( @path_in4global_constants, @path_out4global_constants );
my $package_name;
my ( @config_file_in, @config_file_out, @pm_file_in, @pm_file_out, @spec_file_in, @spec_file_out );
my @global_constants_file_in;
my ( @config_inbound,               @config_outbound, @pm_inbound, @pm_outbound, @spec_inbound, @spec_outbound );
my ( @global_constants_inbound,     @global_constants_outbound );
my ( @line_global_constant_success, @line_terminator_success );
my $whole_aref;
my @slurp;
my $max_index;
my $number_of_lines;
my $spec_replacement_success  = $false;
my $sunix_replacement_success = $false;
my $global_constant_success   = $false;
my $terminator_match_success  = $false;
my $L_SU_global_constants     = 'L_SU_global_constants';

my $sudoc2pm = {
	_names         => '',
	_values        => '',
	_line_contents => '',
};

=head2 SET UP 
sunix package to build

=cut

=head2 QUESTION 1-3:
Which group number do you want ?
What program do you want?

=cut

my $group_no = 13;
$prog_doc2pm->set_group_directory($group_no);
my @developer_sunix_category = @{ $get->developer_sunix_categories_aref() };
my $sunix_category           = $developer_sunix_category[$group_no];

#print("group $group_no category=$developer_sunix_category[$group_no]\n");
my $program_name = 'suhistogram';

=head2 private values

=cut

my $path_in     = $prog_doc2pm->get_path_in();
my $list_length = $prog_doc2pm->get_list_length();

$path_out4developer[0] = $prog_doc2pm->get_path_out4developer();

$path_out4configs[0] = $prog_doc2pm->get_path_out4configs();
$path_out4specs[0]   = $prog_doc2pm->get_path_out4specs();
$path_out4sunix[0]   = $prog_doc2pm->get_path_out4sunix();

$path_in4configs[0] = $prog_doc2pm->get_path_out4configs();
$path_in4specs[0]   = $prog_doc2pm->get_path_out4specs();
$path_in4sunix[0]   = $prog_doc2pm->get_path_out4sunix();

$path_out4global_constants[0] = $prog_doc2pm->get_path_out4global_constants();
$path_in4global_constants[0]  = $prog_doc2pm->get_path_out4global_constants();

=head2 path definitions

=cut

$package_name       = $program_name;
$pm_file_out[0]     = $package_name . '.pm';
$config_file_out[0] = $package_name . '.config';
$spec_file_out[0]   = $package_name . '_spec.pm';

$pm_file_in[0]               = $package_name . '.pm';
$config_file_in[0]           = $package_name . '.config';
$spec_file_in[0]             = $package_name . '_spec.pm';
$global_constants_file_in[0] = $L_SU_global_constants . '.pm';

$pm_inbound[0]               = $path_in4sunix[0] . '/' . $pm_file_in[0];
$config_inbound[0]           = $path_in4configs[0] . '/' . $config_file_in[0];
$spec_inbound[0]             = $path_in4specs[0] . '/' . $spec_file_in[0];
$global_constants_inbound[0] = $path_in4global_constants[0] . '/' . $global_constants_file_in[0];

$pm_outbound[0]               = $path_out4sunix[0] . '/' . $package_name . '.pm';
$config_outbound[0]           = $path_out4configs[0] . '/' . $package_name . '.config';
$spec_outbound[0]             = $path_out4specs[0] . '/' . $package_name . '_spec.pm';
$global_constants_outbound[0] = $path_out4global_constants[0] . '/' . $global_constants_file_in[0];

=head2 QUESTION 3:
Handled automatically
What max_index value do you want to insert?
Read number of lines in the 
program_config.pm file

=cut

open( FILE, "< $config_inbound[0]" ) or die "can't open $config_inbound[0]: $!";
$number_of_lines++ while <FILE>;

# $count now holds the number of lines read
print("number of lines read = $number_of_lines \n");
$max_index = $number_of_lines - 1;

my $spec_string_to_find     = '	my \$max_index           = # Insert a number here';
my $spec_replacement_string = (" my \$max_index           = $max_index;");

#print("For program_spec.pm files, working on replacement of \n$spec_string_to_find\n with \n\t$spec_replacement_string \n");

my $sunix_string_to_find     = 'my \$max_index = 36;';
my $sunix_replacement_string = ("\tmy \$max_index = $max_index;");

my $global_constants_string_to_find = ("my \@sunix_$sunix_category\_programs");
my $terminator_to_find              = '\);';

#print("For program_sunix.pm files, working on replacement of \n$sunix_string_to_find\n with \n\t$sunix_replacement_string \n");

#print("sudoc2pm_update,path_out: $path_out4developer\n");
#my @program_name = @{ $prog_doc2pm->get_program_aref() };
#for ( my $i = 0; $i < $list_length; $i++ ) {

##print("sudoc2pm_update,program_name, num=$i, program_name=$program_name[$i]\n");
#print("sudoc2pm_update,program_name, selected_program_name=$program_name, \n");

#=head2 Updating spec_files
#
#=cut
#
#if (   length $package_name
#	&& ( -e $spec_inbound[0] )
#	&& ( -e $spec_outbound[0] ) ) {
#
#print("sudoc2pm_update, I am in group=$group_no \n");
#print("sudoc2pm_update, I am working on package =$package_name \n");
#print("sudoc2pm_update, updating $spec_file_out[0]in $path_out4specs[0]\n");
#
#=head2 Read in package file (
# "program"_spec.pm)
#
#=cut
#
#	$sudoc->set_file_in_sref( \$spec_file_in[0] );
#	$sudoc->set_perl_path_in( $path_in4specs[0] );
#
#	# slurp the whole file
#	$sudoc->whole();
#	my $whole_aref = $sudoc->get_whole();
#
#	my $number_of_lines = scalar @{$whole_aref};
#
#	#	print("sudoc2pm_update.pl,num_lines= $number_of_lines\n");
#	#	for ( my $i = 0; $i < $number_of_lines; $i++ ) {
#	#		print("sudoc2pm_update,All sunix documentation @{$whole_aref}[$i]\n");
#	#	}
#
#	my @slurp = @{$whole_aref};
#
#	for ( my $i = 0; $i < $number_of_lines; $i++ ) {
#
#		#		print("sudoc2pm_update,All sunix documentation $slurp[$i]\n");
#
#		my $string = $slurp[$i];
#
##        print("sudoc2pm_update, string to search:$slurp[$i]\n");
#
#		if ( $string =~/$spec_string_to_find/ ) {
#
#			print("a spec success\n");
#
#			$slurp[$i] = $spec_replacement_string;
#			print("sudoc2pm_update, \n $slurp[$i]\n");
#
#			$spec_replacement_success= $true;
#			$slurp[$i] = $spec_replacement_string;
#		}
#
#	}
#
#
#
#	if ( $spec_replacement_success ) {
#
#		#	Write out the corrected file
#		#	print("writing out to  $spec_outbound[0]\n");
#
#		open( OUT, ">$spec_outbound[0]" ) or die("File  $spec_outbound[0] not found");
#
#		for ( my $i = 0; $i < $number_of_lines; $i++ ) {
#
#				print ("$slurp[$i]\n");
#				print OUT $slurp[$i] . "\n";
#
#		}
#
#		close(OUT);
#
#	} else {
#		print("sudoc2pm_update, spec string replacement unsuccessful\n");
#	}
##
#} else {
#	print "sudoc2pm_update: a \"spec\" file is missing!\n";
#}    # for a selected program name in the group
#
#
#=head2 Updating sunix.pm files
#
#=cut
#
#if (   length $package_name
#	&& ( -e $pm_outbound[0] )
#	&& ( -e $pm_inbound[0] )
#	){
#
##	print("sudoc2pm_update, I am in group=$group_no \n");
##	print("sudoc2pm_update, I am working on package =$package_name \n");
##	print("sudoc2pm_update, updating $pm_file_out[0] in $path_out4sunix[0]\n");
#
#
#=head2 Read in package file (
# "program".pm)
#
#=cut
#
#	$sudoc->set_file_in_sref( \$pm_file_in[0] );
#	$sudoc->set_perl_path_in( $path_in4sunix[0] );
#
#	# slurp the whole file
#	$sudoc->whole();
#	my $whole_aref = $sudoc->get_whole();
#
#	my $number_of_lines = scalar @{$whole_aref};
#
#		print("sudoc2pm_update.pl,num_lines= $number_of_lines\n");
#		for ( my $i = 0; $i < $number_of_lines; $i++ ) {
##			print("sudoc2pm_update,All sunix documentation @{$whole_aref}[$i]\n");
#	}
#
#	my @slurp = @{$whole_aref};
#
#for ( my $i = 0; $i < $number_of_lines; $i++ ) {
#
##		print ("string to find:$sunix_string_to_find\n");
#		my $string = $slurp[$i];
##        print("sudoc2pm_update, string to search:$slurp[$i]\n");
#
#		if ( $string =~ /$sunix_string_to_find/ ) {
#
##			print("a success\n");
#			$sunix_replacement_success= $true;
#			$slurp[$i] = $sunix_replacement_string;
#
#		}
#
#	}
#
#	if ( $sunix_replacement_success ) {
#
#		#	Write out the corrected file
#		print("writing out to  $pm_outbound[0]\n");
#
#		open( OUT, ">$pm_outbound[0]" ) or die("File  $pm_outbound[0] not found");
#
#		for ( my $i = 0; $i < $number_of_lines; $i++ ) {
#
##			print("$slurp[$i]\n");
#			print OUT $slurp[$i] ."\n";
#
#		}
#
#		close(OUT);
#
#	} else {
#		print("sudoc2pm_update, sunix string replacement unsuccessful\n");
#	}
#
#} else {
#	print "sudoc2pm_update: an sunix file is missing!\n";
#}    # for a selected program name in the group
#

=head2 update L_SU_global_constants

=cut

if (   length $package_name
	&& ( -e $global_constants_inbound[0] )
	&& ( -e $global_constants_outbound[0] ) ) {

	print("sudoc2pm_update, I am in group=$group_no \n");
	print("sudoc2pm_update, I am working on package =$package_name \n");
	print("sudoc2pm_update, updating  $global_constants_file_in[0] in $path_out4global_constants[0]\n");

=head2 Read in file 
( L_SU_global_constants.pm )

=cut

	$sudoc->set_file_in_sref( \$global_constants_file_in[0] );
	$sudoc->set_perl_path_in( $path_in4global_constants[0] );

	# slurp the whole file
	$sudoc->whole();
	$whole_aref      = $sudoc->get_whole();
	@slurp           = @{$whole_aref};
	$number_of_lines = scalar @{$whole_aref};

	#	print("sudoc2pm_update.pl,num_lines= $number_of_lines\n");
	#	for ( my $i = 0; $i < $number_of_lines; $i++ ) {
	#
	#		#		print("sudoc2pm_update,All sunix documentation @{$whole_aref}[$i]\n");
	#	}

	#	print("global_constants_string_to_find=$global_constants_string_to_find\n");
	my @line_success;

	my $count_global_constant = 0;
	my $count_terminator      = 0;

	for ( my $i = 0; $i < $number_of_lines; $i++ ) {

		# print("sudoc2pm_update,$slurp[$i]\n");
		my $string = $slurp[$i];

		#        print("sudoc2pm_update, string to search:$slurp[$i]\n");

		if ( $string =~ /$global_constants_string_to_find/ ) {

			print("a success in finding a global constant\n");
			$line_global_constant_success[$count_global_constant] = $i;
			$count_global_constant++;
			print("sudoc2pm_update, \n $slurp[$i]\n");
			$global_constant_success = $true;

		}

		if ( $string =~ /$terminator_to_find/ ) {

			#			print("a success in finding a terminator\n");
			$line_terminator_success[$count_terminator] = $i;
			$count_terminator++;
			$terminator_match_success = $true;
		}

	}

	my $length_line_terminator_success = scalar @line_terminator_success;
	print("length_line_terminator_success = $length_line_terminator_success\n");
	my $length_line_global_constant_success = scalar @line_global_constant_success;
	print("length_line_global_constant_success= $length_line_global_constant_success\n");

	if (   $global_constant_success
		&& $terminator_match_success
		&& $count_global_constant == 1 ) {

		my @differences;
		for ( my $i = 0; $i < $length_line_terminator_success; $i++ ) {

			$differences[$i]
				= $line_terminator_success[$i] - $line_global_constant_success[0];
			print("differences = $differences[$i]\n");
		}

	} else {
		print("sudoc2pm, unexpected values \n");
	}

	#		#	Write out the corrected file
	#		#	print("writing out to  $spec_outbound[0]\n");
	#
	#		open( OUT, ">$spec_outbound[0]" ) or die("File  $spe#c_outbound[0] not found");
	#
	#		for ( my $i = 0; $i < $number_of_lines; $i++ ) {
	#
	#				print ("$slurp[$i]\n");
	#				print OUT $slurp[$i] . "\n";
	#
#}
#
#		close(OUT);
#
#	} else {
#		print("sudoc2pm_update, spec string replacement unsuccessful\n");
#	}
#
} else {
	print "sudoc2pm_update: a global constants file is missing!\n";
}    # for a selected global constants file

