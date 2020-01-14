 package sutivel;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:   SUTIVEL -  SU Transversely Isotropic velocity table builder		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

  SUTIVEL -  SU Transversely Isotropic velocity table builder		
	computes vnmo or vphase as a function of Thomsen's parameters and
	theta and optionally interpolate to constant increments in slowness

 Optional Parameters:							
 a=2500.		alpha (vertical p velocity)			
 b=1250.		beta (vertical sv velocity)			
 e=.20			epsilon (horiz p-wave anisotropy)		
 d=.10			delta (strange parameter)			
 maxangle=90.0		max angle in degrees				
 nangle=9001		number of angles to compute			
 verbose=0		set to 1 to see full listing			
 np=8001		number of slowness values to output		
 option=1		1=output vnmo(p) (result used for TI DMO)	
			2=output vnmo(theta) in degrees			
			3=output vnmo(theta) in radians			
			4=output vphase(p)				
			5=output vphase(theta) in degrees		
			6=output vphase(theta) in radians		
			7=output first derivative vphase(p)		
			8=output first derivative vphase(theta) in degrees
			9=output first derivative vphase(theta) in radians
			10=output second derivative vphase(p)		
			11=output second derivative vphase(theta) in degrees
			12=output second derivative vphase(theta) in radians
			13=( 1/vnmo(0)^2 -1/vnmo(theta)^2 )/p^2 test vs theta
			   (result should be zero for all theta for d=e)
			14=return vnmo(p) for weak anisotropy		
 normalize=0		=1 means scale vnmo by cosine and scale vphase by
 			    1/sqrt(1+2*e*sin(theta)*sin(theta)		
	 		   (only useful for vphase when d=e for constant
				result)					
			=0 means output vnmo or vphase unnormalized	

 Output on standard output is ascii text with:				
 line   1: number of values						
 line   2: abscissa increment (p or theta increment, always starts at zero)
 line 3-n: one value per line						



 Author: (visitor to CSM form Mobil) John E. Anderson, Spring 1994

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sutivel		= {
		_10					=> '',
		_11					=> '',
		_12					=> '',
		_13					=> '',
		_14					=> '',
		_2					=> '',
		_3					=> '',
		_4					=> '',
		_5					=> '',
		_6					=> '',
		_7					=> '',
		_8					=> '',
		_9					=> '',
		_a					=> '',
		_b					=> '',
		_d					=> '',
		_e					=> '',
		_maxangle					=> '',
		_nangle					=> '',
		_normalize					=> '',
		_np					=> '',
		_option					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sutivel->{_Step}     = 'sutivel'.$sutivel->{_Step};
	return ( $sutivel->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sutivel->{_note}     = 'sutivel'.$sutivel->{_note};
	return ( $sutivel->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sutivel->{_10}			= '';
		$sutivel->{_11}			= '';
		$sutivel->{_12}			= '';
		$sutivel->{_13}			= '';
		$sutivel->{_14}			= '';
		$sutivel->{_2}			= '';
		$sutivel->{_3}			= '';
		$sutivel->{_4}			= '';
		$sutivel->{_5}			= '';
		$sutivel->{_6}			= '';
		$sutivel->{_7}			= '';
		$sutivel->{_8}			= '';
		$sutivel->{_9}			= '';
		$sutivel->{_a}			= '';
		$sutivel->{_b}			= '';
		$sutivel->{_d}			= '';
		$sutivel->{_e}			= '';
		$sutivel->{_maxangle}			= '';
		$sutivel->{_nangle}			= '';
		$sutivel->{_normalize}			= '';
		$sutivel->{_np}			= '';
		$sutivel->{_option}			= '';
		$sutivel->{_verbose}			= '';
		$sutivel->{_Step}			= '';
		$sutivel->{_note}			= '';
 }


=head2 sub 10 


=cut

 sub 10 {

	my ( $self,$10 )		= @_;
	if ( $10 ne $empty_string ) {

		$sutivel->{_10}		= $10;
		$sutivel->{_note}		= $sutivel->{_note}.' 10='.$sutivel->{_10};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 10='.$sutivel->{_10};

	} else { 
		print("sutivel, 10, missing 10,\n");
	 }
 }


=head2 sub 11 


=cut

 sub 11 {

	my ( $self,$11 )		= @_;
	if ( $11 ne $empty_string ) {

		$sutivel->{_11}		= $11;
		$sutivel->{_note}		= $sutivel->{_note}.' 11='.$sutivel->{_11};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 11='.$sutivel->{_11};

	} else { 
		print("sutivel, 11, missing 11,\n");
	 }
 }


=head2 sub 12 


=cut

 sub 12 {

	my ( $self,$12 )		= @_;
	if ( $12 ne $empty_string ) {

		$sutivel->{_12}		= $12;
		$sutivel->{_note}		= $sutivel->{_note}.' 12='.$sutivel->{_12};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 12='.$sutivel->{_12};

	} else { 
		print("sutivel, 12, missing 12,\n");
	 }
 }


=head2 sub 13 


=cut

 sub 13 {

	my ( $self,$13 )		= @_;
	if ( $13 ne $empty_string ) {

		$sutivel->{_13}		= $13;
		$sutivel->{_note}		= $sutivel->{_note}.' 13='.$sutivel->{_13};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 13='.$sutivel->{_13};

	} else { 
		print("sutivel, 13, missing 13,\n");
	 }
 }


=head2 sub 14 


=cut

 sub 14 {

	my ( $self,$14 )		= @_;
	if ( $14 ne $empty_string ) {

		$sutivel->{_14}		= $14;
		$sutivel->{_note}		= $sutivel->{_note}.' 14='.$sutivel->{_14};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 14='.$sutivel->{_14};

	} else { 
		print("sutivel, 14, missing 14,\n");
	 }
 }


=head2 sub 2 


=cut

 sub 2 {

	my ( $self,$2 )		= @_;
	if ( $2 ne $empty_string ) {

		$sutivel->{_2}		= $2;
		$sutivel->{_note}		= $sutivel->{_note}.' 2='.$sutivel->{_2};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 2='.$sutivel->{_2};

	} else { 
		print("sutivel, 2, missing 2,\n");
	 }
 }


=head2 sub 3 


=cut

 sub 3 {

	my ( $self,$3 )		= @_;
	if ( $3 ne $empty_string ) {

		$sutivel->{_3}		= $3;
		$sutivel->{_note}		= $sutivel->{_note}.' 3='.$sutivel->{_3};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 3='.$sutivel->{_3};

	} else { 
		print("sutivel, 3, missing 3,\n");
	 }
 }


=head2 sub 4 


=cut

 sub 4 {

	my ( $self,$4 )		= @_;
	if ( $4 ne $empty_string ) {

		$sutivel->{_4}		= $4;
		$sutivel->{_note}		= $sutivel->{_note}.' 4='.$sutivel->{_4};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 4='.$sutivel->{_4};

	} else { 
		print("sutivel, 4, missing 4,\n");
	 }
 }


=head2 sub 5 


=cut

 sub 5 {

	my ( $self,$5 )		= @_;
	if ( $5 ne $empty_string ) {

		$sutivel->{_5}		= $5;
		$sutivel->{_note}		= $sutivel->{_note}.' 5='.$sutivel->{_5};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 5='.$sutivel->{_5};

	} else { 
		print("sutivel, 5, missing 5,\n");
	 }
 }


=head2 sub 6 


=cut

 sub 6 {

	my ( $self,$6 )		= @_;
	if ( $6 ne $empty_string ) {

		$sutivel->{_6}		= $6;
		$sutivel->{_note}		= $sutivel->{_note}.' 6='.$sutivel->{_6};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 6='.$sutivel->{_6};

	} else { 
		print("sutivel, 6, missing 6,\n");
	 }
 }


=head2 sub 7 


=cut

 sub 7 {

	my ( $self,$7 )		= @_;
	if ( $7 ne $empty_string ) {

		$sutivel->{_7}		= $7;
		$sutivel->{_note}		= $sutivel->{_note}.' 7='.$sutivel->{_7};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 7='.$sutivel->{_7};

	} else { 
		print("sutivel, 7, missing 7,\n");
	 }
 }


=head2 sub 8 


=cut

 sub 8 {

	my ( $self,$8 )		= @_;
	if ( $8 ne $empty_string ) {

		$sutivel->{_8}		= $8;
		$sutivel->{_note}		= $sutivel->{_note}.' 8='.$sutivel->{_8};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 8='.$sutivel->{_8};

	} else { 
		print("sutivel, 8, missing 8,\n");
	 }
 }


=head2 sub 9 


=cut

 sub 9 {

	my ( $self,$9 )		= @_;
	if ( $9 ne $empty_string ) {

		$sutivel->{_9}		= $9;
		$sutivel->{_note}		= $sutivel->{_note}.' 9='.$sutivel->{_9};
		$sutivel->{_Step}		= $sutivel->{_Step}.' 9='.$sutivel->{_9};

	} else { 
		print("sutivel, 9, missing 9,\n");
	 }
 }


=head2 sub a 


=cut

 sub a {

	my ( $self,$a )		= @_;
	if ( $a ne $empty_string ) {

		$sutivel->{_a}		= $a;
		$sutivel->{_note}		= $sutivel->{_note}.' a='.$sutivel->{_a};
		$sutivel->{_Step}		= $sutivel->{_Step}.' a='.$sutivel->{_a};

	} else { 
		print("sutivel, a, missing a,\n");
	 }
 }


=head2 sub b 


=cut

 sub b {

	my ( $self,$b )		= @_;
	if ( $b ne $empty_string ) {

		$sutivel->{_b}		= $b;
		$sutivel->{_note}		= $sutivel->{_note}.' b='.$sutivel->{_b};
		$sutivel->{_Step}		= $sutivel->{_Step}.' b='.$sutivel->{_b};

	} else { 
		print("sutivel, b, missing b,\n");
	 }
 }


=head2 sub d 


=cut

 sub d {

	my ( $self,$d )		= @_;
	if ( $d ne $empty_string ) {

		$sutivel->{_d}		= $d;
		$sutivel->{_note}		= $sutivel->{_note}.' d='.$sutivel->{_d};
		$sutivel->{_Step}		= $sutivel->{_Step}.' d='.$sutivel->{_d};

	} else { 
		print("sutivel, d, missing d,\n");
	 }
 }


=head2 sub e 


=cut

 sub e {

	my ( $self,$e )		= @_;
	if ( $e ne $empty_string ) {

		$sutivel->{_e}		= $e;
		$sutivel->{_note}		= $sutivel->{_note}.' e='.$sutivel->{_e};
		$sutivel->{_Step}		= $sutivel->{_Step}.' e='.$sutivel->{_e};

	} else { 
		print("sutivel, e, missing e,\n");
	 }
 }


=head2 sub maxangle 


=cut

 sub maxangle {

	my ( $self,$maxangle )		= @_;
	if ( $maxangle ne $empty_string ) {

		$sutivel->{_maxangle}		= $maxangle;
		$sutivel->{_note}		= $sutivel->{_note}.' maxangle='.$sutivel->{_maxangle};
		$sutivel->{_Step}		= $sutivel->{_Step}.' maxangle='.$sutivel->{_maxangle};

	} else { 
		print("sutivel, maxangle, missing maxangle,\n");
	 }
 }


=head2 sub nangle 


=cut

 sub nangle {

	my ( $self,$nangle )		= @_;
	if ( $nangle ne $empty_string ) {

		$sutivel->{_nangle}		= $nangle;
		$sutivel->{_note}		= $sutivel->{_note}.' nangle='.$sutivel->{_nangle};
		$sutivel->{_Step}		= $sutivel->{_Step}.' nangle='.$sutivel->{_nangle};

	} else { 
		print("sutivel, nangle, missing nangle,\n");
	 }
 }


=head2 sub normalize 


=cut

 sub normalize {

	my ( $self,$normalize )		= @_;
	if ( $normalize ne $empty_string ) {

		$sutivel->{_normalize}		= $normalize;
		$sutivel->{_note}		= $sutivel->{_note}.' normalize='.$sutivel->{_normalize};
		$sutivel->{_Step}		= $sutivel->{_Step}.' normalize='.$sutivel->{_normalize};

	} else { 
		print("sutivel, normalize, missing normalize,\n");
	 }
 }


=head2 sub np 


=cut

 sub np {

	my ( $self,$np )		= @_;
	if ( $np ne $empty_string ) {

		$sutivel->{_np}		= $np;
		$sutivel->{_note}		= $sutivel->{_note}.' np='.$sutivel->{_np};
		$sutivel->{_Step}		= $sutivel->{_Step}.' np='.$sutivel->{_np};

	} else { 
		print("sutivel, np, missing np,\n");
	 }
 }


=head2 sub option 


=cut

 sub option {

	my ( $self,$option )		= @_;
	if ( $option ne $empty_string ) {

		$sutivel->{_option}		= $option;
		$sutivel->{_note}		= $sutivel->{_note}.' option='.$sutivel->{_option};
		$sutivel->{_Step}		= $sutivel->{_Step}.' option='.$sutivel->{_option};

	} else { 
		print("sutivel, option, missing option,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sutivel->{_verbose}		= $verbose;
		$sutivel->{_note}		= $sutivel->{_note}.' verbose='.$sutivel->{_verbose};
		$sutivel->{_Step}		= $sutivel->{_Step}.' verbose='.$sutivel->{_verbose};

	} else { 
		print("sutivel, verbose, missing verbose,\n");
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