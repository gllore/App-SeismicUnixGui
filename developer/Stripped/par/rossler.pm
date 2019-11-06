 package rossler;


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


 ROSSLER - compute the ROSSLER attractor				

  rossler > [stdout]						

 Required Parameters: none					
 Optional Parameters:						
 a=.2			parameter for rossler equations		
 b=.2			parameter for rossler equations		
 c=5.7			parameter for rossler equations		
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
 rossler stepmax=1000 mode=xy | xgraph n=1000	&		
 rossler stepmax=1000 mode=yz | xgraph n=1000	&		
 rossler stepmax=1000 mode=xz | xgraph n=1000	&		

 rossler stepmax=1000 mode=x | suaddhead ns=1000 | suxwigb &	
 rossler stepmax=1000 mode=y | suaddhead ns=1000 | suxwigb &	
 rossler stepmax=1000 mode=z | suaddhead ns=1000 | suxwigb &	

 GNUPLOT 3D plot example:                                      
 rossler stepmax=2000 mode=xyz > rossler.bin                   
 ...when you run gnuplot type the following command ...        
 splot "rossler.bin" binary record=2000:2000:2000 with points pointsize .1 



 The rossler equations describe a simple example of a chaotic system
 and are given by the autonomous system of ODE's	

	x'(t) = - y - z
	y'(t) = x + a y
	z'(t) = b + z(x - c)

 Author: CWP: Aug 2013: John Stockwell


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $rossler		= {
		_a					=> '',
		_b					=> '',
		_c					=> '',
		_h					=> '',
		_mode					=> '',
		_record					=> '',
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

	$rossler->{_Step}     = 'rossler'.$rossler->{_Step};
	return ( $rossler->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$rossler->{_note}     = 'rossler'.$rossler->{_note};
	return ( $rossler->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$rossler->{_a}			= '';
		$rossler->{_b}			= '';
		$rossler->{_c}			= '';
		$rossler->{_h}			= '';
		$rossler->{_mode}			= '';
		$rossler->{_record}			= '';
		$rossler->{_stepmax}			= '';
		$rossler->{_tol}			= '';
		$rossler->{_y0}			= '';
		$rossler->{_y1}			= '';
		$rossler->{_y2}			= '';
		$rossler->{_Step}			= '';
		$rossler->{_note}			= '';
 }


=head2 sub a 


=cut

 sub a {

	my ( $self,$a )		= @_;
	if ( $a ne $empty_string ) {

		$rossler->{_a}		= $a;
		$rossler->{_note}		= $rossler->{_note}.' a='.$rossler->{_a};
		$rossler->{_Step}		= $rossler->{_Step}.' a='.$rossler->{_a};

	} else { 
		print("rossler, a, missing a,\n");
	 }
 }


=head2 sub b 


=cut

 sub b {

	my ( $self,$b )		= @_;
	if ( $b ne $empty_string ) {

		$rossler->{_b}		= $b;
		$rossler->{_note}		= $rossler->{_note}.' b='.$rossler->{_b};
		$rossler->{_Step}		= $rossler->{_Step}.' b='.$rossler->{_b};

	} else { 
		print("rossler, b, missing b,\n");
	 }
 }


=head2 sub c 


=cut

 sub c {

	my ( $self,$c )		= @_;
	if ( $c ne $empty_string ) {

		$rossler->{_c}		= $c;
		$rossler->{_note}		= $rossler->{_note}.' c='.$rossler->{_c};
		$rossler->{_Step}		= $rossler->{_Step}.' c='.$rossler->{_c};

	} else { 
		print("rossler, c, missing c,\n");
	 }
 }


=head2 sub h 


=cut

 sub h {

	my ( $self,$h )		= @_;
	if ( $h ne $empty_string ) {

		$rossler->{_h}		= $h;
		$rossler->{_note}		= $rossler->{_note}.' h='.$rossler->{_h};
		$rossler->{_Step}		= $rossler->{_Step}.' h='.$rossler->{_h};

	} else { 
		print("rossler, h, missing h,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$rossler->{_mode}		= $mode;
		$rossler->{_note}		= $rossler->{_note}.' mode='.$rossler->{_mode};
		$rossler->{_Step}		= $rossler->{_Step}.' mode='.$rossler->{_mode};

	} else { 
		print("rossler, mode, missing mode,\n");
	 }
 }


=head2 sub record 


=cut

 sub record {

	my ( $self,$record )		= @_;
	if ( $record ne $empty_string ) {

		$rossler->{_record}		= $record;
		$rossler->{_note}		= $rossler->{_note}.' record='.$rossler->{_record};
		$rossler->{_Step}		= $rossler->{_Step}.' record='.$rossler->{_record};

	} else { 
		print("rossler, record, missing record,\n");
	 }
 }


=head2 sub stepmax 


=cut

 sub stepmax {

	my ( $self,$stepmax )		= @_;
	if ( $stepmax ne $empty_string ) {

		$rossler->{_stepmax}		= $stepmax;
		$rossler->{_note}		= $rossler->{_note}.' stepmax='.$rossler->{_stepmax};
		$rossler->{_Step}		= $rossler->{_Step}.' stepmax='.$rossler->{_stepmax};

	} else { 
		print("rossler, stepmax, missing stepmax,\n");
	 }
 }


=head2 sub tol 


=cut

 sub tol {

	my ( $self,$tol )		= @_;
	if ( $tol ne $empty_string ) {

		$rossler->{_tol}		= $tol;
		$rossler->{_note}		= $rossler->{_note}.' tol='.$rossler->{_tol};
		$rossler->{_Step}		= $rossler->{_Step}.' tol='.$rossler->{_tol};

	} else { 
		print("rossler, tol, missing tol,\n");
	 }
 }


=head2 sub y0 


=cut

 sub y0 {

	my ( $self,$y0 )		= @_;
	if ( $y0 ne $empty_string ) {

		$rossler->{_y0}		= $y0;
		$rossler->{_note}		= $rossler->{_note}.' y0='.$rossler->{_y0};
		$rossler->{_Step}		= $rossler->{_Step}.' y0='.$rossler->{_y0};

	} else { 
		print("rossler, y0, missing y0,\n");
	 }
 }


=head2 sub y1 


=cut

 sub y1 {

	my ( $self,$y1 )		= @_;
	if ( $y1 ne $empty_string ) {

		$rossler->{_y1}		= $y1;
		$rossler->{_note}		= $rossler->{_note}.' y1='.$rossler->{_y1};
		$rossler->{_Step}		= $rossler->{_Step}.' y1='.$rossler->{_y1};

	} else { 
		print("rossler, y1, missing y1,\n");
	 }
 }


=head2 sub y2 


=cut

 sub y2 {

	my ( $self,$y2 )		= @_;
	if ( $y2 ne $empty_string ) {

		$rossler->{_y2}		= $y2;
		$rossler->{_note}		= $rossler->{_note}.' y2='.$rossler->{_y2};
		$rossler->{_Step}		= $rossler->{_Step}.' y2='.$rossler->{_y2};

	} else { 
		print("rossler, y2, missing y2,\n");
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