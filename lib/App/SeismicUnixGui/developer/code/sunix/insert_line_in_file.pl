=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  insert_line_in_file.pl							

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


=head2 SET UP sunix packages to update


=cut

 	my @package_name;

 	$package_name[0] 		= 'suxgraph';
 	$package_name[1] 		= 'supef';
 	$package_name[2]		= 'suacor';
 	$package_name[3]		= 'sugain';
  	$package_name[4]		= 'xwigb';
 	$package_name[5]		= 'suxwigb';
 	$package_name[6]		= 'sufilter'; 
  	$package_name[7]		= 'sufft';		
   	$package_name[8]		= 'suamp';	 	
   	$package_name[9]		= 'surange';
   	$package_name[10]		= 'sustolt';
 	$package_name[11] 		= 'a2b';
  	$package_name[12] 		= 'sustrip';
   	$package_name[13] 		= 'ximage';
   	$package_name[14] 		= 'suximage';
  	$package_name[15] 		= 'b2a'; 
   	$package_name[16] 		= 'sustrip';
   	$package_name[17] 		= 'xgraph';
   	$package_name[18] 		= 'sugethw';   		  				
   	$package_name[19] 		= 'swapbytes';   	
   	$package_name[20] 		= 'sushw';
   	$package_name[21] 		= 'suwind';
   	$package_name[22]		= 'suop';	
   	$package_name[23]		= 'suop2';
    $package_name[24]		= 'data_in';
    $package_name[25]		= 'data_out'; 	
    $package_name[26] 		= 'suchw'; 	
   	
   	my $INPUT 			= '/usr/local/pl/developer/scratch';
   	my $OUTPUT			= '/usr/local/pl/developer';
   	my $file_suffix		= '_spec.pm';

   	my $find_line			= 'var->{_true};';
	my $new_line			= "\t".'my $empty_string    = $var->{_empty_string};';		
   	my $reinstert_line      = 'my $true      			= $var->{_true};';
   	
   	my $length = scalar @package_name;
   	my $end_index		 =26;
   	my $start_index 	= 24;
   
   	for (my $i = $start_index; $i < $end_index; $i++) {
   		my $row;
   		my $file							= $package_name[$i].$file_suffix;
   	
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
		
		if ($length == 1) {
			
			# print("@$ref_line_numbers \n");
			# print("num_lines: $num_lines \n");
			
			my $new_line_number = @{$ref_line_numbers}[0];
			
   			# open file
   			open (my $fh, '>', $outbound) or die "Could not open file '$outbound' $!";
   			
  				# rewrite ALL lineS	up to the additional line   
  				for (my $i=0; $i < $new_line_number ; $i++) {	
        			$row	= $all_lines[$i];
        			# print "I write: ". $row ."from the file\n";
        			print $fh $row."\n";
    			}
    			
    			# write the additional line 
    			 print $fh $new_line."\n";
    			
    			#re-write the remaining old lines   			
   				for (my $i=$new_line_number; $i < $num_lines ; $i++) {	
        			$row	= $all_lines[$i];
        			# print "I write: ". $row ."from the file\n";
        			print $fh $row."\n";
    			}   			
    			
   				close($fh); 
   			 
						
			} else {		
				print("none, or too many line numbers\n");
			}
		
		
   	
   	}
   	
