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
	use  suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->hiclip(quotemeta(10));
 	 $data_in 	 	 	 	 ->loclip(quotemeta(-20));
 	 $data_in 	 	 	 	 ->cmap(quotemeta('hsv6'));
 	 $data_in 	 	 	 	 ->dt(quotemeta(1));
 	 $data_in 	 	 	 	 ->dx(quotemeta(1));
 	 $data_in 	 	 	 	 ->gridcolor(quotemeta('blue'));
 	 $data_in 	 	 	 	 ->ylabel(quotemeta('Frequency (Hz)'));
 	 $data_in 	 	 	 	 ->xlabel(quotemeta('Phase Velocity m/s'));
 	 $data_in 	 	 	 	 ->labelcolor(quotemeta('blue'));
 	 $data_in 	 	 	 	 ->labelfont(quotemeta('Erg14'));
 	 $data_in 	 	 	 	 ->legend(quotemeta(1));
 	 $data_in 	 	 	 	 ->legendfont(quotemeta('times_roman12'));
 	 $data_in 	 	 	 	 ->picks(quotemeta('/dev/tty'));
 	 $data_in 	 	 	 	 ->num_minor_ticks_betw_time_ticks(quotemeta(1));
 	 $data_in 	 	 	 	 ->num_minor_ticks_betw_distance_ticks(quotemeta(1));
 	 $data_in 	 	 	 	 ->percent4clip(quotemeta(100.0));
 	 $data_in 	 	 	 	 ->plotfile(quotemeta('plotfile.ps'));
 	 $data_in 	 	 	 	 ->orientation(quotemeta('seismic'));
 	 $data_in 	 	 	 	 ->title(quotemeta('suximage'));
 	 $data_in 	 	 	 	 ->titlecolor(quotemeta('red'));
 	 $data_in 	 	 	 	 ->titlefont(quotemeta('Rom22'));
 	 $data_in 	 	 	 	 ->tmpdir(quotemeta('./'));
 	 $data_in 	 	 	 	 ->units(quotemeta('unit'));
 	 $data_in 	 	 	 	 ->verbose(quotemeta(1));
 	 $data_in 	 	 	 	 ->windowtitle(quotemeta('Raw data'));
 	 $data_in 	 	 	 	 ->wperc(quotemeta(100.0));
 	 $data_in 	 	 	 	 ->box_X0(quotemeta(500));
 	 $data_in 	 	 	 	 ->box_Y0(quotemeta(500));
 	 $data_in 	 	 	 	 ->box_width(quotemeta(700));
 	 $data_in 	 	 	 	 ->box_height(quotemeta(600));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	suximage parameter values

=cut

 	 $suximage 	 	 	 	 ->clear();
 	 $suximage 	 	 	 	 ->hiclip(quotemeta(10));
 	 $suximage 	 	 	 	 ->loclip(quotemeta(-30));
 	 $suximage 	 	 	 	 ->cmap(quotemeta('hsv6'));
 	 $suximage 	 	 	 	 ->dt(quotemeta(1));
 	 $suximage 	 	 	 	 ->dx(quotemeta(1));
 	 $suximage 	 	 	 	 ->gridcolor(quotemeta('blue'));
 	 $suximage 	 	 	 	 ->ylabel(quotemeta('Frequency (Hz)'));
 	 $suximage 	 	 	 	 ->xlabel(quotemeta('Phase Velocity m/s'));
 	 $suximage 	 	 	 	 ->labelcolor(quotemeta('blue'));
 	 $suximage 	 	 	 	 ->labelfont(quotemeta('Erg14'));
 	 $suximage 	 	 	 	 ->legend(quotemeta(1));
 	 $suximage 	 	 	 	 ->legendfont(quotemeta('times_roman12'));
 	 $suximage 	 	 	 	 ->picks(quotemeta('/dev/tty'));
 	 $suximage 	 	 	 	 ->num_minor_ticks_betw_time_ticks(quotemeta(1));
 	 $suximage 	 	 	 	 ->num_minor_ticks_betw_distance_ticks(quotemeta(1));
 	 $suximage 	 	 	 	 ->percent4clip(quotemeta(100.0));
 	 $suximage 	 	 	 	 ->plotfile(quotemeta('plotfile.ps'));
 	 $suximage 	 	 	 	 ->orientation(quotemeta('seismic'));
 	 $suximage 	 	 	 	 ->title(quotemeta('suximage'));
 	 $suximage 	 	 	 	 ->titlecolor(quotemeta('red'));
 	 $suximage 	 	 	 	 ->titlefont(quotemeta('Rom22'));
 	 $suximage 	 	 	 	 ->tmpdir(quotemeta('./'));
 	 $suximage 	 	 	 	 ->units(quotemeta('unit'));
 	 $suximage 	 	 	 	 ->verbose(quotemeta(1));
 	 $suximage 	 	 	 	 ->windowtitle(quotemeta('Raw data'));
 	 $suximage 	 	 	 	 ->wperc(quotemeta(100.0));
 	 $suximage 	 	 	 	 ->box_X0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_Y0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_width(quotemeta(700));
 	 $suximage 	 	 	 	 ->box_height(quotemeta(600));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suximage[1], $in,
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


