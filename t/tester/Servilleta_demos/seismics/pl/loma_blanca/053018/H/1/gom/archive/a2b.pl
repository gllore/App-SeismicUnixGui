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
	use sunix::a2b;
	use sunix::xgraph;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $a2b				= new a2b();
	my $xgraph				= new xgraph();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@a2b);
	my (@xgraph);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->floats_per_line(quotemeta(2));
	$data_in				->outpar(quotemeta('/dev/null'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	a2b parameter values

=cut

