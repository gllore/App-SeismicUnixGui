package instantiation_defaults;

use Moose;
our $VERSION = '0.0.2';

=head2 Default perl lines for instantiation_defaults
       of imported packages V 0.0.1
       ew 
	V 0.0.2 July 24 2018 include data_in, include data_out
	V 0.0.3 4-5-19 remove duplicate program names

=cut


=head2 program parameters
	 
  private hash
  
=cut


 my $instantiation_defaults = {
    	_prog_names_aref   	=> '',
 };


 sub section {
 	my ($self) = @_;
 
 	my $ref_instantiation_lines = _get_instantiation();
 	return ($ref_instantiation_lines);
  }

=head2 sub _get_instantiation

		filter duplicates 4-5-2019

=cut

 sub _get_instantiation {
	
	my ($self) = @_;
	
	if ($instantiation_defaults->{_prog_names_aref}) {
		
		use manage_files_by2;
		
		my @unique_progs;
		my $unique_progs_ref;
   		my $num_unique_progs;		
		my @prog_name    				= @{$instantiation_defaults->{_prog_names_aref}};
		my $length       				= scalar @prog_name;
		my @instantiation_defaults;
		my $filter 						= manage_files_by2->new();
		
		# default programs
 		$instantiation_defaults[0] = 
 		"\n\t".'my $log'."\t\t\t\t\t".'= new message();';
 		
 		$instantiation_defaults[1] = 
 		"\t".'my $run'."\t\t\t\t\t".'= new flow();';
		print("\n");
		
		# user-defined programs
	    # remove repeated programs from the list	
   		$unique_progs_ref	=	$filter->unique_elements(\@prog_name);
   		@unique_progs 		=   @{$unique_progs_ref};
   		$num_unique_progs   =   scalar @unique_progs;		
		
		for (my $i = 0, my $j = 2; $i <$num_unique_progs ; $i++) {
			# if(($prog_name[$i] ne 'data_out') )  {  # exclude data_out module removed in V 0.0.2
		 	# print("2. instantiation,set_prog_names_aref, prog_name=$prog_name[$i]\n");
 			$instantiation_defaults[$j] = 
 			"\t".'my $'.$unique_progs[$i]."\t\t\t\t".'= new '.$unique_progs[$i].'();';
 			
 			# print 	$instantiation_defaults[$j];
			$j++;
			#} 
		}
		return (\@instantiation_defaults);
		
	} else {
		print("instantiation,_get_instantiation, missing instantiation->{_prog_names_aref} \n");				
	}

}


=head2 sub set_prog_names_aref

=cut

sub set_prog_names_aref {
	my ($self,$hash_aref) = @_;

	if ( $hash_aref ) {
    	$instantiation_defaults->{_prog_names_aref} 	= $hash_aref->{_prog_names_aref}; 
		
	} else {
		print("instantiation, set_prog_names_aref, missing hash_aref\n");
	}
	
	return();
}

1;
