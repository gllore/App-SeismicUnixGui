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

=head2 CHANGES and their DATES

=cut


	use Moose;
	use App::SeismicUnixGui::misc::SeismicUnix qw($in $out $on $go $to $suffix_ascii $off $suffix_segd $suffix_segy $suffix_sgy $suffix_su $suffix_segd $suffix_txt $suffix_bin);
	use App::SeismicUnixGui::configs::big_streams::Project_config;

	my $Project		= Project_config->new();
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_SEGY	= $Project->DATA_SEISMIC_SEGY;
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;

	use App::SeismicUnixGui::misc::message;
	use App::SeismicUnixGui::misc::flow;
	use App::SeismicUnixGui::sunix::data::data_in;
	use App::SeismicUnixGui::sunix::statsMath::suop;
	use App::SeismicUnixGui::sunix::shapeNcut::suwind;
	use App::SeismicUnixGui::sunix::shapeNcut::sugain;
	use App::SeismicUnixGui::sunix::filter::sufilter;
	use App::SeismicUnixGui::sunix::transform::suphasevel;
	use App::SeismicUnixGui::sunix::transform::suamp;
	use App::SeismicUnixGui::sunix::plot::suximage;

	my $log					= message->new();
	my $run					= flow->new();
	my $data_in				=  data_in->new();
	my $suop				=  suop->new();
	my $suwind				=  suwind->new();
	my $sugain				=  sugain->new();
	my $sufilter				=  sufilter->new();
	my $suphasevel				=  suphasevel->new();
	my $suamp				=  suamp->new();
	my $suximage				=  suximage->new();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suop);
	my (@suwind);
	my (@sugain);
	my (@sufilter);
	my (@suphasevel);
	my (@suamp);
	my (@suximage);
 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('pseudo_walk_piezo_cylind_wheelA1_geom1'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();
 	 $suop 	 	 	 	 ->clear();
 	 $suop 	 	 	 	 ->op(quotemeta('avg'));
 	 $suop [1]  	 	 	 = $suop ->Step();
 	 $suwind 	 	 	 	 ->clear();
 	 $suwind 	 	 	 	 ->max(quotemeta(8));
 	 $suwind 	 	 	 	 ->min(quotemeta(8));
 	 $suwind 	 	 	 	 ->setheaderword(quotemeta('tracl'));
 	 $suwind [1]  	 	 	 = $suwind ->Step();
 	 $suwind 	 	 	 	 ->clear();
 	 $suwind 	 	 	 	 ->tmin(quotemeta(0));
 	 $suwind 	 	 	 	 ->tmax(quotemeta(.2));
 	 $suwind [2]  	 	 	 = $suwind ->Step();
 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->mbal(quotemeta(1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [1]  	 	 	 = $sugain ->Step();
 	 $sufilter 	 	 	 	 ->clear();
 	 $sufilter 	 	 	 	 ->f(quotemeta('3,6,2000,3000'));
 	 $sufilter 	 	 	 	 ->verbose(quotemeta(0));
 	 $sufilter [1]  	 	 	 = $sufilter ->Step();
 	 $suphasevel 	 	 	 	 ->clear();
 	 $suphasevel 	 	 	 	 ->dv(quotemeta(200));
 	 $suphasevel 	 	 	 	 ->fmax(quotemeta(3900));
 	 $suphasevel 	 	 	 	 ->fv(quotemeta(1));
 	 $suphasevel 	 	 	 	 ->norm(quotemeta(1));
 	 $suphasevel 	 	 	 	 ->nv(quotemeta(100));
 	 $suphasevel 	 	 	 	 ->verbose(quotemeta(0));
 	 $suphasevel [1]  	 	 	 = $suphasevel ->Step();
 	 $suamp 	 	 	 	 ->clear();
 	 $suamp 	 	 	 	 ->mode(quotemeta('real'));
 	 $suamp [1]  	 	 	 = $suamp ->Step();
 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->mbal(quotemeta(1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [2]  	 	 	 = $sugain ->Step();
 	 $suximage 	 	 	 	 ->clear();
 	 $suximage 	 	 	 	 ->hiclip(quotemeta(15));
 	 $suximage 	 	 	 	 ->loclip(quotemeta(-10));
 	 $suximage 	 	 	 	 ->dx(quotemeta(2));
 	 $suximage 	 	 	 	 ->legend(quotemeta(1));
 	 $suximage 	 	 	 	 ->tstart_s(quotemeta(1200));
 	 $suximage 	 	 	 	 ->tend_s(quotemeta(0));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suop[1], $in,
		  $data_in[1], $to,
		  $suwind[1], $to,
		  $suwind[2], $to,
		  $sugain[1], $to,
		  $sufilter[1], $to,
		  $suphasevel[1], $to,
		  $suamp[1], $to,
		  $sugain[2], $to,
		  $suximage[1],
		  $go
		  );
	$flow[1] = $run->modules(\@items);


=head2 RUN FLOW(s) 


=cut

	$run->flow(\$flow[1]);



=head2 LOG FLOW(s)

	to screen and FILE

=cut

	$log->screen($flow[1]);

		$log->file(localtime);
	$log->file($flow[1]);


