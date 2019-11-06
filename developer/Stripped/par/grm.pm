 package grm;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  GRM - Generalized Reciprocal refraction analysis for a single layer	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 GRM - Generalized Reciprocal refraction analysis for a single layer	

     grm <stdin >stdout  [parameters]    		 		

 Required parameters:							
 nt=		Number of arrival time pairs				
 dx=		Geophone spacing (m)					
 v0=		Velocity in weathering layer (m/s)			
 abtime=	If set to 0, use last time as a-b, else give time (ms)  

 Optional parameters:							
 XY=      Value of XY if you want to override the optimum XY		
	  algorithm in the program. If it is not an integer multiple of 
	 dx, then it will be converted to the closest			
		 one.							
	XYmax   Maximum offset distance allowed when searching for      
		optimum XY (m)  (Default is 2*dx*10)			
	depthres  Size of increment in x during verical depth search(m) 
		  (Default is 0.5m)					
 Input file:								
	4 column ASCII - x,y, forward time, reverse time 		
 Output file:								
	1) XYoptimum  							
	2) apparent refractor velcocity					
	3) x, y, z(x,y), y-z(x,y)					
		z(x,y) = calculated (GRM) depth below (x y) 		
		y-z(x,y) = GRM depth subtracted from y - absolute depth 
      .............							
      4) x, y, d(x,y), y-d(x,y), (error)  				
		d(x,y) = dip corrected depth estimate below (x,y)       
		y-d(x,y) = dip corrected absolute depth 		
		error = estimated error in depth due only to the inexact
		      matching of tangents to arcs in dip estimate.	

      If the XY calculation is bypassed and XY specified, the values	
      used will precede 1) above.  XYoptimum will still be calculated	
      and displayed for reference.					

 Notes:							       	
      Uses average refactor velocity along interface.			

  Credits:							       

     CWP: Steven D. Sheaffer						 
								       
     D. Palmer, "The Generalized Reciprocal Method of Seismic	  
     Refraction Interpretation", SEG, 1982.				  


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $grm		= {
		_XY					=> '',
		_abtime					=> '',
		_dx					=> '',
		_error					=> '',
		_nt					=> '',
		_v0					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$grm->{_Step}     = 'grm'.$grm->{_Step};
	return ( $grm->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$grm->{_note}     = 'grm'.$grm->{_note};
	return ( $grm->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$grm->{_XY}			= '';
		$grm->{_abtime}			= '';
		$grm->{_dx}			= '';
		$grm->{_error}			= '';
		$grm->{_nt}			= '';
		$grm->{_v0}			= '';
		$grm->{_Step}			= '';
		$grm->{_note}			= '';
 }


=head2 sub XY 


=cut

 sub XY {

	my ( $self,$XY )		= @_;
	if ( $XY ne $empty_string ) {

		$grm->{_XY}		= $XY;
		$grm->{_note}		= $grm->{_note}.' XY='.$grm->{_XY};
		$grm->{_Step}		= $grm->{_Step}.' XY='.$grm->{_XY};

	} else { 
		print("grm, XY, missing XY,\n");
	 }
 }


=head2 sub abtime 


=cut

 sub abtime {

	my ( $self,$abtime )		= @_;
	if ( $abtime ne $empty_string ) {

		$grm->{_abtime}		= $abtime;
		$grm->{_note}		= $grm->{_note}.' abtime='.$grm->{_abtime};
		$grm->{_Step}		= $grm->{_Step}.' abtime='.$grm->{_abtime};

	} else { 
		print("grm, abtime, missing abtime,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$grm->{_dx}		= $dx;
		$grm->{_note}		= $grm->{_note}.' dx='.$grm->{_dx};
		$grm->{_Step}		= $grm->{_Step}.' dx='.$grm->{_dx};

	} else { 
		print("grm, dx, missing dx,\n");
	 }
 }


=head2 sub error 


=cut

 sub error {

	my ( $self,$error )		= @_;
	if ( $error ne $empty_string ) {

		$grm->{_error}		= $error;
		$grm->{_note}		= $grm->{_note}.' error='.$grm->{_error};
		$grm->{_Step}		= $grm->{_Step}.' error='.$grm->{_error};

	} else { 
		print("grm, error, missing error,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$grm->{_nt}		= $nt;
		$grm->{_note}		= $grm->{_note}.' nt='.$grm->{_nt};
		$grm->{_Step}		= $grm->{_Step}.' nt='.$grm->{_nt};

	} else { 
		print("grm, nt, missing nt,\n");
	 }
 }


=head2 sub v0 


=cut

 sub v0 {

	my ( $self,$v0 )		= @_;
	if ( $v0 ne $empty_string ) {

		$grm->{_v0}		= $v0;
		$grm->{_note}		= $grm->{_note}.' v0='.$grm->{_v0};
		$grm->{_Step}		= $grm->{_Step}.' v0='.$grm->{_v0};

	} else { 
		print("grm, v0, missing v0,\n");
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