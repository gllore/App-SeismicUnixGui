package L_SU;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: L_SU.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 14 2018 

 DESCRIPTION 
     
 BASED ON:
 previous versions of the main L_SU.pl
  
=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 V 0.1.0 refactoring of 2017 version of L_SU.pl
 
 V 0.1.1 May 16 2018
  moving FileDialog_button, FileDialog, FileDialog_close
  to file_dialog.pm
  
  making save_button redundant
  refactor superflow selection
  
  V0.1.2 refactoring superflows and user-built flows
  
  V0.1.3 introduce multi-color flows ( 4 off)
  
  V0.1.5 includes gui_history 9-13-19
  
  V0.1.6 move methods into color_listbox class 2.10.2021
  
  V0.1.7 May 2021
  permit my_dialogs to interact with user and change flow
 
=cut 

use Moose;
our $VERSION = '0.1.7';

extends 'gui_history' => { -version => 0.0.2 };

# potentially, in all packages
use L_SU_global_constants;
use color_listbox;
use flow_widgets;
use file_dialog;
use save_button;
use run_button;
use pre_built_big_stream;

use grey_flow 0.0.3;
use blue_flow 0.0.3;
use pink_flow 0.0.3;
use green_flow 0.0.3;
use neutral_flow 0.0.3;

my $color_listbox = color_listbox->new();
my $gui_history   = gui_history->new();
my $file_dialog   = file_dialog->new();
my $flow_widgets  = flow_widgets->new();
my $get           = L_SU_global_constants->new();

my $pre_built_big_stream = pre_built_big_stream->new();
my $L_SU_href            = $gui_history->get_defaults();

my $flow_type    = $get->flow_type_href();
my $save_button  = save_button->new();
my $run_button   = run_button->new();
my $grey_flow    = grey_flow->new();
my $pink_flow    = pink_flow->new();
my $green_flow   = green_flow->new();
my $blue_flow    = blue_flow->new();
my $neutral_flow = neutral_flow->new();

=head2
share the following parameters in same name 
space

flow_listbox_grey_w  -left listbox, input by user selection
flow_listbox_green_w  -right listbox,input by user selection
sunix_listbox   -choice of listed sunix modules in a listbox
 
36 off

=cut

my ($mw);
my ($parameter_values_button_frame);
my ( $parameter_names_frame, $parameter_values_frame );
my ( $flow_listbox_grey_w,   $flow_listbox_pink_w, $flow_listbox_green_w, $flow_listbox_blue_w );
my ( $flow_name_grey_w,      $flow_name_pink_w,    $flow_name_green_w,    $flow_name_blue_w );
my ($flowNsuperflow_name_w);
my $gui_history_aref;

my $is_pre_built_superflow;
my $is_user_built_flow;

my ( $run_button_w, $save_button_w, $message_w );
my ($sunix_listbox);
my ( $add2flow_button_grey, $add2flow_button_pink, $add2flow_button_green, $add2flow_button_blue );
my ($check_code_button);
my ($file_menubutton);
my ( $flow_item_down_arrow_button, $flow_item_up_arrow_button );
my $wipe_plots_button;
my $Data_menubutton;
my $Flow_menubutton;
my $SaveAs_menubutton;

my $var                     = $get->var();
my $on                      = $var->{_on};
my $true                    = $var->{_true};
my $false                   = $var->{_false};
my $yes                     = $var->{_yes};
my $no                      = $var->{_no};
my $superflow_names         = $get->superflow_names_h();
my $alias_superflow_names_h = $get->alias_superflow_names_h();

=head2 defaults

=cut

 my $my_dialogs_ans4ok_default = $yes;
 my $my_dialogs_ans4cancel_default = $no;

=head2 declare private variables

=cut

=head2 private hash
to manage listbox occupation

=cut

my $L_SU_gui = {

	_occupied_listbox_aref => $color_listbox->get_flow_listbox_occupancy_aref(),
	_vacant_listbox_aref => $color_listbox->get_flow_listbox_vacancy_aref(),	
	_my_dialogs_ans4cancel => $my_dialogs_ans4cancel_default, 
	_my_dialogs_ans4ok     =>  $my_dialogs_ans4ok_default,

};

# print("1. init L_SU_gui->{_occupied_listbox} = @{$L_SU_gui->{_occupied_listbox_aref }}\n");
# print("1. init L_SU_gui->{_vacant_listbox} = @{$L_SU_gui->{_vacant_listbox_aref }}\n");

=head2

	Opening a file of folder for a superflow
	Only superflow bindings use this private ('_') subroutine.
	Superflows that are opening Data files from GUI are directed here
	
	FileDialog_button is mainly used for user-built flows but 
	also directs superflows
	to _FileDialog_button
	
	For safety, place set_hash_ref first
	$$dialog_type_sref can be Data, Save or SaveAs

=cut 

sub _FileDialog_button {
	my ( $self, $dialog_type_sref ) = @_;

	#print("42 L_SU,_FileDialog_button= $self, $$dialog_type_sref\n")

	if ($dialog_type_sref) {

		$L_SU_href->{_dialog_type} = $$dialog_type_sref;
		$file_dialog->set_hash_ref($L_SU_href);
		$file_dialog->FileDialog_director();
		$L_SU_href = $file_dialog->get_hash_ref();

		#		print(" 43 L_SU,_FileDialog_button, dialog type: $L_SU_href->{_dialog_type}\n");
		# print(" L_SU,_FileDialog_button, values_aref: @{$L_SU_href->{_values_aref}}\n");

	} else {
		print("L_SU, for superflows only, _FileDialog_button (binding),option type missing ");
	}
	return ();
}

=head2 sub _get_flow_color

=cut 

sub _get_flow_color {
	my ($self) = @_;
	my $color;
	if ( $L_SU_href->{_flow_color} ) {

		# print("L_SU, _get_flow_color, color:$L_SU_href->{_flow_color} \n");
		$color = $L_SU_href->{_flow_color};
		return ($color);

	} else {
		$color = '';

		# print("L_SU, _get_flow_color, missing color\n");
		return ($color);
	}
}

=head2 sub _set_flow_color

set the flow color even if it is blank (=no color))

=cut 

sub _set_flow_color {
	my ($color) = @_;

	if ( $color or $color eq '' ) {
		$L_SU_href->{_flow_color} = $color;

	} else {
		print("L_SU,_set_flow_color, missing color \n");
	}
	return ();
}

=head2 sub _set_flow_listbox_color_w


=cut 

sub _set_flow_listbox_color_w {
	my ($color) = @_;

	if ( $color eq 'grey' ) {

		$L_SU_href->{_is_flow_listbox_grey_w} = $true;

		# print("1. L_SU,_set_flow_listbox, color:$color \n");

	} elsif ( $color eq 'pink' ) {

		$L_SU_href->{_is_flow_listbox_pink_w} = $true;

		# print("L_SU,_set_flow_listbox, color:$color\n");

	} elsif ( $color eq 'green' ) {

		# print("L_SU,_set_flow_listbox, color:$color\n");
		$L_SU_href->{_is_flow_listbox_green_w} = $true;

	} elsif ( $color eq 'blue' ) {

		# print("L_SU,_set_flow_listbox, color:$color\n");
		$L_SU_href->{_is_flow_listbox_blue_w} = $true;

	} else {
		print("L_SU,_set_flow_listbox, missing color \n");
	}
	return ();
}

=head2 sub _unset_pre_built_userflow_type 

=cut

sub _unset_pre_built_superflow_type {

	my ($self) = @_;

	$L_SU_href->{_is_pre_built_superflow} = $false;

	return ();
}

=head2 sub _set_user_built_flow_type 

=cut

sub _set_user_built_flow_type {

	my ($self) = @_;

	$L_SU_href->{_flow_type}          = $flow_type->{_user_built};
	$L_SU_href->{_is_user_built_flow} = $true;

	return ();
}

=head2 sub FileDialog_button
	For user-built flows.
	Interactively choose a file name
    that will then be entered into the
    values of the parameter frame and 
	stored away via param_flow	
	for colored flows: grey, pink, blue, green

	Set conditions for the use of a FileDialog_button
    i.e., find out which prior widget invoked the FileDialog_button
    e.g., was it a user_built flow or a superflow?

	print("L_SU,FileDialog_button	parameter_values_frame: $L_SU_href->{_parameter_values_frame}\n");
 	print("L_SU,FileDialog_button	parameter_values_frame: $parameter_values_frame\n");
 	
 	dialog_type is one of 3 topics:  'Data', (open a) 
 	Flow (open a user-built perl flow) or 'SaveAs'  a user-built perl flow)
 	
 	the Save (main) option goes straight to the L_SU,save_button for both 'user_built' and 'pre_built_superflow'

 	flow_type can be 'user_built' or 'pre_built_superflow'
	for safety, place set_hash_ref first
	
	each colored flow will be directed to a different program

	 	foreach my $key (sort keys %$L_SU_href) {
      	print (" L_SU,FileDialog_button, key is $key, value is $L_SU_href->{$key}\n");
 	}
 	
 	The number of values and names = what is read from the configuration file
 	After FileDialog is run, the number of values and names = max default value, 
 	because param_widgets are chosen inside file_dialog
 	This is justified because I chose to determine independently # variables
 	from the param_widget which is defaulted to 61 
 	(so that we know in advance how many value are occupied without reading SeismicUnixPltTk_global_cosntants.pm

=cut

sub FileDialog_button {

	my ( $self, $dialog_type_sref ) = @_;

	my $color;

	if ( defined $dialog_type_sref ) {

		# print("L_SU,FileDialog_button, CASE 1 print gui_history.txt\n");
		# $gui_history->view();

		# CASE 1 in prep for CASE 4
		# after just working with a pre-built superflow
		# but before opening a user-built flow

		if (   $$dialog_type_sref eq 'Flow'
			&& $L_SU_href->{_flow_type} eq 'pre_built_superflow'
			&& !( $L_SU_href->{_is_flow_listbox_grey_w} )
			&& !( $L_SU_href->{_is_flow_listbox_pink_w} )
			&& !( $L_SU_href->{_is_flow_listbox_green_w} )
			&& !( $L_SU_href->{_is_flow_listbox_blue_w} ) ) {

			# print("CASE 1 L_SU,FileDialog_button, _flow_type: $L_SU_href->{_flow_type}\n");
#			print("CASE 1 L_SU, FileDialog_button, color is $color\n");

			# TODO default, selected flow box color is 'grey' for now:
			my $which_color = 'grey';
			_set_flow_color($which_color);
			_set_flow_listbox_color_w($which_color);
			_unset_pre_built_superflow_type();
			_set_user_built_flow_type();
			$color = $which_color;

		} elsif ( $$dialog_type_sref eq 'Flow' ) {

			# CASE 2 in prep for CASE 4
			# After selecting a sunix program and before
			# flow selection:
			# select the color of the flow to fill automatically
			# either picked by user immediately before or, if not,
			# pick grey as the default.
			# But, if grey is occupied, send a warning message to the user
			# to say that the current grey will be overwritten
			# and that the prior flow will  not be saved automatically

			my $future_color = $color_listbox->get_future_flow_listbox_color();
			$color_listbox->set_future_flow_listbox_color($future_color);
			my $vacancy = $color_listbox->is_vacant_listbox($future_color);

			# Color was either selected previously or is not yet occupied
			if ( $vacancy eq $true ) {

				_set_flow_color($future_color);
				_set_flow_listbox_color_w($future_color);
				_unset_pre_built_superflow_type();
				_set_user_built_flow_type();
				$color = $future_color;

#				print("CASE 2 1.L_SU,FileDialog_button, $future_color will be occupied\n");

			} elsif ( $vacancy eq $false ) {

				my $which_color = $color_listbox->get_flow_listbox_vacancy_color();

				#	print("CASE 2 1.L_SU,FileDialog_button, $which_color will be occupied\n");
				$color_listbox->set_flow_listbox_color2check($which_color);
				my $ans = $color_listbox->is_flow_listbox_color2check();

				#	print("CASE 2 2.L_SU,FileDialog_button, ans=$ans\n");

				if ( $ans == $true ) {

					#	CASE of a colored box unoccupied
					#	print("CASE 2A L_SU,FileDialog_button, ans=$ans\n");
					_set_flow_color($which_color);
					_set_flow_listbox_color_w($which_color);
					_unset_pre_built_superflow_type();
					_set_user_built_flow_type();
					$color = $which_color;

				} elsif ( $ans == $false ) {

					#	CASE 2B of a colored box ALREADY occupied
					$color_listbox->my_dialogs( 'color_listbox', 0 );
					$L_SU_gui->{_my_dialogs_ans4cancel} = $color_listbox->get_my_dialog_cancel_click();
					$L_SU_gui->{_my_dialogs_ans4ok}     = $color_listbox->get_my_dialog_ok_click();

					# print("L_SU, FileDialog,CASE 2B L_SU_gui->{_my_dialogs_ans4cancel}= $L_SU_gui->{_my_dialogs_ans4cancel}\n");
					# print("L_SU, FileDialog,CASE 2B L_SU_gui->{_my_dialogs_ans4ok}=$L_SU_gui->{_my_dialogs_ans4ok}\n");

					# reset clicks after using my_dialogs
					$color_listbox->set_my_dialog_ok_click($no);
					$color_listbox->set_my_dialog_cancel_click($no);
					$color_listbox->set_my_dialog_box_click($no);

					if (   length $L_SU_gui->{_my_dialogs_ans4cancel}
						&& length $L_SU_gui->{_my_dialogs_ans4ok} ) {

						if ( $L_SU_gui->{_my_dialogs_ans4ok} eq $yes ) {

							# CASE 2B.1; same as CASE 2A
							# overwrite visible flow
							# print("L_SU, FileDialog,CASE 2B.1\n");
							_set_flow_color($which_color);
							_set_flow_listbox_color_w($which_color);
							_unset_pre_built_superflow_type();
							_set_user_built_flow_type();
							$color = $which_color;

						} elsif ( $L_SU_gui->{_my_dialogs_ans4cancel} eq $yes ) {

							# CASE 2B.2
							# NADA, user has another go
							# print("L_SU, FileDialog,CASE 2B.2\n");

						} else {
							print("L_SU, FileDialog,unexpected answer\n");
						}
					}    # answers exists

				} else {
					print("L_SU,FileDialog_button, unexpected answer\n");
				}

			} else {
				# print("CASE 0 L_SU, FileDialog_button, color to occupy (if vacant already) = $color \n");
			}

		} else {
			# print("5 L_SU, FileDialog_button, unknown dialog type (e.g., Data, Save (a Flow),  SaveAs) \n");
		}

		if ( not $color ) {

			$color = _get_flow_color();

		} else {
					# print("L_SU, FileDialog_button, Good, color already chosen: $color \n");
		}

		if (  ($L_SU_gui->{_my_dialogs_ans4cancel} eq $no)
		    && ($L_SU_gui->{_my_dialogs_ans4ok} eq $yes)
		    && $color
			&& (   $L_SU_href->{_is_flow_listbox_grey_w}
				|| $L_SU_href->{_is_flow_listbox_pink_w}
				|| $L_SU_href->{_is_flow_listbox_green_w}
				|| $L_SU_href->{_is_flow_listbox_blue_w}
				|| ( $L_SU_href->{_flow_type} eq 'user_built' && $color ) )
		) {

			# CASES 3A-3D
			# For user-built flows in grey, pink, green or blue
			# = 'neutral', when flow listbox is not a color as sunix_select is selected
			# but add2flow_button has not been activated
			# = nothing if chosen before a colored flow exists
			# when coming from a user-built flow
			# = neutral when superflow Data is chosen
			print("CASES 3A-3D L_SU, FileDialog_button, color is $color\n");

			# update any newly added listboxes for all cases 3A-3D
			#	print("CASES 3A-D L_SU,FileDialog_button, L_SU_gui->{_occupied_listbox_aref},@{$L_SU_gui->{_occupied_listbox_aref}}\n");
			#	print("CASES 3A-D L_SU,FileDialog_button, L_SU_gui->{_vacant_listbox_aref},@{$L_SU_gui->{_vacant_listbox_aref}}\n");

			$color_listbox->set_flow_listbox_color( _get_flow_color() );
			$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
            $L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();
		
			if (   $L_SU_href->{_is_flow_listbox_grey_w}
				&& $color eq 'grey' ) {    # for added certainty
										   # CASE 3A
										   # mark the neutral-colored flow as unused
										   # helps bind flow parameters to the opening files

				print("CASE 3A L_SU, FileDialog_button, color is $color\n");
				$color_listbox->set_future_flow_listbox_color($color);
				my $which_color = $color_listbox->get_future_flow_listbox_color();

				print("CASE 3A 1.L_SU,FileDialog_button, $which_color will be occupied\n");

				$grey_flow->set_hash_ref($L_SU_href);

				#				print("case 3A L_SU,FileDialog_button, L_SU_gui->{_occupied_listbox_aref},@{$L_SU_gui->{_occupied_listbox_aref}}\n");
			   #				print("case 3A L_SU,FileDialog_button, L_SU_gui->{_vacant_listbox_aref},@{$L_SU_gui->{_vacant_listbox_aref}}\n");

				$grey_flow->FileDialog_button($dialog_type_sref);
				$L_SU_href->{_flow_color} = $grey_flow->get_flow_color();

			} elsif ( $L_SU_href->{_is_flow_listbox_pink_w} && $color eq 'pink' ) {    # for added certainty

				# CASE 3B - pink flow box
				$pink_flow->set_hash_ref($L_SU_href);
				$pink_flow->FileDialog_button($dialog_type_sref);
				$L_SU_href->{_flow_color} = $pink_flow->get_flow_color();

				#				print("case 3b L_SU,FileDialog_button, L_SU_gui->{_occupied_listbox_aref},@{$L_SU_gui->{_occupied_listbox_aref}}\n");
				#				print("case 3b L_SU,FileDialog_button, L_SU_gui->{_vacant_listbox_aref},@{$L_SU_gui->{_vacant_listbox_aref}}\n");

				print("CASE 3B, L_SU, FileDialog_button, color is $color\n");
				$color_listbox->set_future_flow_listbox_color($color);
				my $which_color = $color_listbox->get_future_flow_listbox_color();

				# print("CASE 3B 1.L_SU,FileDialog_button, $which_color will be occupied\n");

			} elsif ( $L_SU_href->{_is_flow_listbox_green_w}
				&& $color eq 'green' ) {    # more certainty

				# CASE 3C

				$color_listbox->set_future_flow_listbox_color($color);
				my $which_color = $color_listbox->get_future_flow_listbox_color();

				print("CASE 3C 1.L_SU,FileDialog_button, $which_color will be occupied\n");

				# print("CASE 3C, L_SU,FileDialog_button,_flow_name_green_w:	$L_SU_href->{_flow_name_green_w} \n");
				$green_flow->set_hash_ref($L_SU_href);
				$green_flow->FileDialog_button($dialog_type_sref);
				$L_SU_href->{_flow_color} = $green_flow->get_flow_color();

				# CASE 3D
			} elsif ( $L_SU_href->{_is_flow_listbox_blue_w} && $color eq 'blue' ) {    # more certainty

				$color_listbox->set_future_flow_listbox_color($color);
				my $which_color = $color_listbox->get_future_flow_listbox_color();

				# print("CASE 3D 1.L_SU,FileDialog_button, $which_color will be occupied\n");
				print("CASE 3D, L_SU, FileDialog_button, color is $color\n");

				$blue_flow->set_hash_ref($L_SU_href);
				$blue_flow->FileDialog_button($dialog_type_sref);
				$L_SU_href->{_flow_color} = $blue_flow->get_flow_color();

			} else {
				print("L_SU, FileDialog_button, missing settings \n");
			}
		}

		# CASE 4
		# when GUI opens Data for a superflow
		elsif ( $L_SU_href->{_flow_type} eq 'pre_built_superflow' ) {

#			print("CASE 4, L_SU,FileDialog_button,dialog type=  $$dialog_type_sref");
			$L_SU_href->{_dialog_type} = $$dialog_type_sref;
			$file_dialog->set_hash_ref($L_SU_href);
			$file_dialog->FileDialog_director();
			$L_SU_href = $file_dialog->get_hash_ref();

		} elsif (
    		($L_SU_gui->{_my_dialogs_ans4cancel} eq $yes)
		    && ($L_SU_gui->{_my_dialogs_ans4ok} eq $no) )  {
		    
		   # print("CASE 5, where user skips opening a perl file and overwriting an existant flow\n");
		   # NADA

		} elsif ( not $color
			&& ( $L_SU_href->{_flow_type} eq 'user_built_flow' ) 
			&& ($L_SU_gui->{_my_dialogs_ans4cancel} eq $my_dialogs_ans4cancel_default)
		    && ($L_SU_gui->{_my_dialogs_ans4ok} eq $my_dialogs_ans4ok_default)) {
			print("L_SU,FileDialog_button, Case 6\n");

			# CASE 6
			# Flow when program opens a (pre-existing) user-built perl flow
			# and user flows are already in progress
			# but no color or colored listbox is active,

			$color_listbox->set_flow_listbox_color( _get_flow_color() );
			$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
			$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();			
			my $which_color = $color_listbox->get_flow_listbox_vacancy_color();

			_set_flow_color($which_color);
			_set_flow_listbox_color_w($which_color);
			_unset_pre_built_superflow_type();

			_set_user_built_flow_type();

			$grey_flow->set_hash_ref($L_SU_href);
			$grey_flow->FileDialog_button($dialog_type_sref);
			$L_SU_href->{_flow_color} = $grey_flow->get_flow_color();
			
		} else {
			print("6. L_SU, FileDialog_button, not a color: $color \n");
			print("6. L_SU, FileDialog_button, missing color, and flow types \n");
		}    # end user-built  flow (2 types) or superflow (or user) 1 type)
		
	} else {
		print("8 L_SU, FileDialog_button, missing dialog type (Data, Save, Flow , SaveAs)\n");
	}    # end dialog_type_sref

	return ();
}

=head2 sub help

 Callback sequence following MB3 click 
 activation of a sunix (Listbox) item.
 Program name is a scalar reference
 
 Allow this subroutine help decide whether it is a superflow
 or a user-created flow
 
 Show a window with the perldoc to the user
 

=cut 

sub help {
	my ($self) = @_;
	use help;
	use decisions;

	my $help      = new help();
	my $decisions = decisions->new();
	my $pre_req_ok;

	# print("L_SU, help\n");

	$L_SU_href->{_is_pre_built_superflow} = $true;    #helps decisions

	$decisions->set4help($L_SU_href);
	$pre_req_ok = $decisions->get4help();

	if ($pre_req_ok) {
		my $prog_name = ${ $L_SU_href->{_prog_name_sref} };
		my $alias     = $alias_superflow_names_h->{$prog_name};

		# print("L_SU,help,alias: $alias\n");
		$help->set_name( \$alias );
		$help->tkpod();

	} else {

		# print("L_SU, can not provide help\n");
	}

	return ();
}

=head2 sub initialize my dialogs

Create widgets that show messages
Show warnings or errors in a message box
Message box is defined in main where it is
also made invisible (withdraw)
Here we turn on the message box (deiconify, raise)
The message does not release the program
until OK or cancels clicked and wait variable changes 
from no/yes to yes/no.

=cut

sub initialize_my_dialogs {
	my ( $self, $ok_button, $label, $cancel_button, $top_level ) = @_;

	if (   length $ok_button
		&& length $label
		&& $cancel_button
		&& $top_level ) {

		#	$color_listbox->set_hash_ref($L_SU_href);
		$color_listbox->initialize_my_dialogs( $ok_button, $label, $cancel_button, $top_level );

	} else {
		print("L_SU,initialize_my_dialogs, missing widgets\n");
	}
	return ();
}

=head2 sub initialize messages

Create widgets that show messages
Show warnings or errors in a message box
Message box is defined in main where it is
also made invisible (withdraw)
Here we turn on the message box (deiconify, raise)
The message does not release the program
until OK is clicked and wait variable changes from yes 
to no.

=cut

sub initialize_messages {
	my ($self) = @_;

	$color_listbox->set_hash_ref($L_SU_href);
	$color_listbox->initialize_messages();

	return ();
}

=head2 sub pre_built_superflows
 
 
    scalar reference:
      print("LSU_Tk,superflow_select,prog_name: ${$L_SU_href->{_prog_name_sref}}\n");
    array reference:
      print("LSU_Tk,superflow_select: _names_aref @{$L_SU_href->{_names_aref}}\n");
      
      sets flow type = pre-built superflow
      
       		 		# print complete hash
 		while (my ( $key,$value ) = each %{$L_SU_href} ){
 			print ("$key \t\t=> $value\n");
 		}

 		 
 		 binding needs:
 		  	$pre_built_big_stream	->select(); 
			$pre_built_big_stream	->set_sub_ref
			
		$pre_built_big_stream	->set_flowNsuperflow_name_w  displays superflow name at top of gui 
			
	);
	
	  print("11. L_SU,pre_built_superflows,: $$superflow_name_sref \n");	
  	 print("11. L_SU,pre_built_superflows,flowNsuperflow_name_w: $flowNsuperflow_name_w\n");
  	
  	 				foreach my $key (sort keys %$L_SU_href) {
 					print (" file_dialog,key is $key, value is $L_SU_href->{$key}\n");
    			

=cut

sub pre_built_superflows {
	my ( $self, $superflow_name_sref ) = @_;

	# print("2. L_SU,pre_built_superflows ,superflow_name_sref=$$superflow_name_sref\n");

	if ($superflow_name_sref) {

		$L_SU_href->{_prog_name_sref} = $superflow_name_sref;
		$gui_history->set_hash_ref($L_SU_href);
		$gui_history->set4superflow_open_data_file_start();
		$L_SU_href = $gui_history->get_hash_ref();
		$pre_built_big_stream->set_hash_ref($L_SU_href);

		# displays superflow name at top of gui
		$pre_built_big_stream->set_flowNsuperflow_name_w($flowNsuperflow_name_w);

		# for binding to file dialog options
		my $sub_ref = \&_FileDialog_button;
		$pre_built_big_stream->set_sub_ref($sub_ref);

		# print("41 L_SU,pre_built_superflows, gui_history.txt\n");
		# $gui_history->view();

		# display parameters values and names
		# of a chosen superflow
		# but do not write them to a file
		$pre_built_big_stream->select();

		# print("41 L_SU,pre_built_superflows, parameter_values_frame: $L_SU_href->{_parameter_values_frame}\n");
		# print("41 L_SU,pre_built_superflows, parameter_values_frame: $parameter_values_frame\n");

		# return changes to $L_SU_href without altering other original values
		$L_SU_href = $pre_built_big_stream->get_hash_ref();    # 96 returned
			# print("41 L_SU,pre_built_superflows, values_aref: @{$L_SU_href->{_values_aref}}\n");

	} else {
		print("L_SU,pre_built_superflow, missing name \n");
	}
	return ();
}

=head2 sub run_button

comes from MAIN and is used by superflow
     
    uses flow or pre_built superflow names  
	
	original L_SU plus changes is returned	
    
    for safety, place set_hash_ref first
    
 	foreach my $key (sort keys %$L_SU_href) {
      	print (" L_SU,run_button, key is $key, value is $L_SU_href->{$key}\n");
 	}
 				      	
     
=cut

sub run_button {
	my ( $self, $value_ref ) = @_;

	# print("L_SU,run_button, value: ${$value_ref} \n");

	if ( $$value_ref eq 'Run' ) {    # i.e., 'Run'... double check

		# e.g., user-built or pre-built superflow
		if ( $L_SU_href->{_flow_type} ) {
			my $flow_type = $L_SU_href->{_flow_type};

			if ( $flow_type eq 'user_built' ) {

				my $flow_color = $L_SU_href->{_flow_color};

				# print("1. L_SU,run_button,flow_color: $L_SU_href->{_flow_color} \n");
				my $color_flow = $flow_color . '_flow';

				if ($flow_color) {    # e.g. grey, pink, green or blue flows

					my $temp_hash = $color_flow->get_hash_ref();

					$L_SU_href->{_has_used_SaveAs_button}         = $temp_hash->{_has_used_SaveAs_button};
					$L_SU_href->{_has_used_open_perl_file_button} = $temp_hash->{_has_used_open_perl_file_button};
					$L_SU_href->{_has_used_Save_button}           = $temp_hash->{_has_used_Save_button};
					$L_SU_href->{_flow_name_out}                  = $temp_hash->{_flow_name_out};
					my $flow_name_out = $L_SU_href->{_flow_name_out};

					# print("1 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");

					if (   $L_SU_href->{_has_used_SaveAs_button}
						|| $L_SU_href->{_has_used_Save_button}
						|| $L_SU_href->{_flow_name_out}
						|| $L_SU_href->{_has_used_open_perl_file_button} ) {

						# print("1 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");
						$gui_history->set_hash_ref($L_SU_href);

						# $gui_history->set_gui_widgets($L_SU_href);
						$gui_history->set4start_of_run_button();

						# print("2 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");
						# print("2 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");

						$run_button->set_hash_ref($L_SU_href);

						# print("3 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");
						$run_button->set_flow_type( $L_SU_href->{_flow_type} );

						# print("4 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");
						$run_button->set_flow_name_out($flow_name_out);

						# print("5 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");
						#						$run_button->set_gui_widgets($L_SU_href);
						# print("6 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");
						$run_button->director();

						# print("7 L_SU,run_button,_is_last_parameter_index_touched_color:	$L_SU_href->{_is_last_parameter_index_touched_color} \n");
						$gui_history->set4end_of_run_button();    # sets 2

						$L_SU_href = $gui_history->get_hash_ref();

						# print("\n8. L_SU,run_button,_last_flow_index_touched is: $L_SU_href->{_last_flow_index_touched}\n");

					} else {
						print("L_SU,run_button, missing conditions\n");
						use message_director;
						my $run_button_messages = message_director->new();
						my $message             = $run_button_messages->run_button(1);

						# a blank message
						$message_w->delete( "1.0", 'end' );
						$message_w->insert( 'end', $message );

					}
				} else {
					print("L_SU, run_button, missing color\n");
				}

			} elsif ( $flow_type eq 'pre_built_superflow' ) {

				# print("L_SU,run_button, (a pre_built_superflow, has_used_Save_superflow:	$L_SU_href->{_has_used_Save_superflow}: \n");
				# print("L_SU,run_button, (a pre_built_superflow, has_used_SaveAs_button:	$L_SU_href->{_has_used_SaveAs_button}: \n");

				$run_button->set_hash_ref($L_SU_href);    # used  36 / 115 in
				$run_button->set_flow_type( $L_SU_href->{_flow_type} );
				$run_button->set_prog_name_sref( $L_SU_href->{_prog_name_sref} );

				#				$run_button->set_gui_widgets($L_SU_href);    # used 23 / 115 in
				$run_button->director();

			} else {
				print("L_SU,run_button, wrong flow type\n");
			}
		} else {
			print("L_SU,run_button , missing flow type user- or pre-built \n");
		}
	} else {
		print("L_SU,run_button , missing flow type  Run \n");
	}
	return ();
}

=head2 sub save_button

 called from MAIN

 foreach my $key (sort keys %$L_SU_href) {
      print (" L_SU,save_button, key is $key, value is $L_SU_href->{$key}\n");
 }	
          
         dialog_type for save_button is only 'Save'
         
   Because private hash does not have _dialog type
   it should be assigned to save_button after set_hash_ref transfers L_SU hash
   but not before
   i.e. for safety, transfer set_hash_ref first
         
   save can be for 2 situations: pre-built superflows and user-built flows
         
  collect changes to environmental indicator variables such as _has_used_SaveAs_button
         
    print("L_SU,save_button, flow_type : $L_SU_href->{_flow_type}\n");
    
    In:  save_button, uses topics
    	
    Topics originate as a dialog_type topic which can be  'Data', 'Flow' or 'SaveAs'
    
    Topic for save_button can also be 'Save'
    
    Flow types can be: user-built or pre-built superflow
    
    Logic for use: SaveAs_button must have been used previously or Save_button
    Once Save_button is used has_used_SaveAs_button = false
 	

=cut

sub save_button {

	my ( $self, $topic_sref ) = @_;

	# rint("L_SU,save_button, topic: $$topic_sref\n");

	use message_director;
	my $save_button_messages = message_director->new();
	my $message              = $save_button_messages->null_button(0);

	# a blank message
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	if ($topic_sref) {    # i.e., topic is 'Save'
		my $topic;
		$topic = $$topic_sref;

		# choose between
		# user-built,  or pre-built superflow
		if ( $L_SU_href->{_flow_type} ) {

			my $flow_type = $L_SU_href->{_flow_type};

			if ( $flow_type eq 'user_built' ) {

				my $flow_color = $L_SU_href->{_flow_color};

				# print("L_SU,save_button,flow_color: $L_SU_href->{_flow_color} \n");

				my $flow_color_hname = $flow_color . '_flow';

				if ($flow_color) {    # e.g. grey, pink, green or blue flows

					# collect information from the most recent updates to flow packages (e.g., grey_flow.pm)
					my $temp_hash = $flow_color_hname->get_hash_ref();

					$L_SU_href->{_has_used_SaveAs_button}         = $temp_hash->{_has_used_SaveAs_button};
					$L_SU_href->{_has_used_Save_button}           = $temp_hash->{_has_used_Save_button};
					$L_SU_href->{_flow_name_out}                  = $temp_hash->{_flow_name_out};                   #TBD
					$L_SU_href->{_has_used_open_perl_file_button} = $temp_hash->{_has_used_open_perl_file_button};

					# check to see if the current user-built flow has used SaveAs or Save button
					if (   $L_SU_href->{_has_used_SaveAs_button}
						|| $L_SU_href->{_has_used_Save_button}
						|| $L_SU_href->{_flow_name_out}
						|| $L_SU_href->{_has_used_open_perl_file_button} ) {

						# store possible changes in parameter values
						# print("L_SU, save_button, saving flow \n");
						# print("L_SU, save_button,_last_parameter_index_touched_color, $L_SU_href->{_last_parameter_index_touched_color}\n");
						$flow_color_hname->save_button($topic);

						# reset states
						# N.B. Save_button can only be used if SaveAs is true
						# But, after Save_button is used, reset _has_used_SaveAs_button to false
						# and has_used_Save_button to true

						$gui_history->set_hash_ref($L_SU_href); 
						$gui_history->set4end_of_Save_button();
						$L_SU_href = $gui_history->get_hash_ref();
						
						# print("2. L_SU, save_button, for user_built_flow, print out gui_history.txt\n");
						# $gui_history->view();

					} else {
						my $message = $save_button_messages->save_button(1);
						$message_w->insert( 'end', $message );

						# print("L_SU,save_button, can not save user-built file\n");
					}

				} else {
					print("L_SU, save_button, missing color\n");
				}

			} elsif ( $flow_type eq 'pre_built_superflow' ) {

				# collect latest values from a prior run of pre_built_superflow or FileDialog_button
				# print("2. L_SU, save_button, _values_aref[0]: @{$L_SU_href->{_values_aref}}\n");

				$L_SU_href->{_dialog_type} = 'Save';

				# print("2. L_SU, save_button, _names_aref: @{$L_SU_href->{_names_aref}}\n");  # equi to labels_aref
				$save_button->set_hash_ref($L_SU_href);    #  uses 41  / 115 in
					# $save_button->set_gui_widgets($L_SU_href);                            #  uses 27 / 115 in

				#				print("2. L_SU, save_button, print out gui_history.txt\n");
				#				$gui_history->view();
				$save_button->set_flow_type( $L_SU_href->{_flow_type} );              # set 1
				$save_button->set_prog_name_sref( $L_SU_href->{_prog_name_sref} );    # set 1

				# print("1. L_SU, save_button,last left listbox flow program touched had index = $L_SU_href->{_last_flow_index_touched}\n");
				# print("1. L_SU, save_button, flow_item_up_arrow_button= $L_SU_href->{_flow_item_up_arrow_button}\n");
				$save_button->set_dialog_type($topic);    # set 1 of 3
				 # print("1. L_SU, save_buttonlast left listbox flow program touched had index = $L_SU_href->{_last_flow_index_touched}\n");
				 # print("2. L_SU, save_button, for  pre-built stream, print out gui_history.txt\n");
				 # $gui_history->view();

				$save_button->director();

				$L_SU_href = $save_button->get_all_hash_ref();    # returns 108
				 # print("2. L_SU, save_button, flow_item_up_arrow_button= $L_SU_href->{_flow_item_up_arrow_button}\n");
				 # print("L_SU, save_button,pre_built_flow,has_used_SaveAs_button $L_SU_href->{_has_used_SaveAs_button}\n");
				 # print("L_SU, save_button,pre_built_flow,has_used_Save_superflow $L_SU_href->{_has_used_Save_superflow}\n");
				 # print("L_SU, save_button,pre_built_flow,has_used_Save_button $L_SU_href->{_has_used_Save_button}\n");
				 # print("L_SU, save_button,pre_built_flow,is_Save_button $L_SU_href->{_is_Save_button}\n");

			} else {
				print("L_SU,save_button , missing flow type\n");
			}
		}

	} else {
		print("L_SU,save_button , missing dialog_type, Save \n");
	}
	return ();
}

=head2 sub set_hash_ref 

	imports external hash into private settings
	once at the start of the Main Loop
	Settings are lost thereafter and so it is good
	to store them with local names
 
=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	$gui_history->set_defaults($hash_ref);

	# print("L_SU,set_hash_ref: $gui_history->get_defaults()\n");
	$L_SU_href = $gui_history->get_defaults();

	# $gui_history->view();
	$flowNsuperflow_name_w         = $L_SU_href->{_flowNsuperflow_name_w};
	$message_w                     = $L_SU_href->{_message_w};
	$parameter_names_frame         = $L_SU_href->{_parameter_names_frame};
	$parameter_values_frame        = $L_SU_href->{_parameter_values_frame};
	$parameter_values_button_frame = $L_SU_href->{_parameter_values_button_frame};
	$mw                            = $L_SU_href->{_mw};

	return ();
}

=head2  set_param_widgets
  Initially, checkbutton widgets and values 
  are green ("on") or red ("off"), and
  Labels and Entry Widgets are made blank.
  get back the Label and Entry widgets 
  
  print("L_SU, set_param_widgets _check_buttons_settings_aref: @{$L_SU_href->{_check_buttons_settings_aref}}\n")
  print("L_SU, set_param_widgets _labels_w_aref: @{$L_SU_href->{_labels_w_aref}}\n");
  
=cut

sub set_param_widgets {
	my ($self) = @_;

	use param_widgets;
	my $param_widgets = param_widgets->new();

	# print("L_SU,set_param_widgets, parameter_names_frame: $parameter_names_frame\n");
	# $gui_history->view();

	$param_widgets->set_labels_frame( \$parameter_names_frame );
	$param_widgets->set_values_frame( \$parameter_values_frame );
	$param_widgets->set_check_buttons_frame( \$parameter_values_button_frame );
	$param_widgets->initialize_labels();
	$param_widgets->initialize_values();
	$param_widgets->initialize_check_buttons();
	$param_widgets->show_labels();
	$param_widgets->show_values();
	$param_widgets->show_check_buttons();

	$L_SU_href->{_check_buttons_w_aref}        = $param_widgets->get_check_buttons_w_aref();
	$L_SU_href->{_check_buttons_settings_aref} = $param_widgets->get_check_buttons_settings_aref();
	$L_SU_href->{_labels_w_aref}               = $param_widgets->get_labels_w_aref();
	$L_SU_href->{_values_w_aref}               = $param_widgets->get_values_w_aref();

	return ();
}

=head2 sub user_built_flows

 USE:

  for any colored flow
 to delete an item from a flow
 'delete_from_flow_button'
 to move up and down a list of flow items
 'flow_item_up_arrow_button'
 'flow_item_down_arrow_button'
 'delete_whole_flow_button'
 add2flows
 
 unix_listbox help (MB3)
 flow-item selection ('flow_select') (MB1)

if neutral-colored stored parameters exist
they have to be transferred over from 
neutral_flow to either grey, pink, green, or blue, _flow
 		 			
displays superflow name at top of gui
 		$pre_built_big_stream	->set_flowNsuperflow_name_w($flowNsuperflow_name_w);	

needed for binding to file dialog options
 		$grey_flow	->set_sub_ref(\&_FileDialog_button);
 		
Display of all the parameters and names occurs via select method
 		$pre_built_big_stream	->select();  
 		
return changes to $L_SU_href without altering other original values
 		$L_SU_href 					= $pre_built_big_stream->get_hash_ref();	
 			
 listbox color is selected, e.g., with a MB1 click in Main

=cut

sub user_built_flows {
	my ( $self, $method ) = @_;

	my $color = _get_flow_color;
	my $idx;

	# Dealing with the grey flow ?
	# Is grey flow listbox occupied ?
	# Skip the listbox if it is contains no flow
	# Don't skip the listbox if it does contain a flow

	if (   $color eq 'grey'
		|| $color eq 'pink'
		|| $color eq 'green'
		|| $color eq 'blue'
		|| $color eq 'neutral' ) {

		if ( $color eq 'grey' ) {
			$idx = 0;
		} elsif ( $color eq 'pink' ) {
			$idx = 1;
		} elsif ( $color eq 'green' ) {
			$idx = 2;
		} elsif ( $color eq 'blue' ) {
			$idx = 3;
		} elsif ( $color eq 'neutral' ) {

			# stuff below
		} else {
			print("L_SU,user_built_flows,enexpected value  \n");
		}

		#		print("L_SU,user_built_flows, occupied listboxes= @{$L_SU_gui->{_occupied_listbox_aref}} \n");
		#		print("L_SU,user_built_flows, occupied listboxes= @{$L_SU_gui->{_vacant_listbox_aref}} \n");
		
		if ( $color eq 'grey' ) {

			# A flow has been started
			# Used by delete_from_flow_button,
			# and delete_whole_flow_button
			# Used to delete the flow completely
			# e.g., when deleting the last item in a flow
			# or deleting the whole flow at once
			# Also used for moving item up or down a flow
			# Dealing with the greyflow ?
			# Is grey flow listbox occupied ?
			# Skip the listbox if there is no flow already in it

			if ( @{ $L_SU_gui->{_occupied_listbox_aref} }[0] == $true ) {
				
#   			@{ $L_SU_gui->{_vacant_listbox_aref} }[0] == $false 

				# flow already exists
				# bind flow parameters to the opening files
				$grey_flow->set_hash_ref($L_SU_href);
				$grey_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
				$grey_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
				
				if ( $method eq 'flow_select' ) {

					my $prior_flow_color       = ( $L_SU_href->{_flow_select_color_href} )->{_prior};
					my $most_recent_flow_color = ( $L_SU_href->{_flow_select_color_href} )->{_most_recent};

					if ( $prior_flow_color eq $most_recent_flow_color ) {

						# CASE 1 if selecting the same flow color more than once
						$grey_flow->$method;

					} elsif ( $prior_flow_color ne $most_recent_flow_color ) {

						# CASE 2 if selecting  a different color flow than last time
						$grey_flow->flow_select2save_most_recent_param_flow();

					} else {
						print("2. L_SU,user_built_flows, bad value\n");
					}

					$L_SU_href = $grey_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
					$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();

				} elsif ( $method ne 'flow_select' ) {

					$grey_flow->$method;

				} else {
					print("NADA L_SU,user_built_flows, skip this method\n");
				}

				$L_SU_href = $grey_flow->get_hash_ref();

				# transfer any updates from color_flows to the private hash on
				# the state of occupancy of vacancy of color flow listboxes
				$color_listbox->set_flow_listbox_future_occupancyNvacancy_aref( $L_SU_href->{_occupied_listbox_aref} );
				$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
				$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();
				
			} elsif ( @{ $L_SU_gui->{_occupied_listbox_aref} }[0] == $false ) {
#			@{ $L_SU_gui->{_vacant_listbox_aref} }[0] == $true
				# CASE: A flow does not YET exist in ths colored flow box
				# indicate preferred future occupation of this listbox color

				if ( $method eq 'add2flow_button' ) {

					$grey_flow->set_hash_ref($L_SU_href);
					$grey_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
					$grey_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
					# must precede add2flow	method
					$gui_history->set_flow_select_color($color);

					#	print("first time add2flow : L_SU,user_built_flows,method=$method\n");
					$grey_flow->$method;
					$grey_flow->flow_select2save_most_recent_param_flow();

					#  updates flow_select color
					$L_SU_href = $grey_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
					$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();
					
				} elsif ( $method eq 'flow_select' ) {

					# indicate preferred future occupation of this listbox color
					$color_listbox->set_future_flow_listbox_color('grey');

				} else {
					print(" L_SU,user_built_flows, grey, unexpected:--$method--\n");
				}
			} else {
				print(" L_SU,user_built_flows, grey, unexpected occupation status\n");
			}

		} elsif ( $color eq 'pink' ) {

			# A flow has been started
			# Used by delete_from_flow_button,
			# and delete_whole_flow_button
			# Used to delete the flow completely
			# e.g., when deleting the last item in a flow
			# or deleting the whole flow at once
			# Also used for moving item up or down a flow
			# Dealing with the pink flow
			# Is pink flow listbox occupied ?
			# Skip the listbox if there is a flow already in it

			if ( @{ $L_SU_gui->{_occupied_listbox_aref} }[1] == $true ) {
#			@{ $L_SU_gui->{_vacant_listbox_aref} }[1] == $false 
				# flow already exists
				#  bind flow parameters to the opening files
				$pink_flow->set_hash_ref($L_SU_href);
				$pink_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
				$pink_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
				
				if ( $method eq 'flow_select' ) {

					my $prior_flow_color       = ( $L_SU_href->{_flow_select_color_href} )->{_prior};
					my $most_recent_flow_color = ( $L_SU_href->{_flow_select_color_href} )->{_most_recent};

					if ( $prior_flow_color eq $most_recent_flow_color ) {

						#CASE 1 if selecting the same flow color more than once
						$pink_flow->$method;

					} elsif ( $prior_flow_color ne $most_recent_flow_color ) {

						#CASE 2 if selecting  a different color flow than last time
						$pink_flow->flow_select2save_most_recent_param_flow();

					} else {
						print("2. L_SU,user_built_flows, bad value\n");
					}

					$L_SU_href = $pink_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
					$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();
					
				} elsif ( $method ne 'flow_select' ) {

					$pink_flow->$method;

				} else {
					print("NADA L_SU,user_built_flows, skip thismethod\n");
				}

				$L_SU_href = $pink_flow->get_hash_ref();

				# transfer any updates from color_flows to the private hash on
				# the state of occupancy of vacancy of color flow listboxes
				$color_listbox->set_flow_listbox_future_occupancyNvacancy_aref( $L_SU_href->{_occupied_listbox_aref} );
				$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
				$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();

			} elsif ( @{ $L_SU_gui->{_occupied_listbox_aref} }[1] == $false ) {
#			@{ $L_SU_gui->{_vacant_listbox_aref} }[1] == $true
				# CASE: A flow does not exist in ths colored flow box
				# indicate preferred future occupation of this listbox color
				if ( $method eq 'add2flow_button' ) {

					$pink_flow->set_hash_ref($L_SU_href);
					$pink_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
					$pink_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
					# must precede add2flow	method
					$gui_history->set_flow_select_color($color);

					$pink_flow->$method;
					$pink_flow->flow_select2save_most_recent_param_flow();

					#  updates flow_select color
					$L_SU_href = $pink_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
					$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();

				} elsif ( $method eq 'flow_select' ) {

					# indicate preferred future occupation of this listbox color
					$color_listbox->set_future_flow_listbox_color('pink');

				} else {
					print(" L_SU,user_built_flows, pink, unexpected \n");
				}
			} else {
				print(" L_SU,user_built_flows, pink, unexpected occupation status\n");
			}

		} elsif ( $color eq 'green' ) {

			# A flow has been started
			# Used by delete_from_flow_button,
			# and delete_whole_flow_button
			# Used to delete the flow completely
			# e.g., when deleting the last item in a flow
			# or deleting the whole flow at once
			# Also used for moving item up or down a flow
			# Dealing with the green flow ?
			# Is green flow listbox occupied ?
			# Skip the listbox if there is no flow already in it

			if ( @{ $L_SU_gui->{_occupied_listbox_aref} }[2] == $true ) {
#			@{ $L_SU_gui->{_vacant_listbox_aref} }[2] == $false 
				# flow already exists
				# bind flow parameters to the opening files
				$green_flow->set_hash_ref($L_SU_href);
				$green_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
				$green_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
				if ( $method eq 'flow_select' ) {

					my $prior_flow_color       = ( $L_SU_href->{_flow_select_color_href} )->{_prior};
					my $most_recent_flow_color = ( $L_SU_href->{_flow_select_color_href} )->{_most_recent};

					if ( $prior_flow_color eq $most_recent_flow_color ) {

						#CASE 1 if selecting the same flow color more than once
						$green_flow->$method;

					} elsif ( $prior_flow_color ne $most_recent_flow_color ) {

						#CASE 2 if selecting  a different color flow than last time
						$green_flow->flow_select2save_most_recent_param_flow();

					} else {
						print("2. L_SU,user_built_flows, bad value\n");
					}

					$L_SU_href = $blue_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
					$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();

				} elsif ( $method ne 'flow_select' ) {

					$green_flow->$method;

				} else {
					print("NADA L_SU,user_built_flows, skip thismethod\n");
				}

				$L_SU_href = $green_flow->get_hash_ref();

				# transfer any updates from color_flows to the private hash on
				# the state of occupancy of vacancy of color flow listboxes
				$color_listbox->set_flow_listbox_future_occupancyNvacancy_aref( $L_SU_href->{_occupied_listbox_aref} );
				$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
				$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();

			} elsif ( @{ $L_SU_gui->{_occupied_listbox_aref} }[2] == $false ) {
#			@{ $L_SU_gui->{_vacant_listbox_aref} }[2] == $true 
				# CASE: A flow does not exist in ths colored flow box
				# indicate preferred future occupation of this listbox color
				if ( $method eq 'add2flow_button' ) {

					$green_flow->set_hash_ref($L_SU_href);
					$green_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
                    $green_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
					# must precede add2flow	method
					$gui_history->set_flow_select_color($color);

					$green_flow->$method;
					$green_flow->flow_select2save_most_recent_param_flow();

					#  updates flow_select color
					$L_SU_href = $green_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
                    $L_SU_gui->{_vacant_listbox_aref}   =  $color_listbox->get_flow_listbox_vacancy_aref();
                  
				} elsif ( $method eq 'flow_select' ) {

					# indicate preferred future occupation of this listbox color
					$color_listbox->set_future_flow_listbox_color('green');

				} else {
					print(" L_SU,user_built_flows, green,unexpected \n");
				}
			} else {
				print(" L_SU,user_built_flows, green, unexpected occupation status\n");
			}

		} elsif ( $color eq 'blue' ) {

			# A flow has been started
			# Used by delete_from_flow_button,
			# and delete_whole_flow_button
			# Used to delete the flow completely
			# e.g., when deleting the last item in a flow
			# or deleting the whole flow at once
			# Also used for moving item up or down a flow
			# Dealing with the blue flow ?
			# Is blue flow listbox occupied ?
			# Skip the listbox if there is no flow already in it

			if ( @{ $L_SU_gui->{_occupied_listbox_aref} }[3] == $true ) {
#			@{ $L_SU_gui->{_vacant_listbox_aref} }[3] == $false 
				# flow already exists
				# bind flow parameters to the opening files
				$blue_flow->set_hash_ref($L_SU_href);
				$blue_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
				$blue_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
				
				if ( $method eq 'flow_select' ) {

					my $prior_flow_color       = ( $L_SU_href->{_flow_select_color_href} )->{_prior};
					my $most_recent_flow_color = ( $L_SU_href->{_flow_select_color_href} )->{_most_recent};

					if ( $prior_flow_color eq $most_recent_flow_color ) {

						#CASE 1 if selecting the same flow color more than once
						$blue_flow->$method;

					} elsif ( $prior_flow_color ne $most_recent_flow_color ) {

						#CASE 2 if selecting  a different color flow than last time
						$blue_flow->flow_select2save_most_recent_param_flow();

					} else {
						print("2. L_SU,user_built_flows, bad value\n");
					}

					$L_SU_href = $blue_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
                    $L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();
                    
				} elsif ( $method ne 'flow_select' ) {

					$blue_flow->$method;

				} else {
					print("NADA L_SU,user_built_flows, skip thismethod\n");
				}

				$L_SU_href = $blue_flow->get_hash_ref();

				# transfer any updates from color_flows to the private hash on
				# the state of occupancy of vacancy of color flow listboxes
				$color_listbox->set_flow_listbox_future_occupancyNvacancy_aref( $L_SU_href->{_occupied_listbox_aref} );
				$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
				$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();
				
			} elsif ( @{ $L_SU_gui->{_occupied_listbox_aref} }[3] == $false ) {
#			@{ $L_SU_gui->{_vacant_listbox_aref} }[3] == $true 
				# CASE: A flow does not exist in thsis blue flow box

				if ( $method eq 'add2flow_button' ) {

					$blue_flow->set_hash_ref($L_SU_href);
					$blue_flow->set_occupied_listbox_aref( $L_SU_gui->{_occupied_listbox_aref} );
					$blue_flow->set_vacant_listbox_aref( $L_SU_gui->{_vacant_listbox_aref} );
					# must precede add2flow	method
					$gui_history->set_flow_select_color($color);

					$blue_flow->$method;
					$blue_flow->flow_select2save_most_recent_param_flow();

					#  updates flow_select color
					$L_SU_href = $blue_flow->get_hash_ref();
					$color_listbox->set_flow_listbox_color( _get_flow_color() );
					$L_SU_gui->{_occupied_listbox_aref} = $color_listbox->get_flow_listbox_occupancy_aref();
					$L_SU_gui->{_vacant_listbox_aref} = $color_listbox->get_flow_listbox_vacancy_aref();
					
				} elsif ( $method eq 'flow_select' ) {

					# indicate preferred future occupation of this listbox color
					$color_listbox->set_future_flow_listbox_color('blue');

				} else {
					print(" L_SU,user_built_flows, blue, unexpected \n");
				}
			} else {
				print(" L_SU,user_built_flows, blue, unexpected occupation status\n");
			}

		}

		# sunix_select is chosen
		elsif ( $color eq 'neutral' ) {

			$neutral_flow->set_hash_ref($L_SU_href);
			$neutral_flow->$method;

			# print("10. L_SU,user_built_flows, color=neutral,after MB1 occupied_listboxes: @{$L_SU_gui->{_occupied_listbox_aref}}\n");
			# print("10. L_SU,user_built_flows, color=neutral,after MB1 occupied_listboxes: @{$L_SU_gui->{_vacant_listbox_aref}}\n");
			
			# last_flow_color from L_SU does not enter the gui_history
			# only colors in each color_flow enter the flow history

			# bring back selected sunix program name
			$L_SU_href->{_prog_name_sref} = $neutral_flow->get_prog_name_sref();

			_set_user_built_flow_type();

		} else {
			print("L_SU,user_built_flows, method is $method, unknown color\n");
		}
	} else {
		print("L_SU, user_built_flows, undeclared color \n");
	}

	return ();
}

sub wipe_plots_button {

	system('xk');

	return ();
}

__PACKAGE__->meta->make_immutable;
1;
