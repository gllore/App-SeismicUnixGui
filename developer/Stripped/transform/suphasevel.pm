 package suphasevel;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUPHASEVEL - Multi-mode PHASE VELocity dispersion map computed
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUPHASEVEL - Multi-mode PHASE VELocity dispersion map computed
              from shot record(s)				

 suphasevel <infile >outfile [optional parameters]		

 Optional parameters:						
 fv=330	minimum phase velocity (m/s)			
 nv=100	number of phase velocities			
 dv=25		phase velocity step (m/s)			
 fmax=50	maximum frequency to process (Hz)		
		=0 process to nyquist				
 norm=0	do not normalize by amplitude spectrum		
		=1 normalize by amplitude spectrum		
 verbose=0	verbose = 1 echoes information			

 Notes:  Offsets read from headers.			 	
  1. output is complex frequency data				
  2. offset header word must be set (signed offset is ok)	
  3. norm=1 tends to blow up aliasing and other artifacts	
  4. For correct suifft later, use fmax=0			
  5. For later processing outtrace.dt=domega			
  6. works for 2D or 3D shots in any offset order		


 Using this program:						

 First: use 							
 	suspecfx < shotrecord.su | suximage			
 to see what the maximum bandwidth is in your data. This will	
 give you an idea about the possible value for fmax.		

 Second: Plot your data or some subset of your data via:	
     suxwigb < shotrecord.su key=offset			

 You can then estimate the range of phase velocities by looking
 at the maximum and minimum slopes of arrivals in your data.	
 This will allow you do set first velocity fv and the increment
 in velocity dv, that make sense for your data.		

 You can pick values of offset and time by placing the cursor  
 on the desired location on the plot and pressing the \'s\' key
 The picks will appear in your terminal window. 		

 When displaying, don't forget to use suamp to compute the	
 modulus of the complex values that this program puts out.	

   suphasevel < shotrecord.su [parameters] | suamp | suximage	



 Credits:

	UHouston: Chris Liner June2008 (cloned from suspecfk)

  This code implements the following integral transform
             _
            /
  u(w,v) = / k(w,x,v) u(w,x) dx
         _/
  where
	u(w,v) is the phase velocity dispersion image
	k(w,x,v) is the transform kernel.... exp(-i w x / v)
	u(w,x) = FT[u(t,x)] is the input shot record(s) 
         _/
 Reference: Park, Miller, and Xia (1998, SEG Abstracts)

 Trace header fields accessed: dt, offset, ns
 Trace header fields modified: nx,dt,trid,d1,f1,d2,f2,tracl

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suphasevel		= {
		_dt					=> '',
		_dv					=> '',
		_fmax					=> '',
		_fv					=> '',
		_key					=> '',
		_norm					=> '',
		_nv					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suphasevel->{_Step}     = 'suphasevel'.$suphasevel->{_Step};
	return ( $suphasevel->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suphasevel->{_note}     = 'suphasevel'.$suphasevel->{_note};
	return ( $suphasevel->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suphasevel->{_dt}			= '';
		$suphasevel->{_dv}			= '';
		$suphasevel->{_fmax}			= '';
		$suphasevel->{_fv}			= '';
		$suphasevel->{_key}			= '';
		$suphasevel->{_norm}			= '';
		$suphasevel->{_nv}			= '';
		$suphasevel->{_verbose}			= '';
		$suphasevel->{_Step}			= '';
		$suphasevel->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suphasevel->{_dt}		= $dt;
		$suphasevel->{_note}		= $suphasevel->{_note}.' dt='.$suphasevel->{_dt};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' dt='.$suphasevel->{_dt};

	} else { 
		print("suphasevel, dt, missing dt,\n");
	 }
 }


=head2 sub dv 


=cut

 sub dv {

	my ( $self,$dv )		= @_;
	if ( $dv ne $empty_string ) {

		$suphasevel->{_dv}		= $dv;
		$suphasevel->{_note}		= $suphasevel->{_note}.' dv='.$suphasevel->{_dv};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' dv='.$suphasevel->{_dv};

	} else { 
		print("suphasevel, dv, missing dv,\n");
	 }
 }


=head2 sub fmax 


=cut

 sub fmax {

	my ( $self,$fmax )		= @_;
	if ( $fmax ne $empty_string ) {

		$suphasevel->{_fmax}		= $fmax;
		$suphasevel->{_note}		= $suphasevel->{_note}.' fmax='.$suphasevel->{_fmax};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' fmax='.$suphasevel->{_fmax};

	} else { 
		print("suphasevel, fmax, missing fmax,\n");
	 }
 }


=head2 sub fv 


=cut

 sub fv {

	my ( $self,$fv )		= @_;
	if ( $fv ne $empty_string ) {

		$suphasevel->{_fv}		= $fv;
		$suphasevel->{_note}		= $suphasevel->{_note}.' fv='.$suphasevel->{_fv};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' fv='.$suphasevel->{_fv};

	} else { 
		print("suphasevel, fv, missing fv,\n");
	 }
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ne $empty_string ) {

		$suphasevel->{_key}		= $key;
		$suphasevel->{_note}		= $suphasevel->{_note}.' key='.$suphasevel->{_key};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' key='.$suphasevel->{_key};

	} else { 
		print("suphasevel, key, missing key,\n");
	 }
 }


=head2 sub norm 


=cut

 sub norm {

	my ( $self,$norm )		= @_;
	if ( $norm ne $empty_string ) {

		$suphasevel->{_norm}		= $norm;
		$suphasevel->{_note}		= $suphasevel->{_note}.' norm='.$suphasevel->{_norm};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' norm='.$suphasevel->{_norm};

	} else { 
		print("suphasevel, norm, missing norm,\n");
	 }
 }


=head2 sub nv 


=cut

 sub nv {

	my ( $self,$nv )		= @_;
	if ( $nv ne $empty_string ) {

		$suphasevel->{_nv}		= $nv;
		$suphasevel->{_note}		= $suphasevel->{_note}.' nv='.$suphasevel->{_nv};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' nv='.$suphasevel->{_nv};

	} else { 
		print("suphasevel, nv, missing nv,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suphasevel->{_verbose}		= $verbose;
		$suphasevel->{_note}		= $suphasevel->{_note}.' verbose='.$suphasevel->{_verbose};
		$suphasevel->{_Step}		= $suphasevel->{_Step}.' verbose='.$suphasevel->{_verbose};

	} else { 
		print("suphasevel, verbose, missing verbose,\n");
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