#! /usr/bin/perl

use Moose;


=head2 SYNOPSIS

PROGRAM NAME:  Suvelan.pl
 Purpose: Mute of Data 
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    April 2 2009
           Modified to work with erine lsu1 Nov 21, 2009
           July 31 2013 V0.1
           Oct. 31, 2016 V0.2 for nmo
           Nov 3 2016, V0.3 made oops

=head 2 USES

=head2 NOTES

=head2 STEPS 

=cut


=head2 Import classes
    
   and variables into namespace

=cut

 use flow;
 use message;
 use sucat;
 use sufilter;
 use sugain;
 use sumute;
 use suwind;
 use suximage;
 use suxwigb;
 use SeismicUnix qw ($in $itop_mute_par_ $suffix_top_mute $out $on $go $to $suffix_ascii $off $suffix_su); 

=head2 Instantiate classes

    Use classes:
  flow
  log 
  message
  sucat
  sugain;
  sumute;
  suwind;
  suximage;
  suxwigb;

=cut
  my $cat			        = new sucat();
  my $log 				= new message();
  my $run    				= new flow();
  my $sufilter				= new sufilter();
  my $sugain				= new sugain();
  my $sumute				= new sumute();
  my $suwind				= new suwind();
  my $suximage				= new suximage();
  my $suxwigb				= new suxwigb();


 my ($DATA_SEISMIC_SU) = System_Variables::DATA_SEISMIC_SU();

=head2 Declare

  local variables 

=cut
  my (@flow,@file_in,@file_out,@sufile_in);
  my (@gatherType,@offset_type,@gatherNumber,@gatherNumberRange);
  my (@inbound,@outbound_cat);
  my (@items,@mute_par_file_in);
  my (@sugain,@sugainNote,$sugainVersion);
  my (@sumute,@sumuteNote,$sumuteVersion);
  my (@sufilter,@sufilterNote,$sufilterVersion);
  my (@suximage,@suximageNote,$suximageVersion);
  my (@suxwigb,@suxwigbNote,$suxwigbVersion);
  my (@suwind,@suwindNote,$suwindVersion);
  my ($ref_sumute,$sumute_number_of_par_files,$ref_gather_number,$ref_inbounds,$i);
  my ($ref_cat_array,$top_mute_list);
  my (@cat,@gather_number);
  my (@min_gatherNumber,@max_gatherNumber);


=head2 Default values


=cut

 $gatherNumber[1] = '';

=head2 Assign specific 

       input and output file names

=cut

  $file_in[1] 		        = 'All_cmp_bottom_mute_ep_24_24';
  $file_in[1] 		        = 'All_cmp_bottom_mute_ep_1_48';
  $file_in[1] 		        = 'All_cmp';
  $gatherType[1]                = 'ep';
  $offset_type[1]               = 'tracr';

=head2 Use only

 one of the following sets of values below

 The min and max set is used both in a naming
 convention
 and for data selection

 if there is more than one gather_number i
 then there mutliple X-T pick files are assumed and 
 the  results will be concatenated

 top-mute list of parameter files lies in local PL directory

# text_file names
  #$mute_xfile_in[1]		= 'mute_xfile_picks';
  #$mute_tfile_in[1] 		= 'mute_tfile_picks';
  #$mute_x_picks[1]		= $DATA_SEISMIC_SU.'/'.$mute_xfile_in[1].'.su';
  #$mute_t_picks[1]		= $DATA_SEISMIC_SU.'/'.$mute_tfile_in[1].'.su';

=cut

# if muting  only one shot gather at a time uncomment the following 3 lines
#  $gatherNumber[1]           = 24;
#  $min_gatherNumber[1]       = $gatherNumber[1];
#  $max_gatherNumber[1]       = $gatherNumber[1];
# if using only one shot gather at a time uncomment the following line
#  $mute_par_file_in[1] 		= $itop_mute_par_.$file_in[1].'_'.$gatherType[1].$gatherNumber[1];

# if muting many shot gathers at a time uncomment the following 3 lines
  $min_gatherNumber[1]       = 1;
  $max_gatherNumber[1]       = 48;
  $top_mute_list             = 'top_mute_list'; 

=head2 Set

  file names

=cut

  $gatherNumberRange[1]          = $min_gatherNumber[1].'_'.$max_gatherNumber[1];
  $sufile_in[1] 		= $file_in[1].$suffix_su;
  $file_out[1] 		        = $file_in[1].$suffix_top_mute;
  $inbound[1]	  		= $DATA_SEISMIC_SU.'/'.$file_in[1].$suffix_su;
  $outbound_cat[1]  		= $DATA_SEISMIC_SU.'/'.$file_out[1].'_'.$gatherType[1].'_'.$gatherNumberRange[1].$suffix_su;


=head2 Set

 suwind

=cut

 $suwindVersion = 1;

 $suwind     			-> clear();
 $suwind     			-> setheaderword($gatherType[1]);
 $suwind     			-> min($min_gatherNumber[1]);
 $suwind     			-> max($max_gatherNumber[1]);
 $suwind[$suwindVersion]   	= $suwind->Step();
 $suwindNote[$suwindVersion] 	= $suwind->note();

 $suwindVersion = 2;

 $suwind     			-> clear();
 $suwind     			-> tmin(0);
 $suwind     			-> tmax(1);
 $suwind[$suwindVersion]   	= $suwind->Step();
 $suwindNote[$suwindVersion] 	= $suwind->note();

=head2 Set

 sugain

=cut

 $sugainVersion = 2;
 $sugainVersion = 1;

 $sugain     	-> clear();
 $sugain     	-> agc($on);
 $sugain     	-> width(0.1);
# $sugain    	 -> setdt(1000);
 $sugain[1]   	= $sugain->Step();
 $sugainNote[1] = $sugain->note();


 $sugain     	-> clear();
 $sugain     	-> pbal($on);
 $sugain[2]   	= $sugain->Step();
 $sugainNote[2] = $sugain->note();


=head2 set

 filtering parameters 

=cut

 $sufilter    	 -> clear();
 $sufilter    	 -> freq("0,3,200,400");
 $sufilter[1]  	 = $sufilter->Step();
 $sufilterNote[1]= $sufilter->note();

=head2 Set

 muting parameters 
 print("number of par files is $sumute_number_of_par_files\n\n");
 for (my $i=1;$i<=$sumute_number_of_par_files;$i++) {
    print(" mute case #$i is @$ref_sumute[$i]\n\n");
 }
	#$mute_above[1] = 0;
	#$kill_velocity[1] = 330;	
		#xfile=$mute_x_picks[1]				\\
		#t0file=$mute_t_picks[1]				\\		
		#linvel=$kill_velocity[1]			\\
 @sumute contains all the many sumute flows
for (my $i=1; $i<=$sumute_number_of_par_files; $i++) {
     print ("\n$sumute[$i]\n\n");

=cut

 if ($min_gatherNumber[1] != $max_gatherNumber[1]) {
    $sumute      -> clear();
    $sumute    	 -> headerword('tracr');
    $sumute    	 -> ntaper(50);
    $sumute    	 -> type('top');
    $sumute    	 -> list($top_mute_list,\$file_in[1],\$gatherType[1]);
    ($ref_sumute,$sumute_number_of_par_files,$ref_gather_number,$ref_inbounds)  = $sumute->Steps();
    $sumuteNote[1]  = $sumute->note();
    @sumute         = @$ref_sumute;
    @gather_number  = @$ref_gather_number;
 }
 else {

    $sumute      -> clear();
    $sumute    	 -> headerword('tracr');
    $sumute    	 -> parfile($mute_par_file_in[1]);
    $sumute    	 -> ntaper(50);
    $sumute    	 -> type('top');
    $sumuteNote[1]  = $sumute->note();
    $sumute[1]      = $sumute->Step();

 }
 
 
=head2 Set

 sucat
 from a list

=cut

 if ($sumute_number_of_par_files) {
  $cat     -> clear();
  $ref_cat_array = $ref_inbounds;
  $cat     -> list_array($ref_cat_array);
#  $cat     -> list_directory($list_directory);
#  $cat     -> inbound_directory($inbound_directory);
  $cat[1]   = $cat->Step();
}

=head2 Set

  suximage parameters 

=cut

 $suximage-> clear(); 
 $suximage-> title(quotemeta($sufilterNote[1].$sugainNote[$sugainVersion].$sumuteNote[1])); 
 $suximage-> xlabel(quotemeta('No. traces'));  
 $suximage-> ylabel(quotemeta('TWTT s')); 
 $suximage-> box_width(800); 
 $suximage-> box_height(700); 
 $suximage-> legend($on); 
 $suximage-> box_X0(825); 
 $suximage-> box_Y0(0); 
 #$suximage-> absclip(3);
 $suximage-> loclip(-1);
 $suximage-> hiclip(1);
 $suximage-> windowtitle($sufile_in[1]);
 $suximage[1]  = $suximage->Step();

=head2 DEFINE FLOW(S)
 
   run all the sumute flows
   concatenate the results of all the sumute flows (output)
   plot the output
   save teh raw output

             $sugain[$sugainVersion],$to,

=cut

if ($min_gatherNumber[1] != $max_gatherNumber[1]) {
 print("#mute pick files= $sumute_number_of_par_files\n\n");
 for ($i=1; $i <=$sumute_number_of_par_files ; $i++) {
     $flow[$i] = $sumute[$i];
    }


 @items        = ($cat[1],$out,$outbound_cat[1]);
 $flow[($i+1)] = $run->modules(\@items);

 @items   = ($suwind[1],$in,$outbound_cat[1],$to,
             $suwind[2],$to,
             $sufilter[1],$to,
             $sugain[1],$to,
	     $suximage[1]);
 $flow[($i+2)] = $run->modules(\@items);

}
 else {

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,
             $sumute[1],$to,
             $sufilter[1],$to,
             $sugain[1],$to,
	     $suximage[1],$go);
 $flow[(1)] = $run->modules(\@items);
  

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,
             $sumute[1],$out,
             $outbound_cat[1]);
 $flow[(2)] = $run->modules(\@items);
}

=head2 RUN FLOW(S)

 1. for all sumute flows
 2. for concatenated flows 
 3. for images of the concatenated flow
 4. for raw output of sumute flow

=cut

if ($min_gatherNumber[1] != $max_gatherNumber[1]) {
 for ($i=1; $i <=$sumute_number_of_par_files ; $i++) {
     $run->flow(\$flow[$i])
    }

 $run->flow(\$flow[($i+1)]);
 $run->flow(\$flow[($i+2)]);
}
else {

 $run->flow(\$flow[1]);
 $run->flow(\$flow[2]);

}

=head2 LOG FLOW(S)

 TO SCREEN AND FILE

=cut

if ($min_gatherNumber[1] != $max_gatherNumber[1]) {
 for ($i=1; $i <=$sumute_number_of_par_files ; $i++) {
     print "\n$flow[$i]\n";
#$log->file($flow[$i]);
 }

 print  "\n$flow[($i+1)]\n";
#$log->file($flow[($i+1)]);

 print  "\n$flow[($i+2)]\n";
#$log->file($flow[($i+2)]);
}
else {

print  "\n$flow[1]\n";
#$log->file($flow[($i+1)]);

 print  "\n$flow[2]\n";
#$log->file($flow[($i+2)]);

}
