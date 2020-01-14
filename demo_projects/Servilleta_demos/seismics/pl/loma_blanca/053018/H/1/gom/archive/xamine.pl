#! /bin/perl

use Moose;


=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: Xamine.pl
  Purpose: Simple viewing of an su file 
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    June 18 2013 V0.1
           July 19 2016 V0.2 i
             Show processing notes on images
  DESCRIPTION:  based upon non-oop Xamine.pl  

=head 2 USES

 (for subroutines) 
     manage_files_by 
     System_Variables (for subroutines)

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)


=head2 NOTES 

 We are using moose 
 moose already declares that you need debuggers turned on
 so you don't need a line like the following:

 use warnings;
 
=head2 USES

 (for subroutines) 
     manage_files_by 
     System_Variables (for subroutines)

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)


 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 
  
=head3 STEPS IN THE PROGRAM 


=cut
 use sugain;
 use sufilter;
 use suximage;
 use suxwigb;
 use message;
 use flow;
 use susort;
 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 
 use Project;

=head2 Instantiate classes 

       Create a new version of the package
       Personalize to give it a new name if you wish
     Use classes:
     flow
     log
     message
     sufilter
     sugain
     suspecfx
     suxwigb

=cut

  my $log 				= new message();
  my $run    				= new flow();
  my $suxwigb				= new suxwigb();
  my $suximage				= new suximage();
  my $sufilter				= new sufilter();
  my $sugain				= new sugain();
  my $susort				= new susort();
  my $Project				= new Project();

  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();

=head2 Declare

  local variables 

=cut
  my (@flow,@file_in,@sufile_in,@inbound);
  my (@suxwigb,@sufilter,@sufilterNote,@sugain,@sugainNote,@items,@suximage);
  my (@susort,@susortNote,@suwind,@sunmo);

=head2 Declare 
  File names

=cut

   $file_in[1] 		            = '1_120';
   $file_in[1] 		            = 'All';
   $file_in[1] 		            = 'L28Hz_Ibeam';
   $file_in[1] 		            = 'L28Hz_Ibeam_geom';
   $file_in[1] 		            = 'All_cmp';  
   
   $sufile_in[1]		    = $file_in[1].$suffix_su;
   $inbound[1]			    = $DATA_SEISMIC_SU.'/'.$sufile_in[1];
#
=head2 Set

 sugain

=cut

 my $sugainVersion = 1;

 $sugain     	-> clear();
 $sugain     	-> agc(quotemeta($on));
 $sugain     	-> width(quotemeta(0.2));
# $sugain    	 -> setdt(1000);
 $sugain[1]   	= $sugain->Step();
 $sugainNote[1] = $sugain->note();


 $sugain     	-> clear();
 $sugain     	-> pbal(quotemeta($on));
 $sugain[2]   	= $sugain->Step();
 $sugainNote[2] = $sugain->note();

=head2 set

filtering parameters 

=cut
# $sugain    	 -> setdt(1000);

 #$sufilter    	 -> freq("0,0,500,1000");
 $sufilter    	 -> freq(quotemeta('0,10,500,1000'));
 $sufilter[1]  	 = $sufilter->Step();
 $sufilterNote[1]= $sufilter->note();

=head2 Set

 susort

=cut

 my $susortVersion = 1;

 $susort     			-> clear();
 $susort     			-> headerword(quotemeta('cdp offset'));
 $susort[$susortVersion]   	= $susort->Step();
 $susortNote[$susortVersion] 	= $susort->note();

=head2 Set

  suxwigb parameters 

=cut

 my $is_number = looks_like_number('TWTT s');
 print ("is_number=$is_number\n");

 $suxwigb-> clear(); 
 $suxwigb-> title(quotemeta($sufilterNote[1].$sugainNote[$sugainVersion])); 
 $suxwigb-> xlabel(quotemeta('TWTT s'));  
 $suxwigb-> ylabel(quotemeta('No.traces')); 
 $suxwigb-> box_width(quotemeta(800)); 
 $suxwigb-> box_height(quotemeta(700)); 
 $suxwigb-> box_X0(quotemeta(0)); 
 $suxwigb-> box_Y0(quotemeta(0)); 
 $suxwigb-> absclip(quotemeta(2))
 $suxwigb-> xcur(quotemeta(2));
 $suxwigb-> windowtitle(quotemeta($sufile_in[1]));
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
 $suximage-> loclip(0);
 $suximage-> hiclip(2);
 $suximage-> windowtitle($sufile_in[1]);
 $suximage[1]  = $suximage->Step();

=head2 DEFINE FLOW(S)
 
=cut

 @items   = ($sufilter[1],$in,$inbound[1],$to,
             $sugain[$sugainVersion],$to,$suxwigb[1],$go);
 $flow[1] = $run->modules(\@items);

 @items   = ($sufilter[1],$in,$inbound[1],$to,
             $sugain[$sugainVersion],$to,$suximage[1],$go);
 $flow[2] = $run->modules(\@items);


 @items   = ($susort[1],$in,$inbound[1],$to,
             $suwind[2],$to,
             $sufilter[1],$to,
	     	 $sunmo[1],$to,
             $sugain[$sugainVersion],$to,
             $suximage[2],
	     $go);
 $flow[3] = $run->modules(\@items);
 
 
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

