 package regrid3;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  REGRID3 - REwrite a [ni3][ni2][ni1] GRID to a [no3][no2][no1] 3-D grid
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 REGRID3 - REwrite a [ni3][ni2][ni1] GRID to a [no3][no2][no1] 3-D grid

 regrid3 < oldgrid > newgrid [parameters]				

 Optional parameters:							
 ni1=1   fastest (3rd) dimension in input grid                         
 ni2=1   second fastest (2nd) dimension in input grid			
 ni3=1   slowest (1st) dimension in input grid                       	
 no1=1   fastest (3rd) dimension in output grid                        
 no2=1   second fastest (2nd) dimension in output grid                 ",                
 no3=1   slowest (1st) dimension in output grid                        
 Optional Parameters:                                                  
 verbose=0	=1 print some useful information			

 Notes:								
 REGRID3 can be used to span a 1-D grid to a 2-D grid,  or a 2-D grid  
 to a 3-D grid; or to change grid parameters within the dimensions.	
 Together with MUL and UNIF3, most 3-D velocity model can be 		


 Credits:
  	CWP: Zhaobo Meng, 1996, Colorado School of Mines

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $regrid3		= {
		_ni1					=> '',
		_ni2					=> '',
		_ni3					=> '',
		_no1					=> '',
		_no2					=> '',
		_no3					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$regrid3->{_Step}     = 'regrid3'.$regrid3->{_Step};
	return ( $regrid3->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$regrid3->{_note}     = 'regrid3'.$regrid3->{_note};
	return ( $regrid3->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$regrid3->{_ni1}			= '';
		$regrid3->{_ni2}			= '';
		$regrid3->{_ni3}			= '';
		$regrid3->{_no1}			= '';
		$regrid3->{_no2}			= '';
		$regrid3->{_no3}			= '';
		$regrid3->{_verbose}			= '';
		$regrid3->{_Step}			= '';
		$regrid3->{_note}			= '';
 }


=head2 sub ni1 


=cut

 sub ni1 {

	my ( $self,$ni1 )		= @_;
	if ( $ni1 ne $empty_string ) {

		$regrid3->{_ni1}		= $ni1;
		$regrid3->{_note}		= $regrid3->{_note}.' ni1='.$regrid3->{_ni1};
		$regrid3->{_Step}		= $regrid3->{_Step}.' ni1='.$regrid3->{_ni1};

	} else { 
		print("regrid3, ni1, missing ni1,\n");
	 }
 }


=head2 sub ni2 


=cut

 sub ni2 {

	my ( $self,$ni2 )		= @_;
	if ( $ni2 ne $empty_string ) {

		$regrid3->{_ni2}		= $ni2;
		$regrid3->{_note}		= $regrid3->{_note}.' ni2='.$regrid3->{_ni2};
		$regrid3->{_Step}		= $regrid3->{_Step}.' ni2='.$regrid3->{_ni2};

	} else { 
		print("regrid3, ni2, missing ni2,\n");
	 }
 }


=head2 sub ni3 


=cut

 sub ni3 {

	my ( $self,$ni3 )		= @_;
	if ( $ni3 ne $empty_string ) {

		$regrid3->{_ni3}		= $ni3;
		$regrid3->{_note}		= $regrid3->{_note}.' ni3='.$regrid3->{_ni3};
		$regrid3->{_Step}		= $regrid3->{_Step}.' ni3='.$regrid3->{_ni3};

	} else { 
		print("regrid3, ni3, missing ni3,\n");
	 }
 }


=head2 sub no1 


=cut

 sub no1 {

	my ( $self,$no1 )		= @_;
	if ( $no1 ne $empty_string ) {

		$regrid3->{_no1}		= $no1;
		$regrid3->{_note}		= $regrid3->{_note}.' no1='.$regrid3->{_no1};
		$regrid3->{_Step}		= $regrid3->{_Step}.' no1='.$regrid3->{_no1};

	} else { 
		print("regrid3, no1, missing no1,\n");
	 }
 }


=head2 sub no2 


=cut

 sub no2 {

	my ( $self,$no2 )		= @_;
	if ( $no2 ne $empty_string ) {

		$regrid3->{_no2}		= $no2;
		$regrid3->{_note}		= $regrid3->{_note}.' no2='.$regrid3->{_no2};
		$regrid3->{_Step}		= $regrid3->{_Step}.' no2='.$regrid3->{_no2};

	} else { 
		print("regrid3, no2, missing no2,\n");
	 }
 }


=head2 sub no3 


=cut

 sub no3 {

	my ( $self,$no3 )		= @_;
	if ( $no3 ne $empty_string ) {

		$regrid3->{_no3}		= $no3;
		$regrid3->{_note}		= $regrid3->{_note}.' no3='.$regrid3->{_no3};
		$regrid3->{_Step}		= $regrid3->{_Step}.' no3='.$regrid3->{_no3};

	} else { 
		print("regrid3, no3, missing no3,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$regrid3->{_verbose}		= $verbose;
		$regrid3->{_note}		= $regrid3->{_note}.' verbose='.$regrid3->{_verbose};
		$regrid3->{_Step}		= $regrid3->{_Step}.' verbose='.$regrid3->{_verbose};

	} else { 
		print("regrid3, verbose, missing verbose,\n");
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