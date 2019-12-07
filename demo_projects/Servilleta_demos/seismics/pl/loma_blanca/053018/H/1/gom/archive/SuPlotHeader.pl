#!/usr/bin/perl

 use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: SuPlotHeader.pl 
 AUTHOR: Juan Lorenzo
 DESCRIPTION: script plot fold 
 DATE Version 1 Aug 26, 2016

=head2 Import 

 perl classes container and system variables
 take variables and packages directly from
 the path to the library, so as to minimize memory use

=cut

 use flow;
 use message;
 use sugethw;
 use xgraph;
 use Project_config;


=head2 Instantiate classes

  message,flow,susort,sucat,readfiles 

=cut

	my $log			= new message();
	my $run    		= new flow();
	my $suget      		= new sugethw();
	my $plot 	    	= new xgraph();
	my $Project		= new Project_config();

	
	my ($DATA_SEISMIC_SU)			= $Project->DATA_SEISMIC_SU();
	use SeismicUnix qw ($suffix_geom $suffix_su $go $in $to $out); 

=head2 Declare variables

  Make them local 

=cut

 my ($num_rows,$ref_array);
 my (@file);
 my (@inbound);
 my (@flow);
 my (@items,@suget,@plot);

=head2 Establish

 file names and directories
 inbound and outbound refer to complete paths 

=cut

	$file[1]              = 'L28Hz_Ibeam_geom';
	$file[1]              = 'L28Hz_Ibeam_geom_geom';
	$file[1]              = 'L28Hz_Ibeam_geom_geom_geom';   # has offsets
	$file[1]              =  'All_cmp';						# has CMP's
 	   
	$inbound[1] 	= $DATA_SEISMIC_SU.'/'.$file[1].$suffix_su;
	my ($xheader,$yheader,$y_min,$x_min);
	# $xheader      	= 'offset';
	# $xheader      	= 'sx';
    	$xheader      	= 'cdp';
	# $xheader      	= 'tracl';
	# $xheader      	= 'gx';
	#  $xheader      	= 'sx';
	# $yheader      	= 'offset';
	
	
	 # $yheader      	= 'cdp';
	 # $yheader      	= 'gx';
	# $yheader      	= 'ep';
	# $yheader      	= 'sx'; 
	$yheader      	= 'offset';
	my $number_pairs	 = 15000;
	$x_min        	= -80;
	$y_min        	= -80;
	my $plot_style   	= 'normal';

=head2 dump header values

=cut

    $suget->clear();
    $suget->header_words($xheader.','.$yheader);
    $suget->output('binary');
    $suget[1] = $suget->Step();

=head2 plot header values

=cut

    $plot->clear();
    $plot->num_points(($number_pairs-1));
    $plot->windowtitle(quotemeta($file[1]));
    $plot->style($plot_style);
    $plot->x2_min($y_min);
    $plot->x1_min($x_min);
    $plot->line_widths(0);
    $plot->mark_size_pix(2);
    $plot->label1(quotemeta($xheader));
    $plot->label2(quotemeta($yheader));
    $plot[1] = $plot->Step();

=head2
 
  DEFINE FLOW(S)

=cut

 @items   = ($suget[1],$in,$inbound[1],$to,$plot[1],$go);
 $flow[1] = $run->modules(\@items);

=head2
 
  RUN FLOW(S)

=cut

  $run->flow(\$flow[1]);

=head2
 
  LOG FLOW(S)

=cut

  print $flow[1]."\n\n";
# $log->file($flow[1]);

