package App::SeismicUnixGui::misc::premmod;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: premmod.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 
 DESCRIPTION: 
 Version 0.0.3
  
=cut

=head2 USE

=head3 NOTES
This program module is used to read a SU file, 
creates the file: 
datammod
which is a binary fortran file containing the SU file with no headers, and that
can be read by program mmodpg.  It also create the ascii file: 
parmmod  
containi ng
basic parameters of the SU file (ntr,ns,dt) also used by mmodpg.

=head4
 Examples

=head2 CHANGES and their DATES
   August, 2001 a Perl version from Emilio Vera
   Version: 0.0.1 4-22-19
   Version: 0.0.2 Feb 6 2020 as premmod.pl
   Version: 0.0.3 turn into module
   
=cut 
# must precede immodpg_config 
=head2 Define
local variables

=cut

use Moose;
our $VERSION = '0.0.3';

use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';
use aliased 'App::SeismicUnixGui::configs::big_streams::Project_config';
use aliased 'App::SeismicUnixGui::configs::big_streams::immodpg_config';
use aliased 'App::SeismicUnixGui::misc::message';
use aliased 'App::SeismicUnixGui::misc::flow';
use aliased 'App::SeismicUnixGui::sunix::header::sustrip';

=head2 import variables 

=cut

use App::SeismicUnixGui::misc::SeismicUnix qw($in $out $on $go $to $suffix_bin $off $suffix_su);

my $Project        = Project_config->new();
my $immodpg_config = immodpg_config->new();
my $get            = L_SU_global_constants->new();
my $log            = message->new();
my $run            = flow->new();
my $sustrip        = sustrip->new();

=head2 Declare
local variables

=cut

my (@flow);
my (@items);
my (@sustrip);

my $var          = $get->var();
my $empty_string = $var->{_empty_string};

my $DATA_SEISMIC_SU  = $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN = $Project->DATA_SEISMIC_BIN();
my $IMMODPG          = $Project->IMMODPG();

=head2 private hash

=cut

my $premmod = {
	_base_file_name => '',
	_outbound_par   => '',
	_inbound_su     => '',
	_outbound_bin   => '',

};

=head2 Get starting configuration 
parameters

=cut

my ( $CFG_h, $CFG_aref ) = $immodpg_config->get_values();
my $base_file_name 		= $CFG_h->{immodpg}{1}{base_file_name};
my $parmmod        		= 'parmmod';

if ( length $base_file_name ) {

	# print("premmod,base_file_name:$base_file_name\n");

	$premmod = {
		_base_file_name => $base_file_name,
		_outbound_par   => $IMMODPG . '/' . $parmmod,
		_inbound_su     => $DATA_SEISMIC_SU . '/' . $base_file_name . $suffix_su,
		_outbound_bin   => $DATA_SEISMIC_BIN . '/' . $base_file_name . $suffix_bin,

	};

	# print("premmod,  hash, _inbound_su is $premmod->{_inbound_su} \n");
	# print("premmod,  hash, _outbound_bin is $premmod->{_outbound_bin} \n");
	# print("premmod,  hash, _outbound_par is $premmod->{_outbound_par} \n");
	
} else {
	print("premmod, missing base file name\n");
}

=head2 sub clear
private hash variables

=cut

sub clear {

	my ($self) = @_;
	$premmod->{_base_file_name}   	= '',
	$premmod->{_outbound_par} 		= '';
	$premmod->{_inbound_su}   		= '';
	$premmod->{_outbound_bin} 		= '';

}

=head2 sub out_header_values to FILE

=cut

sub out_header_values {

	my ($self) = @_;

	#	print("1 premmod,out_header_values\n\n");
	#	print("1 premmod,out_header_values inbound_su=$premmod->{_inbound_su}\n\n");
	#	print("1 premmod,out_header_values outbound_par=$premmod->{_outbound_par}\n\n");

	if (   $premmod->{_inbound_su} ne $empty_string
		&& $premmod->{_outbound_par} ne $empty_string ) {

		# print("2 premmod,out_header_values inbound_su=$premmod->{_inbound_su}\n\n");
		# print("2 premmod,out_header_values outbound_par=$premmod->{_outbound_par}\n\n");

		my $size = qx(wc -c   $premmod->{_inbound_su} | awk '{print \$1}');
		my $ns   = qx(sugethw key=ns output=geom <  $premmod->{_inbound_su} | sed 1q);
		my $dt   = qx(sugethw key=dt output=geom <  $premmod->{_inbound_su} | sed 1q);
		my $ntr  = $size / ( $ns * 4 + 240 );

		#		can not print the output to ticks. DO not know why
		# print("premmod,out_header_values, size=$size number of samples=$ns SI=$dt Traces=$ntr \n\n");
		# 		print("premmod,out_header_values, size=$size \n\n");

		open( OUTFILE, '>', $premmod->{_outbound_par} ) or die $!;
		printf OUTFILE "0 0 0\n", $ntr, $ns, $dt;
		close(OUTFILE);

	} else {
		print("premmod, out_header_values missing file name\n");
	}

}

=head2 sub set_binary_strip

=cut

sub set_binary_strip {

	my ($self) = @_;

	# print("1. premmod,set_binary_strip _inbound_su=$premmod->{_inbound_su}\n");
	if ( defined( $premmod->{_inbound_su} )
		&& $premmod->{_inbound_su} ne $empty_string ) {

		#		print("premmod,set_binary_strip _inbound_su=$premmod->{_inbound_su}\n");

=head2 Set up
sustrip parameter values

=cut

		$sustrip->clear();
		$sustrip->ftn( quotemeta(1) );
		$sustrip->head( quotemeta('/dev/null') );
		$sustrip->outpar( quotemeta('/dev/null') );
		$sustrip[1] = $sustrip->Step();

=head2 DEFINE FLOW(s)


=cut

		@items = (
			$sustrip[1],
			$in,  $premmod->{_inbound_su},
			$out, $premmod->{_outbound_bin},
			$go
		);
		$flow[1] = $run->modules( \@items );

=head2 RUN FLOW(s)

=cut

		$run->flow( \$flow[1] );

=head2 LOG FLOW(s)
to screen and FILE

=cut

		# print $flow[1]."\n";
		$log->file( $flow[1] );

	} else {
		print("premmod,set_binary_strip missing variables\n");
		print("premmod,set_binary_strip _inbound_su=$premmod->{_inbound_su}\n");
	}
}

1;
