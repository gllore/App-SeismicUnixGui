 package suvelan_nccs;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUVELAN_NCCS - compute stacking VELocity panel for cdp gathers	     
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUVELAN_NCCS - compute stacking VELocity panel for cdp gathers	     
		using Normalized CrossCorrelation Sum 	                     

 suvelan_uccs <stdin >stdout [optional parameters]			     

 Optional Parameters:							     
 nx=tr.cdpt              number of traces in cdp			     
 nv=50                   number of velocities				     
 dv=50.0                 velocity sampling interval			     
 fv=1500.0               first velocity				     
 smute=1.5               samples with NMO stretch exceeding smute are zeroed
 dtratio=5               ratio of output to input time sampling intervals   
 nsmooth=dtratio*2+1     length of smoothing window                         
 verbose=0               =1 for diagnostic print on stderr		     
 pwr=1.0                 semblance value to the power      		     

 Notes:								     
 Normalized CrossCorrelation sum: sum all possible crosscorrelation	     
 trace pairs in a CMP gather for each trial velocity and zero-offset        
 two-way travel time inside a time window. This coherence measure is        
 normalized by dividing each crosscorrelation trace pair by the geometric   
 mean of the energy, inside the chosen time window, of each trace pair      
 involved in each crosscorrelation. Then, to achieve a maximum amplitude    
 of unity, the result is multiplied by  2/(M(M-1)), which is the inverse    
 of the total number of crosscorrelation. The normalization allows to	     
 bring out weak reflection as long as these reflections have moveouts close 
 to a hyperbola.							     


 
 Credits:  

 CWP:  Valmore Celis, Sept 2002	

 Based on the original code: suvelan.c 
    Colorado School of Mines:  Dave Hale, c. 1989

 Trace header fields accessed:  ns, dt, delrt, offset, cdp, cdpt 
 Trace header fields modified:  ns, dt, offset, cdp

 Reference: Neidell, N.S., and Taner, M.T., 1971, Semblance and 
             other coherency measures for multichannel data: 
             Geophysics, 36, 498-509. 


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suvelan_nccs		= {
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

	$suvelan_nccs->{_Step}     = 'suvelan_nccs'.$suvelan_nccs->{_Step};
	return ( $suvelan_nccs->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suvelan_nccs->{_note}     = 'suvelan_nccs'.$suvelan_nccs->{_note};
	return ( $suvelan_nccs->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suvelan_nccs->{_dtratio}			= '';
		$suvelan_nccs->{_dv}			= '';
		$suvelan_nccs->{_fv}			= '';
		$suvelan_nccs->{_nsmooth}			= '';
		$suvelan_nccs->{_nv}			= '';
		$suvelan_nccs->{_nx}			= '';
		$suvelan_nccs->{_pwr}			= '';
		$suvelan_nccs->{_smute}			= '';
		$suvelan_nccs->{_verbose}			= '';
		$suvelan_nccs->{_Step}			= '';
		$suvelan_nccs->{_note}			= '';
 }


=head2 sub dtratio 


=cut

 sub dtratio {

	my ( $self,$dtratio )		= @_;
	if ( $dtratio ne $empty_string ) {

		$suvelan_nccs->{_dtratio}		= $dtratio;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' dtratio='.$suvelan_nccs->{_dtratio};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' dtratio='.$suvelan_nccs->{_dtratio};

	} else { 
		print("suvelan_nccs, dtratio, missing dtratio,\n");
	 }
 }


=head2 sub dv 


=cut

 sub dv {

	my ( $self,$dv )		= @_;
	if ( $dv ne $empty_string ) {

		$suvelan_nccs->{_dv}		= $dv;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' dv='.$suvelan_nccs->{_dv};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' dv='.$suvelan_nccs->{_dv};

	} else { 
		print("suvelan_nccs, dv, missing dv,\n");
	 }
 }


=head2 sub fv 


=cut

 sub fv {

	my ( $self,$fv )		= @_;
	if ( $fv ne $empty_string ) {

		$suvelan_nccs->{_fv}		= $fv;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' fv='.$suvelan_nccs->{_fv};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' fv='.$suvelan_nccs->{_fv};

	} else { 
		print("suvelan_nccs, fv, missing fv,\n");
	 }
 }


=head2 sub nsmooth 


=cut

 sub nsmooth {

	my ( $self,$nsmooth )		= @_;
	if ( $nsmooth ne $empty_string ) {

		$suvelan_nccs->{_nsmooth}		= $nsmooth;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' nsmooth='.$suvelan_nccs->{_nsmooth};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' nsmooth='.$suvelan_nccs->{_nsmooth};

	} else { 
		print("suvelan_nccs, nsmooth, missing nsmooth,\n");
	 }
 }


=head2 sub nv 


=cut

 sub nv {

	my ( $self,$nv )		= @_;
	if ( $nv ne $empty_string ) {

		$suvelan_nccs->{_nv}		= $nv;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' nv='.$suvelan_nccs->{_nv};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' nv='.$suvelan_nccs->{_nv};

	} else { 
		print("suvelan_nccs, nv, missing nv,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$suvelan_nccs->{_nx}		= $nx;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' nx='.$suvelan_nccs->{_nx};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' nx='.$suvelan_nccs->{_nx};

	} else { 
		print("suvelan_nccs, nx, missing nx,\n");
	 }
 }


=head2 sub pwr 


=cut

 sub pwr {

	my ( $self,$pwr )		= @_;
	if ( $pwr ne $empty_string ) {

		$suvelan_nccs->{_pwr}		= $pwr;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' pwr='.$suvelan_nccs->{_pwr};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' pwr='.$suvelan_nccs->{_pwr};

	} else { 
		print("suvelan_nccs, pwr, missing pwr,\n");
	 }
 }


=head2 sub smute 


=cut

 sub smute {

	my ( $self,$smute )		= @_;
	if ( $smute ne $empty_string ) {

		$suvelan_nccs->{_smute}		= $smute;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' smute='.$suvelan_nccs->{_smute};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' smute='.$suvelan_nccs->{_smute};

	} else { 
		print("suvelan_nccs, smute, missing smute,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suvelan_nccs->{_verbose}		= $verbose;
		$suvelan_nccs->{_note}		= $suvelan_nccs->{_note}.' verbose='.$suvelan_nccs->{_verbose};
		$suvelan_nccs->{_Step}		= $suvelan_nccs->{_Step}.' verbose='.$suvelan_nccs->{_verbose};

	} else { 
		print("suvelan_nccs, verbose, missing verbose,\n");
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