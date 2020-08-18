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
	use  data_in;
	use sunix::statsMath::sumax;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sumax				= new sumax();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sumax);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta(1001));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	sumax parameter values

=cut

 	 $sumax 	 	 	 	 ->clear();
 	 $sumax 	 	 	 	 ->mode(quotemeta('maxmin'));
 	 $sumax 	 	 	 	 ->output(quotemeta('ascii'));
 	 $sumax 	 	 	 	 ->outpar(quotemeta('/dev/tty'));
 	 $sumax 	 	 	 	 ->verbose(quotemeta(1));
 	 $sumax [1]  	 	 	 = $sumax ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sumax[1], $in,
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


