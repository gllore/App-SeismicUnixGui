 package suvelan_uccs;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUVELAN_UCCS - compute stacking VELocity panel for cdp gathers	     
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUVELAN_UCCS - compute stacking VELocity panel for cdp gathers	     
		using UnNormalized CrossCorrelation Sum 	             

 suvelan_uccs <stdin >stdout [optional parameters]			     

 Optional Parameters:							     
 nx=tr.cdpt              number of traces in cdp 			     
 nv=50                   number of velocities				     
 dv=50.0                velocity sampling interval			     
 fv=1500.0               first velocity				     
 smute=1.5               samples with NMO stretch exceeding smute are zeroed
 dtratio=5               ratio of output to input time sampling intervals   
 nsmooth=dtratio*2+1     length of smoothing window                         
 verbose=0               =1 for diagnostic print on stderr		     
 pwr=1.0                 semblance value to the power      		     

Notes:									     
 Unnormalized crosscorrelation sum: sum all possible crosscorrelation trace 
 pairs in a CMP gather for each trial velocity and zero-offset two-way      
 travel time inside a time window. This unnormalized coherency measure      
 produces large spectral amplitudes for strong reflections and small        
 spectral amplitudes for weaker ones. If M is the number of traces in the   
 CMP gather M(M-1)/2 is the total number of crosscorrelations for each trial
 velocity and zero-offset two-way traveltime.			 	     

 
 Credits: CWP: Valmore Celis, Sept 2002	
 
 Based on the original code: suvelan.c 
    Colorado School of Mines:  Dave Hale c. 1989


 Reference: Neidell, N.S., and Taner, M.T., 1971, Semblance and other 
            coherency measures for multichannel data: Geophysics, 36, 498-509.

 Trace header fields accessed:  ns, dt, delrt, offset, cdp
 Trace header fields modified:  ns, dt, offset, cdp

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suvelan_uccs		= {
		_dtratio					=> '',
		_dv					=> '',
		_fv					=> '',
		_nsmooth					=> '',
		_nv					=> '',
		_nx					=> '',
		_pwr					=> '',
		_smute					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suvelan_uccs->{_Step}     = 'suvelan_uccs'.$suvelan_uccs->{_Step};
	return ( $suvelan_uccs->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suvelan_uccs->{_note}     = 'suvelan_uccs'.$suvelan_uccs->{_note};
	return ( $suvelan_uccs->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suvelan_uccs->{_dtratio}			= '';
		$suvelan_uccs->{_dv}			= '';
		$suvelan_uccs->{_fv}			= '';
		$suvelan_uccs->{_nsmooth}			= '';
		$suvelan_uccs->{_nv}			= '';
		$suvelan_uccs->{_nx}			= '';
		$suvelan_uccs->{_pwr}			= '';
		$suvelan_uccs->{_smute}			= '';
		$suvelan_uccs->{_verbose}			= '';
		$suvelan_uccs->{_Step}			= '';
		$suvelan_uccs->{_note}			= '';
 }


=head2 sub dtratio 


=cut

 sub dtratio {

	my ( $self,$dtratio )		= @_;
	if ( $dtratio ne $empty_string ) {

		$suvelan_uccs->{_dtratio}		= $dtratio;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' dtratio='.$suvelan_uccs->{_dtratio};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' dtratio='.$suvelan_uccs->{_dtratio};

	} else { 
		print("suvelan_uccs, dtratio, missing dtratio,\n");
	 }
 }


=head2 sub dv 


=cut

 sub dv {

	my ( $self,$dv )		= @_;
	if ( $dv ne $empty_string ) {

		$suvelan_uccs->{_dv}		= $dv;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' dv='.$suvelan_uccs->{_dv};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' dv='.$suvelan_uccs->{_dv};

	} else { 
		print("suvelan_uccs, dv, missing dv,\n");
	 }
 }


=head2 sub fv 


=cut

 sub fv {

	my ( $self,$fv )		= @_;
	if ( $fv ne $empty_string ) {

		$suvelan_uccs->{_fv}		= $fv;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' fv='.$suvelan_uccs->{_fv};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' fv='.$suvelan_uccs->{_fv};

	} else { 
		print("suvelan_uccs, fv, missing fv,\n");
	 }
 }


=head2 sub nsmooth 


=cut

 sub nsmooth {

	my ( $self,$nsmooth )		= @_;
	if ( $nsmooth ne $empty_string ) {

		$suvelan_uccs->{_nsmooth}		= $nsmooth;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' nsmooth='.$suvelan_uccs->{_nsmooth};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' nsmooth='.$suvelan_uccs->{_nsmooth};

	} else { 
		print("suvelan_uccs, nsmooth, missing nsmooth,\n");
	 }
 }


=head2 sub nv 


=cut

 sub nv {

	my ( $self,$nv )		= @_;
	if ( $nv ne $empty_string ) {

		$suvelan_uccs->{_nv}		= $nv;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' nv='.$suvelan_uccs->{_nv};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' nv='.$suvelan_uccs->{_nv};

	} else { 
		print("suvelan_uccs, nv, missing nv,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$suvelan_uccs->{_nx}		= $nx;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' nx='.$suvelan_uccs->{_nx};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' nx='.$suvelan_uccs->{_nx};

	} else { 
		print("suvelan_uccs, nx, missing nx,\n");
	 }
 }


=head2 sub pwr 


=cut

 sub pwr {

	my ( $self,$pwr )		= @_;
	if ( $pwr ne $empty_string ) {

		$suvelan_uccs->{_pwr}		= $pwr;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' pwr='.$suvelan_uccs->{_pwr};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' pwr='.$suvelan_uccs->{_pwr};

	} else { 
		print("suvelan_uccs, pwr, missing pwr,\n");
	 }
 }


=head2 sub smute 


=cut

 sub smute {

	my ( $self,$smute )		= @_;
	if ( $smute ne $empty_string ) {

		$suvelan_uccs->{_smute}		= $smute;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' smute='.$suvelan_uccs->{_smute};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' smute='.$suvelan_uccs->{_smute};

	} else { 
		print("suvelan_uccs, smute, missing smute,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suvelan_uccs->{_verbose}		= $verbose;
		$suvelan_uccs->{_note}		= $suvelan_uccs->{_note}.' verbose='.$suvelan_uccs->{_verbose};
		$suvelan_uccs->{_Step}		= $suvelan_uccs->{_Step}.' verbose='.$suvelan_uccs->{_verbose};

	} else { 
		print("suvelan_uccs, verbose, missing verbose,\n");
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