package iSuvelan;

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PCKAGE NAME: iSuvelan

  Purpose:  interactive suvelan
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    April 1 2009
  DESCRIPTION:  Generate Velocity Analysis  
  MODIFIED  Nov. 11, 2013
            July 24 2015   uses oop


=head2 NOTES 
  
=head2 USES
   
=head2 STEPS IN THE PROGRAM 

=cut

=head2 inherit and Instantiate

   classes 
    Create a new version of the package
    Personalize to give it a new name if you wish
    Use classes:
                  suvelan

=cut

use Moose;
use flow;
use manage_files_by;
use sufilter;
use sugain;
use susort;
use suvelan;
use suwind;
use suximage;
use suxwigb;
use Project_config;
use message;
use SeismicUnix qw($on $off $in $to $go);

#print(" iSuvelan on,off,in,to,go: $on $off $in $to $go \n");
my $log               = new message();
my $run               = new flow();
my $sufilter          = new sufilter();
my $sugain            = new sugain();
my $susort            = new susort();
my $suvelan           = new suvelan;
my $suwind            = new suwind;
my $suximage          = new suximage();
my $suxwigb           = new suxwigb();
my $Project           = new Project_config();
my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
my ($PL_SEISMIC)      = $Project->PL_SEISMIC();

=head2
 
 establish just the locally scoped variables

=cut

my ( @suwind_min, @suwind_max );
my ( @sufilter,   @suvelan, @suximage, @suxwigb );
my ( @susort,     @sugain, @suwind, @wgagc, @bandpass );
my (@cp);
my ( @suximage_col_bar_max, @suximage_col_bar_min );
my (@windowtitle);
my ($N);
my ( @suximage_first_vel,  @suximage_vel_inc );
my ( @first_velocity_tick, @suximage_vel_tick_inc );
my ( @base_caption,        @tlabel, @xlabel, @X0, @Y0, @max_abs );
my ( @flow,                @items );

=head2  hash array of important variables

 used within
  this package

=cut 

my $iSuvelan = {
    _cdp_num              => '',
    _cdp_num_suffix       => '',
    _data_scale           => '',
    _dt_s                 => '',
    _file_in              => '',
    _first_velocity       => '',
    _freq                 => '',
    _inbound              => '',
    _max_semblance        => '',
    _min_semblance        => '',
    _number_of_tries      => '',
    _number_of_velocities => '',
    _sufile_in            => '',
    _tmax_s               => '',
    _textfile_in          => '',
    _textfile_out         => '',
    _Tvel_inbound         => '',
    _Tvel_outbound        => '',
    _velocity_increment   => '',
};

=head2 subroutine clear

         to blank out hash array values

=cut

sub clear {
    $iSuvelan->{_cdp_num}              = '';
    $iSuvelan->{_cdp_num_suffix}       = '';
    $iSuvelan->{_data_scale}           = '';
    $iSuvelan->{_dt_s}                 = '';
    $iSuvelan->{_file_in}              = '';
    $iSuvelan->{_first_velocity}       = '';
    $iSuvelan->{_freq}                 = '';
    $iSuvelan->{_inbound}              = '';
    $iSuvelan->{_max_semblance}        = '';
    $iSuvelan->{_min_semblance}        = '';
    $iSuvelan->{_number_of_tries}      = '';
    $iSuvelan->{_number_of_velocities} = '';
    $iSuvelan->{_velocity_increment}   = '';
    $iSuvelan->{_sufile_in}            = '';
    $iSuvelan->{_textfile_in}          = '';
    $iSuvelan->{_textfile_out}         = '';
    $iSuvelan->{_Tvel_inbound}         = '';
    $iSuvelan->{_Tvel_outbound}        = '';
    $iSuvelan->{_tmax_s}               = '';
}

=head2 subroutine cdp_num


  establishes the CDP number being worked
  Also establishes'cdp'# as a recognizable suffix
  for file names

=cut

sub cdp_num {
    my ( $variable, $cdp_num ) = @_;
    if ($cdp_num) {
        $iSuvelan->{_cdp_num} = $cdp_num;

        #print("cdp_num in iSuvelan is $iSuvelan->{_cdp_num}\n\n");
    }
}

=head2 subroutine cdp_num_suffix


  establishes the CDP number suffix 
  that is being worked

=cut

sub cdp_num_suffix {
    my ( $variable, $cdp_num ) = @_;
    if ($cdp_num) {
        $iSuvelan->{_cdp_num_suffix} = '_cdp' . $cdp_num;

        #print("suffix in iSuvelan is $iSuvelan->{_cdp_num_suffix}\n\n");
    }
}

=head2 subroutine data_scale


=cut

sub data_scale {
    my ( $variable, $data_scale ) = @_;
    $iSuvelan->{_data_scale} = $data_scale if defined($data_scale);
}

=head2 subroutine dt_s


=cut

sub dt_s {
    my ( $variable, $dt_s ) = @_;
    if ($dt_s) {
        $iSuvelan->{_dt_s} = $dt_s;
    }
}

=head2 subroutine file_in

   gets the file name
   creates the sufile name to read
   creates the full path for reading the sufile

   print("iSuvelan_inbound is $iSuvelan->{_inbound}\n\n");

=cut

sub file_in {
    my ( $variable, $file_in ) = @_;
    if ($file_in) {
        $iSuvelan->{_file_in}   = $file_in;
        $iSuvelan->{_sufile_in} = $file_in . '.su';
    }
    $iSuvelan->{_inbound} = $DATA_SEISMIC_SU . '/' . $iSuvelan->{_sufile_in};
}

=head2  subroutine first_velocity

    print("first velocity is $iSuvelan->{_first_velocity} \n\n");

=cut

sub first_velocity {
    my ( $variable, $first_velocity ) = @_;
    if ($first_velocity) {
        $iSuvelan->{_first_velocity} = $first_velocity;
    }
}

=head2 subroutine freq

  creates the bandpass frequencies to filter data before
  conducting semblance analysis
  e.g., "3,6,40,50"
 
=cut

sub freq {
    my ( $variable, $freq ) = @_;
    $iSuvelan->{_freq} = $freq if defined($freq);
}

=head2  subroutine  number_of_tries

    keep track of the number of attempts
    at picking velocities

=cut

sub number_of_tries {
    my ( $variable, $number_of_tries ) = @_;
    $iSuvelan->{_number_of_tries} = $number_of_tries
      if defined($number_of_tries);

#print("num of tries is $iSuvelan->{_number_of_tries}\n\n");
#print("\nReading: $Tvel_iSuvelan->{_inbound} \nTime=$$ref_T_nmo[1],Vel=$$ref_Vnmo[1],npairs=$num_tvel_pairs \n");

}

=head2 subroutine tmax_s


=cut

sub tmax_s {
    my ( $self, $tmax_s ) = @_;
    if ($tmax_s) {
        $iSuvelan->{_tmax_s} = $tmax_s;
    }
}

=head2  subroutine velocity increment 


=cut

sub velocity_increment {
    my ( $variable, $velocity_increment ) = @_;
    $iSuvelan->{_velocity_increment} = $velocity_increment
      if defined($velocity_increment);

    #print("velocity_increment is $iSuvelan->{_velocity_increment} \n\n");
}

=head2 subroutine calcNdisplay

  calculate semblance and display results 

=cut

sub calcNdisplay {

    # print(" iSuvelan, calcNdisplay\n\n");

=head2 WINDOW  DATA

by cdp 

=cut

    $suwind_min[1] = $iSuvelan->{_cdp_num};
    $suwind_max[1] = $iSuvelan->{_cdp_num};

    $suwind->clear();
    $suwind->setheaderword( quotemeta('cdp') );
    $suwind->min( quotemeta( $suwind_min[1] ) );
    $suwind->max( quotemeta( $suwind_max[1] ) );
    $suwind[1] = $suwind->Step();

=head2 WINDOW  DATA 

by time 

=cut

    $suwind->clear();
    $suwind->tmin( quotemeta(0) );
    $suwind->tmax( quotemeta( $iSuvelan->{_tmax_s} ) );
    $suwind[2] = $suwind->Step();

    # SORT data into CDP before calcualting semblance
    $susort->clear();
    $susort->headerword( quotemeta('cdp') );
    $susort->headerword( quotemeta('offset') );
    $susort[1] = $susort->Step();

=head2 GAIN DATA

 print("iSuvelan,calculated wagc = $width\n");
 ROT 10% window length
 data in velan is not gained

=cut

    $sugain->clear();
    $sugain->pbal( quotemeta($on) );
    $sugain[1] = $sugain->Step();

    $sugain->clear();
    $sugain->agc( quotemeta($on) );
    my $width = 0.1 * $iSuvelan->{_tmax_s};
    $sugain->width( quotemeta($width) );

    # $sugain    -> setdt(1000);
    $sugain[2] = $sugain->Step();

=head2

  set filtering parameters 

=cut

    $sufilter->clear();
    $sufilter->freq( quotemeta( $iSuvelan->{_freq} ) );
    $sufilter[1] = $sufilter->Step();

=head2 semblance analysis

 a scaling factor is needed to match 
 scalel found in data headers

=cut

    $suvelan->clear();
    $suvelan->number_of_velocities(
        quotemeta( $iSuvelan->{_number_of_velocities} ) );
    $suvelan->velocity_increment(
        quotemeta(
            ( $iSuvelan->{_velocity_increment} * $iSuvelan->{_data_scale} )
        )
    );
    $suvelan->first_velocity(
        quotemeta(
            ( $iSuvelan->{_first_velocity} * $iSuvelan->{_data_scale} )
        )
    );
    $suvelan[1] = suvelan->Step();

=head2 DISPLAY DATA

 scaling factor is needed to match scalel found in data headers
 for the purpose of digitizing data

=cut

    #my $time_inc_major 	  =  $time_inc_minor * 2;
    my $time_inc_major = $iSuvelan->{_tmax_s} / 10;

    #my $time_inc_minor	  =  $time_inc_major / 2;
    my $number_minor_time_divisions = 2;

    # to make Jorge Reyes' data work
    #my $new_dt_s            = $iSuvelan->{_tmax_s} * $iSuvelan->{_dt_s} ;
    my $new_dt_s = $iSuvelan->{_dt_s};

    # print("iSuvelan,tmax_s $iSuvelan->{_tmax_s}\n");
    # print("iSuvelan,new_dt_s $new_dt_s\n");

    $N = 2;
    $windowtitle[1] = '\('
      . $N . '\)\ '
      . $iSuvelan->{_sufile_in}
      . '\ CDP=\ '
      . $iSuvelan->{_cdp_num};

    #units=Semblance					\\
    $suximage->clear();
    $suximage->box_width( quotemeta(300) );
    $suximage->box_height( quotemeta(450) );
    $suximage->box_X0( quotemeta(600) );
    $suximage->box_Y0( quotemeta(0) );
    $suximage->title( quotemeta( $iSuvelan->{_cdp_num_suffix} ) );
    $suximage->windowtitle( quotemeta('Semblance') );
    $suximage->ylabel( quotemeta('TWTT (s)') );
    $suximage->xlabel( quotemeta('Velocity (m/s)') );
    $suximage->legend( quotemeta($on) );
    $suximage->cmap( quotemeta('hsv2') );
    $suximage->first_x( quotemeta( $iSuvelan->{_first_velocity} ) );
    $suximage->dx( quotemeta( $iSuvelan->{_velocity_increment} ) );

    #$suximage -> dt_s($new_dt_s);
    $suximage->loclip( quotemeta( $iSuvelan->{_min_semblance} ) );
    $suximage->hiclip( quotemeta( $iSuvelan->{_max_semblance} ) );
    $suximage->verbose( quotemeta($off) );

    #print ("d2num is ($iSuvelan->{_velocity_increment})\n\n");
    $suximage->dx_major_divisions(
        quotemeta( ( $iSuvelan->{_velocity_increment} ) * 10 ) );
    $suximage->dy_minor_divisions( quotemeta($number_minor_time_divisions) );
    $suximage->dy_major_divisions( quotemeta($time_inc_major) );

    #$suximage -> percent4clip(quotemeta(95.0);
    $suximage->first_tick_number_x( quotemeta( $iSuvelan->{_first_velocity} ) );
    $suximage->picks( $iSuvelan->{_Tvel_outbound} )
      ;    # quotemeta does not work JL Nov 2 2018
     #print("iSuvelan, calcNdisplay: Writing picks to $iSuvelan->{_Tvel_outbound}\n\n");

=head2 conditions
 
 when number_of_tries is >=2 
 there should be a pre-exisiting digitized
 overlay curve to plot as well

=cut

    if ( $iSuvelan->{_number_of_tries} >= 2 ) {

        # print("using a curve file:\n");
        # print("\t$iSuvelan->{_Tvel_inbound}\n\n");
        $suximage->curvefile( quotemeta( $iSuvelan->{_Tvel_inbound} ) )
          ;    # does not like quotemeta
        my ( $ref_T_nmo, $ref_Vnmo, $num_tvel_pairs ) =
          manage_files_by::read_2cols( \$iSuvelan->{_Tvel_inbound} );
        $suximage->npair( quotemeta($num_tvel_pairs) );
        $suximage->curvecolor( quotemeta(2) );
    }

    $suximage[1] = $suximage->Step();

    # print("$suximage[1]\n\n");

    $N = 1;

=head2  set suxwigb parameters

  In the perl module for suxwigb we should
  have (but we do not yet) an explanation of each of
  these parameters

=cut

    $suxwigb->clear();
    $suxwigb->title( quotemeta( $iSuvelan->{_sufile_in} ) );
    $suxwigb->ylabel( quotemeta('Time s') );
    $suxwigb->xlabel( quotemeta('Offset m') );
    $suxwigb->box_width( quotemeta(300) );
    $suxwigb->box_height( quotemeta(450) );
    $suxwigb->box_X0( quotemeta(875) );
    $suxwigb->box_Y0( quotemeta(0) );
    $suxwigb->absclip( quotemeta(2) );
    $suxwigb->xcur( quotemeta(1) );
    $suxwigb->windowtitle( quotemeta( $iSuvelan->{_cdp_num_suffix} ) );
    $suxwigb->shading( quotemeta(1) );
    $suxwigb[1] = $suxwigb->Step();

=head2  DEFINE FLOW(S)

  in interactive mode:
  First time you see the image number_of_tries =0
  the suximage is not interactive ( uses '&') 
  Second, third, etc. times (number_of_tries >= 1)
  The image will halt the flow  ('wait'), to allow user to 
  make new picks

  On the other hand suxwigb does not change between the numbers
  of attempts

=cut

    @items = (
        $susort[1],   $in, $iSuvelan->{_inbound}, $to,
        $suwind[1],   $to, $suwind[2],            $to,
        $sufilter[1], $to, $sugain[2],            $to,
        $suxwigb[1],  $go
    );
    $flow[1] = $run->modules( \@items );

=head2  do not halt flow

  print(" suximage NO HALT with num tries $iSuvelan->{_number_of_tries}\n\n");

=cut

    if ( $iSuvelan->{_number_of_tries} == 0 ) {
        @items = (
            $susort[1],   $in, $iSuvelan->{_inbound}, $to,
            $suwind[1],   $to, $suwind[2],            $to,
            $sufilter[1], $to, $suvelan[1],           $to,
            $suximage[1], $go
        );
        $flow[2] = $run->modules( \@items );
    }

=head2  do not halt flow either 

DB

  print("2.suximage WITH HALT \n");
  print("2. number of tries is  $iSuvelan->{_number_of_tries}\n\n");

#,';',' wait'); 
             #$to,$sufilter[1],$to,$suvelan[1],$to,$suximage[1],$go); 
=cut

    if ( $iSuvelan->{_number_of_tries} >= 1 ) {
        @items = (
            $susort[1],   $in, $iSuvelan->{_inbound}, $to,
            $suwind[1],   $to, $suwind[2],            $to,
            $sufilter[1], $to, $suvelan[1],           $to,
            $suximage[1], $go
        );
        $flow[2] = $run->modules( \@items );
    }

=head2

  RUN FLOW(S)
  output copy of picked data points
  only occurs after the number of tries
  is updated

=cut

    $run->flow( \$flow[1] );
    $run->flow( \$flow[2] );

=head2  LOG FLOW(S)

 TO SCREEN AND FILE

=cut

    # print  "$flow[1]\n";
    #  print  "$flow[2]\n";
    #  $log->file($flow[1]);
    #  $log->file($flow[2]);
    #
}

# end of calc_display subroutine

=head2  subroutine maximum semblance to plot 


=cut

sub max_semblance {
    my ( $variable, $max_semblance ) = @_;
    $iSuvelan->{_max_semblance} = $max_semblance if defined $max_semblance;
}

=head2  subroutine minimum semblance to plot 


=cut

sub min_semblance {
    my ( $variable, $min_semblance ) = @_;
    $iSuvelan->{_min_semblance} = $min_semblance if defined $min_semblance;
}

=head2  subroutine  TV pick file in


=cut

sub Tvel_inbound {
    my ( $variable, $Tvel_inbound ) = @_;
    $iSuvelan->{_Tvel_inbound} = $Tvel_inbound if defined $Tvel_inbound;
}

=head2 

 subroutine TV pick file out

=cut

sub Tvel_outbound {
    my ( $variable, $Tvel_outbound ) = @_;
    $iSuvelan->{_Tvel_outbound} = $Tvel_outbound if defined $Tvel_outbound;
}

=head2 

 subroutine number_of_velocities 

=cut

sub number_of_velocities {
    my ( $variable, $number_of_velocities ) = @_;
    $iSuvelan->{_number_of_velocities} = $number_of_velocities
      if defined $number_of_velocities;

    #print(" number_of_velocities is $iSuvelan->{_number_of_velocities} \n\n");
}

#end of iSuvelan

