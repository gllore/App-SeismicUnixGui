
=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: iTopMute (interactive Top Mute) 
 AUTHOR:  Juan Lorenzo

=head2 CHANGES and their DATES

 DATE:  April 2 2009  
        September 2015 :
          updated to oop
          introduced Tk widgets
          Made all event-driven
        July 27 2016 
 
     NEW:   read iTop_Mute3.config text file
     OLD:   import perl variables from 
             *.pm configuration file xi
            within ta local libAll 
            subdirectory
    binheader is used for everything serious
    gather is to be used to texting
    correct offset is essential for applying the mute

=head2 DESCRIPTION

   Interactively pick muting parameters

=head2 USE

=head2 Examples

=head2 SEISMIC UNIX NOTES

=head2 STEPS

 1.  use the local library of the user
 1.1 bring is user variables from a local file
 2.  create instances of the needed subroutines

=head2 NOTES 

 We are using Moose.
 Moose already declares that you need debuggers turned on
 so you don't need a line like the following:
 use warnings;

=cut

use Moose;
my $VERSION = '1.0.3';
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';
use aliased 'App::SeismicUnixGui::misc::readfiles';
use Tk;
use aliased 'App::SeismicUnixGui::big_streams::iTopMute';
use aliased 'App::SeismicUnixGui::configs::big_streams::iTopMute_config';
use App::SeismicUnixGui::misc::SeismicUnix qw($true $false );
use aliased 'App::SeismicUnixGui::sunix::shell::xk';

my $iTM_Tk = {_prompt => ''};


=head2 Instantiate classes:

 Create a new version of the package 
 with a unique name

=cut

my $iTM             = iTopMute->new();
my $iTopMute_config = iTopMute_config->new();
my $read            = readfiles->new();
my $get             = L_SU_global_constants->new();
my $var             = $get->var();
my $xk      		= xk->new();

=head2 Get configuration information

=cut

my ( $CFG_h, $CFG_aref ) = $iTopMute_config->get_values();

my $gather_header  = $CFG_h->{sumute}{1}{gather_header};
my $offset_type    = $CFG_h->{sumute}{1}{offset_type};
my $base_file_name = $CFG_h->{base_file_name};
my $first_gather   = $CFG_h->{sumute}{1}{first_gather};
my $last_gather    = $CFG_h->{sumute}{1}{last_gather};
my $gather_inc     = $CFG_h->{sumute}{1}{gather_inc};
my $freq           = $CFG_h->{sugain}{1}{freq};
my $gather_type    = $CFG_h->{sumute}{1}{gather_type};
my $min_amplitude  = $CFG_h->{sumute}{1}{min_amplitude};
my $max_amplitude  = $CFG_h->{sumute}{1}{max_amplitude};

#print("offset type -1 $offset_type\n\n");


=head2 Declare variables 

    in local memory space

=cut

my ( $calc_rb, $exit_rb, $pick_rb, $next_rb, $saveNcont_rb );
my $rb_value        = "red";
my $gather          = $first_gather;
my $next_step       = 'stop';
my $number_of_tries = 0;
my $there_is_old_data;
our $mw;

$iTM->number_of_tries($number_of_tries);
$iTM->file_in($base_file_name);
$iTM->gather_type($gather_type);
$iTM->gather_header($gather_header);
$iTM->offset_type($offset_type);
$iTM->freq($freq);
$iTM->min_amplitude($min_amplitude);
$iTM->max_amplitude($max_amplitude);
$iTM->gather_num($gather);
$iTM->set_message('iTopMute');


=head2

  Check for old data
  check to see if prior mute parameter files exist for this   project 
	if(($$old_data[1] eq $true) && $$old_data[2] eq $false) ) {
		print ("mute picks exist, but ... \n\n");
		print ("mute parameters should exist but can not be found\n\n");
		print ("resetting the existence file\n\n");
		manage_files_by::write_one(\$check_if_itop_mute_picks_exist);

=cut

$there_is_old_data = $iTM->type('TopMute');

if ($there_is_old_data) {
    print("Old picks already exist.\n");
    print(
        "Delete \(\"rm \*old\*\"\)or Save        old picks, and then restart\n\n"
    );
    exit;
}

=head2 Create Main Window 

 Sstart event-driven loop
 Interaction with user
 initialize values
 If picks are new, show
 message on how to pick data

=cut

if ( !$there_is_old_data ) {

    print("NEW PICKS\n");
    $iTM->message('first_top_mute');
    $iTM->number_of_tries($false);
    $iTM->gather_num($gather);

=head2 Display

     data first time

=cut	

    $iTM->iSelect_tr_Sumute_top();

=head2 Decide whether to 

     PICK or move on to NEXT CDP
     Place window near the upper left corner
     of the screen
  Changing geometry of the toplevel window
  my $h = $mw->screenheight();
  my $w = $mw->screenwidth();
  print("width and height of screen are $w,$h\n\n");
  print("geometry of screen is $geom\n\n");

=cut

    $mw = MainWindow->new;
    $mw->geometry("400x50+40+0");
    $mw->title("Interactive Top Mute");
    $mw->configure( -background => $var->{_my_purple} );

    $calc_rb = $mw->Radiobutton(
        -text       => 'CALC',
        -background => $var->{_my_yellow},
        -value      => 'calc',
        -variable   => \$rb_value,
        -command    => [ \&set_calc ]
    )->pack( -side => 'left' );

    $next_rb = $mw->Radiobutton(
        -text       => 'NEXT',
        -background => $var->{_my_yellow},
        -value      => 'next',
        -variable   => \$rb_value,
        -command    => [ \&set_next ]
    )->pack( -side => 'left' );

    $pick_rb = $mw->Radiobutton(
        -text       => 'PICK',
        -background => $var->{_my_yellow},
        -value      => 'pick',
        -variable   => \$rb_value,
        -command    => [ \&set_pick ]
    )->pack( -side => 'left' );
    $saveNcont_rb = $mw->Radiobutton(
        -text       => 'Save and Continue',
        -background => $var->{_my_yellow},
        -value      => 'saveNcont',
        -variable   => \$rb_value,
        -command    => [ \&set_saveNcont ]
    )->pack( -side => 'left' );

    $exit_rb = $mw->Radiobutton(
        -text       => 'EXIT',
        -background => $var->{_my_yellow},
        -value      => 'exit',
        -variable   => \$rb_value,
        -command    => [ \&set_exit ]
    )->pack( -side => 'left' );

    MainLoop;     # for Tk widgets
}   # for new data


=head2 Set the prompt

 value according
 to which button is pressed
 then exit the MainLoop
 destroy the main window after the prompt
 is properly set

=cut  

=head2 sub set_pick

 callbacks

  send gather number to $iTM
  delete output of previous semblance
  plus more callbacks following...


=cut

sub set_pick {
    my $pick = 'pick';
    $pick_rb->configure( -state => 'normal' );
    $iTM_Tk->{_prompt} = $pick;

    print("Picking...\n");

    $iTM->gather_num($gather);

=head2 Delete output 

  of previous muting

=cut

    $xk->kill_this('suximage');
    $xk->kill_this('suxwigb');

=head2 

    -replot 1st data 
    -PICK X-T pairs
    -Increment number of tries to make
       data display interact with user
       (number_of_tries = 1)

=cut

    $iTM->message('pre_pick_mute');
    $number_of_tries++;
    $iTM->number_of_tries($number_of_tries);
    $iTM->iSelect_tr_Sumute_top();

}

=head2 sub set_calc

      -PRESS the CALC button
      -Increment number of tries to make
          display and show old picks
         (if number_of_tries >1)

=cut

sub set_calc {
    my $calc = 'calc';
    $calc_rb->configure( -state => 'normal' );
    $iTM_Tk->{_prompt} = $calc;
    print("Calculating...\n");

=head2 Delete 

   the previous display

=cut

    $xk->kill_this('suximage');
    $xk->kill_this('suxwigb');

    $iTM->iPicks2par();
    $iTM->iSave_top_mute_picks();
    $iTM->iApply_top_mute();
    $number_of_tries++;
    $iTM->number_of_tries($number_of_tries);

=head2 Message 

       to halts flow
       when number_of_tries >0

=cut

    $iTM->message('post_pick_mute');
}


=head2 sub set_saveNcont

   same as next

=cut

sub set_saveNcont {
    my $saveNcont = 'saveNcont';
    $saveNcont_rb->configure( -state => 'normal' );
    $iTM_Tk->{_prompt} = $saveNcont;
    print("Saving and Continuing...\n");

    #$iTM->icp_sorted2oldpicks();
    &set_next();

}


=head2 sub set_next

  In this case $self is empty
  1. increment gather
     Exit if beyond last gather 
  2. reset prompt
  3. Otherwise display the first semblance
  4 ... see following callbacks

=cut

sub set_next {
    print("Next...\n");
    $next_rb->configure( -state => 'normal' );
    my $next = '';
    $iTM_Tk->{_prompt} = $next;
    $gather = $gather + $gather_inc;

    #print("new gather is $gather \n\n");

=head2  Delete output 

   of previous top mute

=cut

    $xk->kill_this('suximage');
    $xk->kill_this('suxwigb');
    $xk->kill_this('xgraph');

    if ( $gather > $last_gather ) {
        set_exit();
    }

=head2 Display

       update gather number in memory
       first top mute
       Show user message
       Select the mute values
=cut

    $iTM->gather_num($gather);
    $iTM->message('first_top_mute');
    $iTM->iSelect_tr_Sumute_top();

}

=head2  sub set_exit

  saying goodbye 
  clear old images
  kill window
  stop script

=cut

sub set_exit {
    my $exit = 'exit';
    $exit_rb->configure( -state => 'normal' );
    $iTM_Tk->{_prompt} = $exit;
    print("Good bye.\n");
    print("Not continuing to next gather\n");
    $xk->kill_this('suximage');
    $xk->kill_this('suxwigb');
    $xk->kill_this('xgraph');
    $mw->destroy() if Tk::Exists($mw);
    exit 1;
}

#			print ("Old top mute parameters MAY NOT exist\n\n") ;
#			while ($response eq 'n') {
#		  		print ("Select new top mute parameters \n\n") ;
#		  		iTM->iSelect_tr_Sumute_top2");
#				iTM->iTopMutepicks2par2");
#	               		iTM->itemp_Sumute_top2");
#		  		print ("4. Are picks OK y/n or q-quit?\n");
#		  		$response = <>;
##		  		chomp($response);
