#! /bin/perl

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PROGRAM NAME: Suwind.pl
 Purpose: add traces 
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    May 31 2018 V0.1
  DESCRIPTION:  

=head 2 USES

=head2 NOTES

=head2 STEPS 

=cut

 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 
 use flow;
 use message;
 use suwind;
 use Project;


=head2 Instantiate classes

     Use classes:
     flow
     log
     message
     suwind
     Project

=cut

  my $log 				= new message();
  my $run    				= new flow();
  my $suwind                            = new suwind();
  my $Project				= new Project();

  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();

=head2 Declare

  local variables 

=cut

  my (@flow,@file_in,@sufile_in,@inbound);
  my (@file_out,@sufile_out,@outbound);
  my (@suwind,@suwindNote,$suwindVersion);

=head2 Declare

  file names 

=cut

   $file_in[0] 		= '1_120';
   $file_out[0] 	= 'All';

   $sufile_in[0]	= $file_in[0].$suffix_su;
   $inbound[0] 		= $DATA_SEISMIC_SU.'/'.$sufile_in[0];
   $sufile_out[0]	= $file_out[0].$suffix_su;
   $outbound[0] 	= $DATA_SEISMIC_SU.'/'.$sufile_out[0];


=head2 Set

 suwind

=cut

 $suwind     	-> clear();
 $suwind     	-> key('tracr');
 $suwind     	-> min(1);
 $suwind     	-> max(60);
 $suwind[0]   	= $suwind->Step();
 $suwindNote[0]	= $suwind->note();


 $suwind     	-> clear();
 $suwind     	-> tmin(0);
 $suwind     	-> tmax(1.0);
 $suwind[1]   	= $suwind->Step();
 $suwindNote[1]	= $suwind->note();


=head2 DEFINE FLOW(S)
 
=cut

 @items   = ($suwind[0],$in,
	     $inbound[0],$to,
             $suwind[1],$out,
             $outbound[0],
	     $go);
 $flow[0] = $run->modules(\@items);


=head2 RUN FLOW(S)

=cut

# $run->flow(\$flow[0]);

=head2 LOG FLOW(S)

 TO SCREEN AND FILE

=cut

 print  "$flow[0]\n";
#$log->file($flow[0]);
