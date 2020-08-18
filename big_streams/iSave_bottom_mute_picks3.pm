package iSave_bottom_mute_picks3;

use Moose;
use message;
use flow;
use cp;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME:iSave_bottom_mute_picks3.pm
 AUTHOR:  Juan Lorenzo
 DATE:    Nue 12 2017  
 Version: 3.0 

 DESCRIPTION: Originally to Save final Top Mute of Data

=head2 USE

=head4 

 Examples

=head2 SEISMIC UNIX NOTES

=head4 CHANGES and their DATES

 V1 May 5 2009 
 V2. change mute parameters to top mute parameters
 Aug 12, 2011
 V3.0 September 2015 :
          updated to oop
          introduced Tk widgets
          Made all event-driven
 June 12 2017 adapted from iSave_top_mute_picks3.pm

=head2 STEPS

  use the local library of the user
  bring is user variables from a local file
  create instances of the needed subroutines

=cut

=head2

 instantiate classes

=cut

my $log = new message();
my $run = new flow();
my $cp  = new cp();
my $Project = Project_config->new();

=head2

 declare variables types
 establish just the locally scoped variables

=cut

my ( @flow, @cp, @items );

=head2

 create hash with important variables

=cut

my $iSave_bot_mute_picks3 = {
    _gather_num    => '',
    _gather_type   => '',
    _gather_header => '',
    _file_in       => '',
    _inbound       => '',
    _outbound      => ''
};

=head2

 Import file-name  and directory definitions

=cut 

use SeismicUnix qw ($itemp_bot_mute_picks_sorted_par_ $ibot_mute_par_);
my ($PL_SEISMIC) = $Project->PL_SEISMIC();

=head2 subroutine clear

  sets all variable strings to '' 

=cut 

sub clear {
    $iSave_bot_mute_picks3->{_gather_num}    = '';
    $iSave_bot_mute_picks3->{_gather_type}   = '';
    $iSave_bot_mute_picks3->{_gather_header} = '';
    $iSave_bot_mute_picks3->{_inbound}       = '';
    $iSave_bot_mute_picks3->{_outbound}      = '';
}

=head2 subroutine file_in

 Required file name
 on which to pick bottom mute values

=cut

sub file_in {
    my ( $variable, $file_in ) = @_;
    $iSave_bot_mute_picks3->{_file_in} = $file_in if defined($file_in);

    #print("file name is $iSave_bot_mute_picks3->{_file_in} \n\n");

}

=head2 subroutine gather

  sets gather number to consider  

=cut

sub gather_num {
    my ( $variable, $gather_num ) = @_;
    $iSave_bot_mute_picks3->{_gather_num} = $gather_num
      if defined($gather_num);
}

=head2 subroutine gather_type

  sets gather_type number to consider  

=cut

sub gather_type {
    my ( $variable, $gather_type ) = @_;
    $iSave_bot_mute_picks3->{_gather_type} = $gather_type
      if defined($gather_type);
}

=head2 subroutine gather_header

  sets gather_header number to consider  

=cut

sub gather_header {
    my ( $variable, $gather_header ) = @_;
    $iSave_bot_mute_picks3->{_gather_header} = $gather_header
      if defined($gather_header);
}

=head2 sub calc

 rewrite sorted picks into a permanent file

=cut

sub calc {    #
    my $suffix;

    $suffix = '_'
      . $iSave_bot_mute_picks3->{_gather_header}
      . $iSave_bot_mute_picks3->{_gather_num};

    $iSave_bot_mute_picks3->{_inbound} =
      $itemp_bot_mute_picks_sorted_par_ . $iSave_bot_mute_picks3->{_file_in};

    $iSave_bot_mute_picks3->{_outbound} =
        $PL_SEISMIC . '/'
      . $ibot_mute_par_
      . $iSave_bot_mute_picks3->{_file_in}
      . $suffix;

    $cp->from( $iSave_bot_mute_picks3->{_inbound} );
    $cp->to( $iSave_bot_mute_picks3->{_outbound} );
    $cp[1] = $cp->Step();

=head2

  DEFINE FLOW(S)

=cut 

    @items = ( $cp[1] );
    $flow[1] = $run->modules( \@items );

=head2

  RUN FLOW(S)

=cut 

    $run->flow( \$flow[1] );

=head2

  LOG FLOW(S)TO SCREEN AND FILE

=cut

    print "$flow[1]\n";

    #$log->file($flow[1]);

}    # end calc subroutine
1;
