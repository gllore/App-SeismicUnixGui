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
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
	use Project_config;

	my $Project = new Project_config();

	my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;

	use misc::message;
	use misc::flow;
	use misc::data_in;
	use sunix::susort;
	use sunix::suwind;
	use sunix::suphasevel;
	use sunix::suamp;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $susort				= new susort();
	my $suwind				= new suwind();
	my $suphasevel				= new suphasevel();
	my $suamp				= new suamp();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@susort);
	my (@suwind);
	my (@suphasevel);
	my (@suamp);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('All_cmp'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	susort parameter values

=cut

	$susort				->clear();
	$susort				->header_word(quotemeta('ep,offset'));
	$susort[1] 			= $susort->Step();

=head2 Set up

	suwind parameter values

=cut

	$suwind				->clear();
	$suwind				->setheaderword(quotemeta('ep'));
	$suwind				->min(quotemeta(1));
	$suwind				->max(quotemeta(1));
	$suwind				->tmin(quotemeta(0.0));
	$suwind				->tmax(quotemeta(0.6));
	$suwind[1] 			= $suwind->Step();

=head2 Set up

	suphasevel parameter values

=cut

	$suphasevel				->clear();
	$suphasevel				->dv(quotemeta(1));
	$suphasevel				->fmax(quotemeta(100));
	$suphasevel				->fv(quotemeta(10));
	$suphasevel				->norm(quotemeta(1));
	$suphasevel				->nv(quotemeta(600));
	$suphasevel				->verbose(quotemeta(0));
	$suphasevel[1] 			= $suphasevel->Step();

=head2 Set up

	suamp parameter values

=cut

	$suamp				->clear();
	$suamp				->mode(quotemeta('real'));
	$suamp[1] 			= $suamp->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->loclip(quotemeta(0));
	$suximage				->hiclip(quotemeta(400));
	$suximage				->cmap(quotemeta('hsv6'));
	$suximage				->dt(quotemeta(1));
	$suximage				->dx(quotemeta(1));
	$suximage				->gridcolor(quotemeta('blue'));
	$suximage				->ylabel(quotemeta('Frequency (Hz)'));
	$suximage				->xlabel(quotemeta('Phase Velocity m/s'));
	$suximage				->labelcolor(quotemeta('blue'));
	$suximage				->labelfont(quotemeta('Erg14'));
	$suximage				->legend(quotemeta(1));
	$suximage				->legendfont(quotemeta('times_roman12'));
	$suximage				->picks(quotemeta('/dev/tty'));
	$suximage				->num_minor_ticks_betw_time_ticks(quotemeta(1));
	$suximage				->num_minor_ticks_betw_distance_ticks(quotemeta(1));
	$suximage				->percent4clip(quotemeta(100.0));
	$suximage				->plotfile(quotemeta('plotfile.ps'));
	$suximage				->orientation(quotemeta('seismic'));
	$suximage				->title(quotemeta('suximage'));
	$suximage				->titlecolor(quotemeta('red'));
	$suximage				->titlefont(quotemeta('Rom22'));
	$suximage				->tmpdir(quotemeta('./'));
	$suximage				->units(quotemeta('unit'));
	$suximage				->verbose(quotemeta(1));
	$suximage				->windowtitle(quotemeta('Dispersion Image'));
	$suximage				->wperc(quotemeta(100.0));
	$suximage				->box_X0(quotemeta(500));
	$suximage				->box_Y0(quotemeta(500));
	$suximage				->box_width(quotemeta(700));
	$suximage				->box_height(quotemeta(600));
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $susort[1], $in,
		  $data_in[1], $to,
		  $suwind[1], $to,
		  $suphasevel[1], $to,
		  $suamp[1], $to,
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

	print $flow[1];

	$log->file($flow[1]);


