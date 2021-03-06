
=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  sudoc2pm.pl							

 AUTHOR: Juan Lorenzo
 DATE:   Jan 25 2018 
 DESCRIPTION: generate (1) package for unix module
 			  and (2) configuration file for the same unix module
 Version: 1.0.1
 1.1 May 2021: updated file searches in directories
 1.1.2 Jan. 2022 use for unix functions that do not have a good  manual to steal

=head2 USE

=head3 NOTES

=head4 Examples sudoc2pm

=head3 NOTES

Program group array and the directory names:

$developer_sunix_categories[12] = 'shell';	
$developer_sunix_categories[16] = '';
$developer_sunix_categories[17] = '';
  	
 	QUESTION 1:
Which group number do you want to use to create
for *.pm, *.config, and *_spec.pm files ?
	

=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '1.1.2';

use sudoc;

use sunix_package 1.1.2;
use prog_doc2pm 0.0.2;

my $sudoc       = sudoc->new();
my $package     = sunix_package->new();
my $prog_doc2pm = prog_doc2pm->new();

my ( @file_in, @pm_file_out );
my (@config_file_out);
my (@spec_file_out);
my (@path_out);
my ($i);
my @file;
my @package_path_out4configs;
my @package_path_out4developer;
my @package_path_out4specs;
my @package_path_out4sunix;

my $sudoc2pm = {
	_names         => '',
	_values        => '',
	_line_contents => '',
};

=head2 SET UP sunix package to build

=cut

#print("sudoc2pm, reading $file_in[0]\n");

=head2 QUESTION 1:
Which group number do you want ?

=cut

my $sunix_category_number = 12;  # shell

$prog_doc2pm->set_group_directory($sunix_category_number);

=head2 QUESTION 2:
Which program do you want to work on?

For example: 
'sugetgthr';
'sugain'; 'suputgthr'; 'suifft';
'sufctanismod' 'vel2stiff
'unif2aniso' 'transp' 'suflip'

psgraph thru psmovie

=cut

my $selected_program_name = 'catsu';

$selected_program_name =~ s/\ //g;

=head2 private values


=cut

my $path_in            = $prog_doc2pm->get_path_in();
my $list_length        = $prog_doc2pm->get_list_length();
my $path_out4configs   = $prog_doc2pm->get_path_out4configs();
my $path_out4developer = $prog_doc2pm->get_path_out4developer();
my $path_out4specs     = $prog_doc2pm->get_path_out4specs();
my $path_out4sunix     = $prog_doc2pm->get_path_out4sunix();
my @long_file_name     = @{ $prog_doc2pm->get_list_aref() };

print("sudoc2pm.pl,long_file_name: @long_file_name\n");
print("sudoc2pm.pl,path_out: $path_out4developer\n");
print("sudoc2pm.pl,list_length: $list_length\n");

my @program_name = @{ $prog_doc2pm->get_program_aref() };
my $package_name;

for ( my $i = 0 ; $i < $list_length ; $i++ ) {

#	print("sudoc2pm.pl,program_name, num=$i, program_name=$program_name[$i]\n");

	$package_name       = $program_name[$i];
	$pm_file_out[0]     = $package_name . '.pm';
	$config_file_out[0] = $package_name . '.config';
	$spec_file_out[0]   = $package_name . '_spec.pm';

#print("sudoc2pm.pl,program_name, selected_program_name=$selected_program_name \n");
print("sudoc2pm.pl, package_name =$package_name \n");

	if ( $selected_program_name eq $package_name ) {

		print("sudoc2pm.pl, I am in group=$sunix_category_number \n");
		#		print("sudoc2pm.pl, I am working on package =$package_name \n");
		#		print("sudoc2pm.pl, writing $pm_file_out[0] in scratch\n");
		#		print("sudoc2pm.pl, writing $config_file_out[0] in scratch\\n");
		#		print("sudoc2pm.pl, writing $spec_file_out[0]in scratch\ \n");

=head2 Read in sunix documentaion
=cut

		my $file = $long_file_name[$i];
		$sudoc->set_file_in_sref( \$file );
		$sudoc->set_perl_path_in($path_in);
		$sudoc->whole();
		my $whole_aref = $sudoc->get_whole();

		my $ans = scalar @$whole_aref;

		#		print("sudoc2pm.pl,num_lines= $ans\n");
		# for (my $i=0; $i <$length; $i++) {
		# 	print("sudoc2pm.pl,All sunix documentation @{$whole_aref}[$i]\n");
		# }

		$sudoc2pm->{_line_contents} = $sudoc->lines_with('=');
		my $sudoc_namVal = $sudoc->parameters( $sudoc2pm->{_line_contents} );
		my $length       = scalar @{ $sudoc_namVal->{_names} };

		print("sudoc2pm.pl, num names count = $length\n");

#		for ( my $i = 0 ; $i < $length ; $i++ ) {
#			print(
#				"\n3. sudoc2pm,_names = _values,
#			     			 line#$i @{$sudoc_namVal->{_names}}[$i] = "
#			);
#			print("@{$sudoc_namVal->{_values}}[$i]\n");
#		}

		$package_path_out4configs[0]   = $path_out4configs;
		$package_path_out4developer[0] = $path_out4developer;
		$package_path_out4specs[0]     = $path_out4specs;
		$package_path_out4sunix[0]     = $path_out4sunix;

		$package->set_file_out( \@pm_file_out );
		$package->set_path_out4configs( \@package_path_out4configs );

		#		$package->set_path_out4developer( \@package_path_out4developer );
		$package->set_path_out4specs( \@package_path_out4specs );
		$package->set_path_out4sunix( \@package_path_out4sunix );
		$package->set_config_file_out( \@config_file_out );
		$package->set_spec_file_out( \@spec_file_out );
		my @package_name_array;
		$package_name_array[0] = $package_name;
		$package->set_package_name( \@package_name_array );
		$package->set_param_names( $sudoc_namVal->{_names} );
		$package->set_param_values( $sudoc_namVal->{_values} );
		$package->set_sudoc_aref($whole_aref);
		$package->write_pm();
		$package->write_config();
		$package->write_spec();
	}
}    # for a selected program name in the group
