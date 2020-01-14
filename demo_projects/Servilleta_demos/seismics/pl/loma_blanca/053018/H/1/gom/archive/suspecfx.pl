#! /usr/bin/perl
#
use Moose;

# SCRIPT NAME
# Suspecfk.pl
# Purpose: f-x spectral analysis
# Juan M. Lorenzo
# Feb 18 2008
# May 31, 2018 added Moose options

  use Project;

  my $Project	= Project->new();

=head2 Declare variables

=cut

 my @sufile_in;
 my @flow;
 my @title;
 my (@sugain);
 my @sufilter;
 
 my @suxwigb;
 my @suximage;
 my @suwind;
 my @inbound;
 my @suspecfx;

	
# import system variables
  my ($PL_SEISMIC)      = $Project->PL_SEISMIC();
  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
  my ($date)            = $Project->date();

# sufile names
#$sufile_in[1] 		= $date;
 $sufile_in[1] 		= 'L28Hz_Ibeam';
 $inbound[1]		= $DATA_SEISMIC_SU.'/'.$sufile_in[1].'.su';

# print("$sufile_in[1]\n");

# GAIN DATA
	$sugain[1]  =  (" sugain 	            		\\
		pbal=1				  		\\
               ");

# GAIN DATA
	$sugain[2]  =  (" sugain 	            		\\
		wagc=.2				  	\\
		agc=1				  		\\
               ");

# FILTER  DATA
	$sufilter[1] =  (" sufilter 	            		\\
		   f=0,0,800,1000		\\
               ");



# WINDOW  DATA by time
	$suwind[1] =  (" suwind 	            		\\
		< $inbound[1]					\\
		tmin=0   					\\
		tmax=1  					\\
               ");

# WINDOW  DATA by traces 
	$suwind[2] =  (" suwind 	            		\\
		key=tracl   					\\
		max=  					\\
		min=  						\\
               ");

# SPECTRAL FX ANALYSIS  
	$suspecfx[1] =  (" suspecfx 	            		\\
               ");

# DISPLAY DATA
	$title[1]	= 'spectrum f-x';
	$suximage[1] =  (" suximage				\\
		windowtitle=$sufile_in[1]				\\
		title=$title[1]			\\
		label1='Frequency (Hz)'				\\
		label2='No. traces'				\\
                legend=1					\\
		n2tic=1 d2num=1				\\
                wclip=0 bclip=15				\\
		wbox=400 hbox=700 xbox=0 ybox=0			\\
		");

# DISPLAY DATA
	$title[2] =	'4.5 Hz vertical geophones';

	$suximage[2] =  (" suximage				\\
		windowtitle=$sufile_in[1]				\\
		title=$title[2]			\\
		label1='Time (s)'				\\
		label2='No. traces'				\\
		n2tic=1 d2num=2 				\\
                legend=1					\\
		clip=10						\\
		wbox=400 hbox=700 xbox=400 ybox=0		\\
		");
# DISPLAY DATA
	$title[2] =	'';

	$suxwigb[1] =  (" suxwigb				\\
		windowtitle=$sufile_in[1]				\\
		title=$title[2]			\\
		label1='Time (s)'				\\
		label2='No. traces'				\\
		n2tic=1 d2num=2 				\\
                legend=1					\\
		clip=10						\\
		wbox=400 hbox=700 xbox=400 ybox=0		\\
		");

#  DEFINE FLOW(S)
	$flow[1] = (" 						\\
		$suwind[1] | 					\\
                $sufilter[1] |                                  \\
		$sugain[2] | 					\\
		$suximage[2]					\\
		&						\\
		");  	
                #$sufilter[1] |                                  \\
		#$sugain[2] | 					\\
	$flow[2] = (" 						\\
		$suwind[1] | 					\\
		$suxwigb[1]					\\
		&						\\
		");  	
                #$sufilter[1] |                                  \\


#  DEFINE FLOW(S)
	$flow[3] = (" 						\\
		$suwind[1] | 					\\
                $sufilter[1] |                                  \\
		$suspecfx[1] | 					\\
		$suximage[1]					\\
		&						\\
		");  	
                #$sufilter[1] |                                  \\

# RUN FLOW(S)
       system $flow[1]; 
       system 'echo', $flow[1];	

       system $flow[2]; 
       system 'echo', $flow[2];	

       system $flow[3]; 
       system 'echo', $flow[3];	
