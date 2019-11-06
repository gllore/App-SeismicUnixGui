package flows;
 	use Moose;
	use messages::message_director;

	my $L_SU_messages 	    = message_director->new();

=head2 initialize shared anonymous hash 

  key/value pairs

=cut

 my $flows = {
		_corrected_prog_names_aref		=> '',
		_corrected_prog_versions_aref	=> '',
		_message_w						=> '',
		_num_progs4flow					=> '',
    	_prog_name 	   		    		=> '',
    	_prog_version 	   		    	=> '',
		_prog_names_aref				=> '',
		_prog_versions_aref				=> '',
		_symbols_aref				 	=> '',
    };


 my @lines;


=head2 sub param_values

  print("param_values is $package->{_param_values}\n");

=cut

#sub param_values {
#  my($self,$values_aref) = @_;
#  $package->{_param_values} =  $values_aref;
#  $package->{_length} =  scalar @$values_aref;
#  print("package,param_values @{$package->{_param_values}}\n");
#}


# @items   = ($sufilter[1],$in,$inbound[1],$to,
#             $sugain[$sugainVersion],$to,$suximage[1],$go);
# 	$flow[2] = $run->modules(\@items);

=head2 sub get_section

	final assemblage of text for perl script
	this section covers the defined flows
	Removed in V 0.0.2
	if ( ($prog_name[$prog_idx] ne 'data_in') &&  ($prog_name[$prog_idx] ne 'data_out') ) { 

=cut

sub get_section {
	
	my $self =@_;
	my @prog_name 		= @{$flows->{_corrected_prog_names_aref}};
	my @version 		= @{$flows->{_corrected_prog_versions_aref}};
	my @symbol 			= @{$flows->{_symbols_aref}};
    my $num_progs4flow 	= $flows->{_num_progs4flow};
	my $j 				= 0;
	my $prog_idx 		= 0;
 	my @lines;

 	$lines[$j] 			= 
 	"\t".' @items'."\t".'= (';

	if ($num_progs4flow >=0) {
		
		for ($prog_idx=0,$j=1; $prog_idx < ($num_progs4flow-1); $prog_idx++, $j++){
			
    				# print(" flows,get_section,symbols are @symbol \n");
					# print("flows,get_section,prog_name=$prog_name[$prog_idx]\n");
					# print("flows,get_section,num_progs4flow=$num_progs4flow\n");
					# print("flows,get_section,version=$version[$prog_idx]\n");
					# print("flows,get_section,symbol=$symbol[$prog_idx]\n");
		
			$lines[$j]  = "\t\t  ".'$'.$prog_name[$prog_idx].'['."$version[$prog_idx]".'], '.$symbol[$prog_idx].',';
	
		}
		if ( ($prog_name[$prog_idx] ne 'data_in') &&  ($prog_name[$prog_idx] ne 'data_out') ) { 
			
			$lines[$j]  = "\t\t  ".'$'.$prog_name[$prog_idx].'['."$version[$prog_idx]".'],';

		} elsif ($prog_name[$prog_idx] eq 'data_in' ) {
			
			$lines[$j]  = "\t\t  ".'$data_in[1],';

		} elsif ($prog_name[$prog_idx] eq 'data_out' ) {
			
			$lines[$j]  = "\t\t  ".'$data_out[1],';
		}
		
		$j++; $lines[$j]  = "\t\t  ".'$go';
		$j++; $lines[$j]  = "\t\t  ".');';
 		$j++; $lines[$j] = "\t".'$flow[1] = $run->modules(\@items);';

 		return (\@lines);	
		
	} else {
		print("flows,get_section,missing num_progs4flow \n");
	}

}

sub set_num_progs4flow {

	my ($self, $hash_ref) = @_;
	$flows->{_num_progs4flow} 	= $hash_ref->{_num_progs4flow};
			 		#print("1. flows,set_num_progs4flow,number=$flows->{_num_progs4flow}\n");
	return();
}

=head2 sub set_message (widget)

=cut

sub set_message {
	my ($self,$hash_ref) = @_;

	if ( $hash_ref) {
    	$flows->{_message_w} = $hash_ref->{_message_w};
#    			 my $message_w     = $flows->{_message_w};
#				 my	$m          = "flows,set_message,$message_w\n";
# 	  			 $message_w->delete("1.0",'end');
# 	  			 $message_w->insert('end', $m);
		# print("oop_text,set_message, message=$oop_text->{_message}\n");
	}
	return();
}


sub set_prog_name {
	my ($self,$prog_name_href)  = @_;

	if ($prog_name_href) {
		$flows->{_prog_name} = $prog_name_href->{_prog_name};
			#print("1. flows,set_prog_name,prog_name,$flows->{_prog_name}\n");
	}
 	return ();
}


=head2 sub set_prog_names_aref

=cut

sub set_prog_names_aref {
	my ($self,$prog_names_href) = @_;

	if ( $prog_names_href ) {
    	$flows->{_prog_names_aref} = $prog_names_href->{_prog_names_aref}; 
		  		#print("flows,set_prog_names_aref, prog_names=@{$flows->{_prog_names_aref}}\n");
	}
	return();
}

=head2 sub set_specs

	if first program is data_in
    switch with the second program in the list that 
    moves to first location in the flow

	if second file is data_in then OK
	do nothing set symbol to '<' ($in)
	 
	if there is only one item in a flow, do not run the flow

    my $num_progs4flow   =	$flows->{_num_progs4flow};

=cut

sub set_specs {
	my ($self) = @_;
	my (@specs,@prog,@symbols);
	my (@module_spec);
	my ($message_w,$message,$second_last_idx);
	my @corrected_prog_names;
	my @corrected_prog_versions;	
	my $reverse          		= 0;
    my $prog_names_aref	  		= $flows->{_prog_names_aref}; 
	my $prog_names_version_aref = $flows->{_prog_version_aref};
	
		  # print("1. flows,set_specs, prog_names_aref=@{$prog_names_aref}\n");
		  # print("1. flows,set_specs, prog_version_aref=@{$prog_names_version_aref}\n");
	my @prog_names		 		= @$prog_names_aref;
	my @prog_versions	 		= @$prog_names_version_aref;
	my $length 			 		= $flows->{_num_progs4flow};
	my $last_idx   				= $length-1;
	$message_w     				= $flows->{_message_w}; # (widget)
	
	# REVERSE first two items in the flow IF NECESSARY
	if ($length > 1) {
		$second_last_idx 		= $length-2;

		# for the case that data_in is the first item in the flow
		# switch the order of the program and data_in
		if ($prog_names[0] eq  'data_in' ) { $reverse = 1;}

		if ($reverse) {
			my $temp_prog_name 		= $prog_names[1];
			my $temp_prog_version 	= $prog_versions[1];

    		$prog_names[1] 			= $prog_names[0];
    		$prog_versions[1] 		= $prog_versions[0];

			$prog_names[0] 			= $temp_prog_name;
			$prog_versions[0] 		= $temp_prog_version;

			for (my $i = 2; $i < $length; $i++) {
				
				$prog_names[$i] 	= @{$prog_names_aref}[$i]; 
				$prog_versions[$i] 	= @{$prog_names_version_aref}[$i]; 
			}
		}
	# NULL CASE	
	} elsif ($length == 1 ) { # Not enough items in a flow sequence

		print("1.Warning  Only one item in flow--flow may not run: flows,set_specs,length = 0 or 1 \n");
		# for example unif2 can run as a standalone item
		
		my $message_w     	= $flows->{_message_w};			
		my $message          = $L_SU_messages->flows(4);
		# my	$m          = "flows,set_specs,$message_w\n";
 	  	$message_w->delete("1.0",'end');
 	  	$message_w->insert('end', $message);		
		
	} else {
		print("2.Warning No item in flow--flow will not run: flows,set_specs,length = 0 \n");
		
		my $message_w     	= $flows->{_message_w};			
		my $message          = $L_SU_messages->flows(5);
		# my	$m          = "flows,set_specs,$message_w\n";
 	  	$message_w->delete("1.0",'end');
 	  	$message_w->insert('end', $message);
	}

	$flows->{_corrected_prog_names_aref} 	= \@prog_names;
	$flows->{_corrected_prog_versions_aref} = \@prog_versions;
	
	
			# if(@prog_names) {
		       # print("2. flows,set_specs, new prog_names=     @{$flows->{_corrected_prog_names_aref}}\n");
		       # print("3. flows,set_specs, old prog names =    @{$flows->{_prog_names_aref}}\n");
		       # print("2. flows,set_specs, new prog_versions=  @{$flows->{_corrected_prog_versions_aref}}\n");
		       # print("3. flows,set_specs, old prog versions = @{$flows->{_prog_version_aref}}\n");
			#}

	@corrected_prog_names		= @{$flows->{_corrected_prog_names_aref}};
	@corrected_prog_versions	= @{$flows->{_corrected_prog_versions_aref}};

	# USING corrected names and versions, arrange flow sequences
	# Estimate first the redirect and pipe sequences 
	# arrange programs and symbols (>,<,|) in order	
	for ( my $i = 0; $i< $length; $i++ ) {
		
		my $module_spec_pm;
	 	$module_spec[$i] 	= $corrected_prog_names[$i].'_spec'; 
	 	$module_spec_pm     = $module_spec[$i].'.pm';
	 	
		# dynamically used modules need require
    	require $module_spec_pm;
				# print ("flows,set_specs, require $module_spec_pm\n");

		# INSTANTIATE
		$prog[$i]	=  ($module_spec[$i])->new;
				# print ("flows,set_specs, instantiate $module_spec[$i]\n");

    	$specs[$i]	= $prog[$i]->variables();
				# print("flows,set_specs,first_of_2,$[specs$i]->{_is_first_of_2}\n");
	}

	# CASE 1 where 2 items in flow; length, num_progs4flow=2
	# for symbol 0, 1
	if ( $length == 2 ) {
		if ( $specs[0]->{_is_first_of_2} ) {
				# print(" flows,first item is $module_spec[0]\n");
				
			if ( $specs[1]->{_is_last_of_2} ) {
				
				# CASE 1A data_out is last program
				# only if second item is data_out
				if ( $corrected_prog_names[1] eq 'data_out' ) {
					
					# print(" flows, second item is $module_spec[1]\n");
					$symbols[0] = '$out';
							 					
				# only if second item is NOT data_out, i.e. probably data_in
				# BUT not certain this will be the case always TODO 
				} elsif ( ($corrected_prog_names[1] ne 'data_out') 
						&& ($corrected_prog_names[1] ne 'data_in') ) {
												
					# print(" flows, second item is $module_spec[1]\n");			
				 	$symbols[0] = '$to';  # pipe
				 	
				} elsif ($corrected_prog_names[1] eq 'data_in') {
										
					# print(" flows, second item is $module_spec[1]\n");			
				 	$symbols[0] = '$in';  # redirect
				 	
				} else {
					print(" flows, set_specs unexpected case\n");
				}
				
			} else {
				print(" Warning: Second item ($module_spec[1]) is not allowed. Check *spec.pm file (flows,set_specs)\n");
				print(" flows, set_specs, unexpected input\n");
				$message          	= $L_SU_messages->flows(0);
 	  			$message_w			->delete("1.0",'end');
 	  			$message_w			->insert('end', $message);
			}

		} else {
				$message          	= $L_SU_messages->flows(1);
 	  			$message_w->delete("1.0",'end');
 	  			$message_w->insert('end', $message);
				print(" Warning: First item is not allowed. Use another program\n");		
		} # first of two
		
	} # length =2 
	

	# CASE = 3 items in flow; length,num_progs4flow=3

	if ( $length == 3 ) {
		
		# CASE 3.1 first and second items
		# for symbol 0
		# e.g., sugain < data_in
		if ( $specs[0]->{_is_first_of_3or_more} && 
		     $corrected_prog_names[1] eq 'data_in') {
			
			$symbols[0] = '$in';
					# print(" flows,set_specs,case 3.1\n");
			# for Third item
			if ( $specs[2]->{_is_last_of_3or_more} ) {
				
				# CASE 3.1.1 
				# for symbol 1
			    # e.g., sugain < data_in > data_out
				if ( $corrected_prog_names[2] eq 'data_out' ) {
					
					$symbols[1] = '$out';
							# print(" flows,set_specs,case 3.1.1\n");
					
				# CASE 3.1.2 
			    # e.g., sugain < data_in | suximage	
			    # fors symbols[1]
			    
				} elsif ( $specs[2]->{_is_suprog} &&
						  $corrected_prog_names[1] eq 'data_in' &&
						  $specs[2]->{_has_pipe_in}	) {
							# print(" flows,set_specs,corrected_prog_names[1]= $corrected_prog_names[1]\n");
			 		$symbols[1] = '$to' ;
			 		
				} else {  
					$message          	= $L_SU_messages->flows(2);
 	  				$message_w->delete("1.0",'end');
 	  				$message_w->insert('end', $message);
					# print(" Warning: Last item is not allowed. Use data_out or a program (flows,set_specs)\n");
				}
			} else {
				print(" Warning: Last item is not allowed. (flows,set_specs)\n");				
			}
			
		# CASE 3.2 first and second items, 
		# where the first program has internal access to files
		# e.g., suop2 | sugain
		# for symbols[0]
		} elsif ( $specs[0]->{_is_first_of_3or_more} && $specs[0]->{_has_pipe_out} &&
				  $specs[1]->{_is_suprog}            && $specs[1]->{_has_pipe_in} ){
				  	
			$symbols[0] = '$to';
			
			# for Third item
			if ( $specs[2]->{_is_last_of_3or_more} ) {
				
				# CASE 3.2.1 
			    # e.g., suop2 | sugain > data_out
			    # for symbols[1]
				if ( $corrected_prog_names[2] eq 'data_out' ) {
					
					$symbols[1] = '$out';
					
				# CASE 3.2.2 
			    # e.g., suop2 | sugain | suximage
			    # for second symbol symbol[1] between
			    # second and thrid program
				} elsif ( $specs[2]->{_is_suprog}    && 
						  $specs[1]->{_has_pipe_out} &&
					      $specs[2]->{_has_pipe_in}	) {
					
			 		$symbols[1] = '$to' ;
			 		
				} else {  
					$message          	= $L_SU_messages->flows(2);
 	  				$message_w->delete("1.0",'end');
 	  				$message_w->insert('end', $message);
					# print(" Warning: Last item is not allowed. Use data_out or program (flows,set_specs)\n");
				}
			}	
		} else {
				$message          		= $L_SU_messages->flows(3);
 	  			$message_w->delete("1.0",'end');
 	  			$message_w->insert('end', $message);
			# print(" Warning: First or second items are not allowed. (flows,set_specs)\n");
		}	

	} # end of CASE with 3 items in flow

	# CASE 4
	# when there are >=4 items in flow
	if ( $length >= 4 ) {
		# print("flows,set_specs,num_progs=$length\n");
		
		# CASE 4.1 	
		# first and second items, of 4 or more
		# e.g., sugain < data_in ...| suprog
		# for symbols[0]		
		if ( $specs[0]->{_is_first_of_4or_more} && 
			$corrected_prog_names[1] eq 'data_in' ) {
	
			$symbols[0] = '$in';
			# print(" flows,set_specs,case 4.1\n");
			
			# CASE 4.1.1
			# For symbol[1] between second (index=1) and third items (index=2)
		    # for symbols[1]
		    
			 if (    $specs[2]->{_is_suprog}  && 
			 	     $specs[1]->{_has_pipe_out} &&	 
				     $specs[2]->{_has_pipe_in} ) {
			 		
			 	$symbols[1] = '$to' ;
			 		
			 	# print(" flows,set_specs,case 4.1.1\n");
			 		
			 } else{
			 	print(" Warning: Problem with item 2 or beyond, item OK (flows,set_specs)\n");
			 }	# CASE 4.1.1	 				 	
							    				
			
			# CASE 4.1.2
			# Third item and above, of 4 or more items
			# e.g., sugain < data_in | suprog ... > data_out or |	suximage		 	
			# for third item and second symbol and up to symbol between the
			# second- ($j) and third-to-last ($i) of 4 or more items
			# for symbols[2 and above]			
			for ( my $i=2, my $j=3; $i < ($length -2); $i++,$j++) {
				
				if ( $specs[$i]->{_is_suprog}  && 
			 	  	$specs[$i]->{_has_pipe_out} &&	 
				  	$specs[$j]->{_has_pipe_in} ) {
			 		
					$symbols[$i] = '$to' ;
			 		# print(" flows,set_specs,case 4.1.2\n");
			 		
			 	} else{
			 		print(" Case 4.1.2 Warning: Problem with item 3 or beyond, items 1 and 2 OK (flows,set_specs)\n");
			 		print(" Case 4.1.2 flows,set_specs,\n
\tspecs[$i]->{_is_suprog}=$specs[$i]->{_is_suprog} \n
\tspecs[$i]->{_has_pipe_out}=$specs[$i]->{_has_pipe_out} \n
\tspecs[$j]->{_has_pipe_in}=$specs[$j]->{_has_pipe_in}\n");
			 	}		 				 	
			} # CASE 4.1.2
			
			# CASE 4.1.3
			# For last symbol
			if ($specs[$last_idx]->{_is_last_of_4or_more}) {
				
			    # e.g., sugain < data_in | suprog  > data_out
				# CASE 4.1.3.1
				if ( $corrected_prog_names[$last_idx] eq 'data_out'	) {
					
					$symbols[$second_last_idx] = '$out';
							# print(" flows,set_specs,case 4.1.3.1\n");
					
				# CASE 4.1.3.2  sugain < data_in | suprog | suprog
				} elsif ( $specs[$last_idx]->{_is_suprog} && $specs[$last_idx]->{_has_pipe_in}) {
					
			 				# print("flows,set_specs,second_last_idx=$second_last_idx\n");
			 		$symbols[$second_last_idx] = '$to' ;
			 				# print(" flows,set_specs,case 4.1.2.2\n");
			 		
			 	} else {
			 		$message          	= $L_SU_messages->flows(2);
 	  				$message_w->delete("1.0",'end');
 	  				$message_w->insert('end', $message);
 	  				print(" Warning:  3. unexpected last item (flows,set_specs)\n");
					print(" Warning: 3 Last item is not allowed. Use data_out or program (flows,set_specs)\n");	 		
			 	}
			 					
			} else {
				$message          	= $L_SU_messages->flows(2);
 	  			$message_w->delete("1.0",'end');
 	  			$message_w->insert('end', $message);
			 	print(" Warning: 4. unexpected last item (flows,set_specs)\n"); 	  			
				print(" Warning: 4. Last item is not allowed. Use data_out or program (flows,set_specs)\n");
						 				
			} # CASE 4.1.3
			

		# CASE 4.2			
		# for 1st and second item of 4 or more
		# where the first program has internal access to files		
		# e.g., suop2 | suprog | ... suprog .... > data_out or |	suximage
		# for symbols[0]
		} elsif ( $specs[0]->{_is_first_of_4or_more} &&
				  $specs[0]->{_has_pipe_out} &&
				  $specs[1]->{_has_pipe_in} &&
				  $specs[1]->{_is_suprog}     ) {
				  		# print(" flows,set_specs,case 4.2\n");
			$symbols[0] = '$to';
			
			# CASE 4.2.1
			# For symbol between second and third items
		    # for symbols[1]
			if (  $specs[1]->{_is_suprog}  && 
			 	  $specs[1]->{_has_pipe_out} &&	 
				  $specs[2]->{_has_pipe_in} ) {
			 		
			 	$symbols[1] = '$to' ;
			 		
			 			# print(" flows,set_specs,case 4.2.1\n");
			 		
			} else{
			 	print(" Warning: Problem with item 2 or beyond, item OK (flows,set_specs)\n");
			 			 				 	
			}
					    			
			# CASE 4.2.2
			# Third item and above of 4 or more
			# e.g., suop2 | sugain | suprog ... > data_out or |	suximage		 	
			# for third item and up to symbol between the
			# second- ($j) and third-to-last ($i) of 4 or more items
			# for symbols [2 and beyond]
			for ( my $i=2, my $j=3; $i < ($length -2); $i++,$j++) {
				
			 	if ( $specs[$i]->{_is_suprog}  && 
			 	     $specs[$i]->{_has_pipe_out} &&	 
				     $specs[$j]->{_has_pipe_in} ) {
			 				# print(" flows,set_specs,case 4.2.1\n");
			 		$symbols[$j] = '$to' ;
			 		
			 	} else{
			 		print(" Case 4.2.2 Warning: Problem with item 3 or beyond, items 1 and 2 OK (flows,set_specs)\n");
			 	}		 				 	
			}
			
			# CASE 4.2.3
			# Last item and its previous symbol ( last symbol)
			if ($specs[$last_idx]->{_is_last_of_4or_more}) {				
			    
				# CASE 4.2.3.1
				# e.g., sugain | suprog | suprog > data_out	
				# Last item and its previous symbol ( last symbol)							
				if ( $corrected_prog_names[$last_idx] eq 'data_out'	) {
					
					$symbols[$second_last_idx] = '$out';
							# print(" flows,set_specs,case 4.2.3.1\n");
					
				# CASE 4.2.3.2  sugain | suprog | suprog | suprog
				# for last symbol
				} elsif ( $specs[$last_idx]->{_is_suprog} && $specs[$last_idx]->{_has_pipe_in}) {
			 				# print(" flows,set_specs,case 4.2.3.2\n");
			 		$symbols[$second_last_idx] = '$to' ;
			 		
			 	} else {
			 		$message          	= $L_SU_messages->flows(2);
 	  				$message_w->delete("1.0",'end');
 	  				$message_w->insert('end', $message);
 	  				print(" Warning:  1. unexpected last item (flows,set_specs)\n");
					print(" Warning: 1 Last item is not allowed. Use data_out or program (flows,set_specs)\n");	 		
			 	}
			 					
			} else {

				$message          	= $L_SU_messages->flows(2);
 	  			$message_w->delete("1.0",'end');
 	  			$message_w->insert('end', $message);
			 	print(" Warning:  2. unexpected last item (flows,set_specs)\n"); 	  			
				print(" Warning: 2 Last item is not allowed. Use data_out or program (flows,set_specs)\n");	
					 				
			} # CASE 4.2.3
			 				 				 							
		} else { 
			print(" Warning:  unexpected first item (flows,set_specs)\n");
		} # CASE 4.2
				
	} # CASE 4; 4 or more items or more

	$flows->{_symbols_aref} = \@symbols;
				 		# print(" flows,set_specs,symbols are @{$flows->{_symbols_aref}} \n");
	return();
}


=head2 sub set_prog_version_aref
		  print("flows,set_prog_version_aref,prog_version_aref=@{$hash_aref->{_prog_version_aref}}\n");

=cut

sub set_prog_version_aref {
	my ($self,$hash_aref) = @_;

	if ( $hash_aref ) {
    	$flows->{_prog_version_aref} = $hash_aref->{_prog_version_aref}; 
		  # print("flows,set_prog_version_aref,prog_version_aref=@{$flows->{_prog_version_aref}}\n");
	}
	return();
}

1;
