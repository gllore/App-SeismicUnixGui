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
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
	use Project_config;

	my $Project		= new Project_config();
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;

	use misc::message;
	use misc::flow;
	use sunix::statsMath::suop2;
	use  data_out;

	my $log					= new message();
	my $run					= new flow();
	my $suop2				= new suop2();
	my $data_out				= new data_out();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@suop2);
	my (@data_out);

=head2 Set up

	suop2 parameter values

=cut

 	 $suop2 	 	 	 	 ->clear();
 	 $suop2 	 	 	 	 ->file1(quotemeta($DATA_SEISMIC_SU.'/'.'1001_clean'.$suffix_su));
 	 $suop2 	 	 	 	 ->file2(quotemeta($DATA_SEISMIC_SU.'/'.'1001_clean'.$suffix_su));
 	 $suop2 	 	 	 	 ->op(quotemeta('diff'));
 	 $suop2 	 	 	 	 ->trid(quotemeta(111));
 	 $suop2 	 	 	 	 ->w1(quotemeta(1.0));
 	 $suop2 	 	 	 	 ->w2(quotemeta(1.0));
 	 $suop2 [1]  	 	 	 = $suop2 ->Step();

=head2 Set up

	data_out parameter values

=cut

 	 $data_out 	 	 	 	 ->clear();
 	 $data_out 	 	 	 	 ->base_file_name(quotemeta('junk'));
 	 $data_out 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_out [1]  	 	 	 = $data_out ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suop2[1], $out,
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


