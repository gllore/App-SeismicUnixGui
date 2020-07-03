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

	use message;
	use flow;
	use data_in;
	use suwind;
	use data_out;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suwind				= new suwind();
	my $data_out				= new data_out();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suwind);
	my (@data_out);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('1_120_clean'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	suwind parameter values

=cut

 	 $suwind 	 	 	 	 ->clear();
 	 $suwind 	 	 	 	 ->accept(quotemeta('none'));
 	 $suwind 	 	 	 	 ->max(quotemeta(60));
 	 $suwind 	 	 	 	 ->min(quotemeta(1));
 	 $suwind 	 	 	 	 ->setheaderword(quotemeta('tracl'));
 	 $suwind [1]  	 	 	 = $suwind ->Step();

=head2 Set up

	data_out parameter values

=cut

 	 $data_out 	 	 	 	 ->clear();
 	 $data_out 	 	 	 	 ->base_file_name(quotemeta('All'));
 	 $data_out 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_out [1]  	 	 	 = $data_out ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suwind[1], $in,
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


