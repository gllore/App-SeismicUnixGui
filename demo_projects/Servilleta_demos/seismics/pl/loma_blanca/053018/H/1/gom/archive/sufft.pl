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
	use sunix::sufft;
	use sunix::suamp;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sufft				= new sufft();
	my $suamp				= new suamp();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sufft);
	my (@suamp);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('1000_clean'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	sufft parameter values

=cut

	$sufft				->clear();
	$sufft				->sign(quotemeta(1));
	$sufft				->verbose(quotemeta(1));
	$sufft[1] 			= $sufft->Step();

=head2 Set up

	suamp parameter values

=cut

	$suamp				->clear();
	$suamp				->jack(quotemeta(1));
	$suamp				->mode(quotemeta('logamp'));
	$suamp				->op(quotemeta('zipper'));
	$suamp				->r(quotemeta(10.0));
	$suamp				->trend(quotemeta(1));
	$suamp				->unwrap(quotemeta(1));
	$suamp[1] 			= $suamp->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->loclip(quotemeta(0));
	$suximage				->hiclip(quotemeta(.1));
	$suximage				->cmap(quotemeta('rgb1'));
	$suximage				->legend(quotemeta(1));
	$suximage				->percent4clip(quotemeta(100));
	$suximage				->orientation(quotemeta('seismic'));
	$suximage				->title(quotemeta('suximage'));
	$suximage				->box_X0(quotemeta(800));
	$suximage				->box_Y0(quotemeta(300));
	$suximage				->box_width(quotemeta(400));
	$suximage				->box_height(quotemeta(600));
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sufft[1], $in,
		  $data_in[1], $to,
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


