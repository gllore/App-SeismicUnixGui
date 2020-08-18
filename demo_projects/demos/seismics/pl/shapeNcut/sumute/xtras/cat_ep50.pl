=head2 SYNOPSIS

 PACKAGE NAME: 

 AUTHOR:  

 DATE:

 DESCRIPTION:

 Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut

	use Moose;
	our $VERSION		='0.0.1';
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
	use Project_config;

	my $Project 		= new Project_config();

	my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;

	use message;
	use flow;


	my $log					= new message();
	my $run					= new flow();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my $list = '';

=head2 Set up a list of files for action

	my $file_name_list_in
	my $file_name_list_out
	my @file_name_list 
	
=cut 


  	my $first_file_num	    = 1;
  	my $maxfile_num	    = 48;
  	my $changing_number	= 1;
  	

	my $file_name_out			        = 'All_cmp300_muted.su';
	my $outbound				        = $DATA_SEISMIC_SU.'/'.$file_name_out;
 	

	
  	
 	for ( my $i=$first_file_num;
		 $i<=$maxfile_num; 
 		 $i=$i+ $changing_number) {
	
		$list = $list.$DATA_SEISMIC_SU.'/'.'split_ep'.$i.'50'.'_muted'.'.su ';
		
	
	}


=head2 Set up  FLOW 


=cut

	my $cat = "cat $list > $outbound";

=head2 RUN FLOW 


=cut

	 system($cat);


=head2 LOG FLOW(s)

	to screen and FILE

=cut

	print (" $cat\n");	
