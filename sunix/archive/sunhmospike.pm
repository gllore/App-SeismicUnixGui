 package sunhmospike;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUNHMOSPIKE - generates SPIKE test data set with a choice of several   
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUNHMOSPIKE - generates SPIKE test data set with a choice of several   
   Non-Hyperbolic MOveouts						

   sunhmospike [optional parameters] > out_data_file  			

 Optional parameters:							
	nt=300	  number of time samples				
	ntr=20	  number of traces					
	dt=0.001	time sample rate in seconds			
	offref=2000	reference offset				

	gopt=		1 = parabolic transform model			
			2 = Foster/Mosher pseudo hyperbolic option model
			3 = linear tau-p model				
	depthref=400	reference depth used when gopt=2		
	offinc=100	offset increment				
	nspk=4	  number of events					

	p1 = 0		event moveout for event #1 in ms on reference offset
	t1 = 100	intercept time ms event #1			
	a1 = 1.0	amplitude for event #1				

	p2 = 200	event moveout for event #2 in ms on reference offset
	t2 = 100	intercept time ms for spike #2			
	a2 = 1.0	amplitude for event #2				

	p3 = 0;		event moveout for event #3 in ms on reference offset
	t3 = 200	intercept time for spike #3			
	a3 = 1.0	amplitude for event #3				
	p4 = 120	 event moveout for event #4 in ms on reference offset

	t4 = 200	intercept time s for spike #4			
	a4 = 1.0	amplitude for event #4				

	cdp = 1	 output cdp number					

 Notes:								
 Creates a common cdp su data file with up to four spike events	
 for impulse response studies for suradon, and sutifowler		


 Credits:
	CWP: Shuki Ronen, Chris Liner, 
      Modified: CWP   by John Anderson, April, 1994, to have
       appropriate trace header words and default values 
       for SUTIFOWLER tests


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sunhmospike		= {
		_a1					=> '',
		_a2					=> '',
		_a3					=> '',
		_a4					=> '',
		_cdp					=> '',
		_depthref					=> '',
		_dt					=> '',
		_gopt					=> '',
		_nspk					=> '',
		_nt					=> '',
		_ntr					=> '',
		_offinc					=> '',
		_offref					=> '',
		_p1					=> '',
		_p2					=> '',
		_p3					=> '',
		_p4					=> '',
		_t1					=> '',
		_t2					=> '',
		_t3					=> '',
		_t4					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sunhmospike->{_Step}     = 'sunhmospike'.$sunhmospike->{_Step};
	return ( $sunhmospike->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sunhmospike->{_note}     = 'sunhmospike'.$sunhmospike->{_note};
	return ( $sunhmospike->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sunhmospike->{_2}			= '';
		$sunhmospike->{_3}			= '';
		$sunhmospike->{_a1}			= '';
		$sunhmospike->{_a2}			= '';
		$sunhmospike->{_a3}			= '';
		$sunhmospike->{_a4}			= '';
		$sunhmospike->{_cdp}			= '';
		$sunhmospike->{_depthref}			= '';
		$sunhmospike->{_dt}			= '';
		$sunhmospike->{_gopt}			= '';
		$sunhmospike->{_nspk}			= '';
		$sunhmospike->{_nt}			= '';
		$sunhmospike->{_ntr}			= '';
		$sunhmospike->{_offinc}			= '';
		$sunhmospike->{_offref}			= '';
		$sunhmospike->{_p1}			= '';
		$sunhmospike->{_p2}			= '';
		$sunhmospike->{_p3}			= '';
		$sunhmospike->{_p4}			= '';
		$sunhmospike->{_t1}			= '';
		$sunhmospike->{_t2}			= '';
		$sunhmospike->{_t3}			= '';
		$sunhmospike->{_t4}			= '';
		$sunhmospike->{_Step}			= '';
		$sunhmospike->{_note}			= '';
 }


=head2 sub a1 


=cut

 sub a1 {

	my ( $self,$a1 )		= @_;
	if ( $a1 ne $empty_string ) {

		$sunhmospike->{_a1}		= $a1;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' a1='.$sunhmospike->{_a1};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' a1='.$sunhmospike->{_a1};

	} else { 
		print("sunhmospike, a1, missing a1,\n");
	 }
 }


=head2 sub a2 


=cut

 sub a2 {

	my ( $self,$a2 )		= @_;
	if ( $a2 ne $empty_string ) {

		$sunhmospike->{_a2}		= $a2;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' a2='.$sunhmospike->{_a2};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' a2='.$sunhmospike->{_a2};

	} else { 
		print("sunhmospike, a2, missing a2,\n");
	 }
 }


=head2 sub a3 


=cut

 sub a3 {

	my ( $self,$a3 )		= @_;
	if ( $a3 ne $empty_string ) {

		$sunhmospike->{_a3}		= $a3;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' a3='.$sunhmospike->{_a3};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' a3='.$sunhmospike->{_a3};

	} else { 
		print("sunhmospike, a3, missing a3,\n");
	 }
 }


=head2 sub a4 


=cut

 sub a4 {

	my ( $self,$a4 )		= @_;
	if ( $a4 ne $empty_string ) {

		$sunhmospike->{_a4}		= $a4;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' a4='.$sunhmospike->{_a4};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' a4='.$sunhmospike->{_a4};

	} else { 
		print("sunhmospike, a4, missing a4,\n");
	 }
 }


=head2 sub cdp 


=cut

 sub cdp {

	my ( $self,$cdp )		= @_;
	if ( $cdp ne $empty_string ) {

		$sunhmospike->{_cdp}		= $cdp;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' cdp='.$sunhmospike->{_cdp};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' cdp='.$sunhmospike->{_cdp};

	} else { 
		print("sunhmospike, cdp, missing cdp,\n");
	 }
 }


=head2 sub depthref 


=cut

 sub depthref {

	my ( $self,$depthref )		= @_;
	if ( $depthref ne $empty_string ) {

		$sunhmospike->{_depthref}		= $depthref;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' depthref='.$sunhmospike->{_depthref};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' depthref='.$sunhmospike->{_depthref};

	} else { 
		print("sunhmospike, depthref, missing depthref,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sunhmospike->{_dt}		= $dt;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' dt='.$sunhmospike->{_dt};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' dt='.$sunhmospike->{_dt};

	} else { 
		print("sunhmospike, dt, missing dt,\n");
	 }
 }


=head2 sub gopt 


=cut

 sub gopt {

	my ( $self,$gopt )		= @_;
	if ( $gopt ne $empty_string ) {

		$sunhmospike->{_gopt}		= $gopt;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' gopt='.$sunhmospike->{_gopt};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' gopt='.$sunhmospike->{_gopt};

	} else { 
		print("sunhmospike, gopt, missing gopt,\n");
	 }
 }


=head2 sub nspk 


=cut

 sub nspk {

	my ( $self,$nspk )		= @_;
	if ( $nspk ne $empty_string ) {

		$sunhmospike->{_nspk}		= $nspk;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' nspk='.$sunhmospike->{_nspk};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' nspk='.$sunhmospike->{_nspk};

	} else { 
		print("sunhmospike, nspk, missing nspk,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$sunhmospike->{_nt}		= $nt;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' nt='.$sunhmospike->{_nt};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' nt='.$sunhmospike->{_nt};

	} else { 
		print("sunhmospike, nt, missing nt,\n");
	 }
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sunhmospike->{_ntr}		= $ntr;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' ntr='.$sunhmospike->{_ntr};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' ntr='.$sunhmospike->{_ntr};

	} else { 
		print("sunhmospike, ntr, missing ntr,\n");
	 }
 }


=head2 sub offinc 


=cut

 sub offinc {

	my ( $self,$offinc )		= @_;
	if ( $offinc ne $empty_string ) {

		$sunhmospike->{_offinc}		= $offinc;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' offinc='.$sunhmospike->{_offinc};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' offinc='.$sunhmospike->{_offinc};

	} else { 
		print("sunhmospike, offinc, missing offinc,\n");
	 }
 }


=head2 sub offref 


=cut

 sub offref {

	my ( $self,$offref )		= @_;
	if ( $offref ne $empty_string ) {

		$sunhmospike->{_offref}		= $offref;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' offref='.$sunhmospike->{_offref};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' offref='.$sunhmospike->{_offref};

	} else { 
		print("sunhmospike, offref, missing offref,\n");
	 }
 }


=head2 sub p1 


=cut

 sub p1 {

	my ( $self,$p1 )		= @_;
	if ( $p1 ne $empty_string ) {

		$sunhmospike->{_p1}		= $p1;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' p1='.$sunhmospike->{_p1};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' p1='.$sunhmospike->{_p1};

	} else { 
		print("sunhmospike, p1, missing p1,\n");
	 }
 }


=head2 sub p2 


=cut

 sub p2 {

	my ( $self,$p2 )		= @_;
	if ( $p2 ne $empty_string ) {

		$sunhmospike->{_p2}		= $p2;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' p2='.$sunhmospike->{_p2};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' p2='.$sunhmospike->{_p2};

	} else { 
		print("sunhmospike, p2, missing p2,\n");
	 }
 }


=head2 sub p3 


=cut

 sub p3 {

	my ( $self,$p3 )		= @_;
	if ( $p3 ne $empty_string ) {

		$sunhmospike->{_p3}		= $p3;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' p3='.$sunhmospike->{_p3};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' p3='.$sunhmospike->{_p3};

	} else { 
		print("sunhmospike, p3, missing p3,\n");
	 }
 }


=head2 sub p4 


=cut

 sub p4 {

	my ( $self,$p4 )		= @_;
	if ( $p4 ne $empty_string ) {

		$sunhmospike->{_p4}		= $p4;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' p4='.$sunhmospike->{_p4};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' p4='.$sunhmospike->{_p4};

	} else { 
		print("sunhmospike, p4, missing p4,\n");
	 }
 }


=head2 sub t1 


=cut

 sub t1 {

	my ( $self,$t1 )		= @_;
	if ( $t1 ne $empty_string ) {

		$sunhmospike->{_t1}		= $t1;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' t1='.$sunhmospike->{_t1};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' t1='.$sunhmospike->{_t1};

	} else { 
		print("sunhmospike, t1, missing t1,\n");
	 }
 }


=head2 sub t2 


=cut

 sub t2 {

	my ( $self,$t2 )		= @_;
	if ( $t2 ne $empty_string ) {

		$sunhmospike->{_t2}		= $t2;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' t2='.$sunhmospike->{_t2};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' t2='.$sunhmospike->{_t2};

	} else { 
		print("sunhmospike, t2, missing t2,\n");
	 }
 }


=head2 sub t3 


=cut

 sub t3 {

	my ( $self,$t3 )		= @_;
	if ( $t3 ne $empty_string ) {

		$sunhmospike->{_t3}		= $t3;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' t3='.$sunhmospike->{_t3};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' t3='.$sunhmospike->{_t3};

	} else { 
		print("sunhmospike, t3, missing t3,\n");
	 }
 }


=head2 sub t4 


=cut

 sub t4 {

	my ( $self,$t4 )		= @_;
	if ( $t4 ne $empty_string ) {

		$sunhmospike->{_t4}		= $t4;
		$sunhmospike->{_note}		= $sunhmospike->{_note}.' t4='.$sunhmospike->{_t4};
		$sunhmospike->{_Step}		= $sunhmospike->{_Step}.' t4='.$sunhmospike->{_t4};

	} else { 
		print("sunhmospike, t4, missing t4,\n");
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