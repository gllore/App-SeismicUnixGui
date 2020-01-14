package iTop_Mute3;

=head1 DOCUMENTATION
=head2 SYNOPSIS 

 PACKAGE NAME: iTop_Mute3.pm 
 AUTHOR: Juan Lorenzo
 DATE:  Sept. 14 2015 
         
         

 DESCRIPTION: 
 Version: 1.1
 Package used for interactive top mute 

=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 SEISMIC UNIX NOTES  

=head4 CHANGES and their DATES


=cut

=head2 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs  each of the 
    Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

set defaults

VELAN DATA 
 m/s

=cut

my $iTop_Mute3 = {
    _gather_header     => '',
    _offset_type       => '',
    _gather_num        => '',
    _gather_num_suffix => '',
    _exists            => '',
    _file_in           => '',
    _freq              => '',
    _gather_type       => '',
    _min_amplitude     => '',
    _max_amplitude     => '',
    _next_step         => '',
    _number_of_tries   => '',
    _TX_inbound        => '',
    _TX_outbound       => '',
    _textfile_in       => '',
    _textfile_out      => ''
};

=head2 Import 

  packages
  directory definitions

=cut 

use Moose;
use message;
use cp;
use flow;
use iApply_top_mute3;
use iSelect_tr_Sumute_top3;
use iTopMutePicks2par3;
use old_data;
use iSave_top_mute_picks3;
use SuMessages;
use SeismicUnix
  qw ($on $off $in $to $go $itop_mute_par_ $itop_mute_check_pickfile_ $false $true );
my ($PL_SEISMIC)      = System_Variables::PL_SEISMIC();
my ($DATA_SEISMIC_SU) = System_Variables::DATA_SEISMIC_SU();
my ($date)            = System_Variables::date();

=head2 instantiate 

 programs

=cut

my $cp                    = new cp();
my $log                   = new message();
my $run                   = new flow();
my $iApply_top_mute       = new iApply_top_mute3();
my $iSelect_tr_Sumute_top = new iSelect_tr_Sumute_top3();
my $iPicks2par            = new iTopMutePicks2par3();
my $check4old_data        = new old_data;
my $iSave_top_mute_picks  = new iSave_top_mute_picks3();
my $SuMessages            = new SuMessages();

=head2
 
 declare variables types
 establish just the locally scoped variables

=cut

my ( @flow, @cp, @items );

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $iTop_Mute3->{_gather_num}        = '';
    $iTop_Mute3->{_gather_type}       = '';
    $iTop_Mute3->{_gather_header}     = '';
    $iTop_Mute3->{_offset_type}       = '';
    $iTop_Mute3->{_gather_num_suffix} = '';
    $iTop_Mute3->{_exists}            = '';
    $iTop_Mute3->{_file_in}           = '';
    $iTop_Mute3->{_freq}              = '';
    $iTop_Mute3->{_min_amplitude}     = '';
    $iTop_Mute3->{_max_amplitude}     = '';
    $iTop_Mute3->{_next_step}         = '';
    $iTop_Mute3->{_number_of_tries}   = '';
    $iTop_Mute3->{_textfile_in}       = '';
    $iTop_Mute3->{_textfile_out}      = '';
    $iTop_Mute3->{_TX_inbound}        = '';
    $iTop_Mute3->{_TX_outbound}       = '';
}

=head2 subroutine gather_header

  define which values  to use in the xaxis 

=cut

sub gather_header {
    my ( $variable, $gather_header ) = @_;
    $iTop_Mute3->{_gather_header} = $gather_header if defined($gather_header);
}

=head2 subroutine offset_type

  define which values  to use in the xaxis 

=cut

sub offset_type {
    my ( $variable, $offset_type ) = @_;
    $iTop_Mute3->{_offset_type} = $offset_type if defined($offset_type);

    #print("offset type -2 $offset_type\n\n");
}

=head2 subroutine gather_type

  define which family of messages to use

=cut

sub gather_type {
    my ( $variable, $gather_type ) = @_;
    $iTop_Mute3->{_gather_type} = $gather_type if defined($gather_type);
}

=head2 subroutine iSelect_tr_Sumute_top

 Select mute points in traces
  provide file name
 
=cut

sub iSelect_tr_Sumute_top {
    $iSelect_tr_Sumute_top->gather_type( $iTop_Mute3->{_gather_type} );
    $iSelect_tr_Sumute_top->offset_type( $iTop_Mute3->{_offset_type} );
    $iSelect_tr_Sumute_top->gather_header( $iTop_Mute3->{_gather_header} );
    $iSelect_tr_Sumute_top->file_in( $iTop_Mute3->{_file_in} );
    $iSelect_tr_Sumute_top->freq( $iTop_Mute3->{_freq} );
    $iSelect_tr_Sumute_top->gather_num( $iTop_Mute3->{_gather_num} );
    $iSelect_tr_Sumute_top->min_amplitude( $iTop_Mute3->{_min_amplitude} );
    $iSelect_tr_Sumute_top->max_amplitude( $iTop_Mute3->{_max_amplitude} );
    $iSelect_tr_Sumute_top->number_of_tries( $iTop_Mute3->{_number_of_tries} );
    $iSelect_tr_Sumute_top->calcNdisplay();
}

=head2 subroutine iApply_top_mute

  Mute the data using selected parameters 
 
=cut

sub iApply_top_mute {
    $iApply_top_mute->file_in( $iTop_Mute3->{_file_in} );
    $iApply_top_mute->gather_header( $iTop_Mute3->{_gather_header} );
    $iApply_top_mute->offset_type( $iTop_Mute3->{_offset_type} );
    $iApply_top_mute->freq( $iTop_Mute3->{_freq} );
    $iApply_top_mute->gather_num( $iTop_Mute3->{_gather_num} );
    $iApply_top_mute->min_amplitude( $iTop_Mute3->{_min_amplitude} );
    $iApply_top_mute->max_amplitude( $iTop_Mute3->{_max_amplitude} );
    $iApply_top_mute->calcNdisplay();
}

=head2 subroutine iPicks2par

 convert format of pick files for use later
 into "par" format 
 
=cut

sub iPicks2par {
    $iPicks2par->file_in( $iTop_Mute3->{_file_in} );
    $iPicks2par->calc();
}

=head2 subroutine iSave_top_mute_picks

 save pick files for later use
 
=cut

sub iSave_top_mute_picks {
    $iSave_top_mute_picks->gather_num( $iTop_Mute3->{_gather_num} );
    $iSave_top_mute_picks->gather_header( $iTop_Mute3->{_gather_header} );
    $iSave_top_mute_picks->gather_type( $iTop_Mute3->{_gather_type} );
    $iSave_top_mute_picks->file_in( $iTop_Mute3->{_file_in} );
    $iSave_top_mute_picks->calc();
}

=head2 sub set_message

  define the message family (type) to use
  also set the gather nuimber (TODO: move option elsewhere)

=cut

sub set_message {
    my ( $variable, $type ) = @_;
    $iTop_Mute3->{_message_type} = $type if defined($type);
    $SuMessages->set( $iTop_Mute3->{_message_type} );

=head2

    update gather number for messages

=cut

    $SuMessages->gather_num( $iTop_Mute3->{_gather_num} );
    $SuMessages->gather_header( $iTop_Mute3->{_gather_header} );
    $SuMessages->gather_type( $iTop_Mute3->{_gather_type} );
}

=head2 subroutine  message

  instructions 

=cut

sub message {
    my ( $variable, $instructions ) = @_;
    $iTop_Mute3->{_instructions} = $instructions if defined($instructions);

=head2
    update gather number for messages
=cut

    $SuMessages->gather_num( $iTop_Mute3->{_gather_num} );
    $SuMessages->instructions( $iTop_Mute3->{_instructions} );
    $SuMessages->gather_header( $iTop_Mute3->{_gather_header} );
    $SuMessages->gather_type( $iTop_Mute3->{_gather_type} );
}

=head2 

look for old data

  Are there old picks to read?
  These old picks are of a type e.g. velan or gather
  

=cut

sub type {

    my ( $variable, $type ) = @_;
    $iTop_Mute3->{_type} = $type if defined($type);
    $check4old_data->gather_num( $iTop_Mute3->{_gather_num} );
    $iTop_Mute3->{_exists} = $check4old_data->type( $iTop_Mute3->{_type} );

    return $iTop_Mute3->{_exists};
}

=head2 subroutine gather_num

  sets gather number to consider  

=cut

sub gather_num {
    my ( $variable, $gather_num ) = @_;
    $iTop_Mute3->{_gather_num} = $gather_num if defined($gather_num);
    $iTop_Mute3->{_gather_num_suffix} = '_gather' . $iTop_Mute3->{_gather_num}

}

=head2

 subroutine file_in
 Required file name
 on which to pick top mute values

=cut

sub file_in {
    my ( $variable, $file_in ) = @_;
    $iTop_Mute3->{_file_in} = $file_in if defined($file_in);

    #print("file name is $iTop_Mute3->{_file_in} \n\n");
}

=head2

 subroutine data_scale 
 Required data plotting scale 

=cut

sub data_scale {
    my ( $variable, $data_scale ) = @_;
    $iTop_Mute3->{_data_scale} = $data_scale if defined($data_scale);

    #print("ds=$iTop_Mute3->{_data_scale}\n\n");
}

=head2

 subroutine freq
  creates the bandpass frequencies to filter data before
  conducting amplitude analysis
  e.g., "3,6,40,50"
 
=cut

sub freq {
    my ( $variable, $freq ) = @_;
    $iTop_Mute3->{_freq} = $freq if defined($freq);

    #print("freq is $iTop_Mute3->{_freq}\n\n");
}

=head2

 subroutine maximum amplitude to plot 

=cut

sub max_amplitude {
    my ( $variable, $max_amplitude ) = @_;
    $iTop_Mute3->{_max_amplitude} = $max_amplitude if defined($max_amplitude);

    #print("max_amplitude is $iTop_Mute3->{_max_amplitude}\n\n");
}

=head2

 subroutine minumum amplitude to plot 

=cut

sub min_amplitude {
    my ( $variable, $min_amplitude ) = @_;
    $iTop_Mute3->{_min_amplitude} = $min_amplitude if defined($min_amplitude);

    #print("min_amplitude is $iTop_Mute3->{_min_amplitude}\n\n");
}

=head2

 subroutine number_of_tries 
 required count of the number of attempts
 at estimating the velocity

=cut

sub number_of_tries {
    my ( $variable, $number_of_tries ) = @_;
    $iTop_Mute3->{_number_of_tries} = $number_of_tries
      if defined($number_of_tries);

    #print("number_of_tries is $iTop_Mute3->{_number_of_tries} \n\n");
}

=head2

 subroutine icp_sorted_2_old_picks
 When user wants to recheck the data 
 this subroutine will allow the user to 
 recheck  using an old sorted file
 Juan M. Lorenzo
 Jan 10 2010

    input file is ivpicks_sorted
    output pick file 
    text file out: ivpicks_old 


=cut 

sub icp_sorted2oldpicks {

    my ( $inbound, $outbound );
    my ($writefile_out);
    my ($flow);
    my ( $suffix, $sortfile_in, $sorted_suffix, $XTpicks_out, $XTpicks_in );

    # suffixes
    $sorted_suffix = '_sorted';
    $suffix        = '_gather' . $iTop_Mute3->{_gather_num};

    #XT file names
    $XTpicks_in  = 'XTpicks_old' . $sorted_suffix;
    $XTpicks_out = 'XTpicks_old';

    # sort file names
    $sortfile_in = $XTpicks_in;
    $inbound =
        $PL_SEISMIC . '/'
      . $sortfile_in . '_'
      . $iTop_Mute3->{_file_in} . '_'
      . $iTop_Mute3->{_gather_num_suffix};

    # TX write file names
    $writefile_out = $XTpicks_out;
    $outbound =
        $PL_SEISMIC . '/'
      . $writefile_out . '_'
      . $iTop_Mute3->{_file_in} . '_'
      . $iTop_Mute3->{_gather_num_suffix};

    $cp->from($inbound);
    $cp->to($outbound);
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

    #print  "$flow[1]\n";
    #$log->file($flow[1]);

    #end of copy of XT old picks sorted to iXTpicks_old
}

1;
