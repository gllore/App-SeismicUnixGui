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
	use sunix::suwind;
	use sunix::suinterp;
	use sunix::sugain;
	use sunix::sudipfilt;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suwind				= new suwind();
	my $suinterp				= new suinterp();
	my $sugain				= new sugain();
	my $sudipfilt				= new sudipfilt();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suwind);
	my (@suinterp);
	my (@sugain);
	my (@sudipfilt);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('All_cmp'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	suwind parameter values

=cut

	$suwind				->clear();
	$suwind				->setheaderword(quotemeta('ep'));
	$suwind				->min(quotemeta(2));
	$suwind				->max(quotemeta(2));
	$suwind[1] 			= $suwind->Step();

=head2 Set up

	suinterp parameter values

=cut

	$suinterp				->clear();
	$suinterp				->deriv(quotemeta(0));
	$suinterp				->freq1(quotemeta(4.));
	$suinterp				->freq2(quotemeta(60));
	$suinterp				->iopt(quotemeta(0));
	$suinterp				->lagc(quotemeta(400));
	$suinterp				->lent(quotemeta(5));
	$suinterp				->lenx(quotemeta(1));
	$suinterp				->linear(quotemeta(0));
	$suinterp				->ninterp(quotemeta(1));
	$suinterp				->nxmax(quotemeta(500));
	$suinterp				->verbose(quotemeta(0));
	$suinterp				->xopt(quotemeta(0));
	$suinterp[1] 			= $suinterp->Step();

=head2 Set up

	sugain parameter values

=cut

	$sugain				->clear();
	$sugain				->agc(quotemeta(1));
	$sugain				->width_s(quotemeta(.1));
	$sugain				->tmpdir(quotemeta('/tmp'));
	$sugain[1] 			= $sugain->Step();

=head2 Set up

	sudipfilt parameter values

=cut

	$sudipfilt				->clear();
	$sudipfilt				->amps(quotemeta('1,1,0,.5,1'));
	$sudipfilt				->dt(quotemeta(1));
	$sudipfilt				->dx(quotemeta(.5));
	$sudipfilt				->slopes(quotemeta('0,2,4,8,16'));
	$sudipfilt				->verbose(quotemeta(1));
	$sudipfilt[1] 			= $sudipfilt->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->absclip(quotemeta(1));
	$suximage				->cmap(quotemeta('hsv0'));
	$suximage				->dx(quotemeta(1.0));
	$suximage				->gridcolor(quotemeta('blue'));
	$suximage				->ylabel(quotemeta('k 1/m dx=1 Nk=0.5'));
	$suximage				->xlabel(quotemeta('Frequency Hz dt=1 Nf=0.5'));
	$suximage				->labelcolor(quotemeta('blue'));
	$suximage				->labelfont(quotemeta('Erg14'));
	$suximage				->legend(quotemeta(1));
	$suximage				->legendfont(quotemeta('times_roman10'));
	$suximage				->lwidth(quotemeta(16));
	$suximage				->lx(quotemeta(3));
	$suximage				->picks(quotemeta('/dev/tty'));
	$suximage				->num_minor_ticks_betw_time_ticks(quotemeta(2));
	$suximage				->num_minor_ticks_betw_distance_ticks(quotemeta(2));
	$suximage				->percent4clip(quotemeta(100.0));
	$suximage				->plotfile(quotemeta('plotfile.ps'));
	$suximage				->orientation(quotemeta('seismic'));
	$suximage				->title(quotemeta('suximage'));
	$suximage				->titlecolor(quotemeta('red'));
	$suximage				->titlefont(quotemeta('Rom22'));
	$suximage				->tmpdir(quotemeta('./'));
	$suximage				->units(quotemeta('unit'));
	$suximage				->verbose(quotemeta(1));
	$suximage				->windowtitle(quotemeta('suximage'));
	$suximage				->wperc(quotemeta(100.0));
	$suximage				->box_X0(quotemeta(500));
	$suximage				->box_Y0(quotemeta(500));
	$suximage				->box_width(quotemeta(550));
	$suximage				->box_height(quotemeta(550));
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suwind[1], $in,
		  $data_in[1], $to,
		  $suinterp[1], $to,
		  $sugain[1], $to,
		  $sudipfilt[1], $to,
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


