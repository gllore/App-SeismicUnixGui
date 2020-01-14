 package verhulst;


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


 VERHULST - solve the VERHULST logistic equation		

  verhulst > [stdout]						

 Required Parameters: none					
 Optional Parameters:						
 a1=1.0		parameter for verhulst equation		
 a2=2000		parameter for verhulst equation		
 y0=10			initial value of y[0]			
 h=.01			increment in time			
 tol=1.e-08		error tolerance				
 stepmax=2000		maximum number of steps to compute	
 mode=x		xy-pairs, =yz yz-pairs, =xz xz-pairs,	
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
 x is the population						
 verhulst stepmax=2000 mode=x | suaddhead ns=2000 | suxwigb &	
 y is dx/dt, the rate of growth of the population		
 verhulst stepmax=2000 mode=y | suaddhead ns=2000 | suxwigb &	

 In the Verhulst equation, a1 is the reproduction rate and	
 a2 is the carrying capacity					
 	x'(t) = a1 * x * ( 1 - x/a2 )			 	


 The verhulst equation describes a simplified model of a population
 reproducing in an environment with limited resources,
 and are given by the autonomous system of ODE's	
	y'(t) = a1 * y ( 1 - y/a2 )			

 Author: CWP: Aug 2009: John Stockwell


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $verhulst		= {
		_a1					=> '',
		_a2					=> '',
		_h					=> '',
		_mode					=> '',
		_stepmax					=> '',
		_tol					=> '',
		_y0					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$verhulst->{_Step}     = 'verhulst'.$verhulst->{_Step};
	return ( $verhulst->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$verhulst->{_note}     = 'verhulst'.$verhulst->{_note};
	return ( $verhulst->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$verhulst->{_a1}			= '';
		$verhulst->{_a2}			= '';
		$verhulst->{_h}			= '';
		$verhulst->{_mode}			= '';
		$verhulst->{_stepmax}			= '';
		$verhulst->{_tol}			= '';
		$verhulst->{_y0}			= '';
		$verhulst->{_Step}			= '';
		$verhulst->{_note}			= '';
 }


=head2 sub a1 


=cut

 sub a1 {

	my ( $self,$a1 )		= @_;
	if ( $a1 ne $empty_string ) {

		$verhulst->{_a1}		= $a1;
		$verhulst->{_note}		= $verhulst->{_note}.' a1='.$verhulst->{_a1};
		$verhulst->{_Step}		= $verhulst->{_Step}.' a1='.$verhulst->{_a1};

	} else { 
		print("verhulst, a1, missing a1,\n");
	 }
 }


=head2 sub a2 


=cut

 sub a2 {

	my ( $self,$a2 )		= @_;
	if ( $a2 ne $empty_string ) {

		$verhulst->{_a2}		= $a2;
		$verhulst->{_note}		= $verhulst->{_note}.' a2='.$verhulst->{_a2};
		$verhulst->{_Step}		= $verhulst->{_Step}.' a2='.$verhulst->{_a2};

	} else { 
		print("verhulst, a2, missing a2,\n");
	 }
 }


=head2 sub h 


=cut

 sub h {

	my ( $self,$h )		= @_;
	if ( $h ne $empty_string ) {

		$verhulst->{_h}		= $h;
		$verhulst->{_note}		= $verhulst->{_note}.' h='.$verhulst->{_h};
		$verhulst->{_Step}		= $verhulst->{_Step}.' h='.$verhulst->{_h};

	} else { 
		print("verhulst, h, missing h,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$verhulst->{_mode}		= $mode;
		$verhulst->{_note}		= $verhulst->{_note}.' mode='.$verhulst->{_mode};
		$verhulst->{_Step}		= $verhulst->{_Step}.' mode='.$verhulst->{_mode};

	} else { 
		print("verhulst, mode, missing mode,\n");
	 }
 }


=head2 sub stepmax 


=cut

 sub stepmax {

	my ( $self,$stepmax )		= @_;
	if ( $stepmax ne $empty_string ) {

		$verhulst->{_stepmax}		= $stepmax;
		$verhulst->{_note}		= $verhulst->{_note}.' stepmax='.$verhulst->{_stepmax};
		$verhulst->{_Step}		= $verhulst->{_Step}.' stepmax='.$verhulst->{_stepmax};

	} else { 
		print("verhulst, stepmax, missing stepmax,\n");
	 }
 }


=head2 sub tol 


=cut

 sub tol {

	my ( $self,$tol )		= @_;
	if ( $tol ne $empty_string ) {

		$verhulst->{_tol}		= $tol;
		$verhulst->{_note}		= $verhulst->{_note}.' tol='.$verhulst->{_tol};
		$verhulst->{_Step}		= $verhulst->{_Step}.' tol='.$verhulst->{_tol};

	} else { 
		print("verhulst, tol, missing tol,\n");
	 }
 }


=head2 sub y0 


=cut

 sub y0 {

	my ( $self,$y0 )		= @_;
	if ( $y0 ne $empty_string ) {

		$verhulst->{_y0}		= $y0;
		$verhulst->{_note}		= $verhulst->{_note}.' y0='.$verhulst->{_y0};
		$verhulst->{_Step}		= $verhulst->{_Step}.' y0='.$verhulst->{_y0};

	} else { 
		print("verhulst, y0, missing y0,\n");
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