package Sucat_config;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: Sucat_config.pm 
 AUTHOR: Juan Lorenzo
 DATE: June 23 2016 
 	   April 10 2018
	
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
 Version 2.2 derives from Sucat_config.pl
 	and removes dependency on Config::Simple (CPAN) 
     
   
 Notes: Simple configuration files is Sucat.config

=cut

=head2 Notes from bash

  cat file1 file2 >output file
 
=cut 

=head2 LOCAL VARIABLES FOR THIS PROJECT 

  One example""
  uncomment the following 3 lines if you need them, while
  commenting out the last few lines as well
  This package uses a list OR a continuous sequence of define 
  numieric names.

  #$number_of_files	= 10;
  #$first_file_number  	= 1;
  #$last_file_number  	= 10;
  
        Common to all data files
  $input_suffix  	= '.su';

  		Path to directory list
  $list_directory       = '.';

  		One-line or  multi-line list with sepcific 
  		file names
  		but without an extension or suffix
  $list                 = 'cat_list_good_sp';

  		Catted file name
  $output_file_name     = 'All_good_sp';

  Another example:
  first_file_number   = 1000  a numerical value,
  last_file_number    = 1010  a numerical value,
  number_of_files     = 11    a numerical value,
  #output_file_name    = 1001_10 
  output_file_name    = 1000_10 
  #output_file_name    = All_good_SH_B4diff 
  #output_file_name    = SH_from_SW 
  #output_file_name    = SH_from_NE 
  input_suffix        =  '_clean.su' 
  #list               = list_good_shot_numbers
  #list               = list_good_shot_numbers
  #list               = list_good_SP_from_SW
  #list               = list_good_SP_from_NE
  list_directory= ./ 

=cut

use Moose;
our $VERSION = '2.2';
use control;
use config_superflows;
use Project_config;
use L_SU_global_constants;

my $get               = new L_SU_global_constants();
my $config_superflows = new config_superflows;
my $control           = new control();
my $Project           = new Project_config;

my $inbound_directory      = $Project->DATA_SEISMIC_SU();
my $superflow_config_names = $get->superflow_config_names_aref();

# WARNING---- watch out for missing underscore!!
# print("1. Sucat_config,superflow_config_name : $$superflow_config_names[10]\n");

=head2 private hash

=cut

my $Sucat_config = {
    _prog_name   => '',
    _values_aref => '',
};

# set the superflow name: 10 is for Sucat

sub get_values {
    my ($self) = @_;

    # Warning: set using a scalar reference
    $Sucat_config->{_prog_name} = \@{$superflow_config_names}[10];

    # print("Sucat_config, prog_name : @{$superflow_config_names}[10]\n");

    $config_superflows->set_program_name( $Sucat_config->{_prog_name} );

    # parameter values from superflow configuration file
    $Sucat_config->{_values_aref} = $config_superflows->get_values();

    # print("Sucat_config,values=@{$Sucat_config->{_values_aref}}}\n");

    my $first_file_number = @{ $Sucat_config->{_values_aref} }[0];
    my $last_file_number  = @{ $Sucat_config->{_values_aref} }[1];
    my $number_of_files   = @{ $Sucat_config->{_values_aref} }[2];
    my $output_file_name  = @{ $Sucat_config->{_values_aref} }[3];
    my $input_suffix      = @{ $Sucat_config->{_values_aref} }[4];
    my $list              = @{ $Sucat_config->{_values_aref} }[5];
    my $list_directory    = @{ $Sucat_config->{_values_aref} }[6];
    my $inbounddirectory  = @{ $Sucat_config->{_values_aref} }[7];

    my $CFG = {
        sucat => {
            1 => {
                first_file_number => $first_file_number,
                last_file_number  => $last_file_number,
                number_of_files   => $number_of_files,
                output_file_name  => $output_file_name,
                input_suffix      => $input_suffix,
                list              => $list,
                list_directory    => $list_directory,
                inbound_directory => $inbound_directory,
            }
        }
    };    # end of CFG hash

    return ( $CFG, $Sucat_config->{_values_aref} );  # hash and arrary reference

};    # end of sub get_values

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
    my ($self) = @_;

    # only file_name : index=7
    my $max_index = 7;

    return ($max_index);
}

1;
