package iApply_bottom_mute;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: iApply_bottom_mute
 AUTHOR: Juan Lorenzo

 DESCRIPTION:
 Purpose: Linear Top Mute of Data 
         V3 Sept. 23, 2015: added oop functionality

=head2 USE

=head2 NOTES 

=head4 
 Examples

=cut

use Moose;
my $VERSION = '1.0.3';
use App::SeismicUnixGui::misc::message;
use App::SeismicUnixGui::misc::flow;
use App::SeismicUnixGui::sunix::filter::sufilter;
use App::SeismicUnixGui::sunix::shapeNcut::sugain;
use App::SeismicUnixGui::sunix::shapeNcut::sumute;
use App::SeismicUnixGui::sunix::shapeNcut::suwind;
use App::SeismicUnixGui::sunix::plot::suxwigb;
use App::SeismicUnixGui::sunix::plot::suximage;
use App::SeismicUnixGui::configs::big_streams::Project_config;
use App::SeismicUnixGui::messages::SuMessages;
use App::SeismicUnixGui::misc::SeismicUnix
  qw ($go $in $on $off $ibot_mute $itemp_bot_mute_picks_ $itemp_bot_mute_num_points $itemp_bot_mute_picks_sorted_par_ $ibot_mute_par_ $suffix_su $suffix_hyphen $to);

=head2

 inherit other packages
   1. Instantiate classes 
       Create a new version of the package
       Personalize to give it a new name if you wish
     Use the following classes:

=cut

my $log        = new message();
my $run        = new flow();
my $sufilter   = new sufilter();
my $sugain     = new sugain();
my $sumute     = new sumute();
my $suwind     = new suwind;
my $suxwigb    = new suxwigb();
my $suximage   = new suximage();
my $Project    = new Project_config();
my $SuMessages = new SuMessages();

=head2

 Import file-name  and directory definitions

=cut 

use App::SeismicUnixGui::misc::SeismicUnix qw($itemp_bot_mute_picks_sorted_par_);
my ($PL_SEISMIC)      = $Project->PL_SEISMIC();
my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();

=head2
 
 establish just the locally scoped variables

=cut

my ( @items, @flow, @sugain, @sufilter, @suwind );
my ( @suximage,    @sumute );
my ( $windowtitle, $base_caption );

=head2

  hash array of important variables used within
  this package
  Assume that the parameter file already exists
  Assume that the name of this parameter file is:
     $itemp_bot_mute_picks_sorted_par_.$iApply_bottom_mute->{_file_in}

=cut

my $iApply_bottom_mute = {
    _gather_num      => '',
    _gather_header   => '',
    _offset_type     => '',
    _file_in         => '',
    _freq            => '',
    _inbound         => '',
    _message_type    => '',
    _number_of_tries => '',
    _textfile_in     => '',
    _parfile_in      => ''
};

=head2

 subroutine clear
         to blank out hash array values

=cut

sub clear {
    $iApply_bottom_mute->{_gather_num}      = '';
    $iApply_bottom_mute->{_file_in}         = '';
    $iApply_bottom_mute->{_freq}            = '';
    $iApply_bottom_mute->{_inbound}         = '';
    $iApply_bottom_mute->{_message_type}    = '';
    $iApply_bottom_mute->{_gather_header}   = '';
    $iApply_bottom_mute->{_offset_type}     = '';
    $iApply_bottom_mute->{_number_of_tries} = '';
    $iApply_bottom_mute->{_file_in}         = '';
    $iApply_bottom_mute->{_parfile_in}      = '';
    $iApply_bottom_mute->{_textfile_in}     = '';
}

=head2 subroutine gather_header

  define the header for the xmute values
  binheader type value helps define the xmute values
  e.g. if gather_header = 'gather'
             the the xmute values are 'offset'

=cut

sub gather_header {
    my ( $variable, $gather_header ) = @_;
    $iApply_bottom_mute->{_gather_header} = $gather_header
      if defined($gather_header);

    #print(" header type is $iApply_bottom_mute->{_gather_header}\n\n");
}

=head2 subroutine offset_type

  define the header for the xmute values
  offset type value helps define the xmute values
  e.g. if offset_type = 'gather'
             the the xmute values are 'offset'

=cut

sub offset_type {
    my ( $variable, $offset_type ) = @_;
    $iApply_bottom_mute->{_offset_type} = $offset_type
      if defined($offset_type);

    #print(" header type is $iApply_bottom_mute->{_offset_type}\n\n");
}

=head2 subroutine gather

  sets gather number to consider  

=cut

sub gather_num {
    my ( $variable, $gather_num ) = @_;
    $iApply_bottom_mute->{_gather_num} = $gather_num if defined($gather_num);
}

=head2

 subroutine freq
  creates the bandpass frequencies to filter data
   e.g., "3,6,40,50"
 
=cut

sub freq {
    my ( $variable, $freq ) = @_;
    $iApply_bottom_mute->{_freq} = $freq if defined($freq);

    #print("freq is $iApply_bottom_mute->{_freq}\n\n");
}

=head2

 subroutine file_in
 Required file name
 on which to apply top mute values

=cut

sub file_in {
    my ( $variable, $file_in ) = @_;
    $iApply_bottom_mute->{_file_in} = $file_in if defined($file_in);
    $iApply_bottom_mute->{_inbound} =
      $DATA_SEISMIC_SU . '/' . $iApply_bottom_mute->{_file_in} . $suffix_su;
}

=head2

 subroutine minumum amplitude to plot 

=cut

sub min_amplitude {
    my ( $variable, $min_amplitude ) = @_;
    $iApply_bottom_mute->{_min_amplitude} = $min_amplitude
      if defined($min_amplitude);

    #print("min_amplitude is $iApply_bottom_mute->{_min_amplitude}\n\n");
}

=head2

 subroutine maximum amplitude to plot 

=cut

sub max_amplitude {
    my ( $variable, $max_amplitude ) = @_;
    $iApply_bottom_mute->{_max_amplitude} = $max_amplitude
      if defined($max_amplitude);

    #print("max_amplitude is $iApply_bottom_mute->{_max_amplitude}\n\n");
}

=head2 subroutine calcNdisplay

  main processing flow
  calculate mute and display results 

=cut

sub calcNdisplay {

=head2

  Assume that the parameter file already exists
  Assume that the name of this parameter file is:
     $itemp_bot_mute_picks_sorted_par_.$iApply_bottom_mute->{_file_in}

=cut 

    $iApply_bottom_mute->{_parfile_in} =
      $itemp_bot_mute_picks_sorted_par_ . $iApply_bottom_mute->{_file_in};

# print("iApply_bottom_mute_picks, mute pick file is $iApply_bottom_mute->{_parfile_in}\n\n");
# print("iApplybottom_mute_picks,PL_SEISMIC: $PL_SEISMIC\n");

=head2

 MUTE  DATA by  

=cut

    $sumute->clear();
    $sumute->par_directory('PL_SEISMIC');
    $sumute->parfile( $iApply_bottom_mute->{_parfile_in} );
    $sumute->headerword( $iApply_bottom_mute->{_offset_type} );
    $sumute->type('bottom');
    $sumute[1] = $sumute->Step();

=head2

 WINDOW  DATA   

=cut

    $suwind->clear();
    $suwind->setheaderword( $iApply_bottom_mute->{_gather_header} );
    $suwind->min( $iApply_bottom_mute->{_gather_num} );
    $suwind->max( $iApply_bottom_mute->{_gather_num} );

    #print("gather num is $iApply_bottom_mute->{_gather_num}\n\n");
    $suwind[1] = $suwind->Step();

    $suwind->clear();

    #$suwind   	-> setheaderword('time');
    $suwind->tmin(0);
    $suwind->tmax(1);
    $suwind[2] = $suwind->Step();

=head2

  set filtering parameters 

=cut

    $sufilter->clear();
    $sufilter->freq( $iApply_bottom_mute->{_freq} );
    $sufilter[1] = $sufilter->Step();

=head2

 GAIN DATA

=cut

    $sugain->clear();
    $sugain->pbal($on);
    $sugain[1] = $sugain->Step();

    $sugain->clear();
    $sugain->agc($on);
    $sugain->width(0.1);

    # $sugain     -> setdt(1000);
    $sugain[2] = $sugain->Step();

    $sugain->clear();
    $sugain->tpower(3);
    $sugain[3] = $sugain->Step();

=head2

 DISPLAY DATA

=cut

    $base_caption =
        $iApply_bottom_mute->{_file_in}
      . quotemeta(' f=')
      . $iApply_bottom_mute->{_freq};
    $windowtitle =
        $iApply_bottom_mute->{_gather_header}
      . quotemeta(' = ')
      . $iApply_bottom_mute->{_gather_num};

    $suximage->clear();
    $suximage->box_width(300);
    $suximage->box_height(700);
    $suximage->box_X0(70);
    $suximage->box_Y0(120);
    $suximage->title($base_caption);
    $suximage->windowtitle($windowtitle);
    $suximage->ylabel( quotemeta('TWTTs') );
    $suximage->xlabel( $iApply_bottom_mute->{_offset_type} );
    $suximage->legend($on);
    $suximage->cmap('rgb0');
    $suximage->loclip( $iApply_bottom_mute->{_min_amplitude} );
    $suximage->hiclip( $iApply_bottom_mute->{_max_amplitude} );
    $suximage->verbose($off);
    $suximage[1] = $suximage->Step();

=head2
 
  DEFINE FLOW(S)

=cut

    @items = (
        $suwind[1],   $in,        $iApply_bottom_mute->{_inbound},
        $to,          $suwind[2], $to,
        $sumute[1],   $to,        $sufilter[1],
        $to,          $sugain[2], $to,
        $suximage[1], $go
    );
    $flow[1] = $run->modules( \@items );

=head2

  RUN FLOW(S)
  output copy of picked data points
  only occurs after the number of tries
  is updated

=cut

    $run->flow( \$flow[1] );

=head2

  LOG FLOW(S)TO SCREEN AND FILE

=cut

    print "iApply_bottom_mute,$flow[1]\n";

    #$log->file($flow[1]);

}    # end calcNdisplay subroutine

1;
