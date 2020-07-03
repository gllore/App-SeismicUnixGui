#! /bin/perl 

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: Make_cmp.pl
 AUTHOR: Juan Lorenzo
 DATE: Oct. 25 2007 V1.1
 DATE: Nov 3 2013
 Version 1.2
 V 1.3 June 1 2016
   1.31 May 31, 2018

=head2 CHANGES

	replace System_Variables with Project

=cut

=head2 DESCRIPTION

 Purpose: To generate CMP values in the headers,
 	headers must already have the correct geometry
        values inserted for
	the seismic experiment (See header_geom.pl for this)
	We use the basic relation that
 
			CMP = (sx+gx)/2

       where sx is the shot location, and gx is the receiver
       location. We use suchw to calculate the CMP using
       offset and other key words as
       input.
            value(key1) = (a + b * value(key2) + c * value(key3)) / d
 	can be rewritten as:
	
      If we choose the first CMP to be equal to ,say, 101

      then a = 304 
      a = ( 101 (first CMP number) + 51 * (absolute value of 
      half the longest offset on the first shot gather))/2
      You can choose other numbers to be the first CMP.

      value(cdp)   =(304 + 1 * value(sx) + 1 * value(gx) ) / 2
	
=cut

=head2 Use the following libraries

 Some of these libraries or packages 
 contain groups of subroutines
 for example: SU

 use lib explicitly locates packges 

=cut
  use Moose;
  use Project;
  use SeismicUnix qw ($in $on $go $to $out $suffix_su);
  use message;
  use flow;
  use suchw;
  
   
=head2 Create new instances of classes

 message, flow, suchw

=cut

 my $log 	= new message();
 my $run    	= new flow();
 my $makecmp	= new suchw();
 my $Project    = new Project; 


=head2 Declare local  
 
 arrays
 scalars 

=cut

  my (@file_outbound,@file_inbound);
  my (@flow);
  my @items;
  my @makecmp;
  my ($messages);

  my ($DATA_SEISMIC_SU)		= $Project->DATA_SEISMIC_SU();
  my ($TEMP_DATA_SEISMIC_SU)	= $Project->TEMP_DATA_SEISMIC_SU();


=head2 Declare file names

 with their complete paths: inbound and outbound

=cut

  $file_inbound[1]		= $DATA_SEISMIC_SU.'/'.'L28Hz_Ibeam_geom_geom_geom'.$suffix_su;
  $file_outbound[1]      	= $DATA_SEISMIC_SU.'/'.'All_cmp'.$suffix_su;

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
 $makecmp    -> result_header('cdp');
 $makecmp    -> first_header('gx');
 $makecmp    -> second_header('sx');
 $makecmp    -> multiply_hdr1_by('1');
 $makecmp    -> multiply_hdr2_by('1');
 $makecmp    -> divide_all_by('2');
 $makecmp    -> add_to_all('1');
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

