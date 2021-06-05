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
	use sugain;
	use suphasevel;
	use suamp;
	use suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sugain				= new sugain();
	my $suphasevel				= new suphasevel();
	my $suamp				= new suamp();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sugain);
	my (@suphasevel);
	my (@suamp);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('zreflectionz'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	sugain parameter values

=cut

 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->agc(quotemeta(1));
 	 $sugain 	 	 	 	 ->width_s(quotemeta(.1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [1]  	 	 	 = $sugain ->Step();

=head2 Set up

	sugain parameter values

=cut

 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->pbal(quotemeta(1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [2]  	 	 	 = $sugain ->Step();

=head2 Set up

	suphasevel parameter values

=cut

 	 $suphasevel 	 	 	 	 ->clear();
 	 $suphasevel 	 	 	 	 ->dv(quotemeta(10));
 	 $suphasevel 	 	 	 	 ->fmax(quotemeta(100));
 	 $suphasevel 	 	 	 	 ->fv(quotemeta(330));
 	 $suphasevel 	 	 	 	 ->norm(quotemeta(1));
 	 $suphasevel 	 	 	 	 ->nv(quotemeta(1000));
 	 $suphasevel 	 	 	 	 ->verbose(quotemeta(0));
 	 $suphasevel [1]  	 	 	 = $suphasevel ->Step();

=head2 Set up

	suamp parameter values

=cut

 	 $suamp 	 	 	 	 ->clear();
 	 $suamp 	 	 	 	 ->mode(quotemeta('real'));
 	 $suamp [1]  	 	 	 = $suamp ->Step();

=head2 Set up

	suximage parameter values

=cut

 	 $suximage 	 	 	 	 ->clear();
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
 	 $suximage 	 	 	 	 ->units(quotemeta('unit'));
 	 $suximage 	 	 	 	 ->verbose(quotemeta(1));
 	 $suximage 	 	 	 	 ->windowtitle(quotemeta('suximage'));
 	 $suximage 	 	 	 	 ->box_X0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_Y0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_width(quotemeta(550));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sugain[1], $in,
		  $data_in[1], $to,
		  $sugain[2], $to,
		  $suphasevel[1], $to,
		  $suamp[1], $to,
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


