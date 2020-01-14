#!/usr/bin/perl
package Suximage;
use Moose;

=pod

 The parameters of the following 2 seismic unix programs
 apply to the same package

XIMAGE - X IMAGE plot of a uniformly-sampled function f(x1,x2)     	
									
 ximage n1= [optional parameters] <binaryfile			        
									
 X Functionality:							
 Button 1	Zoom with rubberband box				
 Button 2	Show mouse (x1,x2) coordinates while pressed		
 q or Q key	Quit							
 s key		Save current mouse (x1,x2) location to file		
 p or P key	Plot current window with pswigb (only from disk files)	
 a or page up keys		enhance clipping by 10%			
 c or page down keys		reduce clipping by 10%			
 up,down,left,right keys	move zoom window by half width/height	
 i or +(keypad) 		zoom in by factor 2 			
 o or -(keypad) 		zoom out by factor 2 			
									
 ... change colormap interactively					
 r	     install next RGB - colormap				
 R	     install previous RGB - colormap				
 h	     install next HSV - colormap				
 H	     install previous HSV - colormap				
 H	     install previous HSV - colormap				
 (Move mouse cursor out and back into window for r,R,h,H to take effect)
 									
 Required Parameters:							
 n1			 number of samples in 1st (fast) dimension	
									
 Optional Parameters:							
 d1=1.0		 sampling interval in 1st dimension		
 f1=0.0		 first sample in 1st dimension			
 n2=all		 number of samples in 2nd (slow) dimension	
 d2=1.0		 sampling interval in 2nd dimension		
 f2=0.0		 first sample in 2nd dimension			
 mpicks=/dev/tty	 file to save mouse picks in			
 perc=100.0		 percentile used to determine clip		
 clip=(perc percentile) clip used to determine bclip and wclip		
 bperc=perc		 percentile for determining black clip value	
 wperc=100.0-perc	 percentile for determining white clip value	
 bclip=clip		 data values outside of [bclip,wclip] are clipped
 wclip=-clip		 data values outside of [bclip,wclip] are clipped
 balance=0		 bclip & wclip individually			
			 =1 set them to the same abs value		
			   if specified via perc (avoids colorbar skew)	
 cmap=hsv'n' or rgb'm'	'n' is a number from 0 to 13		
				'm' is a number from 0 to 11		
				cmap=rgb0 is equal to cmap=gray		
				cmap=hsv1 is equal to cmap=hue		
				(compatibility to older versions)	
 legend=0	        =1 display the color scale			
 units=		unit label for legend				
 legendfont=times_roman10    font name for title			
 verbose=1		=1 for info printed on stderr (0 for no info)	
 xbox=50		x in pixels of upper left corner of window	
 ybox=50		y in pixels of upper left corner of window	
 wbox=550		width in pixels of window			
 hbox=700		height in pixels of window			
 lwidth=16		colorscale (legend) width in pixels		
 lheight=hbox/3	colorscale (legend) height in pixels		
 lx=3			colorscale (legend) x-position in pixels	
 ly=(hbox-lheight)/3   colorscale (legend) y-position in pixels	
 x1beg=x1min		value at which axis 1 begins			
 x1end=x1max		value at which axis 1 ends			
 d1num=0.0		numbered tic interval on axis 1 (0.0 for automatic)
 f1num=x1min		first numbered tic on axis 1 (used if d1num not 0.0)
 n1tic=1		number of tics per numbered tic on axis 1	
 grid1=none		grid lines on axis 1 - none, dot, dash, or solid
 label1=		label on axis 1					
 x2beg=x2min		value at which axis 2 begins			
 x2end=x2max		value at which axis 2 ends			
 d2num=0.0		numbered tic interval on axis 2 (0.0 for automatic)
 f2num=x2min		first numbered tic on axis 2 (used if d2num not 0.0)
 n2tic=1		number of tics per numbered tic on axis 2	
 grid2=none		grid lines on axis 2 - none, dot, dash, or solid
 label2=		label on axis 2					
 labelfont=Erg14	font name for axes labels			
 title=		title of plot					
 titlefont=Rom22	font name for title				
 windowtitle=ximage	title on window					
 labelcolor=blue	color for axes labels				
 titlecolor=red	color for title					
 gridcolor=blue	color for grid lines				
 style=seismic	$        normal (axis 1 horizontal, axis 2 vertical) or  
			seismic (axis 1 vertical, axis 2 horizontal)	
 blank=0		This indicates what portion of the lower range  
			to blank out (make the background color).  The  
			value should range from 0 to 1.			
 plotfile=plotfile.ps  filename for interactive ploting (P)  		
 curve=curve1,curve2,...  file(s) containing points to draw curve(s)   
 npair=n1,n2,n2,...            number(s) of pairs in each file         
 curvecolor=color1,color2,...  color(s) for curve(s)                   
 blockinterp=0       whether to use block interpolation (0=no, 1=yes)  

 NOTES:								
 The curve file is an ascii file with the points  specified as x1 x2	
 pairs separated by a space, one pair to a line.  A "vector" of curve
 files and curv$e colors may be specified as curvefile=file1,file2,etc. 
 and curvecolor=color1,color2,etc, and the number of pairs of values   
 in each file as npair=npair1,npair2,... .

   1. Use packages:

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)

=cut

# define a value
my $on = 1;

my $Suximage = {
    _key                => '',
    _ftr                => '',
    _cmap               => '',
    _curvefile          => '',
    _curvecolor         => '',
    _label1             => '',
    _label2             => '',
    _d2                 => '',
    _legend             => '',
    _loclip             => '',
    _d2num              => '',
    _d1num              => '',
    _dy_major_divisions => '',
    _dx_major_divisions => '',
    _wbox               => '',
    _ybox               => '',
    _xbox               => '',
    _hbox               => '',
    _f1num              => '',
    _f1                 => '',
    _f2                 => '',
    _f2num              => '',
    _npair              => '',
    _picks              => '',
    _n1tic              => '',
    _title              => '',
    _verbose            => '',
    _windowtitle        => '',
    _Step               => '',
    _note               => ''
};

=pod

 sub clear 
     clear global variables from the memory
=cut

sub clear {
    $Suximage{_key}                = '';
    $Suximage{_ftr}                = '';
    $Suximage{_cmap}               = '';
    $Suximage{_curvefile}          = '';
    $Suximage{_curvecolor}         = '';
    $Suximage{_label1}             = '';
    $Suximage{_label2}             = '';
    $Suximage{_n2}                 = '';
    $Suximage{_d2}                 = '';
    $Suximage{_legend}             = '';
    $Suximage{_loclip}             = '';
    $Suximage{_d2num}              = '';
    $Suximage{_d1num}              = '';
    $Suximage{_dy_major_divisions} = '';
    $Suximage{_dx_major_divisions} = '';
    $Suximage{_wbox}               = '';
    $Suximage{_ybox}               = '';
    $Suximage{_xbox}               = '';
    $Suximage{_hbox}               = '';
    $Suximage{_f1}                 = '';
    $Suximage{_f1num}              = '';
    $Suximage{_f2}                 = '';
    $Suximage{_f2num}              = '';
    $Suximage{_npair}              = '';
    $Suximage{_picks}              = '';
    $Suximage{_n1tic}              = '';
    $Suximage{_title}              = '';
    $Suximage{_verbose}            = '';
    $Suximage{_windowtitle}        = '';
    $Suximage{_Step}               = '';
    $Suximage{_note}               = '';
}

sub box_width {
    my ( $Suximage, $box_width ) = @_;
    $Suximage->{_wbox} = $box_width if defined($box_width);
    $Suximage->{_Step} = $Suximage->{_Step} . ' wbox=' . $Suximage->{_wbox};
    $Suximage->{_note} = $Suximage->{_note};
}

sub box_height {
    my ( $Suximage, $box_height ) = @_;
    $Suximage->{_hbox} = $box_height if defined($box_height);
    $Suximage->{_Step} = $Suximage->{_Step} . ' hbox=' . $Suximage->{_hbox};
    $Suximage->{_note} = $Suximage->{_note};
}

sub box_X0 {
    my ( $Suximage, $box_X0 ) = @_;
    $Suximage->{_xbox} = $box_X0 if defined($box_X0);
    $Suximage->{_Step} = $Suximage->{_Step} . ' xbox=' . $Suximage->{_xbox};
    $Suximage->{_note}    #    	= $Suximage->{_note};
}

sub box_Y0 {
    my ( $Suximage, $box_Y0 ) = @_;
    $Suximage->{_ybox} = $box_Y0 if defined($box_Y0);
    $Suximage->{_Step} = $Suximage->{_Step} . ' ybox=' . $Suximage->{_ybox};
    $Suximage->{_note} = $Suximage->{_note};
}

sub cmap {
    my ( $Suximage, $cmap ) = @_;
    $Suximage->{_cmap} = $cmap if defined($cmap);
    $Suximage->{_Step} = $Suximage->{_Step} . ' cmap=' . $Suximage->{_cmap};
}

=pod =head

 sub curvefile 
 name of ascii file containing plotting points

=cut

sub curvefile {
    my ( $Suximage, $ref_curve ) = @_;
    $Suximage->{_curvefile} = $$ref_curve if defined($ref_curve);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' curve=' . $Suximage->{_curvefile};

    #print("curve file is $Suximage->{_curvefile}\n\n");
}

=head

 sub curvecolor 
 color of curves

=cut

sub curvecolor {
    my ( $Suximage, $curvecolor ) = @_;
    $Suximage->{_curvecolor} = $curvecolor if defined($curvecolor);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' curvecolor=' . $Suximage->{_curvecolor};
}

=head sub npair 
 number of T-Vel pairs

=cut

sub npair {
    my ( $Suximage, $npair ) = @_;
    $Suximage->{_npair} = $npair if defined($npair);
    $Suximage->{_Step} = $Suximage->{_Step} . ' npair=' . $Suximage->{_npair};
}

=pod

 sub d2 or dx
     only the first trace is read in
     if an increment is not 1 between traces
     you should indicate here

=cut

sub dx {
    my ( $Suximage, $d2 ) = @_;
    $Suximage->{_d2} = $d2 if defined($d2);
    $Suximage->{_Step} = $Suximage->{_Step} . ' d2=' . $Suximage->{_d2};
}

sub d2 {
    my ( $Suximage, $d2 ) = @_;
    $Suximage->{_d2} = $d2 if defined($d2);
    $Suximage->{_Step} = $Suximage->{_Step} . ' d2=' . $Suximage->{_d2};
}

=pod =head3

  sub d2num 
  sub dx_major_divisions
  numbered tick interval

=cut

sub d2num {
    my ( $Suximage, $d2num ) = @_;
    $Suximage->{_d2num} = $d2num if defined($d2num);
    $Suximage->{_Step} = $Suximage->{_Step} . ' d2num=' . $Suximage->{_d2num};
}

sub dx_major_divisions {
    my ( $Suximage, $dx_major_divisions ) = @_;
    $Suximage->{_d2num} = $dx_major_divisions if defined($dx_major_divisions);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' d2num=' . $Suximage->{_dx_major_divisions};
}

=head3

  sub f1num 
  sub first_tick_number_y
   first tick number in the
   fast dimentsion (time)

=cut

sub first_tick_number_y {
    my ( $Suximage, $f1num ) = @_;
    $Suximage->{_f1num} = $f1num if defined($f1num);
    $Suximage->{_Step} = $Suximage->{_Step} . ' f1num=' . $Suximage->{_f1num};
}

sub f1num {
    my ( $Suximage, $f1num ) = @_;
    $Suximage->{_f1num} = $f1num if defined($f1num);
    $Suximage->{_Step} = $Suximage->{_Step} . ' f1num=' . $Suximage->{_f1num};
}

=pod =head3

  sub f2num 
  sub first_tick_number_x
   first tick number in the
   slow dimension (distance)

=cut

sub first_tick_number_x {
    my ( $Suximage, $f2num ) = @_;
    $Suximage->{_f2num} = $f2num if defined($f2num);
    $Suximage->{_Step} = $Suximage->{_Step} . ' f2num=' . $Suximage->{_f2num};
}

sub f2num {
    my ( $Suximage, $f2num ) = @_;
    $Suximage->{_f2num} = $f2num if defined($f2num);
    $Suximage->{_Step} = $Suximage->{_Step} . ' f2num=' . $Suximage->{_f2num};
}

=pod =head3

  sub d1num 
  sub dy_major_divisions
  numbered tick interval in fast dimension(t)

=cut

sub d1num {
    my ( $Suximage, $d1num ) = @_;
    $Suximage->{_d1num} = $d1num if defined($d1num);
    $Suximage->{_Step} = $Suximage->{_Step} . ' d1num=' . $Suximage->{_d1num};
}

sub dy_major_divisions {
    my ( $Suximage, $dy_major_divisions ) = @_;
    $Suximage->{_dy_major_divisions} = $dy_major_divisions
      if defined($dy_major_divisions);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' d1num=' . $Suximage->{_dy_major_divisions};
}

sub trace_inc {
    my ( $Suximage, $trace_inc ) = @_;
    $Suximage->{_d2} = $trace_inc if defined($trace_inc);
    $Suximage->{_Step} = $Suximage->{_Step} . ' d2=' . $Suximage->{_d2};
}

sub f1 {
    my ( $Suximage, $f1 ) = @_;
    $Suximage->{_f1} = $f1 if defined($f1);
    $Suximage->{_Step} = $Suximage->{_Step} . ' f1=' . $Suximage->{_f1};
}

sub first_y {
    my ( $Suximage, $f1 ) = @_;
    $Suximage->{_f1} = $f1 if defined($f1);
    $Suximage->{_Step} = $Suximage->{_Step} . 'f1 =' . $Suximage->{_f1};
}

=head3 sub first_x

 sub f2 or sub first_x

 first value in the second dimension (X)

=cut

sub f2 {
    my ( $Suximage, $f2 ) = @_;
    $Suximage->{_f2} = $f2 if defined($f2);
    $Suximage->{_Step} = $Suximage->{_Step} . ' f2=' . $Suximage->{_f2};
}

sub first_x {
    my ( $Suximage, $f2 ) = @_;
    $Suximage->{_f2} = $f2 if defined($f2);
    $Suximage->{_Step} = $Suximage->{_Step} . ' f2=' . $Suximage->{_f2};
}

#=pod =head3
#
#  sub d1num
# sub dx_number_interval
#  numbered tick interval
#
#=cut
#
#sub d1num {
#    my ($Suximage, $d1num )  = @_;
#    $Suximage->{_d1num}      = $d1num if defined($d1num);
#    $Suximage->{_Step}       = $Suximage->{_Step}.' d1num='.$Suximage->{_d1num};
#}
#
#sub dy_number_interval {
#    my ($Suximage, $d1num )  = @_;
#    $Suximage->{_d1num}      = $d1num if defined($d1num);
#    $Suximage->{_Step}       = $Suximage->{_Step}.' d1num='.$Suximage->{_d1num};
#}
#
sub ftr {
    my ( $Suximage, $ftr ) = @_;
    $Suximage->{_ftr} = $ftr if defined($ftr);
    $Suximage->{_Step} = $Suximage->{_Step} . 'Suximage' . $Suximage->{_ftr};
}

sub headerword {
    my ( $Suximage, $headerword ) = @_;
    $Suximage->{_key} = $headerword if defined($headerword);
    $Suximage->{_Step} = $Suximage->{_Step} . ' key=' . $Suximage->{_key};
}

sub initiate {
    $Suximage->{_Step} = '';
    $Suximage->{_note} = '';
}

sub hiclip {
    my ( $Suximage, $hiclip ) = @_;
    $Suximage->{_hiclip} = $hiclip if defined($hiclip);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' bclip=' . $Suximage->{_hiclip};
    $Suximage->{_note} =
      $Suximage->{_note} . ' hiclip=' . $Suximage->{_hiclip};
}

=pod subroutine key

  use this key to plot

=cut

sub key {
    my ( $Suximage, $key ) = @_;
    $Suximage->{_key} = $key if defined($key);
    $Suximage->{_Step} = $Suximage->{_Step} . ' key=' . $Suximage->{_key};
}

sub legend {
    my ( $Suximage, $legend ) = @_;
    $Suximage->{_legend} = $legend if defined($legend);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' legend=' . $Suximage->{_legend};
    $Suximage->{_note} =
      $Suximage->{_note} . ' legend=' . $Suximage->{_legend};

}

sub loclip {
    my ( $Suximage, $loclip ) = @_;
    $Suximage->{_loclip} = $loclip if defined($loclip);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' wclip=' . $Suximage->{_loclip};
    $Suximage->{_note} =
      $Suximage->{_note} . ' loclip=' . $Suximage->{_loclip};

}

=pod =head3 sub n1tic

 number of ticks per numbered tick
 on x axis

=cut

sub n1tic {
    my ( $Suximage, $n1tic ) = @_;
    $Suximage->{_n1tic} = $n1tic if defined($n1tic);
    $Suximage->{_Step}  = $Suximage->{_Step} . ' n1tic=' . $Suximage->{_n1tic};
    $Suximage->{_note}  = $Suximage->{_note} . ' n1tic=' . $Suximage->{_n1tic};

}

sub dy_minor_divisions {
    my ( $Suximage, $n1tic ) = @_;
    $Suximage->{_n1tic} = $n1tic if defined($n1tic);
    $Suximage->{_Step}  = $Suximage->{_Step} . ' n1tic=' . $Suximage->{_n1tic};
    $Suximage->{_note}  = $Suximage->{_note} . ' n1tic=' . $Suximage->{_n1tic};

}

sub note {
    my ($Suximage) = @_;
    $Suximage->{_note} = $Suximage->{_note};
    return $Suximage->{_note};
}

=pod =head3 sub percent4clip 
  
   percentile used to determine clip

=cut

sub percent4clip {
    my ( $Suximage, $percent ) = @_;
    $Suximage->{_perc} = $percent if defined($percent);
    $Suximage->{_Step} = $Suximage->{_Step} . ' perc=' . $Suximage->{_perc};
    $Suximage->{_note} = $Suximage->{_note} . ' perc=' . $Suximage->{_perc};
}

sub Step {
    my ($Suximage) = @_;
    $Suximage->{_Step} = 'Suximage ' . $Suximage->{_Step};
    return $Suximage->{_Step};
}

=pod

 sub picks
    automatically generates a pick file

=cut

sub picks {
    my ( $Suximage, $ref_picks ) = @_;
    $Suximage->{_picks} = $$ref_picks if defined($ref_picks);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' mpicks=' . $Suximage->{_picks};
    $Suximage->{_note} = $Suximage->{_note} . ' piks=' . $Suximage->{_picks};

}

=pod

 sub title allows for a default graph title ($on) or
 a user-defined title

=cut

sub title {
    my ( $Suximage, $title ) = @_;
    $Suximage->{_title} = $title if defined($title);

    if ( $title == $on ) {
        $Suximage->{_Step} =
          $Suximage->{_Step} . ' title=' . $Suximage->{_note};
    }
    else {
        $Suximage->{_Step} =
          $Suximage->{_Step} . ' title=' . $Suximage->{_title};
    }

    #print (" title is $Suximage->{_title} \n\n");
    $Suximage->{_note} = $Suximage->{_note};
}

sub verbose {
    my ( $Suximage, $verbose ) = @_;
    $Suximage->{_verbose} = $verbose if defined($verbose);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' verbose=' . $Suximage->{_verbose};
}

sub windowtitle {
    my ( $Suximage, $windowtitle ) = @_;
    $Suximage->{_windowtitle} = $windowtitle if defined($windowtitle);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' windowtitle=' . $Suximage->{_windowtitle};
    $Suximage->{_note} = $Suximage->{_note};
}

sub xlabel {
    my ( $Suximage, $xlabel ) = @_;
    $Suximage->{_label2} = $xlabel if defined($xlabel);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' label2=' . $Suximage->{_label2};
    $Suximage->{_note} = $Suximage->{_note};
}

sub ylabel {
    my ( $Suximage, $ylabel ) = @_;
    $Suximage->{_label1} = $ylabel if defined($ylabel);
    $Suximage->{_Step} =
      $Suximage->{_Step} . ' label1=' . $Suximage->{_label1};
    $Suximage->{_note} = $Suximage->{_note};
}

1;
