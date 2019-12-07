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
	use susort;
	use sufilter;
	use sunmo;
	use sustack;
	use sugain;
	use suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $susort				= new susort();
	my $sufilter				= new sufilter();
	my $sunmo				= new sunmo();
	my $sustack				= new sustack();
	my $sugain				= new sugain();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@susort);
	my (@sufilter);
	my (@sunmo);
	my (@sustack);
	my (@sugain);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('All_cmp'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	susort parameter values

=cut

 	 $susort 	 	 	 	 ->clear();
 	 $susort 	 	 	 	 ->header_word(quotemeta('cdp,offset'));
 	 $susort [1]  	 	 	 = $susort ->Step();

=head2 Set up

	sufilter parameter values

=cut

 	 $sufilter 	 	 	 	 ->clear();
 	 $sufilter 	 	 	 	 ->f(quotemeta('10,20,70,80'));
 	 $sufilter 	 	 	 	 ->verbose(quotemeta(0));
 	 $sufilter [1]  	 	 	 = $sufilter ->Step();

=head2 Set up

	sunmo parameter values

=cut

 	 $sunmo 	 	 	 	 ->clear();
 	 $sunmo 	 	 	 	 ->lmute(quotemeta(25));
 	 $sunmo 	 	 	 	 ->smute(quotemeta(1.5));
 	 $sunmo 	 	 	 	 ->sscale(quotemeta(1));
 	 $sunmo 	 	 	 	 ->tnmo(quotemeta('0,1'));
 	 $sunmo 	 	 	 	 ->upward(quotemeta(0));
 	 $sunmo 	 	 	 	 ->vnmo(quotemeta('100,600'));
 	 $sunmo [1]  	 	 	 = $sunmo ->Step();

=head2 Set up

	sustack parameter values

=cut

 	 $sustack 	 	 	 	 ->clear();
 	 $sustack 	 	 	 	 ->header_word(quotemeta('cdp'));
 	 $sustack 	 	 	 	 ->normpow(quotemeta(0));
 	 $sustack 	 	 	 	 ->nrepeat(quotemeta(1));
 	 $sustack 	 	 	 	 ->repeat(quotemeta(0));
 	 $sustack 	 	 	 	 ->verbose(quotemeta(0));
 	 $sustack [1]  	 	 	 = $sustack ->Step();

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
 	 $suximage 	 	 	 	 ->absclip(quotemeta(2));
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
 	 $suximage 	 	 	 	 ->box_height(quotemeta(550));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $susort[1], $in,
		  $data_in[1], $to,
		  $sufilter[1], $to,
		  $sunmo[1], $to,
		  $sustack[1], $to,
		  $sugain[1], $to,
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

	print $flow[1];

	$log->file($flow[1]);


