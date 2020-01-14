 package stiff2vel;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  STIFF2VEL - Transforms 2D elastic stiffnesses to (vp,vs,epsilon,delta) 
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 STIFF2VEL - Transforms 2D elastic stiffnesses to (vp,vs,epsilon,delta) 

 stiff2vel  nx=  nz=  [optional parameters]				

 Required parameters:							
 nx=		 	 number of x samples (2nd dimension)		
 nz=		 	 number of z samples (1st dimension)		
 rho_file='rho.bin'     input file containing rho(x,z)			
 c11_file='c11.bin'     input file containing c11(x,z)			
 c13_file='c13.bin'     input file containing c13(x,z)			
 c33_file='c33.bin'     input file containing c33(x,z)			
 c44_file='c44.bin'     input file containing c44(x,z)			

 Optional Parameters:							
 vp_file='vp.bin'	 output file containing P-wave velocities	
 vs_file='vs.bin'	 output file containing S-wave velocities	
 rho_file='rho.bin'	 output file containing densities		
 eps_file='eps.bin'	 output file containing Thomsen epsilon	       	
 delta_file='delta.bin' output file containing Thomsen delta	       	

 Notes: 								
 1. All quantities in MKS units					
 2. Isotropy implied by c11(x,z)=c33(x,z)=0 			
 3. Vertical symmetry axis is assumed.					



  Coded:
  Aramco: Chris Liner 9/25/2005 
          (based on vel2stiff.c)

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $stiff2vel		= {
		_c11_file					=> '',
		_c13_file					=> '',
		_c33_file					=> '',
		_c44_file					=> '',
		_delta_file					=> '',
		_eps_file					=> '',
		_nx					=> '',
		_nz					=> '',
		_rho_file					=> '',
		_vp_file					=> '',
		_vs_file					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$stiff2vel->{_Step}     = 'stiff2vel'.$stiff2vel->{_Step};
	return ( $stiff2vel->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$stiff2vel->{_note}     = 'stiff2vel'.$stiff2vel->{_note};
	return ( $stiff2vel->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$stiff2vel->{_c11_file}			= '';
		$stiff2vel->{_c13_file}			= '';
		$stiff2vel->{_c33_file}			= '';
		$stiff2vel->{_c44_file}			= '';
		$stiff2vel->{_delta_file}			= '';
		$stiff2vel->{_eps_file}			= '';
		$stiff2vel->{_nx}			= '';
		$stiff2vel->{_nz}			= '';
		$stiff2vel->{_rho_file}			= '';
		$stiff2vel->{_vp_file}			= '';
		$stiff2vel->{_vs_file}			= '';
		$stiff2vel->{_Step}			= '';
		$stiff2vel->{_note}			= '';
 }


=head2 sub c11_file 


=cut

 sub c11_file {

	my ( $self,$c11_file )		= @_;
	if ( $c11_file ne $empty_string ) {

		$stiff2vel->{_c11_file}		= $c11_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' c11_file='.$stiff2vel->{_c11_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' c11_file='.$stiff2vel->{_c11_file};

	} else { 
		print("stiff2vel, c11_file, missing c11_file,\n");
	 }
 }


=head2 sub c13_file 


=cut

 sub c13_file {

	my ( $self,$c13_file )		= @_;
	if ( $c13_file ne $empty_string ) {

		$stiff2vel->{_c13_file}		= $c13_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' c13_file='.$stiff2vel->{_c13_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' c13_file='.$stiff2vel->{_c13_file};

	} else { 
		print("stiff2vel, c13_file, missing c13_file,\n");
	 }
 }


=head2 sub c33_file 


=cut

 sub c33_file {

	my ( $self,$c33_file )		= @_;
	if ( $c33_file ne $empty_string ) {

		$stiff2vel->{_c33_file}		= $c33_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' c33_file='.$stiff2vel->{_c33_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' c33_file='.$stiff2vel->{_c33_file};

	} else { 
		print("stiff2vel, c33_file, missing c33_file,\n");
	 }
 }


=head2 sub c44_file 


=cut

 sub c44_file {

	my ( $self,$c44_file )		= @_;
	if ( $c44_file ne $empty_string ) {

		$stiff2vel->{_c44_file}		= $c44_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' c44_file='.$stiff2vel->{_c44_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' c44_file='.$stiff2vel->{_c44_file};

	} else { 
		print("stiff2vel, c44_file, missing c44_file,\n");
	 }
 }


=head2 sub delta_file 


=cut

 sub delta_file {

	my ( $self,$delta_file )		= @_;
	if ( $delta_file ne $empty_string ) {

		$stiff2vel->{_delta_file}		= $delta_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' delta_file='.$stiff2vel->{_delta_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' delta_file='.$stiff2vel->{_delta_file};

	} else { 
		print("stiff2vel, delta_file, missing delta_file,\n");
	 }
 }


=head2 sub eps_file 


=cut

 sub eps_file {

	my ( $self,$eps_file )		= @_;
	if ( $eps_file ne $empty_string ) {

		$stiff2vel->{_eps_file}		= $eps_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' eps_file='.$stiff2vel->{_eps_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' eps_file='.$stiff2vel->{_eps_file};

	} else { 
		print("stiff2vel, eps_file, missing eps_file,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$stiff2vel->{_nx}		= $nx;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' nx='.$stiff2vel->{_nx};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' nx='.$stiff2vel->{_nx};

	} else { 
		print("stiff2vel, nx, missing nx,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$stiff2vel->{_nz}		= $nz;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' nz='.$stiff2vel->{_nz};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' nz='.$stiff2vel->{_nz};

	} else { 
		print("stiff2vel, nz, missing nz,\n");
	 }
 }


=head2 sub rho_file 


=cut

 sub rho_file {

	my ( $self,$rho_file )		= @_;
	if ( $rho_file ne $empty_string ) {

		$stiff2vel->{_rho_file}		= $rho_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' rho_file='.$stiff2vel->{_rho_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' rho_file='.$stiff2vel->{_rho_file};

	} else { 
		print("stiff2vel, rho_file, missing rho_file,\n");
	 }
 }


=head2 sub vp_file 


=cut

 sub vp_file {

	my ( $self,$vp_file )		= @_;
	if ( $vp_file ne $empty_string ) {

		$stiff2vel->{_vp_file}		= $vp_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' vp_file='.$stiff2vel->{_vp_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' vp_file='.$stiff2vel->{_vp_file};

	} else { 
		print("stiff2vel, vp_file, missing vp_file,\n");
	 }
 }


=head2 sub vs_file 


=cut

 sub vs_file {

	my ( $self,$vs_file )		= @_;
	if ( $vs_file ne $empty_string ) {

		$stiff2vel->{_vs_file}		= $vs_file;
		$stiff2vel->{_note}		= $stiff2vel->{_note}.' vs_file='.$stiff2vel->{_vs_file};
		$stiff2vel->{_Step}		= $stiff2vel->{_Step}.' vs_file='.$stiff2vel->{_vs_file};

	} else { 
		print("stiff2vel, vs_file, missing vs_file,\n");
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