 package rayt2d;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  RAYT2D - traveltime Tables calculated by 2D paraxial RAY tracing	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 RAYT2D - traveltime Tables calculated by 2D paraxial RAY tracing	

     rayt2d vfile= tfile= [optional parameters]			

 Required parameters:							
 vfile=stdin		file containning velocity v[nx][nz]		
 tfile=stdout		file containning traveltime tables		
			t[nxs][nxo][nzo]				

 Optional parameters							
 dt=0.008		time sample interval in ray tracing		
 nt=401		number of time samples in ray tracing		

 fz=0			first depth sample in velocity			
 nz=101		number of depth samples in velocity		
 dz=100		depth interval in velocity			
 fx=0			first lateral sample in velocity		
 nx=101		number of lateral samples in velocity		
 dx=100		lateral interval in velocity			

 fzo=fz		first depth sample in traveltime table		
 nzo=nz		number of depth samples in traveltime table	
 dzo=dz		depth interval in traveltime table		
 fxo=fx		first lateral sample in traveltime table	
 nxo=nx		number of lateral samples in traveltime table	
 dxo=dx		lateral interval in traveltime table		

 surf="0,0;99999,0"  Recording surface "x1,z1;x2,z2;x3,z3;...
 fxs=fx		x-coordinate of first source			
 nxs=1			number of sources				
 dxs=2*dxo		x-coordinate increment of sources		
 aperx=0.5*nx*dx  	ray tracing aperature in x-direction		

 fa=-60		first take-off angle of rays (degrees)		
 na=61			number of rays  				
 da=2			increment of take-off angle  			
 amin=0		minimum emergence angle 			
 amax=90		maximum emergence angle 			

 fac=0.01		factor to determine radius for extrapolation	
 ek=1			flag of implementing eikonal in shadow zones 	
 ms=10			print verbal information at every ms sources	
 restart=n		job is restarted (=y yes; =n no)		
 npv=0			flag of computing quantities for velocity analysis
 if npv>0 specify the following three files				
 pvfile=pvfile		input file of velocity variation pv[nxo][nzo]	
 tvfile=tvfile		output file of traveltime variation tables  	
			tv[nxs][nxo][nzo]				
 csfile=csfile		output file of cosine tables cs[nxs][nxo][nzo]	

 Notes:								
 1. Each traveltime table is calculated by paraxial ray tracing; then 	
    traveltimes in shadow zones are compensated by solving eikonal	
    equation.								
 2. Input velocity is uniformly sampled and smooth one preferred.	
 3. Traveltime table and source ranges must be within velocity model.	
 4. Ray tracing aperature can be chosen as sum of migration aperature	
    plus half of maximum offset.					
 5. Memory requirement for this program is about			
      [nx*nz+4*mx*nz+3*nxo*nzo+na*(nx*nz+mx*nz+3*nxo*nzo)]*4 bytes	
    where mx = min(nx,2*(1+aperx/dx)).					


 Author:  Zhenyue Liu, 10/11/94,  Colorado School of Mines 

          Trino Salinas, 01/01/96 included the option to handle nonflat
          reference surfaces.
          Subroutines from Dave Hale's modeling library were adapted in
          this code to define topography using cubic splines.

 References:

 Beydoun, W. B., and Keho, T. H., 1987, The paraxial ray method:
   Geophysics, vol. 52, 1639-1653.

 Cerveny, V., 1985, The application of ray tracing to the numerical
   modeling of seismic wavefields in complex structures, in Dohr, G.,
   ED., Seismic shear waves (part A: Theory): Geophysical Press,
   Number 15 in Handbook of Geophysical Exploration, 1-124.
 

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $rayt2d		= {
		_amax					=> '',
		_amin					=> '',
		_aperx					=> '',
		_csfile					=> '',
		_da					=> '',
		_dt					=> '',
		_dx					=> '',
		_dxo					=> '',
		_dxs					=> '',
		_dz					=> '',
		_dzo					=> '',
		_ek					=> '',
		_fa					=> '',
		_fac					=> '',
		_fx					=> '',
		_fxo					=> '',
		_fxs					=> '',
		_fz					=> '',
		_fzo					=> '',
		_ms					=> '',
		_mx					=> '',
		_na					=> '',
		_npv					=> '',
		_nt					=> '',
		_nx					=> '',
		_nxo					=> '',
		_nxs					=> '',
		_nz					=> '',
		_nzo					=> '',
		_pvfile					=> '',
		_restart					=> '',
		_surf					=> '',
		_tfile					=> '',
		_tvfile					=> '',
		_vfile					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$rayt2d->{_Step}     = 'rayt2d'.$rayt2d->{_Step};
	return ( $rayt2d->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$rayt2d->{_note}     = 'rayt2d'.$rayt2d->{_note};
	return ( $rayt2d->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$rayt2d->{_amax}			= '';
		$rayt2d->{_amin}			= '';
		$rayt2d->{_aperx}			= '';
		$rayt2d->{_csfile}			= '';
		$rayt2d->{_da}			= '';
		$rayt2d->{_dt}			= '';
		$rayt2d->{_dx}			= '';
		$rayt2d->{_dxo}			= '';
		$rayt2d->{_dxs}			= '';
		$rayt2d->{_dz}			= '';
		$rayt2d->{_dzo}			= '';
		$rayt2d->{_ek}			= '';
		$rayt2d->{_fa}			= '';
		$rayt2d->{_fac}			= '';
		$rayt2d->{_fx}			= '';
		$rayt2d->{_fxo}			= '';
		$rayt2d->{_fxs}			= '';
		$rayt2d->{_fz}			= '';
		$rayt2d->{_fzo}			= '';
		$rayt2d->{_ms}			= '';
		$rayt2d->{_mx}			= '';
		$rayt2d->{_na}			= '';
		$rayt2d->{_npv}			= '';
		$rayt2d->{_nt}			= '';
		$rayt2d->{_nx}			= '';
		$rayt2d->{_nxo}			= '';
		$rayt2d->{_nxs}			= '';
		$rayt2d->{_nz}			= '';
		$rayt2d->{_nzo}			= '';
		$rayt2d->{_pvfile}			= '';
		$rayt2d->{_restart}			= '';
		$rayt2d->{_surf}			= '';
		$rayt2d->{_tfile}			= '';
		$rayt2d->{_tvfile}			= '';
		$rayt2d->{_vfile}			= '';
		$rayt2d->{_Step}			= '';
		$rayt2d->{_note}			= '';
 }


=head2 sub amax 


=cut

 sub amax {

	my ( $self,$amax )		= @_;
	if ( $amax ne $empty_string ) {

		$rayt2d->{_amax}		= $amax;
		$rayt2d->{_note}		= $rayt2d->{_note}.' amax='.$rayt2d->{_amax};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' amax='.$rayt2d->{_amax};

	} else { 
		print("rayt2d, amax, missing amax,\n");
	 }
 }


=head2 sub amin 


=cut

 sub amin {

	my ( $self,$amin )		= @_;
	if ( $amin ne $empty_string ) {

		$rayt2d->{_amin}		= $amin;
		$rayt2d->{_note}		= $rayt2d->{_note}.' amin='.$rayt2d->{_amin};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' amin='.$rayt2d->{_amin};

	} else { 
		print("rayt2d, amin, missing amin,\n");
	 }
 }


=head2 sub aperx 


=cut

 sub aperx {

	my ( $self,$aperx )		= @_;
	if ( $aperx ne $empty_string ) {

		$rayt2d->{_aperx}		= $aperx;
		$rayt2d->{_note}		= $rayt2d->{_note}.' aperx='.$rayt2d->{_aperx};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' aperx='.$rayt2d->{_aperx};

	} else { 
		print("rayt2d, aperx, missing aperx,\n");
	 }
 }


=head2 sub csfile 


=cut

 sub csfile {

	my ( $self,$csfile )		= @_;
	if ( $csfile ne $empty_string ) {

		$rayt2d->{_csfile}		= $csfile;
		$rayt2d->{_note}		= $rayt2d->{_note}.' csfile='.$rayt2d->{_csfile};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' csfile='.$rayt2d->{_csfile};

	} else { 
		print("rayt2d, csfile, missing csfile,\n");
	 }
 }


=head2 sub da 


=cut

 sub da {

	my ( $self,$da )		= @_;
	if ( $da ne $empty_string ) {

		$rayt2d->{_da}		= $da;
		$rayt2d->{_note}		= $rayt2d->{_note}.' da='.$rayt2d->{_da};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' da='.$rayt2d->{_da};

	} else { 
		print("rayt2d, da, missing da,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$rayt2d->{_dt}		= $dt;
		$rayt2d->{_note}		= $rayt2d->{_note}.' dt='.$rayt2d->{_dt};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' dt='.$rayt2d->{_dt};

	} else { 
		print("rayt2d, dt, missing dt,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$rayt2d->{_dx}		= $dx;
		$rayt2d->{_note}		= $rayt2d->{_note}.' dx='.$rayt2d->{_dx};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' dx='.$rayt2d->{_dx};

	} else { 
		print("rayt2d, dx, missing dx,\n");
	 }
 }


=head2 sub dxo 


=cut

 sub dxo {

	my ( $self,$dxo )		= @_;
	if ( $dxo ne $empty_string ) {

		$rayt2d->{_dxo}		= $dxo;
		$rayt2d->{_note}		= $rayt2d->{_note}.' dxo='.$rayt2d->{_dxo};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' dxo='.$rayt2d->{_dxo};

	} else { 
		print("rayt2d, dxo, missing dxo,\n");
	 }
 }


=head2 sub dxs 


=cut

 sub dxs {

	my ( $self,$dxs )		= @_;
	if ( $dxs ne $empty_string ) {

		$rayt2d->{_dxs}		= $dxs;
		$rayt2d->{_note}		= $rayt2d->{_note}.' dxs='.$rayt2d->{_dxs};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' dxs='.$rayt2d->{_dxs};

	} else { 
		print("rayt2d, dxs, missing dxs,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$rayt2d->{_dz}		= $dz;
		$rayt2d->{_note}		= $rayt2d->{_note}.' dz='.$rayt2d->{_dz};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' dz='.$rayt2d->{_dz};

	} else { 
		print("rayt2d, dz, missing dz,\n");
	 }
 }


=head2 sub dzo 


=cut

 sub dzo {

	my ( $self,$dzo )		= @_;
	if ( $dzo ne $empty_string ) {

		$rayt2d->{_dzo}		= $dzo;
		$rayt2d->{_note}		= $rayt2d->{_note}.' dzo='.$rayt2d->{_dzo};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' dzo='.$rayt2d->{_dzo};

	} else { 
		print("rayt2d, dzo, missing dzo,\n");
	 }
 }


=head2 sub ek 


=cut

 sub ek {

	my ( $self,$ek )		= @_;
	if ( $ek ne $empty_string ) {

		$rayt2d->{_ek}		= $ek;
		$rayt2d->{_note}		= $rayt2d->{_note}.' ek='.$rayt2d->{_ek};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' ek='.$rayt2d->{_ek};

	} else { 
		print("rayt2d, ek, missing ek,\n");
	 }
 }


=head2 sub fa 


=cut

 sub fa {

	my ( $self,$fa )		= @_;
	if ( $fa ne $empty_string ) {

		$rayt2d->{_fa}		= $fa;
		$rayt2d->{_note}		= $rayt2d->{_note}.' fa='.$rayt2d->{_fa};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' fa='.$rayt2d->{_fa};

	} else { 
		print("rayt2d, fa, missing fa,\n");
	 }
 }


=head2 sub fac 


=cut

 sub fac {

	my ( $self,$fac )		= @_;
	if ( $fac ne $empty_string ) {

		$rayt2d->{_fac}		= $fac;
		$rayt2d->{_note}		= $rayt2d->{_note}.' fac='.$rayt2d->{_fac};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' fac='.$rayt2d->{_fac};

	} else { 
		print("rayt2d, fac, missing fac,\n");
	 }
 }


=head2 sub fx 


=cut

 sub fx {

	my ( $self,$fx )		= @_;
	if ( $fx ne $empty_string ) {

		$rayt2d->{_fx}		= $fx;
		$rayt2d->{_note}		= $rayt2d->{_note}.' fx='.$rayt2d->{_fx};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' fx='.$rayt2d->{_fx};

	} else { 
		print("rayt2d, fx, missing fx,\n");
	 }
 }


=head2 sub fxo 


=cut

 sub fxo {

	my ( $self,$fxo )		= @_;
	if ( $fxo ne $empty_string ) {

		$rayt2d->{_fxo}		= $fxo;
		$rayt2d->{_note}		= $rayt2d->{_note}.' fxo='.$rayt2d->{_fxo};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' fxo='.$rayt2d->{_fxo};

	} else { 
		print("rayt2d, fxo, missing fxo,\n");
	 }
 }


=head2 sub fxs 


=cut

 sub fxs {

	my ( $self,$fxs )		= @_;
	if ( $fxs ne $empty_string ) {

		$rayt2d->{_fxs}		= $fxs;
		$rayt2d->{_note}		= $rayt2d->{_note}.' fxs='.$rayt2d->{_fxs};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' fxs='.$rayt2d->{_fxs};

	} else { 
		print("rayt2d, fxs, missing fxs,\n");
	 }
 }


=head2 sub fz 


=cut

 sub fz {

	my ( $self,$fz )		= @_;
	if ( $fz ne $empty_string ) {

		$rayt2d->{_fz}		= $fz;
		$rayt2d->{_note}		= $rayt2d->{_note}.' fz='.$rayt2d->{_fz};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' fz='.$rayt2d->{_fz};

	} else { 
		print("rayt2d, fz, missing fz,\n");
	 }
 }


=head2 sub fzo 


=cut

 sub fzo {

	my ( $self,$fzo )		= @_;
	if ( $fzo ne $empty_string ) {

		$rayt2d->{_fzo}		= $fzo;
		$rayt2d->{_note}		= $rayt2d->{_note}.' fzo='.$rayt2d->{_fzo};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' fzo='.$rayt2d->{_fzo};

	} else { 
		print("rayt2d, fzo, missing fzo,\n");
	 }
 }


=head2 sub ms 


=cut

 sub ms {

	my ( $self,$ms )		= @_;
	if ( $ms ne $empty_string ) {

		$rayt2d->{_ms}		= $ms;
		$rayt2d->{_note}		= $rayt2d->{_note}.' ms='.$rayt2d->{_ms};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' ms='.$rayt2d->{_ms};

	} else { 
		print("rayt2d, ms, missing ms,\n");
	 }
 }


=head2 sub mx 


=cut

 sub mx {

	my ( $self,$mx )		= @_;
	if ( $mx ne $empty_string ) {

		$rayt2d->{_mx}		= $mx;
		$rayt2d->{_note}		= $rayt2d->{_note}.' mx='.$rayt2d->{_mx};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' mx='.$rayt2d->{_mx};

	} else { 
		print("rayt2d, mx, missing mx,\n");
	 }
 }


=head2 sub na 


=cut

 sub na {

	my ( $self,$na )		= @_;
	if ( $na ne $empty_string ) {

		$rayt2d->{_na}		= $na;
		$rayt2d->{_note}		= $rayt2d->{_note}.' na='.$rayt2d->{_na};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' na='.$rayt2d->{_na};

	} else { 
		print("rayt2d, na, missing na,\n");
	 }
 }


=head2 sub npv 


=cut

 sub npv {

	my ( $self,$npv )		= @_;
	if ( $npv ne $empty_string ) {

		$rayt2d->{_npv}		= $npv;
		$rayt2d->{_note}		= $rayt2d->{_note}.' npv='.$rayt2d->{_npv};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' npv='.$rayt2d->{_npv};

	} else { 
		print("rayt2d, npv, missing npv,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$rayt2d->{_nt}		= $nt;
		$rayt2d->{_note}		= $rayt2d->{_note}.' nt='.$rayt2d->{_nt};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' nt='.$rayt2d->{_nt};

	} else { 
		print("rayt2d, nt, missing nt,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$rayt2d->{_nx}		= $nx;
		$rayt2d->{_note}		= $rayt2d->{_note}.' nx='.$rayt2d->{_nx};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' nx='.$rayt2d->{_nx};

	} else { 
		print("rayt2d, nx, missing nx,\n");
	 }
 }


=head2 sub nxo 


=cut

 sub nxo {

	my ( $self,$nxo )		= @_;
	if ( $nxo ne $empty_string ) {

		$rayt2d->{_nxo}		= $nxo;
		$rayt2d->{_note}		= $rayt2d->{_note}.' nxo='.$rayt2d->{_nxo};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' nxo='.$rayt2d->{_nxo};

	} else { 
		print("rayt2d, nxo, missing nxo,\n");
	 }
 }


=head2 sub nxs 


=cut

 sub nxs {

	my ( $self,$nxs )		= @_;
	if ( $nxs ne $empty_string ) {

		$rayt2d->{_nxs}		= $nxs;
		$rayt2d->{_note}		= $rayt2d->{_note}.' nxs='.$rayt2d->{_nxs};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' nxs='.$rayt2d->{_nxs};

	} else { 
		print("rayt2d, nxs, missing nxs,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$rayt2d->{_nz}		= $nz;
		$rayt2d->{_note}		= $rayt2d->{_note}.' nz='.$rayt2d->{_nz};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' nz='.$rayt2d->{_nz};

	} else { 
		print("rayt2d, nz, missing nz,\n");
	 }
 }


=head2 sub nzo 


=cut

 sub nzo {

	my ( $self,$nzo )		= @_;
	if ( $nzo ne $empty_string ) {

		$rayt2d->{_nzo}		= $nzo;
		$rayt2d->{_note}		= $rayt2d->{_note}.' nzo='.$rayt2d->{_nzo};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' nzo='.$rayt2d->{_nzo};

	} else { 
		print("rayt2d, nzo, missing nzo,\n");
	 }
 }


=head2 sub pvfile 


=cut

 sub pvfile {

	my ( $self,$pvfile )		= @_;
	if ( $pvfile ne $empty_string ) {

		$rayt2d->{_pvfile}		= $pvfile;
		$rayt2d->{_note}		= $rayt2d->{_note}.' pvfile='.$rayt2d->{_pvfile};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' pvfile='.$rayt2d->{_pvfile};

	} else { 
		print("rayt2d, pvfile, missing pvfile,\n");
	 }
 }


=head2 sub restart 


=cut

 sub restart {

	my ( $self,$restart )		= @_;
	if ( $restart ne $empty_string ) {

		$rayt2d->{_restart}		= $restart;
		$rayt2d->{_note}		= $rayt2d->{_note}.' restart='.$rayt2d->{_restart};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' restart='.$rayt2d->{_restart};

	} else { 
		print("rayt2d, restart, missing restart,\n");
	 }
 }


=head2 sub surf 


=cut

 sub surf {

	my ( $self,$surf )		= @_;
	if ( $surf ne $empty_string ) {

		$rayt2d->{_surf}		= $surf;
		$rayt2d->{_note}		= $rayt2d->{_note}.' surf='.$rayt2d->{_surf};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' surf='.$rayt2d->{_surf};

	} else { 
		print("rayt2d, surf, missing surf,\n");
	 }
 }


=head2 sub tfile 


=cut

 sub tfile {

	my ( $self,$tfile )		= @_;
	if ( $tfile ne $empty_string ) {

		$rayt2d->{_tfile}		= $tfile;
		$rayt2d->{_note}		= $rayt2d->{_note}.' tfile='.$rayt2d->{_tfile};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' tfile='.$rayt2d->{_tfile};

	} else { 
		print("rayt2d, tfile, missing tfile,\n");
	 }
 }


=head2 sub tvfile 


=cut

 sub tvfile {

	my ( $self,$tvfile )		= @_;
	if ( $tvfile ne $empty_string ) {

		$rayt2d->{_tvfile}		= $tvfile;
		$rayt2d->{_note}		= $rayt2d->{_note}.' tvfile='.$rayt2d->{_tvfile};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' tvfile='.$rayt2d->{_tvfile};

	} else { 
		print("rayt2d, tvfile, missing tvfile,\n");
	 }
 }


=head2 sub vfile 


=cut

 sub vfile {

	my ( $self,$vfile )		= @_;
	if ( $vfile ne $empty_string ) {

		$rayt2d->{_vfile}		= $vfile;
		$rayt2d->{_note}		= $rayt2d->{_note}.' vfile='.$rayt2d->{_vfile};
		$rayt2d->{_Step}		= $rayt2d->{_Step}.' vfile='.$rayt2d->{_vfile};

	} else { 
		print("rayt2d, vfile, missing vfile,\n");
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