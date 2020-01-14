 package lorenz;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME: 
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES


 LORENZ - compute the LORENZ attractor				

  lorenz > [stdout]						

 Required Parameters: none					
 Optional Parameters:						
 rho=28.0		parameter for lorenz equations		
 sigma=10.0		parameter for lorenz equations		
 eta=1.6666667		parameter for lorenz equations		
 y0=1.0		initial value of y[0]			
 y1=-1.0		initial value of y[1]			
 y2=1.0		initial value of y[2]			
 h=.01			increment in time			
 tol=1.e-08		error tolerance				
 stepmax=500		maximum number of steps to compute	
 mode=xy		xy-pairs, =yz yz-pairs, =xz xz-pairs,	
			=xyz xyz-triplet, =x only, =y only, =z only
 Notes:							
 This program is really just a demo showing how to use the 	
 differential equation solver rke_solve written by Francois 	
 Pinard, based on a modified form of the 4th order Runge-Kutta 
 method, which employs the error checking method of R. England 
 1969.								

 The output consists of unformated C-style binary floats, of	
 either pairs or triplets as specified by the "mode" paramerter.

 Examples:							
 lorenz stepmax=1000 mode=xy | xgraph n=1000	&		
 lorenz stepmax=1000 mode=yz | xgraph n=1000	&		
 lorenz stepmax=1000 mode=xz | xgraph n=1000	&		

 lorenz stepmax=1000 mode=x | suaddhead ns=1000 | suxwigb &	
 lorenz stepmax=1000 mode=y | suaddhead ns=1000 | suxwigb &	
 lorenz stepmax=1000 mode=z | suaddhead ns=1000 | suxwigb &	

 GNUPLOT 3D plot example:						
 lorenz stepmax=2000 mode=xyz > lorenz.bin			
 ...when you run gnuplot type the following command ...	
 splot "lorenz.bin" binary record=2000:2000:2000 with points pointsize .1 



 The lorenz equations describe a simplified model of a convection
 cell, and are given by the autonomous system of ODE's	

	x'(t) = sigma * ( y - x )			
	y'(t) = x * ( rho - z ) - y		
	z'(t) = x * y - eta * z		

 Author: CWP: Aug 2004: John Stockwell


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $lorenz		= {
		_eta					=> '',
		_h					=> '',
		_mode					=> '',
		_record					=> '',
		_rho					=> '',
		_sigma					=> '',
		_stepmax					=> '',
		_tol					=> '',
		_y0					=> '',
		_y1					=> '',
		_y2					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$lorenz->{_Step}     = 'lorenz'.$lorenz->{_Step};
	return ( $lorenz->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$lorenz->{_note}     = 'lorenz'.$lorenz->{_note};
	return ( $lorenz->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$lorenz->{_eta}			= '';
		$lorenz->{_h}			= '';
		$lorenz->{_mode}			= '';
		$lorenz->{_record}			= '';
		$lorenz->{_rho}			= '';
		$lorenz->{_sigma}			= '';
		$lorenz->{_stepmax}			= '';
		$lorenz->{_tol}			= '';
		$lorenz->{_y0}			= '';
		$lorenz->{_y1}			= '';
		$lorenz->{_y2}			= '';
		$lorenz->{_Step}			= '';
		$lorenz->{_note}			= '';
 }


=head2 sub eta 


=cut

 sub eta {

	my ( $self,$eta )		= @_;
	if ( $eta ne $empty_string ) {

		$lorenz->{_eta}		= $eta;
		$lorenz->{_note}		= $lorenz->{_note}.' eta='.$lorenz->{_eta};
		$lorenz->{_Step}		= $lorenz->{_Step}.' eta='.$lorenz->{_eta};

	} else { 
		print("lorenz, eta, missing eta,\n");
	 }
 }


=head2 sub h 


=cut

 sub h {

	my ( $self,$h )		= @_;
	if ( $h ne $empty_string ) {

		$lorenz->{_h}		= $h;
		$lorenz->{_note}		= $lorenz->{_note}.' h='.$lorenz->{_h};
		$lorenz->{_Step}		= $lorenz->{_Step}.' h='.$lorenz->{_h};

	} else { 
		print("lorenz, h, missing h,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$lorenz->{_mode}		= $mode;
		$lorenz->{_note}		= $lorenz->{_note}.' mode='.$lorenz->{_mode};
		$lorenz->{_Step}		= $lorenz->{_Step}.' mode='.$lorenz->{_mode};

	} else { 
		print("lorenz, mode, missing mode,\n");
	 }
 }


=head2 sub record 


=cut

 sub record {

	my ( $self,$record )		= @_;
	if ( $record ne $empty_string ) {

		$lorenz->{_record}		= $record;
		$lorenz->{_note}		= $lorenz->{_note}.' record='.$lorenz->{_record};
		$lorenz->{_Step}		= $lorenz->{_Step}.' record='.$lorenz->{_record};

	} else { 
		print("lorenz, record, missing record,\n");
	 }
 }


=head2 sub rho 


=cut

 sub rho {

	my ( $self,$rho )		= @_;
	if ( $rho ne $empty_string ) {

		$lorenz->{_rho}		= $rho;
		$lorenz->{_note}		= $lorenz->{_note}.' rho='.$lorenz->{_rho};
		$lorenz->{_Step}		= $lorenz->{_Step}.' rho='.$lorenz->{_rho};

	} else { 
		print("lorenz, rho, missing rho,\n");
	 }
 }


=head2 sub sigma 


=cut

 sub sigma {

	my ( $self,$sigma )		= @_;
	if ( $sigma ne $empty_string ) {

		$lorenz->{_sigma}		= $sigma;
		$lorenz->{_note}		= $lorenz->{_note}.' sigma='.$lorenz->{_sigma};
		$lorenz->{_Step}		= $lorenz->{_Step}.' sigma='.$lorenz->{_sigma};

	} else { 
		print("lorenz, sigma, missing sigma,\n");
	 }
 }


=head2 sub stepmax 


=cut

 sub stepmax {

	my ( $self,$stepmax )		= @_;
	if ( $stepmax ne $empty_string ) {

		$lorenz->{_stepmax}		= $stepmax;
		$lorenz->{_note}		= $lorenz->{_note}.' stepmax='.$lorenz->{_stepmax};
		$lorenz->{_Step}		= $lorenz->{_Step}.' stepmax='.$lorenz->{_stepmax};

	} else { 
		print("lorenz, stepmax, missing stepmax,\n");
	 }
 }


=head2 sub tol 


=cut

 sub tol {

	my ( $self,$tol )		= @_;
	if ( $tol ne $empty_string ) {

		$lorenz->{_tol}		= $tol;
		$lorenz->{_note}		= $lorenz->{_note}.' tol='.$lorenz->{_tol};
		$lorenz->{_Step}		= $lorenz->{_Step}.' tol='.$lorenz->{_tol};

	} else { 
		print("lorenz, tol, missing tol,\n");
	 }
 }


=head2 sub y0 


=cut

 sub y0 {

	my ( $self,$y0 )		= @_;
	if ( $y0 ne $empty_string ) {

		$lorenz->{_y0}		= $y0;
		$lorenz->{_note}		= $lorenz->{_note}.' y0='.$lorenz->{_y0};
		$lorenz->{_Step}		= $lorenz->{_Step}.' y0='.$lorenz->{_y0};

	} else { 
		print("lorenz, y0, missing y0,\n");
	 }
 }


=head2 sub y1 


=cut

 sub y1 {

	my ( $self,$y1 )		= @_;
	if ( $y1 ne $empty_string ) {

		$lorenz->{_y1}		= $y1;
		$lorenz->{_note}		= $lorenz->{_note}.' y1='.$lorenz->{_y1};
		$lorenz->{_Step}		= $lorenz->{_Step}.' y1='.$lorenz->{_y1};

	} else { 
		print("lorenz, y1, missing y1,\n");
	 }
 }


=head2 sub y2 


=cut

 sub y2 {

	my ( $self,$y2 )		= @_;
	if ( $y2 ne $empty_string ) {

		$lorenz->{_y2}		= $y2;
		$lorenz->{_note}		= $lorenz->{_note}.' y2='.$lorenz->{_y2};
		$lorenz->{_Step}		= $lorenz->{_Step}.' y2='.$lorenz->{_y2};

	} else { 
		print("lorenz, y2, missing y2,\n");
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