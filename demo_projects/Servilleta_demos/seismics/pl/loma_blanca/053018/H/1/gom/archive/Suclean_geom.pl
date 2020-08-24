#! /bin/perl
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: Suclean_geom.pl 
 AUTHOR: Juan Lorenzo
 DESCRIPTION: script to clean and add geomtery to headers
 DATE Version 1 June 3, 2012
 DATE Dec 31 2014 converting to Moose
 DATE Feb. 18, 2015 adapt for False River case
 DATE June 1, 2016 adapt for Bueche property at False River case
 DATE May 31 2018  adapt for loma blanca IRIS2018 Internship Orientation week

=head2 Call modules

=cut
	use Project;
	use sushw;
	use suchw;
	use message;
	use flow;

=head2 instantiate classes

=cut
	my $Project = Project -> new();
	my $log				= new message();
 	my $run    			= new flow();
 	my $suchw           = new suchw();
 	my $sushw           = new sushw();


=head2 Import 

 perl classes container and system variables

=cut
	my ($DATA_SEISMIC_SU)		= $Project->DATA_SEISMIC_SU();
	my ($DATA_SEISMIC_SEGY)		= $Project->DATA_SEISMIC_SEGY();
	use SeismicUnix qw ($suffix_segy $suffix_su $suffix_ascii $suffix_bin $suffix_geom $suffix_hyphen $suffix_lsu $go $in $to $out); 


=head2 Declare variables

  Make them local 

=cut
	my ($endian,$num_files,$i);
	my (@segyfile,@segyfile_in,@segyfile_out);
 	my (@segyread,@segyread_inbound,@segyread_outbound);
 	my (@file,@sufile);
 	my (@sufile_inbound,@sufile_outbound);
 	my (@sufile_in,@sufile_out);
 	my (@flow,@suchw,@sushw);
 	my (@sushw_outbound,@sushw_headers_to_wipe,@sushw_replace_w_);
 	my (@sushw_inbound);
 	my (@items);

=head2 Establish

 file names and directories
 inbound and outbound refer to complete paths 

=cut
	$file[1] 			= 'L28Hz_Ibeam';

	$sufile_in[1] 		= $file[1].$suffix_su;
	$sufile_inbound[1] 	= $DATA_SEISMIC_SU.'/'.$sufile_in[1];
	$sufile_outbound[1] = $DATA_SEISMIC_SU.'/'.$file[1].$suffix_geom.$suffix_su;

=head2 sushw information

 clean the unused header values
 but keep field traces fldr

=cut
	$sushw_inbound[1]	 		= $sufile_inbound[1];
	$sushw_outbound[1]     	= $sufile_outbound[1]; 

 $sushw_headers_to_wipe[1] 	=  'tracl,tracr,tracf,cdp,cdpt,trid,nvs,nhs,duse,swdep,scalel,scalco,counit,sx,sy,ep,fldr,year,day,minute,hour,sec';
 $sushw_replace_w_[1]	    =  '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';

=head2 Information about data files
 We shoot through a line of 60 L28- geophones
 sp every m 

 maximum of  traces = 60 sp x 1 neg-stacked hammer-blow-I-beam shotgathers x  traces = 3600 

 traces go from 3600

 geophone spacing is 1 m
 The smallest  (NOMINAL) sp-geophone offset is 1 m
 (See notes)
 increment sx=1 (NOMINAL) meters between new sp locations
 
 sp# 1 (I-beam,first of day)   sx = 0  (48 traces) uses I-beam  
 sp# 2 (I-beam)                sx = 1  (60 traces) uses I-beam 
 sp# 3 (I-beam)                sx = 2  (60 traces) uses I-beam ...
  
 sp# 60 (I-beam)               sx = 60  (60 traces) uses I-beam 

 we use an small I-beam and sledge hammer (3 stacked blows per side;
 later negatively stacked)

 suchw adds spacing

 G 1 is to SSW and G 60 lies to NNE
 Mark Products SH 28 Hz geophones have orange plastic to the W

 For sp# 1: (sx=0)
  
 G 1 is given a gx value  = 1 m 
 G 2 is given a gx value  = 2 m 
 G 3 is given a gx value  = 3 m 
 G 4 is given a gx value  = 4 m 

 G 21 is given a gx value = 21 m
 G 22 is given a gx value = 22 m ...
 
 G 59 is given a gx value = 59 m
 G 60 is given a gx value = 60 m

 For sp# 2: (sx=0)
 
 Geophones stay
 the shot in the field is moved
 northward
 
 G 1 is given a gx value  =   1 m 
 G 2 is given a gx value  =   2 m
 G 3 is given a gx value  =   3 m
 G ...
 G 59 is given a gx value =  59 m
 G 60 is given a gx value =  60 m

 Between each increase in sp location we
 have both a hit from E (ep = a) followed by
           a hit from W (ep = a+1)

 sushw for I-beam

=cut

     $sushw->clear();
     $sushw->key($sushw_headers_to_wipe[1]);
     $sushw->first_value($sushw_replace_w_[1]);
     $sushw[1] = $sushw->Step();

     $sushw->clear();
     $sushw->key('tracl,tracf,tracr');
     $sushw->first_value('1,1,1');
     $sushw->intra_gather_inc('1,1,1');
     $sushw->inter_gather_inc('-1,-1,-1');
     $sushw->gather_size('60,60,60');  # number of field traces = 60 
     $sushw[2] = $sushw->Step();

     $sushw->clear();
     $sushw->key('ep');
     $sushw->first_value('1');
     $sushw->intra_gather_inc('0');
     $sushw->inter_gather_inc('1');
     $sushw->gather_size('60');
     $sushw[4] = $sushw->Step();

=pod
 
  DEFINE FLOW(S)

=cut

 @items = (	$sushw[1],$in,
           	$sushw_inbound[1],$to,
           	$sushw[2],$to,
	   		$sushw[4],$out,
           	$sushw_outbound[1],$go);

 $flow[1] = $run->modules(\@items);

# RUN FLOW (s)
  $run->flow(\$flow[1]);

# LOG FLOW
  print $flow[1]."\n\n";
# $log->file($flow[1]);

