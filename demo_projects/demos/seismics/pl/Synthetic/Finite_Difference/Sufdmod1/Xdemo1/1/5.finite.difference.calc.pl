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
	use  sufdmod1;
	use  data_out;

	my $log					= new message();
	my $run					= new flow();
	my $sufdmod1				= new sufdmod1();
	my $data_out				= new data_out();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@sufdmod1);
	my (@data_out);

=head2 Set up

	sufdmod1 parameter values

=cut

 	 $sufdmod1 	 	 	 	 ->clear();
 	 $sufdmod1 	 	 	 	 ->boundary_conditions(quotemeta('1,1'));
 	 $sufdmod1 	 	 	 	 ->density_file_bin(quotemeta($DATA_SEISMIC_BIN.'/'.'density'.$suffix_bin));
 	 $sufdmod1 	 	 	 	 ->dz(quotemeta(1));
 	 $sufdmod1 	 	 	 	 ->freq(quotemeta(15));
 	 $sufdmod1 	 	 	 	 ->fz(quotemeta(0));
 	 $sufdmod1 	 	 	 	 ->nz(quotemeta(2001));
 	 $sufdmod1 	 	 	 	 ->press(quotemeta(0));
 	 $sufdmod1 	 	 	 	 ->receiver_depth(quotemeta(1));
 	 $sufdmod1 	 	 	 	 ->source_type(quotemeta(1));
 	 $sufdmod1 	 	 	 	 ->source_depth(quotemeta(1));
 	 $sufdmod1 	 	 	 	 ->tmax(quotemeta(1));
 	 $sufdmod1 	 	 	 	 ->verbose(quotemeta(0));
 	 $sufdmod1 	 	 	 	 ->velocity_file_bin(quotemeta($DATA_SEISMIC_BIN.'/'.'velocity'.$suffix_bin));
 	 $sufdmod1 [1]  	 	 	 = $sufdmod1 ->Step();

=head2 Set up

	data_out parameter values

=cut

 	 $data_out 	 	 	 	 ->clear();
 	 $data_out 	 	 	 	 ->base_file_name(quotemeta('junk2'));
 	 $data_out 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_out [1]  	 	 	 = $data_out ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sufdmod1[1], $out,
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


