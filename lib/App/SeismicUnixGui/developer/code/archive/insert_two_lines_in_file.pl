=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  insert_two_lines_in_file.pl							

 AUTHOR: Juan Lorenzo
 DATE:   Oct 4 2018 
 
 DESCRIPTION: 
 Version: 0.0.1

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES


=cut
 	
 	use Moose;
 	use App::SeismicUnixGui::misc::sunix_pl;
 	
 	my $sunix_pl = sunix_pl -> new();
	my ($find_line, $shift);
   	
    my $INPUT 				= '/usr/local/pl/L_SU/developer/scratch';
   	my $OUTPUT				= '/usr/local/pl/L_SU/developer';
   	my $file_suffix			= '_spec.pm';
	
	# What to look for


   	$find_line			= '=head2  sub get_incompatibles';
    $find_line			= '=head2 incompatible parameters';
    $find_line			= '=head2 sub get_max_index';
    $find_line			= '=head2 sub get_flow_type_aref';   
    $find_line			= '\$max_index,'; 
   	print(" looking for a string: [$find_line]\n");
   	
 	# how far down from new_line_number do you want to insert the new lines ?

 	$shift = 68;	# after '=head2 sub get_incompatibles'
 	$shift = 12;	# after '=head2 sub get_incompatibles'
 	$shift = 19;	# after  '=head2 sub get_max_index' 
	$shift = 18;	# after '=head2 sub get_flow_type_aref' 	
	$shift = 1;	# after '=head2 sub get_flow_type_aref' 	
 	 	
=head2 SET UP sunix packages to update


=cut

 	my (@program_name);

 	$program_name[0] 		= 'suxgraph'; #
 	$program_name[1] 		= 'supef'; #
 	$program_name[2]		= 'suacor'; #
 	$program_name[3]		= 'sugain'; #
  	$program_name[4]		= 'xwigb'; # 2 rebuild .pm and config
 	$program_name[5]		= 'suxwigb'; #
 	$program_name[6]		= 'sufilter'; #
  	$program_name[7]		= 'sufft';	#	
   	$program_name[8]		= 'suamp';	# 	
   	$program_name[9]		= 'surange'; #
   	$program_name[10]		= 'sustolt'; #
 	$program_name[11] 		= 'a2b';#
  	$program_name[12] 		= 'sustrip'; #
   	$program_name[13] 		= 'ximage'; #
   	$program_name[14] 		= 'suximage'; #
  	$program_name[15] 		= 'b2a';  # 
   	$program_name[16] 		= 'sustrip'; #
   	$program_name[17] 		= 'xgraph';   # 	
   	$program_name[18] 		= 'sugethw';  #		  				
   	$program_name[19] 		= 'swapbytes';  # 2 rebuild	all 	
   	$program_name[20] 		= 'sushw'; #
   	$program_name[21] 		= 'suwind'; #
   	$program_name[22]		= 'suop';	#
   	$program_name[23]		= 'suop2';		#
    $program_name[24]		= 'data_in'; 	#
    $program_name[25]		= 'data_out'; 	#
    $program_name[26] 		= 'suchw'; 	#
    $program_name[27]       = 'iSpectralAnalysis';
    $program_name[28]       = 'iBottomMute';
    $program_name[29]       = 'iPick';
    $program_name[30]       = 'iTopMute';
    $program_name[31]       = 'Sucat';
    $program_name[32]       = 'Sudipfilt';
    $program_name[33]       = 'Sseg2su';
    $program_name[34]       = 'Synseis';
    $program_name[35]       = 'iVA';
    $program_name[36]       = 'immodpg';   
    
    	# which programs to choose 
    my $start_index 		    = 36;	# this index gets used
   	my $end_index		 	= 37;  # this index does not get used

	# Programs to use =
   	for (my $i = $start_index; $i < $end_index; $i++) {
   	 	
   	 	my $row;	
   		my @section;
   		my $package_name	= $program_name[$i]; 		
   		
   		# New lines to introduce	
 		$section[0] = '	_prefix_aref           => \'\','."\n".
	     '    _suffix_aref'."\t\t\t".'=> \'\',';
   		
#   	print @section;
   		my $new_lines			= $section[0]; 	
   		  		 		  		
   		# SEARCH the FILE(s) 
   		my $file							= $package_name.$file_suffix;
      	print(" file = $file\n");	
   		$sunix_pl							 ->set_perl_file_in($file);   		
   		$sunix_pl      						->set_perl_path($INPUT);
   		my $outbound						= $OUTPUT.'/'.$file;
   	
   		# suck in the file line by line
		$sunix_pl							->whole();

		$sunix_pl							->set_progs_contain($find_line); # 1st identifier
		my $ref_line_numbers 				= $sunix_pl	->get_lines_progs_contain();
		my @all_lines						= @{$sunix_pl->get_whole()};
		my $num_lines						= scalar @all_lines;
		
		# B4 writing a file
		# make sure there is only one line inside ref_line_numbers
		
		my $length = scalar @{$ref_line_numbers};
		
			print("@$ref_line_numbers \n");
			print("num_lines: $num_lines \n");
		
		if ($length == 1) {
			
			print("@$ref_line_numbers \n");
			print("num_lines: $num_lines \n");
			
			my $new_line_number = @{$ref_line_numbers}[0];
			
			$new_line_number = $new_line_number + $shift;
			
   			# open file
   			open (my $fh, '>', $outbound) or die "Could not open file '$outbound' $!";
   			
  				# rewrite ALL lineS	up to the additional line   
  				for (my $i=0; $i < $new_line_number ; $i++) {	
        			$row	= $all_lines[$i];
        			# print "I write: ". $row ."from the file\n";
        			print $fh $row."\n";
    			}
    			
    			# write the additional line 
    			 print $fh $new_lines."\n";
    			
    			#re-write the remaining old lines   			
   				for (my $i=$new_line_number; $i < $num_lines ; $i++) {	
        			$row	= $all_lines[$i];
        			# print "I write: ". $row ."from the file\n";
        			print $fh $row."\n";
    			}   			
    			
   				close($fh);   			 
						
			} else {		
				print("none, or too many line numbers (=$length) \n");
			}		
   	
   	}
   	