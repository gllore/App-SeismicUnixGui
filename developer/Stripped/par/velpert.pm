 package velpert;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  VELPERT - estimate velocity parameter perturbation from covariance 	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 VELPERT - estimate velocity parameter perturbation from covariance 	
	 of imaged depths in common image gathers (CIGs)		

 verpert <dfile dzfile=dzfile >outfile [parameters]			

 Required Parameters:							
 dfile			input of imaged depths in CIGs			
 dzfile=dzfile		input of dz/dv at the imaged depths in CIGs	
 outfile		output of the estimated parameter 		
 noff			number of offsets 				
 ncip			number of common image gathers 			

 Optional Parameters:							
 moff=noff	number of first offsets used in velocity estimation  	

 Notes:								
 1. This program is part of Zhenyue Liu's velocity analysis technique.	
    The input dzdv values are computed using the program dzdv.		
 2. For given depths, using moff smaller than noff may avoid poor 	
    values of dz/dv at far offsets. However, a too small moff used	
    will the sensitivity of velocity error to the imaged depth.	
 3. Outfile contains three parts:					
    dlambda	correction of the velocity paramter. dlambda plus	
    		the initial parameter (used in migration) will	be	
		the updated one.					
    deviation	to measure how close imaged depths are to each other	
    		in CIGs. Old deviation corresponds to the initial	
		parameter; new deviation corresponds to the updated one.
    sensitivity  to predict how sensitive the error in the estimated	
		parameter is to an error in the measurement of imaged	
		depths.							

       error of parameter <= sensitivity * error of depth.		


 
 Author:  Zhenyue Liu, 12/29/93,  Colorado School of Mines

 Reference: 
 Liu, Z. 1995, "Migration Velocity Analysis", Ph.D. Thesis, Colorado
      School of Mines, CWP report #168.

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $velpert		= {
		_dzfile					=> '',
		_moff					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$velpert->{_Step}     = 'velpert'.$velpert->{_Step};
	return ( $velpert->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$velpert->{_note}     = 'velpert'.$velpert->{_note};
	return ( $velpert->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$velpert->{_dzfile}			= '';
		$velpert->{_moff}			= '';
		$velpert->{_Step}			= '';
		$velpert->{_note}			= '';
 }


=head2 sub dzfile 


=cut

 sub dzfile {

	my ( $self,$dzfile )		= @_;
	if ( $dzfile ne $empty_string ) {

		$velpert->{_dzfile}		= $dzfile;
		$velpert->{_note}		= $velpert->{_note}.' dzfile='.$velpert->{_dzfile};
		$velpert->{_Step}		= $velpert->{_Step}.' dzfile='.$velpert->{_dzfile};

	} else { 
		print("velpert, dzfile, missing dzfile,\n");
	 }
 }


=head2 sub moff 


=cut

 sub moff {

	my ( $self,$moff )		= @_;
	if ( $moff ne $empty_string ) {

		$velpert->{_moff}		= $moff;
		$velpert->{_note}		= $velpert->{_note}.' moff='.$velpert->{_moff};
		$velpert->{_Step}		= $velpert->{_Step}.' moff='.$velpert->{_moff};

	} else { 
		print("velpert, moff, missing moff,\n");
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