package iBottomMute_spec;
our $VERSION = '1.00';
use Moose;
use App::SeismicUnixGui::configs::big_streams::Project_config;
use App::SeismicUnixGui::misc::L_SU_global_constants;
use iBottomMute_config;
use App:SeismicUnixGui::misc::SeismicUnix qw($su $suffix_su);

my $get              = L_SU_global_constants->new();
my $var              = $get->var();
my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type        = $get->flow_type_href();

my $true  = $var->{_true};
my $false = $var->{_false};
my $Project            = Project_config->new();
my $iBottomMute_config = new iBottomMute_config;

my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU();            # output data directory
my $PL_SEISMIC		= $Project->PL_SEISMIC();

my $max_index       = $iBottomMute_config->get_max_index();

my $iBottomMute_spec = {
	_CONFIG					=> $PL_SEISMIC,
	_DATA_DIR_IN           => $DATA_SEISMIC_SU,
	_DATA_DIR_OUT          => $DATA_SEISMIC_SU,
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
};

=head2 sub binding_index_aref

	help bind a parameter (in calling module) 
	to a callback via a mouse-click

=cut

sub binding_index_aref {
	my ($self) = @_;
	my @index;

	$index[0] = 0;

	$iBottomMute_spec->{_binding_index_aref} = \@index;

	return ();
}

=head2 sub get_binding_index_aref

=cut

sub get_binding_index_aref {
	my ($self) = @_;
	my @index;

	if ( $iBottomMute_spec->{_binding_index_aref} ) {
		my $index_aref = $iBottomMute_spec->{_binding_index_aref};
		return ($index_aref);

	}
	else {
		print( "iBottomMute_spec, get_binding_index_aref, missing binding_index_aref\n" );
		return ();
	}

	my $index_aref = $iBottomMute_spec->{_binding_index_aref};

}

=head2 sub get_max_index

=cut

sub get_max_index {
	my ($self) = @_;

	if ( $iBottomMute_spec->{_max_index} ) {

		my $max_idx = $iBottomMute_config->get_max_index();
		return ($max_idx);

	}
	else {
		print("iBottomMute_spec, get_max_index, missing max_index\n");
		return ();
	}
}

=head2 sub file_dialog_type_aref

=cut 

sub file_dialog_type_aref {
	my ($self) = @_;

	my @type;

	$type[0] = $file_dialog_type->{_Data};

	$iBottomMute_spec->{_file_dialog_type_aref} = \@type;

	return ();

}

=head2 sub get_file_dialog_type_aref

=cut 

sub get_file_dialog_type_aref {
	my ($self) = @_;

	if ( $iBottomMute_spec->{_file_dialog_type_aref} ) {
		my @type = @{ $iBottomMute_spec->{_file_dialog_type_aref} };
		return ( \@type );
	}
	else {
		print( "iBottomMute_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n" );
		return ();
	}
}

=head2 sub flow_type_aref

	an array to define the type of flow that is
	being used, e.g., user_built or pre-built superflow (this case)
	important for binding buttons to opening certain directories

=cut 

sub flow_type_aref {
	my ($self) = @_;

	my @type;

	$type[0] = $flow_type->{_pre_built_superflow};

	$iBottomMute_spec->{_flow_type_aref} = \@type;

	return ();

}

=head2 sub get_flow_type_aref

=cut 

sub get_flow_type_aref {
	my ($self) = @_;

	if ( $iBottomMute_spec->{_flow_type_aref} ) {
		my $type_aref = $iBottomMute_spec->{_flow_type_aref};

		return ($type_aref);
	}
	else {

		print("iBottomMute_spec, get_flow_type_aref, missing flow_type_aref \n");
		return ();
	}
}

=head2 sub get_binding_length

=cut 

sub get_binding_length {
	my ($self) = @_;

	if ( $iBottomMute_spec->{_binding_index_aref} ) {
		my $length;
		$length = scalar @{ $iBottomMute_spec->{_binding_index_aref} };
		return ($length);

	}
	else {

		print("iBottomMute_spec, get_binding_length, missing length \n");
		return ();
	}

}

=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my ($self) = @_;

	# print("iBottomMute_spec,variables,
	# first_of_2,$iBottomMute_spec->{_is_first_of_2}\n");
	my $hash_ref = $iBottomMute_spec;
	return ($hash_ref);
}

1;
