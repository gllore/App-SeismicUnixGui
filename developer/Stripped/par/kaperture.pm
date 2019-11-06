 package kaperture;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  KAPERTURE - generate the k domain of a line scatterer for a seismic array
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 KAPERTURE - generate the k domain of a line scatterer for a seismic array

 kaperture [optional parameters] >stdout 				

 Optional parameters							
 	x0=1000		point scatterer location			
 	z0=1000		point scatterer location			
 	nshot=1		number of shots					
 	sxmin=0		first shot location				
 	szmin=0		first shot location				
 	dsx=100		x-steps in shot location			
 	dsz=0		z-steps in shot location			
 	ngeo=1		number of receivers				
 	gxmin=0		first receiver location				
 	gzmin=0		first receiver location				
 	dgx=100		x-steps in receiver location			
 	dgz=0		z-steps in receiver location			
 	fnyq=125	Nyquist frequency  (Hz)				
 	fmax=125	maximum frequency  (Hz)				
 	fmin=5		minimum frequency  (Hz)				
 	nfreq=2		number of frequencies   			
 	both=0		= 1 gives negative freqs too			
 	nstep=60	points on Nyquist circle			
 	c=5000		speed						
 	outpar=/dev/tty output parameter file, contains:		
 				xmin, xmax, ymin, ymax 			
 				and npairs (needed for psgraph or xgraph)
 			other choices for outpar are: /dev/tty,		
 			/dev/stderr, or a name of a disk file		
 Notes:								
       nfreq=1 produces fmin						
       nstep=0 suppresses the Nyquist circle				
 				and npairs				
 Examples:								

 Default case: both=0 nfreq=2					

 	kaperture nshot=NSHOT ngeo=NGEO nstep=NSTEP |			
 	psgraph	n=NPAIRS,NSTEP mark=1,0 marksize=1,0 linewidth=0,1 |...
 		WHERE: NPAIRS=NSHOT*NGEO				

 Other cases: 								

 both=0 nfreq=NFREQ > 2						
 	kaperture both=0 nfreq=NFREQ nshot=NSHOT ngeo=NGEO nstep=NSTEP |
 	psgraph	n=NPAIRS,NSTEP mark=1,0 marksize=1,0 linewidth=0,1 |...	
 		WHERE: NPAIRS=NFREQ*NSHOT*NGEO				

 both=1 nfreq=NFREQ > 2						
 	kaperture both=1 nfreq=NFREQ nshot=NSHOT ngeo=NGEO nstep=NSTEP |
 	psgraph	n=NPAIRS,NSTEP mark=1,0 marksize=1,0 linewidth=0,1 |...	
 		 WHERE: NPAIRS=NFREQ*NSHOT*NGEO*2			

 When in doubt to the size of NPAIRS, redirect output of kaperture to	
 /dev/tty the first time to get npairs=:				
		 kaperture [optional parameters] > /dev/tty		
=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $kaperture		= {
		_NPAIRS					=> '',
		_both					=> '',
		_c					=> '',
		_dgx					=> '',
		_dgz					=> '',
		_dsx					=> '',
		_dsz					=> '',
		_fmax					=> '',
		_fmin					=> '',
		_fnyq					=> '',
		_gxmin					=> '',
		_gzmin					=> '',
		_n					=> '',
		_nfreq					=> '',
		_ngeo					=> '',
		_npairs					=> '',
		_nshot					=> '',
		_nstep					=> '',
		_outpar					=> '',
		_sxmin					=> '',
		_szmin					=> '',
		_x0					=> '',
		_z0					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$kaperture->{_Step}     = 'kaperture'.$kaperture->{_Step};
	return ( $kaperture->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$kaperture->{_note}     = 'kaperture'.$kaperture->{_note};
	return ( $kaperture->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$kaperture->{_NPAIRS}			= '';
		$kaperture->{_both}			= '';
		$kaperture->{_c}			= '';
		$kaperture->{_dgx}			= '';
		$kaperture->{_dgz}			= '';
		$kaperture->{_dsx}			= '';
		$kaperture->{_dsz}			= '';
		$kaperture->{_fmax}			= '';
		$kaperture->{_fmin}			= '';
		$kaperture->{_fnyq}			= '';
		$kaperture->{_gxmin}			= '';
		$kaperture->{_gzmin}			= '';
		$kaperture->{_n}			= '';
		$kaperture->{_nfreq}			= '';
		$kaperture->{_ngeo}			= '';
		$kaperture->{_npairs}			= '';
		$kaperture->{_nshot}			= '';
		$kaperture->{_nstep}			= '';
		$kaperture->{_outpar}			= '';
		$kaperture->{_sxmin}			= '';
		$kaperture->{_szmin}			= '';
		$kaperture->{_x0}			= '';
		$kaperture->{_z0}			= '';
		$kaperture->{_Step}			= '';
		$kaperture->{_note}			= '';
 }


=head2 sub NPAIRS 


=cut

 sub NPAIRS {

	my ( $self,$NPAIRS )		= @_;
	if ( $NPAIRS ne $empty_string ) {

		$kaperture->{_NPAIRS}		= $NPAIRS;
		$kaperture->{_note}		= $kaperture->{_note}.' NPAIRS='.$kaperture->{_NPAIRS};
		$kaperture->{_Step}		= $kaperture->{_Step}.' NPAIRS='.$kaperture->{_NPAIRS};

	} else { 
		print("kaperture, NPAIRS, missing NPAIRS,\n");
	 }
 }


=head2 sub both 


=cut

 sub both {

	my ( $self,$both )		= @_;
	if ( $both ne $empty_string ) {

		$kaperture->{_both}		= $both;
		$kaperture->{_note}		= $kaperture->{_note}.' both='.$kaperture->{_both};
		$kaperture->{_Step}		= $kaperture->{_Step}.' both='.$kaperture->{_both};

	} else { 
		print("kaperture, both, missing both,\n");
	 }
 }


=head2 sub c 


=cut

 sub c {

	my ( $self,$c )		= @_;
	if ( $c ne $empty_string ) {

		$kaperture->{_c}		= $c;
		$kaperture->{_note}		= $kaperture->{_note}.' c='.$kaperture->{_c};
		$kaperture->{_Step}		= $kaperture->{_Step}.' c='.$kaperture->{_c};

	} else { 
		print("kaperture, c, missing c,\n");
	 }
 }


=head2 sub dgx 


=cut

 sub dgx {

	my ( $self,$dgx )		= @_;
	if ( $dgx ne $empty_string ) {

		$kaperture->{_dgx}		= $dgx;
		$kaperture->{_note}		= $kaperture->{_note}.' dgx='.$kaperture->{_dgx};
		$kaperture->{_Step}		= $kaperture->{_Step}.' dgx='.$kaperture->{_dgx};

	} else { 
		print("kaperture, dgx, missing dgx,\n");
	 }
 }


=head2 sub dgz 


=cut

 sub dgz {

	my ( $self,$dgz )		= @_;
	if ( $dgz ne $empty_string ) {

		$kaperture->{_dgz}		= $dgz;
		$kaperture->{_note}		= $kaperture->{_note}.' dgz='.$kaperture->{_dgz};
		$kaperture->{_Step}		= $kaperture->{_Step}.' dgz='.$kaperture->{_dgz};

	} else { 
		print("kaperture, dgz, missing dgz,\n");
	 }
 }


=head2 sub dsx 


=cut

 sub dsx {

	my ( $self,$dsx )		= @_;
	if ( $dsx ne $empty_string ) {

		$kaperture->{_dsx}		= $dsx;
		$kaperture->{_note}		= $kaperture->{_note}.' dsx='.$kaperture->{_dsx};
		$kaperture->{_Step}		= $kaperture->{_Step}.' dsx='.$kaperture->{_dsx};

	} else { 
		print("kaperture, dsx, missing dsx,\n");
	 }
 }


=head2 sub dsz 


=cut

 sub dsz {

	my ( $self,$dsz )		= @_;
	if ( $dsz ne $empty_string ) {

		$kaperture->{_dsz}		= $dsz;
		$kaperture->{_note}		= $kaperture->{_note}.' dsz='.$kaperture->{_dsz};
		$kaperture->{_Step}		= $kaperture->{_Step}.' dsz='.$kaperture->{_dsz};

	} else { 
		print("kaperture, dsz, missing dsz,\n");
	 }
 }


=head2 sub fmax 


=cut

 sub fmax {

	my ( $self,$fmax )		= @_;
	if ( $fmax ne $empty_string ) {

		$kaperture->{_fmax}		= $fmax;
		$kaperture->{_note}		= $kaperture->{_note}.' fmax='.$kaperture->{_fmax};
		$kaperture->{_Step}		= $kaperture->{_Step}.' fmax='.$kaperture->{_fmax};

	} else { 
		print("kaperture, fmax, missing fmax,\n");
	 }
 }


=head2 sub fmin 


=cut

 sub fmin {

	my ( $self,$fmin )		= @_;
	if ( $fmin ne $empty_string ) {

		$kaperture->{_fmin}		= $fmin;
		$kaperture->{_note}		= $kaperture->{_note}.' fmin='.$kaperture->{_fmin};
		$kaperture->{_Step}		= $kaperture->{_Step}.' fmin='.$kaperture->{_fmin};

	} else { 
		print("kaperture, fmin, missing fmin,\n");
	 }
 }


=head2 sub fnyq 


=cut

 sub fnyq {

	my ( $self,$fnyq )		= @_;
	if ( $fnyq ne $empty_string ) {

		$kaperture->{_fnyq}		= $fnyq;
		$kaperture->{_note}		= $kaperture->{_note}.' fnyq='.$kaperture->{_fnyq};
		$kaperture->{_Step}		= $kaperture->{_Step}.' fnyq='.$kaperture->{_fnyq};

	} else { 
		print("kaperture, fnyq, missing fnyq,\n");
	 }
 }


=head2 sub gxmin 


=cut

 sub gxmin {

	my ( $self,$gxmin )		= @_;
	if ( $gxmin ne $empty_string ) {

		$kaperture->{_gxmin}		= $gxmin;
		$kaperture->{_note}		= $kaperture->{_note}.' gxmin='.$kaperture->{_gxmin};
		$kaperture->{_Step}		= $kaperture->{_Step}.' gxmin='.$kaperture->{_gxmin};

	} else { 
		print("kaperture, gxmin, missing gxmin,\n");
	 }
 }


=head2 sub gzmin 


=cut

 sub gzmin {

	my ( $self,$gzmin )		= @_;
	if ( $gzmin ne $empty_string ) {

		$kaperture->{_gzmin}		= $gzmin;
		$kaperture->{_note}		= $kaperture->{_note}.' gzmin='.$kaperture->{_gzmin};
		$kaperture->{_Step}		= $kaperture->{_Step}.' gzmin='.$kaperture->{_gzmin};

	} else { 
		print("kaperture, gzmin, missing gzmin,\n");
	 }
 }


=head2 sub n 


=cut

 sub n {

	my ( $self,$n )		= @_;
	if ( $n ne $empty_string ) {

		$kaperture->{_n}		= $n;
		$kaperture->{_note}		= $kaperture->{_note}.' n='.$kaperture->{_n};
		$kaperture->{_Step}		= $kaperture->{_Step}.' n='.$kaperture->{_n};

	} else { 
		print("kaperture, n, missing n,\n");
	 }
 }


=head2 sub nfreq 


=cut

 sub nfreq {

	my ( $self,$nfreq )		= @_;
	if ( $nfreq ne $empty_string ) {

		$kaperture->{_nfreq}		= $nfreq;
		$kaperture->{_note}		= $kaperture->{_note}.' nfreq='.$kaperture->{_nfreq};
		$kaperture->{_Step}		= $kaperture->{_Step}.' nfreq='.$kaperture->{_nfreq};

	} else { 
		print("kaperture, nfreq, missing nfreq,\n");
	 }
 }


=head2 sub ngeo 


=cut

 sub ngeo {

	my ( $self,$ngeo )		= @_;
	if ( $ngeo ne $empty_string ) {

		$kaperture->{_ngeo}		= $ngeo;
		$kaperture->{_note}		= $kaperture->{_note}.' ngeo='.$kaperture->{_ngeo};
		$kaperture->{_Step}		= $kaperture->{_Step}.' ngeo='.$kaperture->{_ngeo};

	} else { 
		print("kaperture, ngeo, missing ngeo,\n");
	 }
 }


=head2 sub npairs 


=cut

 sub npairs {

	my ( $self,$npairs )		= @_;
	if ( $npairs ne $empty_string ) {

		$kaperture->{_npairs}		= $npairs;
		$kaperture->{_note}		= $kaperture->{_note}.' npairs='.$kaperture->{_npairs};
		$kaperture->{_Step}		= $kaperture->{_Step}.' npairs='.$kaperture->{_npairs};

	} else { 
		print("kaperture, npairs, missing npairs,\n");
	 }
 }


=head2 sub nshot 


=cut

 sub nshot {

	my ( $self,$nshot )		= @_;
	if ( $nshot ne $empty_string ) {

		$kaperture->{_nshot}		= $nshot;
		$kaperture->{_note}		= $kaperture->{_note}.' nshot='.$kaperture->{_nshot};
		$kaperture->{_Step}		= $kaperture->{_Step}.' nshot='.$kaperture->{_nshot};

	} else { 
		print("kaperture, nshot, missing nshot,\n");
	 }
 }


=head2 sub nstep 


=cut

 sub nstep {

	my ( $self,$nstep )		= @_;
	if ( $nstep ne $empty_string ) {

		$kaperture->{_nstep}		= $nstep;
		$kaperture->{_note}		= $kaperture->{_note}.' nstep='.$kaperture->{_nstep};
		$kaperture->{_Step}		= $kaperture->{_Step}.' nstep='.$kaperture->{_nstep};

	} else { 
		print("kaperture, nstep, missing nstep,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$kaperture->{_outpar}		= $outpar;
		$kaperture->{_note}		= $kaperture->{_note}.' outpar='.$kaperture->{_outpar};
		$kaperture->{_Step}		= $kaperture->{_Step}.' outpar='.$kaperture->{_outpar};

	} else { 
		print("kaperture, outpar, missing outpar,\n");
	 }
 }


=head2 sub sxmin 


=cut

 sub sxmin {

	my ( $self,$sxmin )		= @_;
	if ( $sxmin ne $empty_string ) {

		$kaperture->{_sxmin}		= $sxmin;
		$kaperture->{_note}		= $kaperture->{_note}.' sxmin='.$kaperture->{_sxmin};
		$kaperture->{_Step}		= $kaperture->{_Step}.' sxmin='.$kaperture->{_sxmin};

	} else { 
		print("kaperture, sxmin, missing sxmin,\n");
	 }
 }


=head2 sub szmin 


=cut

 sub szmin {

	my ( $self,$szmin )		= @_;
	if ( $szmin ne $empty_string ) {

		$kaperture->{_szmin}		= $szmin;
		$kaperture->{_note}		= $kaperture->{_note}.' szmin='.$kaperture->{_szmin};
		$kaperture->{_Step}		= $kaperture->{_Step}.' szmin='.$kaperture->{_szmin};

	} else { 
		print("kaperture, szmin, missing szmin,\n");
	 }
 }


=head2 sub x0 


=cut

 sub x0 {

	my ( $self,$x0 )		= @_;
	if ( $x0 ne $empty_string ) {

		$kaperture->{_x0}		= $x0;
		$kaperture->{_note}		= $kaperture->{_note}.' x0='.$kaperture->{_x0};
		$kaperture->{_Step}		= $kaperture->{_Step}.' x0='.$kaperture->{_x0};

	} else { 
		print("kaperture, x0, missing x0,\n");
	 }
 }


=head2 sub z0 


=cut

 sub z0 {

	my ( $self,$z0 )		= @_;
	if ( $z0 ne $empty_string ) {

		$kaperture->{_z0}		= $z0;
		$kaperture->{_note}		= $kaperture->{_note}.' z0='.$kaperture->{_z0};
		$kaperture->{_Step}		= $kaperture->{_Step}.' z0='.$kaperture->{_z0};

	} else { 
		print("kaperture, z0, missing z0,\n");
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