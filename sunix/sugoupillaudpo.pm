 package sugoupillaudpo;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUGOUPILLAUDPO - calculate Primaries-Only impulse response of a lossless
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUGOUPILLAUDPO - calculate Primaries-Only impulse response of a lossless
	      GOUPILLAUD medium for plane waves at normal incidence	

 sugoupillaudpo < stdin > stdout [optional parameters]		      

 Required parameters:							     
	none								

 Optional parameters:						       
	l=1	   source layer number; 1 <= l <= tr.ns		  
		      Source is located at the top of layer l.		     
	k=1	   receiver layer number; 1 <= k			 
		      Receiver is located at the top of layer k.	    
	tmax	  number of output time-samples;			
		      default: long enough to capture all primaries	 
	pV=1	  flag for vector field seismogram		      
		      (displacement, velocity, acceleration);	       
		      =-1 for pressure seismogram.			  
	verbose=0     silent operation, =1 list warnings		    

 Input: Reflection coefficient series:				      

			       impedance[i]-impedance[i+1]		   
		       r[i] = -----------------------------		  
			       impedance[i]+impedance[i+1]		   

	r[0]= surface refl. coef. (as seen from above)		      
	r[n]= refl. coef. of the deepest interface			  

 Input file is to be in SU format, i.e., binary floats with a SU header.    

 Remarks:								   
 1. For vector fields, a buried source produces a spike of amplitude 1      
 propagating downwards and a spike of amplitude -1 propagating upwards.     
 A buried pressure source produces spikes of amplitude 1 both in the up-    
 and downward directions.						   
    A surface source induces only a downgoing spike of amplitude 1 at the   
 top of the first layer (both for vector and pressure fields).	      
 2. The sampling interval dt in the header of the input reflectivity file   
 is interpreted as a two-way traveltime thicknes of the layers. The sampling
 interval of the output seismogram is the same as that of the input file.   

 
 Credits:
	CWP: Albena Mateeva, April 2001.



=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sugoupillaudpo		= {
		_k					=> '',
		_l					=> '',
		_pV					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sugoupillaudpo->{_Step}     = 'sugoupillaudpo'.$sugoupillaudpo->{_Step};
	return ( $sugoupillaudpo->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sugoupillaudpo->{_note}     = 'sugoupillaudpo'.$sugoupillaudpo->{_note};
	return ( $sugoupillaudpo->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sugoupillaudpo->{_k}			= '';
		$sugoupillaudpo->{_l}			= '';
		$sugoupillaudpo->{_pV}			= '';
		$sugoupillaudpo->{_verbose}			= '';
		$sugoupillaudpo->{_Step}			= '';
		$sugoupillaudpo->{_note}			= '';
 }


=head2 sub k 


=cut

 sub k {

	my ( $self,$k )		= @_;
	if ( $k ne $empty_string ) {

		$sugoupillaudpo->{_k}		= $k;
		$sugoupillaudpo->{_note}		= $sugoupillaudpo->{_note}.' k='.$sugoupillaudpo->{_k};
		$sugoupillaudpo->{_Step}		= $sugoupillaudpo->{_Step}.' k='.$sugoupillaudpo->{_k};

	} else { 
		print("sugoupillaudpo, k, missing k,\n");
	 }
 }


=head2 sub l 


=cut

 sub l {

	my ( $self,$l )		= @_;
	if ( $l ne $empty_string ) {

		$sugoupillaudpo->{_l}		= $l;
		$sugoupillaudpo->{_note}		= $sugoupillaudpo->{_note}.' l='.$sugoupillaudpo->{_l};
		$sugoupillaudpo->{_Step}		= $sugoupillaudpo->{_Step}.' l='.$sugoupillaudpo->{_l};

	} else { 
		print("sugoupillaudpo, l, missing l,\n");
	 }
 }


=head2 sub pV 


=cut

 sub pV {

	my ( $self,$pV )		= @_;
	if ( $pV ne $empty_string ) {

		$sugoupillaudpo->{_pV}		= $pV;
		$sugoupillaudpo->{_note}		= $sugoupillaudpo->{_note}.' pV='.$sugoupillaudpo->{_pV};
		$sugoupillaudpo->{_Step}		= $sugoupillaudpo->{_Step}.' pV='.$sugoupillaudpo->{_pV};

	} else { 
		print("sugoupillaudpo, pV, missing pV,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sugoupillaudpo->{_verbose}		= $verbose;
		$sugoupillaudpo->{_note}		= $sugoupillaudpo->{_note}.' verbose='.$sugoupillaudpo->{_verbose};
		$sugoupillaudpo->{_Step}		= $sugoupillaudpo->{_Step}.' verbose='.$sugoupillaudpo->{_verbose};

	} else { 
		print("sugoupillaudpo, verbose, missing verbose,\n");
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