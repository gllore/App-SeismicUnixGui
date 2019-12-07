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
	use Project;

	my $Project = new Project();

	use misc::message;
	use misc::flow;
	use misc::data_in;
	use sunix::suop;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suop				= new suop();
	my $suximage				= new suximage();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suop);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('1000_clean'));
	$data_in				->type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	suop parameter values

=cut

	$suop				->clear();
	$suop				->op(quotemeta('abs'));
	$suop[1] 			= $suop->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->absclip(quotemeta(1));
	$suximage				->cmap(quotemeta('hsv1'));
	$suximage				->gridcolor(quotemeta('blue'));
	$suximage				->labelcolor(quotemeta('blue'));
	$suximage				->labelfont(quotemeta('Erg14'));
	$suximage				->legend(quotemeta(1));
	$suximage				->legendfont(quotemeta('times_roman10'));
	$suximage				->lwidth(quotemeta(16));
	$suximage				->lx(quotemeta(3));
	$suximage				->plotfile(quotemeta('plotfile.ps'));
	$suximage				->title(quotemeta('suximage'));
	$suximage				->titlecolor(quotemeta('red'));
	$suximage				->titlefont(quotemeta('Rom22'));
	$suximage				->units(quotemeta('unit'));
	$suximage				->windowtitle(quotemeta('suximage'));
	$suximage				->wperc(quotemeta(100));
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suop[1], $in,
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


