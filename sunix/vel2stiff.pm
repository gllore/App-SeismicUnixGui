package vel2stiff;
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: vel2stiff 
 AUTHOR: Juan Lorenzo
 DATE: July 22 2016 
 DESCRIPTION convert a velocity grid file
                     a density grid filei
                     and a Thomsen or Sayers grid file
                     an elastic stiffness grid   
             
 Version 1
 Notes: 
 Package name is the same as the file name
 Moose is a package that allows an object-oriented
 syntax to organizing your programs

=head2  Notes from Seismic Unix

 VEL2STIFF - Transforms VELocities, densities, and Thomsen or Sayers   
		parameters to elastic STIFFnesses 			
 									
 vel2stiff  [Required parameters] [Optional Parameters] > stdout	
 									
 Required parameters:							
 vpfile=	file with P-wave velocities				
 vsfile=	file with S-wave velocities				
 rhofile=	file with densities					
									
 Optional Parameters:							
 epsfile=	file with Thomsen/Sayers epsilon			
 deltafile=	file with Thomsen/Sayers delta			 	
 gammafile=	file with Thomsen/Sayers gamma			 	
 phi_file=	angle of axis of symmetry from vertical (radians)	
									
 c11_file=c11_file     output filename for c11 values                  
 c13_file=c13_file     output filename for c13 values                  
 c15_file=c15_file     output filename for c15 values                  
 c33_file=c33_file     output filename for c33 values                  
 c35_file=c35_file     output filename for c35 values                  
 c44_file=c44_file     output filename for c44 values                  
 c55_file=c55_file     output filename for c55 values                  
 c66_file=c66_file     output filename for c66 values                  
 									
 paramtype=1  (1) Thomsen parameters, (0) Sayers parameters(see below) 
 									
 nx=101	number of x samples 2nd (slow) dimension		
 nz=101	number of z samples 1st (fast) dimension		
 									
 Notes: 								
 Transforms velocities, density and Thomsen/Sayers parameters		
 epsilon, delta, and gamma into elastic stiffness coefficients.	
 									
 If only P-wave, S-wave velocities and density is given as input,	
 the model is assumed to be isotropic.					
 									
 If files containing Thomsen/Sayers parameters are given, the model	
 will be assumed to have VTI symmetry.		 			
 									
 All input files  vpfile, vsfile, rhofile etc. are assumed to consist  
 only of C style binary floating point numbers representing the        
 corresponding  material values of vp, vs, rho etc. Similarly, the output
 files consist of the coresponding stiffnesses as C style binary floats. 
 If the output files are to be used as input for a modeling program,   
 such as suea2df, then further, the contents are assumed be arrays of  
 floating point numbers of the form of   Array[n2][n1], where the fast 
 dimension, dimension 1, represents depth.       



=head2 USAGE 1 

 Example

        $vel2stiff->vpfile();
	$vel2stiff->vsfile();
	$vel2stiff->rhofile();
	$vel2stiff->epsfile();
	$vel2stiff->deltafile();
	$vel2stiff->gammafile();
	$vel2stiff->phi_file();
	$vel2stiff->c11_file();
	$vel2stiff->c13_file();
	$vel2stiff->c15_file();
        $vel2stiff->c33_file();
        $vel2stiff->c35_file();
        $vel2stiff->c44_file();
        $vel2stiff->c55_file();
	$vel2stiff->c66_file();
	$vel2stiff->paramtype();
	$vel2stiff->nx();
	$vel2stiff->nz();
        $vel2stiff->Step();


=cut

my $vel2stiff = {
    _vpfile    => '',
    _vsfile    => '',
    _rhofile   => '',
    _epsfile   => '',
    _deltafile => '',
    _gammafile => '',
    _phi_file  => '',
    _c11_file  => '',
    _c13_file  => '',
    _c15_file  => '',
    _c33_file  => '',
    _c35_file  => '',
    _c44_file  => '',
    _c55_file  => '',
    _c66_file  => '',
    _paramtype => '',
    _nx        => '',
    _nz        => '',
    _note      => '',
    _Step      => ''
};

=head2 Notes

   Create mesh for finite difference modeling 

=head2 sub clear:

 clean hash of its values

=cut

sub clear {
    $vel2stiff->{_vpfile}    = '';
    $vel2stiff->{_vsfile}    = '';
    $vel2stiff->{_rhofile}   = '';
    $vel2stiff->{_epsfile}   = '';
    $vel2stiff->{_deltafile} = '';
    $vel2stiff->{_gammafile} = '';
    $vel2stiff->{_phi_file}  = '';
    $vel2stiff->{_c11_file}  = '';
    $vel2stiff->{_c13_file}  = '';
    $vel2stiff->{_c15_file}  = '';
    $vel2stiff->{_c33_file}  = '';
    $vel2stiff->{_c35_file}  = '';
    $vel2stiff->{_c44_file}  = '';
    $vel2stiff->{_c55_file}  = '';
    $vel2stiff->{_c66_file}  = '';
    $vel2stiff->{_paramtype} = '';
    $vel2stiff->{_nx}        = '';
    $vel2stiff->{_nz}        = '';
    $vel2stiff->{_note}      = '';
    $vel2stiff->{_Step}      = '';
}

=head2 subroutine vpfile

=cut

sub vpfile {
    my ( $variable, $vpfile ) = @_;
    if ($vpfile) {
        $vel2stiff->{_vpfile} = $vpfile;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' vpfile=' . $vel2stiff->{_vpfile};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' vpfile=' . $vel2stiff->{_vpfile};
    }
}

=head2 subroutine vsfile

=cut

sub vsfile {
    my ( $variable, $vsfile ) = @_;
    if ($vsfile) {
        $vel2stiff->{_vsfile} = $vsfile;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' vsfile=' . $vel2stiff->{_vsfile};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' vsfile=' . $vel2stiff->{_vsfile};
    }
}

=head2 subroutine rhofile

=cut

sub rhofile {
    my ( $variable, $rhofile ) = @_;
    if ($rhofile) {
        $vel2stiff->{_rhofile} = $rhofile;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' rhofile=' . $vel2stiff->{_rhofile};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' rhofile=' . $vel2stiff->{_rhofile};
    }
}

=head2 subroutine epsfile

=cut

sub epsfile {
    my ( $variable, $epsfile ) = @_;
    if ($epsfile) {
        $vel2stiff->{_epsfile} = $epsfile;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' epsfile=' . $vel2stiff->{_epsfile};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' epsfile=' . $vel2stiff->{_epsfile};
    }
}

=head2 subroutine deltafile

=cut

sub deltafile {
    my ( $variable, $deltafile ) = @_;
    if ($deltafile) {
        $vel2stiff->{_deltafile} = $deltafile;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' deltafile=' . $vel2stiff->{_deltafile};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' deltafile=' . $vel2stiff->{_deltafile};
    }
}

=head2 subroutine gammafile

=cut

sub gammafile {
    my ( $variable, $gammafile ) = @_;
    if ($gammafile) {
        $vel2stiff->{_gammafile} = $gammafile;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' gammafile=' . $vel2stiff->{_gammafile};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' gammafile=' . $vel2stiff->{_gammafile};
    }
}

=head2 subroutine phi_file

=cut

sub phi_file {
    my ( $variable, $phi_file ) = @_;
    if ($phi_file) {
        $vel2stiff->{_phi_file} = $phi_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' phi_file=' . $vel2stiff->{_phi_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' phi_file=' . $vel2stiff->{_phi_file};
    }
}

=head2 subroutine c11_file

=cut

sub c11_file {
    my ( $variable, $c11_file ) = @_;
    if ($c11_file) {
        $vel2stiff->{_c11_file} = $c11_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c11_file=' . $vel2stiff->{_c11_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c11_file=' . $vel2stiff->{_c11_file};
    }
}

=head2 subroutine c13_file

=cut

sub c13_file {
    my ( $variable, $c13_file ) = @_;
    if ($c13_file) {
        $vel2stiff->{_c13_file} = $c13_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c13_file=' . $vel2stiff->{_c13_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c13_file=' . $vel2stiff->{_c15_file};
    }
}

=head2 subroutine c15_file

=cut

sub c15_file {
    my ( $variable, $c15_file ) = @_;
    if ($c15_file) {
        $vel2stiff->{_c15_file} = $c15_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c15_file=' . $vel2stiff->{_c15_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c15_file=' . $vel2stiff->{_c15_file};
    }
}

=head2 subroutine c33_file

=cut

sub c33_file {
    my ( $variable, $c33_file ) = @_;
    if ($c33_file) {
        $vel2stiff->{_c33_file} = $c33_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c33_file=' . $vel2stiff->{_c33_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c33_file=' . $vel2stiff->{_c33_file};
    }
}

=head2 subroutine c35_file

=cut

sub c35_file {
    my ( $variable, $c35_file ) = @_;
    if ($c35_file) {
        $vel2stiff->{_c35_file} = $c35_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c35_file=' . $vel2stiff->{_c35_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c35_file=' . $vel2stiff->{_c35_file};
    }
}

=head2 subroutine c44_file

=cut

sub c44_file {
    my ( $variable, $c44_file ) = @_;
    if ($c44_file) {
        $vel2stiff->{_c44_file} = $c44_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c44_file=' . $vel2stiff->{_c44_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c44_file=' . $vel2stiff->{_c44_file};
    }
}

=head2 subroutine c55_file

=cut

sub c55_file {
    my ( $variable, $c55_file ) = @_;
    if ($c55_file) {
        $vel2stiff->{_c55_file} = $c55_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c55_file=' . $vel2stiff->{_c55_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c55_file=' . $vel2stiff->{_c55_file};
    }
}

=head2 subroutine c66_file

=cut

sub c66_file {
    my ( $variable, $c66_file ) = @_;
    if ($c66_file) {
        $vel2stiff->{_c66_file} = $c66_file;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' c66_file=' . $vel2stiff->{_c66_file};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' c66_file=' . $vel2stiff->{_c66_file};
    }
}

=head2 subroutine paramtype

=cut

sub paramtype {
    my ( $variable, $paramtype ) = @_;
    if ($paramtype) {
        $vel2stiff->{_paramtype} = $paramtype;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' paramtype=' . $vel2stiff->{_paramtype};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' paramtype=' . $vel2stiff->{_paramtype};
    }
}

=head2 subroutine nx

=cut

sub nx {
    my ( $variable, $nx ) = @_;
    if ($nx) {
        $vel2stiff->{_nx} = $nx;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' nx=' . $vel2stiff->{_nx};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' nx=' . $vel2stiff->{_nx};
    }
}

=head2 subroutine nz

=cut

sub nz {
    my ( $variable, $nz ) = @_;
    if ($nz) {
        $vel2stiff->{_nz} = $nz;
        $vel2stiff->{_Step} =
          $vel2stiff->{_Step} . ' nz=' . $vel2stiff->{_nz};
        $vel2stiff->{_note} =
          $vel2stiff->{_note} . ' nz=' . $vel2stiff->{_nz};
    }
}

=head2 subroutine  note

=cut

sub note {
    my ( $variable, $note ) = @_;
    $vel2stiff->{_note} = 'vel2stiff ' . $vel2stiff->{_note};
    return $vel2stiff->{_note};
}

=head2 subroutine  Step

=cut

sub Step {

    $vel2stiff->{_Step} = 'vel2stiff ' . $vel2stiff->{_Step};
    return $vel2stiff->{_Step};
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
