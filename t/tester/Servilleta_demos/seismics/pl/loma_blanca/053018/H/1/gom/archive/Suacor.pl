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
	use sunix::suacor;
	use sunix::suxwigb;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suacor				= new suacor();
	my $suxwigb				= new suxwigb();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suacor);
	my (@suxwigb);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name('60_clean');
	$data_in				->type('su');
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	suacor parameter values

=cut

	$suacor				->clear();
	$suacor[1] 			= $suacor->Step();

=head2 Set up

	suxwigb parameter values

=cut

	$suxwigb				->clear();
	$suxwigb				->absclip(1);
	$suxwigb				->box_width(200);
	$suxwigb				->box_height(200);
	$suxwigb				->orientation('seismic');
	$suxwigb				->number_of_traces('all');
	$suxwigb[1] 			= $suxwigb->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suacor[1], $in,
		  $data_in[1], $to,
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


