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
	use ximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $ximage				= new ximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@ximage);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('dummy_zero'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('bin'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	ximage parameter values

=cut

 	 $ximage 	 	 	 	 ->clear();
 	 $ximage 	 	 	 	 ->balance(quotemeta(1.));
 	 $ximage 	 	 	 	 ->blank(quotemeta(0));
 	 $ximage 	 	 	 	 ->blockinterp(quotemeta(0));
 	 $ximage 	 	 	 	 ->cmap(quotemeta('hsv1'));
 	 $ximage 	 	 	 	 ->d1(quotemeta(1.0));
 	 $ximage 	 	 	 	 ->d1num(quotemeta(0.0));
 	 $ximage 	 	 	 	 ->d2(quotemeta(1.0));
 	 $ximage 	 	 	 	 ->d2num(quotemeta(0.0));
 	 $ximage 	 	 	 	 ->f1(quotemeta(0.0));
 	 $ximage 	 	 	 	 ->f2(quotemeta(0.0));
 	 $ximage 	 	 	 	 ->hbox(quotemeta(700));
 	 $ximage 	 	 	 	 ->label2(quotemeta('label'));
 	 $ximage 	 	 	 	 ->labelcolor(quotemeta('blue'));
 	 $ximage 	 	 	 	 ->labelfont(quotemeta('Erg14'));
 	 $ximage 	 	 	 	 ->legend(quotemeta(0));
 	 $ximage 	 	 	 	 ->legendfont(quotemeta('times_roman10'));
 	 $ximage 	 	 	 	 ->mpicks(quotemeta('/dev/tty'));
 	 $ximage 	 	 	 	 ->n1(quotemeta(100));
 	 $ximage 	 	 	 	 ->n1tic(quotemeta(1));
 	 $ximage 	 	 	 	 ->n2tic(quotemeta(1));
 	 $ximage 	 	 	 	 ->plotfile(quotemeta('plotfile.ps'));
 	 $ximage 	 	 	 	 ->style(quotemeta('seismic'));
 	 $ximage 	 	 	 	 ->title(quotemeta('title'));
 	 $ximage 	 	 	 	 ->titlecolor(quotemeta('red'));
 	 $ximage 	 	 	 	 ->titlefont(quotemeta('Rom22'));
 	 $ximage 	 	 	 	 ->units(quotemeta('unit'));
 	 $ximage 	 	 	 	 ->verbose(quotemeta(0));
 	 $ximage 	 	 	 	 ->wbox(quotemeta(550));
 	 $ximage 	 	 	 	 ->windowtitle(quotemeta('ximage'));
 	 $ximage 	 	 	 	 ->xbox(quotemeta(500));
 	 $ximage 	 	 	 	 ->ybox(quotemeta(500));
 	 $ximage [1]  	 	 	 = $ximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $ximage[1], $in,
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


