package sufctanismod;

use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME:  sufctanismod.pm
 AUTHOR: Juan Lorenzo
 DATE: July 25 2016 
 DESCRIPTION: elastic finite difference modeling in anisotropic media   
              
             
 Version 1
 Notes: 
 Package name is the same as the file name
 Moose is a package that allows an object-oriented
 syntax to organizing your programs

=head2  Notes from Seismic Unix

SUFCTANISMOD - Flux-Corrected Transport correction applied to the 2D
	  elastic wave equation for finite difference modeling in 	
	  anisotropic media						
									
 sufctanismod > outfile [optional parameters]				
		outfile is the final wavefield snapshot x-component	
		x-component of wavefield snapshot is in snapshotx.data	
		y-component of wavefield snapshot is in snapshoty.data	
		z-component of wavefield snapshot is in snapshotz.data	
 									
 Optional Output Files:						
 reflxfile=	reflection seismogram file name for x-component		
		no output produced if no name specified	 		
 reflyfile=	reflection seismogram file name for y-component		
		no output produced if no name specified	 		
 reflzfile=	reflection seismogram file name for z-component		
		no output produced if no name specified	 		
 vspxfile=	VSP seismogram file name for x-component		
		no output produced if no name specified	 		
 vspyfile=	VSP seismogram file name for y-component		
		no output produced if no name specified	 		
 vspzfile=	VSP seismogram file name for z-component		
		no output produced if no name specified	 		
									
 suhead=1      To get SU-header output seismograms (else suhead=0)	
									
 New parameter:							
	               							
 Optional Parameters:							
 mt=1          number of time steps per output snapshot  		
 dofct=1 	1 do the FCT correction					
		0 do not do the FCT correction 				
 FCT Related parameters:						
 eta0=0.03	diffusion coefficient					
		typical values ranging from 0.008 to 0.06		
		about 0.03 for the second-order method 			
		about 0.012 for the fourth-order method 		
 eta=0.04	anti-diffusion coefficient 				
		typical values ranging from 0.008 to 0.06		
		about 0.04 for the second-order method  		
		about 0.015 for the fourth-order method 		
 fctxbeg=0 	x coordinate to begin applying the FCT correction	
 fctzbeg=0 	z coordinate to begin applying the FCT correction	
 fctxend=nx 	x coordinate to stop applying the FCT correction	
 fctzend=nz 	z coordinate to stop applying the FCT correction
 									
 deta0dx=0.0	gradient of eta0 in x-direction  d(eta0)/dx		
 deta0dz=0.0	gradient of eta0 in z-direction  d(eta0)/dz		
 detadx=0.0	gradient of eta in x-direction 	 d(eta)/dx		
 detadz=0.0	gradient of eta in z-direction 	 d(eta)/dz		
									
 General Parameters:							
 order=2	2 second-order finite-difference 			
		4 fourth-order finite-difference 			
									
 nt=200        number of time steps 			 		
 dt=0.004	time step  						
									
 nx=100 	number of grid points in x-direction 			
 nz=100 	number of grid points in z-direction 			
									
 dx=0.02	spatial step in x-direction 				
 dz=0.02	spatial step in z-direction 				
									
 sx=nx/2	source x-coordinate (in gridpoints)			
 sz=nz/2	source z-coordinate (in gridpoints)			
									
 fpeak=20	peak frequency of the wavelet 				
									
 receiverdepth=sz  depth of horizontal receivers (in gridpoints)      
 vspnx=sx			x grid loc of vsp				
									
 verbose=0     silent operation							
				=1 for diagnostic messages, =2 for more		
									
 wavelet=1	1 AKB wavelet						
 		2 Ricker wavelet 					
		3 impulse 						
		4 unity 						

									
 isurf=2	1 absorbing surface condition 				
		2 free surface condition 				
		3 zero surface condition 				
									
 source=1	1 point source 						
 		2 sources are located on a given refelector 	        
			(two horizontal and one dipping reflectors) 	
 		3 sources are located on a given dipping refelector     
									
 sfile= 	the name of input source file, if no name specified then
		use default source location. (source=1 or 2) 		
									
 Density and Elastic Parameters:					
 dfile= 	the name of input density file,                         
               if no name specified then                             
		assume a linear density profile with ...		
 rho00=2.0	density at (0, 0) 					
 drhodx=0.0	density gradient in x-direction  d(rho)/dx		
 drhodz=0.0	density gradient in z-direction  d(rho)/dz		
									
 afile= 	name of input elastic param.  (c11) aa file, if no name 
		specified then, assume a linear profile with ...	
 aa00=2.0	elastic parameter at (0, 0) 				
 daadx=0.0	parameter gradient in x-direction  d(aa)/dx		
 daadz=0.0	parameter gradient in z-direction  d(aa)/dz		
									
 cfile= 	name of input elastic param. (c33)  cc file, if no name 
		specified then, assume a linear profile with ...	
 cc00=2.0	elastic parameter at (0, 0) 				
 dccdx=0.0	parameter gradient in x-direction  d(cc)/dx		
 dccdz=0.0	parameter gradient in z-direction  d(cc)/dz		
									
 ffile= 	name of input elastic param.  (c13) ff file, if no name 
		specified then, assume a linear profile with ...	
 ff00=2.0	elastic parameter at (0, 0) 				
 dffdx=0.0	parameter gradient in x-direction  d(ff)/dx		
 dffdz=0.0	parameter gradient in z-direction  d(ff)/dz	

									
 lfile= 	name of input elastic param.  (c44) ll file, if no name 
		specified then, assume a linear profile with ...	
 ll00=2.0	elastic parameter at (0, 0) 				
 dlldx=0.0	parameter gradient in x-direction  d(ll)/dx		
 dlldz=0.0	parameter gradient in z-direction  d(ll)/dz		
									
 nfile= 	name of input elastic param. (c66)  nn file, if no name 
		specified then, assume a linear profile with ...	
 nn00=2.0	elastic parameter at (0, 0) 				
 dnndx=0.0	parameter gradient in x-direction  d(nn)/dx		
 dnndz=0.0	parameter gradient in z-direction  d(nn)/dz		
									
 Optimizations:							
 The moving boundary option permits the user to restrict the computations
 of the wavefield to be confined to a specific range of spatial coordinates.
 The boundary of this restricted area moves with the wavefield		
 movebc=0	0 do not use moving boundary optimization		
		1 use moving boundaries					

=head2 USAGE

Examples

	
=cut

my $sufctanismod = {
    _reflxfile     => '',
    _reflyfile     => '',
    _vspxfile      => '',
    _vspyfile      => '',
    _vspzfile      => '',
    _suhead        => '',
    _mt            => '',
    _dofct         => '',
    _eta0          => '',
    _eta           => '',
    _fctxbeg       => '',
    _fctzbeg       => '',
    _fctxend       => '',
    _fctzend       => '',
    _deta0dx       => '',
    _deta0dz       => '',
    _detadx        => '',
    _detadz        => '',
    _order         => '',
    _nt            => '',
    _dt            => '',
    _nx            => '',
    _nz            => '',
    _dx            => '',
    _dz            => '',
    _sx            => '',
    _sz            => '',
    _fpeak         => '',
    _receiverdepth => '',
    _vspnx         => '',
    _verbose       => '',
    _isurf         => '',
    _source        => '',
    _sfile         => '',
    _dfile         => '',
    _rho00         => '',
    _drhodx        => '',
    _drhodz        => '',
    _afile         => '',
    _aa00          => '',
    _daadx         => '',
    _daadz         => '',
    _cfile         => '',
    _cc00          => '',
    _dccdx         => '',
    _dccdz         => '',
    _ffile         => '',
    _ff00          => '',
    _dffdx         => '',
    _dffdz         => '',
    _lfile         => '',
    _ll00          => '',
    _dlldx         => '',
    _dlldz         => '',
    _nfile         => '',
    _nn00          => '',
    _dnndx         => '',
    _dnndz         => '',
    _indexux       => '',
    _indexuy       => '',
    _indexuz       => '',
    _indexv        => '',
    _indexdt       => '',
    _wavelet       => '',
    _impulse       => '',
    _movebc        => '',
    _mbx1          => '',
    _mbx2          => '',
    _mbz1          => '',
    _mbz2          => '',
    _Step          => '',
    _note          => ''
};

# define a value
my $on = 1;

=head2 sub clear

     clear global variables from the memory

=cut

sub clear {
    $sufctanismod->{_reflxfile}     = '';
    $sufctanismod->{_reflyfile}     = '';
    $sufctanismod->{_reflzfile}     = '';
    $sufctanismod->{_vspxfile}      = '';
    $sufctanismod->{_vspyfile}      = '';
    $sufctanismod->{_vspzfile}      = '';
    $sufctanismod->{_suhead}        = '';
    $sufctanismod->{_mt}            = '';
    $sufctanismod->{_dofct}         = '';
    $sufctanismod->{_eta0}          = '';
    $sufctanismod->{_eta}           = '';
    $sufctanismod->{_fctxbeg}       = '';
    $sufctanismod->{_fctzbeg}       = '';
    $sufctanismod->{_fctxend}       = '';
    $sufctanismod->{_fctzend}       = '';
    $sufctanismod->{_deta0dx}       = '';
    $sufctanismod->{_deta0d}        = '';
    $sufctanismod->{_detadx}        = '';
    $sufctanismod->{_detadz}        = '';
    $sufctanismod->{_order}         = '';
    $sufctanismod->{_nt}            = '';
    $sufctanismod->{_dt}            = '';
    $sufctanismod->{_nx}            = '';
    $sufctanismod->{_nz}            = '';
    $sufctanismod->{_dx}            = '';
    $sufctanismod->{_dz}            = '';
    $sufctanismod->{_sx}            = '';
    $sufctanismod->{_sz}            = '';
    $sufctanismod->{_fpeak}         = '';
    $sufctanismod->{_receiverdepth} = '';
    $sufctanismod->{_vspnx}         = '';
    $sufctanismod->{_verbose}       = '';
    $sufctanismod->{_isurf}         = '';
    $sufctanismod->{_source}        = '';
    $sufctanismod->{_sfile}         = '';
    $sufctanismod->{_dfile}         = '';
    $sufctanismod->{_rho00}         = '';
    $sufctanismod->{_afile}         = '';
    $sufctanismod->{_aa00}          = '';
    $sufctanismod->{_daadx}         = '';
    $sufctanismod->{_daadz}         = '';
    $sufctanismod->{_drhodx}        = '';
    $sufctanismod->{_drhodz}        = '';
    $sufctanismod->{_cfile}         = '';
    $sufctanismod->{_cc00}          = '';
    $sufctanismod->{_dccdx}         = '';
    $sufctanismod->{_ffile}         = '';
    $sufctanismod->{_ff00}          = '';
    $sufctanismod->{_dffdx}         = '';
    $sufctanismod->{_dfffdz}        = '';
    $sufctanismod->{_dccdz}         = '';
    $sufctanismod->{_lfile}         = '';
    $sufctanismod->{_ll00}          = '';
    $sufctanismod->{_dlldx}         = '';
    $sufctanismod->{_dlldz}         = '';
    $sufctanismod->{_nfile}         = '';
    $sufctanismod->{_nn00}          = '';
    $sufctanismod->{_dnndx}         = '';
    $sufctanismod->{_dnndz}         = '';
    $sufctanismod->{_mbz2}          = '';
    $sufctanismod->{_indexux}       = '';
    $sufctanismod->{_indexuy}       = '';
    $sufctanismod->{_indexuz}       = '';
    $sufctanismod->{_indexdt}       = '';
    $sufctanismod->{_indexv}        = '';
    $sufctanismod->{_wavelet}       = '';
    $sufctanismod->{_impulse}       = '';
    $sufctanismod->{_movebc}        = '';
    $sufctanismod->{_mbx1}          = '';
    $sufctanismod->{_mbx2}          = '';
    $sufctanismod->{_mbz1}          = '';
    $sufctanismod->{_Step}          = '';
    $sufctanismod->{_note}          = '';
}

=head2 sub reflxfile


=cut

sub reflxfile {
    my ( $variable, $reflxfile ) = @_;
    if ($reflxfile) {
        $sufctanismod->{_reflxfile} = $reflxfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' reflxfile=' . $sufctanismod->{_reflxfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' reflxfile=' . $sufctanismod->{_reflxfile};
    }
}

=head2 sub reflyfile


=cut

sub reflyfile {
    my ( $variable, $reflyfile ) = @_;
    if ($reflyfile) {
        $sufctanismod->{_reflyfile} = $reflyfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' reflyfile=' . $sufctanismod->{_reflyfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' reflyfile=' . $sufctanismod->{_reflyfile};
    }
}

=head2 sub reflzfile


=cut

sub reflzfile {
    my ( $variable, $reflzfile ) = @_;
    if ($reflzfile) {
        $sufctanismod->{_reflzfile} = $reflzfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' reflzfile=' . $sufctanismod->{_reflzfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' reflzfile=' . $sufctanismod->{_reflzfile};
    }
}

=head2 sub vspxfile


=cut

sub vspxfile {
    my ( $variable, $vspxfile ) = @_;
    if ($vspxfile) {
        $sufctanismod->{_vspxfile} = $vspxfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' vspxfile=' . $sufctanismod->{_vspxfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' vspxfile=' . $sufctanismod->{_vspxfile};
    }
}

=head2 sub vspyfile


=cut

sub vspyfile {
    my ( $variable, $vspyfile ) = @_;
    if ($vspyfile) {
        $sufctanismod->{_vspyfile} = $vspyfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' vspyfile=' . $sufctanismod->{_vspyfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' vspyfile=' . $sufctanismod->{_vspyfile};
    }
}

=head2 sub vspzfile


=cut

sub vspzfile {
    my ( $variable, $vspzfile ) = @_;
    if ($vspzfile) {
        $sufctanismod->{_vspzfile} = $vspzfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' vspzfile=' . $sufctanismod->{_vspzfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' vspzfile=' . $sufctanismod->{_vspzfile};
    }
}

=head2 sub suhead


=cut

sub suhead {
    my ( $variable, $suhead ) = @_;
    if ($suhead) {
        $sufctanismod->{_suhead} = $suhead;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' suhead=' . $sufctanismod->{_suhead};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' suhead=' . $sufctanismod->{_suhead};
    }
}

=head2 sub mt


=cut

sub mt {
    my ( $variable, $mt ) = @_;
    if ($mt) {
        $sufctanismod->{_mt} = $mt;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' mt=' . $sufctanismod->{_mt};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' mt=' . $sufctanismod->{_mt};
    }
}

=head2 sub dofct


=cut

sub dofct {
    my ( $variable, $dofct ) = @_;
    if ($dofct) {
        $sufctanismod->{_dofct} = $dofct;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dofct=' . $sufctanismod->{_dofct};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dofct=' . $sufctanismod->{_dofct};
    }
}

=head2 sub eta0


=cut

sub eta0 {
    my ( $variable, $eta0 ) = @_;
    if ($eta0) {
        $sufctanismod->{_eta0} = $eta0;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' eta0=' . $sufctanismod->{_eta0};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' eta0=' . $sufctanismod->{_eta0};
    }
}

=head2 sub eta


=cut

sub eta {
    my ( $variable, $eta ) = @_;
    if ($eta) {
        $sufctanismod->{_eta} = $eta;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' eta=' . $sufctanismod->{_eta};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' eta=' . $sufctanismod->{_eta};
    }
}

=head2 sub fctxbeg


=cut

sub fctxbeg {
    my ( $variable, $fctxbeg ) = @_;
    if ($fctxbeg) {
        $sufctanismod->{_fctxbeg} = $fctxbeg;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' fctxbeg=' . $sufctanismod->{_fctxbeg};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' fctxbeg=' . $sufctanismod->{_fctxbeg};
    }
}

=head2 sub fctzbeg


=cut

sub fctzbeg {
    my ( $variable, $fctzbeg ) = @_;
    if ($fctzbeg) {
        $sufctanismod->{_fctzbeg} = $fctzbeg;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' fctzbeg=' . $sufctanismod->{_fctzbeg};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' fctzbeg=' . $sufctanismod->{_fctzbeg};
    }
}

=head2 sub fctxend


=cut

sub fctxend {
    my ( $variable, $fctxend ) = @_;
    if ($fctxend) {
        $sufctanismod->{_fctxend} = $fctxend;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' fctxend=' . $sufctanismod->{_fctxend};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' fctxend=' . $sufctanismod->{_fctxend};
    }
}

=head2 sub fctzend


=cut

sub fctzend {
    my ( $variable, $fctzend ) = @_;
    if ($fctzend) {
        $sufctanismod->{_fctzend} = $fctzend;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' fctzend=' . $sufctanismod->{_fctzend};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' fctzend=' . $sufctanismod->{_fctzend};
    }
}

=head2 sub deta0dx


=cut

sub deta0dx {
    my ( $variable, $deta0dx ) = @_;
    if ($deta0dx) {
        $sufctanismod->{_deta0dx} = $deta0dx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' deta0dx=' . $sufctanismod->{_deta0dx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' deta0dx=' . $sufctanismod->{_deta0dx};
    }
}

=head2 sub deta0dz


=cut

sub deta0dz {
    my ( $variable, $deta0dz ) = @_;
    if ($deta0dz) {
        $sufctanismod->{_deta0dz} = $deta0dz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' deta0dz=' . $sufctanismod->{_deta0dz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' deta0dz=' . $sufctanismod->{_deta0dz};
    }
}

=head2 sub detadx


=cut

sub detadx {
    my ( $variable, $detadx ) = @_;
    if ($detadx) {
        $sufctanismod->{_detadx} = $detadx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' detadx=' . $sufctanismod->{_detadx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' detadx=' . $sufctanismod->{_detadx};
    }
}

=head2 sub detadz


=cut

sub detadz {
    my ( $variable, $detadz ) = @_;
    if ($detadz) {
        $sufctanismod->{_detadz} = $detadz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' detadz=' . $sufctanismod->{_detadz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' detadz=' . $sufctanismod->{_detadz};
    }
}

=head2 sub order


=cut

sub order {
    my ( $variable, $order ) = @_;
    if ($order) {
        $sufctanismod->{_order} = $order;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' order=' . $sufctanismod->{_order};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' order=' . $sufctanismod->{_order};
    }
}

=head2 sub nt


=cut

sub nt {
    my ( $variable, $nt ) = @_;
    if ($nt) {
        $sufctanismod->{_nt} = $nt;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' nt=' . $sufctanismod->{_nt};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' nt=' . $sufctanismod->{_nt};
    }
}

=head2 sub dt


=cut

sub dt {
    my ( $variable, $dt ) = @_;
    if ($dt) {
        $sufctanismod->{_dt} = $dt;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dt=' . $sufctanismod->{_dt};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dt=' . $sufctanismod->{_dt};
    }
}

=head2 sub nx


=cut

sub nx {
    my ( $variable, $nx ) = @_;
    if ($nx) {
        $sufctanismod->{_nx} = $nx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' nx=' . $sufctanismod->{_nx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' nx=' . $sufctanismod->{_nx};
    }
}

=head2 sub nz


=cut

sub nz {
    my ( $variable, $nz ) = @_;
    if ($nz) {
        $sufctanismod->{_nz} = $nz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' nz=' . $sufctanismod->{_nz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' nz=' . $sufctanismod->{_nz};
    }
}

=head2 sub dx


=cut

sub dx {
    my ( $variable, $dx ) = @_;
    if ($dx) {
        $sufctanismod->{_dx} = $dx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dx=' . $sufctanismod->{_dx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dx=' . $sufctanismod->{_dx};
    }
}

=head2 sub dz


=cut

sub dz {
    my ( $variable, $dz ) = @_;
    if ($dz) {
        $sufctanismod->{_dz} = $dz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dz=' . $sufctanismod->{_dz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dz=' . $sufctanismod->{_dz};
    }
}

=head2 sub sx


=cut

sub sx {
    my ( $variable, $sx ) = @_;
    if ($sx) {
        $sufctanismod->{_sx} = $sx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' sx=' . $sufctanismod->{_sx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' sx=' . $sufctanismod->{_sx};
    }
}

=head2 sub sz


=cut

sub sz {
    my ( $variable, $sz ) = @_;
    if ($sz) {
        $sufctanismod->{_sz} = $sz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' sz=' . $sufctanismod->{_sz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' sz=' . $sufctanismod->{_sz};
    }
}

=head2 sub fpeak


=cut

sub fpeak {
    my ( $variable, $fpeak ) = @_;
    if ($fpeak) {
        $sufctanismod->{_fpeak} = $fpeak;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' fpeak=' . $sufctanismod->{_fpeak};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' fpeak=' . $sufctanismod->{_fpeak};
    }
}

=head2 sub receiverdepth


=cut

sub receiverdepth {
    my ( $variable, $receiverdepth ) = @_;
    if ($receiverdepth) {
        $sufctanismod->{_receiverdepth} = $receiverdepth;
        $sufctanismod->{_Step} =
            $sufctanismod->{_Step}
          . ' receiverdepth='
          . $sufctanismod->{_receiverdepth};
        $sufctanismod->{_note} =
            $sufctanismod->{_note}
          . ' receiverdepth='
          . $sufctanismod->{_receiverdepth};
    }
}

=head2 sub vspnx


=cut

sub vspnx {
    my ( $variable, $vspnx ) = @_;
    if ($vspnx) {
        $sufctanismod->{_vspnx} = $vspnx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' vspnx=' . $sufctanismod->{_vspnx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' vspnx=' . $sufctanismod->{_vspnx};
    }
}

=head2 sub verbose


=cut

sub verbose {
    my ( $variable, $verbose ) = @_;
    if ($verbose) {
        $sufctanismod->{_verbose} = $verbose;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' verbose=' . $sufctanismod->{_verbose};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' verbose=' . $sufctanismod->{_verbose};
    }
}

=head2 sub isurf


=cut

sub isurf {
    my ( $variable, $isurf ) = @_;
    if ($isurf) {
        $sufctanismod->{_isurf} = $isurf;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' isurf=' . $sufctanismod->{_isurf};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' isurf=' . $sufctanismod->{_isurf};
    }
}

=head2 sub source


=cut

sub source {
    my ( $variable, $source ) = @_;
    if ($source) {
        $sufctanismod->{_source} = $source;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' source=' . $sufctanismod->{_source};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' source=' . $sufctanismod->{_source};
    }
}

=head2 sub sfile


=cut

sub sfile {
    my ( $variable, $sfile ) = @_;
    if ($sfile) {
        $sufctanismod->{_sfile} = $sfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' sfile=' . $sufctanismod->{_sfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' sfile=' . $sufctanismod->{_sfile};
    }
}

=head2 sub dfile


=cut

sub dfile {
    my ( $variable, $dfile ) = @_;
    if ($dfile) {
        $sufctanismod->{_dfile} = $dfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dfile=' . $sufctanismod->{_dfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dfile=' . $sufctanismod->{_dfile};
    }
}

=head2 sub rho00


=cut

sub rho00 {
    my ( $variable, $rho00 ) = @_;
    if ($rho00) {
        $sufctanismod->{_rho00} = $rho00;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' rho00=' . $sufctanismod->{_rho00};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' rho00=' . $sufctanismod->{_rho00};
    }
}

=head2 sub drhodx


=cut

sub drhodx {
    my ( $variable, $drhodx ) = @_;
    if ($drhodx) {
        $sufctanismod->{_drhodx} = $drhodx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' drhodx=' . $sufctanismod->{_drhodx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' drhodx=' . $sufctanismod->{_drhodx};
    }
}

=head2 sub drhodz


=cut

sub drhodz {
    my ( $variable, $drhodz ) = @_;
    if ($drhodz) {
        $sufctanismod->{_drhodz} = $drhodz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' drhodz=' . $sufctanismod->{_drhodz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' drhodz=' . $sufctanismod->{_drhodz};
    }
}

=head2 sub cfile


=cut

sub cfile {
    my ( $variable, $cfile ) = @_;
    if ($cfile) {
        $sufctanismod->{_cfile} = $cfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' cfile=' . $sufctanismod->{_cfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' cfile=' . $sufctanismod->{_cfile};
    }
}

=head2 sub afile


=cut

sub afile {
    my ( $variable, $afile ) = @_;
    if ($afile) {
        $sufctanismod->{_afile} = $afile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' afile=' . $sufctanismod->{_afile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' afile=' . $sufctanismod->{_afile};
    }
}

=head2 sub aa00


=cut

sub aa00 {
    my ( $variable, $aa00 ) = @_;
    if ($aa00) {
        $sufctanismod->{_aa00} = $aa00;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' aa00=' . $sufctanismod->{_aa00};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' aa00=' . $sufctanismod->{_aa00};
    }
}

=head2 sub daadx


=cut

sub daadx {
    my ( $variable, $daadx ) = @_;
    if ($daadx) {
        $sufctanismod->{_daadx} = $daadx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' daadx=' . $sufctanismod->{_daadx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' daadx=' . $sufctanismod->{_daadx};
    }
}

=head2 sub daadz


=cut

sub daadz {
    my ( $variable, $daadz ) = @_;
    if ($daadz) {
        $sufctanismod->{_daadz} = $daadz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' daadz=' . $sufctanismod->{_daadz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' daadz=' . $sufctanismod->{_daadz};
    }
}

=head2 sub ffile


=cut

sub ffile {
    my ( $variable, $ffile ) = @_;
    if ($ffile) {
        $sufctanismod->{_ffile} = $ffile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' ffile=' . $sufctanismod->{_ffile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' ffile=' . $sufctanismod->{_ffile};
    }
}

=head2 sub ff00


=cut

sub ff00 {
    my ( $variable, $ff00 ) = @_;
    if ($ff00) {
        $sufctanismod->{_ff00} = $ff00;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' ff00=' . $sufctanismod->{_ff00};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' ff00=' . $sufctanismod->{_ff00};
    }
}

=head2 sub dffdx


=cut

sub dffdx {
    my ( $variable, $dffdx ) = @_;
    if ($dffdx) {
        $sufctanismod->{_dffdx} = $dffdx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dffdx=' . $sufctanismod->{_dffdx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dffdx=' . $sufctanismod->{_dffdx};
    }
}

=head2 sub dffdz


=cut

sub dffdz {
    my ( $variable, $dffdz ) = @_;
    if ($dffdz) {
        $sufctanismod->{_dffdz} = $dffdz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dffdz=' . $sufctanismod->{_dffdz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dffdz=' . $sufctanismod->{_dffdz};
    }
}

=head2 sub lfile


=cut

sub lfile {
    my ( $variable, $lfile ) = @_;
    if ($lfile) {
        $sufctanismod->{_lfile} = $lfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' lfile=' . $sufctanismod->{_lfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' lfile=' . $sufctanismod->{_lfile};
    }
}

=head2 sub ll00


=cut

sub ll00 {
    my ( $variable, $ll00 ) = @_;
    if ($ll00) {
        $sufctanismod->{_ll00} = $ll00;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' ll00=' . $sufctanismod->{_ll00};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' ll00=' . $sufctanismod->{_ll00};
    }
}

=head2 sub dlldx


=cut

sub dlldx {
    my ( $variable, $dlldx ) = @_;
    if ($dlldx) {
        $sufctanismod->{_dlldx} = $dlldx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dlldx=' . $sufctanismod->{_dlldx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dlldx=' . $sufctanismod->{_dlldx};
    }
}

=head2 sub dlldz


=cut

sub dlldz {
    my ( $variable, $dlldz ) = @_;
    if ($dlldz) {
        $sufctanismod->{_dlldz} = $dlldz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dlldz=' . $sufctanismod->{_dlldz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dlldz=' . $sufctanismod->{_dlldz};
    }
}

=head2 sub nfile


=cut

sub nfile {
    my ( $variable, $nfile ) = @_;
    if ($nfile) {
        $sufctanismod->{_nfile} = $nfile;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' nfile=' . $sufctanismod->{_nfile};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' nfile=' . $sufctanismod->{_nfile};
    }
}

=head2 sub nn00


=cut

sub nn00 {
    my ( $variable, $nn00 ) = @_;
    if ($nn00) {
        $sufctanismod->{_nn00} = $nn00;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' nn00=' . $sufctanismod->{_nn00};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' nn00=' . $sufctanismod->{_nn00};
    }
}

=head2 sub dnndx


=cut

sub dnndx {
    my ( $variable, $dnndx ) = @_;
    if ($dnndx) {
        $sufctanismod->{_dnndx} = $dnndx;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dnndx=' . $sufctanismod->{_dnndx};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dnndx=' . $sufctanismod->{_dnndx};
    }
}

=head2 sub dnndz


=cut

sub dnndz {
    my ( $variable, $dnndz ) = @_;
    if ($dnndz) {
        $sufctanismod->{_dnndz} = $dnndz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' dnndz=' . $sufctanismod->{_dnndz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' dnndz=' . $sufctanismod->{_dnndz};
    }
}

=head2 sub indexux


=cut

sub indexux {
    my ( $variable, $indexux ) = @_;
    if ($indexux) {
        $sufctanismod->{_indexux} = $indexux;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' indexux=' . $sufctanismod->{_indexux};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' indexux=' . $sufctanismod->{_indexux};
    }
}

=head2 sub indexuy


=cut

sub indexuy {
    my ( $variable, $indexuy ) = @_;
    if ($indexuy) {
        $sufctanismod->{_indexuy} = $indexuy;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' indexuy=' . $sufctanismod->{_indexuy};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' indexuy=' . $sufctanismod->{_indexuy};
    }
}

=head2 sub indexuz


=cut

sub indexuz {
    my ( $variable, $indexuz ) = @_;
    if ($indexuz) {
        $sufctanismod->{_indexuz} = $indexuz;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' indexuz=' . $sufctanismod->{_indexuz};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' indexuz=' . $sufctanismod->{_indexuz};
    }
}

=head2 sub indexdt


=cut

sub indexdt {
    my ( $variable, $indexdt ) = @_;
    $sufctanismod->{_indexdt} = $indexdt;
    $sufctanismod->{_Step} =
      $sufctanismod->{_Step} . ' indexdt=' . $sufctanismod->{_indexdt};
    $sufctanismod->{_note} =
      $sufctanismod->{_note} . ' indexdt=' . $sufctanismod->{_indexdt};
}

=head2 sub indexv


=cut

sub indexv {
    my ( $variable, $indexv ) = @_;
    if ($indexv) {
        $sufctanismod->{_indexv} = $indexv;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' indexv=' . $sufctanismod->{_indexv};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' indexv=' . $sufctanismod->{_indexv};
    }
}

=head2 sub wavelet


=cut

sub wavelet {
    my ( $variable, $wavelet ) = @_;
    if ($wavelet) {
        $sufctanismod->{_wavelet} = $wavelet;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' wavelet=' . $sufctanismod->{_wavelet};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' wavelet=' . $sufctanismod->{_wavelet};
    }
}

=head2 sub impulse


=cut

sub impulse {
    my ( $variable, $impulse ) = @_;
    if ($impulse) {
        $sufctanismod->{_impulse} = $impulse;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' impulse=' . $sufctanismod->{_impulse};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' impulse=' . $sufctanismod->{_impulse};
    }
}

=head2 sub mbx1


=cut

sub mbx1 {
    my ( $variable, $mbx1 ) = @_;
    if ($mbx1) {
        $sufctanismod->{_mbx1} = $mbx1;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' mbx1=' . $sufctanismod->{_mbx1};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' mbx1=' . $sufctanismod->{_mbx1};
    }
}

=head2 sub mbx2


=cut

sub mbx2 {
    my ( $variable, $mbx2 ) = @_;
    if ($mbx2) {
        $sufctanismod->{_mbx2} = $mbx2;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' mbx2=' . $sufctanismod->{_mbx2};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' mbx2=' . $sufctanismod->{_mbx2};
    }
}

=head2 sub mbz1


=cut

sub mbz1 {
    my ( $variable, $mbz1 ) = @_;
    if ($mbz1) {
        $sufctanismod->{_mbz1} = $mbz1;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' mbz1=' . $sufctanismod->{_mbz1};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' mbz1=' . $sufctanismod->{_mbz1};
    }
}

=head2 sub mbz2


=cut

sub mbz2 {
    my ( $variable, $mbz2 ) = @_;
    if ($mbz2) {
        $sufctanismod->{_mbz2} = $mbz2;
        $sufctanismod->{_Step} =
          $sufctanismod->{_Step} . ' mbz2=' . $sufctanismod->{_mbz2};
        $sufctanismod->{_note} =
          $sufctanismod->{_note} . ' mbz2=' . $sufctanismod->{_mbz2};
    }
}

=head2 sub movebc


=cut

sub movebc {
    my ( $variable, $movebc ) = @_;
    $sufctanismod->{_movebc} = $movebc;
    $sufctanismod->{_Step} =
      $sufctanismod->{_Step} . ' movebc=' . $sufctanismod->{_movebc};
    $sufctanismod->{_note} =
      $sufctanismod->{_note} . ' movebc=' . $sufctanismod->{_movebc};
}

=head2 sub note 

 Internal record of processes

=cut

sub note {
    my ( $variable, $note ) = @_;
    $sufctanismod->{_note} = $sufctanismod->{_note};
    return $sufctanismod->{_note};
}

=head2 sub Step 

 Assembles variables with correct
 syntax

=cut

sub Step {
    my ( $variable, $Step ) = @_;
    $sufctanismod->{_Step} = 'sufctanismod ' . $sufctanismod->{_Step};
    $sufctanismod->{_note} = 'sufctanismod ' . $sufctanismod->{_note};
    return $sufctanismod->{_Step};
}

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
    my ($self) = @_;

    # only file_name : index=6
    my $max_index = 6;

    return ($max_index);
}

1;
