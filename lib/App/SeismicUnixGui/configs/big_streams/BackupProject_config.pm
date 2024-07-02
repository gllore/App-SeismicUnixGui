package App::SeismicUnixGui::configs::big_streams::BackupProject_config;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PERL PROGRAM NAME: BackupProject_config.pm 
 AUTHOR: Juan Lorenzo
 DATE: June 23 2024 

	
 DESCRIPTION Configuration file set to elicit
      project name via BackupProject_selector

 USED FOR 
     

 Version 1  Based on Sucat_config.pm
     
   

=cut


=head2 LOCAL VARIABLES FOR THIS PROJECT 

 

=cut

use Moose;
our $VERSION = '1.0.1';
use App::SeismicUnixGui::misc::control '0.0.3';
use aliased 'App::SeismicUnixGui::misc::control';
use aliased 'App::SeismicUnixGui::misc::config_superflows';
use App::SeismicUnixGui::configs::big_streams::Project_config;
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';

my $get               = L_SU_global_constants->new();
my $config_superflows = config_superflows->new();
my $control           = control->new();
my $Project           = App::SeismicUnixGui::configs::big_streams::Project_config->new();

my $inbound_directory      = $Project->DATA_SEISMIC_SU(); #defaulted
my $outbound_directory     = $Project->DATA_SEISMIC_SU(); #defaulted
my $superflow_config_names = $get->superflow_config_names_aref();

# WARNING---- watch out for missing underscore!!
# print("1. BackupProject_config,superflow_config_name : $$superflow_config_names[13]\n");

=head2 private hash

=cut

my $BackupProject_config = {
    _prog_name   => '',
    _values_aref => '',
};

## set the superflow name: 13 is for BackupProject
#
#sub get_values {
#    my ($self) = @_;
#
#    # Warning: set using a scalar reference
#    $BackupProject_config->{_prog_name} = \@{$superflow_config_names}[13];
#
#    # print("BackupProject_config, prog_name : @{$superflow_config_names}[13]\n");
#
#    $config_superflows->set_program_name( $BackupProject_config->{_prog_name} );
#
#    # parameter values from superflow configuration file
#    $BackupProject_config->{_values_aref} = $config_superflows->get_values();
#
#    # print("BackupProject_config,values=@{$BackupProject_config->{_values_aref}}\n");
#
#    my $first_file_number_in = @{ $BackupProject_config->{_values_aref} }[0];
#    my $last_file_number_in  = @{ $BackupProject_config->{_values_aref} }[1];
#    my $number_of_files_in   = @{ $BackupProject_config->{_values_aref} }[2];
#
#    my $input_suffix         = @{ $BackupProject_config->{_values_aref} }[3];
#    my $input_name_prefix    = @{ $BackupProject_config->{_values_aref} }[4];
#    my $input_name_extension = @{ $BackupProject_config->{_values_aref} }[5];
#    my $list                 = @{ $BackupProject_config->{_values_aref} }[6];    
#    my $output_file_name     = @{ $BackupProject_config->{_values_aref} }[7];
#    my $alternative_inbound_directory  = @{ $BackupProject_config->{_values_aref} }[8];
#    my $alternative_outbound_directory  = @{ $BackupProject_config->{_values_aref} }[9];
#
#    my $CFG = {
#        sucat => {
#            1 => {
#                first_file_number_in => $first_file_number_in,
#                last_file_number_in  => $last_file_number_in,
#                number_of_files_in   => $number_of_files_in,
#                output_file_name  => $output_file_name,
#                input_suffix      => $input_suffix,
#     			input_name_prefix       => $input_name_prefix,
#    			input_name_extension    => $input_name_extension,             
#                list              => $list,
#                alternative_inbound_directory => $alternative_inbound_directory,
#                alternative_outbound_directory => $alternative_outbound_directory,
#            }
#        }
#    };    # end of CFG hash
#
#    return ( $CFG, $BackupProject_config->{_values_aref} );  # hash and arrary reference
#
#};    # end of sub get_values

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
    my ($self) = @_;

    my $max_index = 0;

    return ($max_index);
}

1;
