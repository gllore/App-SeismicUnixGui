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
	use App::SeismicUnixGui::misc::SeismicUnix qw($in $out $on $go $to $suffix_ascii $off $suffix_segd $suffix_segy $suffix_sgy $suffix_su $suffix_segd $suffix_txt $suffix_bin);
	use App::SeismicUnixGui::configs::big_streams::Project_config;

	my $Project		= Project_config->new();
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_SEGY	= $Project->DATA_SEISMIC_SEGY;
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;

	use App::SeismicUnixGui::misc::message;
	use App::SeismicUnixGui::misc::flow;
	use App::SeismicUnixGui::sunix::data::data_in;
	use App::SeismicUnixGui::sunix::shapeNcut::sugain;
	use App::SeismicUnixGui::sunix::plot::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sugain				= new sugain();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sugain);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('1_126_clean'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	sugain parameter values

=cut

 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->agc(quotemeta(1));
 	 $sugain 	 	 	 	 ->width_s(quotemeta(.2));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [1]  	 	 	 = $sugain ->Step();

=head2 Set up

	suximage parameter values

=cut

 	 $suximage 	 	 	 	 ->clear();
 	 $suximage 	 	 	 	 ->absclip(quotemeta(5));
 	 $suximage 	 	 	 	 ->cmap(quotemeta('hsv0'));
 	 $suximage 	 	 	 	 ->dx(quotemeta(1.0));
 	 $suximage 	 	 	 	 ->first_time_sample_value(quotemeta(0.0));
 	 $suximage 	 	 	 	 ->gridcolor(quotemeta('blue'));
 	 $suximage 	 	 	 	 ->labelcolor(quotemeta('blue'));
 	 $suximage 	 	 	 	 ->labelfont(quotemeta('Erg14'));
 	 $suximage 	 	 	 	 ->legend(quotemeta(1));
 	 $suximage 	 	 	 	 ->legendfont(quotemeta('times_roman10'));
 	 $suximage 	 	 	 	 ->lwidth(quotemeta(16));
 	 $suximage 	 	 	 	 ->lx(quotemeta(3));
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
 	 $suximage 	 	 	 	 ->windowtitle(quotemeta('suximage'));
 	 $suximage 	 	 	 	 ->wperc(quotemeta(100.0));
 	 $suximage 	 	 	 	 ->box_X0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_Y0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_width(quotemeta(550));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sugain[1], $in,
		  $data_in[1], $to,
		  $suximage[1],
		  $go
		  );
	$flow[1] = $run->modules(\@items);


=head2 RUN FLOW(s) 


=cut

	$run->flow(\$flow[1]);



=head2 LOG FLOW(s)

	to screen and FILE

=cut

	$log->screen($flow[1]);

		$log->file(localtime);
	$log->file($flow[1]);


