package sutxtaper;

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
 SUTXTAPER - TAPER in (X,T) the edges of a data panel to zero.	



 sutxtaper <stdin >stdout [optional parameters]		



 Optional Parameters:                                          

 low=0.    	minimum amplitude factor of taper		

 tbeg=0    	length of taper (ms) at trace start		

 tend=0     	length of taper (ms) at trace end		

 taper=1       taper type                                      

                 =1 linear (default)                           

                 =2 sine                                       

                 =3 cosine                                     

                 =4 gaussian (+/-3.8)                          

                 =5 gaussian (+/-2.0)                          

 key=tr	set key to compute x-domain taper weights	

               default is using internal tracecount (tr)       

 tr1=0         number of traces to be tapered at beg (key=tr)	

 tr2=tr1       number of traces to be tapered at end (key=tr)	



 min=0.	minimum value of key where taper starts (amp=1.)

 max=0.	maximum value of key where taper starts (amp=1.)

 dx=1. 	length of taper (in key units)			

		if key=tr (unset) length is tr1 and (ntr-tr2)	



 Notes:                                                        

   Taper type is used for trace (x-domain) tapering as well 	

   as for time domain tapering.				

   The taper is applied to all traces <tr1 (or key<min) and    

   >tr2 (or key >max) and all time samples <tbeg and >tend. 	

   Taper weights are amp*1 for traces n tr1<n<tr2 and computed	

   for all other traces corresponding to the taper typ.	

   If key is given the taper length is defined by dx, otherwise

   the length of taper is tr1 and (ntr-tr2) respectively.	

   To eliminate the taper, choose tbeg=0. and tend=0. and tr1=0

   If key is set, min,max values take precedence over tr1,tr2.	





 Credits: (based on sutaper)



	CWP: Chris Liner, Jack K. Cohen



 Trace header fields accessed: ns

 

 Rewrite: Tagir Galikeev, October 2002

 Rewrite: Gerald Klein, IFM-GEOMAR, April 2004



=head2 User's notes (Juan Lorenzo)
untested

=cut


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use L_SU_global_constants();

use SeismicUnix qw ($go $in $off $on $out $ps $to $suffix_ascii $suffix_bin $suffix_ps $suffix_segy $suffix_su);
use Project_config;


=head2 instantiation of packages

=cut

my $get					= new L_SU_global_constants();
my $Project				= new Project_config();
my $DATA_SEISMIC_SU		= $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT();

my $PS_SEISMIC      	= $Project->PS_SEISMIC();

my $var				= $get->var();
my $on				= $var->{_on};
my $off				= $var->{_off};
my $true			= $var->{_true};
my $false			= $var->{_false};
my $empty_string	= $var->{_empty_string};

=head2 Encapsulated
hash of private variables

=cut

my $sutxtaper			= {
	_dx					=> '',
	_key					=> '',
	_low					=> '',
	_max					=> '',
	_min					=> '',
	_taper					=> '',
	_tbeg					=> '',
	_tend					=> '',
	_tr1					=> '',
	_tr2					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sutxtaper->{_Step}     = 'sutxtaper'.$sutxtaper->{_Step};
	return ( $sutxtaper->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sutxtaper->{_note}     = 'sutxtaper'.$sutxtaper->{_note};
	return ( $sutxtaper->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sutxtaper->{_dx}			= '';
		$sutxtaper->{_key}			= '';
		$sutxtaper->{_low}			= '';
		$sutxtaper->{_max}			= '';
		$sutxtaper->{_min}			= '';
		$sutxtaper->{_taper}			= '';
		$sutxtaper->{_tbeg}			= '';
		$sutxtaper->{_tend}			= '';
		$sutxtaper->{_tr1}			= '';
		$sutxtaper->{_tr2}			= '';
		$sutxtaper->{_Step}			= '';
		$sutxtaper->{_note}			= '';
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$sutxtaper->{_dx}		= $dx;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' dx='.$sutxtaper->{_dx};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' dx='.$sutxtaper->{_dx};

	} else { 
		print("sutxtaper, dx, missing dx,\n");
	 }
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ne $empty_string ) {

		$sutxtaper->{_key}		= $key;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' key='.$sutxtaper->{_key};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' key='.$sutxtaper->{_key};

	} else { 
		print("sutxtaper, key, missing key,\n");
	 }
 }


=head2 sub low 


=cut

 sub low {

	my ( $self,$low )		= @_;
	if ( $low ne $empty_string ) {

		$sutxtaper->{_low}		= $low;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' low='.$sutxtaper->{_low};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' low='.$sutxtaper->{_low};

	} else { 
		print("sutxtaper, low, missing low,\n");
	 }
 }


=head2 sub max 


=cut

 sub max {

	my ( $self,$max )		= @_;
	if ( $max ne $empty_string ) {

		$sutxtaper->{_max}		= $max;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' max='.$sutxtaper->{_max};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' max='.$sutxtaper->{_max};

	} else { 
		print("sutxtaper, max, missing max,\n");
	 }
 }


=head2 sub min 


=cut

 sub min {

	my ( $self,$min )		= @_;
	if ( $min ne $empty_string ) {

		$sutxtaper->{_min}		= $min;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' min='.$sutxtaper->{_min};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' min='.$sutxtaper->{_min};

	} else { 
		print("sutxtaper, min, missing min,\n");
	 }
 }


=head2 sub taper 


=cut

 sub taper {

	my ( $self,$taper )		= @_;
	if ( $taper ne $empty_string ) {

		$sutxtaper->{_taper}		= $taper;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' taper='.$sutxtaper->{_taper};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' taper='.$sutxtaper->{_taper};

	} else { 
		print("sutxtaper, taper, missing taper,\n");
	 }
 }


=head2 sub tbeg 


=cut

 sub tbeg {

	my ( $self,$tbeg )		= @_;
	if ( $tbeg ne $empty_string ) {

		$sutxtaper->{_tbeg}		= $tbeg;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' tbeg='.$sutxtaper->{_tbeg};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' tbeg='.$sutxtaper->{_tbeg};

	} else { 
		print("sutxtaper, tbeg, missing tbeg,\n");
	 }
 }


=head2 sub tend 


=cut

 sub tend {

	my ( $self,$tend )		= @_;
	if ( $tend ne $empty_string ) {

		$sutxtaper->{_tend}		= $tend;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' tend='.$sutxtaper->{_tend};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' tend='.$sutxtaper->{_tend};

	} else { 
		print("sutxtaper, tend, missing tend,\n");
	 }
 }


=head2 sub tr1 


=cut

 sub tr1 {

	my ( $self,$tr1 )		= @_;
	if ( $tr1 ne $empty_string ) {

		$sutxtaper->{_tr1}		= $tr1;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' tr1='.$sutxtaper->{_tr1};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' tr1='.$sutxtaper->{_tr1};

	} else { 
		print("sutxtaper, tr1, missing tr1,\n");
	 }
 }


=head2 sub tr2 


=cut

 sub tr2 {

	my ( $self,$tr2 )		= @_;
	if ( $tr2 ne $empty_string ) {

		$sutxtaper->{_tr2}		= $tr2;
		$sutxtaper->{_note}		= $sutxtaper->{_note}.' tr2='.$sutxtaper->{_tr2};
		$sutxtaper->{_Step}		= $sutxtaper->{_Step}.' tr2='.$sutxtaper->{_tr2};

	} else { 
		print("sutxtaper, tr2, missing tr2,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 9;

    return($max_index);
}
 
 
1;
