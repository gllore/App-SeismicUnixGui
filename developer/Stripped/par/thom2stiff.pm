 package thom2stiff;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  THOM2STIFF - convert Thomsen's parameters into (density normalized)	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 THOM2STIFF - convert Thomsen's parameters into (density normalized)	
                 stiffness components for transversely isotropic 	
	 	   material with in-plane-tilted axis of symmetry	

 thom2stiff [optional parameter] 		                        

 vp=2         symm.axis p-wave velocity                        	
 vs=1         symm.axis s-wave velocity                        	
 eps=0        Thomsen's (generic) epsilon 	         		
 delta=0      Thomsen's (generic) delta         			
 gamma=0      Thomsen's (generic) gamma                                
 rho=1        density                					
 phi=0        angle(DEG) vertical --> symmetry axes (clockwise)        
 sign=1       sign of c11+c44 (generally sign=1)                       
 outpar=/dev/tty	output parameter file				

 Output:								
 aijkl,cijkl	(density normalized) stiffness components               

 
 Author: CWP: Andreas Rueger  1995


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $thom2stiff		= {
		_delta					=> '',
		_eps					=> '',
		_gamma					=> '',
		_outpar					=> '',
		_phi					=> '',
		_rho					=> '',
		_sign					=> '',
		_vp					=> '',
		_vs					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$thom2stiff->{_Step}     = 'thom2stiff'.$thom2stiff->{_Step};
	return ( $thom2stiff->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$thom2stiff->{_note}     = 'thom2stiff'.$thom2stiff->{_note};
	return ( $thom2stiff->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$thom2stiff->{_delta}			= '';
		$thom2stiff->{_eps}			= '';
		$thom2stiff->{_gamma}			= '';
		$thom2stiff->{_outpar}			= '';
		$thom2stiff->{_phi}			= '';
		$thom2stiff->{_rho}			= '';
		$thom2stiff->{_sign}			= '';
		$thom2stiff->{_vp}			= '';
		$thom2stiff->{_vs}			= '';
		$thom2stiff->{_Step}			= '';
		$thom2stiff->{_note}			= '';
 }


=head2 sub delta 


=cut

 sub delta {

	my ( $self,$delta )		= @_;
	if ( $delta ne $empty_string ) {

		$thom2stiff->{_delta}		= $delta;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' delta='.$thom2stiff->{_delta};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' delta='.$thom2stiff->{_delta};

	} else { 
		print("thom2stiff, delta, missing delta,\n");
	 }
 }


=head2 sub eps 


=cut

 sub eps {

	my ( $self,$eps )		= @_;
	if ( $eps ne $empty_string ) {

		$thom2stiff->{_eps}		= $eps;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' eps='.$thom2stiff->{_eps};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' eps='.$thom2stiff->{_eps};

	} else { 
		print("thom2stiff, eps, missing eps,\n");
	 }
 }


=head2 sub gamma 


=cut

 sub gamma {

	my ( $self,$gamma )		= @_;
	if ( $gamma ne $empty_string ) {

		$thom2stiff->{_gamma}		= $gamma;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' gamma='.$thom2stiff->{_gamma};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' gamma='.$thom2stiff->{_gamma};

	} else { 
		print("thom2stiff, gamma, missing gamma,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$thom2stiff->{_outpar}		= $outpar;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' outpar='.$thom2stiff->{_outpar};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' outpar='.$thom2stiff->{_outpar};

	} else { 
		print("thom2stiff, outpar, missing outpar,\n");
	 }
 }


=head2 sub phi 


=cut

 sub phi {

	my ( $self,$phi )		= @_;
	if ( $phi ne $empty_string ) {

		$thom2stiff->{_phi}		= $phi;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' phi='.$thom2stiff->{_phi};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' phi='.$thom2stiff->{_phi};

	} else { 
		print("thom2stiff, phi, missing phi,\n");
	 }
 }


=head2 sub rho 


=cut

 sub rho {

	my ( $self,$rho )		= @_;
	if ( $rho ne $empty_string ) {

		$thom2stiff->{_rho}		= $rho;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' rho='.$thom2stiff->{_rho};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' rho='.$thom2stiff->{_rho};

	} else { 
		print("thom2stiff, rho, missing rho,\n");
	 }
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$thom2stiff->{_sign}		= $sign;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' sign='.$thom2stiff->{_sign};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' sign='.$thom2stiff->{_sign};

	} else { 
		print("thom2stiff, sign, missing sign,\n");
	 }
 }


=head2 sub vp 


=cut

 sub vp {

	my ( $self,$vp )		= @_;
	if ( $vp ne $empty_string ) {

		$thom2stiff->{_vp}		= $vp;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' vp='.$thom2stiff->{_vp};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' vp='.$thom2stiff->{_vp};

	} else { 
		print("thom2stiff, vp, missing vp,\n");
	 }
 }


=head2 sub vs 


=cut

 sub vs {

	my ( $self,$vs )		= @_;
	if ( $vs ne $empty_string ) {

		$thom2stiff->{_vs}		= $vs;
		$thom2stiff->{_note}		= $thom2stiff->{_note}.' vs='.$thom2stiff->{_vs};
		$thom2stiff->{_Step}		= $thom2stiff->{_Step}.' vs='.$thom2stiff->{_vs};

	} else { 
		print("thom2stiff, vs, missing vs,\n");
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