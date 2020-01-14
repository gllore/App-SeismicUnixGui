 package h2b;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  H2B - convert 8 bit hexidecimal floats to binary		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 H2B - convert 8 bit hexidecimal floats to binary		

 h2b <stdin >stdout outpar=/dev/tty 				

 Required parameters:						
 	none							

 Optional parameters:						
 	outpar=/dev/tty output parameter file, contains the	
			number of lines (n=)			
 			other choices for outpar are: /dev/tty,	
 			/dev/stderr, or a name of a disk file	

 Note: this code may be used to recover binary data from PostScript
 bitmaps. To do this, strip away all parts of the PSfile that	
 are not the actual hexidecimal bitmap and run through h2b.	

 Note: that the binary file may need to be transposed using	
 "transp" to appear to be the same as input data.		

 Note:	output will be floats with the values 0-255		
=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $h2b		= {
		_n					=> '',
		_outpar					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$h2b->{_Step}     = 'h2b'.$h2b->{_Step};
	return ( $h2b->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$h2b->{_note}     = 'h2b'.$h2b->{_note};
	return ( $h2b->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$h2b->{_n}			= '';
		$h2b->{_outpar}			= '';
		$h2b->{_Step}			= '';
		$h2b->{_note}			= '';
 }


=head2 sub n 


=cut

 sub n {

	my ( $self,$n )		= @_;
	if ( $n ne $empty_string ) {

		$h2b->{_n}		= $n;
		$h2b->{_note}		= $h2b->{_note}.' n='.$h2b->{_n};
		$h2b->{_Step}		= $h2b->{_Step}.' n='.$h2b->{_n};

	} else { 
		print("h2b, n, missing n,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$h2b->{_outpar}		= $outpar;
		$h2b->{_note}		= $h2b->{_note}.' outpar='.$h2b->{_outpar};
		$h2b->{_Step}		= $h2b->{_Step}.' outpar='.$h2b->{_outpar};

	} else { 
		print("h2b, outpar, missing outpar,\n");
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