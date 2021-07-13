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
	use sunix::unif2;

	my $log					= new message();
	my $run					= new flow();
	my $unif2				= new unif2();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@unif2);

=head2 Set up

	unif2 parameter values

=cut

	$unif2				->clear();
	$unif2				->dvdx(quotemeta('0.0,0.0'));
	$unif2				->dvdz(quotemeta('0.0,0.0'));
	$unif2				->dx(quotemeta(10));
	$unif2				->dz(quotemeta(10));
	$unif2				->fx(quotemeta(0.0));
	$unif2				->fz(quotemeta(0.0));
	$unif2				->method(quotemeta('linear'));
	$unif2				->ninf(quotemeta(5));
	$unif2				->npmax(quotemeta(201));
	$unif2				->nx(quotemeta(100));
	$unif2				->nz(quotemeta(100));
	$unif2				->tfile(quotemeta('testfilename'));
	$unif2				->v00(quotemeta('1500,2000,2500'));
	$unif2				->x0(quotemeta('0.0,0.0'));
	$unif2				->z0(quotemeta('0.0,0.0'));
	$unif2[1] 			= $unif2->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $unif2[1],
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


