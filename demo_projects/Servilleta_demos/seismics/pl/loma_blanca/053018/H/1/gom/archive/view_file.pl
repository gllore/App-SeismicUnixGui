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
	use sunix::sugain;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sugain				= new sugain();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sugain);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta(quotemeta('1_120_clean_wind')));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	sugain parameter values

=cut

	$sugain				->clear();
	$sugain				->epow(quotemeta(quotemeta(0.0)));
	$sugain				->etpow(quotemeta(quotemeta(1.0)));
	$sugain				->gpow(quotemeta(quotemeta(1.0)));
	$sugain				->qclip(quotemeta(quotemeta(1.0)));
	$sugain				->scale(quotemeta(quotemeta(1.0)));
	$sugain				->norm(quotemeta(quotemeta(0.0)));
	$sugain				->bias(quotemeta(quotemeta(0.0)));
	$sugain				->tmpdir(quotemeta(quotemeta('/tmp')));
	$sugain[1] 			= $sugain->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->cmap(quotemeta(quotemeta('hsv1')));
	$suximage				->gridcolor(quotemeta(quotemeta('blue')));
	$suximage				->labelcolor(quotemeta(quotemeta('blue')));
	$suximage				->labelfont(quotemeta(quotemeta('Erg14')));
	$suximage				->legendfont(quotemeta(quotemeta('times_roman10')));
	$suximage				->lwidth(quotemeta(quotemeta(16)));
	$suximage				->lx(quotemeta(quotemeta(3)));
	$suximage				->plotfile(quotemeta(quotemeta('plotfile.ps')));
	$suximage				->title(quotemeta(quotemeta('suximage')));
	$suximage				->titlecolor(quotemeta(quotemeta('red')));
	$suximage				->titlefont(quotemeta(quotemeta('Rom22')));
	$suximage				->tmpdir(quotemeta(quotemeta('./')));
	$suximage				->units(quotemeta(quotemeta('unit')));
	$suximage				->verbose(quotemeta(quotemeta(1)));
	$suximage				->windowtitle(quotemeta(quotemeta('suximage')));
	$suximage				->wperc(quotemeta(quotemeta(100.0)));
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sugain[1], $in,
		  $data_in[1], $to,
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


