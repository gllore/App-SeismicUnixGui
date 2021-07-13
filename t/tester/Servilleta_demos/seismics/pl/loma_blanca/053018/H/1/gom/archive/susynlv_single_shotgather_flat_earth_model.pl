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
	use sunix::susynlv;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $susynlv				= new susynlv();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@susynlv);
	my (@suximage);

=head2 Set up

	susynlv parameter values

=cut

	$susynlv				->clear();
	$susynlv				->dt(quotemeta(0.008));
	$susynlv				->dvdx(quotemeta(0.0));
	$susynlv				->dvdz(quotemeta(0.0));
	$susynlv				->dxo(quotemeta(0.05));
	$susynlv				->dxs(quotemeta(0.05));
	$susynlv				->er(quotemeta(1));
	$susynlv				->ft(quotemeta(0.0));
	$susynlv				->fxo(quotemeta(0.05));
	$susynlv				->fxs(quotemeta(0.0));
	$susynlv				->nt(quotemeta(750));
	$susynlv				->nxs(quotemeta(1));
	$susynlv				->ob(quotemeta(1));
	$susynlv				->reflector(quotemeta('1.0:0.0,1.0;5.0,1.0'));
	$susynlv				->smooth(quotemeta(0));
	$susynlv				->v00(quotemeta(2.0));
	$susynlv				->verbose(quotemeta(0));
	$susynlv[1] 			= $susynlv->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->cmap(quotemeta('hsv0'));
	$suximage				->dx(quotemeta(1.0));
	$suximage				->first_time_sample_value(quotemeta(0.0));
	$suximage				->gridcolor(quotemeta('blue'));
	$suximage				->ylabel(quotemeta('Time (s)'));
	$suximage				->xlabel(quotemeta('Distance (km)'));
	$suximage				->labelcolor(quotemeta('blue'));
	$suximage				->labelfont(quotemeta('Erg14'));
	$suximage				->legend(quotemeta(1));
	$suximage				->legendfont(quotemeta('times_roman10'));
	$suximage				->lwidth(quotemeta(16));
	$suximage				->lx(quotemeta(3));
	$suximage				->picks(quotemeta('/dev/tty'));
	$suximage				->num_minor_ticks_betw_time_ticks(quotemeta(1));
	$suximage				->num_minor_ticks_betw_distance_ticks(quotemeta(1));
	$suximage				->percent4clip(quotemeta(99));
	$suximage				->plotfile(quotemeta('plotfile.ps'));
	$suximage				->orientation(quotemeta('seismic'));
	$suximage				->title(quotemeta('Zero Dip Shot Record'));
	$suximage				->titlecolor(quotemeta('red'));
	$suximage				->titlefont(quotemeta('Rom22'));
	$suximage				->tmpdir(quotemeta('./'));
	$suximage				->units(quotemeta('unit'));
	$suximage				->verbose(quotemeta(1));
	$suximage				->windowtitle(quotemeta('Zero Dip Shot'));
	$suximage				->wperc(quotemeta(100.0));
	$suximage				->box_X0(quotemeta(500));
	$suximage				->box_Y0(quotemeta(500));
	$suximage				->box_width(quotemeta(550));
	$suximage				->box_height(quotemeta(550));
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $susynlv[1], $to,
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


