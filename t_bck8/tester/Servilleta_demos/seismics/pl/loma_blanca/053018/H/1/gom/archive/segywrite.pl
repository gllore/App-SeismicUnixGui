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
	use sunix::segywrite;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $segywrite				= new segywrite();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@segywrite);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('1000_clean'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	segywrite parameter values

=cut

	$segywrite				->clear();
	$segywrite				->bfile(quotemeta('binary'));
	$segywrite				->buff(quotemeta(1));
	$segywrite				->conv(quotemeta(1));
	$segywrite				->ebcdic(quotemeta(1));
	$segywrite				->errmax(quotemeta(0));
	$segywrite				->file(quotemeta('junk'));
	$segywrite				->vblock(quotemeta(50));
	$segywrite				->verbose(quotemeta(0));
	$segywrite[1] 			= $segywrite->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $segywrite[1], $in,
		  $data_in[1],
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


