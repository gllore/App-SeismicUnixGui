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
	use sunix::sugethw;
	use sunix::xgraph;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sugethw				= new sugethw();
	my $xgraph				= new xgraph();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sugethw);
	my (@xgraph);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('All_cmp'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	sugethw parameter values

=cut

	$sugethw				->clear();
	$sugethw				->key(quotemeta('cdp,offset'));
	$sugethw				->output(quotemeta('binary'));
	$sugethw				->verbose(quotemeta(0));
	$sugethw[1] 			= $sugethw->Step();

=head2 Set up

	xgraph parameter values

=cut

	$xgraph				->clear();
	$xgraph				->box_height(quotemeta('600'));
	$xgraph				->y_label(quotemeta('cdp'));
	$xgraph				->x_label(quotemeta('offset (m)'));
	$xgraph				->line_widths(quotemeta(0));
	$xgraph				->num_points(quotemeta(14999));
	$xgraph				->format(quotemeta(1));
	$xgraph				->orientation(quotemeta('normal'));
	$xgraph				->box_width(quotemeta('400'));
	$xgraph				->x1_min(quotemeta(0));
	$xgraph				->x2_min(quotemeta(-80));
	$xgraph[1] 			= $xgraph->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sugethw[1], $in,
		  $data_in[1], $to,
		  $xgraph[1],
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


