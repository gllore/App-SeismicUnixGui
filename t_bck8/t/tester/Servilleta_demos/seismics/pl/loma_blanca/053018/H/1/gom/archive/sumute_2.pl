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
	use sunix::sumute;
	use sunix::sugain;
	use misc::data_out;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sumute				= new sumute();
	my $sugain				= new sugain();
	my $data_out				= new data_out();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sumute);
	my (@sugain);
	my (@data_out);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('All_cmp'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	sumute parameter values

=cut

	$sumute				->clear();
	$sumute				->header_word(quotemeta('tracr'));
	$sumute				->par_directory(quotemeta('PL_SEISMIC'));
	$sumute				->par_file(quotemeta('All_cmp_mute'));
	$sumute[1] 			= $sumute->Step();

=head2 Set up

	sugain parameter values

=cut

	$sugain				->clear();
	$sugain				->agc(quotemeta(1));
	$sugain				->width_s(quotemeta(.1));
	$sugain				->tmpdir(quotemeta('/tmp'));
	$sugain[1] 			= $sugain->Step();

=head2 Set up

	data_out parameter values

=cut

	$data_out				->clear();
	$data_out				->base_file_name(quotemeta('junk'));
	$data_out				->suffix_type(quotemeta('su'));
	$data_out[1] 			= $data_out->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sumute[1], $in,
		  $data_in[1], $to,
		  $sugain[1], $out,
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


