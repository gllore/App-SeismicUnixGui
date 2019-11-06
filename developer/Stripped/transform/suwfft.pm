 package suwfft;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUWFFT - Weighted amplitude FFT with spectrum flattening 0->Nyquist	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUWFFT - Weighted amplitude FFT with spectrum flattening 0->Nyquist	

 suwfft <stdin | suifft >sdout 					

 Required parameters:							
 none									

 Optional parameters:							
 w0=0.75		weight for AmpSpectrum[f-df]			
 w1=1.00		weight for AmpSpectrum[f].. center value	
 w2=0.75		weight for AmpSpectrum[f+df]			

 Notes: 								
 1. output format is same as sufft					
 2. suwfft | suifft is not quite a no-op since the trace		
    length will usually be longer due to fft padding.			
 3. using w0=0 w1=1 w2=0  gives truly flat spectrum, for other	        
    weight choices the spectrum retains some of its original topograpy 

 Examples: 								
 1. boost data bandwidth to 10-90 Hz					
     suwfft < data.su | suifft | sufilter f=5,8,90,100 | suximage 	
 1. view amplitude spectrum after flattening				
     suwfft < data.su | suamp | suximage 				

 Caveat: The process of cascading the forward and inverse Fourier	
  transforms may result in the output trace length being greater than 	
  the input trace length owing to zero padding. The user may wish to	
  apply suwind to return the number of samples per trace to the original
  value:  Here NS is the number of samples per trace on the original data
  			... | suwind itmax=NS | ... 			

 Credits:

	UHouston: Chris Liner 

 Note: Concept from UTulsa PhD thesis of Bassel Al-Moughraby

 Trace header fields accessed: ns, dt
 Trace header fields modified: ns, d1, f1, trid

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suwfft		= {
		_f					=> '',
		_itmax					=> '',
		_w0					=> '',
		_w1					=> '',
		_w2					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suwfft->{_Step}     = 'suwfft'.$suwfft->{_Step};
	return ( $suwfft->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suwfft->{_note}     = 'suwfft'.$suwfft->{_note};
	return ( $suwfft->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suwfft->{_f}			= '';
		$suwfft->{_itmax}			= '';
		$suwfft->{_w0}			= '';
		$suwfft->{_w1}			= '';
		$suwfft->{_w2}			= '';
		$suwfft->{_Step}			= '';
		$suwfft->{_note}			= '';
 }


=head2 sub f 


=cut

 sub f {

	my ( $self,$f )		= @_;
	if ( $f ne $empty_string ) {

		$suwfft->{_f}		= $f;
		$suwfft->{_note}		= $suwfft->{_note}.' f='.$suwfft->{_f};
		$suwfft->{_Step}		= $suwfft->{_Step}.' f='.$suwfft->{_f};

	} else { 
		print("suwfft, f, missing f,\n");
	 }
 }


=head2 sub itmax 


=cut

 sub itmax {

	my ( $self,$itmax )		= @_;
	if ( $itmax ne $empty_string ) {

		$suwfft->{_itmax}		= $itmax;
		$suwfft->{_note}		= $suwfft->{_note}.' itmax='.$suwfft->{_itmax};
		$suwfft->{_Step}		= $suwfft->{_Step}.' itmax='.$suwfft->{_itmax};

	} else { 
		print("suwfft, itmax, missing itmax,\n");
	 }
 }


=head2 sub w0 


=cut

 sub w0 {

	my ( $self,$w0 )		= @_;
	if ( $w0 ne $empty_string ) {

		$suwfft->{_w0}		= $w0;
		$suwfft->{_note}		= $suwfft->{_note}.' w0='.$suwfft->{_w0};
		$suwfft->{_Step}		= $suwfft->{_Step}.' w0='.$suwfft->{_w0};

	} else { 
		print("suwfft, w0, missing w0,\n");
	 }
 }


=head2 sub w1 


=cut

 sub w1 {

	my ( $self,$w1 )		= @_;
	if ( $w1 ne $empty_string ) {

		$suwfft->{_w1}		= $w1;
		$suwfft->{_note}		= $suwfft->{_note}.' w1='.$suwfft->{_w1};
		$suwfft->{_Step}		= $suwfft->{_Step}.' w1='.$suwfft->{_w1};

	} else { 
		print("suwfft, w1, missing w1,\n");
	 }
 }


=head2 sub w2 


=cut

 sub w2 {

	my ( $self,$w2 )		= @_;
	if ( $w2 ne $empty_string ) {

		$suwfft->{_w2}		= $w2;
		$suwfft->{_note}		= $suwfft->{_note}.' w2='.$suwfft->{_w2};
		$suwfft->{_Step}		= $suwfft->{_Step}.' w2='.$suwfft->{_w2};

	} else { 
		print("suwfft, w2, missing w2,\n");
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