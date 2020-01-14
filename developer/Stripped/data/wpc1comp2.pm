 package wpc1comp2;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  WPC1COMP2 --- COMPress a 2D seismic section trace-by-trace using 	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 WPC1COMP2 --- COMPress a 2D seismic section trace-by-trace using 	
		Wavelet Packets						

 wpc1comp2 < stdin n1= [optional parameters ] > stdout              	

 Required Parameters:                                                  
 n1=                    number of samples in each trace		

 Optional Parameters:                                                  
 error=0.01              relative RMS allowed in compress		", 

 Notes:                                                                
  This program is used to compress a 2D section using 1D method.	
  It is not a true 2D compression algorithm, since the later diretion	
  is not compressed at all. It can be used in situations where random	
  accessing of each trace is desirable, or when there are very few	
  traces and normal 2D compression algorithm will not compress.	

  The parameter error is used control the allowable compression error,	
  and thus the compression ratio. The larger the error, the more 	
  the more compression you can get. The amount of error depends on 	
  the type of data and the application of the compression. From my 	
  experience, error=0.01 is a safe choice even when the compressed data 	
  are used for further processing. For some other applications, it 	
  may be set higher to achieve larger compression.			", 

 Caveats:								
  For the current implementation, the compressed data themselves are	
  NOT portable, i.e., the data compressed on one platform might not be	
  recognizable on another.						

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $wpc1comp2		= {
		_error					=> '',
		_n1					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$wpc1comp2->{_Step}     = 'wpc1comp2'.$wpc1comp2->{_Step};
	return ( $wpc1comp2->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$wpc1comp2->{_note}     = 'wpc1comp2'.$wpc1comp2->{_note};
	return ( $wpc1comp2->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$wpc1comp2->{_error}			= '';
		$wpc1comp2->{_n1}			= '';
		$wpc1comp2->{_Step}			= '';
		$wpc1comp2->{_note}			= '';
 }


=head2 sub error 


=cut

 sub error {

	my ( $self,$error )		= @_;
	if ( $error ne $empty_string ) {

		$wpc1comp2->{_error}		= $error;
		$wpc1comp2->{_note}		= $wpc1comp2->{_note}.' error='.$wpc1comp2->{_error};
		$wpc1comp2->{_Step}		= $wpc1comp2->{_Step}.' error='.$wpc1comp2->{_error};

	} else { 
		print("wpc1comp2, error, missing error,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$wpc1comp2->{_n1}		= $n1;
		$wpc1comp2->{_note}		= $wpc1comp2->{_note}.' n1='.$wpc1comp2->{_n1};
		$wpc1comp2->{_Step}		= $wpc1comp2->{_Step}.' n1='.$wpc1comp2->{_n1};

	} else { 
		print("wpc1comp2, n1, missing n1,\n");
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