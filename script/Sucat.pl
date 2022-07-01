
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
 Needs a local configuration file Sucat.config
 GUI will generate a new one if needed one, but will
 prefer to use the contents of an existant configuration file. 

=head2 Example Cases

CASE 1
Use a list, for concatenating iVelan pick files ( Vrms,time pairs)
into the correct format

Use a list (file name) WITHOUT values for first 7 parameters (GUI). 
Only include the output name. The alternative directories are optional.
That is, a list can only be used when the values of the prior
7 parameters are blank

Example:
    first_file_number_in               =               
    last_file_number_in                =                
    number_of_files_in                 =                  
    output_file_name                   =           
    input_suffix                       =               
    input_name_prefix                  =                  
    input_name_extension               =              
    list                               =  a file name [found in $PL_SEISMIC]
    output_file_name				   =    
    alternative_inbound_directory      =  [$PL_SEISMIC]             
    alternative_outbound_directory     =  [$PL_SEISMIC]  
    
    The list is expected to be found in $PL_SEISMIC
    
    Internally, the data_type will be determined from the file names in the list
    that will contain "velan" etc." 
    If data_type = velan then the concatenated output file
    will automatically be reformatted for input into
    sunmo.

---------------------------------------------------------------------------

CASE 2
General concatenation of files with patterns in their names

DO NOT use a list. Instead, include values for at least the first 3 
parameters and up to and including values for all the remaining parameters,
except the list. An output name is possible but not required.
 
Example:
  
    first_file_number_in               = 1000                
    last_file_number_in                = 1001                
    number_of_files_in                 = 2                           
    input_suffix                       		 = su                  
    input_name_prefix                   = cdp                 
    input_name_extension             = _clean              
    list                               					=                
    output_file_name                   	= 1000_01 
    alternative_inbound_directory      =                   
    alternative_outbound_directory     =  
    
    The above case will produce
    
    cat DIR1/cdp1000_clean.su DIR1/cdp1001_clean.su > DIR2/1000_01.su
   
    
    A list CAN NOT be in use when 
    any value exists for any of the following:
    
    first_file_number_in                  = 1000                
    last_file_number_in                   = 1010                
    number_of_files_in                    = 11                               
    input_suffix                          		= su           
    input_name_prefix                     = cdp                 
    input_name_extension                  = _clean
    
CASE 3
  
	A. If you want to use a list, the list
	is a file that contains one-
	or multiple nemes of files without an ex


	first_file_number_in  	= 
	last_file_number_in  		= 
	number_of_files_in		= 
	input_suffix  					= 
	input_name_prefix     	= 
	input_name_extension       = 
	list                 									= cat_list_good_sp;
	output_file_name     					= 'All_good_sp';
	alternative_inbound_directory   = 
	alternative_outbound_directory =

 CASE 4:
 
  first_file_number_in   = 1000
  last_file_number_in    = 1010
  number_of_files_in     = 11
   input_suffix  					=  _clean.su
  input_name_prefix     = 
  input_name_extension       = 
  output_file_name    = 1000_10 
 alternative_inbound_directory   = 
 alternative_outbound_directory =

=head2 NOTES 

   The input and output default directories is $PL_SEISMIC
    but these can be overridden by the alternatives
    
 
 =head2 CHANGES
 
  V 0.1.2 considers empty file_names May 30, 2019; NM
  V 0.1.3 includes additional concatenation for:
  (1) sorted ivpicks
  V 0.1.4 update NOTES 9.9.21

=cut

use Moose;
our $VERSION = '0.1.4';
use LSeismicUnix::misc::control '0.0.3';
use LSeismicUnix::configs::big_streams::Project_config;
use LSeismicUnix::misc::readfiles;
use LSeismicUnix::misc::flow;
use LSeismicUnix::misc::message;
use LSeismicUnix::sunix::shell::sucat;
use LSeismicUnix::misc::manage_files_by;
use LSeismicUnix::misc::SeismicUnix
	qw ($_cdp $_mute $in $itop_mute_par_ $ivpicks_sorted_par_ $out $on $go $to $suffix_ascii $off $suffix_su);
use LSeismicUnix::misc::L_SU_global_constants;
use LSeismicUnix::configs::big_streams::Sucat_config;
use LSeismicUnix::specs::big_streams::Sucat_spec;

=head2 Declare variables 

    in local memory space

=cut

my ( @file_out, @flow, @items, @cat, @sufile_out, @outbound );
my $outbound_directory;
my $inbound_directory;
my ( @ref_array, @sucat );
my $ref_array;
my $num_cdps;

=head2 2. Instantiate classes:

 Create a new version of the package  with a unique name

=cut

my $Project    = Project_config->new();
my $control    = control->new();
my $log        = new message();
my $run        = new flow();
my $sucat      = new sucat();
my $read       = new readfiles();
my $Sucat_spec = new Sucat_spec;

my $get          = new L_SU_global_constants->new();
my $Sucat_config = Sucat_config->new();

=head2 Get configuration information
Establish default variables using a *_spec file
and defaults defined hereinf or the location of the list file;
in PL_SEISMIC

=cut

my ( $CFG_h, $CFG_aref ) = $Sucat_config->get_values();
my $Sucat_spec_variables = $Sucat_spec->variables();

my $DATA_DIR_IN  = $Sucat_spec_variables->{_DATA_DIR_IN};
my $DATA_DIR_OUT = $Sucat_spec_variables->{_DATA_DIR_OUT};
my $PL_SEISMIC   = $Project->PL_SEISMIC;

$inbound_directory  = $DATA_DIR_IN;
$outbound_directory = $DATA_DIR_OUT;
my $list_directory = $PL_SEISMIC;

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
$alternative_inbound_directory  = $CFG_h->{sucat}{1}{alternative_inbound_directory};
$alternative_outbound_directory = $CFG_h->{sucat}{1}{alternative_outbound_directory};

=head2 correct input format values

=cut

$list = $control->get_no_quotes($list);

# print("Sucat.pl, list: $list\n\n");
# print("Sucat.pl, list: $data_type\n\n");

=head2 3. Consider compatible
parameter inputs

=cut

# CASE 1: new inbound and or/outbound directories replace defaults
if ( $alternative_outbound_directory ne $empty_string ) {
	$outbound_directory = $alternative_outbound_directory;

	# print("1. Sucat.pl, selected alternative_outbound_directory  $outbound_directory\n");

} elsif ( $alternative_outbound_directory eq $empty_string ) {
	$outbound_directory = $DATA_DIR_OUT;

	# print("2. Sucat.pl, selected outbound_directory $outbound_directory  \n");
} else {
	print("Sucat.pl, unexpected alternative_outbound_directory  \n");
}

if ( $alternative_inbound_directory ne $empty_string ) {
	$inbound_directory = $alternative_inbound_directory;

	# print("1. Sucat.pl, selected alternative inbound_directory=$inbound_directory  \n");
} elsif ( $alternative_inbound_directory eq $empty_string ) {
	$inbound_directory = $DATA_DIR_IN;

	# print("2. Sucat.pl, selected inbound_directory=$inbound_directory  \n");
} else {
	print("Sucat.pl, unexpected alternative_inbound_directory  \n");
}

# print("Sucat.pl,inbound_directory:---$inbound_directory--\n");
# print("Sucat.pl,outbound_directory:---$outbound_directory--\n");

=head2 3. Declare outout file names and their paths

  inbound and outbound directories
  are  defaulted but can be different

=cut

$file_out[1] = $output_file_name;

if ( $input_suffix ne $empty_string ) {

	$outbound[1] = $outbound_directory . '/' . $file_out[1] . '.' . $input_suffix;

} elsif ( $input_suffix eq $empty_string ) {

	$outbound[1] = $outbound_directory . '/' . $file_out[1];

} else {
	print("Sucat.pl,unexpected empty string\n");
}

=header set up sucat

=cut

$sucat->clear();
$sucat->first_file_number_in($first_file_number_in);
$sucat->last_file_number_in($last_file_number_in);
$sucat->number_of_files_in($number_of_files_in);
$sucat->input_suffix($input_suffix);
$sucat->input_name_prefix($input_name_prefix);
$sucat->input_name_extension($input_name_extension);
$sucat->output_file_name($output_file_name);
$sucat->list($list);
$sucat->list_directory($list_directory);
$sucat->inbound_directory($inbound_directory);
$sucat->outbound_directory($outbound_directory);

=head2 4. create script to concatenate files
files may use either a default directory
or an alternative directory provided by the user
Also consider incompatible as well as compatible
parameter inputs

=cut

# CASE 1 If there is a list, we do not need numbers or
# other forms of names
if (    $list ne $empty_string
	and $first_file_number_in eq $empty_string
	and $last_file_number_in eq $empty_string
	and $number_of_files_in eq $empty_string
	and $input_suffix eq $empty_string
	and $input_name_prefix eq $empty_string
	and $input_name_extension eq $empty_string ) {

	# print("2. Sucat.pl, list:---$list---\n");
	# print("2. Sucat.pl, list:---0:@$ref_array[0], 1:@$ref_array[1]\n");
	# my $ans =scalar @$ref_array;
	# print("2. Sucat.pl, num_rows---$ans, $num_rows\n");
	my $inbound_list = $list_directory . '/' . $list;
	( $ref_array, $num_cdps ) = $read->cols_1p($inbound_list);
	$sucat->set_list_aref($ref_array);
	$sucat->data_type();

	# print("ref_array is num_cdps is $num_cdps\n\n");
}

# CASE 2 If there is no list but at least the first 3 file parameters exist
elsif ( $list eq $empty_string
	and $first_file_number_in ne $empty_string
	and $last_file_number_in ne $empty_string
	and $number_of_files_in ne $empty_string ) {

	# print("3. Sucat.pl, OK, NADA\n");

} else {
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

#$log->file($flow[1]);
