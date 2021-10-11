
=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  sudoc2pm_updates.pl							

 AUTHOR: Juan Lorenzo
 DATE:   Septmber 11, 2021 
 DESCRIPTION: update  sunix module
 			  and its spec-file
 			  
 Version: 0.0.1

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
Which group number do you want to use to create
for *.pm, *.config, and *_spec.pm files ?

e.g., for transforms use:
$group_number = 15
	

=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';
use update;

my $update = update->new();


=head2 QUESTION 1:
Which group number do you want ?
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

=cut

my $selected_program_name = 'sudatumk2ds';
my $group_number                   = 1;
$update->set_program($selected_program_name, $group_number);
$update->get_changes();
