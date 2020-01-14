 package velconv;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  VELCONV - VELocity CONVersion					
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 VELCONV - VELocity CONVersion					

 velconv <infile >outfile intype= outtype= [optional parameters]

 Required Parameters:						
 intype=                input data type (see valid types below)
 outtype=               output data type (see valid types below)

 Valid types for input and output data are:			
 vintt          interval velocity as a function of time	
 vrmst          RMS velocity as a function of time		
 vintz          velocity as a function of depth		
 zt             depth as a function of time			
 tz             time as a function of depth			

 Optional Parameters:						
 nt=all                 number of time samples			
 dt=1.0                 time sampling interval			
 ft=0.0                 first time				
 nz=all                 number of depth samples		
 dz=1.0                 depth sampling interval		
 fz=0.0                 first depth				
 nx=all                 number of traces			

 Example:  "intype=vintz outtype=vrmst" converts an interval velocity
           function of depth to an RMS velocity function of time.

 Notes:  nt, dt, and ft are used only for input and output functions
         of time; you need specify these only for vintt, vrmst, orzt.
         Likewise, nz, dz, and fz are used only for input and output
         functions of depth.					

 The input and output data formats are C-style binary floats.	


  AUTHOR:  Dave Hale, Colorado School of Mines, 07/07/89

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $velconv		= {
		_dt					=> '',
		_dz					=> '',
		_ft					=> '',
		_fz					=> '',
		_intype					=> '',
		_nt					=> '',
		_nx					=> '',
		_nz					=> '',
		_outtype					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$velconv->{_Step}     = 'velconv'.$velconv->{_Step};
	return ( $velconv->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$velconv->{_note}     = 'velconv'.$velconv->{_note};
	return ( $velconv->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$velconv->{_dt}			= '';
		$velconv->{_dz}			= '';
		$velconv->{_ft}			= '';
		$velconv->{_fz}			= '';
		$velconv->{_intype}			= '';
		$velconv->{_nt}			= '';
		$velconv->{_nx}			= '';
		$velconv->{_nz}			= '';
		$velconv->{_outtype}			= '';
		$velconv->{_Step}			= '';
		$velconv->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$velconv->{_dt}		= $dt;
		$velconv->{_note}		= $velconv->{_note}.' dt='.$velconv->{_dt};
		$velconv->{_Step}		= $velconv->{_Step}.' dt='.$velconv->{_dt};

	} else { 
		print("velconv, dt, missing dt,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$velconv->{_dz}		= $dz;
		$velconv->{_note}		= $velconv->{_note}.' dz='.$velconv->{_dz};
		$velconv->{_Step}		= $velconv->{_Step}.' dz='.$velconv->{_dz};

	} else { 
		print("velconv, dz, missing dz,\n");
	 }
 }


=head2 sub ft 


=cut

 sub ft {

	my ( $self,$ft )		= @_;
	if ( $ft ne $empty_string ) {

		$velconv->{_ft}		= $ft;
		$velconv->{_note}		= $velconv->{_note}.' ft='.$velconv->{_ft};
		$velconv->{_Step}		= $velconv->{_Step}.' ft='.$velconv->{_ft};

	} else { 
		print("velconv, ft, missing ft,\n");
	 }
 }


=head2 sub fz 


=cut

 sub fz {

	my ( $self,$fz )		= @_;
	if ( $fz ne $empty_string ) {

		$velconv->{_fz}		= $fz;
		$velconv->{_note}		= $velconv->{_note}.' fz='.$velconv->{_fz};
		$velconv->{_Step}		= $velconv->{_Step}.' fz='.$velconv->{_fz};

	} else { 
		print("velconv, fz, missing fz,\n");
	 }
 }


=head2 sub intype 


=cut

 sub intype {

	my ( $self,$intype )		= @_;
	if ( $intype ne $empty_string ) {

		$velconv->{_intype}		= $intype;
		$velconv->{_note}		= $velconv->{_note}.' intype='.$velconv->{_intype};
		$velconv->{_Step}		= $velconv->{_Step}.' intype='.$velconv->{_intype};

	} else { 
		print("velconv, intype, missing intype,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$velconv->{_nt}		= $nt;
		$velconv->{_note}		= $velconv->{_note}.' nt='.$velconv->{_nt};
		$velconv->{_Step}		= $velconv->{_Step}.' nt='.$velconv->{_nt};

	} else { 
		print("velconv, nt, missing nt,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$velconv->{_nx}		= $nx;
		$velconv->{_note}		= $velconv->{_note}.' nx='.$velconv->{_nx};
		$velconv->{_Step}		= $velconv->{_Step}.' nx='.$velconv->{_nx};

	} else { 
		print("velconv, nx, missing nx,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$velconv->{_nz}		= $nz;
		$velconv->{_note}		= $velconv->{_note}.' nz='.$velconv->{_nz};
		$velconv->{_Step}		= $velconv->{_Step}.' nz='.$velconv->{_nz};

	} else { 
		print("velconv, nz, missing nz,\n");
	 }
 }


=head2 sub outtype 


=cut

 sub outtype {

	my ( $self,$outtype )		= @_;
	if ( $outtype ne $empty_string ) {

		$velconv->{_outtype}		= $outtype;
		$velconv->{_note}		= $velconv->{_note}.' outtype='.$velconv->{_outtype};
		$velconv->{_Step}		= $velconv->{_Step}.' outtype='.$velconv->{_outtype};

	} else { 
		print("velconv, outtype, missing outtype,\n");
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