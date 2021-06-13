package Project_spec;
our $VERSION = '1.00';
use Moose;
use L_SU_global_constants;
use Project_config;
use SeismicUnix qw ($su $suffix_su);

my $get              = new L_SU_global_constants();
my $var              = $get->var();
my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type        = $get->flow_type_href();

my $true  = $var->{_true};
my $false = $var->{_false};

my $Project = Project_config->new();

my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU();      # output data directory
my $PL_SEISMIC      = $Project->PL_SEISMIC();

#print("Project_spec,PL_SEISMIC=$PL_SEISMIC\n");
my $max_index = $Project->get_max_index();

my $Project_spec = {
	_CONFIG                => $PL_SEISMIC,
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

    Mark the index of the parameter value,
    visible in the GUI, that is bound to MB3.

=cut

sub binding_index_aref {
	my ($self) = @_;
	my @index;

	$index[0] = 0; 
	$index[1] = 1;  
	$index[2] = 2; 
	$index[3] = 3;  
	$index[4] = 4;  
	$index[5] = 5;   
	$index[6] = 6;
	$index[7] = 7;   
		
	$Project_spec->{_binding_index_aref} = \@index;

	return ();
}

=head2 sub get_binding_index_aref

=cut

sub get_binding_index_aref {
	my ($self) = @_;
	my @index;

	if ( $Project_spec->{_binding_index_aref} ) {
		my $index_aref = $Project_spec->{_binding_index_aref};
		return ($index_aref);

	} else {
		print("Project_spec, get_binding_index_aref, missing binding_index_aref\n");
		return ();
	}

	my $index_aref = $Project_spec->{_binding_index_aref}; 	

}

=head2 sub get_max_index

=cut

sub get_max_index {
	my ($self) = @_;

	if ( $Project_spec->{_max_index} ) {

		my $max_idx = $Project->get_max_index();
		return ($max_idx);

	} else {
		print("Project_spec, get_max_index, missing max_index\n");
		return ();
	}
}

=head2 sub file_dialog_type_aref

	ALl cases look for a directory path

=cut 

sub file_dialog_type_aref {
	my ($self) = @_;

	my @type;

	$type[0] = $file_dialog_type->{_Path};
	$type[1] = $file_dialog_type->{_Path};
	$type[2] = $file_dialog_type->{_last_dir_in_path};
	$type[3] = $file_dialog_type->{_last_dir_in_path};
	$type[4] = $file_dialog_type->{_last_dir_in_path};
	$type[5] = $file_dialog_type->{_last_dir_in_path};
	$type[6] = $file_dialog_type->{_last_dir_in_path};
	$type[7] = $file_dialog_type->{_last_dir_in_path};
	# print(" Project_spec, file_dialog_type_aref = $type[2]  \n");
	
	$Project_spec->{_file_dialog_type_aref} = \@type;

	return ();

}

=head2 sub get_file_dialog_type_aref

=cut 

sub get_file_dialog_type_aref {
	my ($self) = @_;

	if ( $Project_spec->{_file_dialog_type_aref} ) {
		my @type = @{ $Project_spec->{_file_dialog_type_aref} };
		return ( \@type );
	} else {
		print("Project_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return ();
	}
}

=head2 sub flow_type_aref

=cut 

sub flow_type_aref {
	my ($self) = @_;

	my @type;

	$type[0] = $flow_type->{_pre_built_superflow};

	$Project_spec->{_flow_type_aref} = \@type;

	return ();

}

=head2 sub get_flow_type_aref

=cut 

sub get_flow_type_aref {
	my ($self) = @_;

	if ( $Project_spec->{_flow_type_aref} ) {
		my $type_aref = $Project_spec->{_flow_type_aref};
		return ($type_aref);
	} else {

		print("Project_spec, get_flow_type_aref, missing flow_type_aref \n");
		return ();
	}
}

=head2 sub get_binding_length

=cut 

sub get_binding_length {
	my ($self) = @_;

	if ( $Project_spec->{_binding_index_aref} ) {
		my $length;
		$length = scalar @{ $Project_spec->{_binding_index_aref} };
		return ($length);

	} else {
		print("Project_spec, get_binding_length, missing length \n");
		return ();
	}

}

=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my ($self) = @_;

	# print("Project_spec,variables, first_of_2,$Project_spec->{_CONFIG}\n");
	my $hash_ref = $Project_spec;
	return ($hash_ref);
}

1;
