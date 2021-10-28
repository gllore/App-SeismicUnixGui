package sukdmdcs_spec;
<<<<<<< Updated upstream
	use Moose;
=======
<<<<<<< HEAD
use Moose;
=======
	use Moose;
>>>>>>> V0.6.6
>>>>>>> Stashed changes
our $VERSION = '0.0.1';

use Project_config;
use SeismicUnix qw ($bin $su $suffix_bin $suffix_su $suffix_txt $txt);
use L_SU_global_constants;
use sukdmdcs;
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
my $get      = new L_SU_global_constants();
my $Project  = new Project_config;
my $sukdmdcs = new sukdmdcs;

my $var = $get->var();

my $empty_string     = $var->{_empty_string};
my $true             = $var->{_true};
my $false            = $var->{_false};
my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type        = $get->flow_type_href();

my $DATA_SEISMIC_BIN = $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_SU =
  $Project->DATA_SEISMIC_SU();    # output data directory
my $DATA_SEISMIC_TXT = $Project->DATA_SEISMIC_TXT();    # output data directory
my $PL_SEISMIC       = $Project->PL_SEISMIC();
my $max_index        = 34;

my $sukdmdcs_spec = {
	_CONFIG                => $PL_SEISMIC,
	_DATA_DIR_IN           => $DATA_SEISMIC_BIN,
	_DATA_DIR_OUT          => $DATA_SEISMIC_SU,
	_binding_index_aref    => '',
	_suffix_type_in        => $su,
	_data_suffix_in        => $suffix_su,
	_suffix_type_out       => $su,
	_data_suffix_out       => $suffix_su,
	_file_dialog_type_aref => '',
	_flow_type_aref        => '',
	_has_infile            => $true,
	_has_outpar            => $false,
	_has_pipe_in           => $true,
	_has_pipe_out          => $true,
	_has_redirect_in       => $true,
	_has_redirect_out      => $true,
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
=======
>>>>>>> Stashed changes
my $get					= new L_SU_global_constants();
my $Project 				= new Project_config;
my $sukdmdcs		= new sukdmdcs;

my $var					= $get->var();

my $empty_string			= $var->{_empty_string};
my $true					= $var->{_true};
my $false      			= $var->{_false};
my $file_dialog_type		= $get->file_dialog_type_href();
my $flow_type				= $get->flow_type_href();

	my $DATA_SEISMIC_BIN  	= $Project->DATA_SEISMIC_BIN();
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $DATA_SEISMIC_TXT  	= $Project->DATA_SEISMIC_TXT();   # output data directory
  my $PL_SEISMIC		    = $Project->PL_SEISMIC();
 my $max_index = # Insert a number here

	my $sukdmdcs_spec = {
		_CONFIG		            => $PL_SEISMIC,
		_DATA_DIR_IN		    => $DATA_SEISMIC_BIN,
	 	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
		_binding_index_aref	    => '',
	 	_suffix_type_in			=> $su,
		_data_suffix_in			=> $suffix_su,
		_suffix_type_out		=> $su,
	 	_data_suffix_out		=> $suffix_su,
		_file_dialog_type_aref	=> '',
		_flow_type_aref			=> '',
	 	_has_infile				=> $true,
	 	_has_outpar				=> $false,
	 	_has_pipe_in			=> $true,	
	 	_has_pipe_out           => $true,
	 	_has_redirect_in		=> $true,
	 	_has_redirect_out		=> $true,
	 	_has_subin_in			=> $false,
	 	_has_subin_out			=> $false,
	 	_is_data				=> $false,
		_is_first_of_2			=> $true,
		_is_first_of_3or_more	=> $true,
		_is_first_of_4or_more	=> $true,
	 	_is_last_of_2			=> $false,
	 	_is_last_of_3or_more	=> $false,
		_is_last_of_4or_more	=> $false,
		_is_suprog				=> $true,
	 	_is_superflow			=> $false,
	 	_max_index              => $max_index,
	 	_prefix_aref               => '',
	 	_suffix_aref               => '',
	};

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2  sub binding_index_aref

=cut

<<<<<<< Updated upstream
 sub binding_index_aref {

	my $self 	= @_;
=======
<<<<<<< HEAD
sub binding_index_aref {

	my $self = @_;
=======
 sub binding_index_aref {

	my $self 	= @_;
>>>>>>> V0.6.6
>>>>>>> Stashed changes

	my @index;

	# first binding index (index=0)
	# connects to second item (index=1)
	# in the parameter list
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
	$index[0] = 1;     # inbound item is  bound
	$index[1] = 17;    # inbound item is  bound
	$index[2] = 27;    # outbound item is  bound
	$index[3] = 28;    # inbound item is  bound
	$index[4] = 31;    # outbound item is  bound

	$sukdmdcs_spec->{_binding_index_aref} = \@index;
	return ();

}
=======
>>>>>>> Stashed changes
	$index[0] = 1; # inbound item is  bound 
	$index[1]	= 17; # inbound item is  bound
	$index[2]	= 18; # outbound item is  bound
	$index[3]	= 27; # outbound item is  bound
	$index[4]	= 28; # outbound item is  bound
	$index[5]	= 28; # inbound item is  bound

	$sukdmdcs_spec ->{_binding_index_aref} = \@index;
	return();

 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2  sub file_dialog_type_aref

type of dialog (Data, Flow, SaveAs) is needed by binding
one type of dialog for each index
=cut

<<<<<<< Updated upstream
 sub file_dialog_type_aref {

	my $self 	= @_;
=======
<<<<<<< HEAD
sub file_dialog_type_aref {

	my $self = @_;
=======
 sub file_dialog_type_aref {

	my $self 	= @_;
>>>>>>> V0.6.6
>>>>>>> Stashed changes

	my @type;

	my $index_aref = get_binding_index_aref();
	my @index      = @$index_aref;

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
	# bound index will look for data
	$type[0]           = '';
	$type[ $index[0] ] = $file_dialog_type->{_Data};
	$type[ $index[1] ] = $file_dialog_type->{_Data};
	$type[ $index[2] ] = $file_dialog_type->{_Data};
	$type[ $index[3] ] = $file_dialog_type->{_Data};
	$type[ $index[4] ] = $file_dialog_type->{_Data};

		$sukdmdcs_spec ->{_file_dialog_type_aref} = \@type;
	return ();

}
=======
>>>>>>> Stashed changes
		# bound index will look for data
	$type[0]	= '';
#	$type[$index[0]] = $file_dialog_type->{_Data};
#	$type[$index[1]]	=  $file_dialog_type->{_Data};
#	$type[$index[2]]	=  $file_dialog_type->{_Data};

#	$sukdmdcs_spec ->{_file_dialog_type_aref} = \@type;
	return();

 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2  sub flow_type_aref

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub flow_type_aref {

	my $self = @_;

	my @type;

	$type[0] = $flow_type->{_user_built};

	$sukdmdcs_spec->{_flow_type_aref} = \@type;
	return ();

}
=======
>>>>>>> Stashed changes
 sub flow_type_aref {

	my $self 	= @_;

	my @type;

	$type[0]	= $flow_type->{_user_built};

	$sukdmdcs_spec ->{_flow_type_aref} = \@type;
	return();

 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub get_binding_index_aref

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub get_binding_index_aref {

	my $self = @_;
	my @index;

	if ( $sukdmdcs_spec->{_binding_index_aref} ) {

		#	$type[$index[0]] = $file_dialog_type->{_Data};
		#	$type[$index[1]]	=  $file_dialog_type->{_Data};
		#	$type[$index[2]]	=  $file_dialog_type->{_Data};
		my $index_aref = $sukdmdcs_spec->{_binding_index_aref};
		return ($index_aref);

	}
	else {
		print(
"sukdmdcs_spec, get_binding_index_aref, missing binding_index_aref\n"
		);
		return ();
	}

	my $index_aref = $sukdmdcs_spec->{_binding_index_aref};
}
=======
>>>>>>> Stashed changes
 sub get_binding_index_aref{

	my $self 	= @_;
	my @index;

	if ($sukdmdcs_spec->{_binding_index_aref} ) {

		my $index_aref = $sukdmdcs_spec->{_binding_index_aref};
		return($index_aref);

	} else {
		print("sukdmdcs_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $sukdmdcs_spec->{_binding_index_aref};
 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub get_binding_length

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub get_binding_length {

	my $self = @_;

	if ( $sukdmdcs_spec->{_binding_index_aref} ) {

		my $binding_length = scalar @{ $sukdmdcs_spec->{_binding_index_aref} };
		return ($binding_length);

	}
	else {
		print("sukdmdcs_spec, get_binding_length, missing binding_length\n");
		return ();
	}

	return ();
}
=======
>>>>>>> Stashed changes
 sub get_binding_length{

	my $self 	= @_;

	if ($sukdmdcs_spec->{_binding_index_aref} ) {

		my $binding_length= scalar @{$sukdmdcs_spec->{_binding_index_aref}};
		return($binding_length);

	} else {
		print("sukdmdcs_spec, get_binding_length, missing binding_length\n");
		return();
	}

	return();
 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub get_file_dialog_type_aref

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub get_file_dialog_type_aref {

	my $self = @_;
	if ( $sukdmdcs_spec->{_file_dialog_type_aref} ) {

		my $index_aref = $sukdmdcs_spec->{_file_dialog_type_aref};
		return ($index_aref);

	}
	else {
		print(
"sukdmdcs_spec, get_file_dialog_type_aref, missing get_file_dialog_type_aref\n"
		);
		return ();
	}

	return ();
}
=======
>>>>>>> Stashed changes
 sub get_file_dialog_type_aref{

	my $self 	= @_;
	if ($sukdmdcs_spec->{_file_dialog_type_aref} ) {

		my $index_aref = $sukdmdcs_spec->{_file_dialog_type_aref};
		return($index_aref);

	} else {
		print("sukdmdcs_spec, get_file_dialog_type_aref, missing get_file_dialog_type_aref\n");
		return();
	}

	return();
 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub get_flow_type_aref

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub get_flow_type_aref {

	my $self = @_;

	if ( $sukdmdcs_spec->{_flow_type_aref} ) {

		my $index_aref = $sukdmdcs_spec->{_flow_type_aref};
		return ($index_aref);

	}
	else {
		print("sukdmdcs_spec, get_flow_type_aref, missing flow_type_aref\n");
		return ();
	}

}
=======
>>>>>>> Stashed changes
 sub get_flow_type_aref {

	my $self 	= @_;

	if ($sukdmdcs_spec->{_flow_type_aref} ) {

			my $index_aref = $sukdmdcs_spec->{_flow_type_aref};
			return($index_aref);

	} else {
		print("sukdmdcs_spec, get_flow_type_aref, missing flow_type_aref\n");
		return();
	}

 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub get_incompatibles

=cut

<<<<<<< Updated upstream
 sub get_incompatibles{

	my $self 	= @_;
=======
<<<<<<< HEAD
sub get_incompatibles {

	my $self = @_;
=======
 sub get_incompatibles{

	my $self 	= @_;
>>>>>>> V0.6.6
>>>>>>> Stashed changes
	my @needed;

	my @_need_both;

	my @_need_only_1;

	my @_none_needed;

	my @_all_needed;

	my $params = {

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
		_need_both   => \@_need_both,
		_need_only_1 => \@_need_only_1,
		_none_needed => \@_none_needed,
		_all_needed  => \@_all_needed,

	};

	my @of_two = ( 'xx', 'yy' );
	push @{ $params->{_need_only_1} }, \@of_two;

	my $len_1_needed = scalar @{ $params->{_need_only_1} };

	if ( $len_1_needed >= 1 ) {

		for ( my $i = 0 ; $i < $len_1_needed ; $i++ ) {

			print(
"sukdmdcs, get_incompatibles,need_only_1:  @{@{$params->{_need_only_1}}[$i]}\n"
			);

		}

	}
	else {
		print("get_incompatibles, no incompatibles\n");
	}

	return ($params);

}
=======
>>>>>>> Stashed changes
		_need_both			=> \@_need_both,
		_need_only_1		=> \@_need_only_1,
		_none_needed		=> \@_none_needed,
		_all_needed			=> \@_all_needed,

	};

	my @of_two					= ('xx','yy');
	push @{$params->{_need_only_1}}	,	\@of_two;

	my $len_1_needed			= scalar @{$params->{_need_only_1}};

	if ($len_1_needed >= 1) {

		for (my $i=0; $i < $len_1_needed; $i++) {

			print("sukdmdcs, get_incompatibles,need_only_1:  @{@{$params->{_need_only_1}}[$i]}\n");

		}

	} else {
		print("get_incompatibles, no incompatibles\n")
	}

	return($params);

 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub get_prefix_aref

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub get_prefix_aref {

	my $self = @_;

	if ( $sukdmdcs_spec->{_prefix_aref} ) {

		my $prefix_aref = $sukdmdcs_spec->{_prefix_aref};
		return ($prefix_aref);

	}
	else {
		print("sukdmdcs_spec, get_prefix_aref, missing prefix_aref\n");
		return ();
	}

	return ();
}
=======
>>>>>>> Stashed changes
 sub get_prefix_aref {

	my $self 	= @_;

	if ($sukdmdcs_spec->{_prefix_aref} ) {

		my $prefix_aref= $sukdmdcs_spec->{_prefix_aref};
		return($prefix_aref);

	} else {
		print("sukdmdcs_spec, get_prefix_aref, missing prefix_aref\n");
		return();
	}

	return();
 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub get_suffix_aref

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub get_suffix_aref {

	my $self = @_;

	if ( $sukdmdcs_spec->{_suffix_aref} ) {

		my $suffix_aref = $sukdmdcs_spec->{_suffix_aref};
		return ($suffix_aref);

	}
	else {
		print("$sukdmdcs_spec, get_suffix_aref, missing suffix_aref\n");
		return ();
	}

	return ();
}
=======
>>>>>>> Stashed changes
 sub get_suffix_aref {

	my $self 	= @_;

	if ($sukdmdcs_spec->{_suffix_aref} ) {

			my $suffix_aref= $sukdmdcs_spec->{_suffix_aref};
			return($suffix_aref);

	} else {
			print("$sukdmdcs_spec, get_suffix_aref, missing suffix_aref\n");
			return();
	}

	return();
 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2  sub prefix_aref

Include in the Set up
sections of an output Poop flow.

prefixes and suffixes to parameter labels
are filtered by sunix_pl

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub prefix_aref {

	my $self = @_;

	my @prefix;

	for ( my $i = 0 ; $i < $max_index ; $i++ ) {

		$prefix[$i] = $empty_string;

	}

	my $index_aref = get_binding_index_aref();
	my @index      = @$index_aref;

	# label 2 in GUI is input xx_file and needs a home directory
	$prefix[ $index[0] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 18 in GUI is input yy_file and needs a home directory
	$prefix[ $index[1] ] = '$DATA_SEISMIC_SU' . ".'/'.";

	# label 28 in GUI is output zz_file and needs a home directory
	$prefix[ $index[2] ] = '$DATA_SEISMIC_SU' . ".'/'.";

	# label 29 in GUI is input yy_file and needs a home directory
	$prefix[ $index[3] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 32 in GUI is input zz_file and needs a home directory
	$prefix[ $index[4] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	$sukdmdcs_spec->{_prefix_aref} = \@prefix;
	return ();

}
=======
>>>>>>> Stashed changes
 sub prefix_aref {

	my $self 	= @_;

	my @prefix;

	for (my $i=0; $i < $max_index; $i++) {

		$prefix[$i]	= $empty_string;

	}

#	my $index_aref = get_binding_index_aref();
#	my @index       = @$index_aref;

	# label 2 in GUI is input xx_file and needs a home directory
#	$prefix[ $index[0] ] = '$DATA_SEISMIC_BIN' . ".'/'.";

	# label 3 in GUI is input yy_file and needs a home directory
#	$prefix[ $index[1] ] = '$DATA_SEISMIC_TXT' . ".'/'.";

	# label 9 in GUI is input zz_file and needs a home directory
#	$prefix[ $index[2] ] = '$DATA_SEISMIC_SU' . ".'/'.";

	$sukdmdcs_spec ->{_prefix_aref} = \@prefix;
	return();

 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2  sub suffix_aref

Initialize suffixes as empty
values

=cut

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
sub suffix_aref {

	my $self = @_;

	my @suffix;

	for ( my $i = 0 ; $i < $max_index ; $i++ ) {

		$suffix[$i] = $empty_string;

	}

	my $index_aref = get_binding_index_aref();
	my @index      = @$index_aref;

	# label 2 in GUI is input xx_file and needs a home directory
	$suffix[ $index[0] ] = '' . '' . '$suffix_bin';

	# label 18 in GUI is input yy_file and needs a home directory
	$suffix[ $index[1] ] = '' . '' . '$suffix_su';

	# label 28 in GUI is output zz_file and needs a home directory
	$suffix[ $index[2] ] = '' . '' . '$suffix_su';

	# label 29 in GUI is input zz_file and needs a home directory
	$suffix[ $index[3] ] = '' . '' . '$suffix_bin';

	# label 32 in GUI is oinput zz_file and needs a home directory
	$suffix[ $index[4] ] = '' . '' . '$suffix_bin';

	$sukdmdcs_spec->{_suffix_aref} = \@suffix;
	return ();

}
=======
>>>>>>> Stashed changes
 sub suffix_aref {

	my $self 	= @_;

	my @suffix;

	for (my $i=0; $i < $max_index; $i++) {

		$suffix[$i]	= $empty_string;

	}

#	my $index_aref = get_binding_index_aref();
#	my @index       = @$index_aref;

	# label 2 in GUI is input xx_file and needs a home directory
#	$suffix[ $index[0] ] = ''.'' . '$suffix_bin';

	# label 3 in GUI is input yy_file and needs a home directory
#	$suffix[ $index[1] ] = ''.'' . '$suffix_bin';

	# label 9 in GUI is output zz_file and needs a home directory
#	$suffix[ $index[2] ] = ''.'' . '$suffix_su';

	$sukdmdcs_spec ->{_suffix_aref} = \@suffix;
	return();

 }

<<<<<<< Updated upstream
=======
>>>>>>> V0.6.6
>>>>>>> Stashed changes

=head2 sub variables


return a hash array 
with definitions
 
=cut
<<<<<<< Updated upstream
 
=======
<<<<<<< HEAD

=======
 
>>>>>>> V0.6.6
>>>>>>> Stashed changes
sub variables {

	my ($self) = @_;
	my $hash_ref = $sukdmdcs_spec;
	return ($hash_ref);
}

1;
