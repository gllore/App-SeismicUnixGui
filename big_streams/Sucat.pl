
=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: Sucat.pl
  Purpose: Concatenate a series files 
  AUTHOR:  Juan M. Lorenzo DEPENDS: on cat from bash 
  DATE:    May 25 
           Includes access to a simple configuration file
           Simple file is called Sucat.config
           Access to simple file is via Sucat2_config.pl
           Sucat2_config.pl uses Config::Simple (jdhedden)
           as well as SeismicUnix and SystemVariables 
           packages V 2.10
           
           April 9 2018
           removed dependency on Config::Simple (CPAN)

  DESCRIPTION: 

=head2 USAGE
 
 Sucat 
 Will need alocal configuration file Sucat.config
 GUi will provide one 

=head2 EXAMPLES 

    
Either: 

Case 1) Use a list without values for first 6 parameters. Only include the output
name. The alternative directories are optional.
That is, a list can only be used when the values of the prior
6 parameters are blank

Example:
    
    first_file_number_in              =               
    last_file_number_in                =                
    number_of_files_in                 =                            
    input_suffix                       =               
    input_name_prefix                  =                  
    input_name_extension               =              
    list                               =  a list_name (found in $PL_SEISMIC)      
    output_file_name                   =       
    alternative_inbound_directory      =  [$PL_SEISMIC]             
    alternative_outbound_directory     =  [$PL_SEISMIC]  

OR

Case 2) Do not use a list. Instead include values for at least the first 3 
parameters and up to and including values for all the remaining parameters,
 except the list
 
Exmples:
 
 Sucat_config
  Builds a hash of the configuration parameters
    first_file_number_in               = 1000                
    last_file_number_in                = 1001                
    number_of_files_in                 = 11                             
    input_suffix                       = su                  
    input_name_prefix                  = cdp                 
    input_name_extension               = _clean              
    list                               =  
    output_file_name                   = 1000_01                 
    alternative_inbound_directory      =                   
    alternative_outbound_directory     =  
    
    The above case will produce
    
    cat DIR1/cdp1000_clean.su DIR1/cdp1001_clean.su > DIR2/1000_01.su
    wher DIR1
   
    A list can not be in use when 
    any value exists for any of the following:
    
    first_file_number_in                  = 1000                
    last_file_number_in                   = 1010                
    number_of_files_in                    = 11                               
    input_suffix                          = su                  
    input_name_prefix                     = cdp                 
    input_name_extension                  = _clean
 
=head2 NOTES 

    Defaults are to have DIR1=DIR2 but these can be overridden by the alternatives
    The input and output default directories is [$PL_SEISMIC]
    The list is expected to be found also in [$PL_SEISMIC]
    Internally, the data_type can be mute, velan 
    If data_type = mute or velan then the concatenated output file
    will automatically be reformatted for input into
    sunmo, or sumute respectively

 We are using Moose.
 Moose already declares that you need debuggers turned on
 so you don't need a line like the following:
 use warnings;
 
 TODO: other formats, and other default output directories
 e.g., perhaps in future mute and velan picks should be in the 
 'txt' directories or in their own 'mute' or 'velan' directories
 
 USES the following classes:
 flow
 message
 sucat
 and packages of subroutines
 #System_Variables
 
 =head2 CHANGES
 
  V 0.1.2 considers empty file_names May 30, 2019; NM
  V 0.1.3 includes additional concatenation for:
  (1) sorted ivpicks and (2) sorted imute picks

=cut

use Moose;
our $VERSION = '0.1.3';
use control;
use Project_config;
use readfiles;
use flow;
use message;
use sucat;
use manage_files_by;
use SeismicUnix
	qw ($_cdp $_mute $in $itop_mute_par_ $ivpicks_sorted_par_ $out $on $go $to $suffix_ascii $off $suffix_su);
use L_SU_global_constants;
use Sucat_config;
use Sucat_spec;

=head2 Declare variables 

    in local memory space

=cut

my ( @file_out, @flow, @items, @cat, @sufile_out, @outbound );
my $outbound_directory;
my $inbound_directory;
my ( @ref_array, @sucat );
my $ref_array;
my $num_cdps;
my ($DIR_IN,$DIR_OUT);

=head2 2. Instantiate classes:

 Create a new version of the package  with a unique name

=cut

my $Project    = Project_config->new();
my $control    = control->new();
my $log        = new message();
my $run        = new flow();
my $sucat      = new sucat();
my $read       = new readfiles();

my $get          = new L_SU_global_constants->new();
my $Sucat_config = Sucat_config->new();

=head2 Get configuration information
and defaults defined herein for the location of the list file,
in PL_SEISMIC

=cut

my ( $CFG_h, $CFG_aref ) = $Sucat_config->get_values();

my $PL_SEISMIC   = $Project->PL_SEISMIC;
my $list_directory  = $PL_SEISMIC;

# clear all the variables in sucat.pm
$sucat->clear();
$sucat->list_directory($list_directory);

=head2 set global imported variables

=cut

my $var                  = $get->var();
my $empty_string         = $var->{_empty_string};
my $literal_empty_string = $var->{_literal_empty_string};

# print("Sucat.pl, literal_empty_string: ->$literal_empty_string<- \n");

=head2 set the different parameters

  includes  variables

=cut

my $alternative_outbound_directory = '';
my $alternative_inbound_directory  = '';

my $first_file_number_in = $CFG_h->{sucat}{1}{first_file_number_in};
my $last_file_number_in  = $CFG_h->{sucat}{1}{last_file_number_in};
my $number_of_files_in   = $CFG_h->{sucat}{1}{number_of_files_in};
my $output_file_name     = $CFG_h->{sucat}{1}{output_file_name};
my $input_suffix         = $CFG_h->{sucat}{1}{input_suffix};
my $input_name_prefix    = $CFG_h->{sucat}{1}{input_name_prefix};
my $input_name_extension = $CFG_h->{sucat}{1}{input_name_extension};
my $list                 = $CFG_h->{sucat}{1}{list};
$alternative_inbound_directory =
	$CFG_h->{sucat}{1}{alternative_inbound_directory};
$alternative_outbound_directory =
	$CFG_h->{sucat}{1}{alternative_outbound_directory};

=head2 correct input format values

=cut

$list      = $control->get_no_quotes($list);

# print("1. Sucat.pl, list: $list\n\n");

=header set up sucat

=cut

$sucat->first_file_number_in($first_file_number_in);
$sucat->last_file_number_in($last_file_number_in);
$sucat->number_of_files_in($number_of_files_in);
$sucat->input_suffix($input_suffix);
$sucat->input_name_prefix($input_name_prefix);
$sucat->input_name_extension($input_name_extension);
$sucat->output_file_name($output_file_name);
$sucat->list_name($list);
$sucat->alternative_inbound_directory($alternative_outbound_directory);
$sucat->alternative_outbound_directory($alternative_outbound_directory);


=head2
the inbound and outbound directories can be overridden if there
are alternative directory paths

=cut

$outbound_directory = $sucat->get_outbound_directory;

=head2 3. Declare outout file names and their paths

  inbound and outbound directories
  are defaulted but can be different

=cut

$file_out[1] = $output_file_name;

if ( $input_suffix ne $empty_string ) {

	$outbound[1] =
		$outbound_directory . '/' . $file_out[1] . '.' . $input_suffix;

}
elsif ( $input_suffix eq $empty_string ) {

	$outbound[1] = $outbound_directory . '/' . $file_out[1];

}
else {
	print("Sucat.pl,unexpected empty string\n");
}


=head2 4. create script to concatenate files
files may use either a default directory
or an alternative directory provided by the user
Also consider incompatible as well as compatible
parameter inputs

=cut

# CASE 1 If there is a list
# 1. we do not need numbers or other forms of names
# 2. data type is determined automatically from names in the list
# inside sucat.pm

if (    $list ne $empty_string
	and $first_file_number_in eq $empty_string
	and $last_file_number_in eq $empty_string
	and $number_of_files_in eq $empty_string
	and $input_suffix eq $empty_string
	and $input_name_prefix eq $empty_string
	and $input_name_extension eq $empty_string )
{

		print("2. Sucat.pl, list:---$list---\n");

		my $inbound_list = $list_directory . '/' . $list;
		( $ref_array, $num_cdps ) = $read->cols_1p($inbound_list);
		# print("2. Sucat.pl, num_cdps $num_cdps\n");
		$sucat->set_list_aref($ref_array);
		$sucat->data_type();

		# print("ref_array is num_cdps is $num_cdps\n\n");
}

# CASE 2 If there is no list but at least the first 3 file parameters exist
# 1. data_type is not set
elsif ( $list eq $empty_string
	and $first_file_number_in ne $empty_string
	and $last_file_number_in ne $empty_string
	and $number_of_files_in ne $empty_string )
{

	# print("3. Sucat.pl, OK, empty list, NADA\n");

}
else {
	print(
		"Warning: Incorrect settings. Either: 
\t 1) Use a list without values for first 6 parameters. Include the output
\t name (the alternative directories are optional).
\t That is, a list can only be used when the values of the prior
\t 6 parameters are blank
\t 2) Do not use a list. Instead include values for at least the first 3 
\t parameters and up to and including values for all the remaining parameters,
\t except the list\n"
	);
}

$sucat[1] = $sucat->Step();

=head2 A. DEFINE FLOW(S)

=cut

 @items = ( $sucat[1], $out, $outbound[1], $go );

 $flow[1] = $run->modules( \@items );

=head2  B. RUN FLOW(S)

=cut

 $run->flow( \$flow[1] );

=head2 C. LOG FLOW(S)TO SCREEN AND FILE
=cut

 print "$flow[1]\n";

# $log->file($flow[1]);
