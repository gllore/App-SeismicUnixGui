package prog_params;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: prog_params
 AUTHOR: 	Juan Lorenzo
 DATE: 		2018

 DESCRIPTION 
     

 BASED ON:
 Version 0.0.2 July 26 2018   
 changed _private_* to _*
 removed exceptions to data_in and data_out
      

=cut

=head2 USE

=head3 NOTES

=head_for_ Examples

=head2 CHANGES and their DATES

Version 0.0. _for_ Oct 5, 2018
suffixes and prefixes to program parameter values are allowed
by importing the conditions set in each 'program_spec.pm module

=cut

use Moose;
our $VERSION = '0.0._for_';

=head2 program parameters
	 
  private hash
  
=cut


	my $prog_params = {
		_label						=> '',
    	_prog_name 	   		    	=> '',
    	_prog_version 	   		    => '',
    	_param_labels_aref 	   		=> '',
    	_param_values_aref 	   		=> '',
 	};

=head2 sub _get_prefix_aref

	get prefix values externally for the module
	MUST first use prefix_aref method to set prefixes internally 

	use program_name_spec.pm
	bring in a different module 
	each program
	prefix rules are in *_spec.pm
	
=cut


 sub _get_prefix_aref {
	
	my ($self) 		= @_;
	
	if ( $prog_params->{_prog_name} ) {
		
		my $prog_name 			= $prog_params->{_prog_name};	
				
		my $module_spec			= $prog_name.'_spec';
		my $module_spec_pm      = $module_spec.'.pm';
 	
		require $module_spec_pm;		
		my $package				= $module_spec->new;
		
		$package				->prefix_aref();
 		my $prefix_aref 		= $package ->get_prefix_aref();		
		print("prog_params,_get_prefix_aref, prefixes are: @{$prefix_aref}\n");		
		return ($prefix_aref);
		
	} else {	
		
	}
	
	return();
		
 }


=head2 sub _get_suffix_aref

	use program_name_spec.pm
	bring in a different module 
	each program
	suffix rules are in *_spec.pm
	
=cut


 sub _get_suffix_aref {
	
	my $self 		= @_;
	
	if ( $prog_params->{_prog_name} ) {
		
		my $prog_name 			= $prog_params->{_prog_name};	
				
		my $module_spec			= $prog_name.'_spec';
		my $module_spec_pm      = $module_spec.'.pm';
 	
		require $module_spec_pm;		
		my $package				= $module_spec->new;
		
		# set internally and get suffix values externally for the module
		$package				->suffix_aref();
 		my $suffix_aref 		= $package ->get_suffix_aref();		
					print("prog_params,_get_suffix_aref, suffixes are: @{$suffix_aref}\n");
		return ($suffix_aref);
		
	} else {	
		print("prog_params,_get_suffix, missing program name\n");
	}
	
	return();
		
 }
 
 
  sub _get_prefix_for_a_label {
  	
 	my ($self) = @_;
 	
 	use param_sunix;
 	my $param_sunix			= param_sunix -> new();
 	 	
 	my $prefix='';
 	my @all_program_labels;
 	my $labels_aref;
 	my @prefixes;
 	
 	# The following must exist
 	my @all_prog_prefixes 	= @{_get_prefix_aref()};
 	my $label				= $prog_params->{_label};
 	my $program_name		= $prog_params->{_prog_name};
	
	# find all the available names/labels for this program
 	$param_sunix   			->set_program_name(\$program_name);
   	$labels_aref  			= $param_sunix->get_names();
   	@all_program_labels     = @$labels_aref;
   	
   	# number of values not index 
   	my $length  			= $param_sunix->get_length();
   	
   		  # print("2. prog_params,_get_prefix_for_label,  prefix length: $length\n");
 		  # print("2. prog_params,_get_prefix_for_label, prefix labels: @all_program_labels\n");
 		  
    # what's the index in the configuration file (not the perl script)when label names match?   	
    for (my $i=0; $i < $length; $i++) {
    	
		# both labels should contain SOMETHING
		if ($label && $all_program_labels[$i] ) {
  
      		# a match locates the index to read from the program_spec.pm file  		
    		if ($label eq $all_program_labels[$i]) {
    			
    			@prefixes = @{_get_prefix_aref()} ;
    			$prefix	     = $prefixes[$i];

    			# print("prog_params,_get_prefix_for_label, match i=$i, this label=$label other label = $all_program_labels[$i]\n");
    		
    		} else {
    			# NADA print("2. prog_params,_get_prefix_for_label: no match\n"); #NADA 
    		}
    		    		
		} else {
    			# NADA print("2. prog_params,_get_prefix_for_label, this or the other label are empty\n");
    	}
    }
    
 	return($prefix);	
 }

=head2  sub _set_label_for_a_prefix 

=cut

 sub _set_label_for_a_prefix {
 	my ($label) = @_;
 	
 	# needs a program name
 	if ($label && $prog_params->{_prog_name}) {
 		
 		$prog_params->{_label} = $label;		
 		
 	} else {
		print("prog_params,_set_label_for_prefix, missing label and/or program name\n");	
 	}
 	
 	return(); 		
 }
 
 
 sub _get_suffix_for_a_label {
	my ($self) = @_;
 	
 	use param_sunix;
 	my $param_sunix			= param_sunix -> new();
 	 	
 	my $suffix='';
 	my @all_program_labels;
 	my $labels_aref;
 	my @suffixes;
 	
 	# The following must exist
 	my @all_prog_suffixes 	= @{_get_suffix_aref()};
 	my $label				= $prog_params->{_label};
 	my $program_name		= $prog_params->{_prog_name};
	
	# find all the available names/labels for this program
 	$param_sunix   			->set_program_name(\$program_name);
   	$labels_aref  			= $param_sunix->get_names();
   	@all_program_labels     = @$labels_aref;
   	
   	# set half length of number of values not index 
   	$param_sunix			->set_half_length();
   	my $length  			= $param_sunix->get_length();
   	
   		  # print("2. prog_params,_get_suffix_for_label, suffix length: $length\n");
 		  # print("2. prog_params, _get_suffix_for_label,suffix labels: @all_program_labels\n");
 		  
    # what's the index in the configuration file (not the perl script) when label names match?   	
    for (my $i=0; $i < $length; $i++) {
    	
		# both labels should contain SOMETHING
		if ($label && $all_program_labels[$i] ) {
  
      		# a match locates the index to read from the program_spec.pm file  		
    		if ($label eq $all_program_labels[$i]) {
    			
    			@suffixes = @{_get_suffix_aref()} ;
    			$suffix	     = $suffixes[$i];

    			# print("prog_params,_get_suffix_for_label, match i=$i, this label=$label other label = $all_program_labels[$i]\n");
    		
    		} else {
    			#NADA print("2. prog_params, _get_suffix_for_label, no match\n"); 
    		}
    		    		
		} else {
    			#NADA  print("2. prog_params, _get_suffix_for_label this or the other label are empty\n");
    	}
    }
 	 
 	return($suffix);	
 }


 sub _set_label_for_a_suffix {
 	my ($label) = @_;
 
  	# needs a program name	
 	if ($label && $prog_params->{_prog_name}) {
 		
 		$prog_params->{_label} 	= $label;
 					# print("prog_params,_set_label_for_a_suffix,label =$label \n");
 		 		
 	} else {
		print("prog_params,_set_label_for_a_suffix, missing label and/or program name\n");	
 	}
 	
 	return(); 		
 }
 
 
=head2 sub get_a_section
 e.g., 
 	$sugain		        ->clear();
	$sugain				->pbal(1);
	$sugain[1] 			= $sugain->Step();	
 e.g.,
    $suop2			    ->clear();
    $suop2			    ->file1(quotemeta($SEISMIC_PL_SU.'/'.'100_clean');   
    $suop2			    ->file1(quotemeta($SEISMIC_PL_SU.'/'.'100_clean');
    $suop2			    ->op('diff')
    
=cut


sub get_a_section {
	my $self 		= @_;
	
	use control;
	my $control		= new control();
	
	my $prog_name 	= $prog_params->{_prog_name};
	my $j 			= 0;
	
 	my @prog_params;
	my $ok 			= 1; #_get_exceptions();
	
	if ($ok) {
		
 		$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t"."->clear();";
		
		# same as for values
		my $length 		= scalar @{$prog_params->{_param_labels_aref}}; 
		my $version 	= $prog_params->{_prog_version};

    	for (my $param_idx=0,$j=1; $param_idx < $length; $j++,$param_idx++ ) {
    		
			my $label 	= @{$prog_params->{_param_labels_aref}}[$param_idx];		
					# print("1. prog_params,get_section, label = $label\n");
					
			$label		= $control->ors($label);
					# print("2. prog_params,get_section, label = $label\n");
					
			my $value 	= @{$prog_params->{_param_values_aref}}[$param_idx];		

			# after the label has been cleaned (just above)			
			_set_label_for_a_suffix($label);
			my $suffix = _get_suffix_for_a_label;

			_set_label_for_a_prefix($label);
			my $prefix = _get_prefix_for_a_label;
			
			# CASE 1
			if ($prefix && $suffix ) {
				
						# print("prog_params, get_section CASE 1\n");
				# OUTPUT TEXT is set here
				$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t".'->'.$label.'(quotemeta('.$prefix.
				$value.$suffix.'));';
				
			# CASE 2				
			} elsif ( !($prefix) && $suffix ){
				
						# print("prog_params, get_section CASE 2\n");
				# OUTPUT TEXT is set here
				$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t".'->'.$label.'(quotemeta('.
				$value.$suffix.'));';				
				
			# CASE 3				
			} elsif ($prefix && !($suffix) ){
				
				# print("prog_params, get_section CASE 3\n");
				# OUTPUT TEXT is set here
				$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t".'->'.$label.'(quotemeta('.$prefix.
				$value.'));';
							
			# CASE _for_				
			} elsif ($suffix && !($prefix)){
				
							# print("prog_params, get_section = CASE _for_\n");				
				# OUTPUT TEXT is set here
				$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t".'->'.$label.'(quotemeta('.
				$value.$suffix.'));';
							
			# CASE 5				
			} elsif (!($suffix) && !($prefix)){
				
							# print("prog_params, get_section = CASE 5\n");				
				# OUTPUT TEXT is set here
				$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t".'->'.$label.'(quotemeta('.
				$value.'));';
				
			# CASE 6 	
			} else {
				print("prog_params, get_section prefix and suffixes are weird\n");
			}
				# print("2. prog_params,get_section, label,value = $prog_params[$j]\n");					
		}
		
 		$prog_params[$j] = "\t".'$'."$prog_name".'['.
		$version.'] '."\t\t\t".'= $'."$prog_name".'->Step();';
 		return (\@prog_params);

	} else {

		# print("prog_params,get_section, data detected\n");
 		$prog_params[0] = "\t".'place data here'."\n";
 		return (\@prog_params);

	} # no exceptions
}

sub set_many_param_labels {

	my ($self,$param_labels_href)  = @_;

	if ($param_labels_href) {
		$prog_params->{_param_labels_aref} = $param_labels_href->{_prog_param_labels_aref};
			# print("prog_params,set_param_labels,param_labels,@{$prog_params->{_param_labels_aref}}\n");
	}
 	return ();
}


sub set_many_param_values {

	my ($self,$param_values_href)  = @_;

	if ($param_values_href) {
		$prog_params->{_param_values_aref} = $param_values_href->{_prog_param_values_aref};
			# print("prog_params,set_param_values,param_values,@{$prog_params->{_param_values_aref}}\n");
	}
 	return ();
}


sub set_a_prog_name {

	my ($self,$prog_name_href)  = @_;

	if ($prog_name_href) {
		$prog_params->{_prog_name} = $prog_name_href->{_prog_name};
			# print("1. prog_params,set_prog_name,prog_name,$prog_params->{_prog_name}\n");
	}
 	return ();
}


sub set_a_prog_version {

	my ($self,$prog_version_href)  = @_;

	if ($prog_version_href) {
		$prog_params->{_prog_version} = $prog_version_href->{_prog_version};
			# print("1. prog_params,set_prog_version,prog_version,$prog_params->{_prog_version}\n");
	}
 	return ();
}

1;
