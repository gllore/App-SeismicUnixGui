 package sutihaledmo;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUTIHALEDMO - TI Hale Dip MoveOut (based on Hale's PhD thesis)	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUTIHALEDMO - TI Hale Dip MoveOut (based on Hale's PhD thesis)	

  sutihaledmo <infile >outfile [optional parameters]			


 Required Parameters:							
 nxmax		  maximum number of midpoints in common offset gather

 Optional Parameters:							
 option=1		1 = traditional Hale DMO (from PhD thesis)	
			2 = Bleistein's true amplitude DMO		
			3 = Bleistein's cos*cos weighted DMO		
			4 = Zhang's DMO					
			5 = Tsvankin's anisotropic DMO			
			6 = Tsvankin's VTI DMO weak anisotropy approximation
 dx=50.		 midpoint sampling interval between traces	
			in a common offset gather.  (usually shot	
			interval in meters)				
 v=1500.0		velocity (in meters/sec)			
			(must enter a positive value for option=3)	
			(for excluding evanescent energy)		
 h=200.0		source-receiver half-offset (in meters)		
 ntpad=0		number of time samples to pad			
 nxpad=h/dx		number of midpoints to pad			
 file=vnmo		name of file with vnmo as a function of p	
			used for option=5--otherwise not used		
			(Generate this file by running program		
			sutivel with appropriate list of Thomsen's	
			parameters.)					
 e=0.			Thompsen's epsilon				
 d=0.			Thompsen's delta				

Note:									

 This module assumes a single common offset gather after NMO is	
 to be input, DMO corrected, and output.  It is useful for computing	
 theoretical DMO impulse responses.  The Hale algorithm is		
 computationally intensive and not commonly used for bulk processing	
 of all of the offsets on a 2-D line as there are cheaper alternative	
 algorithms.  The Hale algorithm is commonly used in theoretical studies.
 Bulk processing for multiple common offset gathers is typically done	
 using other modules.							

 Test run:   suspike | sutihaledmo nxmax=32 option=1 v=1500 | suxwigb & 


 Author:  (Visitor to CSM from Mobil) John E. Anderson Spring 1994
 References: Anderson, J.E., and Tsvankin, I., 1994, Dip-moveout by
	Fourier transform in anisotropic media, CWP-146

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sutihaledmo		= {
		_2					=> '',
		_3					=> '',
		_4					=> '',
		_5					=> '',
		_6					=> '',
		_d					=> '',
		_dx					=> '',
		_e					=> '',
		_file					=> '',
		_h					=> '',
		_ntpad					=> '',
		_nxmax					=> '',
		_nxpad					=> '',
		_option					=> '',
		_v					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sutihaledmo->{_Step}     = 'sutihaledmo'.$sutihaledmo->{_Step};
	return ( $sutihaledmo->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sutihaledmo->{_note}     = 'sutihaledmo'.$sutihaledmo->{_note};
	return ( $sutihaledmo->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sutihaledmo->{_2}			= '';
		$sutihaledmo->{_3}			= '';
		$sutihaledmo->{_4}			= '';
		$sutihaledmo->{_5}			= '';
		$sutihaledmo->{_6}			= '';
		$sutihaledmo->{_d}			= '';
		$sutihaledmo->{_dx}			= '';
		$sutihaledmo->{_e}			= '';
		$sutihaledmo->{_file}			= '';
		$sutihaledmo->{_h}			= '';
		$sutihaledmo->{_ntpad}			= '';
		$sutihaledmo->{_nxmax}			= '';
		$sutihaledmo->{_nxpad}			= '';
		$sutihaledmo->{_option}			= '';
		$sutihaledmo->{_v}			= '';
		$sutihaledmo->{_Step}			= '';
		$sutihaledmo->{_note}			= '';
 }


=head2 sub 2 


=cut

 sub 2 {

	my ( $self,$2 )		= @_;
	if ( $2 ne $empty_string ) {

		$sutihaledmo->{_2}		= $2;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' 2='.$sutihaledmo->{_2};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' 2='.$sutihaledmo->{_2};

	} else { 
		print("sutihaledmo, 2, missing 2,\n");
	 }
 }


=head2 sub 3 


=cut

 sub 3 {

	my ( $self,$3 )		= @_;
	if ( $3 ne $empty_string ) {

		$sutihaledmo->{_3}		= $3;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' 3='.$sutihaledmo->{_3};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' 3='.$sutihaledmo->{_3};

	} else { 
		print("sutihaledmo, 3, missing 3,\n");
	 }
 }


=head2 sub 4 


=cut

 sub 4 {

	my ( $self,$4 )		= @_;
	if ( $4 ne $empty_string ) {

		$sutihaledmo->{_4}		= $4;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' 4='.$sutihaledmo->{_4};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' 4='.$sutihaledmo->{_4};

	} else { 
		print("sutihaledmo, 4, missing 4,\n");
	 }
 }


=head2 sub 5 


=cut

 sub 5 {

	my ( $self,$5 )		= @_;
	if ( $5 ne $empty_string ) {

		$sutihaledmo->{_5}		= $5;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' 5='.$sutihaledmo->{_5};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' 5='.$sutihaledmo->{_5};

	} else { 
		print("sutihaledmo, 5, missing 5,\n");
	 }
 }


=head2 sub 6 


=cut

 sub 6 {

	my ( $self,$6 )		= @_;
	if ( $6 ne $empty_string ) {

		$sutihaledmo->{_6}		= $6;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' 6='.$sutihaledmo->{_6};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' 6='.$sutihaledmo->{_6};

	} else { 
		print("sutihaledmo, 6, missing 6,\n");
	 }
 }


=head2 sub d 


=cut

 sub d {

	my ( $self,$d )		= @_;
	if ( $d ne $empty_string ) {

		$sutihaledmo->{_d}		= $d;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' d='.$sutihaledmo->{_d};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' d='.$sutihaledmo->{_d};

	} else { 
		print("sutihaledmo, d, missing d,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$sutihaledmo->{_dx}		= $dx;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' dx='.$sutihaledmo->{_dx};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' dx='.$sutihaledmo->{_dx};

	} else { 
		print("sutihaledmo, dx, missing dx,\n");
	 }
 }


=head2 sub e 


=cut

 sub e {

	my ( $self,$e )		= @_;
	if ( $e ne $empty_string ) {

		$sutihaledmo->{_e}		= $e;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' e='.$sutihaledmo->{_e};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' e='.$sutihaledmo->{_e};

	} else { 
		print("sutihaledmo, e, missing e,\n");
	 }
 }


=head2 sub file 


=cut

 sub file {

	my ( $self,$file )		= @_;
	if ( $file ne $empty_string ) {

		$sutihaledmo->{_file}		= $file;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' file='.$sutihaledmo->{_file};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' file='.$sutihaledmo->{_file};

	} else { 
		print("sutihaledmo, file, missing file,\n");
	 }
 }


=head2 sub h 


=cut

 sub h {

	my ( $self,$h )		= @_;
	if ( $h ne $empty_string ) {

		$sutihaledmo->{_h}		= $h;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' h='.$sutihaledmo->{_h};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' h='.$sutihaledmo->{_h};

	} else { 
		print("sutihaledmo, h, missing h,\n");
	 }
 }


=head2 sub ntpad 


=cut

 sub ntpad {

	my ( $self,$ntpad )		= @_;
	if ( $ntpad ne $empty_string ) {

		$sutihaledmo->{_ntpad}		= $ntpad;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' ntpad='.$sutihaledmo->{_ntpad};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' ntpad='.$sutihaledmo->{_ntpad};

	} else { 
		print("sutihaledmo, ntpad, missing ntpad,\n");
	 }
 }


=head2 sub nxmax 


=cut

 sub nxmax {

	my ( $self,$nxmax )		= @_;
	if ( $nxmax ne $empty_string ) {

		$sutihaledmo->{_nxmax}		= $nxmax;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' nxmax='.$sutihaledmo->{_nxmax};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' nxmax='.$sutihaledmo->{_nxmax};

	} else { 
		print("sutihaledmo, nxmax, missing nxmax,\n");
	 }
 }


=head2 sub nxpad 


=cut

 sub nxpad {

	my ( $self,$nxpad )		= @_;
	if ( $nxpad ne $empty_string ) {

		$sutihaledmo->{_nxpad}		= $nxpad;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' nxpad='.$sutihaledmo->{_nxpad};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' nxpad='.$sutihaledmo->{_nxpad};

	} else { 
		print("sutihaledmo, nxpad, missing nxpad,\n");
	 }
 }


=head2 sub option 


=cut

 sub option {

	my ( $self,$option )		= @_;
	if ( $option ne $empty_string ) {

		$sutihaledmo->{_option}		= $option;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' option='.$sutihaledmo->{_option};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' option='.$sutihaledmo->{_option};

	} else { 
		print("sutihaledmo, option, missing option,\n");
	 }
 }


=head2 sub v 


=cut

 sub v {

	my ( $self,$v )		= @_;
	if ( $v ne $empty_string ) {

		$sutihaledmo->{_v}		= $v;
		$sutihaledmo->{_note}		= $sutihaledmo->{_note}.' v='.$sutihaledmo->{_v};
		$sutihaledmo->{_Step}		= $sutihaledmo->{_Step}.' v='.$sutihaledmo->{_v};

	} else { 
		print("sutihaledmo, v, missing v,\n");
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