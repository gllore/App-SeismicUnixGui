 package normray;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  NORMRAY - dynamic ray tracing for normal incidence rays in a sloth model
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 NORMRAY - dynamic ray tracing for normal incidence rays in a sloth model

    normray <modelfile >rayends [optional parameters]			

 Optional Parameters:							
 caustic	 0: show all rays 1: show only caustic rays		
 nonsurface	 0: show rays which reach surface 1: show all rays      
 surface	 0: shot ray from subsurface 1: from surface               
 nrays 	 number of location to shoot rays                       
 dangle 	 increment of ray angle for one location                
 nangle 	 number of rays shot from one location                  
 ashift 	 shift first taking off angle                           
 xs1 	         x of shooting location                                 
 zs1 	         z of shooting location                                 
 nangle=101     number of takeoff angles				
 fangle=-45     first takeoff angle (in degrees)			
 rayfile        file of ray x,z coordinates of ray-edge intersections	
 nxz=101        number of (x,z) in optional rayfile (see notes below)	
 wavefile       file of ray x,z coordinates uniformly sampled in time	
 nt=101         number of (x,z) in optional wavefile (see notes below)	
 infofile       ASCII-file to store useful information 		
 fresnelfile    used if you want to plot the fresnel volumes. 		
                default is <fresnelfile.bin> 				
 outparfile     contains parameters for the plotting software. 	
                default is <outpar> 					
 krecord        if specified, only rays incident at interface with index
                krecord are displayed and stored			
 prim           =1, only single-reflected rays are plotted 		",     
                =0, only direct hits are displayed  			
 ffreq=-1       FresnelVolume frequency 				
 refseq=1,0,0   index of reflector followed by sequence of reflection (1)
                transmission(0) or ray stops(-1).			
                The default rayend is at the model boundary.		
                NOTE:refseq must be defined for each reflector		
 NOTES:								
 The rayends file contains ray parameters for the locations at which	
 the rays terminate.  							

 The rayfile is useful for making plots of ray paths.			
 nxz should be larger than twice the number of triangles intersected	
 by the rays.								

 The wavefile is useful for making plots of wavefronts.		
 The time sampling interval in the wavefile is tmax/(nt-1),		
 where tmax is the maximum time for all rays.				

 The infofile is useful for collecting information along the		
 individual rays. The fresnelfile contains data used to plot 		
 the Fresnel volumes. The outparfile stores information used 		
 for the plotting software.						



 AUTHOR:  Dave Hale, Colorado School of Mines, 02/16/91
 MODIFIED:  Andreas Rueger, Colorado School of Mines, 08/12/93
	Modifications include: functions writeFresnel, checkIfSourceIsOnEdge;
		options refseq=, krecord=, prim=, infofile=;
		computation of reflection/transmission losses, attenuation.
 MODIFIED: Boyi Ou, Colorado School of Mines, 4/14/95

 Notes:
 This code can shoot rays from specified interface by users, normally you
need to use gbmodel2 to generate interface parameters for this code, both
code have a parameter named nrays, it should be same. If you just want to
shoot rays from one specified location, you need to specify xs1,zs1,
otherwise, leave them alone. If you want to shoot rays from surface, you need
to define surface equal to 1. The rays from one location will be
approximately symetric with direction Normal_direction - ashift.(if nangle is
odd, it is symetric, even, almost symetric. The formula for the first take
off angle is: angle=normal_direction-nangle/2*dangle-ashift. If you only want to
see caustics, you specify caustic=1, if you want to see rays which does not
reach surface, you specify nonsurface=1. 
/
=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $normray		= {
		_angle					=> '',
		_caustic					=> '',
		_fangle					=> '',
		_ffreq					=> '',
		_nangle					=> '',
		_nonsurface					=> '',
		_nt					=> '',
		_nxz					=> '',
		_prim					=> '',
		_refseq					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$normray->{_Step}     = 'normray'.$normray->{_Step};
	return ( $normray->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$normray->{_note}     = 'normray'.$normray->{_note};
	return ( $normray->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$normray->{_angle}			= '';
		$normray->{_caustic}			= '';
		$normray->{_fangle}			= '';
		$normray->{_ffreq}			= '';
		$normray->{_nangle}			= '';
		$normray->{_nonsurface}			= '';
		$normray->{_nt}			= '';
		$normray->{_nxz}			= '';
		$normray->{_prim}			= '';
		$normray->{_refseq}			= '';
		$normray->{_Step}			= '';
		$normray->{_note}			= '';
 }


=head2 sub angle 


=cut

 sub angle {

	my ( $self,$angle )		= @_;
	if ( $angle ne $empty_string ) {

		$normray->{_angle}		= $angle;
		$normray->{_note}		= $normray->{_note}.' angle='.$normray->{_angle};
		$normray->{_Step}		= $normray->{_Step}.' angle='.$normray->{_angle};

	} else { 
		print("normray, angle, missing angle,\n");
	 }
 }


=head2 sub caustic 


=cut

 sub caustic {

	my ( $self,$caustic )		= @_;
	if ( $caustic ne $empty_string ) {

		$normray->{_caustic}		= $caustic;
		$normray->{_note}		= $normray->{_note}.' caustic='.$normray->{_caustic};
		$normray->{_Step}		= $normray->{_Step}.' caustic='.$normray->{_caustic};

	} else { 
		print("normray, caustic, missing caustic,\n");
	 }
 }


=head2 sub fangle 


=cut

 sub fangle {

	my ( $self,$fangle )		= @_;
	if ( $fangle ne $empty_string ) {

		$normray->{_fangle}		= $fangle;
		$normray->{_note}		= $normray->{_note}.' fangle='.$normray->{_fangle};
		$normray->{_Step}		= $normray->{_Step}.' fangle='.$normray->{_fangle};

	} else { 
		print("normray, fangle, missing fangle,\n");
	 }
 }


=head2 sub ffreq 


=cut

 sub ffreq {

	my ( $self,$ffreq )		= @_;
	if ( $ffreq ne $empty_string ) {

		$normray->{_ffreq}		= $ffreq;
		$normray->{_note}		= $normray->{_note}.' ffreq='.$normray->{_ffreq};
		$normray->{_Step}		= $normray->{_Step}.' ffreq='.$normray->{_ffreq};

	} else { 
		print("normray, ffreq, missing ffreq,\n");
	 }
 }


=head2 sub nangle 


=cut

 sub nangle {

	my ( $self,$nangle )		= @_;
	if ( $nangle ne $empty_string ) {

		$normray->{_nangle}		= $nangle;
		$normray->{_note}		= $normray->{_note}.' nangle='.$normray->{_nangle};
		$normray->{_Step}		= $normray->{_Step}.' nangle='.$normray->{_nangle};

	} else { 
		print("normray, nangle, missing nangle,\n");
	 }
 }


=head2 sub nonsurface 


=cut

 sub nonsurface {

	my ( $self,$nonsurface )		= @_;
	if ( $nonsurface ne $empty_string ) {

		$normray->{_nonsurface}		= $nonsurface;
		$normray->{_note}		= $normray->{_note}.' nonsurface='.$normray->{_nonsurface};
		$normray->{_Step}		= $normray->{_Step}.' nonsurface='.$normray->{_nonsurface};

	} else { 
		print("normray, nonsurface, missing nonsurface,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$normray->{_nt}		= $nt;
		$normray->{_note}		= $normray->{_note}.' nt='.$normray->{_nt};
		$normray->{_Step}		= $normray->{_Step}.' nt='.$normray->{_nt};

	} else { 
		print("normray, nt, missing nt,\n");
	 }
 }


=head2 sub nxz 


=cut

 sub nxz {

	my ( $self,$nxz )		= @_;
	if ( $nxz ne $empty_string ) {

		$normray->{_nxz}		= $nxz;
		$normray->{_note}		= $normray->{_note}.' nxz='.$normray->{_nxz};
		$normray->{_Step}		= $normray->{_Step}.' nxz='.$normray->{_nxz};

	} else { 
		print("normray, nxz, missing nxz,\n");
	 }
 }


=head2 sub prim 


=cut

 sub prim {

	my ( $self,$prim )		= @_;
	if ( $prim ne $empty_string ) {

		$normray->{_prim}		= $prim;
		$normray->{_note}		= $normray->{_note}.' prim='.$normray->{_prim};
		$normray->{_Step}		= $normray->{_Step}.' prim='.$normray->{_prim};

	} else { 
		print("normray, prim, missing prim,\n");
	 }
 }


=head2 sub refseq 


=cut

 sub refseq {

	my ( $self,$refseq )		= @_;
	if ( $refseq ne $empty_string ) {

		$normray->{_refseq}		= $refseq;
		$normray->{_note}		= $normray->{_note}.' refseq='.$normray->{_refseq};
		$normray->{_Step}		= $normray->{_Step}.' refseq='.$normray->{_refseq};

	} else { 
		print("normray, refseq, missing refseq,\n");
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