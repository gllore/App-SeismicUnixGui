package synseis_spec;
 	our $VERSION = '1.00';
	use Moose;
	use L_SU_global_constants;
	
	use Project_config;
	use synseis_config;
	use SeismicUnix qw ($su $suffix_su);
		
 	my $get					= new L_SU_global_constants();
 	my $var					= $get->var();
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	
	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
	
	my $Project 			= new Project_config;
	my $synseis_config		= new synseis_config;
	
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $max_index           = $synseis_config->get_max_index();
	
=pod

    infile is piped in
    max_index from *.config file

=cut
	my $synseis_spec = {
	_CONFIG					=> 'Nada'
	_DATA_DIR_IN		    => $DATA_SEISMIC_SU,
	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	_binding_index_aref	    => '',
	_suffix_type_in			=> $su,
	_data_suffix_in			=> $suffix_su,
	_suffix_type_out			=> $su,
	_data_suffix_out		=> $suffix_su,
	_file_dialog_type_aref	=> '',
	_flow_type_aref			=> '',		
	_has_infile				=> $false,	
	_has_pipe_in			=> $false,	
	_has_pipe_out           => $false,	 
	_has_redirect_in		=> $false,
	_has_redirect_out		=> $false,
	_has_subin_in			=> $false,
	_has_subin_out			=> $false,
	_is_data				=> $false,
	_is_first_of_2			=> $false,
	_is_first_of_3or_more	=> $false,
	_is_first_of_4or_more	=> $false,
	_is_last_of_2			=> $false,
	_is_last_of_3or_more	=> $false,
	_is_last_of_4or_more	=> $false,
	_is_suprog				=> $false,
	_is_superflow			=> $true,
	_max_index              => $max_index,
};
 
=head2 sub binding_index_aref

=cut

 sub binding_index_aref {
	my $self 	= @_;
	my @index;
	
	$index[0]	= 0;
	
	$synseis_spec->{_binding_index_aref} = \@index;
	
	return();
 }
 
=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{
	my $self 	= @_;
	my @index;
	
	if ($synseis_spec->{_binding_index_aref} ) {
		my $index_aref = $synseis_spec->{_binding_index_aref};
		return($index_aref);
		
	}else {
		print("synseis_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $synseis_spec->{_binding_index_aref};	
	
 }
 
  
=head2 sub get_max_index

=cut

sub get_max_index {
	my $self	= @_;
	
	if ( $synseis_spec->{_max_index} ) {		

		my $max_idx           	  = $synseis_config->get_max_index();
		return($max_idx);
		
	} else {
		print("synseis_spec, get_max_index, missing max_index\n");
		return();
	}
}  
 
=head2 sub file_dialog_type_aref

=cut 

 sub file_dialog_type_aref{
	my ($self) = @_;
	
	my @type;
	
	$type[0]= $file_dialog_type->{_Data};
	
	$synseis_spec->{_file_dialog_type_aref} = \@type;
	
	return();
	
 } 
 
=head2 sub get_file_dialog_type_aref

=cut 

 sub get_file_dialog_type_aref{
	my ($self) = @_;
	
	if ( $synseis_spec->{_file_dialog_type_aref}) {
		my @type	  =  @{$synseis_spec->{_file_dialog_type_aref}};	
		return(\@type);
	} else {
		print("synseis_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	}
 }
  
=head2 sub flow_type_aref

=cut 

 sub flow_type_aref{
	my ($self) = @_;
	
	my @type;
	
	$type[0]		= $flow_type->{_user_built};
	
	$synseis_spec	->{_flow_type_aref} = \@type;
	
	return();
	
 }
  
=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my ($self) = @_;
	
	if ( $synseis_spec->{_flow_type_aref} ) { 				
		my $type_aref = $synseis_spec->{_flow_type_aref};
		return($type_aref);			
	} else {
		
		print("synseis_spec, get_flow_type_aref, missing flow_type_aref \n");
		return();
	}	
 }
 
=head2 sub get_binding_length

=cut 

 sub get_binding_length{
	my ($self) = @_;
		
	if ( $synseis_spec->{_binding_index_aref} ) { 		
		my $length;
		$length = scalar @{$synseis_spec->{_binding_index_aref}};
		return($length);
		
	} else {
		
		print("synseis_spec, get_binding_length, missing length \n");
		return();
	}
	
 }
 
=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my ($self) = @_;
						# print("synseis_spec,variables,
						# first_of_2,$synseis_spec->{_is_first_of_2}\n");
	my $hash_ref = $synseis_spec;
	return ($hash_ref);
}

1;
