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
	use sushw;
	use sustatic;
	use sugain;
	use sufilter;
	use data_out;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sushw				= new sushw();
	my $sustatic				= new sustatic();
	my $sugain				= new sugain();
	my $sufilter				= new sufilter();
	my $data_out				= new data_out();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sushw);
	my (@sustatic);
	my (@sugain);
	my (@sufilter);
	my (@data_out);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('LSBB1-1'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	sushw parameter values

=cut

 	 $sushw 	 	 	 	 ->clear();
 	 $sushw 	 	 	 	 ->first_value(quotemeta('9,1'));
 	 $sushw 	 	 	 	 ->headerwords(quotemeta('tstat,cdp'));
 	 $sushw 	 	 	 	 ->intra_gather_inc(quotemeta('0,1'));
 	 $sushw [1]  	 	 	 = $sushw ->Step();

=head2 Set up

	sustatic parameter values

=cut

 	 $sustatic 	 	 	 	 ->clear();
 	 $sustatic 	 	 	 	 ->hdrs(quotemeta(1));
 	 $sustatic [1]  	 	 	 = $sustatic ->Step();

=head2 Set up

	sugain parameter values

=cut

 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->mbal(quotemeta(1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [1]  	 	 	 = $sugain ->Step();

=head2 Set up

	sufilter parameter values

=cut

 	 $sufilter 	 	 	 	 ->clear();
 	 $sufilter 	 	 	 	 ->f(quotemeta('0,30,400,500'));
 	 $sufilter 	 	 	 	 ->verbose(quotemeta(0));
 	 $sufilter [1]  	 	 	 = $sufilter ->Step();

=head2 Set up

	data_out parameter values

=cut

 	 $data_out 	 	 	 	 ->clear();
 	 $data_out 	 	 	 	 ->base_file_name(quotemeta('temp1'));
 	 $data_out 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_out [1]  	 	 	 = $data_out ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sushw[1], $in,
		  $data_in[1], $to,
		  $sustatic[1], $to,
		  $sugain[1], $to,
		  $sufilter[1], $out,
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


