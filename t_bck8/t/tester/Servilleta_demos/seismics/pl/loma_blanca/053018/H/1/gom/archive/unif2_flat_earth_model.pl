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
	use sunix::unif2;
	use sunix::ximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $unif2				= new unif2();
	my $ximage				= new ximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@unif2);
	my (@ximage);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('model00deg'));
	$data_in				->suffix_type(quotemeta('txt'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	unif2 parameter values

=cut

	$unif2				->clear();
	$unif2				->dx(quotemeta(0.05));
	$unif2				->dz(quotemeta(0.04));
	$unif2				->fx(quotemeta(0.0));
	$unif2				->fz(quotemeta(0.0));
	$unif2				->method(quotemeta('linear'));
	$unif2				->ninf(quotemeta(2));
	$unif2				->nx(quotemeta(101));
	$unif2				->nz(quotemeta(101));
	$unif2				->v00(quotemeta('1.0,1.0'));
	$unif2[1] 			= $unif2->Step();

=head2 Set up

	ximage parameter values

=cut

	$ximage				->clear();
	$ximage				->d1(quotemeta(0.04));
	$ximage				->d1num(quotemeta(0.0));
	$ximage				->d2(quotemeta(0.05));
	$ximage				->d2num(quotemeta(0.0));
	$ximage				->f1(quotemeta(0.0));
	$ximage				->f2(quotemeta(0.0));
	$ximage				->gridcolor(quotemeta('blue'));
	$ximage				->hbox(quotemeta(700));
	$ximage				->labelcolor(quotemeta('blue'));
	$ximage				->labelfont(quotemeta('Erg14'));
	$ximage				->legend(quotemeta(0));
	$ximage				->legendfont(quotemeta('times_roman10'));
	$ximage				->n1(quotemeta(101));
	$ximage				->n2(quotemeta(101));
	$ximage				->title(quotemeta('Flat Model'));
	$ximage				->titlecolor(quotemeta('red'));
	$ximage				->titlefont(quotemeta('Rom22'));
	$ximage				->units(quotemeta('unit'));
	$ximage				->verbose(quotemeta(1));
	$ximage				->windowtitle(quotemeta('Flat Model'));
	$ximage[1] 			= $ximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $unif2[1], $in,
		  $data_in[1], $to,
		  $ximage[1],
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


