 package trimodel;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  TRIMODEL - make a triangulated sloth (1/velocity^2) model                  		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 TRIMODEL - make a triangulated sloth (1/velocity^2) model                  		

 trimodel >modelfile [optional parameters] 				

 Optional Parameters:							
 xmin=0.0               minimum horizontal coordinate (x)		
 xmax=1.0               maximum horizontal coordinate (x)		
 zmin=0.0               minimum vertical coordinate (z)		
 zmax=1.0               maximum vertical coordinate (z)		
 xedge=                 x coordinates of an edge			
 zedge=                 z coordinates of an edge			
 sedge=                 sloth along an edge				
 kedge=                 array of indices used to identify edges	
 normray               0:do not generate parameters 1: does it   	
 normface              specify which interface to shoot rays   	
 nrays                 number of locations to shoot rays      	        
 sfill=                 x, z, x0, z0, s00, dsdx, dsdz to fill a region	
 densfill=              x, z, dens to fill a region 			
 qfill=                 x, z, Q-factor to fill a region 		
 maxangle=5.0           maximum angle (deg) between adjacent edge segments

 Notes: 								
 More than set of xedge, zedge, and sedge parameters may be 		
 specified, but the numbers of these parameters must be equal. 	

 Within each set, vertices will be connected by fixed edges. 		

 Edge indices in the k array are used to identify edges 		
 specified by the x and z parameters.  The first k index 		
 corresponds to the first set of x and z parameters, the 		
 second k index corresponds to the second set, and so on. 		

 After all vertices and their corresponding sloth values have 		
 been inserted into the model, the optional sfill parameters 		
 are used to fill closed regions bounded by fixed edges. 		
 Let (x,z) denote any point inside a closed region.  Sloth inside 	
 this region is determined by s(x,z) = s00+(x-x0)*dsdx+(z-z0)*dsdz.  	
 The (x,z) component of the sfill parameter is used to identify a 	
 closed region. 							




 AUTHOR:  Dave Hale, Colorado School of Mines, 02/12/91
 MODIFIED: Andreas Rueger, Colorado School of Mines, 01/18/93
    Fill regions with attenuation Q-factors and density values.
 MODIFIED: Craig Artley, Colorado School of Mines, 03/27/94
    Corrected bug in computing s00 in makeSlothForTri() function.
 MODIFIED: Boyi Ou, Colorado School of Mines, 4/14/95
     Make code to generate interface parameters for shooting rays 
     from specified interface

 NOTE:
 When you use normface to specify interface, the number of interface might
 not be the number of interface in the picture, for example, you build a one
 interface model, this interface is very long, so in the shell, you use three
 part of xedge,zedge,sedge to make this interface, so when you use normface to
 specify interface, this interface is just part of whole interface. If you
 want see the normal rays from entire interface, you need to maek normal ray
 picture few times, and merge them together.
 

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $trimodel		= {
		_densfill					=> '',
		_kedge					=> '',
		_maxangle					=> '',
		_qfill					=> '',
		_sedge					=> '',
		_sfill					=> '',
		_xedge					=> '',
		_xmax					=> '',
		_xmin					=> '',
		_zedge					=> '',
		_zmax					=> '',
		_zmin					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$trimodel->{_Step}     = 'trimodel'.$trimodel->{_Step};
	return ( $trimodel->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$trimodel->{_note}     = 'trimodel'.$trimodel->{_note};
	return ( $trimodel->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$trimodel->{_densfill}			= '';
		$trimodel->{_kedge}			= '';
		$trimodel->{_maxangle}			= '';
		$trimodel->{_qfill}			= '';
		$trimodel->{_sedge}			= '';
		$trimodel->{_sfill}			= '';
		$trimodel->{_xedge}			= '';
		$trimodel->{_xmax}			= '';
		$trimodel->{_xmin}			= '';
		$trimodel->{_zedge}			= '';
		$trimodel->{_zmax}			= '';
		$trimodel->{_zmin}			= '';
		$trimodel->{_Step}			= '';
		$trimodel->{_note}			= '';
 }


=head2 sub densfill 


=cut

 sub densfill {

	my ( $self,$densfill )		= @_;
	if ( $densfill ne $empty_string ) {

		$trimodel->{_densfill}		= $densfill;
		$trimodel->{_note}		= $trimodel->{_note}.' densfill='.$trimodel->{_densfill};
		$trimodel->{_Step}		= $trimodel->{_Step}.' densfill='.$trimodel->{_densfill};

	} else { 
		print("trimodel, densfill, missing densfill,\n");
	 }
 }


=head2 sub kedge 


=cut

 sub kedge {

	my ( $self,$kedge )		= @_;
	if ( $kedge ne $empty_string ) {

		$trimodel->{_kedge}		= $kedge;
		$trimodel->{_note}		= $trimodel->{_note}.' kedge='.$trimodel->{_kedge};
		$trimodel->{_Step}		= $trimodel->{_Step}.' kedge='.$trimodel->{_kedge};

	} else { 
		print("trimodel, kedge, missing kedge,\n");
	 }
 }


=head2 sub maxangle 


=cut

 sub maxangle {

	my ( $self,$maxangle )		= @_;
	if ( $maxangle ne $empty_string ) {

		$trimodel->{_maxangle}		= $maxangle;
		$trimodel->{_note}		= $trimodel->{_note}.' maxangle='.$trimodel->{_maxangle};
		$trimodel->{_Step}		= $trimodel->{_Step}.' maxangle='.$trimodel->{_maxangle};

	} else { 
		print("trimodel, maxangle, missing maxangle,\n");
	 }
 }


=head2 sub qfill 


=cut

 sub qfill {

	my ( $self,$qfill )		= @_;
	if ( $qfill ne $empty_string ) {

		$trimodel->{_qfill}		= $qfill;
		$trimodel->{_note}		= $trimodel->{_note}.' qfill='.$trimodel->{_qfill};
		$trimodel->{_Step}		= $trimodel->{_Step}.' qfill='.$trimodel->{_qfill};

	} else { 
		print("trimodel, qfill, missing qfill,\n");
	 }
 }


=head2 sub sedge 


=cut

 sub sedge {

	my ( $self,$sedge )		= @_;
	if ( $sedge ne $empty_string ) {

		$trimodel->{_sedge}		= $sedge;
		$trimodel->{_note}		= $trimodel->{_note}.' sedge='.$trimodel->{_sedge};
		$trimodel->{_Step}		= $trimodel->{_Step}.' sedge='.$trimodel->{_sedge};

	} else { 
		print("trimodel, sedge, missing sedge,\n");
	 }
 }


=head2 sub sfill 


=cut

 sub sfill {

	my ( $self,$sfill )		= @_;
	if ( $sfill ne $empty_string ) {

		$trimodel->{_sfill}		= $sfill;
		$trimodel->{_note}		= $trimodel->{_note}.' sfill='.$trimodel->{_sfill};
		$trimodel->{_Step}		= $trimodel->{_Step}.' sfill='.$trimodel->{_sfill};

	} else { 
		print("trimodel, sfill, missing sfill,\n");
	 }
 }


=head2 sub xedge 


=cut

 sub xedge {

	my ( $self,$xedge )		= @_;
	if ( $xedge ne $empty_string ) {

		$trimodel->{_xedge}		= $xedge;
		$trimodel->{_note}		= $trimodel->{_note}.' xedge='.$trimodel->{_xedge};
		$trimodel->{_Step}		= $trimodel->{_Step}.' xedge='.$trimodel->{_xedge};

	} else { 
		print("trimodel, xedge, missing xedge,\n");
	 }
 }


=head2 sub xmax 


=cut

 sub xmax {

	my ( $self,$xmax )		= @_;
	if ( $xmax ne $empty_string ) {

		$trimodel->{_xmax}		= $xmax;
		$trimodel->{_note}		= $trimodel->{_note}.' xmax='.$trimodel->{_xmax};
		$trimodel->{_Step}		= $trimodel->{_Step}.' xmax='.$trimodel->{_xmax};

	} else { 
		print("trimodel, xmax, missing xmax,\n");
	 }
 }


=head2 sub xmin 


=cut

 sub xmin {

	my ( $self,$xmin )		= @_;
	if ( $xmin ne $empty_string ) {

		$trimodel->{_xmin}		= $xmin;
		$trimodel->{_note}		= $trimodel->{_note}.' xmin='.$trimodel->{_xmin};
		$trimodel->{_Step}		= $trimodel->{_Step}.' xmin='.$trimodel->{_xmin};

	} else { 
		print("trimodel, xmin, missing xmin,\n");
	 }
 }


=head2 sub zedge 


=cut

 sub zedge {

	my ( $self,$zedge )		= @_;
	if ( $zedge ne $empty_string ) {

		$trimodel->{_zedge}		= $zedge;
		$trimodel->{_note}		= $trimodel->{_note}.' zedge='.$trimodel->{_zedge};
		$trimodel->{_Step}		= $trimodel->{_Step}.' zedge='.$trimodel->{_zedge};

	} else { 
		print("trimodel, zedge, missing zedge,\n");
	 }
 }


=head2 sub zmax 


=cut

 sub zmax {

	my ( $self,$zmax )		= @_;
	if ( $zmax ne $empty_string ) {

		$trimodel->{_zmax}		= $zmax;
		$trimodel->{_note}		= $trimodel->{_note}.' zmax='.$trimodel->{_zmax};
		$trimodel->{_Step}		= $trimodel->{_Step}.' zmax='.$trimodel->{_zmax};

	} else { 
		print("trimodel, zmax, missing zmax,\n");
	 }
 }


=head2 sub zmin 


=cut

 sub zmin {

	my ( $self,$zmin )		= @_;
	if ( $zmin ne $empty_string ) {

		$trimodel->{_zmin}		= $zmin;
		$trimodel->{_note}		= $trimodel->{_note}.' zmin='.$trimodel->{_zmin};
		$trimodel->{_Step}		= $trimodel->{_Step}.' zmin='.$trimodel->{_zmin};

	} else { 
		print("trimodel, zmin, missing zmin,\n");
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