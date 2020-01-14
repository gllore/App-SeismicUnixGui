 package wkbj;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  WKBJ - Compute WKBJ ray theoretic parameters, via finite differencing	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 WKBJ - Compute WKBJ ray theoretic parameters, via finite differencing	

 wkbj <vfile >tfile nx= nz= xs= zs= [optional parameters]		

 Required Parameters:							
 <vfile	file containing velocities v[nx][nz]			
 nx=		number of x samples (2nd dimension)			
 nz=		number of z samples (1st dimension)			
 xs=		x coordinate of source					
 zs=		z coordinate of source					

 Optional Parameters:							
 dx=1.0		 x sampling interval				
 fx=0.0		 first x sample					
 dz=1.0		 z sampling interval				
 fz=0.0		 first z sample					
 sfile=sfile	file containing sigmas sg[nx][nz]			
 bfile=bfile	file containing incident angles bet[nx][nz]		
 afile=afile	file containing propagation angles a[nx][nz]		

 Notes:								
 Traveltimes, propagation angles, sigmas, and incident angles in WKBJ	
 by finite differences  in polar coordinates. Traveltimes are calculated
 by upwind scheme; sigmas and incident angles by a Crank-Nicolson scheme.

 Credits:
	CWP: Zhenyue Liu, Dave Hale, pre 1992. 

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $wkbj		= {
		_afile					=> '',
		_bfile					=> '',
		_dx					=> '',
		_dz					=> '',
		_fx					=> '',
		_fz					=> '',
		_nx					=> '',
		_nz					=> '',
		_sfile					=> '',
		_xs					=> '',
		_zs					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$wkbj->{_Step}     = 'wkbj'.$wkbj->{_Step};
	return ( $wkbj->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$wkbj->{_note}     = 'wkbj'.$wkbj->{_note};
	return ( $wkbj->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$wkbj->{_afile}			= '';
		$wkbj->{_bfile}			= '';
		$wkbj->{_dx}			= '';
		$wkbj->{_dz}			= '';
		$wkbj->{_fx}			= '';
		$wkbj->{_fz}			= '';
		$wkbj->{_nx}			= '';
		$wkbj->{_nz}			= '';
		$wkbj->{_sfile}			= '';
		$wkbj->{_xs}			= '';
		$wkbj->{_zs}			= '';
		$wkbj->{_Step}			= '';
		$wkbj->{_note}			= '';
 }


=head2 sub afile 


=cut

 sub afile {

	my ( $self,$afile )		= @_;
	if ( $afile ne $empty_string ) {

		$wkbj->{_afile}		= $afile;
		$wkbj->{_note}		= $wkbj->{_note}.' afile='.$wkbj->{_afile};
		$wkbj->{_Step}		= $wkbj->{_Step}.' afile='.$wkbj->{_afile};

	} else { 
		print("wkbj, afile, missing afile,\n");
	 }
 }


=head2 sub bfile 


=cut

 sub bfile {

	my ( $self,$bfile )		= @_;
	if ( $bfile ne $empty_string ) {

		$wkbj->{_bfile}		= $bfile;
		$wkbj->{_note}		= $wkbj->{_note}.' bfile='.$wkbj->{_bfile};
		$wkbj->{_Step}		= $wkbj->{_Step}.' bfile='.$wkbj->{_bfile};

	} else { 
		print("wkbj, bfile, missing bfile,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$wkbj->{_dx}		= $dx;
		$wkbj->{_note}		= $wkbj->{_note}.' dx='.$wkbj->{_dx};
		$wkbj->{_Step}		= $wkbj->{_Step}.' dx='.$wkbj->{_dx};

	} else { 
		print("wkbj, dx, missing dx,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$wkbj->{_dz}		= $dz;
		$wkbj->{_note}		= $wkbj->{_note}.' dz='.$wkbj->{_dz};
		$wkbj->{_Step}		= $wkbj->{_Step}.' dz='.$wkbj->{_dz};

	} else { 
		print("wkbj, dz, missing dz,\n");
	 }
 }


=head2 sub fx 


=cut

 sub fx {

	my ( $self,$fx )		= @_;
	if ( $fx ne $empty_string ) {

		$wkbj->{_fx}		= $fx;
		$wkbj->{_note}		= $wkbj->{_note}.' fx='.$wkbj->{_fx};
		$wkbj->{_Step}		= $wkbj->{_Step}.' fx='.$wkbj->{_fx};

	} else { 
		print("wkbj, fx, missing fx,\n");
	 }
 }


=head2 sub fz 


=cut

 sub fz {

	my ( $self,$fz )		= @_;
	if ( $fz ne $empty_string ) {

		$wkbj->{_fz}		= $fz;
		$wkbj->{_note}		= $wkbj->{_note}.' fz='.$wkbj->{_fz};
		$wkbj->{_Step}		= $wkbj->{_Step}.' fz='.$wkbj->{_fz};

	} else { 
		print("wkbj, fz, missing fz,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$wkbj->{_nx}		= $nx;
		$wkbj->{_note}		= $wkbj->{_note}.' nx='.$wkbj->{_nx};
		$wkbj->{_Step}		= $wkbj->{_Step}.' nx='.$wkbj->{_nx};

	} else { 
		print("wkbj, nx, missing nx,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$wkbj->{_nz}		= $nz;
		$wkbj->{_note}		= $wkbj->{_note}.' nz='.$wkbj->{_nz};
		$wkbj->{_Step}		= $wkbj->{_Step}.' nz='.$wkbj->{_nz};

	} else { 
		print("wkbj, nz, missing nz,\n");
	 }
 }


=head2 sub sfile 


=cut

 sub sfile {

	my ( $self,$sfile )		= @_;
	if ( $sfile ne $empty_string ) {

		$wkbj->{_sfile}		= $sfile;
		$wkbj->{_note}		= $wkbj->{_note}.' sfile='.$wkbj->{_sfile};
		$wkbj->{_Step}		= $wkbj->{_Step}.' sfile='.$wkbj->{_sfile};

	} else { 
		print("wkbj, sfile, missing sfile,\n");
	 }
 }


=head2 sub xs 


=cut

 sub xs {

	my ( $self,$xs )		= @_;
	if ( $xs ne $empty_string ) {

		$wkbj->{_xs}		= $xs;
		$wkbj->{_note}		= $wkbj->{_note}.' xs='.$wkbj->{_xs};
		$wkbj->{_Step}		= $wkbj->{_Step}.' xs='.$wkbj->{_xs};

	} else { 
		print("wkbj, xs, missing xs,\n");
	 }
 }


=head2 sub zs 


=cut

 sub zs {

	my ( $self,$zs )		= @_;
	if ( $zs ne $empty_string ) {

		$wkbj->{_zs}		= $zs;
		$wkbj->{_note}		= $wkbj->{_note}.' zs='.$wkbj->{_zs};
		$wkbj->{_Step}		= $wkbj->{_Step}.' zs='.$wkbj->{_zs};

	} else { 
		print("wkbj, zs, missing zs,\n");
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