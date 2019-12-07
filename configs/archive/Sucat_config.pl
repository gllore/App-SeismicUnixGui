#!/usr/bin/perl  -w

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: Sucat_config.pl 
 AUTHOR: Juan Lorenzo
 DATE: June 23 2016 
	
 DESCRIPTION Combines configuration variables
     both from a simple text file and from
     from additional packages.

 USED FOR 
      Upper-level variable
      definitions in Sucat 
      Can do sets of files with numerically
      sequential  names,
      such as 1000.su, 1001.su, 1002.su etc.
      Seismic data is assumed currently to be in
      su format.

 Version 1  Based on linux command "cat"
 Version 2 based on Sucat.pm June 29 2016
    Added a simple configuration file readable 
    and writable using Config::Simple (CPAN)
 Version 2.1 chnaged local configuration file name 
 	from Sucat2.config Sucat.config 
     
   
 Notes: Simple configuration files is Sucat.config

=cut

=head2 Notes from bash

  cat file1 file2 >output file
 
=cut 

use Moose;
use Config::Simple;
my $cfg = new Config::Simple('Sucat.config');

use Project_config;
my $Project = new Project_config();

use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
my $inbound_directory  = $Project->DATA_SEISMIC_SU();
my $outbound_directory = $Project->DATA_SEISMIC_SU();

=head2 anonymous array referencei $CFG

 contains all the configuration variables in
 perl script

=cut

=head2 Values that are taken from the simple file 
  include 

  $first_file_number
      numerical value, e.g., 100
  $last_file_number 
      numerical value, e.g., 102
  $number_of_files
       numerical value, e.g., 3 
  $list 
      One-line or  multi-line list with sepcific file names
      but without an extension or suffix
  $list_directory 
      Path to directory list 
  $inbound_directory 
      Path to Seismic Unix-formatted Data (currently it is an ~su directory)
  $output_file_name 
      Catted file name
  $input_suffix
      Common to all data files
       
=cut 

my $first_file_number 		= $cfg->param("first_file_number");
my $last_file_number  		= $cfg->param("last_file_number");
my $number_of_files   		= $cfg->param("number_of_files");
my $list              		= $cfg->param("list");
my $list_directory    		= $cfg->param("list_directory");
my $output_file_name  		= $cfg->param("output_file_name");
my $input_suffix      		= $cfg->param("input_suffix");
 $inbound_directory      	= $cfg->param("inbound_directory");
 $outbound_directory      	= $cfg->param("outbound_directory");
#print(" last file number is $last_file_number\n\n");
#print ("Variable1 is $key\n\n");
#
#

=head2 Example LOCAL VARIABLES FOR THIS PROJECT

  uncomment the following 3 lines if you need them, while
  commenting out the last few lines as well
  This package uses a list OR a continuous sequence of define 
  numieric names.

  #$number_of_files	= 10;
  #$first_file_number  	= 1;
  #$last_file_number  	= 10;
  
  $input_suffix  	= '.su';

  $list_directory       = '.';

  $list                 = 'cat_list_good_sp';

  $output_file_name     = 'All_good_sp';

=cut

our $Variable1 = $first_file_number;

our $CFG = {
    sucat => {
        1 => {
            last_file_number  => $last_file_number,
            first_file_number => $first_file_number,
            number_of_files   => $number_of_files,
            list              => $list,
            list_directory    => $list_directory,
            output_file_name  => $output_file_name,
            input_suffix      => $input_suffix,
            inbound_directory => $inbound_directory,
            outbound_directory => $outbound_directory,           
        }
    },
    Variable => $first_file_number
};