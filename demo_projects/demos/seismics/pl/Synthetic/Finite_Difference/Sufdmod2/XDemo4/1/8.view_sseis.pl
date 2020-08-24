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
	use  data_in;
	use  suxwigb;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suxwigb				= new suxwigb();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suxwigb);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('sseis'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	suxwigb parameter values

=cut

 	 $suxwigb 	 	 	 	 ->clear();
 	 $suxwigb 	 	 	 	 ->absclip(quotemeta(.5));
 	 $suxwigb 	 	 	 	 ->box_width(quotemeta(450));
 	 $suxwigb 	 	 	 	 ->box_height(quotemeta(450));
 	 $suxwigb 	 	 	 	 ->box_X0(quotemeta(930));
 	 $suxwigb 	 	 	 	 ->box_Y0(quotemeta(530));
 	 $suxwigb 	 	 	 	 ->orientation(quotemeta('seismic'));
 	 $suxwigb 	 	 	 	 ->title(quotemeta('Source point seismogram'));
 	 $suxwigb 	 	 	 	 ->windowtitle(quotemeta('Source'));
 	 $suxwigb 	 	 	 	 ->xlabel(quotemeta('Trace'));
 	 $suxwigb 	 	 	 	 ->ylabel(quotemeta('Time (sec)'));
 	 $suxwigb [1]  	 	 	 = $suxwigb ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suxwigb[1], $in,
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


