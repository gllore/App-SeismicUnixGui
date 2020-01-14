package iBottomMutePicks2par3;

use Moose;
use message;
use flow;
use mkparfile;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME:iBottomMutePicks2par3.pm
 AUTHOR: Juan Lorenzo
 DATE: June 12 2017 

 DESCRIPTION: 

 Purpose: write data pairs to par format for input to sumute 


=head2 USE

=head3 NOTES 

=head4 
Examples

=head3 SEISMIC UNIX NOTES  

=head4 CHANGES and their DATES

  V 1. May 5 2009
  V2 for interactive top mute picks
  V3 Sept.19 2015 perl oops for use with GUI 
  June 14 adapted from iTopMutePicks2par3.pm


=head3 STEPS

1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs  each of the 
    Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

=pod

 instantiate classes

=cut

my $log       = new message();
my $run       = new flow();
my $mkparfile = new mkparfile();

=pod
 
 declare variables types
 establish just the locally scoped variables

=cut

my @mkparfile;
my ( $mkparfile_in,  $mkparfile_inbound );
my ( $mkparfile_out, $mkparfile_outbound );
my ( @items,         @flow );

=pod

 create hash with important variables

=cut

my $iBottomMutePicks2par3 = {
    _TX_inbound    => '',
    _TX_outbound   => '',
    _taup_inbound  => '',
    _taup_outbound => '',
    _gather_num    => '',
    _exists        => '',
    _textfile_in   => '',
    _textfile_out  => '',
    _type          => ''
};

=head3

 Import file-name  and directory definitions

=cut 

use SeismicUnix
  qw ($true $false $in $out $to $ibot_mute_par_ $itemp_bot_mute_picks_ $itemp_bot_mute_picks_sorted_par_  $out $suffix_su);
my ($PL_SEISMIC) = System_Variables::PL_SEISMIC();

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $iBottomMutePicks2par3->{_TX_inbound}    = '';
    $iBottomMutePicks2par3->{_TX_outbound}   = '';
    $iBottomMutePicks2par3->{_taup_inbound}  = '';
    $iBottomMutePicks2par3->{_taup_outbound} = '';
    $iBottomMutePicks2par3->{_gather_num}    = '';
    $iBottomMutePicks2par3->{_exists}        = '';
    $iBottomMutePicks2par3->{_textfile_in}   = '';
    $iBottomMutePicks2par3->{_textfile_out}  = '';
    $iBottomMutePicks2par3->{_type}          = '';
}

=head3 subroutine file_in

 Required file name
 on which to pick bottom mute values

=cut

sub file_in {
    my ( $variable, $file_in ) = @_;
    $iBottomMutePicks2par3->{_file_in} = $file_in if defined($file_in);

    #print("file name is $iBottomMutePicks2par3->{_file_in} \n\n");
}

=head3 sub type

  switches for old data of two different types

   for type: tx or taup


=cut

sub type {
    my ( $variable, $type ) = @_;
    $iBottomMutePicks2par3->{_type} = $iBottomMutePicks2par3
      if defined($iBottomMutePicks2par3);
}

=pod subroutine calc 

 main processing flow
 reformats data  

=cut

sub calc {

=pod

  MAKE PARAMETER FILE
  CONVERT TEXT FILE TO PAR FILE

  In the old manner:
   	$mkparfile	=  ("mkparfile			\\
		string1=tmute 				\\
		string2=xmute 				\\
		");
=cut

=pod

 establish par file names

 TODO if no sorting is ever needed
 rm file name from $itemp_bot_mute_picks_sorted_par to itemp_bot_mute_picks

=cut

    $mkparfile_in = $itemp_bot_mute_picks_ . $iBottomMutePicks2par3->{_file_in};
    $mkparfile_out =
      $itemp_bot_mute_picks_sorted_par_ . $iBottomMutePicks2par3->{_file_in};

    $iBottomMutePicks2par3->{TX_inbound}  = $PL_SEISMIC . '/' . $mkparfile_in;
    $iBottomMutePicks2par3->{TX_outbound} = $PL_SEISMIC . '/' . $mkparfile_out;

    $mkparfile->clear();
    $mkparfile->string1('tmute');
    $mkparfile->string2('xmute');
    $mkparfile[1] = $mkparfile->Step();

    # DEFINE FLOW(s)
    # CONVERT t-p picks to t-trace picks
    #   $taup = $taup_data;
    #
    #   if ($taup == $true) {
    #	print("Mute picks inbound file: $mkparfile_inbound[1]\n\n");
    #	print("This is taup data\n\n");
    #
    #	($ref_inbound) = iTop_Mute::tp_piks2ttr(\@mkparfile_inbound[1]);
    #
    #	$flow[1] = (" 						\\
    #		$mkparfile[1] 					\\
    #		< $$ref_inbound[1] 				\\
    #		>$mkparfile_outbound[1]  			\\
    #								\\
    #		");
    #
    #   }
    #  elsif ($taup == $false) {

    #  in the current flow below
    #  }

=pod
 
  DEFINE FLOW(S)

 In the old manner (non oops):

	$flow[1] = (" 						\\
		$mkparfile[1] 					\\
		< $mkparfile_inbound[1]				\\
		>$mkparfile_outbound[1]				\\
								\\
		"); 

=cut

    #   print("Regular xt data\n\n");

    @items = (
        $mkparfile[1], $in, $iBottomMutePicks2par3->{TX_inbound},
        $out, $iBottomMutePicks2par3->{TX_outbound}
    );
    $flow[1] = $run->modules( \@items );

=pod

  RUN FLOW(S)
  output copy of picked data points
  only occurs after the number of tries
  is updated

=cut

    $run->flow( \$flow[1] );

=pod

  LOG FLOW(S)TO SCREEN AND FILE

=cut

    #print  "$flow[1]\n";
    #$log->file($flow[1]);

}    # end calc subroutine

1;
