package iVA_config;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: iVA_config.pm 
 AUTHOR: Juan Lorenzo
 DATE: Aug 18 2016 
       July 19 2017
       Jan 7 2017
 DESCRIPTION Combines configuration variables
     both from a simple text file and from
     from additional packages.

 USED FOR IVA (interactive velocity analysis)

 Derives from iVA_config.pl
 
 Version 2 based on Sucat.pm June 29 2016
    Added a simple configuration file readable 
    and writable using Config::Simple (CPAN)

    package control replaces commas in strings
    needed by Seismic Unix
    
  July 19 2017 - added tmax_s parameter to configuration file
  January 7, 2017 - remove outside dependency on Config-Simple
     

=cut

=head2 LOCAL VARIABLES FOR THIS PROJECT 

 Values taken from the simple,local
 file: iVA.config called
 LOCAL VARIABLES FOR THIS PROJECT
     base_file_name  				= 'All_cmp'
     cdp_first   				= 15
     cdp_inc    				= 1
     cdp_last    				= 100
     tmax_s             		= .2
     data_scale    				= 1
     dt_s    					= .004
     freq    		    		= '0,3,100,200'
     number_of_velocities   	= 300
     first_velocity   	        = 3
     velocity_increment   		= 10
     min_semblance    	        = .0
     max_semblance    	        = .75
 
=cut 

use Moose;
our $VERSION = '1.0.0';
use config_superflows;
use control;
use L_SU_global_constants;

my $get                    = new L_SU_global_constants();
my $control                = new control;
my $config_superflows      = new config_superflows;
my $superflow_config_names = $get->superflow_config_names_aref();

#WARNING---- watch out for missing underscore!!
# set the correct index manually for this superflow
# print("1. iVA_config, alias_superflow_config_name : $$alias_superflow_config_name[4].config\n");

=head2 private hash


=cut

my $iVA = {
    _prog_name   => '',
    _names_aref  => '',
    _values_aref => '',

    #_check_buttons_settings_aref		=> '',
    #_check_buttons_settings_aref		=> '',
    _superflows_first_idx => '',
    _superflows_length    => '',
};

# set the superflow name: 4 is for iVA
# print("iVA_config, prog_name : @{$superflow_config_names}[4]\n");
# Warning: set using a scalar reference
sub get_values {
    $iVA->{_prog_name} = \@{$superflow_config_names}[4];

    $config_superflows->set_program_name( $iVA->{_prog_name} );

    # parameter names from superflow configuration file
    # $iVA->{_names_aref}  = $config_superflows->get_names();
    # print("iVA_config,prog=@{$iVA->{_names_aref}}\n");

    # parameter values from superflow configuration file
    $iVA->{_values_aref} = $config_superflows->get_values();

    # print("iVA_config,values=@{$iVA->{_values_aref}}\n");

# $iVA->{_check_buttons_settings_aref}  	= $config_superflows->get_check_buttons_settings();
# print("iVA_config,chkb=@{$iVA->{_check_buttons_settings_aref}}\n");

    $iVA->{_superflows_first_idx} = $config_superflows->first_idx();
    $iVA->{_superflows_length}    = $config_superflows->length();

    my $base_file_name       = @{ $iVA->{_values_aref} }[0];
    my $cdp_first            = @{ $iVA->{_values_aref} }[1];
    my $cdp_inc              = @{ $iVA->{_values_aref} }[2];
    my $cdp_last             = @{ $iVA->{_values_aref} }[3];
    my $data_scale           = @{ $iVA->{_values_aref} }[4];
    my $dt_s                 = @{ $iVA->{_values_aref} }[5];
    my $tmax_s               = @{ $iVA->{_values_aref} }[6];
    my $freq                 = @{ $iVA->{_values_aref} }[7];
    my $number_of_velocities = @{ $iVA->{_values_aref} }[8];
    my $first_velocity       = @{ $iVA->{_values_aref} }[9];
    my $velocity_increment   = @{ $iVA->{_values_aref} }[10];
    my $min_semblance        = @{ $iVA->{_values_aref} }[11];
    my $max_semblance        = @{ $iVA->{_values_aref} }[12];

    # check on formats
    $freq = $control->commas( \$freq );    # needed?

    # print(" 1. iVA_config for iVA, base_file_name is $base_file_name\n\n");
    $base_file_name = $control->su_data_name( \$base_file_name );

    # print(" 2. VA_config, for iVA, base_file_name is $base_file_name \n\n");

    # private hash variable
    my $CFG_h = {
        iva => {
            1 => {
                base_file_name       => $base_file_name,
                cdp_first            => $cdp_first,
                cdp_inc              => $cdp_inc,
                cdp_last             => $cdp_last,
                tmax_s               => $tmax_s,
                data_scale           => $data_scale,
                dt_s                 => $dt_s,
                freq                 => $freq,
                first_velocity       => $first_velocity,
                min_semblance        => $min_semblance,
                max_semblance        => $max_semblance,
                number_of_velocities => $number_of_velocities,
                velocity_increment   => $velocity_increment,
            }
        }
    };

    return ( $CFG_h, $iVA->{_values_aref} );    # hash and arrary reference
}    # end of sub get_values

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
    my ($self) = @_;

    # only file_name : index=12
    my $max_index = 12;

    return ($max_index);
}

1;

