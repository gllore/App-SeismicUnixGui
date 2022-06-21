=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  insert_manylines2_in_file.pl							

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
 	use LSeismicUnix::misc::sunix_pl;
 	
 	my $sunix_pl = sunix_pl -> new();
	my ($find_line, $shift);
	
	# which programs to choose 
   	my $end_index		 	= 23;
   	my $start_index 		= 22;
   	
    my $INPUT 				= '/usr/local/pl/developer/scratch';
   	my $OUTPUT				= '/usr/local/pl/developer';
   	my $file_suffix			= '_spec.pm';
	
	# What to look for
   	$find_line			= '=head2 sub get_incompatibles';

    $find_line			= '=head2 sub get_max_index';  	
     	$find_line			= '=head2 sub get_flow_type_aref';  
   	print(" looking for a string: [$find_line]\n");
   	
   	 
 	# how far down from new_line_number do you want to insert the new lines ?
	$shift = 48;	# after '=head2 sub get_incompatibles'

 	$shift = 20;	# after  '=head2 sub get_max_index' 
	$shift = 21;	# after '=head2 sub get_flow_type_aref' 
	   	
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
  	$program_name[7]		= 'sufft';		#
   	$program_name[8]		= 'suamp';	# 	
   	$program_name[9]		= 'surange'; #
   	$program_name[10]		= 'sustolt'; #
 	$program_name[11] 		= 'a2b'; #
  	$program_name[12] 		= 'sustrip';#
   	$program_name[13] 		= 'ximage'; #
   	$program_name[14] 		= 'suximage'; #
  	$program_name[15] 		= 'b2a'; #
   	$program_name[16] 		= 'sustrip'; #
   	$program_name[17] 		= 'xgraph';  # 
   	$program_name[18] 		= 'sugethw';   #	  				
   	$program_name[19] 		= 'swapbytes';  # 2 rebuild	all 	
   	$program_name[20] 		= 'sushw'; #
   	$program_name[21] 		= 'suwind'; #
   	$program_name[22]		= 'suop';	#
   	$program_name[23]		= 'suop2';	    #
    $program_name[24]		= 'data_in';    #
    $program_name[25]		= 'data_out'; 	#
    $program_name[26] 		= 'suchw'; 	#


	
	# Programs to use =
   	for (my $i = $start_index; $i < $end_index; $i++) {
   	 	
   	 	my $row;	
   		my @section;
   		my $package_name	= $program_name[$i]; 		
   		
   		# New lines to introduce	
 		$section[0] = '=head2 sub get_incompatibles'."\n\n".
	'=cut'."\n\n".
	' sub get_incompatibles{'."\n\n".
	"\t".'my $self 	= @_;'."\n".
	"\t".'my @needed;'."\n\n".
	"\t".'my @_need_both;'."\n\n".
	"\t".'my @_need_only_1;'."\n\n".
	"\t".'my @_none_needed;'."\n\n".
	"\t".'my @_all_needed;'."\n\n".	
	"\t".'my $params = {'."\n\n".
	"\t\t".'_need_both'."\t\t\t".'=> \@_need_both,'."\n".
	"\t\t".'_need_only_1'."\t\t".'=> \@_need_only_1,'."\n".
	"\t\t".'_none_needed'."\t\t".'=> \@_none_needed,'."\n".
	"\t\t".'_all_needed'."\t\t\t".'=> \@_all_needed,'."\n\n".		
	"\t".'};'."\n\n".		
	"\t".'my @of_two'."\t\t\t\t\t".'= (\'xx\',\'yy\');'."\n".
	"\t".'push @{$params->{_need_only_1}}	,	\@of_two;'."\n\n".
	"\t".'my $len_1_needed'."\t\t\t".'= scalar @{$params->{_need_only_1}};'."\n\n".	
	"\t".'if ($len_1_needed >= 1) {'."\n\n". 		
	"\t\t".'for (my $i=0; $i < $len_1_needed; $i++) {'."\n\n".
	"\t\t\t".'print("'.$package_name.', get_incompatibles,need_only_1:  @{@{$params->{_need_only_1}}[$i]}\n");'."\n\n".
	"\t\t".'}'."\n\n".		
	"\t".'} else {'."\n".
	"\t\t".'print("get_incompatibles, no incompatibles\n")'."\n".
	"\t".'}'."\n\n".	
	"\t".'return($params);'."\n\n".
	' }'."\n\n\n".
	'=head2 sub get_prefix_aref'."\n\n".
		'=cut'."\n\n".
		' sub get_prefix_aref {'."\n\n".
		"\t".'my $self 	= @_;'."\n\n".	
		"\t".'if ($'.$package_name.'_spec->{_prefix_aref} ) {'."\n\n".
		"\t\t".'my $prefix_aref= $'.$package_name.'_spec->{_prefix_aref};'."\n".
		"\t\t".'return($prefix_aref);'."\n\n".		
		"\t".'} else {'."\n".
		"\t\t".'print("'.$package_name.'_spec, get_prefix_aref, missing prefix_aref\n");'."\n".
		"\t\t".'return();'."\n".
		"\t".'}'."\n\n".
		"\t".'return();'."\n".
 		' }'."\n\n".
	'=head2 sub get_suffix_aref'."\n\n".
	'=cut'."\n".	
	"\n".
	' sub get_suffix_aref {'."\n\n".
	"\t".'my $self 	= @_;'."\n".
	"\n".
	"\t".'if ($'.$package_name.'_spec->{_suffix_aref} ) {'."\n".
	"\n".
	"\t\t".'	my $suffix_aref= $'.$package_name.'_spec->{_suffix_aref};'."\n".
	"\t\t".'	return($suffix_aref);'."\n".
	"\n".
	"\t".'} else {'."\n".
	"\t\t".'	print("'.$package_name.'_spec, get_suffix_aref, missing suffix_aref\n");'."\n".
	"\t\t".'	return();'."\n".
	"\t".'}'."\n".
	"\n".
	"\t".'return();'."\n".	
 	' }'."\n\n\n".
	'=head2  sub prefix_aref'."\n\n".
		'=cut'."\n\n".
		' sub prefix_aref {'."\n\n".
		"\t".'my $self 	= @_;'."\n\n".
		"\t".'my @prefix;'."\n\n".
		"\t".'for (my $i=0; $i < $max_index; $i++) {'."\n\n".
		"\t\t".'$prefix[$i]	= $empty_string;'."\n\n".
		"\t".'}'."\n".
		"\t".'$'.$package_name.'_spec ->{_prefix_aref} = \@prefix;'."\n".	
		"\t".'return();'."\n\n".
 		' }'."\n\n\n".
 		'=head2  sub suffix_aref'."\n\n".
	'=cut'."\n\n".
	' sub suffix_aref {'."\n\n".
	"\t".'my $self 	= @_;'."\n\n".
	"\t".'my @suffix;'."\n\n".
	"\t".'for (my $i=0; $i < $max_index; $i++) {'."\n\n".
	"\t\t".'$suffix[$i]	= $empty_string;'."\n\n".
	"\t".'}'."\n".
	"\t".'$'.$package_name.'_spec ->{_suffix_aref} = \@suffix;'."\n".	
	"\t".'return();'."\n\n".
 	' }'."\n\n";
   		
   		
   		my $new_lines			= $section[0]; 	
   		  		
  		  		
   		# SEARCH the FILE(s) 
   		my $file							= $package_name.$file_suffix;
      				# print(" file = $file\n");	
   		$sunix_pl							->set_perl_file_in($file);   		
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
		
			# print("@$ref_line_numbers \n");
			# print("num_lines: $num_lines \n");
		
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
   	
