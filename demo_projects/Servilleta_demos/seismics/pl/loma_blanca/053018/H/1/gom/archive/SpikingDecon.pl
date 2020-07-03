#! /usr/local/bin/perl
# -w

# PROGRAM NAME
# SpikDecon_Vertical.pl
# Nov 2, 2009 
# V1
# Spiking Deconvolution
# J Lorenzo

# use library
  use Project;

  my $Project = Project -> new();

# import system variables
  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();


# FUNCTION TITLE
  $windowtitle	= 'Spiking Deconvolution'.$date.'_'.$line;

# sufile names
   $sufile_in[1] 		= '60_clean';
   $inbound[1] 			=("$DATA_SEISMIC_SU/$sufile_in[1].su");
   $supef_outbound[1]		= $DATA_SEISMIC_SU.'/'.$sufile_in[1].'_spikdecon'.'.su';

# GAIN DATA
	$text_sugain[1]='pbal ';

	@sugain[1]  =  (" sugain 	            		\\
		pbal=1				  		\\
               ");

# GAIN DATA
	$wagc		   = .1;
	$text_sugain[2]    = 'wagc='.$wagc;

	@sugain[2]  =  (" sugain 	            		\\
		wagc=$wagc			  		\\
		agc=1				  		\\
               ");

# WINDOW  DATA by time
	@suwind[1] =  (" suwind 	            		\\
		tmin=0   					\\
		tmax=1   					\\
               ");

# WINDOW  DATA by ep 
	@suwind[2] =  (" suwind 	            		\\
		key=tracr   					\\
		min=1   					\\
		max=60 \\
               ");


# FILTER  DATA
	$bp_filter 	   = '0,3,50,100';
	$text_sufilter[1] = 'bpf '.$bp_filter;

	@sufilter[1] =  (" sufilter 	            		\\
		f=$bp_filter					\\
               ");


# SPIKING DECONVOLUTION 
	$min_lag 	= '';
	$max_lag 	= .001;
        $text_supef[1] 	= 'Lag '.$min_lag.' '.$max_lag;

	@supef[1] =  (" supef	 	            		\\
		maxlag=$max_lag					\\
               ");

# DISPLAY DATA
     		$xlabel = 'offset (m)';
     		$tlabel = 'Time(s)';
		$X0	= 700;
		$widthbox= 300;
		#mpicks=piks					\\

	@suxwigb[1] =  (" suxwigb				\\
		key=offset					\\
		title='$text_sugain[2] $text_sufilter[1] $text_supef[1]'	\\
		label1='$tlabel'				\\
		label2='$xlabel'				\\
		xbox=$X0					\\
		wbox=$widthbox					\\
		windowtitle='$windowtitle'			\\
		clip=10						\\
		");

# DISPLAY DATA
     		$xlabel = 'Trace number';
     		$tlabel = 'Time(s)';
		$X0	= 0;
		$widthbox= 300;

	@suximage[1] =  (" suximage				\\
		title='$text_sugain[2] $text_sufilter[1] '	\\
		label1='$tlabel'				\\
		label2='$xlabel'				\\
		windowtitle='No Spiking DECON'			\\
		xbox=$X0					\\
		wbox=$widthbox					\\
		clip=5						\\
		legend=1					\\
		");

# DISPLAY DATA
     		$xlabel = 'Trace number';
     		$tlabel = 'Time(s)';
		$X0	= 400;
		$widthbox= 300;

	@suximage[2] =  (" suximage				\\
		title='$text_sugain[2] $text_sufilter[1] $text_supef[1]'	\\
		label1='$tlabel'				\\
		label2='$xlabel'				\\
		windowtitle='$windowtitle'			\\
		xbox=$X0					\\
		wbox=$widthbox					\\
		clip=2						\\
		");
#  DEFINE FLOW(s)
	@flow[1] = (" @suwind[1]				\\
		< @inbound[1]|					\\
		@suwind[2] |					\\
		@sufilter[1]  					\\
		@sugain[2] | 					\\
		@suximage[1]					\\
		&						\\
		"); 

#  DEFINE FLOW(s)
	@flow[2] = (" @suwind[1]				\\
		< @inbound[1]|					\\
		@suwind[2] |					\\
		@supef[1]  |					\\
		@sufilter[1] |  				\\
		@sugain[2] | 					\\
		@suximage[2]					\\
		&						\\
		"); 

#  DEFINE FLOW(s)
	@flow[3] = (" @suwind[1]				\\
		< @inbound[1]|					\\
		@suwind[2] |					\\
		@supef[1]  |					\\
		@sufilter[1] |  				\\
		@sugain[2] | 					\\
		@suxwigb[1]					\\
		&						\\
		"); 
#  DEFINE FLOW(s)
	@flow[3] = (" @suwind[1]				\\
		< @inbound[1]|					\\
		@suwind[2] |					\\
		@supef[1]  |					\\
		> $supef_outbound[1]				\\
		&						\\
		"); 
# RUN FLOW(s)
       system @flow[1]; 
       system @flow[2]; 
       system @flow[3]; 

       system 'echo', @flow[1];	
       system 'echo', @flow[2];	
       system 'echo', @flow[3];	
