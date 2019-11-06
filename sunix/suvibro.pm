 package suvibro;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUVIBRO - Generates a Vibroseis sweep (linear, linear-segment,
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUVIBRO - Generates a Vibroseis sweep (linear, linear-segment,
			dB per Octave, dB per Hertz, T-power)	

 suvibro [optional parameters] > out_data_file			

 Optional Parameters:						
 dt=0.004		time sampling interval			
 sweep=1	  	linear sweep			  	
 		  	=2 linear-segment			
 		  	=3 decibel per octave	 		
 		  	=4 decibel per hertz	  		
 		  	=5 t-power				
 swconst=0.0		sweep constant (see note)		
 f1=10.0		sweep frequency at start		
 f2=60.0		sweep frequency at end			
 tv=10.0		sweep length				
 phz=0.0		initial phase (radians=1 default)	
 radians=1		=0 degrees				
 fseg=10.0,60.0	frequency segments (see notes)		
 tseg=0.0,10.0		time segments (see notes)		
 t1=1.0		length of taper at start (see notes)	
 t2=1.0		length of taper at end (see notes)	
 taper=1		linear					
		  	=2 sine					
			=3 cosine				
			=4 gaussian (+/-3.8)			
			=5 gaussian (+/-2.0)			

 Notes:							
 The default tapers are linear envelopes. To eliminate the	
 taper, choose t1=t2=0.0.					

 "swconst" is active only with nonlinear sweeps, i.e. when	
 sweep=3,4,5.							", 
 "tseg" and "fseg" arrays are used when only sweep=2	

 Sweep is a modulated cosine function.				


 Author: CWP: Michel Dietrich
   Rewrite: Tagir Galikeev, CWP,  7 October 1994

 Trace header fields set: ns, dt, tracl, sfs, sfe, slen, styp

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suvibro		= {
		_dt					=> '',
		_f1					=> '',
		_f2					=> '',
		_fseg					=> '',
		_phz					=> '',
		_radians					=> '',
		_swconst					=> '',
		_sweep					=> '',
		_t1					=> '',
		_t2					=> '',
		_taper					=> '',
		_tseg					=> '',
		_tv					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suvibro->{_Step}     = 'suvibro'.$suvibro->{_Step};
	return ( $suvibro->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suvibro->{_note}     = 'suvibro'.$suvibro->{_note};
	return ( $suvibro->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suvibro->{_dt}			= '';
		$suvibro->{_f1}			= '';
		$suvibro->{_f2}			= '';
		$suvibro->{_fseg}			= '';
		$suvibro->{_phz}			= '';
		$suvibro->{_radians}			= '';
		$suvibro->{_swconst}			= '';
		$suvibro->{_sweep}			= '';
		$suvibro->{_t1}			= '';
		$suvibro->{_t2}			= '';
		$suvibro->{_taper}			= '';
		$suvibro->{_tseg}			= '';
		$suvibro->{_tv}			= '';
		$suvibro->{_Step}			= '';
		$suvibro->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suvibro->{_dt}		= $dt;
		$suvibro->{_note}		= $suvibro->{_note}.' dt='.$suvibro->{_dt};
		$suvibro->{_Step}		= $suvibro->{_Step}.' dt='.$suvibro->{_dt};

	} else { 
		print("suvibro, dt, missing dt,\n");
	 }
 }


=head2 sub f1 


=cut

 sub f1 {

	my ( $self,$f1 )		= @_;
	if ( $f1 ne $empty_string ) {

		$suvibro->{_f1}		= $f1;
		$suvibro->{_note}		= $suvibro->{_note}.' f1='.$suvibro->{_f1};
		$suvibro->{_Step}		= $suvibro->{_Step}.' f1='.$suvibro->{_f1};

	} else { 
		print("suvibro, f1, missing f1,\n");
	 }
 }


=head2 sub f2 


=cut

 sub f2 {

	my ( $self,$f2 )		= @_;
	if ( $f2 ne $empty_string ) {

		$suvibro->{_f2}		= $f2;
		$suvibro->{_note}		= $suvibro->{_note}.' f2='.$suvibro->{_f2};
		$suvibro->{_Step}		= $suvibro->{_Step}.' f2='.$suvibro->{_f2};

	} else { 
		print("suvibro, f2, missing f2,\n");
	 }
 }


=head2 sub fseg 


=cut

 sub fseg {

	my ( $self,$fseg )		= @_;
	if ( $fseg ne $empty_string ) {

		$suvibro->{_fseg}		= $fseg;
		$suvibro->{_note}		= $suvibro->{_note}.' fseg='.$suvibro->{_fseg};
		$suvibro->{_Step}		= $suvibro->{_Step}.' fseg='.$suvibro->{_fseg};

	} else { 
		print("suvibro, fseg, missing fseg,\n");
	 }
 }


=head2 sub phz 


=cut

 sub phz {

	my ( $self,$phz )		= @_;
	if ( $phz ne $empty_string ) {

		$suvibro->{_phz}		= $phz;
		$suvibro->{_note}		= $suvibro->{_note}.' phz='.$suvibro->{_phz};
		$suvibro->{_Step}		= $suvibro->{_Step}.' phz='.$suvibro->{_phz};

	} else { 
		print("suvibro, phz, missing phz,\n");
	 }
 }


=head2 sub radians 


=cut

 sub radians {

	my ( $self,$radians )		= @_;
	if ( $radians ne $empty_string ) {

		$suvibro->{_radians}		= $radians;
		$suvibro->{_note}		= $suvibro->{_note}.' radians='.$suvibro->{_radians};
		$suvibro->{_Step}		= $suvibro->{_Step}.' radians='.$suvibro->{_radians};

	} else { 
		print("suvibro, radians, missing radians,\n");
	 }
 }


=head2 sub swconst 


=cut

 sub swconst {

	my ( $self,$swconst )		= @_;
	if ( $swconst ne $empty_string ) {

		$suvibro->{_swconst}		= $swconst;
		$suvibro->{_note}		= $suvibro->{_note}.' swconst='.$suvibro->{_swconst};
		$suvibro->{_Step}		= $suvibro->{_Step}.' swconst='.$suvibro->{_swconst};

	} else { 
		print("suvibro, swconst, missing swconst,\n");
	 }
 }


=head2 sub sweep 


=cut

 sub sweep {

	my ( $self,$sweep )		= @_;
	if ( $sweep ne $empty_string ) {

		$suvibro->{_sweep}		= $sweep;
		$suvibro->{_note}		= $suvibro->{_note}.' sweep='.$suvibro->{_sweep};
		$suvibro->{_Step}		= $suvibro->{_Step}.' sweep='.$suvibro->{_sweep};

	} else { 
		print("suvibro, sweep, missing sweep,\n");
	 }
 }


=head2 sub t1 


=cut

 sub t1 {

	my ( $self,$t1 )		= @_;
	if ( $t1 ne $empty_string ) {

		$suvibro->{_t1}		= $t1;
		$suvibro->{_note}		= $suvibro->{_note}.' t1='.$suvibro->{_t1};
		$suvibro->{_Step}		= $suvibro->{_Step}.' t1='.$suvibro->{_t1};

	} else { 
		print("suvibro, t1, missing t1,\n");
	 }
 }


=head2 sub t2 


=cut

 sub t2 {

	my ( $self,$t2 )		= @_;
	if ( $t2 ne $empty_string ) {

		$suvibro->{_t2}		= $t2;
		$suvibro->{_note}		= $suvibro->{_note}.' t2='.$suvibro->{_t2};
		$suvibro->{_Step}		= $suvibro->{_Step}.' t2='.$suvibro->{_t2};

	} else { 
		print("suvibro, t2, missing t2,\n");
	 }
 }


=head2 sub taper 


=cut

 sub taper {

	my ( $self,$taper )		= @_;
	if ( $taper ne $empty_string ) {

		$suvibro->{_taper}		= $taper;
		$suvibro->{_note}		= $suvibro->{_note}.' taper='.$suvibro->{_taper};
		$suvibro->{_Step}		= $suvibro->{_Step}.' taper='.$suvibro->{_taper};

	} else { 
		print("suvibro, taper, missing taper,\n");
	 }
 }


=head2 sub tseg 


=cut

 sub tseg {

	my ( $self,$tseg )		= @_;
	if ( $tseg ne $empty_string ) {

		$suvibro->{_tseg}		= $tseg;
		$suvibro->{_note}		= $suvibro->{_note}.' tseg='.$suvibro->{_tseg};
		$suvibro->{_Step}		= $suvibro->{_Step}.' tseg='.$suvibro->{_tseg};

	} else { 
		print("suvibro, tseg, missing tseg,\n");
	 }
 }


=head2 sub tv 


=cut

 sub tv {

	my ( $self,$tv )		= @_;
	if ( $tv ne $empty_string ) {

		$suvibro->{_tv}		= $tv;
		$suvibro->{_note}		= $suvibro->{_note}.' tv='.$suvibro->{_tv};
		$suvibro->{_Step}		= $suvibro->{_Step}.' tv='.$suvibro->{_tv};

	} else { 
		print("suvibro, tv, missing tv,\n");
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