package Synseis_spec;

our $VERSION = '1.00';
use Moose;
use L_SU_global_constants;
use Project_config;
use Sudipfilt_config;
use SeismicUnix qw ($su $suffix_su);
use Synseis_config;

my $get              = new L_SU_global_constants();
my $var              = $get->var();

my $empty_string     = $var->{_empty_string};
my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type        = $get->flow_type_href();

my $true  = $var->{_true};
my $false = $var->{_false};

my $Project        = new Project_config;
my $Synseis_config = new Synseis_config;

my $DATA_SEISMIC_WELL_SYNSEIS = $Project->DATA_SEISMIC_WELL_SYNSEIS();    #  data directories
my $PL_SEISMIC		 = $Project->PL_SEISMIC();

my $max_index = $Synseis_config->get_max_index();

=pod

    infile is piped in
    max_index from *.config file

=cut

my $Synseis_spec = {
	  _CONFIG	 				=> $PL_SEISMIC,
	_DATA_DIR_IN           => $DATA_SEISMIC_WELL_SYNSEIS,
	_DATA_DIR_OUT          => $DATA_SEISMIC_WELL_SYNSEIS,
	_binding_index_aref    => '',
	_suffix_type_in        => $su,
	_data_suffix_in        => $suffix_su,
	_suffix_type_out       => $su,
	_data_suffix_out       => $suffix_su,
	_file_dialog_type_aref => '',
	_flow_type_aref        => '',
	_has_infile            => $false,
	_has_pipe_in           => $false,
	_has_pipe_out          => $false,
	_has_redirect_in       => $false,
	_has_redirect_out      => $false,
	_has_subin_in          => $false,
	_has_subin_out         => $false,
	_is_data               => $false,
	_is_first_of_2         => $false,
	_is_first_of_3or_more  => $false,
	_is_first_of_4or_more  => $false,
	_is_last_of_2          => $false,
	_is_last_of_3or_more   => $false,
	_is_last_of_4or_more   => $false,
	_is_suprog             => $false,
	_is_superflow          => $true,
	_max_index             => $max_index,
	_prefix_aref           => '',
	_suffix_aref           => '',
};

=head2 sub binding_index_aref

=cut

sub binding_index_aref {
	my ($self) = @_;
	my @index;

	$index[0] = 0;

	$Synseis_spec->{_binding_index_aref} = \@index;

	return ();
}

=head2 sub get_binding_index_aref

=cut

sub get_binding_index_aref {
	my ($self) = @_;
	my @index;

	if ( $Synseis_spec->{_binding_index_aref} ) {
		my $index_aref = $Synseis_spec->{_binding_index_aref};
		return ($index_aref);

	}
	else {
		print( "Synseis_spec, get_binding_index_aref, missing binding_index_aref\n" );
		return ();
	}

	my $index_aref = $Synseis_spec->{_binding_index_aref};

}

=head2 sub get_max_index

=cut

sub get_max_index {
	my ($self) = @_;

	if ( $Synseis_spec->{_max_index} ) {

		my $max_idx = $Synseis_config->get_max_index();
		return ($max_idx);

	}
	else {
		print("Synseis_spec, get_max_index, missing max_index\n");
		return ();
	}
}

=head2 sub file_dialog_type_aref

data for a synthetic seismogram is found in the 
default perl flow directory, for now
TODO: synthetic seismogram data could be found in future
in the Well data directories

=cut 

sub file_dialog_type_aref {
	my ($self) = @_;

	my @type;

	$type[0] = $file_dialog_type->{_Data};

	$Synseis_spec->{_file_dialog_type_aref} = \@type;

	return ();

}

=head2 sub get_file_dialog_type_aref

=cut 

sub get_file_dialog_type_aref {
	my ($self) = @_;

	if ( $Synseis_spec->{_file_dialog_type_aref} ) {

		my @type = @{ $Synseis_spec->{_file_dialog_type_aref} };
		return ( \@type );

	}
	else {
		print( "Synseis_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n" );
		return ();
	}
}

=head2 sub flow_type_aref

=cut 

sub flow_type_aref {
	my ($self) = @_;

	my @type;

	$type[0] = $flow_type->{_user_built};

	$Synseis_spec->{_flow_type_aref} = \@type;

	return ();

}

=head2 sub get_flow_type_aref

=cut 

sub get_flow_type_aref {
	my ($self) = @_;

	if ( $Synseis_spec->{_flow_type_aref} ) {
		my $type_aref = $Synseis_spec->{_flow_type_aref};
		return ($type_aref);

	}
	else {

		print("Synseis_spec, get_flow_type_aref, missing flow_type_aref \n");
		return ();
	}
}

=head2 sub get_binding_length

=cut 

sub get_binding_length {
	my ($self) = @_;

	if ( $Synseis_spec->{_binding_index_aref} ) {

		my $length;
		$length = scalar @{ $Synseis_spec->{_binding_index_aref} };
		return ($length);

	}
	else {

		print("Synseis_spec, get_binding_length, missing length \n");
		return ();
	}

}

=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my ($self) = @_;

	# print("Synseis_spec,variables,
	# first_of_2,$Synseis_spec->{_is_first_of_2}\n");
	my $hash_ref = $Synseis_spec;
	return ($hash_ref);
}

1;
