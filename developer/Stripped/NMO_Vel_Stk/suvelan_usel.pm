 package suvelan_usel;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUVELAN_USEL - compute stacking velocity panel for cdp gathers	     
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUVELAN_USEL - compute stacking velocity panel for cdp gathers	     
		using the UnNormalized Selective CrossCorrelation Sum	     

 suvelan_usel <stdin >stdout [optional parameters]			     

 Optional Parameters:							     
 nx=tr.cdpt              number of traces in cdp			     
 dx=tr.d2                offset increment				     
 nv=50                   number of velocities				     
 dv=50.0                 velocity sampling interval			     
 fv=1500.0               first velocity				     
 tau=0.5                 threshold for significance values                  
 smute=1.5               samples with NMO stretch exceeding smute are zeroed
 dtratio=5               ratio of output to input time sampling intervals   
 nsmooth=dtratio*2+1     length of smoothing window                         
 verbose=0               =1 for diagnostic print on stderr		     
 pwr=1.0                 semblance value to the power      		     

 Notes:								     
 UnNormalized Selective CrossCorrelation sum: is based on the coherence     
 measure known as crosscorrelation sum. The difference is that the selective
 approach sum only crosscorrelation pairs with relatively large differential
 moveout, thus increasing the resolving power in the velocity spectra       
 compared to that achieved by conventional methods.  The selection is made  
 using a parabolic approximation of the differential moveout and imposing a 
 threshold for those differential moveouts.				     

 That threshold is the parameter tau in this program, which varies between  
 0 to 1.  A value of tau=0, means conventional crosscorrelation sum is      
 applied implying that all crosscorrelations are included in the sum. In    
 contrast, a value of tau=1 (not recomended) means that only the            
 crosscorrelation formed by the trace pair involving the shortest and longest
 offset is included in the sum. Intermediate values will produce percentages
 of the crosscorrelations included in the sum that will be shown in the     
 screen before computing the velocity spectra. Typical values for tau are   
 between 0.2 and 0.6, producing approximated percentages of crosscorrelations
 summed between 60% and 20%. The higher the value of tau the lower the     
 percentage and higher the increase in the resolving power of velocity	      
 spectra.								      

 Keeping the percentage of crosscorrelations included in the sum between 20%
 and 60% will increase resolution and avoid the precense of artifacts in the
 results.  In data contaminated by random noise or statics distortions is    
 recomended to mantaing the percentage of crosscorrelations included in the  
 sum above 25%.  After computing the velocity spectra one might want to     
 adjust the level and number of contours before velocity picking.  	      

 
 Credits:  CWP: Valmore Celis, Sept 2002
 
 Based on the original code: suvelan_.c 
    Colorado School of Mines:  Dave Hale c. 1989


 References: 
 Neidell, N.S., and Taner, M.T., 1971, Semblance and other coherency
             measures for multichannel data: Geophysics, 36, 498-509.
 Celis, V. T., 2002, Selective-correlation velocity analysis: CSM thesis.

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


	my $suvelan_usel		= {
		_dtratio					=> '',
		_dv					=> '',
		_dx					=> '',
		_fv					=> '',
		_nsmooth					=> '',
		_nv					=> '',
		_nx					=> '',
		_pwr					=> '',
		_smute					=> '',
		_tau					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suvelan_usel->{_Step}     = 'suvelan_usel'.$suvelan_usel->{_Step};
	return ( $suvelan_usel->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suvelan_usel->{_note}     = 'suvelan_usel'.$suvelan_usel->{_note};
	return ( $suvelan_usel->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suvelan_usel->{_dtratio}			= '';
		$suvelan_usel->{_dv}			= '';
		$suvelan_usel->{_dx}			= '';
		$suvelan_usel->{_fv}			= '';
		$suvelan_usel->{_nsmooth}			= '';
		$suvelan_usel->{_nv}			= '';
		$suvelan_usel->{_nx}			= '';
		$suvelan_usel->{_pwr}			= '';
		$suvelan_usel->{_smute}			= '';
		$suvelan_usel->{_tau}			= '';
		$suvelan_usel->{_verbose}			= '';
		$suvelan_usel->{_Step}			= '';
		$suvelan_usel->{_note}			= '';
 }


=head2 sub dtratio 


=cut

 sub dtratio {

	my ( $self,$dtratio )		= @_;
	if ( $dtratio ne $empty_string ) {

		$suvelan_usel->{_dtratio}		= $dtratio;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' dtratio='.$suvelan_usel->{_dtratio};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' dtratio='.$suvelan_usel->{_dtratio};

	} else { 
		print("suvelan_usel, dtratio, missing dtratio,\n");
	 }
 }


=head2 sub dv 


=cut

 sub dv {

	my ( $self,$dv )		= @_;
	if ( $dv ne $empty_string ) {

		$suvelan_usel->{_dv}		= $dv;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' dv='.$suvelan_usel->{_dv};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' dv='.$suvelan_usel->{_dv};

	} else { 
		print("suvelan_usel, dv, missing dv,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$suvelan_usel->{_dx}		= $dx;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' dx='.$suvelan_usel->{_dx};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' dx='.$suvelan_usel->{_dx};

	} else { 
		print("suvelan_usel, dx, missing dx,\n");
	 }
 }


=head2 sub fv 


=cut

 sub fv {

	my ( $self,$fv )		= @_;
	if ( $fv ne $empty_string ) {

		$suvelan_usel->{_fv}		= $fv;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' fv='.$suvelan_usel->{_fv};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' fv='.$suvelan_usel->{_fv};

	} else { 
		print("suvelan_usel, fv, missing fv,\n");
	 }
 }


=head2 sub nsmooth 


=cut

 sub nsmooth {

	my ( $self,$nsmooth )		= @_;
	if ( $nsmooth ne $empty_string ) {

		$suvelan_usel->{_nsmooth}		= $nsmooth;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' nsmooth='.$suvelan_usel->{_nsmooth};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' nsmooth='.$suvelan_usel->{_nsmooth};

	} else { 
		print("suvelan_usel, nsmooth, missing nsmooth,\n");
	 }
 }


=head2 sub nv 


=cut

 sub nv {

	my ( $self,$nv )		= @_;
	if ( $nv ne $empty_string ) {

		$suvelan_usel->{_nv}		= $nv;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' nv='.$suvelan_usel->{_nv};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' nv='.$suvelan_usel->{_nv};

	} else { 
		print("suvelan_usel, nv, missing nv,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$suvelan_usel->{_nx}		= $nx;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' nx='.$suvelan_usel->{_nx};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' nx='.$suvelan_usel->{_nx};

	} else { 
		print("suvelan_usel, nx, missing nx,\n");
	 }
 }


=head2 sub pwr 


=cut

 sub pwr {

	my ( $self,$pwr )		= @_;
	if ( $pwr ne $empty_string ) {

		$suvelan_usel->{_pwr}		= $pwr;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' pwr='.$suvelan_usel->{_pwr};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' pwr='.$suvelan_usel->{_pwr};

	} else { 
		print("suvelan_usel, pwr, missing pwr,\n");
	 }
 }


=head2 sub smute 


=cut

 sub smute {

	my ( $self,$smute )		= @_;
	if ( $smute ne $empty_string ) {

		$suvelan_usel->{_smute}		= $smute;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' smute='.$suvelan_usel->{_smute};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' smute='.$suvelan_usel->{_smute};

	} else { 
		print("suvelan_usel, smute, missing smute,\n");
	 }
 }


=head2 sub tau 


=cut

 sub tau {

	my ( $self,$tau )		= @_;
	if ( $tau ne $empty_string ) {

		$suvelan_usel->{_tau}		= $tau;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' tau='.$suvelan_usel->{_tau};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' tau='.$suvelan_usel->{_tau};

	} else { 
		print("suvelan_usel, tau, missing tau,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suvelan_usel->{_verbose}		= $verbose;
		$suvelan_usel->{_note}		= $suvelan_usel->{_note}.' verbose='.$suvelan_usel->{_verbose};
		$suvelan_usel->{_Step}		= $suvelan_usel->{_Step}.' verbose='.$suvelan_usel->{_verbose};

	} else { 
		print("suvelan_usel, verbose, missing verbose,\n");
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