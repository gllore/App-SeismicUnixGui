package thom2hti;

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
 THOM2HTI - Convert Thompson parameters V_p0, V_s0, eps, gamma,	

              to the HTI parameters alpha, beta, epsilon(V), delta(V), 

	       gamma							



 thom2hti  [optional parameter]                           		





 vp=2         symm.axis p-wave velocity                        	

 vs=1         symm.axis s-wave velocity                        	

 eps=0        Thomsen's (generic) epsilon 	         		

 gamma=0      Thomsen's generic gamma                                  

 weak=1       compute weak approximation                               

 outpar=/dev/tty	output parameter file				



 Outputs:								

   alpha, beta, e(V), d(V), gamma					



 Notes:								

 Output is dumped to the screen and, if selected to outpar		



 Code can be used to find models that satisfy the constraints		

 that are imposed on HTI models caused by vertically fractured		

 layers. For definition and use of the HTI parameter set see CWP-235.	



 

  Credits: Andreas Rueger, CWP

  For definition and use of the HTI parameter set see CWP-235.





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

my $thom2hti			= {
	_eps					=> '',
	_gamma					=> '',
	_outpar					=> '',
	_vp					=> '',
	_vs					=> '',
	_weak					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$thom2hti->{_Step}     = 'thom2hti'.$thom2hti->{_Step};
	return ( $thom2hti->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$thom2hti->{_note}     = 'thom2hti'.$thom2hti->{_note};
	return ( $thom2hti->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$thom2hti->{_eps}			= '';
		$thom2hti->{_gamma}			= '';
		$thom2hti->{_outpar}			= '';
		$thom2hti->{_vp}			= '';
		$thom2hti->{_vs}			= '';
		$thom2hti->{_weak}			= '';
		$thom2hti->{_Step}			= '';
		$thom2hti->{_note}			= '';
 }


=head2 sub eps 


=cut

 sub eps {

	my ( $self,$eps )		= @_;
	if ( $eps ne $empty_string ) {

		$thom2hti->{_eps}		= $eps;
		$thom2hti->{_note}		= $thom2hti->{_note}.' eps='.$thom2hti->{_eps};
		$thom2hti->{_Step}		= $thom2hti->{_Step}.' eps='.$thom2hti->{_eps};

	} else { 
		print("thom2hti, eps, missing eps,\n");
	 }
 }


=head2 sub gamma 


=cut

 sub gamma {

	my ( $self,$gamma )		= @_;
	if ( $gamma ne $empty_string ) {

		$thom2hti->{_gamma}		= $gamma;
		$thom2hti->{_note}		= $thom2hti->{_note}.' gamma='.$thom2hti->{_gamma};
		$thom2hti->{_Step}		= $thom2hti->{_Step}.' gamma='.$thom2hti->{_gamma};

	} else { 
		print("thom2hti, gamma, missing gamma,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$thom2hti->{_outpar}		= $outpar;
		$thom2hti->{_note}		= $thom2hti->{_note}.' outpar='.$thom2hti->{_outpar};
		$thom2hti->{_Step}		= $thom2hti->{_Step}.' outpar='.$thom2hti->{_outpar};

	} else { 
		print("thom2hti, outpar, missing outpar,\n");
	 }
 }


=head2 sub vp 


=cut

 sub vp {

	my ( $self,$vp )		= @_;
	if ( $vp ne $empty_string ) {

		$thom2hti->{_vp}		= $vp;
		$thom2hti->{_note}		= $thom2hti->{_note}.' vp='.$thom2hti->{_vp};
		$thom2hti->{_Step}		= $thom2hti->{_Step}.' vp='.$thom2hti->{_vp};

	} else { 
		print("thom2hti, vp, missing vp,\n");
	 }
 }


=head2 sub vs 


=cut

 sub vs {

	my ( $self,$vs )		= @_;
	if ( $vs ne $empty_string ) {

		$thom2hti->{_vs}		= $vs;
		$thom2hti->{_note}		= $thom2hti->{_note}.' vs='.$thom2hti->{_vs};
		$thom2hti->{_Step}		= $thom2hti->{_Step}.' vs='.$thom2hti->{_vs};

	} else { 
		print("thom2hti, vs, missing vs,\n");
	 }
 }


=head2 sub weak 


=cut

 sub weak {

	my ( $self,$weak )		= @_;
	if ( $weak ne $empty_string ) {

		$thom2hti->{_weak}		= $weak;
		$thom2hti->{_note}		= $thom2hti->{_note}.' weak='.$thom2hti->{_weak};
		$thom2hti->{_Step}		= $thom2hti->{_Step}.' weak='.$thom2hti->{_weak};

	} else { 
		print("thom2hti, weak, missing weak,\n");
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
