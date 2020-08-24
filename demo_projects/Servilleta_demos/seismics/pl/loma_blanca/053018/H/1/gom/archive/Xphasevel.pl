
=head1 Documentation

=head2 Synopsis

	Program: 	Xphasevel.pl
	Purpose: 	Creation of a Dispersion Curve
	Author:  	Derek S. Goff
	Date:    	November 17 2013 V1.1
                        Nov 28 2016, add perldoc (Juan M. Lorenzo) 
	Description:	Implements  suphasevel.pm
			Creates phase velocity dispersions
	
=head2 Uses

     Subroutines:
	manage_files_by
	$Project-> (for subroutines)

     Varibale Definitions:
	SeismicUnix (Seismic Unix modules)

=cut

 use Moose;
 use message;
 use flow;
 use suximage;
 use suxwigb;
 use suamp;
 use suphasevel;
 use suifft;
 use sufilter;
 use sugain;
 use suflip;
 use suwind;
 use suop;
 use sushw;
 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 
 use Project_config;


=head2  Instanitiate Classes

	Create a new version of a package6
	Give it a new name if desired
    Use classes:
	flow
	log
	message
	sufilter
	suximage
        suop

=cut

 my $log 		= new message();
 my $run    		= new flow();
 my $suximage		= new suximage();
 my $suxwigb		= new suxwigb();
 my $suamp		= new suamp();
 my $suphasevel		= new suphasevel();
 my $suifft		= new suifft();
 my $sufilter		= new sufilter();
 my $sugain		= new sugain();
 my $suflip		= new suflip();
 my $suwind		= new suwind();
 my $suop		= new suop();
 my $smooth		= new sufilter();
 my $sushw		= new sushw();
 my $Project		= new Project_config();


=head2 Use directory navigation system

=cut

 my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
 my ($PL_SEISMIC)      = $Project->PL_SEISMIC();
 my ($GEOPSY)     		= $Project->GEOPSY();

=head2 Declare local variables


=cut

 my (@flow, @items);
 my (@suamp, @suximage, @suxwigb, @suphasevel, @sufilter, @sugain, @suflip);
 my (@suwind,@suop,@smooth,@sushw);
 my (@file_in, @sufile_in, @inbound, @file_out, @outbound);
 my (@outpicks);


=head2 Define the file name 


   of the shot record to be used to 
    compute a multi-mode phase velocity dispersion map

   IMPORTANT
  ->Please note that output files will be amped
  ->They will not be complex frequency data!!

=cut

  $file_in[1] 			= 'All_cmp';
 
 my $first_file_index 	= 1;
 my $last_file_index 	= 1;
 my $index_inc		= 1;
 
 for (my $i = $first_file_index; $i <= $last_file_index ; $i=$i + $index_inc) {
 	
  $sufile_in[1]			= $file_in[$i].$suffix_su;

  $inbound[1]			= $DATA_SEISMIC_SU.'/'.$sufile_in[1];

  $file_out[1]			= $file_in[$i].'_phvel';
  $outbound[1]			= $DATA_SEISMIC_SU.'/'.$file_out[1].'.su';
  $outpicks[1]			= $GEOPSY.'/'.$file_out[1].'_picks';


=head2 suphasevel

	fv = The starting phase velocity (pv) to process
	      -> Not always in (m/s)
	      -> Depends on units in geometry (header)
	nv = How many steps to take
	      -> Number of velocities to test
	dv = Step Size0
	      -> How large a gap between
		-> test velocities
	fmax = Maximum frequency to process

	fv+nv*dv = largest velocity tested
		
        scalel is needed to rescale the plotting and 
        phasevel parameters

        my $default_scalel  = -1; # does nothing

=cut

 my $scalel 	   = -1;
 my $dv            = 1;  #m
 my $new_dv        = $dv * (-$scalel);

 $suphasevel	-> clear();
 $suphasevel	-> fv("10"); 
 $suphasevel	-> nv("400");
 $suphasevel	-> dv($new_dv);
 $suphasevel	-> fmax("50");
 $suphasevel	-> norm($off);
 $suphasevel	-> norm($on);
 $suphasevel	-> verb($on);
 $suphasevel[1]	= $suphasevel->Step();


=head2 Set suximage parameters

 These default settings will generate an image of
 the dispersion curve for viewing
 For actual data output

 $suximage-> style('normal'); # y axis is phase velocity
 $suximage-> style('seismic'); # y axis is phase velocity
 my $new_d2 = $dv;
 $suximage ->d2($new_d2);

=cut

 $suximage-> clear(); 
 $suximage-> title($file_out[1]); 
 $suximage-> xlabel("Phase_Velocity");  
 $suximage-> ylabel("Frequency"); 
 $suximage-> box_width(700); 
 $suximage-> box_height(600);
 $suximage-> cmap("hsv6"); #hsv0 for black and white
 $suximage-> legend($on); #hsv0 for black and white
 $suximage-> box_X0(0); 
 $suximage-> picks(\$outpicks[1]); 
 $suximage-> box_Y0(0); 
 $suximage-> hiclip(4); 
 $suximage-> loclip(0); 
 $suximage-> legend($on);
 $suximage-> windowtitle("Dispersion Image");
 $suximage[1]  = $suximage->Step();

 $suxwigb-> clear(); 
 #$suxwigb -> key('tracf');
 $suxwigb-> title($file_in[$i]); 
# $suxwigb-> xlabel("Offset");  
 $suxwigb-> xlabel("Trace");  
 $suxwigb-> ylabel("TWTT_s"); 
 $suxwigb-> box_width(800); 
 $suxwigb-> box_height(700); 
 $suxwigb-> box_X0(0); 
 $suxwigb-> box_Y0(0);
 $suxwigb-> clip(10);
 $suxwigb-> windowtitle("Original_Data");
 $suxwigb[1]  = $suxwigb->Step();

=head2 Set amplitudes 

 make output absolute

=cut

 $suop-> clear();
 $suop-> op(abs);
 $suop[1] = $suop->Step();


=head2 Smooth phase vel plot 

 freq resolution sufiltered out 
 needs to know in advance the dimension
 of the fft and the number of 
 phase-velocity traces

=cut

 $sushw-> clear();
 $sushw-> key('trid');
 $sushw-> key('trid');
 $sushw-> first_value('1');
 $sushw-> inter_gather_inc('0');
 $sushw-> intra_gather_inc('0');
 $sushw[1] = $sushw->Step();



=head2 Smooth phase vel plot 

 freq resolution sufiltered out 
 needs to know in advance the dimension
 of the fft and the number of 
 phase-velocity traces

=cut

 $smooth-> clear();
 $smooth-> freq('0,0,60,80');
 $smooth-> amps('1,1,1,0');
 $smooth[1] = $smooth->Step();


=head2 Set type of traces to output

	amp gives amplitude traces
	phase gives phase traces...
	see suamp.pm for further instruction
    -> None are really neccessary
    -> amp is default

=cut

 $suamp-> clear();
 $suamp-> mode('real');
 $suamp[1] = $suamp->Step();


=head2 Set Filtering Parameters

=cut

 $sufilter-> clear();
 $sufilter-> freq("0,0,80,100");
 $sufilter[2]  =  $sufilter->Step();

=head2 Add Gain to traces

=cut

 $sugain	-> clear();
 $sugain	-> agc($on);
 $sugain	-> width(.1);
 $sugain[1]   =    $sugain->Step();

=head2 Add Gain to output of suamps

=cut

 $sugain	-> clear();
 $sugain	-> pbal($on);
 $sugain[1]   =    $sugain->Step();

=head2 Window time value of traces

=cut

 $suwind	-> clear();
 $suwind	-> key('tracl');
 $suwind	-> min(1);
 $suwind	-> max(24);
 $suwind[1] = $suwind->Step();

=head2  Window by offset traces

  in meters 
=cut

 my $min_offset 	= 12 ;
 my $max_offset 	= 81 ;
 my $new_min_offset 	= $min_offset * (-$scalel);
 my $new_max_offset 	= $max_offset * (-$scalel);


 $suwind	-> clear();
 $suwind	-> key('offset');
 $suwind	-> min($new_min_offset);
 $suwind	-> max($new_max_offset);
 $suwind[3] = $suwind->Step();

=head2 Window by time 

  Window by time 

=cut

 $suwind	-> clear();
 $suwind	-> tmin(0);
 $suwind	-> tmax(4);
 $suwind[2] = $suwind->Step();


=head2

 Create Window for picking
 
=cut

=head2 Define Flows

=cut

=head2  Create outbound file

=cut 

 @items = ($suwind[1],$in,$inbound[1],
           $to,$suwind[2],
           $to,$suwind[3],
           $to,$sufilter[2],
           $to,$suphasevel[1],
           $to,$suamp[1],
           $out,$outbound[1],
           $go);
 $flow[1]	= $run -> modules(\@items);

=head2 Produce image of input shot record



Produce image of input shot record

=cut

 @items = ($suwind[1],$in,$inbound[1],
           $to,$suwind[2],$to,$suwind[3],
	   $to,$sufilter[2],
	   $to,$sugain[1],
	   $to,$suxwigb[1],
	   $go);
 $flow[2]	= $run -> modules(\@items);

=head2 Phasevel dispersion image w filter or gain, Windowed


Phasevel dispersion image w filter or gain, Windowed

=cut

  @items 	= ($suwind[1],$in,$inbound[1]
		,$to,$suwind[2],
		$to,$suwind[3],
		$to,$sufilter[2],
		$to,$suphasevel[1],
		$to,$suamp[1],
		$to,$sugain[1],
		$to,$suximage[1],$go);
  $flow[3]	= $run -> modules(\@items);

=head2 Run Flows

=cut

# $run->flow(\$flow[1]);
# print $flow[3]."\n";

 $run->flow(\$flow[2]);
 print $flow[2]."\n";

 $run->flow(\$flow[3]);
 print $flow[3]."\n";
 	
 	
 }
  


