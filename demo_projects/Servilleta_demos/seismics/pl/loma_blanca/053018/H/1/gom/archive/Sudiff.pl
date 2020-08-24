#! /usr/bin/perl
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: Sudiff.pl 
 AUTHOR: Juan Lorenzo
 DESCRIPTION: script to subtract panels
              Used to difference SH panels 
 DATE Version 1 Feb 19 2015 
             False River case

=cut
 
=head3 STEPS IN THE PROGRAM 


=cut

=head2
	import modules

=cut

 use sugain;
 use sufilter;
 use suximage;
 use suxwigb;
 use message;
 use flow;
 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 
 use Project;
 use suwind;
 use suop2;


=pod

  2. Instantiate classes 
     and declare variables

=cut
  my $log 				= new message();
  my $run    				= new flow();
  my $suxwigb				= new suxwigb();
  my $suximage				= new suximage();
  my $sufilter				= new sufilter();
  my $sugain				= new sugain();
  my $Project				= new Project();

  my $suwind             		= new suwind();
  my $sudiff             		= new suop2();

  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();

=pod

 import system variables

=cut

  use SeismicUnix qw ($suffix_segy $suffix_su $suffix_ascii $suffix_bin $suffix_geom $suffix_hyphen $suffix_lsu $go $in $to $out); 


 my ($endian,$num_files,$i);
 my (@sudiff);
 my (@suwind,@suwind_inbound,@suwind_outbound);
 my (@fromNE_ep,@fromSW_ep);
 my (@file,@sufile,@temp_file);
 my (@sufile_inbound,@sufile_outbound);
 my (@sufile_in,@sufile_out);
 my (@sudiff_inbound,@sudiff_outbound);
 my (@flow);
 my (@items);

# sufile names
   $file[0] 		= 'All';
   $sufile_in[0] 	= $file[0].$suffix_su;

# outgoing
   $file[1] 		= 'L28HzHit_fromNE';
   $file[2] 		= 'L28HzHit_fromSW';
   $file[3] 		= 'L28Hz_Ibeam';

#sufile information
   $sufile_out[0] 	= $file[1].$suffix_su;
   $sufile_out[1] 	= $file[2].$suffix_su;
   $sufile_out[2] 	= $file[3].$suffix_su;

#sufile with directory information
   $sufile_inbound[0] 	= $DATA_SEISMIC_SU.'/'.$sufile_in[0];
   $sufile_outbound[0] 	= $DATA_SEISMIC_SU.'/'.$sufile_out[0];
   $sufile_outbound[1] 	= $DATA_SEISMIC_SU.'/'.$sufile_out[1];
   $sufile_outbound[2] 	= $DATA_SEISMIC_SU.'/'.$sufile_out[2];


=head2 Notes on data
 
 for I-beam
  maximum of  traces =  60  shotpoints x 2 shots per point x 60 traces  
		     = 7200 traces
       @fromNE_ep = (1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101,103,105,107,109,111,113,115,117,119);

       @fromSW_ep = (2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120);
=cut

  @fromNE_ep = (1,3,5,7,9,11,13,15,17,19,
		21,23,25,27,29,31,33,35,37,39,
		41,43,45,47,49,51,53,55,57,59,
		61,63,65,67,69,71,73,75,77,79,
		81,83,85,87,89,91,93,95,97,99,
		101,103,105,107,109,111,113,115,117,119);

       $suwind->clear();
       $suwind->setheaderword('fldr');
       $suwind->accept_only_list(\@fromNE_ep);
       $suwind[0] = $suwind->Step();

       $suwind_inbound[0]  =  $sufile_inbound[0];  
       $suwind_outbound[0] =  $sufile_outbound[0];  

       @fromSW_ep = (2,4,6,8,10,12,14,16,18,20,
		    22,24,26,28,30,32,34,36,38,40,
		    42,44,46,48,50,52,54,56,58,60,
		    62,64,66,68,70,72,74,76,78,80,
		    82,84,86,88,90,92,94,96,98,100,
		    102,104,106,108,110,112,114,116,118,120);

       $suwind->clear();
       $suwind->setheaderword('fldr');
       $suwind->accept_only_list(\@fromSW_ep);
       $suwind[1] = $suwind->Step();

       $suwind_inbound[1]   =  $sufile_inbound[0];  
       $suwind_outbound[1]  =  $sufile_outbound[1];  

       $sudiff_inbound[0]   = $sufile_outbound[0];
       $sudiff_inbound[1]   = $sufile_outbound[1];

       $sudiff->clear();
       $sudiff->AminusB();
       $sudiff->fileA(\$sudiff_inbound[0]);
       $sudiff->fileB(\$sudiff_inbound[1]);
       $sudiff[0] = $sudiff->Step();
       $sudiff_outbound[0]  = $sufile_outbound[2];


=pod
 
  DEFINE FLOW(S)

=cut

 @items   = ($suwind[0],$in,$suwind_inbound[0],$out,
             $suwind_outbound[0],$go);
 $flow[0] = $run->modules(\@items);

 @items   = ($suwind[1],$in,$suwind_inbound[1],$out,
             $suwind_outbound[1],$go);
 $flow[1] = $run->modules(\@items);

 @items   = ($sudiff[0],$out,$sudiff_outbound[0]);
 $flow[2] = $run->modules(\@items);


# RUN FLOW (s)
#  $run->flow(\$flow[0]);
 # $run->flow(\$flow[1]);
 # $run->flow(\$flow[2]);

# LOG FLOW
  print $flow[0]."\n\n";  
 # print $flow[1]."\n\n";
 # print $flow[2]."\n\n";

# $log->file($flow[0]);
# $log->file($flow[1]);
# $log->file($flow[2]);

