 package suinterpfowler;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUINTERPFOWLER - interpolate output image from constant velocity panels
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUINTERPFOWLER - interpolate output image from constant velocity panels
	   built by SUTIFOWLER or CVS					

 These parameters should be specified the same as in SUTIFOWLER:	
 vmin=1500.		minimum velocity				
 vmax=2500.		maximum velocity				
 nv=21			number of velocity panels			
 etamin=0.10		minimum eta value				
 etamax=0.25		maximum eta value				
 neta=11		number of eta values				
 ncdps=1130		number of cdp points				

 If these parameters are specified so that nvstack>5, then the input 	
 data are assumed to come from CVS and the SUTIFOWLER parameters are ignored.
 nvstack=0		number of constant velocity stack panels output by CVS
 vminstack=1450	minimum velocity specified for CVS		
 vscale=1.0		scale factor for velocity functions		

 These parameters specify the desired output (time,velocity,eta) model	
 at each cdp location. The sequential cdp numbers should be specified in
 increasing order from 0 to 'ncdps-1' at from 1 to 'ncdps' control point
 locations. (Time values are in seconds.)				
 cdp=0			cdp number for (t,v,eta) triplets (specify more than
 				once if needed)				
 t=0.			array of times for (t,v,eta) triplets (specify more
				than once if needed)			
 v=1500.		array of velocities for (t,v,eta) triplets (specify
				more than once if needed)		
 eta=0.		array of etas for (t,v,eta) triplets (specify more
				than once if needed)			

 Note: This is a simple research code based on linear interpolation.	
 There are no protections against aliasing built into the code beyond	
 suggesting that this program have a knowledgable user. A final version
 should do a better job taking care of endpoint conditions.



 Author: (Visitor from Mobil) John E. Anderson, Spring 1994 

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suinterpfowler		= {
		_cdp					=> '',
		_eta					=> '',
		_etamax					=> '',
		_etamin					=> '',
		_ncdps					=> '',
		_neta					=> '',
		_nv					=> '',
		_nvstack					=> '',
		_t					=> '',
		_v					=> '',
		_vmax					=> '',
		_vmin					=> '',
		_vminstack					=> '',
		_vscale					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suinterpfowler->{_Step}     = 'suinterpfowler'.$suinterpfowler->{_Step};
	return ( $suinterpfowler->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suinterpfowler->{_note}     = 'suinterpfowler'.$suinterpfowler->{_note};
	return ( $suinterpfowler->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suinterpfowler->{_cdp}			= '';
		$suinterpfowler->{_eta}			= '';
		$suinterpfowler->{_etamax}			= '';
		$suinterpfowler->{_etamin}			= '';
		$suinterpfowler->{_ncdps}			= '';
		$suinterpfowler->{_neta}			= '';
		$suinterpfowler->{_nv}			= '';
		$suinterpfowler->{_nvstack}			= '';
		$suinterpfowler->{_t}			= '';
		$suinterpfowler->{_v}			= '';
		$suinterpfowler->{_vmax}			= '';
		$suinterpfowler->{_vmin}			= '';
		$suinterpfowler->{_vminstack}			= '';
		$suinterpfowler->{_vscale}			= '';
		$suinterpfowler->{_Step}			= '';
		$suinterpfowler->{_note}			= '';
 }


=head2 sub cdp 


=cut

 sub cdp {

	my ( $self,$cdp )		= @_;
	if ( $cdp ne $empty_string ) {

		$suinterpfowler->{_cdp}		= $cdp;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' cdp='.$suinterpfowler->{_cdp};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' cdp='.$suinterpfowler->{_cdp};

	} else { 
		print("suinterpfowler, cdp, missing cdp,\n");
	 }
 }


=head2 sub eta 


=cut

 sub eta {

	my ( $self,$eta )		= @_;
	if ( $eta ne $empty_string ) {

		$suinterpfowler->{_eta}		= $eta;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' eta='.$suinterpfowler->{_eta};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' eta='.$suinterpfowler->{_eta};

	} else { 
		print("suinterpfowler, eta, missing eta,\n");
	 }
 }


=head2 sub etamax 


=cut

 sub etamax {

	my ( $self,$etamax )		= @_;
	if ( $etamax ne $empty_string ) {

		$suinterpfowler->{_etamax}		= $etamax;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' etamax='.$suinterpfowler->{_etamax};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' etamax='.$suinterpfowler->{_etamax};

	} else { 
		print("suinterpfowler, etamax, missing etamax,\n");
	 }
 }


=head2 sub etamin 


=cut

 sub etamin {

	my ( $self,$etamin )		= @_;
	if ( $etamin ne $empty_string ) {

		$suinterpfowler->{_etamin}		= $etamin;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' etamin='.$suinterpfowler->{_etamin};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' etamin='.$suinterpfowler->{_etamin};

	} else { 
		print("suinterpfowler, etamin, missing etamin,\n");
	 }
 }


=head2 sub ncdps 


=cut

 sub ncdps {

	my ( $self,$ncdps )		= @_;
	if ( $ncdps ne $empty_string ) {

		$suinterpfowler->{_ncdps}		= $ncdps;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' ncdps='.$suinterpfowler->{_ncdps};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' ncdps='.$suinterpfowler->{_ncdps};

	} else { 
		print("suinterpfowler, ncdps, missing ncdps,\n");
	 }
 }


=head2 sub neta 


=cut

 sub neta {

	my ( $self,$neta )		= @_;
	if ( $neta ne $empty_string ) {

		$suinterpfowler->{_neta}		= $neta;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' neta='.$suinterpfowler->{_neta};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' neta='.$suinterpfowler->{_neta};

	} else { 
		print("suinterpfowler, neta, missing neta,\n");
	 }
 }


=head2 sub nv 


=cut

 sub nv {

	my ( $self,$nv )		= @_;
	if ( $nv ne $empty_string ) {

		$suinterpfowler->{_nv}		= $nv;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' nv='.$suinterpfowler->{_nv};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' nv='.$suinterpfowler->{_nv};

	} else { 
		print("suinterpfowler, nv, missing nv,\n");
	 }
 }


=head2 sub nvstack 


=cut

 sub nvstack {

	my ( $self,$nvstack )		= @_;
	if ( $nvstack ne $empty_string ) {

		$suinterpfowler->{_nvstack}		= $nvstack;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' nvstack='.$suinterpfowler->{_nvstack};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' nvstack='.$suinterpfowler->{_nvstack};

	} else { 
		print("suinterpfowler, nvstack, missing nvstack,\n");
	 }
 }


=head2 sub t 


=cut

 sub t {

	my ( $self,$t )		= @_;
	if ( $t ne $empty_string ) {

		$suinterpfowler->{_t}		= $t;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' t='.$suinterpfowler->{_t};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' t='.$suinterpfowler->{_t};

	} else { 
		print("suinterpfowler, t, missing t,\n");
	 }
 }


=head2 sub v 


=cut

 sub v {

	my ( $self,$v )		= @_;
	if ( $v ne $empty_string ) {

		$suinterpfowler->{_v}		= $v;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' v='.$suinterpfowler->{_v};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' v='.$suinterpfowler->{_v};

	} else { 
		print("suinterpfowler, v, missing v,\n");
	 }
 }


=head2 sub vmax 


=cut

 sub vmax {

	my ( $self,$vmax )		= @_;
	if ( $vmax ne $empty_string ) {

		$suinterpfowler->{_vmax}		= $vmax;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' vmax='.$suinterpfowler->{_vmax};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' vmax='.$suinterpfowler->{_vmax};

	} else { 
		print("suinterpfowler, vmax, missing vmax,\n");
	 }
 }


=head2 sub vmin 


=cut

 sub vmin {

	my ( $self,$vmin )		= @_;
	if ( $vmin ne $empty_string ) {

		$suinterpfowler->{_vmin}		= $vmin;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' vmin='.$suinterpfowler->{_vmin};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' vmin='.$suinterpfowler->{_vmin};

	} else { 
		print("suinterpfowler, vmin, missing vmin,\n");
	 }
 }


=head2 sub vminstack 


=cut

 sub vminstack {

	my ( $self,$vminstack )		= @_;
	if ( $vminstack ne $empty_string ) {

		$suinterpfowler->{_vminstack}		= $vminstack;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' vminstack='.$suinterpfowler->{_vminstack};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' vminstack='.$suinterpfowler->{_vminstack};

	} else { 
		print("suinterpfowler, vminstack, missing vminstack,\n");
	 }
 }


=head2 sub vscale 


=cut

 sub vscale {

	my ( $self,$vscale )		= @_;
	if ( $vscale ne $empty_string ) {

		$suinterpfowler->{_vscale}		= $vscale;
		$suinterpfowler->{_note}		= $suinterpfowler->{_note}.' vscale='.$suinterpfowler->{_vscale};
		$suinterpfowler->{_Step}		= $suinterpfowler->{_Step}.' vscale='.$suinterpfowler->{_vscale};

	} else { 
		print("suinterpfowler, vscale, missing vscale,\n");
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