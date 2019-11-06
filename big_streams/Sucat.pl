
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
 
 Sucat_config
  Builds a hash of the configuration parameters 

=head2 NOTES 

 We are using Moose.
 Moose already declares that you need debuggers turned on
 so you don't need a line like the following:
 use warnings;
 
 USES the following classes:
 flow
 message
 sucat
 and packages of subroutines
 #System_Variables
 
 =head2 CHANGES
 
  V 2.12 considers empty file_names May 30, 2019; NM

=cut

use Moose;
our $VERSION = '2.12';
use readfiles;
use flow;
use message;
use sucat;
use manage_files_by;
use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
use L_SU_global_constants;
use Sucat_config;

=head2 Declare variables 

    in local memory space

=cut

my ( @file_out, @flow, @items, @cat, @sufile_out, @outbound );

=head2 2. Instantiate classes:

 Create a new version of the package  with a unique name

=cut

my $log  = new message();
my $run  = new flow();
my $cat  = new sucat();
my $read = new readfiles();

my $get          = new L_SU_global_constants->new();
my $Sucat_config = Sucat_config->new();


=head2 Get configuration information

=cut

my ( $CFG_h, $CFG_aref ) = $Sucat_config->get_values();


=head2 set global imported variables

=cut

my $var                  = $get->var();
my $empty_string         = $var->{_empty_string};
my $literal_empty_string = $var->{_literal_empty_string};

# print("Sucat.pl, literal_empty_string: ->$literal_empty_string<- \n");

=head2 set the different parameters

  includes  variables

=cut

my $first_file_number = $CFG_h->{sucat}{1}{first_file_number};
my $last_file_number  = $CFG_h->{sucat}{1}{last_file_number};
my $number_of_files   = $CFG_h->{sucat}{1}{number_of_files};
my $output_file_name  = $CFG_h->{sucat}{1}{output_file_name};
my $input_suffix      = $CFG_h->{sucat}{1}{input_suffix};
my $list_name         = $CFG_h->{sucat}{1}{list};
my $list_directory    = $CFG_h->{sucat}{1}{list_directory};
my $inbound_directory = $CFG_h->{sucat}{1}{inbound_directory};

# print("Sucat,inbound_directory: $inbound_directory\n\n");
# print("Sucat,first_file_number:$first_file_number\n\n");

=head2 3. Declare file names 

  In this version, inbound and outbound directories
  are identical
  If a list exists then read it

=cut

$file_out[1]   = $output_file_name;
$sufile_out[1] = $file_out[1] . $suffix_su;
$outbound[1]   = $inbound_directory . '/' . $sufile_out[1];

my @ref_array;
my $ref_array;
my $num_rows;

if (   $list_name ne $empty_string
    && $list_name ne $literal_empty_string )
{

    # print("Sucat.pl, reading list contents of ->$list_name<- \n");
    # print("Sucat.pl, empty_string:->$empty_string<- \n");
    # print("Sucat.pl, literal_empty_string:->$literal_empty_string<- \n"	);
    ( $ref_array, $num_rows ) = $read->cols_1($list_name);

    # print("ref_array is @$ref_array num_rows is $num_rows\n\n");

}
else {
    print("Sucat.pl,missing list name: NADA\n");
}

=head2 4. create script to concatenate files

 files can be sequential and have
 numeric names or they can be in a list;
 either way supply a directory

=cut

$cat->clear();

if (   $list_name ne $empty_string
    && $list_name ne $literal_empty_string )
{

    print("2. Sucat.pl, list_name: ->$list_name\<-n");
    $cat->list_array($ref_array);
    $cat->list_directory($list_directory);

}
elsif ($list_name eq $empty_string
    or $list_name eq $literal_empty_string )
{

    print("3. Sucat.pl, list_name: $list_name\n");
    $cat->first_file_number($first_file_number);
    $cat->last_file_number($last_file_number);
    $cat->number_of_files($number_of_files);

}
else {
    print("1. Sucat.pl, unexpected list_name\n");
}

$cat->inbound_directory($inbound_directory);
$cat->input_suffix($input_suffix);
$cat[1] = $cat->Step();

=head2 A. DEFINE FLOW(S)

=cut

@items = ( $cat[1], $out, $outbound[1], $go );
$flow[1] = $run->modules( \@items );

=head2  B. RUN FLOW(S)

=cut

$run->flow( \$flow[1] );

=head2 C. LOG FLOW(S)TO SCREEN AND FILE

=cut

print "$flow[1]\n";

#$log->file($flow[1]);
