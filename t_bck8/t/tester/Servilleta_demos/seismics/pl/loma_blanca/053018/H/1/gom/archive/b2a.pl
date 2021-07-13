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

	my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;

	use misc::message;
	use misc::flow;
	use misc::data_in;
	use sunix::b2a;
	use misc::data_out;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $b2a				= new b2a();
	my $data_out				= new data_out();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@b2a);
	my (@data_out);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('1001_clean'));
	$data_in				->type(quotemeta('bin'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	b2a parameter values

=cut

	$b2a				->clear();
	$b2a				->format(quotemeta(1));
	$b2a				->n1(quotemeta(2));
	$b2a				->outpar(quotemeta('/dev/tty'));
	$b2a[1] 			= $b2a->Step();

=head2 Set up

	data_out parameter values

=cut

	$data_out				->clear();
	$data_out				->base_file_name(quotemeta('junk'));
	$data_out				->type(quotemeta('txt'));
	$data_out[1] 			= $data_out->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $b2a[1], $in,
		  $data_in[1], $out,
		  $data_out[1],
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


