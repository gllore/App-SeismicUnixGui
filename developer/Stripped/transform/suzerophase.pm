 package suzerophase;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUZEROPHASE - convert input to zero phase equivalent			
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUZEROPHASE - convert input to zero phase equivalent			

 suzerophase <stdin >stdout [optional parameters]	 		

 Required parameters:					 		
	if dt is not set in header, then dt is mandatory		

 Optional parameters:							
    	t0=1.0			time of peak value t0 			
	verbose=0		=1 for advisory messages		



 Credits:
	c. 2011 Bruce VerWest as part of the SEAM project
 
 Trace header fields accessed: ns, dt, d1

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suzerophase		= {
		_t0					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suzerophase->{_Step}     = 'suzerophase'.$suzerophase->{_Step};
	return ( $suzerophase->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suzerophase->{_note}     = 'suzerophase'.$suzerophase->{_note};
	return ( $suzerophase->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suzerophase->{_t0}			= '';
		$suzerophase->{_verbose}			= '';
		$suzerophase->{_Step}			= '';
		$suzerophase->{_note}			= '';
 }


=head2 sub t0 


=cut

 sub t0 {

	my ( $self,$t0 )		= @_;
	if ( $t0 ne $empty_string ) {

		$suzerophase->{_t0}		= $t0;
		$suzerophase->{_note}		= $suzerophase->{_note}.' t0='.$suzerophase->{_t0};
		$suzerophase->{_Step}		= $suzerophase->{_Step}.' t0='.$suzerophase->{_t0};

	} else { 
		print("suzerophase, t0, missing t0,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suzerophase->{_verbose}		= $verbose;
		$suzerophase->{_note}		= $suzerophase->{_note}.' verbose='.$suzerophase->{_verbose};
		$suzerophase->{_Step}		= $suzerophase->{_Step}.' verbose='.$suzerophase->{_verbose};

	} else { 
		print("suzerophase, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 