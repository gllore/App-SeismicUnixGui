 package velpertan;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  VELPERTAN - Velocity PERTerbation analysis in ANisotropic media to    
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 VELPERTAN - Velocity PERTerbation analysis in ANisotropic media to    
             determine the model update required to flatten image gathers",  

 velpertan boundary= par=cig.par refl1= refl2= npicks1= 		
	npicks2= cdp1= cdp2= vfile= efile= dfile= nx= dx= fx= 		
	ncdp= dcdp= fcdp= off0= noff= doff= >outfile [parameters]	

 Required Parameters:							
 refl1=	file with picks on the 1st reflector	  		
 refl2=	file with picks on the 2nd reflector  			
 vfile=	file defining VP0 at all grid points from prev. iter.	", 
 efile=	file defining eps at all grid points from prev. iter.	", 
 dfile=	file defining del at all grid points from prev. iter.	", 
 boundary=	file defining the boundary above which 			
        	parameters are known; update is done below this		", 
		boundary						", 
 npicks1=	number of picks on the 1st reflector			
 npicks2=	number of picks on the 2nd reflector			
 ncdp=		number of cdp's		 				
 dcdp=		cdp spacing			 			
 fcdp=		first cdp			 			
 off0=		first offset in common image gathers 			
 noff=		number of offsets in common image gathers  		
 doff=		offset increment in common image gathers  		
 cip1=x1,r1,r2,..., cip=xn,r1n,r2n         description of input CIGS	
 cip2=x2,r1,r2,..., cip=xn,r1n,r2n         description of input CIGS	
	x	x-value of a common image point				
	r1	hyperbolic component of the residual moveout		
	r2	non-hyperbolic component of residual moveout		
 Optional Parameters:							
 method=akima         for linear interpolation of the interface       
                       =mono for monotonic cubic interpolation of interface
                       =akima for Akima's cubic interpolation of interface 
                       =spline for cubic spline interpolation of interface 
 VP0=2000	Starting value for vertical velocity at a point in the   
							target layer	
 x00=0.0	x-coordinate at which VP0 is defined			
 z00=0.0	z-coordinate at which VP0 is defined			
 eps=0.0	Starting value for Thomsen's parameter epsilon		
 del=0.0	Starting value for Thomsen's parameter delta		
 kz=0.0	Starting value for the vertical gradient in VP0		
 kx=0.0	Starting value for the lateral gradient in VP0		
 nx=100	number of nodes in the horizontal direction for the     
							velocity grid 	
 nz=100	number of nodes in the vertical direction for the	
							velocity grid	
 dx=10	horizontal grid increment				
 dz=10	vertical grid increment					
 fx=0		first horizontal grid point				
 fz=0		first vertical grid point				
 dt=0.008	traveltime increment					
 nt=500	no. of points on the ray				
 amax=360	max. angle of emergence					
 amin=0	min. angle of emergence					

 Smoothing parameters:							
 r1=0                  smoothing parameter in the 1 direction          
 r2=0                  smoothing parameter in the 2 direction          
 win=0,n1,0,n2         array for window range                          
 rw=0                  smoothing parameter for window function         
 nbound=2	number of points picked on the boundary			
 tol=0.1	tolerance in computing the offset (m)			
 Notes:								
 This program is used as part of the velocity analysis technique developed
 by Debashish Sarkar, CWP:2003.					

 Notes:								
 The output par file contains the coefficients describing the residual 
 moveout. This program is used in conjunction with surelanan.		


 Author: CSM: Debashish Sarkar, December 2003 
 based on program: velpert.c written by Zhenuye Liu.


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $velpertan		= {
		_VP0					=> '',
		_amax					=> '',
		_amin					=> '',
		_boundary					=> '',
		_cip1					=> '',
		_cip2					=> '',
		_dcdp					=> '',
		_del					=> '',
		_dfile					=> '',
		_doff					=> '',
		_dt					=> '',
		_dx					=> '',
		_dz					=> '',
		_efile					=> '',
		_eps					=> '',
		_fcdp					=> '',
		_fx					=> '',
		_fz					=> '',
		_kx					=> '',
		_kz					=> '',
		_method					=> '',
		_nbound					=> '',
		_ncdp					=> '',
		_noff					=> '',
		_npicks1					=> '',
		_npicks2					=> '',
		_nt					=> '',
		_nx					=> '',
		_nz					=> '',
		_off0					=> '',
		_r1					=> '',
		_r2					=> '',
		_refl1					=> '',
		_refl2					=> '',
		_rw					=> '',
		_tol					=> '',
		_vfile					=> '',
		_win					=> '',
		_x00					=> '',
		_z00					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$velpertan->{_Step}     = 'velpertan'.$velpertan->{_Step};
	return ( $velpertan->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$velpertan->{_note}     = 'velpertan'.$velpertan->{_note};
	return ( $velpertan->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$velpertan->{_VP0}			= '';
		$velpertan->{_amax}			= '';
		$velpertan->{_amin}			= '';
		$velpertan->{_boundary}			= '';
		$velpertan->{_cip1}			= '';
		$velpertan->{_cip2}			= '';
		$velpertan->{_dcdp}			= '';
		$velpertan->{_del}			= '';
		$velpertan->{_dfile}			= '';
		$velpertan->{_doff}			= '';
		$velpertan->{_dt}			= '';
		$velpertan->{_dx}			= '';
		$velpertan->{_dz}			= '';
		$velpertan->{_efile}			= '';
		$velpertan->{_eps}			= '';
		$velpertan->{_fcdp}			= '';
		$velpertan->{_fx}			= '';
		$velpertan->{_fz}			= '';
		$velpertan->{_kx}			= '';
		$velpertan->{_kz}			= '';
		$velpertan->{_method}			= '';
		$velpertan->{_nbound}			= '';
		$velpertan->{_ncdp}			= '';
		$velpertan->{_noff}			= '';
		$velpertan->{_npicks1}			= '';
		$velpertan->{_npicks2}			= '';
		$velpertan->{_nt}			= '';
		$velpertan->{_nx}			= '';
		$velpertan->{_nz}			= '';
		$velpertan->{_off0}			= '';
		$velpertan->{_r1}			= '';
		$velpertan->{_r2}			= '';
		$velpertan->{_refl1}			= '';
		$velpertan->{_refl2}			= '';
		$velpertan->{_rw}			= '';
		$velpertan->{_tol}			= '';
		$velpertan->{_vfile}			= '';
		$velpertan->{_win}			= '';
		$velpertan->{_x00}			= '';
		$velpertan->{_z00}			= '';
		$velpertan->{_Step}			= '';
		$velpertan->{_note}			= '';
 }


=head2 sub VP0 


=cut

 sub VP0 {

	my ( $self,$VP0 )		= @_;
	if ( $VP0 ne $empty_string ) {

		$velpertan->{_VP0}		= $VP0;
		$velpertan->{_note}		= $velpertan->{_note}.' VP0='.$velpertan->{_VP0};
		$velpertan->{_Step}		= $velpertan->{_Step}.' VP0='.$velpertan->{_VP0};

	} else { 
		print("velpertan, VP0, missing VP0,\n");
	 }
 }


=head2 sub amax 


=cut

 sub amax {

	my ( $self,$amax )		= @_;
	if ( $amax ne $empty_string ) {

		$velpertan->{_amax}		= $amax;
		$velpertan->{_note}		= $velpertan->{_note}.' amax='.$velpertan->{_amax};
		$velpertan->{_Step}		= $velpertan->{_Step}.' amax='.$velpertan->{_amax};

	} else { 
		print("velpertan, amax, missing amax,\n");
	 }
 }


=head2 sub amin 


=cut

 sub amin {

	my ( $self,$amin )		= @_;
	if ( $amin ne $empty_string ) {

		$velpertan->{_amin}		= $amin;
		$velpertan->{_note}		= $velpertan->{_note}.' amin='.$velpertan->{_amin};
		$velpertan->{_Step}		= $velpertan->{_Step}.' amin='.$velpertan->{_amin};

	} else { 
		print("velpertan, amin, missing amin,\n");
	 }
 }


=head2 sub boundary 


=cut

 sub boundary {

	my ( $self,$boundary )		= @_;
	if ( $boundary ne $empty_string ) {

		$velpertan->{_boundary}		= $boundary;
		$velpertan->{_note}		= $velpertan->{_note}.' boundary='.$velpertan->{_boundary};
		$velpertan->{_Step}		= $velpertan->{_Step}.' boundary='.$velpertan->{_boundary};

	} else { 
		print("velpertan, boundary, missing boundary,\n");
	 }
 }


=head2 sub cip1 


=cut

 sub cip1 {

	my ( $self,$cip1 )		= @_;
	if ( $cip1 ne $empty_string ) {

		$velpertan->{_cip1}		= $cip1;
		$velpertan->{_note}		= $velpertan->{_note}.' cip1='.$velpertan->{_cip1};
		$velpertan->{_Step}		= $velpertan->{_Step}.' cip1='.$velpertan->{_cip1};

	} else { 
		print("velpertan, cip1, missing cip1,\n");
	 }
 }


=head2 sub cip2 


=cut

 sub cip2 {

	my ( $self,$cip2 )		= @_;
	if ( $cip2 ne $empty_string ) {

		$velpertan->{_cip2}		= $cip2;
		$velpertan->{_note}		= $velpertan->{_note}.' cip2='.$velpertan->{_cip2};
		$velpertan->{_Step}		= $velpertan->{_Step}.' cip2='.$velpertan->{_cip2};

	} else { 
		print("velpertan, cip2, missing cip2,\n");
	 }
 }


=head2 sub dcdp 


=cut

 sub dcdp {

	my ( $self,$dcdp )		= @_;
	if ( $dcdp ne $empty_string ) {

		$velpertan->{_dcdp}		= $dcdp;
		$velpertan->{_note}		= $velpertan->{_note}.' dcdp='.$velpertan->{_dcdp};
		$velpertan->{_Step}		= $velpertan->{_Step}.' dcdp='.$velpertan->{_dcdp};

	} else { 
		print("velpertan, dcdp, missing dcdp,\n");
	 }
 }


=head2 sub del 


=cut

 sub del {

	my ( $self,$del )		= @_;
	if ( $del ne $empty_string ) {

		$velpertan->{_del}		= $del;
		$velpertan->{_note}		= $velpertan->{_note}.' del='.$velpertan->{_del};
		$velpertan->{_Step}		= $velpertan->{_Step}.' del='.$velpertan->{_del};

	} else { 
		print("velpertan, del, missing del,\n");
	 }
 }


=head2 sub dfile 


=cut

 sub dfile {

	my ( $self,$dfile )		= @_;
	if ( $dfile ne $empty_string ) {

		$velpertan->{_dfile}		= $dfile;
		$velpertan->{_note}		= $velpertan->{_note}.' dfile='.$velpertan->{_dfile};
		$velpertan->{_Step}		= $velpertan->{_Step}.' dfile='.$velpertan->{_dfile};

	} else { 
		print("velpertan, dfile, missing dfile,\n");
	 }
 }


=head2 sub doff 


=cut

 sub doff {

	my ( $self,$doff )		= @_;
	if ( $doff ne $empty_string ) {

		$velpertan->{_doff}		= $doff;
		$velpertan->{_note}		= $velpertan->{_note}.' doff='.$velpertan->{_doff};
		$velpertan->{_Step}		= $velpertan->{_Step}.' doff='.$velpertan->{_doff};

	} else { 
		print("velpertan, doff, missing doff,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$velpertan->{_dt}		= $dt;
		$velpertan->{_note}		= $velpertan->{_note}.' dt='.$velpertan->{_dt};
		$velpertan->{_Step}		= $velpertan->{_Step}.' dt='.$velpertan->{_dt};

	} else { 
		print("velpertan, dt, missing dt,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$velpertan->{_dx}		= $dx;
		$velpertan->{_note}		= $velpertan->{_note}.' dx='.$velpertan->{_dx};
		$velpertan->{_Step}		= $velpertan->{_Step}.' dx='.$velpertan->{_dx};

	} else { 
		print("velpertan, dx, missing dx,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$velpertan->{_dz}		= $dz;
		$velpertan->{_note}		= $velpertan->{_note}.' dz='.$velpertan->{_dz};
		$velpertan->{_Step}		= $velpertan->{_Step}.' dz='.$velpertan->{_dz};

	} else { 
		print("velpertan, dz, missing dz,\n");
	 }
 }


=head2 sub efile 


=cut

 sub efile {

	my ( $self,$efile )		= @_;
	if ( $efile ne $empty_string ) {

		$velpertan->{_efile}		= $efile;
		$velpertan->{_note}		= $velpertan->{_note}.' efile='.$velpertan->{_efile};
		$velpertan->{_Step}		= $velpertan->{_Step}.' efile='.$velpertan->{_efile};

	} else { 
		print("velpertan, efile, missing efile,\n");
	 }
 }


=head2 sub eps 


=cut

 sub eps {

	my ( $self,$eps )		= @_;
	if ( $eps ne $empty_string ) {

		$velpertan->{_eps}		= $eps;
		$velpertan->{_note}		= $velpertan->{_note}.' eps='.$velpertan->{_eps};
		$velpertan->{_Step}		= $velpertan->{_Step}.' eps='.$velpertan->{_eps};

	} else { 
		print("velpertan, eps, missing eps,\n");
	 }
 }


=head2 sub fcdp 


=cut

 sub fcdp {

	my ( $self,$fcdp )		= @_;
	if ( $fcdp ne $empty_string ) {

		$velpertan->{_fcdp}		= $fcdp;
		$velpertan->{_note}		= $velpertan->{_note}.' fcdp='.$velpertan->{_fcdp};
		$velpertan->{_Step}		= $velpertan->{_Step}.' fcdp='.$velpertan->{_fcdp};

	} else { 
		print("velpertan, fcdp, missing fcdp,\n");
	 }
 }


=head2 sub fx 


=cut

 sub fx {

	my ( $self,$fx )		= @_;
	if ( $fx ne $empty_string ) {

		$velpertan->{_fx}		= $fx;
		$velpertan->{_note}		= $velpertan->{_note}.' fx='.$velpertan->{_fx};
		$velpertan->{_Step}		= $velpertan->{_Step}.' fx='.$velpertan->{_fx};

	} else { 
		print("velpertan, fx, missing fx,\n");
	 }
 }


=head2 sub fz 


=cut

 sub fz {

	my ( $self,$fz )		= @_;
	if ( $fz ne $empty_string ) {

		$velpertan->{_fz}		= $fz;
		$velpertan->{_note}		= $velpertan->{_note}.' fz='.$velpertan->{_fz};
		$velpertan->{_Step}		= $velpertan->{_Step}.' fz='.$velpertan->{_fz};

	} else { 
		print("velpertan, fz, missing fz,\n");
	 }
 }


=head2 sub kx 


=cut

 sub kx {

	my ( $self,$kx )		= @_;
	if ( $kx ne $empty_string ) {

		$velpertan->{_kx}		= $kx;
		$velpertan->{_note}		= $velpertan->{_note}.' kx='.$velpertan->{_kx};
		$velpertan->{_Step}		= $velpertan->{_Step}.' kx='.$velpertan->{_kx};

	} else { 
		print("velpertan, kx, missing kx,\n");
	 }
 }


=head2 sub kz 


=cut

 sub kz {

	my ( $self,$kz )		= @_;
	if ( $kz ne $empty_string ) {

		$velpertan->{_kz}		= $kz;
		$velpertan->{_note}		= $velpertan->{_note}.' kz='.$velpertan->{_kz};
		$velpertan->{_Step}		= $velpertan->{_Step}.' kz='.$velpertan->{_kz};

	} else { 
		print("velpertan, kz, missing kz,\n");
	 }
 }


=head2 sub method 


=cut

 sub method {

	my ( $self,$method )		= @_;
	if ( $method ne $empty_string ) {

		$velpertan->{_method}		= $method;
		$velpertan->{_note}		= $velpertan->{_note}.' method='.$velpertan->{_method};
		$velpertan->{_Step}		= $velpertan->{_Step}.' method='.$velpertan->{_method};

	} else { 
		print("velpertan, method, missing method,\n");
	 }
 }


=head2 sub nbound 


=cut

 sub nbound {

	my ( $self,$nbound )		= @_;
	if ( $nbound ne $empty_string ) {

		$velpertan->{_nbound}		= $nbound;
		$velpertan->{_note}		= $velpertan->{_note}.' nbound='.$velpertan->{_nbound};
		$velpertan->{_Step}		= $velpertan->{_Step}.' nbound='.$velpertan->{_nbound};

	} else { 
		print("velpertan, nbound, missing nbound,\n");
	 }
 }


=head2 sub ncdp 


=cut

 sub ncdp {

	my ( $self,$ncdp )		= @_;
	if ( $ncdp ne $empty_string ) {

		$velpertan->{_ncdp}		= $ncdp;
		$velpertan->{_note}		= $velpertan->{_note}.' ncdp='.$velpertan->{_ncdp};
		$velpertan->{_Step}		= $velpertan->{_Step}.' ncdp='.$velpertan->{_ncdp};

	} else { 
		print("velpertan, ncdp, missing ncdp,\n");
	 }
 }


=head2 sub noff 


=cut

 sub noff {

	my ( $self,$noff )		= @_;
	if ( $noff ne $empty_string ) {

		$velpertan->{_noff}		= $noff;
		$velpertan->{_note}		= $velpertan->{_note}.' noff='.$velpertan->{_noff};
		$velpertan->{_Step}		= $velpertan->{_Step}.' noff='.$velpertan->{_noff};

	} else { 
		print("velpertan, noff, missing noff,\n");
	 }
 }


=head2 sub npicks1 


=cut

 sub npicks1 {

	my ( $self,$npicks1 )		= @_;
	if ( $npicks1 ne $empty_string ) {

		$velpertan->{_npicks1}		= $npicks1;
		$velpertan->{_note}		= $velpertan->{_note}.' npicks1='.$velpertan->{_npicks1};
		$velpertan->{_Step}		= $velpertan->{_Step}.' npicks1='.$velpertan->{_npicks1};

	} else { 
		print("velpertan, npicks1, missing npicks1,\n");
	 }
 }


=head2 sub npicks2 


=cut

 sub npicks2 {

	my ( $self,$npicks2 )		= @_;
	if ( $npicks2 ne $empty_string ) {

		$velpertan->{_npicks2}		= $npicks2;
		$velpertan->{_note}		= $velpertan->{_note}.' npicks2='.$velpertan->{_npicks2};
		$velpertan->{_Step}		= $velpertan->{_Step}.' npicks2='.$velpertan->{_npicks2};

	} else { 
		print("velpertan, npicks2, missing npicks2,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$velpertan->{_nt}		= $nt;
		$velpertan->{_note}		= $velpertan->{_note}.' nt='.$velpertan->{_nt};
		$velpertan->{_Step}		= $velpertan->{_Step}.' nt='.$velpertan->{_nt};

	} else { 
		print("velpertan, nt, missing nt,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$velpertan->{_nx}		= $nx;
		$velpertan->{_note}		= $velpertan->{_note}.' nx='.$velpertan->{_nx};
		$velpertan->{_Step}		= $velpertan->{_Step}.' nx='.$velpertan->{_nx};

	} else { 
		print("velpertan, nx, missing nx,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$velpertan->{_nz}		= $nz;
		$velpertan->{_note}		= $velpertan->{_note}.' nz='.$velpertan->{_nz};
		$velpertan->{_Step}		= $velpertan->{_Step}.' nz='.$velpertan->{_nz};

	} else { 
		print("velpertan, nz, missing nz,\n");
	 }
 }


=head2 sub off0 


=cut

 sub off0 {

	my ( $self,$off0 )		= @_;
	if ( $off0 ne $empty_string ) {

		$velpertan->{_off0}		= $off0;
		$velpertan->{_note}		= $velpertan->{_note}.' off0='.$velpertan->{_off0};
		$velpertan->{_Step}		= $velpertan->{_Step}.' off0='.$velpertan->{_off0};

	} else { 
		print("velpertan, off0, missing off0,\n");
	 }
 }


=head2 sub r1 


=cut

 sub r1 {

	my ( $self,$r1 )		= @_;
	if ( $r1 ne $empty_string ) {

		$velpertan->{_r1}		= $r1;
		$velpertan->{_note}		= $velpertan->{_note}.' r1='.$velpertan->{_r1};
		$velpertan->{_Step}		= $velpertan->{_Step}.' r1='.$velpertan->{_r1};

	} else { 
		print("velpertan, r1, missing r1,\n");
	 }
 }


=head2 sub r2 


=cut

 sub r2 {

	my ( $self,$r2 )		= @_;
	if ( $r2 ne $empty_string ) {

		$velpertan->{_r2}		= $r2;
		$velpertan->{_note}		= $velpertan->{_note}.' r2='.$velpertan->{_r2};
		$velpertan->{_Step}		= $velpertan->{_Step}.' r2='.$velpertan->{_r2};

	} else { 
		print("velpertan, r2, missing r2,\n");
	 }
 }


=head2 sub refl1 


=cut

 sub refl1 {

	my ( $self,$refl1 )		= @_;
	if ( $refl1 ne $empty_string ) {

		$velpertan->{_refl1}		= $refl1;
		$velpertan->{_note}		= $velpertan->{_note}.' refl1='.$velpertan->{_refl1};
		$velpertan->{_Step}		= $velpertan->{_Step}.' refl1='.$velpertan->{_refl1};

	} else { 
		print("velpertan, refl1, missing refl1,\n");
	 }
 }


=head2 sub refl2 


=cut

 sub refl2 {

	my ( $self,$refl2 )		= @_;
	if ( $refl2 ne $empty_string ) {

		$velpertan->{_refl2}		= $refl2;
		$velpertan->{_note}		= $velpertan->{_note}.' refl2='.$velpertan->{_refl2};
		$velpertan->{_Step}		= $velpertan->{_Step}.' refl2='.$velpertan->{_refl2};

	} else { 
		print("velpertan, refl2, missing refl2,\n");
	 }
 }


=head2 sub rw 


=cut

 sub rw {

	my ( $self,$rw )		= @_;
	if ( $rw ne $empty_string ) {

		$velpertan->{_rw}		= $rw;
		$velpertan->{_note}		= $velpertan->{_note}.' rw='.$velpertan->{_rw};
		$velpertan->{_Step}		= $velpertan->{_Step}.' rw='.$velpertan->{_rw};

	} else { 
		print("velpertan, rw, missing rw,\n");
	 }
 }


=head2 sub tol 


=cut

 sub tol {

	my ( $self,$tol )		= @_;
	if ( $tol ne $empty_string ) {

		$velpertan->{_tol}		= $tol;
		$velpertan->{_note}		= $velpertan->{_note}.' tol='.$velpertan->{_tol};
		$velpertan->{_Step}		= $velpertan->{_Step}.' tol='.$velpertan->{_tol};

	} else { 
		print("velpertan, tol, missing tol,\n");
	 }
 }


=head2 sub vfile 


=cut

 sub vfile {

	my ( $self,$vfile )		= @_;
	if ( $vfile ne $empty_string ) {

		$velpertan->{_vfile}		= $vfile;
		$velpertan->{_note}		= $velpertan->{_note}.' vfile='.$velpertan->{_vfile};
		$velpertan->{_Step}		= $velpertan->{_Step}.' vfile='.$velpertan->{_vfile};

	} else { 
		print("velpertan, vfile, missing vfile,\n");
	 }
 }


=head2 sub win 


=cut

 sub win {

	my ( $self,$win )		= @_;
	if ( $win ne $empty_string ) {

		$velpertan->{_win}		= $win;
		$velpertan->{_note}		= $velpertan->{_note}.' win='.$velpertan->{_win};
		$velpertan->{_Step}		= $velpertan->{_Step}.' win='.$velpertan->{_win};

	} else { 
		print("velpertan, win, missing win,\n");
	 }
 }


=head2 sub x00 


=cut

 sub x00 {

	my ( $self,$x00 )		= @_;
	if ( $x00 ne $empty_string ) {

		$velpertan->{_x00}		= $x00;
		$velpertan->{_note}		= $velpertan->{_note}.' x00='.$velpertan->{_x00};
		$velpertan->{_Step}		= $velpertan->{_Step}.' x00='.$velpertan->{_x00};

	} else { 
		print("velpertan, x00, missing x00,\n");
	 }
 }


=head2 sub z00 


=cut

 sub z00 {

	my ( $self,$z00 )		= @_;
	if ( $z00 ne $empty_string ) {

		$velpertan->{_z00}		= $z00;
		$velpertan->{_note}		= $velpertan->{_note}.' z00='.$velpertan->{_z00};
		$velpertan->{_Step}		= $velpertan->{_Step}.' z00='.$velpertan->{_z00};

	} else { 
		print("velpertan, z00, missing z00,\n");
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