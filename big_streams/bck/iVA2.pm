package iVA2;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: iVA2 
 AUTHOR: Juan Lorenzo
 DATE:   Nov 1 2012,
         sept. 13 2013
         oct. 21 2013
         July 15 2015
         Aug 18 2016

 DESCRIPTION: 
 Version: 1.1
 Package used for interactive velocity analysis
 Version 1.2 separates graphics from calculations

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

=cut

=head2

set defaults

VELAN DATA 
 m/s
 
=cut

=head2 import and then

 instantiate iclasses

=cut

use Moose;
use message;
use flow;
use suxwigb;
use iSuvelan;
use iWrite_All_iva_out;
use iVpicks2par;
use iVrms2Vint;
use manage_files_by2;
use SuMessages;
use iSunmo;
use SeismicUnix qw ($on $off $in $to $go);
use L_SU_global_constants;
use System_Variables;
use readfiles;
use xk;

=head2 establish hash of shared variables

=cut 

my $iVA2 = {
    _cdp_last             => '',
    _cdp_first            => '',
    _cdp_num              => '',
    _cdp_num_suffix       => '',
    _cdp_inc              => '',
    _data_scale           => '',
    _dt_s                 => '',
    _file_in              => '',
    _freq                 => '',
    _instructions         => '',
    _min_semblance        => '',
    _max_semblance        => '',
    _message_type         => 'iva',
    _next_step            => '',
    _number_of_tries      => '',
    _number_of_velocities => '',
    _old_data             => '',
    _tmax_s               => '',
    _Tvel_inbound         => '',
    _Tvel_outbound        => '',
    _textfile_in          => '',
    _textfile_out         => '',
    _type                 => '',
    _velocity_increment   => '',
    _velocity_min         => '',
    _velocity_max         => '',
};

=head2 Instantiate classes:

 Create a new version of the package 
 with a unique name

=cut

my $read               = new readfiles();
my $log                = new message();
my $run                = new flow();
my $suxwigb            = new suxwigb();
my $semblance          = new iSuvelan();
my $iWrite_All_iva_out = new iWrite_All_iva_out();
my $iVpicks2par        = new iVpicks2par();
my $iVrms2Vint         = new iVrms2Vint();
my $test               = new manage_files_by2();
my $SuMessages         = new SuMessages();
my $iSunmo             = new iSunmo();
my $get                = new L_SU_global_constants();
my $global_libs        = $get->global_libs();

=head2 Get configuration information

=cut

my $fileNpath = $global_libs->{_param} . "/iVA2_config.pl";
my ( $err, $CFG ) = $read->cfg($fileNpath);

$iVA2->{_file_in}              = $CFG->{iva}{1}{file_name};
$iVA2->{_cdp_first}            = $CFG->{iva}{1}{cdp_first};
$iVA2->{_cdp_inc}              = $CFG->{iva}{1}{cdp_inc};
$iVA2->{_cdp_last}             = $CFG->{iva}{1}{cdp_last};
$iVA2->{_tmax_s}               = $CFG->{iva}{1}{tmax_s};
$iVA2->{_data_scale}           = $CFG->{iva}{1}{data_scale};
$iVA2->{_dt_s}                 = $CFG->{iva}{1}{dt_s};
$iVA2->{_freq}                 = $CFG->{iva}{1}{freq};
$iVA2->{_first_velocity}       = $CFG->{iva}{1}{first_velocity};
$iVA2->{_min_semblance}        = $CFG->{iva}{1}{min_semblance};
$iVA2->{_max_semblance}        = $CFG->{iva}{1}{max_semblance};
$iVA2->{_number_of_velocities} = $CFG->{iva}{1}{number_of_velocities};
$iVA2->{_velocity_increment}   = $CFG->{iva}{1}{velocity_increment};

#print("file name is $file_name\n\n");

=head2 Check configuration file for errors

=cut

if ($err) {
    print( STDERR $err, "\n" );
    exit(1);
}

=head2 

 VELAN DATA 
 must be in units of: m/s
 must seed first cdp

 Set the type of messages you will receive
 for now it also sets the CDP number to use
 so keep it after setting cdp numbers

=cut

=head2

 Import directory definitions

=cut 

my ($PL_SEISMIC)      = System_Variables::PL_SEISMIC();
my ($DATA_SEISMIC_SU) = System_Variables::DATA_SEISMIC_SU();
my ($date)            = System_Variables::date();

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $iVA2->{_cdp_num}              = '';
    $iVA2->{_cdp_first}            = '';
    $iVA2->{_cdp_last}             = '';
    $iVA2->{_cdp_inc}              = '';
    $iVA2->{_data_scale}           = '';
    $iVA2->{_dt_s}                 = '';
    $iVA2->{_file_in}              = '';
    $iVA2->{_freq}                 = '';
    $iVA2->{_instructions}         = '';
    $iVA2->{_min_semblance}        = '';
    $iVA2->{_max_semblance}        = '';
    $iVA2->{_message_type}         = '';
    $iVA2->{_next_step}            = '';
    $iVA2->{_number_of_tries}      = '';
    $iVA2->{_number_of_velocities} = '';
    $iVA2->{_old_data}             = '';
    $iVA2->{_test}                 = '';
    $iVA2->{_tmax_s}               = '';
    $iVA2->{_Tvel_inbound}         = '';
    $iVA2->{_Tvel_outbound}        = '';
    $iVA2->{_velocity_min}         = '';
    $iVA2->{_velocity_max}         = '';
    $iVA2->{_velocity_increment}   = '';
}

=head2 subroutine  set_message

  define the message family to use
  alsoset the cdp nuber (TODO: move option elsewhere)

=cut

sub set_message {
    my ( $variable, $type ) = @_;
    $iVA2->{_message_type} = $type if defined($type);

    #print("message type is $iVA2->{_message_type}\n\n");
    $SuMessages->set( $iVA2->{_message_type} );
    $SuMessages->cdp_num( $iVA2->{_cdp_num} );

}

=head2 subroutine  message

  instructions 

=cut

sub message {
    my ($instructions) = @_;
    if ($instructions) {
        $iVA2->{_instructions} = $instructions if defined($instructions);
        $SuMessages->instructions( $iVA2->{_instructions} );

        #print("Instructions are $iVA2->{_instructions} \n\n");
    }
}

=head2 

 subroutine TV pick file out

=cut

sub refresh_Tvel_outbound {
    $iVA2->{_textfile_out} =
      'ivpicks_' . $iVA2->{_file_in} . $iVA2->{_cdp_num_suffix};
    $iVA2->{_Tvel_outbound} = $PL_SEISMIC . '/' . $iVA2->{_textfile_out};

    #print("output file is $iVA2->{_Tvel_outbound} \n\n");
}

=head2 

 subroutine TV pick file in 

=cut

sub refresh_Tvel_inbound {
    $iVA2->{_textfile_in} =
      'ivpicks_old' . '_' . $iVA2->{_file_in} . $iVA2->{_cdp_num_suffix};
    $iVA2->{_Tvel_inbound} = $PL_SEISMIC . '/' . $iVA2->{_textfile_in};
}

=head2 look for old data

  There is an old pick file to read
  textfile_in: ivpicks_old
  Requires knowing current cdp number
  becaus we are at the start of the process
  we will provide the lowest cdp as an indicator
  TODO: check all old cdp data files before going on
     to subsequent analyses

=cut

sub old_data {
    my ( $variable, $old_data ) = @_;
    my $ans;

    #print("variable and old_data $variable, $old_data\n\n");
    #switches old data of velan type
    if ($old_data) {
        $iVA2->{_type} = $old_data;
        if ( $iVA2->{_type} eq 'velan' ) {

            cdp_num( $iVA2->{_cdp_first} );
            cdp_num_suffix( $iVA2->{_cdp_num} );

            $iVA2->{_textfile_in} =
                'ivpicks_old' . '_'
              . $iVA2->{_file_in}
              . $iVA2->{_cdp_num_suffix};

            if ($PL_SEISMIC) {
                $iVA2->{_Tvel_inbound} =
                  $PL_SEISMIC . '/' . $iVA2->{_textfile_in};
                $ans = $test->does_file_exist( \$iVA2->{_Tvel_inbound} );

                if ( $iVA2->{_file_in} && $iVA2->{_cdp_num_suffix} ) {
                    $iVA2->{_textfile_out} =
                      'ivpicks_' . $iVA2->{_file_in} . $iVA2->{_cdp_num_suffix};
                    $iVA2->{_Tvel_outbound} =
                      $PL_SEISMIC . '/' . $iVA2->{_textfile_out};
                }
            }

            #print("TV in is $iVA2->{_Tvel_inbound}\n\n");
            #print("TV out is $iVA2->{_Tvel_outbound}\n\n");

            if ($ans) {
                print("Old picks already exist.\n");
                print(
"Delete \(\"rm \*old\*\"\)or Save old picks, and then restart\n\n"
                );
                exit;
            }
            return ($ans);
        }

    }
}

=head2 subroutine cdp

  sets cdp number to consider and is used only 
  by sub start 

=cut

sub cdp_num {
    my ($cdp_num) = @_;
    $iVA2->{_cdp_num} = $cdp_num if defined($cdp_num);

    #print("cdp_num is $cdp_num\n\n");
}

=head2 subroutine cdp_num_suffix

  sets cdp number suffix to consider 
  used by subs start and next

=cut

sub cdp_num_suffix {
    my ($cdp_num) = @_;
    if ($cdp_num) {
        $iVA2->{_cdp_num_suffix} = '_cdp' . $cdp_num;

        #print("cdp_num suffix in iVA2.pm is $iVA2->{_cdp_num_suffix}\n\n");
    }
}

#=head2 subroutine cdp_first
#
#  sets min cdp number to consider
#
#=cut
#
#sub cdp_first {
#   my($variable,$cdp_first)  	= @_;
#   $iVA2->{_cdp_first} 		= $cdp_first if defined ($cdp_first);
#}

=head2 subroutine start 

  sets first cdp  to use internally
    and display in the messages 
  sets the type of messages to relay
  sets the counter for attempts at velocity
  analysis for a particular cdp

=cut

sub start {

    print("NEW PICKS\n");
    set_message( $iVA2->{_message_type} );
    $SuMessages->cdp_num( $iVA2->{_cdp_first} );
    cdp_num( $iVA2->{_cdp_first} );
    cdp_num_suffix( $iVA2->{_cdp_first} );

    #print("cdp_num_suffix is $iVA2->{_cdp_num_suffix}\n\n");
    message('first_velan');
    $iVA2->{_number_of_tries} = 0;
    semblance();

}

=head2 subroutine pick
 
  Picking data
  send cdp number to subroutine 
  update cdp_num_suffix
  and update the Tvel_outbound.
  #delete output of previous semblance
  

    -replot 1st semblance
    -PICK V-T pairs
    -Increment number of tries to make
       semblance display interacts
       when number_of_tries >= 1)
        also blocks flow so
        place message before semblance
=cut

sub pick {

    print("Picking...cdp $iVA2->{_cdp_num}\n");
    print("NOW, PICK\n\n");
    cdp_num_suffix( $iVA2->{_cdp_num} );
    refresh_Tvel_inbound();
    refresh_Tvel_outbound();

    #xk::kill_this('suximage');
    #xk::kill_this('suxwigb');
    message('pre_pick_velan');
    $iVA2->{_number_of_tries}++;
    semblance();

}

=head2 sub next

  1. increment cdp
     update variable variables
        (cdp_num_suffix, Tvel_inbound and Tvel_outbound)
     Exit if beyond last cdp 
  2. reset prompt
     reset the number of tries to zero again
  3. Otherwise display the first semblance
    -Based on semblance,
      decide whether to PICK or move on to NEXT CDP
     -radio_buttons stop flow

   delete output of previous semblance
   delete the output of semblance and iSunmo
   delete the output of Vrms2Vint 

=cut

sub next {

    $iVA2->{_cdp_num} = $iVA2->{_cdp_num} + $iVA2->{_cdp_inc};
    cdp_num_suffix( $iVA2->{_cdp_num} );
    refresh_Tvel_inbound();
    refresh_Tvel_outbound();
    $iVA2->{_number_of_tries} = 0;

    #print("Next CDP_NUM IS $iVA2->{_cdp_num}");

    #xk::kill_this('suximage');
    #xk::kill_this('suxwigb');
    #xk::kill_this('xgraph');
    if ( $iVA2->{_cdp_num} > $iVA2->{_cdp_last} ) {
        exit();
    }

    semblance();
    $SuMessages->cdp_num( $iVA2->{_cdp_num} );
    message('first_velan');

}

=head2 subroutine exit

=cut

sub exit {

    print("Good bye.\n");
    print("Not continuing to next cdp\n");
    xk::kill_this('suximage');
    xk::kill_this('suxwigb');
    xk::kill_this('xgraph');
    exit(1);

}

=head2 Calculate NMO 

    0. Message to user
    1. delete the output of previous semblance 
    2. calculations
    3. message is needed because semblance halts flow
       when number_of_tries >0

=cut

sub calc {

    #print("Calculating...\n");

    #xk::kill_this('suximage');
    #xk::kill_this('suxwigb');
    iWrite_All_iva_out();
    iVrms2Vint();
    icp_sorted2oldpicks();
    iVpicks2par();
    iSunmo();
    $iVA2->{_number_of_tries}++;
    message('post_pick_velan');
    semblance();

}

=head2

 subroutine icp_sorted_2_old_picks
 When user wants to recheck the data  velocity_increment
 this subroutine will allow the user to recheck  using an old sorted file
 Juan M. Lorenzo
 Jan 10 2010

    input file is ivpicks_sorted
    output pick file 
    text file out: ivpicks_old 


=cut 

sub icp_sorted2oldpicks {

    my ( @cdp_num,     @sorted_suffix, @suffix );
    my ( @sufile_in,   @vpicks_in,     @vpicks_out );
    my ( @sortfile_in, @inbound,       @outbound );
    my (@writefile_out);
    my (@flow);

    $cdp_num[1] = $iVA2->{_cdp_num};

    # suffixes
    $sorted_suffix[1] = '_sorted';
    $suffix[3]        = '_cdp' . $iVA2->{_cdp_num};

    # su file names
    $sufile_in[1] = $iVA2->{_file_in};

    #V file names
    $vpicks_in[1]  = 'ivpicks_old' . $sorted_suffix[1];
    $vpicks_out[1] = 'ivpicks_old';

    # sort file names
    $sortfile_in[1] = $vpicks_in[1];
    $inbound[1] =
      $PL_SEISMIC . '/' . $sortfile_in[1] . '_' . $sufile_in[1] . $suffix[3];

    # Velocity write file names
    $writefile_out[1] = $vpicks_out[1];
    $outbound[1] =
      $PL_SEISMIC . '/' . $writefile_out[1] . '_' . $sufile_in[1] . $suffix[3];

    #  DEFINE FLOW(S)
    $flow[1] = (
        " 						\\
		cp 	 				\\
		 $inbound[1] 					\\
		 $outbound[1]					\\
		"
    );

    # RUN FLOW(S)
    system $flow[1];

    #system 'echo', $flow[1];
    #end of copy of Vrms old picks sorted to ivpicks_old
}

=head2 sub iVrms2Vint

 Purpose: Convert Vrms to Vinterval  
 Juan M. Lorenzo
 April 7 2009 
 Nov. 19 2013

=cut

sub iVrms2Vint {

    $iVrms2Vint->first_velocity( $iVA2->{_first_velocity} );
    $iVrms2Vint->number_of_velocities( $iVA2->{_number_of_velocities} );
    $iVrms2Vint->velocity_increment( $iVA2->{_velocity_increment} );
    $iVrms2Vint->file_in( $iVA2->{_file_in} );
    $iVrms2Vint->cdp_num( $iVA2->{_cdp_num} );
    $iVrms2Vint->tmax_s( $iVA2->{_tmax_s} );
    $iVrms2Vint->calcNdisplay();

}

=head2 sub iVpicsk2par_Vpicks

 Purpose: Prepare velocity picks for
 input to Sunmo 
 Interactive mode
 Juan M. Lorenzo
 April 7 2009
 Adapted from Forel and Pennington's iva.sh script
 Nov 19 2013

=cut

sub iVpicks2par {

    $iVpicks2par->file_in( $iVA2->{_file_in} );
    $iVpicks2par->cdp_num( $iVA2->{_cdp_num} );
    $iVpicks2par->flows();

}

sub iSunmo {

    $iSunmo->file_in( $iVA2->{_file_in} );
    $iSunmo->cdp_num( $iVA2->{_cdp_num} );
    $iSunmo->freq( $iVA2->{_freq} );
    $iSunmo->tmax_s( $iVA2->{_tmax_s} );
    $iSunmo->calcNdisplay();

}

=head2 sub semblance

 Purpose: Generate Velocity Analysis 
          and Plot the results 

=cut

sub semblance {

    #print(" running semblance\n\n");
    #print(" number of tries is $iVA2->{_number_of_tries}\n\n");

    $semblance->clear();
    $semblance->cdp_num( $iVA2->{_cdp_num} );
    $semblance->cdp_num_suffix( $iVA2->{_cdp_num} );
    $semblance->file_in( $iVA2->{_file_in} );
    $semblance->data_scale( $iVA2->{_data_scale} );
    $semblance->dt_s( $iVA2->{_dt_s} );
    $semblance->tmax_s( $iVA2->{_tmax_s} );
    $semblance->first_velocity( $iVA2->{_first_velocity} );
    $semblance->freq( $iVA2->{_freq} );
    $semblance->max_semblance( $iVA2->{_max_semblance} );
    $semblance->min_semblance( $iVA2->{_min_semblance} );
    $semblance->number_of_tries( $iVA2->{_number_of_tries} );
    $semblance->number_of_velocities( $iVA2->{_number_of_velocities} );
    $semblance->velocity_increment( $iVA2->{_velocity_increment} );
    $semblance->Tvel_inbound( $iVA2->{_Tvel_inbound} );
    $semblance->Tvel_outbound( $iVA2->{_Tvel_outbound} );
    $semblance->calcNdisplay();
}

=head2

 subroutine Write_All_iva_out.pl
 Purpose: Write out best vpicked files from iVA2 
 needs sufile name and cdp number

=cut

sub iWrite_All_iva_out {

    $iWrite_All_iva_out->file_in( $iVA2->{_file_in} );
    $iWrite_All_iva_out->cdp_num( $iVA2->{_cdp_num} );
    $iWrite_All_iva_out->flows();

}

1;
