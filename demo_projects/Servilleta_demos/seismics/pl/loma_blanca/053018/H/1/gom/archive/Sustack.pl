#! /usr/local/bin/perl

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PROGRAM NAME: Sustack.pl P 
 Purpose: add traces 
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    July 31 2013 V0.1
           Oct. 31, 2016 V0.2 for nmo
  DESCRIPTION:  

=head 2 USES

=head2 NOTES

=head2 STEPS 

=cut

 use Project_config;
 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 
 use flow;
 use message;
 use sufilter;
 use sugain;
 use susort;
 use sunmo;
 use suwind;
 use sustack;
 use suximage;
 use suxwigb;
 use manage_files_by;

=head2 Instantiate classes

     Use classes:
     flow
     log
     message
     sufilter
     sugain
     suximage
     suxwigb
     suwind

=cut

  my $log 				= new message();
  my $run    				= new flow();
  my $sufilter				= new sufilter();
  my $sugain				= new sugain();
  my $susort				= new susort();
  my $sunmo				= new sunmo();
  my $suwind                            = new suwind();
  my $sustack                           = new sustack();
  my $suximage				= new suximage();
  my $suxwigb				= new suxwigb();
  my $Project				= new Project_config();

  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();

=head2 Declare

  local variables 

=cut

  my (@flow,@file_in,@sufile_in,@inbound);
  my (@sugain,@sugainNote,$sugainVersion,@items,@suximage);
  my (@suwind,@suwindNote,$suwindVersion);
  my (@susort,@susortNote,$susortVersion);
  my (@sustack,@sustackNote,$sustackVersion);
  my (@suximage,@suximage,@suximageNote);
  my (@suxwigb,@sufilter,@sufilterNote);

=head2 Declare

  file names 

=cut

=head2

susort cdp offset <All_cmp.su   \
| suwind key=cdp min=1 max=100 \
| sufilter f=10,20,230,280  \
| sudipfilt dt=1 dx=1 slopes=3,8,17,25,80 amps=1,1,0,1,1 \
| sunmo vnmo=150 | sustack  \
| suwind tmin=0 tmax=1 \
|sustolt cdpmin=1 cdpmax=100 dxcdp=1 vmig=50,100 tmig=0,1\
| suximage clip=1 

=cut

   $file_in[1] 		= 'All_cmp_mute_ep_1_238';
   $file_in[1] 		= 'All_cmp_mute_ep_1_238_fk';
   $file_in[1] 		= 'All_cmp_mute_ep_1_238_fk_mute_ep_1_238';
   $file_in[1] 		= 'All_cmp';
   $file_in[1] 		= 'junk';
   $par_file[1]         = $file_in[1].'_'.'stkvel';
   $sufile_in[1]	= $file_in[1].$suffix_su;
   $inbound[1] 		= $DATA_SEISMIC_SU.'/'.$sufile_in[1];


=head2 Set

sustolt 

=cut
my @sustolt;
$sustolt[1] = ("sustolt cdpmin=1 cdpmax=300 dxcdp=1 vmig=50,150 tmig=0,1");
 

=head2 Set

 sunmo

=cut

 $sunmoVersion = 1;

 $sunmo     	-> clear();
 #$sunmo     	-> vnmo('300,300');
 #$sunmo     	-> tnmo('0,1');
 $sunmo     	-> par($par_file[1]);
 $sunmo[1]   	= $sunmo->Step();
 $sunmoNote[1]  = $sunmo->note();

=head2 Set

 sugain

=cut

 $sugainVersion = 1;

 $sugain     	-> clear();
 $sugain     	-> agc($on);
 $sugain     	-> width(0.1);
 $sugain[$sugainVersion]     = $sugain->Step();
 $sugainNote[$sugainVersion] = $sugain->note();
 $sugainVersion = '';

=head2 Set

 sugain

=cut

 $sugainVersion = 2;
 $sugain     	-> clear();
 $sugain     	-> pbal($on);
 $sugain[$sugainVersion]     = $sugain->Step();
 $sugainNote[$sugainVersion] = $sugain->note();
 $sugainVersion = '';

=head2 Set

 suwind

=cut

 $suwindVersion = 1;

 $suwind     	-> clear();
 $suwind     	-> key('cdp');
 $suwind     	-> min(1);
 $suwind     	-> max(300);
 $suwind[$suwindVersion]   	= $suwind->Step();
 $suwindNote[$suwindVersion] 	= $suwind->note();

$suwindVersion = 2;

 $suwind     	-> clear();
 $suwind     	-> tmin(0);
 $suwind     	-> tmax(1);
 $suwind[$suwindVersion]   	= $suwind->Step();
 $suwindNote[$suwindVersion] 	= $suwind->note();

=head2 Set

 susort

=cut

 $susortVersion = 1;

 $susort     			-> clear();
 $susort     			-> headerword('cdp offset');
 $susort[$susortVersion]   	= $susort->Step();
 $susortNote[$susortVersion] 	= $susort->note();

=head2 Set

 stacking parameters 

=cut

 $sustack     	 ->clear();
 $sustack     	 ->headerword('cdp');
 $sustack[1]  	 = $sustack->Step();
 $sustackNote[1] = $sustack->note();

=head2 Set

filtering parameters 

=cut

 $sufilter    	 -> freq("10,20,200,400");
 $sufilter[1]  	 = $sufilter->Step();
 $sufilterNote[1]= $sufilter->note();

=head2 Set

  suxwigb parameters 

=cut

 $suxwigb-> clear(); 
 $suxwigb-> title(quotemeta($sufilterNote[1].$sugainNote[$sugainVersion])); 
 $suxwigb-> xlabel(quotemeta('TWTT s'));  
 $suxwigb-> ylabel(quotemeta('No.traces')); 
 $suxwigb-> box_width(800); 
 $suxwigb-> box_height(700); 
 $suxwigb-> box_X0(0); 
 $suxwigb-> box_Y0(0); 
 $suxwigb-> absclip(2);
 $suxwigb-> xcur(1);
 $suxwigb-> windowtitle($sufile_in[1]);
 $suxwigb[1]  = $suxwigb->Step();

=head2 Set

  suximage parameters 

=cut

 $suximage-> clear(); 
 $suximage-> title(quotemeta($sufilterNote[1].$sugainNote[$sugainVersion])); 
 $suximage-> xlabel(quotemeta('No. traces'));  
 $suximage-> ylabel(quotemeta('TWTT s')); 
 $suximage-> box_width(800); 
 $suximage-> box_height(700); 
 $suximage-> legend($on); 
 $suximage-> box_X0(825); 
 $suximage-> box_Y0(0); 
 #$suximage-> absclip(3);
 $suximage-> loclip(-3);
 $suximage-> hiclip(3);
 $suximage-> windowtitle($sufile_in[1]);
 $suximage[1]  = $suximage->Step();


=head2 DEFINE FLOW(S)
 
=cut


 $sugainVersion = 1;

 @items   = ($susort[1],$in,$inbound[1],$to,
             $suwind[1],$to,
             $sufilter[1],$to,$sunmo[1],$to,
             $suwind[2],$to,$sustack[1],$to,
             $sugain[$sugainVersion],$to,
             $suxwigb[1],$go);
 $flow[1] = $run->modules(\@items);

 
 @items   = ($susort[1],$in,$inbound[1],$to,
             $suwind[1],$to,
             $sufilter[1],$to,$sunmo[1],$to,
             $suwind[2],$to,$sustack[1],$to,
             $sugain[$sugainVersion],$to,$sustolt[1],$to,
             $suximage[1],$go);
 $flow[2] = $run->modules(\@items);
 
=head2 RUN FLOW(S)

=cut

 $run->flow(\$flow[1]);
  $run->flow(\$flow[2]);
=head2 LOG FLOW(S)

 TO SCREEN AND FILE

=cut

 print  "$flow[1]\n";
#$log->file($flow[1]);
 print  "$flow[2]\n";
#$log->file($flow[2]);
