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
	use sunix::segyread;
	use sunix::suxwigb;

	my $log					= new message();
	my $run					= new flow();
	my $segyread				= new segyread();
	my $suxwigb				= new suxwigb();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@segyread);
	my (@suxwigb);

=head2 Set up

	segyread parameter values

=cut

	$segyread				->clear();
	$segyread				->bfile(quotemeta('binary'));
	$segyread				->buff(quotemeta(1));
	$segyread				->conv(quotemeta(1));
	$segyread				->ebcdic(quotemeta(1));
	$segyread				->errmax(quotemeta(0));
	$segyread				->file(quotemeta('30_clean'));
	$segyread				->hfile(quotemeta('header'));
	$segyread				->over(quotemeta(0));
	$segyread				->trcwt(quotemeta(1));
	$segyread				->trmin(quotemeta(1));
	$segyread				->vblock(quotemeta(50));
	$segyread				->verbose(quotemeta(0));
	$segyread[1] 			= $segyread->Step();

=head2 Set up

	suxwigb parameter values

=cut

	$suxwigb				->clear();
	$suxwigb				->absclip(quotemeta(1));
	$suxwigb				->box_width(quotemeta(600));
	$suxwigb				->box_height(quotemeta(800));
	$suxwigb				->box_X0(quotemeta(600));
	$suxwigb				->box_Y0(quotemeta(800));
	$suxwigb				->orientation(quotemeta('seismic'));
	$suxwigb[1] 			= $suxwigb->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $segyread[1], $to,
		  $suxwigb[1],
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


