package sutaper;

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
 SUTAPER - Taper the edge traces of a data panel to zero.	





 sutaper <stdin >stdout [optional parameters]		  



 Optional Parameters:					  

 ntr=tr.ntr	number of traces. If tr.ntr is not set, then	

 		ntr is mandatory				

 tr1=0	 number of traces to be tapered at beginning	

 tr2=tr1	number of traces to be tapered at end		

 min=0.		minimum amplitude factor of taper		

 tbeg=0		length of taper (ms) at trace start		

 tend=0		length of taper (ms) at trace end		

 taper=1	taper type					

		 =1 linear (default)			   

		 =2 sine					

		 =3 cosine					

		 =4 gaussian (+/-3.8)			  

		 =5 gaussian (+/-2.0)			  



 Notes:							

   To eliminate the taper, choose tbeg=0. and tend=0. and tr1=0





 Credits:



	CWP: Chris Liner, Jack K. Cohen



 Trace header fields accessed: ns, ntr

 

 Rewrite: Tagir Galikeev, October 2002



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

my $sutaper			= {
	_min					=> '',
	_ntr					=> '',
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

	$sutaper->{_Step}     = 'sutaper'.$sutaper->{_Step};
	return ( $sutaper->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sutaper->{_note}     = 'sutaper'.$sutaper->{_note};
	return ( $sutaper->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sutaper->{_min}			= '';
		$sutaper->{_ntr}			= '';
		$sutaper->{_taper}			= '';
		$sutaper->{_tbeg}			= '';
		$sutaper->{_tend}			= '';
		$sutaper->{_tr1}			= '';
		$sutaper->{_tr2}			= '';
		$sutaper->{_Step}			= '';
		$sutaper->{_note}			= '';
 }


=head2 sub min 


=cut

 sub min {

	my ( $self,$min )		= @_;
	if ( $min ne $empty_string ) {

		$sutaper->{_min}		= $min;
		$sutaper->{_note}		= $sutaper->{_note}.' min='.$sutaper->{_min};
		$sutaper->{_Step}		= $sutaper->{_Step}.' min='.$sutaper->{_min};

	} else { 
		print("sutaper, min, missing min,\n");
	 }
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sutaper->{_ntr}		= $ntr;
		$sutaper->{_note}		= $sutaper->{_note}.' ntr='.$sutaper->{_ntr};
		$sutaper->{_Step}		= $sutaper->{_Step}.' ntr='.$sutaper->{_ntr};

	} else { 
		print("sutaper, ntr, missing ntr,\n");
	 }
 }


=head2 sub taper 


=cut

 sub taper {

	my ( $self,$taper )		= @_;
	if ( $taper ne $empty_string ) {

		$sutaper->{_taper}		= $taper;
		$sutaper->{_note}		= $sutaper->{_note}.' taper='.$sutaper->{_taper};
		$sutaper->{_Step}		= $sutaper->{_Step}.' taper='.$sutaper->{_taper};

	} else { 
		print("sutaper, taper, missing taper,\n");
	 }
 }


=head2 sub tbeg 


=cut

 sub tbeg {

	my ( $self,$tbeg )		= @_;
	if ( $tbeg ne $empty_string ) {

		$sutaper->{_tbeg}		= $tbeg;
		$sutaper->{_note}		= $sutaper->{_note}.' tbeg='.$sutaper->{_tbeg};
		$sutaper->{_Step}		= $sutaper->{_Step}.' tbeg='.$sutaper->{_tbeg};

	} else { 
		print("sutaper, tbeg, missing tbeg,\n");
	 }
 }


=head2 sub tend 


=cut

 sub tend {

	my ( $self,$tend )		= @_;
	if ( $tend ne $empty_string ) {

		$sutaper->{_tend}		= $tend;
		$sutaper->{_note}		= $sutaper->{_note}.' tend='.$sutaper->{_tend};
		$sutaper->{_Step}		= $sutaper->{_Step}.' tend='.$sutaper->{_tend};

	} else { 
		print("sutaper, tend, missing tend,\n");
	 }
 }


=head2 sub tr1 


=cut

 sub tr1 {

	my ( $self,$tr1 )		= @_;
	if ( $tr1 ne $empty_string ) {

		$sutaper->{_tr1}		= $tr1;
		$sutaper->{_note}		= $sutaper->{_note}.' tr1='.$sutaper->{_tr1};
		$sutaper->{_Step}		= $sutaper->{_Step}.' tr1='.$sutaper->{_tr1};

	} else { 
		print("sutaper, tr1, missing tr1,\n");
	 }
 }


=head2 sub tr2 


=cut

 sub tr2 {

	my ( $self,$tr2 )		= @_;
	if ( $tr2 ne $empty_string ) {

		$sutaper->{_tr2}		= $tr2;
		$sutaper->{_note}		= $sutaper->{_note}.' tr2='.$sutaper->{_tr2};
		$sutaper->{_Step}		= $sutaper->{_Step}.' tr2='.$sutaper->{_tr2};

	} else { 
		print("sutaper, tr2, missing tr2,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 6;

    return($max_index);
}
 
 
1;
