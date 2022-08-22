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
	use SeismicUnix qw($in $out $on $go $to $suffix_ascii $off $suffix_segd $suffix_segy $suffix_sgy $suffix_su $suffix_segd $suffix_txt $suffix_bin);
	use aliased 'App::SeismicUnixGui::configs::big_streams::Project_config';

	my $Project		= Project_config->new();
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_SEGY	= $Project->DATA_SEISMIC_SEGY;
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;

	use aliased 'App::SeismicUnixGui::misc::message';
	use aliased 'App::SeismicUnixGui::misc::flow';
	use aliased 'App::SeismicUnixGui::sunix::data::data_in';
	use aliased 'App::SeismicUnixGui::sunix::statsMath::suop';
	use aliased 'App::SeismicUnixGui::sunix::shapeNcut::suwind';
	use aliased 'App::SeismicUnixGui::sunix::shapeNcut::sugain';
	use aliased 'App::SeismicUnixGui::sunix::filter::sufilter';
	use aliased 'App::SeismicUnixGui::sunix::transform::suphasevel';
	use aliased 'App::SeismicUnixGui::sunix::transform::suamp';
	use aliased 'App::SeismicUnixGui::sunix::plot::suximage';

	my $log					=  message->new();
	my $run					=  flow->new();
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

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('pseudo_walk_piezo_cylind_wheelA1_geom1'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	suop parameter values

=cut

 	 $suop 	 	 	 	 ->clear();
 	 $suop 	 	 	 	 ->op(quotemeta('avg'));
 	 $suop [1]  	 	 	 = $suop ->Step();

=head2 Set up

	suwind parameter values

=cut

 	 $suwind 	 	 	 	 ->clear();
 	 $suwind 	 	 	 	 ->max(quotemeta(8));
 	 $suwind 	 	 	 	 ->min(quotemeta(8));
 	 $suwind 	 	 	 	 ->setheaderword(quotemeta('tracl'));
 	 $suwind 	 	 	 	 ->tmin(quotemeta(0));
 	 $suwind 	 	 	 	 ->tmax(quotemeta(.06));
 	 $suwind [1]  	 	 	 = $suwind ->Step();

=head2 Set up

	sugain parameter values

=cut

 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->mbal(quotemeta(1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [1]  	 	 	 = $sugain ->Step();

=head2 Set up

	sufilter parameter values

=cut

 	 $sufilter 	 	 	 	 ->clear();
 	 $sufilter 	 	 	 	 ->f(quotemeta('3,6,1000,2000'));
 	 $sufilter 	 	 	 	 ->verbose(quotemeta(0));
 	 $sufilter [1]  	 	 	 = $sufilter ->Step();

=head2 Set up

	suphasevel parameter values

=cut

 	 $suphasevel 	 	 	 	 ->clear();
 	 $suphasevel 	 	 	 	 ->dv(quotemeta(2000));
 	 $suphasevel 	 	 	 	 ->fmax(quotemeta(1000));
 	 $suphasevel 	 	 	 	 ->fv(quotemeta(1));
 	 $suphasevel 	 	 	 	 ->norm(quotemeta(1));
 	 $suphasevel 	 	 	 	 ->nv(quotemeta(100));
 	 $suphasevel 	 	 	 	 ->verbose(quotemeta(0));
 	 $suphasevel [1]  	 	 	 = $suphasevel ->Step();

=head2 Set up

	suamp parameter values

=cut

 	 $suamp 	 	 	 	 ->clear();
 	 $suamp 	 	 	 	 ->mode(quotemeta('amp'));
 	 $suamp [1]  	 	 	 = $suamp ->Step();

=head2 Set up

	sugain parameter values

=cut

 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->mbal(quotemeta(1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [2]  	 	 	 = $sugain ->Step();

=head2 Set up

	suximage parameter values

=cut

 	 $suximage 	 	 	 	 ->clear();
 	 $suximage 	 	 	 	 ->hiclip(quotemeta(15));
 	 $suximage 	 	 	 	 ->loclip(quotemeta(-30));
 	 $suximage 	 	 	 	 ->cmap(quotemeta('hsv12'));
 	 $suximage 	 	 	 	 ->dt(quotemeta(15.873015));
 	 $suximage 	 	 	 	 ->dx(quotemeta(2.0));
 	 $suximage 	 	 	 	 ->first_time_sample_value(quotemeta(0.0));
 	 $suximage 	 	 	 	 ->gridcolor(quotemeta('blue'));
 	 $suximage 	 	 	 	 ->ylabel(quotemeta('Hz'));
 	 $suximage 	 	 	 	 ->xlabel(quotemeta('Vs (m/s)'));
 	 $suximage 	 	 	 	 ->labelcolor(quotemeta('blue'));
 	 $suximage 	 	 	 	 ->labelfont(quotemeta('Erg14'));
 	 $suximage 	 	 	 	 ->legend(quotemeta(1));
 	 $suximage 	 	 	 	 ->legendfont(quotemeta('times_roman10'));
 	 $suximage 	 	 	 	 ->lwidth(quotemeta(16));
 	 $suximage 	 	 	 	 ->lx(quotemeta(3));
 	 $suximage 	 	 	 	 ->picks(quotemeta('/dev/tty'));
 	 $suximage 	 	 	 	 ->num_minor_ticks_betw_time_ticks(quotemeta(1));
 	 $suximage 	 	 	 	 ->num_minor_ticks_betw_distance_ticks(quotemeta(1));
 	 $suximage 	 	 	 	 ->percent4clip(quotemeta(99));
 	 $suximage 	 	 	 	 ->plotfile(quotemeta('plotfile.ps'));
 	 $suximage 	 	 	 	 ->orientation(quotemeta('seismic'));
 	 $suximage 	 	 	 	 ->title(quotemeta('suximage'));
 	 $suximage 	 	 	 	 ->titlecolor(quotemeta('red'));
 	 $suximage 	 	 	 	 ->titlefont(quotemeta('Rom22'));
 	 $suximage 	 	 	 	 ->tstart_s(quotemeta(100000));
 	 $suximage 	 	 	 	 ->tend_s(quotemeta(0));
 	 $suximage 	 	 	 	 ->units(quotemeta('unit'));
 	 $suximage 	 	 	 	 ->verbose(quotemeta(1));
 	 $suximage 	 	 	 	 ->windowtitle(quotemeta('Dispersion for A1 on wheel'));
 	 $suximage 	 	 	 	 ->box_X0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_Y0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_width(quotemeta(550));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suop[1], $in,
		  $data_in[1], $to,
		  $suwind[1], $to,
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


