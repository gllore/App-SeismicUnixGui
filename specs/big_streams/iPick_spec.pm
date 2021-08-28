package iPick_spec;
our $VERSION = '0.0.1';
use Moose;
use Project_config;
use L_SU_global_constants;
use iPick_config;
use SeismicUnix qw ($su $suffix_su $txt $suffix_txt);

my $get              = new L_SU_global_constants();
my $var              = $get->var();
my $empty_string     = $var->{_empty_string};
my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type        = $get->flow_type_href();

my $true  = $var->{_true};
my $false = $var->{_false};

my $Project          = new Project_config;
my $DATA_SEISMIC_SU  = $Project->DATA_SEISMIC_SU();     # input data directory
my $DATA_SEISMIC_TXT = $Project->DATA_SEISMIC_TXT();    # output data directory
my $PL_SEISMIC		 = $Project->PL_SEISMIC();

print("iPick_spec, PL_SEISMIC=$PL_SEISMIC\n");

my $iPick_config = new iPick_config;
my $max_index    = $iPick_config->get_max_index();

my $iPick_spec =  {
    _CONFIG	 				    => $PL_SEISMIC,
    _DATA_DIR_IN           => $DATA_SEISMIC_SU,
    _DATA_DIR_OUT          => $DATA_SEISMIC_TXT,
	_binding_index_aref    => '',
    _suffix_type_in        => $su,
    _data_suffix_in        => $suffix_su,
    _suffix_type_out       => $txt,
    _data_suffix_out       => $suffix_txt,
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
    _suffix_aref			=> '',
};

=head2 sub binding_index_aref
out
=cut

sub binding_index_aref {
    my ($self) = @_;
    my @index;

    $index[0] = 0;

    $iPick_spec->{_binding_index_aref} = \@index;

    return ();
}

=head2 sub get_binding_index_aref

=cut 	= $Project->DATA_SEISMIC_SU();   # output data directory

sub get_binding_index_aref {
    my ($self) = @_;
    my @index;

    if ( $iPick_spec->{_binding_index_aref} ) {
        my $index_aref = $iPick_spec->{_binding_index_aref};
        return ($index_aref);

    }
    else {
        print(
            "iPick_spec, get_binding_index_aref, missing binding_index_aref\n"
        );
        return ();
    }

    my $index_aref = $iPick_spec->{_binding_index_aref};

}

=head2 sub get_max_index

=cut

sub get_max_index {
    my ($self) = @_;

    if ( $iPick_spec->{_max_index} ) {

        my $max_idx = $iPick_config->get_max_index();
        return ($max_idx);

    }
    else {
        print("iPick_spec, get_max_index, missing max_index\n");
        return ();
    }
}

=head2 sub file_dialog_type_aref
 	= $Project->DATA_SEISMIC_SU();   # output data directory

=cut 

sub file_dialog_type_aref {
    my ($self) = @_;

    my @type;

    $type[0] = $file_dialog_type->{_Data};

    $iPick_spec->{_file_dialog_type_aref} = \@type;

    return ();

}

=head2 sub get_file_dialog_type_aref

=cut 

sub get_file_dialog_type_aref {
    my ($self) = @_;

    if ( $iPick_spec->{_file_dialog_type_aref} ) {
        my @type = @{ $iPick_spec->{_file_dialog_type_aref} };
        return ( \@type );
    }
    else {
        print(
"iPick_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n"
        );
        return ();
    }
}

=head2 sub flow_type_aref

=cut 

sub flow_type_aref {
    my ($self) = @_;

    my @type;

    $type[0] = $flow_type->{_pre_built_superflow};

    $iPick_spec->{_flow_type_aref} = \@type;

    return ();

}

=head2 sub get_flow_type_aref

=cut 

sub get_flow_type_aref {
    my ($self) = @_;

    if ( $iPick_spec->{_flow_type_aref} ) {
        my $type_aref = $iPick_spec->{_flow_type_aref};
        return ($type_aref);
    }
    else {

        print("iPick_spec, get_flow_type_aref, missing flow_type_aref \n");
        return ();
    }
}

=head2 sub get_prefix_aref

=cut

 sub get_prefix_aref {

	my $self 	= @_;

	if ( defined $iPick_spec->{_prefix_aref} ) {

		my $prefix_aref= $iPick_spec->{_prefix_aref};
		return($prefix_aref);

	} else {
		print("iPick_spec, get_prefix_aref, missing prefix_aref\n");
		return();
	}

	return();
 }

=head2 sub get_suffix_aref

=cut

 sub get_suffix_aref {

	my $self 	= @_;

	if ($iPick_spec->{_suffix_aref} ) {

			my $suffix_aref= $iPick_spec->{_suffix_aref};
			return($suffix_aref);

	} else {
			print("iPick_spec, get_suffix_aref, missing suffix_aref\n");
			return();
	}

	return();
 }


=head2  sub prefix_aref

=cut

 sub prefix_aref {

	my $self 	= @_;

	my @prefix;

	for (my $i=0; $i < $max_index; $i++) {

		$prefix[$i]	= $empty_string;

	}
	$iPick_spec ->{_prefix_aref} = \@prefix;
	return();

 }


=head2  sub suffix_aref

=cut

 sub suffix_aref {

	my $self 	= @_;

	my @suffix;

	for (my $i=0; $i < $max_index; $i++) {

		$suffix[$i]	= $empty_string;

	}
	$iPick_spec ->{_suffix_aref} = \@suffix;
	return();

 }


=head2 sub get_binding_length

=cut 

sub get_binding_length {
    my ($self) = @_;

    if ( $iPick_spec->{_binding_index_aref} ) {
        my $length;
        $length = scalar @{ $iPick_spec->{_binding_index_aref} };
        return ($length);

    }
    else {

        print("iPick_spec, get_binding_length, missing length \n");
        return ();
    }

}

=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
    my ($self) = @_;

    # print("iPick_spec,variables,
    # first_of_2,$iPick_spec->{_is_first_of_2}\n");
    my $hash_ref = $iPick_spec;
    return ($hash_ref);
}

1;
