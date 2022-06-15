package susorty;

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
 SUSORTY - make a small 2-D common shot off-end  		

	    data set in which the data show geometry 		

	    values to help visualize data sorting.		



  susorty [optional parameters] > out_data_file  		



 Optional parameters:						

	nt=100 		number of time samples			

	nshot=10 	number of shots				

	dshot=10 	shot interval (m)			

	noff=20 	number of offsets			

	doff=20 	offset increment (m)			



 Notes:							

 Creates a common shot su data file for sort visualization	

	       time samples           quantity			

	       ----------------      ----------			

	       first   25%           shot coord			

	       second  25%           rec coord			

	       third   25%           offset			

	       fourth  25%           cmp coord			





 1. default is shot ordered (hsv2 cmap looks best to me)	

 susorty | suximage legend=1 units=meters cmap=hsv2		



 2. sort on cmp (note random order within a cmp)		

 susorty | susort cdp > junk.su 				

 suximage < junk.su legend=1 units=meters cmap=hsv2		



 3. sort to cmp and subsort on offset 	 			

 susorty | susort cdp offset > junk.su 			

 suximage < junk.su legend=1 units=meters cmap=hsv2		





 Credits:

	CWP: Chris Liner  10.09.01



 Trace header fields set: ns, dt, sx, gx, offset, cdp, tracl 



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

my $susorty			= {
	_doff					=> '',
	_dshot					=> '',
	_legend					=> '',
	_noff					=> '',
	_nshot					=> '',
	_nt					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$susorty->{_Step}     = 'susorty'.$susorty->{_Step};
	return ( $susorty->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$susorty->{_note}     = 'susorty'.$susorty->{_note};
	return ( $susorty->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$susorty->{_doff}			= '';
		$susorty->{_dshot}			= '';
		$susorty->{_legend}			= '';
		$susorty->{_noff}			= '';
		$susorty->{_nshot}			= '';
		$susorty->{_nt}			= '';
		$susorty->{_Step}			= '';
		$susorty->{_note}			= '';
 }


=head2 sub doff 


=cut

 sub doff {

	my ( $self,$doff )		= @_;
	if ( $doff ne $empty_string ) {

		$susorty->{_doff}		= $doff;
		$susorty->{_note}		= $susorty->{_note}.' doff='.$susorty->{_doff};
		$susorty->{_Step}		= $susorty->{_Step}.' doff='.$susorty->{_doff};

	} else { 
		print("susorty, doff, missing doff,\n");
	 }
 }


=head2 sub dshot 


=cut

 sub dshot {

	my ( $self,$dshot )		= @_;
	if ( $dshot ne $empty_string ) {

		$susorty->{_dshot}		= $dshot;
		$susorty->{_note}		= $susorty->{_note}.' dshot='.$susorty->{_dshot};
		$susorty->{_Step}		= $susorty->{_Step}.' dshot='.$susorty->{_dshot};

	} else { 
		print("susorty, dshot, missing dshot,\n");
	 }
 }


=head2 sub legend 


=cut

 sub legend {

	my ( $self,$legend )		= @_;
	if ( $legend ne $empty_string ) {

		$susorty->{_legend}		= $legend;
		$susorty->{_note}		= $susorty->{_note}.' legend='.$susorty->{_legend};
		$susorty->{_Step}		= $susorty->{_Step}.' legend='.$susorty->{_legend};

	} else { 
		print("susorty, legend, missing legend,\n");
	 }
 }


=head2 sub noff 


=cut

 sub noff {

	my ( $self,$noff )		= @_;
	if ( $noff ne $empty_string ) {

		$susorty->{_noff}		= $noff;
		$susorty->{_note}		= $susorty->{_note}.' noff='.$susorty->{_noff};
		$susorty->{_Step}		= $susorty->{_Step}.' noff='.$susorty->{_noff};

	} else { 
		print("susorty, noff, missing noff,\n");
	 }
 }


=head2 sub nshot 


=cut

 sub nshot {

	my ( $self,$nshot )		= @_;
	if ( $nshot ne $empty_string ) {

		$susorty->{_nshot}		= $nshot;
		$susorty->{_note}		= $susorty->{_note}.' nshot='.$susorty->{_nshot};
		$susorty->{_Step}		= $susorty->{_Step}.' nshot='.$susorty->{_nshot};

	} else { 
		print("susorty, nshot, missing nshot,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$susorty->{_nt}		= $nt;
		$susorty->{_note}		= $susorty->{_note}.' nt='.$susorty->{_nt};
		$susorty->{_Step}		= $susorty->{_Step}.' nt='.$susorty->{_nt};

	} else { 
		print("susorty, nt, missing nt,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 5;

    return($max_index);
}
 
 
1;
