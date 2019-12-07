#! /usr/bin/perl 

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: Suwindow.pl
 AUTHOR: Juan Lorenzo
 DATE: March 28 2018
 Version 0.1 

=cut

=head2 DESCRIPTION
	
	window traces each different for adjacent sp gathers

	
=cut

=head2 Use the following libraries

 Some of these libraries or packages 
 contain groups of subroutines
 for example: SU

 use lib explicitly locates packges 

=cut
  use Moose;
  use SeismicUnix qw ($in $on $go $to $out $suffix_su);
  use ;

=head2 Declare local  
 
 arrays
 scalars 

=cut

  my (@file_outbound,@file_inbound);
  my (@flow,@items,@makecmp);
  my ($log,$messages,$makecmp,$run);

  my ($DATA_SEISMIC_SU)		= System_Variables::DATA_SEISMIC_SU();
  my ($TEMP_DATA_SEISMIC_SU)	= System_Variables::TEMP_DATA_SEISMIC_SU();


=head2 Create new instances of classes

 message, flow, suchw

=cut

 $log 		= new message();
 $run    	= new flow();
 $makecmp	= new suchw();

=head2 Declare file names

 with their complete paths: inbound and outbound

=cut

  $file_inbound[1]			= $DATA_SEISMIC_SU.'/'.'30Hz_Ibeam_geom'.$suffix_su;
  $file_outbound[1]      		= $DATA_SEISMIC_SU.'/'.'All_cmp'.$suffix_su;

=head2  Example in shell script

 suchw <$DATA_IN/1001_head_geom.su \
	key1=cdp 	\
	key2=sx		\
	key3=gx		\
	a=0		\
	b=1		\
	c=1		\
	d=2		\
 $DATA_OUT/all_geom_CMP.su

=cut

=head2 set up suchw

 To calculate cdp number and offset
 geometry

=cut

 $makecmp    -> clear();
 $makecmp    -> result_header('offset');
 $makecmp    -> first_header('gx');
 $makecmp    -> second_header('sx');
 $makecmp    -> multiply_hdr1_by('1');
 $makecmp    -> multiply_hdr2_by('-1');
 $makecmp    -> divide_all_by('1');
 $makecmp[1] = $makecmp->Step();

=head2 DEFINE FLOW(S)

=cut

 @items = ($makecmp[1],$in,$file_inbound[1],$out,$file_outbound[1],$go);
 $flow[1] = $run->modules(\@items);

=head2 RUN FLOW(S)

=cut

 $run->flow(\$flow[1]);

=head2

 LOG FLOW(S)TO SCREEN AND FILE

=cut

 print  "$flow[1]\n";
 #$log->file($flow[1]);

