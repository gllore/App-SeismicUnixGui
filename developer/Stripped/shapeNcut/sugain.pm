package sugain;

=head2 SYNOPSIS

PACKAGE NAME: 

AUTHOR:  

DATE:

DESCRIPTION:

Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES
 SUGAIN - apply various types of gain				  	



 sugain <stdin >stdout [optional parameters]			   	



 Required parameters:						  	

	none (no-op)						    	



 Optional parameters:						  	

	panel=0	        =1  gain whole data set (vs. trace by trace)	

	tpow=0.0	multiply data by t^tpow			 	

	epow=0.0	multiply data by exp(epow*t)		    	

	etpow=1.0	multiply data by exp(epow*t^etpow)	    	

	gpow=1.0	take signed gpowth power of scaled data	 	

	agc=0	   flag; 1 = do automatic gain control	     		

	gagc=0	  flag; 1 = ... with gaussian taper			

	wagc=0.5	agc window in seconds (use if agc=1 or gagc=1)  

	trap=none	zero any value whose magnitude exceeds trapval  

	clip=none	clip any value whose magnitude exceeds clipval  

	pclip=none	clip any value greater than clipval  		

	nclip=none	clip any value less than  clipval 		

	qclip=1.0	clip by quantile on absolute values on trace    

	qbal=0	  flag; 1 = balance traces by qclip and scale     	

	pbal=0	  flag; 1 = bal traces by dividing by rms value   	

	mbal=0	  flag; 1 = bal traces by subtracting the mean    	

	maxbal=0	flag; 1 = balance traces by subtracting the max 

	scale=1.0	multiply data by overall scale factor	   	

	norm=0.0	divide data by overall scale factor	     	

	bias=0.0	bias data by adding an overall bias value	

	jon=0	   	flag; 1 means tpow=2, gpow=.5, qclip=.95	

	verbose=0	verbose = 1 echoes info				

	mark=0		apply gain only to traces with tr.mark=0	

			=1 apply gain only to traces with tr.mark!=0    

	vred=0	  reducing velocity of data to use with tpow		



 	tmpdir=		if non-empty, use the value as a directory path	

			prefix for storing temporary files; else if the 

			the CWP_TMPDIR environment variable is set use  

			its value for the path; else use tmpfile()	



 Operation order:							

 if (norm) scale/norm						  	



 out(t) = scale * BAL{CLIP[AGC{[t^tpow * exp(epow * t^tpow) * ( in(t)-bias )]^gpow}]}



 Notes:								

	The jon flag selects the parameter choices discussed in		

	Claerbout's Imaging the Earth, pp 233-236.			



	Extremely large/small values may be lost during agc. Windowing  

	these off and applying a scale in a preliminary pass through	

	sugain may help.						



	Sugain only applies gain to traces with tr.mark=0. Use sushw,	

	suchw, suedit, or suxedit to mark traces you do not want gained.

	See the selfdocs of sushw, suchw, suedit, and suxedit for more	

	information about setting header fields. Use "sukeyword mark

	for more information about the mark header field.		



      debias data by using mbal=1					



      option etpow only becomes active if epow is nonzero		



 Credits:

	SEP: Jon Claerbout

	CWP: Jack K. Cohen, Brian Sumner, Dave Hale



 Note: Have assumed tr.deltr >= 0 in tpow routine.



 Technical Reference:

	Jon's second book, pages 233-236.



 Trace header fields accessed: ns, dt, delrt, mark, offset



=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use L_SU_global_constants();

use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
use Project_config;


=head2 instantiation of packages

=cut

my $get					= new L_SU_global_constants();
my $Project				= new Project_config();
my $DATA_SEISMIC_SU		= $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT();

my $var				= $get->var();
my $on				= $var->{_on};
my $off				= $var->{_off};
my $true			= $var->{_true};
my $false			= $var->{_false};
my $empty_string	= $var->{_empty_string};

=head2 Encapsulated
hash of private variables

=cut

my $sugain			= {
	_agc					=> '',
	_bias					=> '',
	_clip					=> '',
	_epow					=> '',
	_etpow					=> '',
	_gagc					=> '',
	_gpow					=> '',
	_jon					=> '',
	_mark					=> '',
	_maxbal					=> '',
	_mbal					=> '',
	_nclip					=> '',
	_norm					=> '',
	_panel					=> '',
	_pbal					=> '',
	_pclip					=> '',
	_qbal					=> '',
	_qclip					=> '',
	_scale					=> '',
	_tmpdir					=> '',
	_tpow					=> '',
	_trap					=> '',
	_verbose					=> '',
	_vred					=> '',
	_wagc					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sugain->{_Step}     = 'sugain'.$sugain->{_Step};
	return ( $sugain->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sugain->{_note}     = 'sugain'.$sugain->{_note};
	return ( $sugain->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sugain->{_agc}			= '';
		$sugain->{_bias}			= '';
		$sugain->{_clip}			= '';
		$sugain->{_epow}			= '';
		$sugain->{_etpow}			= '';
		$sugain->{_gagc}			= '';
		$sugain->{_gpow}			= '';
		$sugain->{_jon}			= '';
		$sugain->{_mark}			= '';
		$sugain->{_maxbal}			= '';
		$sugain->{_mbal}			= '';
		$sugain->{_nclip}			= '';
		$sugain->{_norm}			= '';
		$sugain->{_panel}			= '';
		$sugain->{_pbal}			= '';
		$sugain->{_pclip}			= '';
		$sugain->{_qbal}			= '';
		$sugain->{_qclip}			= '';
		$sugain->{_scale}			= '';
		$sugain->{_tmpdir}			= '';
		$sugain->{_tpow}			= '';
		$sugain->{_trap}			= '';
		$sugain->{_verbose}			= '';
		$sugain->{_vred}			= '';
		$sugain->{_wagc}			= '';
		$sugain->{_Step}			= '';
		$sugain->{_note}			= '';
 }


=head2 sub agc 


=cut

 sub agc {

	my ( $self,$agc )		= @_;
	if ( $agc ne $empty_string ) {

		$sugain->{_agc}		= $agc;
		$sugain->{_note}		= $sugain->{_note}.' agc='.$sugain->{_agc};
		$sugain->{_Step}		= $sugain->{_Step}.' agc='.$sugain->{_agc};

	} else { 
		print("sugain, agc, missing agc,\n");
	 }
 }


=head2 sub bias 


=cut

 sub bias {

	my ( $self,$bias )		= @_;
	if ( $bias ne $empty_string ) {

		$sugain->{_bias}		= $bias;
		$sugain->{_note}		= $sugain->{_note}.' bias='.$sugain->{_bias};
		$sugain->{_Step}		= $sugain->{_Step}.' bias='.$sugain->{_bias};

	} else { 
		print("sugain, bias, missing bias,\n");
	 }
 }


=head2 sub clip 


=cut

 sub clip {

	my ( $self,$clip )		= @_;
	if ( $clip ne $empty_string ) {

		$sugain->{_clip}		= $clip;
		$sugain->{_note}		= $sugain->{_note}.' clip='.$sugain->{_clip};
		$sugain->{_Step}		= $sugain->{_Step}.' clip='.$sugain->{_clip};

	} else { 
		print("sugain, clip, missing clip,\n");
	 }
 }


=head2 sub epow 


=cut

 sub epow {

	my ( $self,$epow )		= @_;
	if ( $epow ne $empty_string ) {

		$sugain->{_epow}		= $epow;
		$sugain->{_note}		= $sugain->{_note}.' epow='.$sugain->{_epow};
		$sugain->{_Step}		= $sugain->{_Step}.' epow='.$sugain->{_epow};

	} else { 
		print("sugain, epow, missing epow,\n");
	 }
 }


=head2 sub etpow 


=cut

 sub etpow {

	my ( $self,$etpow )		= @_;
	if ( $etpow ne $empty_string ) {

		$sugain->{_etpow}		= $etpow;
		$sugain->{_note}		= $sugain->{_note}.' etpow='.$sugain->{_etpow};
		$sugain->{_Step}		= $sugain->{_Step}.' etpow='.$sugain->{_etpow};

	} else { 
		print("sugain, etpow, missing etpow,\n");
	 }
 }


=head2 sub gagc 


=cut

 sub gagc {

	my ( $self,$gagc )		= @_;
	if ( $gagc ne $empty_string ) {

		$sugain->{_gagc}		= $gagc;
		$sugain->{_note}		= $sugain->{_note}.' gagc='.$sugain->{_gagc};
		$sugain->{_Step}		= $sugain->{_Step}.' gagc='.$sugain->{_gagc};

	} else { 
		print("sugain, gagc, missing gagc,\n");
	 }
 }


=head2 sub gpow 


=cut

 sub gpow {

	my ( $self,$gpow )		= @_;
	if ( $gpow ne $empty_string ) {

		$sugain->{_gpow}		= $gpow;
		$sugain->{_note}		= $sugain->{_note}.' gpow='.$sugain->{_gpow};
		$sugain->{_Step}		= $sugain->{_Step}.' gpow='.$sugain->{_gpow};

	} else { 
		print("sugain, gpow, missing gpow,\n");
	 }
 }


=head2 sub jon 


=cut

 sub jon {

	my ( $self,$jon )		= @_;
	if ( $jon ne $empty_string ) {

		$sugain->{_jon}		= $jon;
		$sugain->{_note}		= $sugain->{_note}.' jon='.$sugain->{_jon};
		$sugain->{_Step}		= $sugain->{_Step}.' jon='.$sugain->{_jon};

	} else { 
		print("sugain, jon, missing jon,\n");
	 }
 }


=head2 sub mark 


=cut

 sub mark {

	my ( $self,$mark )		= @_;
	if ( $mark ne $empty_string ) {

		$sugain->{_mark}		= $mark;
		$sugain->{_note}		= $sugain->{_note}.' mark='.$sugain->{_mark};
		$sugain->{_Step}		= $sugain->{_Step}.' mark='.$sugain->{_mark};

	} else { 
		print("sugain, mark, missing mark,\n");
	 }
 }


=head2 sub maxbal 


=cut

 sub maxbal {

	my ( $self,$maxbal )		= @_;
	if ( $maxbal ne $empty_string ) {

		$sugain->{_maxbal}		= $maxbal;
		$sugain->{_note}		= $sugain->{_note}.' maxbal='.$sugain->{_maxbal};
		$sugain->{_Step}		= $sugain->{_Step}.' maxbal='.$sugain->{_maxbal};

	} else { 
		print("sugain, maxbal, missing maxbal,\n");
	 }
 }


=head2 sub mbal 


=cut

 sub mbal {

	my ( $self,$mbal )		= @_;
	if ( $mbal ne $empty_string ) {

		$sugain->{_mbal}		= $mbal;
		$sugain->{_note}		= $sugain->{_note}.' mbal='.$sugain->{_mbal};
		$sugain->{_Step}		= $sugain->{_Step}.' mbal='.$sugain->{_mbal};

	} else { 
		print("sugain, mbal, missing mbal,\n");
	 }
 }


=head2 sub nclip 


=cut

 sub nclip {

	my ( $self,$nclip )		= @_;
	if ( $nclip ne $empty_string ) {

		$sugain->{_nclip}		= $nclip;
		$sugain->{_note}		= $sugain->{_note}.' nclip='.$sugain->{_nclip};
		$sugain->{_Step}		= $sugain->{_Step}.' nclip='.$sugain->{_nclip};

	} else { 
		print("sugain, nclip, missing nclip,\n");
	 }
 }


=head2 sub norm 


=cut

 sub norm {

	my ( $self,$norm )		= @_;
	if ( $norm ne $empty_string ) {

		$sugain->{_norm}		= $norm;
		$sugain->{_note}		= $sugain->{_note}.' norm='.$sugain->{_norm};
		$sugain->{_Step}		= $sugain->{_Step}.' norm='.$sugain->{_norm};

	} else { 
		print("sugain, norm, missing norm,\n");
	 }
 }


=head2 sub panel 


=cut

 sub panel {

	my ( $self,$panel )		= @_;
	if ( $panel ne $empty_string ) {

		$sugain->{_panel}		= $panel;
		$sugain->{_note}		= $sugain->{_note}.' panel='.$sugain->{_panel};
		$sugain->{_Step}		= $sugain->{_Step}.' panel='.$sugain->{_panel};

	} else { 
		print("sugain, panel, missing panel,\n");
	 }
 }


=head2 sub pbal 


=cut

 sub pbal {

	my ( $self,$pbal )		= @_;
	if ( $pbal ne $empty_string ) {

		$sugain->{_pbal}		= $pbal;
		$sugain->{_note}		= $sugain->{_note}.' pbal='.$sugain->{_pbal};
		$sugain->{_Step}		= $sugain->{_Step}.' pbal='.$sugain->{_pbal};

	} else { 
		print("sugain, pbal, missing pbal,\n");
	 }
 }


=head2 sub pclip 


=cut

 sub pclip {

	my ( $self,$pclip )		= @_;
	if ( $pclip ne $empty_string ) {

		$sugain->{_pclip}		= $pclip;
		$sugain->{_note}		= $sugain->{_note}.' pclip='.$sugain->{_pclip};
		$sugain->{_Step}		= $sugain->{_Step}.' pclip='.$sugain->{_pclip};

	} else { 
		print("sugain, pclip, missing pclip,\n");
	 }
 }


=head2 sub qbal 


=cut

 sub qbal {

	my ( $self,$qbal )		= @_;
	if ( $qbal ne $empty_string ) {

		$sugain->{_qbal}		= $qbal;
		$sugain->{_note}		= $sugain->{_note}.' qbal='.$sugain->{_qbal};
		$sugain->{_Step}		= $sugain->{_Step}.' qbal='.$sugain->{_qbal};

	} else { 
		print("sugain, qbal, missing qbal,\n");
	 }
 }


=head2 sub qclip 


=cut

 sub qclip {

	my ( $self,$qclip )		= @_;
	if ( $qclip ne $empty_string ) {

		$sugain->{_qclip}		= $qclip;
		$sugain->{_note}		= $sugain->{_note}.' qclip='.$sugain->{_qclip};
		$sugain->{_Step}		= $sugain->{_Step}.' qclip='.$sugain->{_qclip};

	} else { 
		print("sugain, qclip, missing qclip,\n");
	 }
 }


=head2 sub scale 


=cut

 sub scale {

	my ( $self,$scale )		= @_;
	if ( $scale ne $empty_string ) {

		$sugain->{_scale}		= $scale;
		$sugain->{_note}		= $sugain->{_note}.' scale='.$sugain->{_scale};
		$sugain->{_Step}		= $sugain->{_Step}.' scale='.$sugain->{_scale};

	} else { 
		print("sugain, scale, missing scale,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ne $empty_string ) {

		$sugain->{_tmpdir}		= $tmpdir;
		$sugain->{_note}		= $sugain->{_note}.' tmpdir='.$sugain->{_tmpdir};
		$sugain->{_Step}		= $sugain->{_Step}.' tmpdir='.$sugain->{_tmpdir};

	} else { 
		print("sugain, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub tpow 


=cut

 sub tpow {

	my ( $self,$tpow )		= @_;
	if ( $tpow ne $empty_string ) {

		$sugain->{_tpow}		= $tpow;
		$sugain->{_note}		= $sugain->{_note}.' tpow='.$sugain->{_tpow};
		$sugain->{_Step}		= $sugain->{_Step}.' tpow='.$sugain->{_tpow};

	} else { 
		print("sugain, tpow, missing tpow,\n");
	 }
 }


=head2 sub trap 


=cut

 sub trap {

	my ( $self,$trap )		= @_;
	if ( $trap ne $empty_string ) {

		$sugain->{_trap}		= $trap;
		$sugain->{_note}		= $sugain->{_note}.' trap='.$sugain->{_trap};
		$sugain->{_Step}		= $sugain->{_Step}.' trap='.$sugain->{_trap};

	} else { 
		print("sugain, trap, missing trap,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sugain->{_verbose}		= $verbose;
		$sugain->{_note}		= $sugain->{_note}.' verbose='.$sugain->{_verbose};
		$sugain->{_Step}		= $sugain->{_Step}.' verbose='.$sugain->{_verbose};

	} else { 
		print("sugain, verbose, missing verbose,\n");
	 }
 }


=head2 sub vred 


=cut

 sub vred {

	my ( $self,$vred )		= @_;
	if ( $vred ne $empty_string ) {

		$sugain->{_vred}		= $vred;
		$sugain->{_note}		= $sugain->{_note}.' vred='.$sugain->{_vred};
		$sugain->{_Step}		= $sugain->{_Step}.' vred='.$sugain->{_vred};

	} else { 
		print("sugain, vred, missing vred,\n");
	 }
 }


=head2 sub wagc 


=cut

 sub wagc {

	my ( $self,$wagc )		= @_;
	if ( $wagc ne $empty_string ) {

		$sugain->{_wagc}		= $wagc;
		$sugain->{_note}		= $sugain->{_note}.' wagc='.$sugain->{_wagc};
		$sugain->{_Step}		= $sugain->{_Step}.' wagc='.$sugain->{_wagc};

	} else { 
		print("sugain, wagc, missing wagc,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
    my $max_index = 36;

    return($max_index);
}
 
 
1; 