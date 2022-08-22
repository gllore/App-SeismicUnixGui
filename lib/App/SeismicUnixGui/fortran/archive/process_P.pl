=head2 SYNOPSIS

 PACKAGE NAME: process_P.pl

 AUTHOR:  Juan Lorenzo

 DATE: 4-22-19

 DESCRIPTION:
 Select a portion of data from an *.su file

 Xmassage.sh takes the outpu file from suwind and filters 
 and gains it for input to mmodpg.

  premmod reads a *.su file, and creates the file: datammod
  which is a binary fortran file containing the su file with
  no headers, and that
  can be read by program mmodpg.
  It also creates the ascii file: parmmod  containing

 Xamine.sh filters and gains the data file and outputs an image for
 quality control by the user

 Version: 0.0.1 10-21-05 as a shell script
 		  0.0.2 10-31-07
		  0.0.3 4-22-19  made into a perl script
=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut

	use Moose;
	use App::SeismicUnixGui::misc::SeismicUnix qw($in $out $on $go $to $suffix_ascii $off $suffix_su);
	use App::SeismicUnixGui::configs::big_streams::Project_config;

	my $Project = Project_config->new();

	my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;

	use aliased 'App::SeismicUnixGui::misc::message';
	use aliased 'App::SeismicUnixGui::misc::flow';
	use  data_in;
	use sunix::shapeNcut::suwind;
	use  sufilter;
	use sunix::shapeNcut::sugain;
	use  suximage;
	use  data_out;
	
	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suwind				= new suwind();
	my $sufilter			= new sufilter();
	my $sugain				= new sugain();
	my $suximage			= new suximage();
	my $data_out			= new data_out();

=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suwind);
	my (@sufilter);
	my (@sugain);
	my (@suximage);	
	my (@data_out);
	
=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('1008_9_clean2_geom2'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();
	
=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('junk'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[2] 			= $data_in->Step();
	
=head2 Set up

	suwind parameter values

=cut

	$suwind				->clear();
	$suwind				->tmin(quotemeta(0));
	$suwind				->tmax(quotemeta(.1));
	$suwind[1] 			= $suwind->Step();

=head2 Set up

	sufilter parameter values

=cut

	$sufilter				->clear();
	$sufilter				->f(quotemeta('0,3,400,500'));
	$sufilter[1] 			= $sufilter->Step();

=head2 Set up

	sugain parameter values

=cut

	$sugain				->clear();
	$sugain				->pbal(quotemeta(1));
	#$sugain				->width_s(quotemeta(.01));
	$sugain[1] 			= $sugain->Step();


=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->absclip(quotemeta(8));
	$suximage				->cmap(quotemeta('hsv0'));
	$suximage				->first_time_sample_value(quotemeta(0.0));
	$suximage				->gridcolor(quotemeta('blue'));
	$suximage				->labelcolor(quotemeta('blue'));
	$suximage				->labelfont(quotemeta('Erg14'));
	$suximage				->legend(quotemeta(1));
	$suximage				->legendfont(quotemeta('times_roman10'));
	$suximage				->lwidth(quotemeta(16));
	$suximage				->lx(quotemeta(3));
	$suximage				->picks(quotemeta('/dev/tty'));
	$suximage				->num_minor_ticks_betw_time_ticks(quotemeta(1));
	$suximage				->num_minor_ticks_betw_distance_ticks(quotemeta(1));
	$suximage				->percent4clip(quotemeta(100.0));
	$suximage				->plotfile(quotemeta('plotfile.ps'));
	$suximage				->orientation(quotemeta('seismic'));
	$suximage				->title(quotemeta('sequential traces'));
	$suximage				->titlecolor(quotemeta('red'));
	$suximage				->titlefont(quotemeta('Rom22'));
	$suximage				->tmpdir(quotemeta('./'));
	$suximage				->units(quotemeta('unit'));
	$suximage				->verbose(quotemeta(1));
	$suximage				->windowtitle(quotemeta('suximage'));
	$suximage				->box_X0(quotemeta(500));
	$suximage				->box_Y0(quotemeta(500));
	$suximage				->box_width(quotemeta(550));
	$suximage				->box_height(quotemeta(550));
	$suximage[1] 			= $suximage->Step();


=head2 Set up

	data_out parameter values

=cut

	$data_out				->clear();
	$data_out				->base_file_name(quotemeta('junk'));
	$data_out				->suffix_type(quotemeta('su'));
	$data_out[1] 			= $data_out->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suwind[1], $in,
		  $data_in[1], $to,
#		  $sufilter[1], $out,
		  $sugain[1], $out,
		  $data_out[1],
		  $go
		  );
	$flow[1] = $run->modules(\@items);
	
	 @items	= (
		  $suwind[1], $in,
		  $data_in[2],$to,		 
		  $suximage[1],
		  $go
		  );
	$flow[2] = $run->modules(\@items);	


=head2 RUN FLOW(s) 


=cut

 	$run->flow(\$flow[1]);


=head2 LOG FLOW(s)

	to screen and FILE

=cut

	#print $flow[1];
	
	#$log->file($flow[1]);
	
=head2 RUN FLOW(s) 


=cut

 	 my $input = $DATA_SEISMIC_SU.'/'.'junk.su';
  	# print("\n process_p.pl, DATA_SEIMIC_SU/file = $input \n");
  	 system ("perl ./premmod.pl $input");

	# QC file for mmodpg
        $run->flow(\$flow[2]);
    
    
=head2 LOG FLOW(s)

	to screen and FILE

=cut

#	print $flow[2];
	
#	$log->file($flow[2]);
	
=head2 RUN FLOW(s) 

=cut

# House cleaning!
# system("rm $input  &");

# run mmodpg
  system("/usr/local/bin/mmodpg1.1");
#  system("/usr/local/bin/mmodpg2");

