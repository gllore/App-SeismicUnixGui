package App::SeismicUnixGui::sunix::model::suea2df;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUEA2DF - SU version of (an)elastic anisotropic 2D finite difference 	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUEA2DF - SU version of (an)elastic anisotropic 2D finite difference 	
		forward modeling, 4th order in space			

 suea2df > outfile c11file= c55file  [optional parameters]		

 Required Parameters:							
 c11file=c11_file	c11 voigt elasticity parameter filename		
 c55file=c55_file	c55 voigt elasticity parameter filename		

 Optional Parameters:							
 rhofile=rho_file	density filename				
			(if rhofile is not set, rho=1000 is assumed)	
 Anisotropy parameters:						
 aniso=0	 	 =1 - include anisotropy parameters		
 mode=0		=0 output particle velocity, =1 output stresses 
			(snapshots only)				

 ... the next 3 parameters become active only when aniso=1....		
 c13file=c13_file	c13 voigt elasticity parameter filename		
 c33file=c33_file	c33 voigt elasticity parameter filename		
 c15file=c15_file	c15 voigt elasticity parameter filename		
 c35file=c35_file	c35 voigt elasticity parameter filename		

 Attenuation parameters:						 
 qsw=0		 switch to include attenuation =1 - include		
 ... the next parameter becomes active only when qsw=1....	     	
 qfile=Q_file	  Q parameter filename	    				

 dt=0.001		time sampling interval (s)			
 ft=0.0 		first time (s)				 	
 lt=1.0 		last time (s)					

 nx=200		number of values in slow (x-direction)		
 dx=10.0	 	spatial sampling interval (m) x-coor		
 fx=-1000		first x coor (m)				

 nz=100		number of values in fast (z)-dimension		
 dz=dx			spatial sampling interval (m) z-coor		
 fz=0			firstz coor (m)  				

 Source parameters:							
 sx=0			source x position (m)				
 sz=500		source location (m)  				
 stype='p'		source type					
			  p: P-wave					
			  v: velocity					
			 pw: P plane-wave				
 sang=0		for stype='pw': plane wave angle		
 wtype='dg'		wave type					
 			 dg: Gaussian derivative 			
 			 ga: Gaussian		 			
 			 ri: Ricker					
 			 sp: spike, sp2: double spike   		
 ts=0.05		source duration (s)				
 favg=50		source average frequency			

 Attenuation parameters:						
 qsw=0		 	switch to include attenuation =1 - include	

 Boundary condition parameters:					
 bc=10,10,10,10 	Top,left,bottom,right boundary condition	
 			=0 none						
 			=1 symmetry 					
 			=2 free surface (top only)			
 			>2 absorbing (value indicates width of absorbing
			layer	 					
 bc_a=0.95;		bc initial taper value for absorbing boundary  
 bc_r=0.;		bc exponential factor for absorbing boundary  	
 			variables are scaled by bc_a*pow(i,-bc_r)	

 Optional output parameters:						
 sofile=		name of source file				
 snfile=		name of file containing for snapshots		
 snaptime=		times of snapshots i.e. snaptime=0.1,0.2,0.3	

 vsx=			x coordinate of vertical line of seismograms	
 hsz=			z coordinate of horizontal line of seismograms	
 vrslfile="vsp.su"	output file for vertical line of seismograms[nz][nt]
 hsfile="hs.su" 	output file for horizontal line of seismograms[nx][nt]
 tsw=0		 	switch to use shear stress only in non-fluid	
			media - may help reduce dispersion tsw=1. If	
			tsw=0 then standard calculation	  		
 verbose=0		=1 to print progress on screen			

 Notes:								
 1) The outfile contains information generated by the input parameters,
    such as memory allocation, stability, etc. If your input file does	
    not work, check this file first.					

 The model is specified as binary files of stiffness parameters and    
 densities. These may be created any way the user desires. The program 
 unif2 or makevel may be used to generate densities, and the program	
 unif2aniso may be used to generate the stiffnesses. You will need to	
 transpose these files (stiffnesses and densities), as the input	
 format for suea2df assumes that the fast dimesion is the horizontal or 
 the x-dimension. You may do this via					

  transp n1=nz < c11_file > transp_c11_file				

 If aniso=1 then the program will expect the additional stiffnesss files.

 If qsw=1 unif2anis can be used to generate the Q values on a grid	
 These value also need to be transposed, as with the stiffnesses.	

Output files (always generated)					
	hsfile								
	vrslfile							
	hsfile.chd - header for hsfile					
	vrslfile.chd - header for vrslfile				
	hsfile.mod - model file						

 Output files (if requested)						
	sofile - ascii source file					
	snfile  - su format snapshots file				

 Caveat:								
 A common error in using this program is to compute stiffnesses with	
 a specified density, but forget to specify this density as the rhofile.

 
 Credits: UU GEOPHY Chris Juhlin 15 May 1999
 Copyright (c) Uppsala University, 1998.
 All rights reserved.			
 Parts of program use Seismic Unix Package - CSM
 Changes - C. Juhlin

 1. Fixed upgrading of stresses. There was an error in the coding for
 the Tzz term, c15 was being used instead of c35. This only caused
 problems for dipping anisotropic layers

 2. Added some header information for hutput of snapshots.

 3. 2001-01-30: Added option to set absorbing bc constants bc_a and bc_r 

 4. 2001-02-23: Corrected bug in outputting model boundaries to standard
 output in 
 routine get_econst

 5. 2001-04-26: Added option for updating velocities to only use 
 shear stress if material is non-fluid, this appears to reduce dispersion at 
 near grazing angles for fluid-solid boundary. Set tsw=1 to invoke

 6. 2001-05-14: Changed loop in free-surface boundary condition for velocties
 Thanks goes to Mike Holzrichter for pointing out this problem and the wrong
 scaling factor in the updating.

 7. 2001-05-16: Changed set_layers function to avoid negative indexing.
 Thanks goes to Mike Holzrichter for pointing out this problem

 8. 2001-05-17: Modified make_seis to take into account VSP geometry
 correctly and not store unnecessary data.

 9. 2001-08-21: Fixed set_layers so mode fills properly in depth. Earlier
 versions were accessing incorrect array locations at last defined depth.

 10. 2003-04-21: Fixed boundary conditions.

 11. 2003-05-02: Extended the model area by half the grid spacing on the RHS.
 This makes the model area symmetric allowing a plane wave source to be
 introduced into the model (stype=pw). The w, txx and tzz grids contain now
 one more column than the u and txz grids.

 12. 2003-05-02: Added routines to allow plane waves to be introduced at a 
 specified angle (sang) into the model with functions add_pw_source_V and
 add_pw_source_S.

 13. 15 Oct 2005 -- tossed all the model building stuff. Read models
	from binary files made by  unif2aniso (CWP:John Stockwell)

 14. 25 Feb 2008 -- Fixed attenutation option (qsw=1) so that Q values are
	from binary files made by makevel or similar program

 15. 1 April 2010 -- Changed free surface velocity BC back to original.
	Someone had changed the scaling factor from 2.0 to 0.5 in fs4v_bc_top

 Algorithm based on Juhlin (1995, Geophys. Prosp.)
	and Levander (1988, Geophysics)
 Attenuation included as in Graves (1996, BSSA)



=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';
use App::SeismicUnixGui::misc::L_SU_global_constants;

my $get = new L_SU_global_constants();

my $var          = $get->var();
my $empty_string = $var->{_empty_string};

my $suea2df = {
    _aniso    => '',
    _bc       => '',
    _bc_a     => '',
    _bc_r     => '',
    _c11file  => '',
    _c13file  => '',
    _c15file  => '',
    _c33file  => '',
    _c35file  => '',
    _c55file  => '',
    _dt       => '',
    _dx       => '',
    _dz       => '',
    _favg     => '',
    _ft       => '',
    _fx       => '',
    _fz       => '',
    _hsfile   => '',
    _hsz      => '',
    _lt       => '',
    _mode     => '',
    _nx       => '',
    _nz       => '',
    _qfile    => '',
    _qsw      => '',
    _rho      => '',
    _rhofile  => '',
    _sang     => '',
    _snaptime => '',
    _snfile   => '',
    _sofile   => '',
    _stype    => '',
    _sx       => '',
    _sz       => '',
    _ts       => '',
    _tsw      => '',
    _verbose  => '',
    _vrslfile => '',
    _vsx      => '',
    _wtype    => '',
    _Step     => '',
    _note     => '',
};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

suea2df reads anisotropy files locally wherever the executable
is run

=cut

sub Step {
	use App::SeismicUnixGui::configs::big_streams::Project_config;
	
	my $Project          = new Project_config();
	
	my $PL_SEISMIC  = $Project->PL_SEISMIC();
	
    $suea2df->{_Step} ="cd $PL_SEISMIC \n".'suea2df' . $suea2df->{_Step};
    return ( $suea2df->{_Step} );

}

=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

sub note {

    $suea2df->{_note} = 'suea2df' . $suea2df->{_note};
    return ( $suea2df->{_note} );

}

=head2 sub clear

=cut

sub clear {

    $suea2df->{_aniso}    = '';
    $suea2df->{_bc}       = '';
    $suea2df->{_bc_a}     = '';
    $suea2df->{_bc_r}     = '';
    $suea2df->{_c11file}  = '';
    $suea2df->{_c13file}  = '';
    $suea2df->{_c15file}  = '';
    $suea2df->{_c33file}  = '';
    $suea2df->{_c35file}  = '';
    $suea2df->{_c55file}  = '';
    $suea2df->{_dt}       = '';
    $suea2df->{_dx}       = '';
    $suea2df->{_dz}       = '';
    $suea2df->{_favg}     = '';
    $suea2df->{_ft}       = '';
    $suea2df->{_fx}       = '';
    $suea2df->{_fz}       = '';
    $suea2df->{_hsfile}   = '';
    $suea2df->{_hsz}      = '';
    $suea2df->{_lt}       = '';
    $suea2df->{_mode}     = '';
    $suea2df->{_nx}       = '';
    $suea2df->{_nz}       = '';
    $suea2df->{_qfile}    = '';
    $suea2df->{_qsw}      = '';
    $suea2df->{_rho}      = '';
    $suea2df->{_rhofile}  = '';
    $suea2df->{_sang}     = '';
    $suea2df->{_snaptime} = '';
    $suea2df->{_snfile}   = '';
    $suea2df->{_sofile}   = '';
    $suea2df->{_stype}    = '';
    $suea2df->{_sx}       = '';
    $suea2df->{_sz}       = '';
    $suea2df->{_ts}       = '';
    $suea2df->{_tsw}      = '';
    $suea2df->{_verbose}  = '';
    $suea2df->{_vrslfile} = '';
    $suea2df->{_vsx}      = '';
    $suea2df->{_wtype}    = '';
    $suea2df->{_Step}     = '';
    $suea2df->{_note}     = '';
}

=head2 sub aniso 


=cut

sub aniso {

    my ( $self, $aniso ) = @_;
    if ( $aniso ne $empty_string ) {

        $suea2df->{_aniso} = $aniso;
        $suea2df->{_note} =
          $suea2df->{_note} . ' aniso=' . $suea2df->{_aniso};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' aniso=' . $suea2df->{_aniso};

    }
    else {
        print("suea2df, aniso, missing aniso,\n");
    }
}

=head2 sub bc 


=cut

sub bc {

    my ( $self, $bc ) = @_;
    if ( $bc ne $empty_string ) {

        $suea2df->{_bc}   = $bc;
        $suea2df->{_note} = $suea2df->{_note} . ' bc=' . $suea2df->{_bc};
        $suea2df->{_Step} = $suea2df->{_Step} . ' bc=' . $suea2df->{_bc};

    }
    else {
        print("suea2df, bc, missing bc,\n");
    }
}

=head2 sub bc_a 


=cut

sub bc_a {

    my ( $self, $bc_a ) = @_;
    if ( $bc_a ne $empty_string ) {

        $suea2df->{_bc_a} = $bc_a;
        $suea2df->{_note} = $suea2df->{_note} . ' bc_a=' . $suea2df->{_bc_a};
        $suea2df->{_Step} = $suea2df->{_Step} . ' bc_a=' . $suea2df->{_bc_a};

    }
    else {
        print("suea2df, bc_a, missing bc_a,\n");
    }
}

=head2 sub bc_r 


=cut

sub bc_r {

    my ( $self, $bc_r ) = @_;
    if ( $bc_r ne $empty_string ) {

        $suea2df->{_bc_r} = $bc_r;
        $suea2df->{_note} = $suea2df->{_note} . ' bc_r=' . $suea2df->{_bc_r};
        $suea2df->{_Step} = $suea2df->{_Step} . ' bc_r=' . $suea2df->{_bc_r};

    }
    else {
        print("suea2df, bc_r, missing bc_r,\n");
    }
}

=head2 sub c11file 


=cut

sub c11file {

    my ( $self, $c11file ) = @_;
    if ( $c11file ne $empty_string ) {

        $suea2df->{_c11file} = $c11file;
        $suea2df->{_note} =
          $suea2df->{_note} . ' c11file=' . $suea2df->{_c11file};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' c11file=' . $suea2df->{_c11file};

    }
    else {
        print("suea2df, c11file, missing c11file,\n");
    }
}

=head2 sub c13file 


=cut

sub c13file {

    my ( $self, $c13file ) = @_;
    if ( $c13file ne $empty_string ) {

        $suea2df->{_c13file} = $c13file;
        $suea2df->{_note} =
          $suea2df->{_note} . ' c13file=' . $suea2df->{_c13file};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' c13file=' . $suea2df->{_c13file};

    }
    else {
        print("suea2df, c13file, missing c13file,\n");
    }
}

=head2 sub c15file 


=cut

sub c15file {

    my ( $self, $c15file ) = @_;
    if ( $c15file ne $empty_string ) {

        $suea2df->{_c15file} = $c15file;
        $suea2df->{_note} =
          $suea2df->{_note} . ' c15file=' . $suea2df->{_c15file};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' c15file=' . $suea2df->{_c15file};

    }
    else {
        print("suea2df, c15file, missing c15file,\n");
    }
}

=head2 sub c33file 


=cut

sub c33file {

    my ( $self, $c33file ) = @_;
    if ( $c33file ne $empty_string ) {

        $suea2df->{_c33file} = $c33file;
        $suea2df->{_note} =
          $suea2df->{_note} . ' c33file=' . $suea2df->{_c33file};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' c33file=' . $suea2df->{_c33file};

    }
    else {
        print("suea2df, c33file, missing c33file,\n");
    }
}

=head2 sub c35file 


=cut

sub c35file {

    my ( $self, $c35file ) = @_;
    if ( $c35file ne $empty_string ) {

        $suea2df->{_c35file} = $c35file;
        $suea2df->{_note} =
          $suea2df->{_note} . ' c35file=' . $suea2df->{_c35file};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' c35file=' . $suea2df->{_c35file};

    }
    else {
        print("suea2df, c35file, missing c35file,\n");
    }
}

=head2 sub c55file 


=cut

sub c55file {

    my ( $self, $c55file ) = @_;
    if ( $c55file ne $empty_string ) {

        $suea2df->{_c55file} = $c55file;
        $suea2df->{_note} =
          $suea2df->{_note} . ' c55file=' . $suea2df->{_c55file};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' c55file=' . $suea2df->{_c55file};

    }
    else {
        print("suea2df, c55file, missing c55file,\n");
    }
}

=head2 sub dt 


=cut

sub dt {

    my ( $self, $dt ) = @_;
    if ( $dt ne $empty_string ) {

        $suea2df->{_dt}   = $dt;
        $suea2df->{_note} = $suea2df->{_note} . ' dt=' . $suea2df->{_dt};
        $suea2df->{_Step} = $suea2df->{_Step} . ' dt=' . $suea2df->{_dt};

    }
    else {
        print("suea2df, dt, missing dt,\n");
    }
}

=head2 sub dx 


=cut

sub dx {

    my ( $self, $dx ) = @_;
    if ( $dx ne $empty_string ) {

        $suea2df->{_dx}   = $dx;
        $suea2df->{_note} = $suea2df->{_note} . ' dx=' . $suea2df->{_dx};
        $suea2df->{_Step} = $suea2df->{_Step} . ' dx=' . $suea2df->{_dx};

    }
    else {
        print("suea2df, dx, missing dx,\n");
    }
}

=head2 sub dz 


=cut

sub dz {

    my ( $self, $dz ) = @_;
    if ( $dz ne $empty_string ) {

        $suea2df->{_dz}   = $dz;
        $suea2df->{_note} = $suea2df->{_note} . ' dz=' . $suea2df->{_dz};
        $suea2df->{_Step} = $suea2df->{_Step} . ' dz=' . $suea2df->{_dz};

    }
    else {
        print("suea2df, dz, missing dz,\n");
    }
}

=head2 sub favg 


=cut

sub favg {

    my ( $self, $favg ) = @_;
    if ( $favg ne $empty_string ) {

        $suea2df->{_favg} = $favg;
        $suea2df->{_note} = $suea2df->{_note} . ' favg=' . $suea2df->{_favg};
        $suea2df->{_Step} = $suea2df->{_Step} . ' favg=' . $suea2df->{_favg};

    }
    else {
        print("suea2df, favg, missing favg,\n");
    }
}

=head2 sub ft 


=cut

sub ft {

    my ( $self, $ft ) = @_;
    if ( $ft ne $empty_string ) {

        $suea2df->{_ft}   = $ft;
        $suea2df->{_note} = $suea2df->{_note} . ' ft=' . $suea2df->{_ft};
        $suea2df->{_Step} = $suea2df->{_Step} . ' ft=' . $suea2df->{_ft};

    }
    else {
        print("suea2df, ft, missing ft,\n");
    }
}

=head2 sub fx 


=cut

sub fx {

    my ( $self, $fx ) = @_;
    if ( $fx ne $empty_string ) {

        $suea2df->{_fx}   = $fx;
        $suea2df->{_note} = $suea2df->{_note} . ' fx=' . $suea2df->{_fx};
        $suea2df->{_Step} = $suea2df->{_Step} . ' fx=' . $suea2df->{_fx};

    }
    else {
        print("suea2df, fx, missing fx,\n");
    }
}

=head2 sub fz 


=cut

sub fz {

    my ( $self, $fz ) = @_;
    if ( $fz ne $empty_string ) {

        $suea2df->{_fz}   = $fz;
        $suea2df->{_note} = $suea2df->{_note} . ' fz=' . $suea2df->{_fz};
        $suea2df->{_Step} = $suea2df->{_Step} . ' fz=' . $suea2df->{_fz};

    }
    else {
        print("suea2df, fz, missing fz,\n");
    }
}

=head2 sub hsfile 


=cut

sub hsfile {

    my ( $self, $hsfile ) = @_;
    if ( $hsfile ne $empty_string ) {

        $suea2df->{_hsfile} = $hsfile;
        $suea2df->{_note} =
          $suea2df->{_note} . ' hsfile=' . $suea2df->{_hsfile};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' hsfile=' . $suea2df->{_hsfile};

    }
    else {
        print("suea2df, hsfile, missing hsfile,\n");
    }
}

=head2 sub hsz 


=cut

sub hsz {

    my ( $self, $hsz ) = @_;
    if ( $hsz ne $empty_string ) {

        $suea2df->{_hsz}  = $hsz;
        $suea2df->{_note} = $suea2df->{_note} . ' hsz=' . $suea2df->{_hsz};
        $suea2df->{_Step} = $suea2df->{_Step} . ' hsz=' . $suea2df->{_hsz};

    }
    else {
        print("suea2df, hsz, missing hsz,\n");
    }
}

=head2 sub lt 


=cut

sub lt {

    my ( $self, $lt ) = @_;
    if ( $lt ne $empty_string ) {

        $suea2df->{_lt}   = $lt;
        $suea2df->{_note} = $suea2df->{_note} . ' lt=' . $suea2df->{_lt};
        $suea2df->{_Step} = $suea2df->{_Step} . ' lt=' . $suea2df->{_lt};

    }
    else {
        print("suea2df, lt, missing lt,\n");
    }
}

=head2 sub mode 


=cut

sub mode {

    my ( $self, $mode ) = @_;
    if ( $mode ne $empty_string ) {

        $suea2df->{_mode} = $mode;
        $suea2df->{_note} = $suea2df->{_note} . ' mode=' . $suea2df->{_mode};
        $suea2df->{_Step} = $suea2df->{_Step} . ' mode=' . $suea2df->{_mode};

    }
    else {
        print("suea2df, mode, missing mode,\n");
    }
}

=head2 sub nx 


=cut

sub nx {

    my ( $self, $nx ) = @_;
    if ( $nx ne $empty_string ) {

        $suea2df->{_nx}   = $nx;
        $suea2df->{_note} = $suea2df->{_note} . ' nx=' . $suea2df->{_nx};
        $suea2df->{_Step} = $suea2df->{_Step} . ' nx=' . $suea2df->{_nx};

    }
    else {
        print("suea2df, nx, missing nx,\n");
    }
}

=head2 sub nz 


=cut

sub nz {

    my ( $self, $nz ) = @_;
    if ( $nz ne $empty_string ) {

        $suea2df->{_nz}   = $nz;
        $suea2df->{_note} = $suea2df->{_note} . ' nz=' . $suea2df->{_nz};
        $suea2df->{_Step} = $suea2df->{_Step} . ' nz=' . $suea2df->{_nz};

    }
    else {
        print("suea2df, nz, missing nz,\n");
    }
}

=head2 sub qfile 


=cut

sub qfile {

    my ( $self, $qfile ) = @_;
    if ( $qfile ne $empty_string ) {

        $suea2df->{_qfile} = $qfile;
        $suea2df->{_note} =
          $suea2df->{_note} . ' qfile=' . $suea2df->{_qfile};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' qfile=' . $suea2df->{_qfile};

    }
    else {
        print("suea2df, qfile, missing qfile,\n");
    }
}

=head2 sub qsw 


=cut

sub qsw {

    my ( $self, $qsw ) = @_;
    if ( $qsw ne $empty_string ) {

        $suea2df->{_qsw}  = $qsw;
        $suea2df->{_note} = $suea2df->{_note} . ' qsw=' . $suea2df->{_qsw};
        $suea2df->{_Step} = $suea2df->{_Step} . ' qsw=' . $suea2df->{_qsw};

    }
    else {
        print("suea2df, qsw, missing qsw,\n");
    }
}

=head2 sub rho 


=cut

sub rho {

    my ( $self, $rho ) = @_;
    if ( $rho ne $empty_string ) {

        $suea2df->{_rho}  = $rho;
        $suea2df->{_note} = $suea2df->{_note} . ' rho=' . $suea2df->{_rho};
        $suea2df->{_Step} = $suea2df->{_Step} . ' rho=' . $suea2df->{_rho};

    }
    else {
        print("suea2df, rho, missing rho,\n");
    }
}

=head2 sub rhofile 


=cut

sub rhofile {

    my ( $self, $rhofile ) = @_;
    if ( $rhofile ne $empty_string ) {

        $suea2df->{_rhofile} = $rhofile;
        $suea2df->{_note} =
          $suea2df->{_note} . ' rhofile=' . $suea2df->{_rhofile};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' rhofile=' . $suea2df->{_rhofile};

    }
    else {
        print("suea2df, rhofile, missing rhofile,\n");
    }
}

=head2 sub sang 


=cut

sub sang {

    my ( $self, $sang ) = @_;
    if ( $sang ne $empty_string ) {

        $suea2df->{_sang} = $sang;
        $suea2df->{_note} = $suea2df->{_note} . ' sang=' . $suea2df->{_sang};
        $suea2df->{_Step} = $suea2df->{_Step} . ' sang=' . $suea2df->{_sang};

    }
    else {
        print("suea2df, sang, missing sang,\n");
    }
}

=head2 sub snaptime 


=cut

sub snaptime {

    my ( $self, $snaptime ) = @_;
    if ( $snaptime ne $empty_string ) {

        $suea2df->{_snaptime} = $snaptime;
        $suea2df->{_note} =
          $suea2df->{_note} . ' snaptime=' . $suea2df->{_snaptime};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' snaptime=' . $suea2df->{_snaptime};

    }
    else {
        print("suea2df, snaptime, missing snaptime,\n");
    }
}

=head2 sub snfile 


=cut

sub snfile {

    my ( $self, $snfile ) = @_;
    if ( $snfile ne $empty_string ) {

        $suea2df->{_snfile} = $snfile;
        $suea2df->{_note} =
          $suea2df->{_note} . ' snfile=' . $suea2df->{_snfile};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' snfile=' . $suea2df->{_snfile};

    }
    else {
        print("suea2df, snfile, missing snfile,\n");
    }
}

=head2 sub sofile 


=cut

sub sofile {

    my ( $self, $sofile ) = @_;
    if ( $sofile ne $empty_string ) {

        $suea2df->{_sofile} = $sofile;
        $suea2df->{_note} =
          $suea2df->{_note} . ' sofile=' . $suea2df->{_sofile};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' sofile=' . $suea2df->{_sofile};

    }
    else {
        print("suea2df, sofile, missing sofile,\n");
    }
}

=head2 sub stype 


=cut

sub stype {

    my ( $self, $stype ) = @_;
    if ( $stype ne $empty_string ) {

        $suea2df->{_stype} = $stype;
        $suea2df->{_note} =
          $suea2df->{_note} . ' stype=' . $suea2df->{_stype};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' stype=' . $suea2df->{_stype};

    }
    else {
        print("suea2df, stype, missing stype,\n");
    }
}

=head2 sub sx 


=cut

sub sx {

    my ( $self, $sx ) = @_;
    if ( $sx ne $empty_string ) {

        $suea2df->{_sx}   = $sx;
        $suea2df->{_note} = $suea2df->{_note} . ' sx=' . $suea2df->{_sx};
        $suea2df->{_Step} = $suea2df->{_Step} . ' sx=' . $suea2df->{_sx};

    }
    else {
        print("suea2df, sx, missing sx,\n");
    }
}

=head2 sub sz 


=cut

sub sz {

    my ( $self, $sz ) = @_;
    if ( $sz ne $empty_string ) {

        $suea2df->{_sz}   = $sz;
        $suea2df->{_note} = $suea2df->{_note} . ' sz=' . $suea2df->{_sz};
        $suea2df->{_Step} = $suea2df->{_Step} . ' sz=' . $suea2df->{_sz};

    }
    else {
        print("suea2df, sz, missing sz,\n");
    }
}

=head2 sub ts 


=cut

sub ts {

    my ( $self, $ts ) = @_;
    if ( $ts ne $empty_string ) {

        $suea2df->{_ts}   = $ts;
        $suea2df->{_note} = $suea2df->{_note} . ' ts=' . $suea2df->{_ts};
        $suea2df->{_Step} = $suea2df->{_Step} . ' ts=' . $suea2df->{_ts};

    }
    else {
        print("suea2df, ts, missing ts,\n");
    }
}

=head2 sub tsw 


=cut

sub tsw {

    my ( $self, $tsw ) = @_;
    if ( $tsw ne $empty_string ) {

        $suea2df->{_tsw}  = $tsw;
        $suea2df->{_note} = $suea2df->{_note} . ' tsw=' . $suea2df->{_tsw};
        $suea2df->{_Step} = $suea2df->{_Step} . ' tsw=' . $suea2df->{_tsw};

    }
    else {
        print("suea2df, tsw, missing tsw,\n");
    }
}

=head2 sub verbose 


=cut

sub verbose {

    my ( $self, $verbose ) = @_;
    if ( $verbose ne $empty_string ) {

        $suea2df->{_verbose} = $verbose;
        $suea2df->{_note} =
          $suea2df->{_note} . ' verbose=' . $suea2df->{_verbose};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' verbose=' . $suea2df->{_verbose};

    }
    else {
        print("suea2df, verbose, missing verbose,\n");
    }
}

=head2 sub vrslfile 


=cut

sub vrslfile {

    my ( $self, $vrslfile ) = @_;
    if ( $vrslfile ne $empty_string ) {

        $suea2df->{_vrslfile} = $vrslfile;
        $suea2df->{_note} =
          $suea2df->{_note} . ' vrslfile=' . $suea2df->{_vrslfile};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' vrslfile=' . $suea2df->{_vrslfile};

    }
    else {
        print("suea2df, vrslfile, missing vrslfile,\n");
    }
}

=head2 sub vsx 


=cut

sub vsx {

    my ( $self, $vsx ) = @_;
    if ( $vsx ne $empty_string ) {

        $suea2df->{_vsx}  = $vsx;
        $suea2df->{_note} = $suea2df->{_note} . ' vsx=' . $suea2df->{_vsx};
        $suea2df->{_Step} = $suea2df->{_Step} . ' vsx=' . $suea2df->{_vsx};

    }
    else {
        print("suea2df, vsx, missing vsx,\n");
    }
}

=head2 sub wtype 


=cut

sub wtype {

    my ( $self, $wtype ) = @_;
    if ( $wtype ne $empty_string ) {

        $suea2df->{_wtype} = $wtype;
        $suea2df->{_note} =
          $suea2df->{_note} . ' wtype=' . $suea2df->{_wtype};
        $suea2df->{_Step} =
          $suea2df->{_Step} . ' wtype=' . $suea2df->{_wtype};

    }
    else {
        print("suea2df, wtype, missing wtype,\n");
    }
}

=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut

sub get_max_index {
    my ($self) = @_;
    my $max_index = 39;

    return ($max_index);
}

1;
