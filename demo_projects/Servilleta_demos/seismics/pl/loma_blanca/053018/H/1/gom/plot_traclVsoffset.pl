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
	use sugethw;
	use xgraph;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sugethw				= new sugethw();
	my $xgraph				= new xgraph();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sugethw);
	my (@xgraph);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('L28Hz_Ibeam_geom3'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	sugethw parameter values

=cut

 	 $sugethw 	 	 	 	 ->clear();
 	 $sugethw 	 	 	 	 ->key(quotemeta('tracl,ep'));
 	 $sugethw 	 	 	 	 ->output(quotemeta('binary'));
 	 $sugethw [1]  	 	 	 = $sugethw ->Step();

=head2 Set up

	xgraph parameter values

=cut

 	 $xgraph 	 	 	 	 ->clear();
 	 $xgraph 	 	 	 	 ->box_X0(quotemeta(0));
 	 $xgraph 	 	 	 	 ->box_Y0(quotemeta(0));
 	 $xgraph 	 	 	 	 ->box_height(quotemeta(600));
 	 $xgraph 	 	 	 	 ->box_width(quotemeta(400));
 	 $xgraph 	 	 	 	 ->grid1_type(quotemeta('dot'));
 	 $xgraph 	 	 	 	 ->grid2_type(quotemeta('dot'));
 	 $xgraph 	 	 	 	 ->gridColor(quotemeta(4));
 	 $xgraph 	 	 	 	 ->line_widths(quotemeta(0));
 	 $xgraph 	 	 	 	 ->mark_size_pix(quotemeta(1));
 	 $xgraph 	 	 	 	 ->num_points(quotemeta(15000));
 	 $xgraph 	 	 	 	 ->reverse(quotemeta(0));
 	 $xgraph 	 	 	 	 ->orientation(quotemeta('normal'));
 	 $xgraph 	 	 	 	 ->title(quotemeta('blue'));
 	 $xgraph 	 	 	 	 ->windowtitle(quotemeta('windowtitle'));
 	 $xgraph 	 	 	 	 ->x1_min(quotemeta(0));
 	 $xgraph 	 	 	 	 ->x1_max(quotemeta(120));
 	 $xgraph 	 	 	 	 ->x2_min(quotemeta(0));
 	 $xgraph 	 	 	 	 ->x2_max(quotemeta(100));
 	 $xgraph 	 	 	 	 ->x_label(quotemeta('ep'));
 	 $xgraph 	 	 	 	 ->y_label(quotemeta('tracl'));
 	 $xgraph [1]  	 	 	 = $xgraph ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sugethw[1], $in,
		  $data_in[1], $to,
		  $xgraph[1],
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


