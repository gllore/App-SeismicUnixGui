package sufctanismod_spec;
use Moose;
our $VERSION = '0.0.1';

use Project_config;
use SeismicUnix qw ($su $suffix_su);
use L_SU_global_constants;
use sufctanismod;
my $get          = new L_SU_global_constants();
my $Project      = new Project_config;
my $sufctanismod = new sufctanismod;

my $var = $get->var();

my $empty_string     = $var->{_empty_string};
my $true             = $var->{_true};
my $false            = $var->{_false};
my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type        = $get->flow_type_href();

my $DATA_SEISMIC_SU  = $Project->DATA_SEISMIC_SU();     # output data directory
my $DATA_SEISMIC_BIN = $Project->DATA_SEISMIC_BIN();    # input data directory
my $PL_SEISMIC       = $Project->PL_SEISMIC();
my $max_index        = 70;                              #$sufctanismod->get_max_index();

my $sufctanismod_spec = {
	_CONFIG                => $PL_SEISMIC,
	_DATA_DIR_IN           => $DATA_SEISMIC_BIN,
	_DATA_DIR_OUT          => $DATA_SEISMIC_SU,
	_binding_index_aref    => '',
	_suffix_type_in        => $su,                      # N/A
	_data_suffix_in        => $suffix_su,               # N/A
	_suffix_type_out       => $su,
	_data_suffix_out       => $suffix_su,
	_file_dialog_type_aref => '',
	_flow_type_aref        => '',
	_has_infile            => $false,                   # N/A
	_has_outpar            => $false,
	_has_pipe_in           => $false,
	_has_pipe_out          => $false,
	_has_redirect_in       => $false,
	_has_redirect_out      => $false,
	_has_subin_in          => $false,
	_has_subin_out         => $false,
	_is_data               => $false,
	_is_first_of_2         => $true,
	_is_first_of_3or_more  => $true,
	_is_first_of_4or_more  => $true,
	_is_last_of_2          => $false,
	_is_last_of_3or_more   => $false,
	_is_last_of_4or_more   => $false,
	_is_suprog             => $true,
	_is_superflow          => $false,
	_max_index             => $max_index,
	_prefix_aref           => '',
	_suffix_aref           => '',
};

=head2  sub binding_index_aref

=cut

sub binding_index_aref {

	my $self = @_;

	my @index;

	$index[1]  = 1;     # item is  bound to _DATA_DIR_IN
	$index[3]  = 3;     # item is  bound to _DATA_DIR_IN
	$index[14] = 14;    # item is  bound to _DATA_DIR_IN
	$index[32] = 32;    # item is  bound to _DATA_DIR_IN
	$index[40] = 40;    # item is  bound to _DATA_DIR_IN
	$index[48] = 48;    # item is  bound to _DATA_DIR_IN
	$index[55] = 55;    # item is  bound to prefix
	$index[56] = 56;    # item is  bound to prefix
	$index[57] = 57;    # item is  bound to prefix
	$index[59] = 59;    # item is  bound to _DATA_DIR_IN
	$index[67] = 67;    # item is  bound to _DATA_DIR_IN
	$index[68] = 68;    # item is  bound to _DATA_DIR_IN
	$index[69] = 69;    # item is  bound to _DATA_DIR_IN

	$sufctanismod_spec->{_binding_index_aref} = \@index;
	return ();

}

=head2  sub file_dialog_type_aref

type of dialog (Data, Flow, SaveAs) is needed by binding
one type of dialog for each index
=cut

sub file_dialog_type_aref {

	my $self = @_;

	my @type;

	$type[1]  = $file_dialog_type->{_Data};
	$type[3]  = $file_dialog_type->{_Data};
	$type[14] = $file_dialog_type->{_Data};
	$type[32] = $file_dialog_type->{_Data};
	$type[40] = $file_dialog_type->{_Data};
	$type[48] = $file_dialog_type->{_Data};
	$type[55] = $file_dialog_type->{_Data};
	$type[56] = $file_dialog_type->{_Data};
	$type[57] = $file_dialog_type->{_Data};
	$type[59] = $file_dialog_type->{_Data};
	$type[67] = $file_dialog_type->{_Data};
	$type[68] = $file_dialog_type->{_Data};
	$type[69] = $file_dialog_type->{_Data};

	$sufctanismod_spec->{_file_dialog_type_aref} = \@type;
	return ();

}

=head2  sub flow_type_aref

=cut

sub flow_type_aref {

	my $self = @_;

	my @type;

	$type[0] = $flow_type->{_user_built};

	$sufctanismod_spec->{_flow_type_aref} = \@type;
	return ();

}

=head2 sub get_binding_index_aref

=cut

sub get_binding_index_aref {

	my $self = @_;
	my @index;

	if ( $sufctanismod_spec->{_binding_index_aref} ) {

		my $index_aref = $sufctanismod_spec->{_binding_index_aref};
		return ($index_aref);

	} else {
		print("sufctanismod_spec, get_binding_index_aref, missing binding_index_aref\n");
		return ();
	}

	my $index_aref = $sufctanismod_spec->{_binding_index_aref};
}

=head2 sub get_binding_length

=cut

sub get_binding_length {

	my $self = @_;

	if ( $sufctanismod_spec->{_binding_index_aref} ) {

		my $binding_length = scalar @{ $sufctanismod_spec->{_binding_index_aref} };
		return ($binding_length);

	} else {
		print("sufctanismod_spec, get_binding_length, missing binding_length\n");
		return ();
	}

	return ();
}

=head2 sub get_file_dialog_type_aref

=cut

sub get_file_dialog_type_aref {

	my $self = @_;
	if ( $sufctanismod_spec->{_file_dialog_type_aref} ) {

		my $index_aref = $sufctanismod_spec->{_file_dialog_type_aref};
		return ($index_aref);

	} else {
		print("sufctanismod_spec, get_file_dialog_type_aref, missing get_file_dialog_type_aref\n");
		return ();
	}

	return ();
}

=head2 sub get_flow_type_aref

=cut

sub get_flow_type_aref {

	my $self = @_;

	if ( $sufctanismod_spec->{_flow_type_aref} ) {

		my $index_aref = $sufctanismod_spec->{_flow_type_aref};
		return ($index_aref);

	} else {
		print("sufctanismod_spec, get_flow_type_aref, missing flow_type_aref\n");
		return ();
	}

}

=head2 sub get_incompatibles

=cut

sub get_incompatibles {

	my $self = @_;
	my @needed;

	my @_need_both;

	my @_need_only_1;

	my @_none_needed;

	my @_all_needed;

	my $params = {

		_need_both   => \@_need_both,
		_need_only_1 => \@_need_only_1,
		_none_needed => \@_none_needed,
		_all_needed  => \@_all_needed,

	};

	my @of_two = ( 'xx', 'yy' );
	push @{ $params->{_need_only_1} }, \@of_two;

	my $len_1_needed = scalar @{ $params->{_need_only_1} };

	if ( $len_1_needed >= 1 ) {

		for ( my $i = 0; $i < $len_1_needed; $i++ ) {

			print("sufctanismod, get_incompatibles,need_only_1:  @{@{$params->{_need_only_1}}[$i]}\n");

		}

	} else {
		print("get_incompatibles, no incompatibles\n");
	}

	return ($params);

}

=head2 sub get_prefix_aref

=cut

sub get_prefix_aref {

	my $self = @_;

	if ( defined $sufctanismod_spec->{_prefix_aref} ) {

		my $prefix_aref = $sufctanismod_spec->{_prefix_aref};
		return ($prefix_aref);

	} else {
		print("sufctanismod_spec, get_prefix_aref, missing prefix_aref\n");
		return ();
	}

	return ();
}

=head2 sub get_suffix_aref

=cut

sub get_suffix_aref {

	my $self = @_;

	if ( defined $sufctanismod_spec->{_suffix_aref} ) {

		my $suffix_aref = $sufctanismod_spec->{_suffix_aref};
		return ($suffix_aref);

	} else {
		print("$sufctanismod_spec, get_suffix_aref, missing suffix_aref\n");
		return ();
	}

	return ();
}

=head2  sub prefix_aref

Include in the Set up
sections of an output Poop flow.
Also include in iFile for opening directories

prefixes and suffixes to parameter labels
are filtered by sunix_pl

=cut

sub prefix_aref {

	my $self = @_;

	my @prefix;

	for ( my $i = 0; $i < $max_index; $i++ ) {

		$prefix[$i] = $empty_string;

	}

	my $index_aref = get_binding_index_aref();
	my @index      = @$index_aref;

	# label 2 in GUI is input c11_file and needs a home directory
	$prefix[ $index[1] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 4 in GUI is input c33_file and needs a home directory
	$prefix[ $index[3] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 15 in GUI is input rho_file and needs a home directory
	$prefix[ $index[14] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 33 in GUI is input c13_file and needs a home directory
	$prefix[ $index[32] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 41 in GUI is input c44_file and needs a home directory
	$prefix[ $index[40] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 49 in GUI is input c66_file and needs a home directory
	$prefix[ $index[48] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 56 in GUI is input reflxfile and needs a home directory
	$prefix[ $index[55] ] = '$DATA_SEISMIC_SU' . ".'/'.";

	# label 57  in GUI is input reflyfile and needs a home directory
	$prefix[ $index[56] ] = '$DATA_SEISMIC_SU' . ".'/'.";

	# label 58 in GUI is input reflz_file and needs a home directory
	$prefix[ $index[57] ] = '$DATA_SEISMIC_SU' . ".'/'.";

	# label 61 in GUI is input source_file and needs a home directory
	$prefix[ $index[59] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 68 in GUI is input vspx_file and needs a home directory
	$prefix[ $index[67] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 69 in GUI is input vspy_file and needs a home directory
	$prefix[ $index[68] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 70 in GUI is input vspz_file and needs a home directory
	$prefix[ $index[69] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	$sufctanismod_spec->{_prefix_aref} = \@prefix;
	return ();

}

=head2  sub suffix_aref

Include in 
Include in iFile for opening directories
Initialize suffixes as empty

values

=cut

sub suffix_aref {

	my $self = @_;

	my @suffix;

	for ( my $i = 0; $i < $max_index; $i++ ) {

		$suffix[$i] = $empty_string;

	}

	my $index_aref = get_binding_index_aref();
	my @index      = @$index_aref;

	# label 2 n GUI is input c11_file and needs a home directory
	$suffix[ $index[1] ] = "." . '$suffix_bin';

	# label 4 in GUI is input c33_file and needs a home directory
	$suffix[ $index[3] ] = "." . '$suffix_bin';

	# label 15 in GUI is input rho_file and needs a home directory
	$suffix[ $index[14] ] = "." . '$suffix_bin';

	# label 33 in GUI is input c13_file and needs a home directory
	$suffix[ $index[32] ] = "." . '$suffix_bin';

	# label 41 in GUI is input c44_file and needs a home directory
	$suffix[ $index[40] ] = "." . '$suffix_bin';

	# label 49 in GUI is input c66_file and needs a home directory
	$suffix[ $index[48] ] = "." . '$suffix_bin';

	# label 56 in GUI is input reflxfile and needs a home directory
	$suffix[ $index[55] ] = "." . '$suffix_su';

	# label 57  in GUI is input reflyfile and needs a home directory
	$suffix[ $index[56] ] = "." . '$suffix_su';

	# label 58 in GUI is input reflz_file and needs a home directory
	$suffix[ $index[57] ] = "." . '$suffix_su';

	# label 61 in GUI is input source_file and needs a home directory
	$suffix[ $index[59] ] = "." . '$suffix_bin';

	# label 68 in GUI is input vspx_file and needs a home directory
	$suffix[ $index[67] ] = "." . '$suffix_bin';

	# label 69 in GUI is input vspy_file and needs a home directory
	$suffix[ $index[68] ] = "." . '$suffix_bin';

	# label 70 in GUI is input vspz_file and needs a home directory
	$suffix[ $index[69] ] = "." . '$suffix_bin';

	$sufctanismod_spec->{_suffix_aref} = \@suffix;
	
	return ();

}

=head2 sub variables


return a hash array 
with definitions
 
=cut

sub variables {

	my ($self) = @_;
	my $hash_ref = $sufctanismod_spec;
	return ($hash_ref);
}

1;
