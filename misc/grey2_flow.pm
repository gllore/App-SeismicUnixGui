package grey2_flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: grey_flow.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 

 DESCRIPTION 
     

 BASED ON:
 previous versions of the main userBuiltFlow.pl
  

=cut

=head2 USE

=head3 NOTES

   Provides in-house macros/superflows
   1. Find widget you have selected

  if widget_name= frame then we have flow
              $var->{_flow}
              
  if widget_name= menubutton we have superflow 
              $var->{_tool}

   2. Set the new program name 

     3. Make widget states active for:
       run_button
       save_button

     4. Disable the following widgets:
       delete_from_flow_button
      (sunix) flow_listbox

    sunix_listbox   		-choice of listed sunix modules in a listbox
    gui_history records updates to GUI selections
    but color_flow_href points to the changed has reference and senses
    the change as well.
    
=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl
 V 0.0.2 removed unused methods in comments

=cut 

=head2 Notes 

sub sunix_select (subroutine is only active in neutral_flow.pm)

magic names to replace by other colors

 grey_flow					to color_flow
 param_widgets_grey			to param_widgets_color
 param_flow_grey			to param_flow_color
 _grey_w}\n					to _color_w}\n
 _touched_grey} = $true;	to _color_touched_grey} = $true;
 
 
=cut 

use Moose;
our $VERSION = '0.0.3';

extends 'gui_history' => { -version => 0.0.2 };

use param_widgets_grey2 0.0.2;
use param_flow_grey 0.0.2;

# use whereami;    # for whole-gui awareness
use flow_widgets;
use conditions_gui;
use L_SU_global_constants;

=head2 Instantiation

=cut

my $get = L_SU_global_constants->new();

# my $conditions_gui = conditions_gui->new();
my $flow_widgets = flow_widgets->new();
my $gui_history  = gui_history->new();

my $param_flow_color_pkg = param_flow_grey->new();

my $param_widgets = param_widgets_grey2->new();

# my $whereami        = whereami->new();
my $flow_type       = $get->flow_type_href();
my $var             = $get->var();
my $empty_string    = $var->{_empty_string};
my $this_color      = 'grey';
my $color_flow_href = $gui_history->get_defaults();

=head2

 share the following parameters in same name 
 space
 

=cut

my $flow_color;
my $flow_name_color_w;
my $flowNsuperflow_name_w;
my $last_flow_color;
my $message_w;
my $occupied_listbox_aref;
my $parameter_values_button_frame;
my $parameter_values_frame;

# my $sunix_listbox;
my $user_built = $flow_type->{_user_built};

# global variable
our $gui_history_aref;

my $true        = $var->{_true};
my $false       = $var->{_false};
my @empty_array = (0);              # length=1

#=head2 private hash
#
#	_is_flow_listbox_color_w is generic colored widget
#	Warning: conditions_gui.pm does not contain all the hash keys and values
#	that follow-- these variables will be reset by conditions_gui.pm
#
#=cut

=head2 sub _add2flow
When reading a user-built perl flow
Incorporate new program parameter values and labels into the gui
and save the values, labels and checkbuttons setting in the param_flow
namespace

foreach my $key (sort keys %$color_flow_href) {
   print (" color_flow _add2flow,key is $key, value is $color_flow_href->{$key}\n");
  }
	
_flow_select is run from _perl_flow

=cut

sub _add2flow {

	my ( $self, $value ) = @_;

	use messages::message_director;
	use Clone 'clone';

	my $color_flow_messages = message_director->new();
	my $message             = $color_flow_messages->null_button(0);

	my $here;
	my $flow_color = _get_flow_color();
	$gui_history->set_add2flow_color($flow_color);
	$gui_history->set_button('add2flow_button');
	$gui_history->set_flow_type($user_built);

	$gui_history->set_hash_ref($color_flow_href);
	$gui_history->set4start_of_add2flow_button($flow_color);
	$color_flow_href = $gui_history->get_hash_ref();

	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# add the most recently selected program
	# name (scalar reference) to the
	# end of the list inside flow_listbox
	_local_set_flow_listbox_color_w($flow_color);    # in "color"_flow namespace

	# append new program names to the end of the list but this item is NOT selected
	# selection occurs inside gui_history, conditions_gui
	$color_flow_href->{_flow_listbox_color_w}->insert( "end", ${ $color_flow_href->{_prog_name_sref} }, );

	# display default paramters in the GUI
	# same as for sunix_select
	# can not get program name from the item selected in the sunix list box
	# because focus is transferred to a flow list box  ($this_color)

	# widgets are initialized in a super class
	# Assign program parameters in the GUI
	# no. of parameters defaults to max=114
	# See: L_SU_global_constants.pl

	$param_widgets->set_labels_w_aref( $color_flow_href->{_labels_w_aref} );
	$param_widgets->set_values_w_aref( $color_flow_href->{_values_w_aref} );
	$param_widgets->set_check_buttons_w_aref( $color_flow_href->{_check_buttons_w_aref} );

	# print(" 1. color_flow, _add2flow, \n");
	$param_widgets->range($color_flow_href);
	$param_widgets->set_labels( $color_flow_href->{_names_aref} );
	$param_widgets->set_values( $color_flow_href->{_values_aref} );
	$param_widgets->set_check_buttons( $color_flow_href->{_check_buttons_settings_aref} );

	# wipes out values labels and checkbuttons from the gui
	# strange memory leak inside param_widgets
	my $save = clone( $color_flow_href->{_check_buttons_settings_aref} );
	$param_widgets->gui_full_clear();
	@{ $color_flow_href->{_check_buttons_settings_aref} } = @$save;

	$param_widgets->redisplay_labels();
	$param_widgets->redisplay_values();
	$param_widgets->redisplay_check_buttons();

	# Collect and store prog versions changed in list box
	_stack_versions();

	# Add a single_program to the growing stack
	# store one program name, its associated parameters and their values
	# as well as the checkbuttons settings (on or off) in another namespace
	_stack_flow();

	$gui_history->set_hash_ref($color_flow_href);
	$gui_history->set4end_of_add2flow($flow_color);

	# print("color_flow,_add2flow: color $color_flow_href->{_flow_color} \n");
	my $index = $flow_widgets->get_flow_selection( $color_flow_href->{_flow_listbox_color_w} );

	$gui_history->set_flow_index_last_touched($index);    # flow color is not reset
	$color_flow_href = $gui_history->get_hash_ref();

	# switch between the correct index of the last parameter that was touched
	# as a function of the flow's color
	# These data are encapsulated

	$color_flow_href->{_last_parameter_index_touched_color}   = 0;       # initialize
	$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;

	# print("color_flow,_add2flow: print gui_history.txt \n");
	# $gui_history->view();

	_flow_select_director('_add2flow');

	return ();

}

=head2 sub _clear_color_flow

	wipe out color-flow list box with programs
	wipe out param_widgets_color
	wipe out parameters stored for color flow

=cut

sub _clear_color_flow {
	my ($self) = @_;
	use Clone 'clone';

	# my $number = $param_flow_color_pkg->get_num_items();

	#clear all stored parameters and versions in the param_flow
	$param_flow_color_pkg->clear();
	my $number = $param_flow_color_pkg->get_num_items();

	# my $test 	= $param_flow_color_pkg->get_flow_prog_names_aref();

	# clear the parameter values and labels belonging to the gui
	# strange memory leak inside param_widgets
	my $save = clone( $color_flow_href->{_check_buttons_settings_aref} );
	$param_widgets->gui_full_clear();
	@{ $color_flow_href->{_check_buttons_settings_aref} } = @$save;

	# remove all sunix program names from the flow listbox
	# in "color"_flow namespace
	my $_flow_listbox_color_w = _get_flow_listbox_color_w();
	$flow_widgets->clear($_flow_listbox_color_w);

}

=head2

	Only cases with a MB binding use this private ('_') subroutine
	sub binding is responsible
	Other cases that select the GUI file buttons directly use: FileDialog_button
	 	 foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  		}
  	print ("color_flow,_FileDialog_button(binding), _is_flow_listbox_color_w: $color_flow_href->{_is_flow_listbox_color_w} \n");
  	
  	Once the file name is selected the paramter value is upadate in the GUI
  	
=cut 

sub _FileDialog_button {

	my ( $self, $option_sref ) = @_;
	use file_dialog;
	use control;

	my $file_dialog = file_dialog->new();
	my $control     = control->new();

	if ($option_sref) {    # e.g., can be 'Data' or 'Flow'

		# provide values in the current widget
		$color_flow_href->{_values_aref} = $param_widgets->get_values_aref();
		$param_widgets->{_values_aref}   = $param_widgets->get_values_aref();

		# restore strings to have terminal strings
		# remove quotes upon input
		$color_flow_href->{_values_aref} =
			$control->get_no_quotes4array( $color_flow_href->{_values_aref} );

		# in case parameter values have been displayed stringless
		$color_flow_href->{_values_aref} = $control->get_string_or_number4array( $color_flow_href->{_values_aref} );

		$color_flow_href->{_dialog_type} = $$option_sref;    # dereference scalar

		$file_dialog->set_flow_color( $color_flow_href->{_flow_color} );    # uses 1/ 31 in
		$file_dialog->set_hash_ref($color_flow_href);                       # uses 7/ 31 in  ; uses values_aref
		$file_dialog->set_gui_widgets($color_flow_href);                    # uses 18/ 31 in
		$file_dialog->FileDialog_director();

		# print("4. color_flow, _FileDialog_button, last_flow_color:$color_flow_href->{_last_flow_color}\n");

		# file_dialog updates of parameter values
		# values are retrieved
		$color_flow_href->{_values_aref} = $file_dialog->get_values_aref();

		# print("color_flow, _FileDialog_button, param_widgets values_aref: @{$param_widgets->{_values_aref}}\n");

		# assume that after selection to open of a data file while using file-dialog button the
		# GUI has been updated
		# See if the last parameter index has been touched (>= 0)
		# Assume we are still dealing with the current flow item selected

		$color_flow_href->{_last_parameter_index_touched_color}   = $file_dialog->get_last_parameter_index_touched_color();
		$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;

		# the parameter_index_touched changes only when an effective change to the parameter is made
		# print ("color_flow,_FileDialog_button(binding), last_parameter_index_touched: $color_flow_href->{_last_parameter_index_touched_color} \n");
		# in case _check4changes does not run make sure to use the following line
		# update to parameter values occurs in file_dialog

		# Here we update the value of the Entry widget (in GUI) with the selected file name
		# Now might be a good moment to update the parameter_widgets with the updated value
		# update endtry those parameters
		my $selected_Entry_widget = $parameter_values_frame->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);
		$color_flow_href->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();
		$color_flow_href->{_entry_button_label}    = $param_widgets->get_label4entry_button_chosen();
		my $current_index = $color_flow_href->{_parameter_value_index};
		@{ $param_widgets->{_values_aref} }[$current_index]   = $file_dialog->get_selected_file_name();
		@{ $color_flow_href->{_values_aref} }[$current_index] = $file_dialog->get_selected_file_name();
		$param_widgets->redisplay_values();

		# Make sure to place focus again on the updated widget so other modules can find the selection
		$selected_Entry_widget->focus;    # from above

		# in the calling program update the stored paramter flows
		# my $default_param_specs  	= $get->param();
		# my $first_idx 			 	= $default_param_specs->{_first_entry_idx};
		# my $length  			 	= $default_param_specs->{_length};
		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		# $param_widgets				->set_first_idx($first_idx);
		# $param_widgets				->set_length($length);

		# set index touched so that iFile can highlight the correct index
		# Also update the index touched so that the main program can update it later via _check4changes
		# $color_flow_href->{_last_parameter_index_touched_color}  = $current_index;

		#		print("13 color_flow, _FileDialog_button,color_flow selected_file_name: @{ $param_widgets->{_values_aref} }[$current_index]\n");
		#		print("13 color_flow, _FileDialog_button,color_flow values: @{ $color_flow_href->{_values_aref} }\n");

		# print("9. color_flow, _FileDialog_button, last_flow_color:$color_flow_href->{_last_flow_color}\n");
		# print("1. color_flow, _FileDialog_button, last_flow_index_touched $color_flow_href->{_last_flow_index_touched}\n");
		# set up this flow listbox item as the last item touched
		my $_flow_listbox_color_w      = _get_flow_listbox_color_w();                                 # user-built_flow in current use
		my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);
		$color_flow_href->{_last_flow_index_touched}         = $current_flow_listbox_index;           # for next time
		$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

		# print("2. color_flow, _FileDialog_button, last_flow_index_touched $color_flow_href->{_last_flow_index_touched}\n");
		# print("10. color_flow, _FileDialog_button, last_flow_color:$color_flow_href->{_last_flow_color}\n");
		# Changes made with another instance of param_widgets (in file_dialog) will require
		# that we update the namespace of the current param_flow
		# We make this change inside _update_most_recent_param_flow
		_update_most_recent_param_flow();

	}
	else {
		print("color_flow,_FileDialog_button (binding),option type missing ");
	}
	return ();
}

=head2 sub _clear_items_version_aref 

	clear items_versions_aref
	used when last item is removed from the listbox

=cut

sub _clear_items_version_aref {

	my ($self) = @_;

	if ($color_flow_href) {

		$color_flow_href->{_items_versions_aref} = '';
		return ();

	}
	else {
		print("color_flow, _clear_items_version_aref, missing color_flow \n");
		return ();
	}

}

=head2 sub _clear_stack_versions 

	clear items_versions_aref
	when last flow item is deleted
	in the listbox

=cut

sub _clear_stack_versions {

	my $_flow_listbox_color_w = _get_flow_listbox_color_w();

	$flow_widgets->clear_flow_items($_flow_listbox_color_w);
	$flow_widgets->clear_items_versions_aref();

	# hash value = ''
	_clear_items_version_aref();

	$param_flow_color_pkg->clear_flow_items_version_aref();

}

=head2 sub _flow_select_director
Private alias for flow_select
both color and button are set as
per the flow_select called by an active click
from Main, in_L_SU_flow_bindings

=cut

sub _flow_select_director {

	my ($type) = @_;

	if ( defined $type ) {
		$gui_history->set_flow_select_color($this_color);

		if (   $type eq '_add2flow'
			or $type eq '_perl_flow'
			or $type eq 'delete_from_flow_button'
			or $type eq 'flow_item_down_arrow_button'
			or $type eq 'add2flow_button'
			or $type eq 'flow_item_up_arrow_button' )
		{
			# update most recent flow
			_flow_select2update_most_recent_flow();

		}

		#		elsif ($type eq 'flow_item_down_arrow_button'
		#			or $type eq 'add2flow_button'
		#			or $type eq 'flow_item_up_arrow_button') {
		#
		#			# update prior flow
		#			flow_select();
		#			# update most recent flow
		#			_flow_select2update_most_recent_flow();
		#
		#
		#		}
		elsif (1) {

			# update prior flow
			flow_select();

		}
		else {
			print("color_flow,_flow_select_director, unexpected\n");
		}
		return ();

		# $gui_history->view();

	}
}

=head2 sub _flow_select2update_most_recent_flow

 select a program from the flow
 archive the index
 and update any changed parameter flows
  	
=cut

sub _flow_select2update_most_recent_flow {
	my ($self) = @_;

	use messages::message_director;
	use decisions;

	$color_flow_href->{_flow_type} = $flow_type->{_user_built};

	# print("1. color_flow,_flow_select2update_most_recent_flow, last_flow_index_touched:$color_flow_href->{_last_flow_index_touched}\n");
	# print("color_flow,_flow_select2update_most_recent_flow, last_flow_color:$color_flow_href->{_last_flow_color}\n");

	# reset residual flow_listbox_color_w of another color
	# flow_color exists in current (color_flow) namespace
	_local_set_flow_listbox_color_w($flow_color);
	$gui_history->set_flow_select_color($flow_color);

	# print("2\n");
	# $param_flow_color_pkg->view_data();

	my $color_flow_messages = message_director->new();
	my $decisions           = decisions->new();

	my $message = $color_flow_messages->null_button(0);
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	$gui_history->set_hash_ref($color_flow_href);
	$gui_history->set_defaults_4start_of_flow_select($flow_color);
	$color_flow_href = $gui_history->get_hash_ref();

	# print("2. color_flow,_flow_select2update_most_recent_flow, last_flow_index_touched:$color_flow_href->{_last_flow_index_touched}\n");
	# $param_flow_color_pkg->view_data();

	# update the flow color as per add2_flow_select2update_most_recent_flow
	my $_flow_listbox_color_w = _get_flow_listbox_color_w();

	$color_flow_href->{_prog_name_sref} = $flow_widgets->get_current_program( \$_flow_listbox_color_w );

=pod

CASE 1: When _flow_select2update_most_recent_flow is being used for the first time
BUT when no previous flow has been selected
This case can occur when a flow is read into a GUI which is used
for the first time, i.e., when no listboxes have been occupied previously

=cut

	if (  !( $color_flow_href->{_last_flow_color} )
		|| ( $color_flow_href->{_last_flow_color} eq $empty_string ) )
	{
		# print("color_flow,_flow_select2update_most_recent_flow, CASE #1 \n");
		# print( "color_flow,_flow_select2update_most_recent_flow, color_flow->{_last_flow_color}=$color_flow_href->{_last_flow_color}\n" );

		$color_flow_href->{_last_flow_color} = $color_flow_href->{_flow_color};

		$color_flow_href->{_is_last_flow_index_touched_grey}      = $true;
		$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;
		my $num_indices = $flow_widgets->get_num_indices( \$_flow_listbox_color_w );
		$color_flow_href->{_last_flow_index_touched}            = -1;    # $num_indices;
		$color_flow_href->{_last_parameter_index_touched_color} = 0;

		#print("1. color_flow, _flow_select2update_most_recent_flow: writing gui_history.txt\n");
		#$gui_history->view();

=pod

CASE 2 flow_select is used actively (directly clicked) by the user for the first time
The first flow of the session has already been run and saved
BUT if the flow has never been actively selected by the user then the following 
parameters are not activated
and so the internal parameters of the flow items will not get saved 
at the start of this subroutine.
This can happen when user
(1) loads, saves and runs a pre-built user-flow
selects a new flow item
WITHOUT selecting an existant flow item
Does not happen if the user chooses a flow item before going on to select a new sunix
program

=cut

	}
	elsif ($color_flow_href->{_last_flow_color} eq 'neutral'
		&& defined $color_flow_href->{_flow_color}
		&& $color_flow_href->{_flow_color} eq $this_color
		&& defined $color_flow_href->{_prog_name_sref}
		&& $color_flow_href->{_prog_name_sref} ne $empty_string
		&& !( $color_flow_href->{_is_last_flow_index_touched_grey} )
		&& !( $color_flow_href->{_is_last_flow_index_touched_pink} )
		&& !( $color_flow_href->{_is_last_flow_index_touched_green} )
		&& !( $color_flow_href->{_is_last_flow_index_touched_blue} ) )
	{

		# print("CASE # 2\n");
		# $param_flow_color_pkg->view_data();

		$color_flow_href->{_last_flow_color}                      = $color_flow_href->{_flow_color};
		$color_flow_href->{_is_last_flow_index_touched_grey}      = $true;
		$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;
		my $num_indices = $flow_widgets->get_num_indices( \$_flow_listbox_color_w );
		$color_flow_href->{_last_flow_index_touched}            = $num_indices;
		$color_flow_href->{_last_parameter_index_touched_color} = 0;

		#			print("2. color_flow, _flow_select2update_most_recent_flow: writing gui_history.txt\n");
		#			$gui_history->view();
	}

=pod

CASE 3
Flow selected is used a second time only

=cut

	else {
		# NADA
	}

	$decisions->set4flow_select($color_flow_href);

	# print("3. color_flow, _flow_select2update_most_recent_flow: writing gui_history.txt\n");
	# $gui_history->view();
	# $param_flow_color_pkg->view_data();

	my $pre_req_ok = $decisions->get4flow_select();

	if ($pre_req_ok) {

		use binding;
		my $binding = binding->new();
		my $here;
		use Clone 'clone';

		# print("5 _flow_select2update_most_recent_flow \n");
		# my $ans = ( ( $gui_history->get_defaults )->{_flow_select_index_href} )->{_most_recent};
		# print("6 _flow_select2update_most_recent_flow, most_recent_index = $ans\n");
		$gui_history->set_button('flow_select');

		# $ans = ( ( $gui_history->get_defaults )->{_flow_select_index_href} )->{_most_recent};
		# print(" _flow_select2update_most_recent_flow, most_recent_index = $ans\n");

		# $param_flow_color_pkg->view_data();

		# consider prior flow-color changes
		# unticked strings from GUI are corrected here
		_update_most_recent_param_flow2();

		# print("9 _flow_select2update_most_recent_flow \n");

		# Update last flow color in case it does not get updated by _update_most_recent_param_flow2 (above)
		# flow selection needs to update the last flow color selected by the user
		$color_flow_href->{_last_flow_color} = $flow_color;

		# my $value = @{$color_flow_href->{_values_w_aref}}[1]->get;

		# for just-selected program name
		# get its flow parameters from storage
		# and redisplay the widgets with parameters

		# Update the flow item index to the program that is currently being used, instead
		# of prior program
		# Warning: Flow selection gets reset if user double-clicks on a parameter value
		# in another window
		my $index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

		# print("9 _flow_select2update_most_recent_flow, get_selected flow_index = $ans\n");
		$param_flow_color_pkg->set_flow_index($index);
		$color_flow_href->{_names_aref}  = $param_flow_color_pkg->get_names_aref();
		$color_flow_href->{_values_aref} = $param_flow_color_pkg->get_values_aref();

		# print("10 _flow_select2update_most_recent_flow\n");
		# $param_flow_color_pkg->view_data();

		$color_flow_href->{_check_buttons_settings_aref} = $param_flow_color_pkg->get_check_buttons_settings();

		# get stored first index and num of items
		$color_flow_href->{_param_flow_first_idx} = $param_flow_color_pkg->first_idx();
		$color_flow_href->{_param_flow_length}    = $param_flow_color_pkg->length();

		$param_widgets->set_current_program( $color_flow_href->{_prog_name_sref} );

		# print("4. color_flow, _flow_select2update_most_recent_flow: writing gui_history.txt\n");
		# $gui_history->view();

		# widgets were initialized in super class
		$param_widgets->set_labels_w_aref( $color_flow_href->{_labels_w_aref} );
		$param_widgets->set_values_w_aref( $color_flow_href->{_values_w_aref} );
		$param_widgets->set_check_buttons_w_aref( $color_flow_href->{_check_buttons_w_aref} );

		$color_flow_href->{_prog_name_sref} = $flow_widgets->get_current_program( \$_flow_listbox_color_w );

		# wipes out values labels and checkbuttons from the gui
		# print(" 1. color_flow, _flow_select2update_most_recent_flow, \n");

		$param_widgets->range($color_flow_href);

		# strange memory leak inside param_widgets
		my $save = clone( $color_flow_href->{_check_buttons_settings_aref} );
		$param_widgets->gui_full_clear();
		@{ $color_flow_href->{_check_buttons_settings_aref} } = @$save;

		$param_widgets->set_labels( $color_flow_href->{_names_aref} );
		$param_widgets->set_values( $color_flow_href->{_values_aref} );
		$param_widgets->set_check_buttons( $color_flow_href->{_check_buttons_settings_aref} );

		# print("3\n");
		# $param_flow_color_pkg->view_data();

		$param_widgets->redisplay_labels();
		$param_widgets->redisplay_values();
		$param_widgets->redisplay_check_buttons();
		$param_widgets->set_entry_change_status($false);

		# unxpectedly  Entry focus is delayed until the end of this method becore
		# completion;
		# that is we get to gui_history->view before we can update the focus
		# mysterious!!!!!
		$param_widgets->set_focus_on_Entry_w(0);    # put focus on first entry widget, index=0

		# Force the parameter index = 0 (this is NOT the flow index that marks the index of the programs in the flow);
		# If parameter_index >= 0 stored values will also be updated via update_static_param_flow
		# TODO the parameter_index_touched may become  .n.e. 0 but >=0
		# $color_flow_href->{_last_parameter_index_touched_color} = 0;
		# the changed parameter value in the Entry widget should force an update of stored values
		# in the current flow item (not the last flow item touched)
		# _update_most_recent_param_flow(); # is only active if
		# $color_flow_href->{_last_parameter_index_touched_color} >= 0

		# Here is where you rebind the different buttons depending on the
		# program name that is selected (i.e., through spec.pm)
		$binding->set_prog_name_sref( $color_flow_href->{_prog_name_sref} );
		$binding->set_values_w_aref( $param_widgets->get_values_w_aref );

		# reference to local subroutine that will be run when MB3 is pressed
		$binding->setFileDialog_button_sub_ref( \&_FileDialog_button );
		$binding->set();

		$gui_history->set_hash_ref($color_flow_href);
		$gui_history->set4end_of_flow_select($flow_color);
		$gui_history->set_flow_index_last_touched($index);
		$color_flow_href = $gui_history->get_hash_ref();    # now color_flow= 0; flow_type=user_built

		# Update thr entry button value that displays the currently active
		# flow or superflow name, by using the currently selected program name from the flow list
		# e.g. data_in, suximage, suxgraph etc.
		( $color_flow_href->{_flowNsuperflow_name_w} )->configure( -text => ${ $color_flow_href->{_prog_name_sref} } );

		# needed in possible export via get_hash_ref to help
		my $prog_name_sref = $color_flow_href->{_prog_name_sref};

		# will not reflect the Entry focus change
		# print("color_flow_href _flow_select2update_most_recent_flow, log view is on\n");
		# $gui_history->view();

	}    # end pre_ok

	return ();
}

=head2 sub _get_flow_color

	get a private hash value
 
=cut

sub _get_flow_color {
	my ($self) = @_;

	if ( $color_flow_href->{_flow_color} ) {
		my $color;

		$color = $color_flow_href->{_flow_color};
		return ($color);

	}
	else {
		print("color_flow, missing flow color\n");
	}

}

=head2 sub _get_flow_listbox_color_w


=cut 

sub _get_flow_listbox_color_w {
	my ($self) = @_;
	my $flow_color;
	my $this_flow_listbox_color_w;

	$flow_color = $color_flow_href->{_flow_color};

	if ( $flow_color eq $this_color ) {

		$this_flow_listbox_color_w = $color_flow_href->{_flow_listbox_grey_w};

	}
	else {
		print("color_flow, _get_flow_listbox_color_w, missing color\n");
	}

	return ($this_flow_listbox_color_w);
}

=head2 sub _move_in_stored_flows

  move program names,
  parameter names, values and checkbutton setttings
  --- these are stored separately (via param_flows.pm)
  from GUI widgets (via flow_widgets.pm)
  The flow-widgets is a single copy of names and values
  that constantly changes as the uses interacts with the GUI
  The param-flows stores several program (items) and their
  names and values

=cut 

sub _move_in_stored_flows {
	my ($self) = @_;

	$color_flow_href->{_index2move}        = $flow_widgets->index2move();
	$color_flow_href->{_destination_index} = $flow_widgets->destination_index();

	my $start = $color_flow_href->{_index2move};
	my $end   = $color_flow_href->{_destination_index};
	print("color_flow move_in_stored_flows,start index is the $start\n");
	print("color_flow move_in_stored_flows, insertion index is $end \n");

	$param_flow_color_pkg->set_insert_start($start);
	$param_flow_color_pkg->set_insert_end($end);
	$param_flow_color_pkg->insert_selection();

	return ();
}

=head2 sub _SaveAs_button

topic: only for 'SaveAs'
for safety, place set_hash_ref first
  	
CASE #1 considered:
Flow_selection is forced during _add2flow

CASE #2
if the previous items have not been diectly selected with sub flow_select
they will not have been updated since loadin ginto the GUI
if user made changes to the paramters but the flow was not selected
via flow_select (directly by the user) the flow parameters are not correct


=cut

sub _SaveAs_button {
	my ($topic) = @_;

	if ( $topic eq 'SaveAs' ) {

		use files_LSU;
		use control;

		my $files_LSU = new files_LSU();
		my $control   = new control();

		# Start refocus index in flow, in case focus has been removed
		# e.g., by double-clicking in parameter values window
		my $most_recent_flow_index_touched = ( $color_flow_href->{_flow_select_index_href} )->{_most_recent};
		my $prior_flow_index_touched       = ( $color_flow_href->{_flow_select_index_href} )->{_prior};
		my $most_recent_flow_color         = ( $color_flow_href->{_flow_select_color_href} )->{_most_recent};
		my $last_flow_index                = $most_recent_flow_index_touched;

		# print("1 OLD save, last_flow_color is:  $color_flow_href->{_last_flow_color} \n");
		# print("1 OLD save, last_flow_index is:  $color_flow_href->{_last_flow_index} \n");

		# print("1 save_button, most_recent_flow_index is:  $most_recent_flow_index_touched\n");
		# print("1 save_button, pior_flow_index is:  $prior_flow_index_touched\n");

		# print("1 new save, last_flow_color is:  $most_recent_flow_color \n");

=pod


		
=cut

		#		print("_SaveAs_button, view stored data in param flow3\n");
		#		$param_flow_color_pkg->view_data();

		$gui_history->set_hash_ref($color_flow_href);
		$gui_history->set4_start_of_SaveAs_button();

		my $num_items = $param_flow_color_pkg->get_num_items();

		$color_flow_href->{_names_aref} = $param_flow_color_pkg->get_names_aref();

		$param_flow_color_pkg->set_good_values();
		$param_flow_color_pkg->set_good_labels();

		# collect information to be saved in a perl flow
		$color_flow_href->{_good_labels_aref2}   = $param_flow_color_pkg->get_good_labels_aref2();
		$color_flow_href->{_items_versions_aref} = $param_flow_color_pkg->get_flow_items_version_aref();
		$color_flow_href->{_good_values_aref2}   = $param_flow_color_pkg->get_good_values_aref2();
		$color_flow_href->{_prog_names_aref}     = $param_flow_color_pkg->get_flow_prog_names_aref();

		# @{$color_flow_href->{_prog_names_aref}}\n");
		my $num_items4flow = scalar @{ $color_flow_href->{_good_labels_aref2} };

		# for (my $i=0; $i < $num_items4flow; $i++ ) {
		# @{@{$color_flow_href->{_good_labels_aref2}}[$i]}\n");
		# }

		#f or (my $i=0; $i < $num_items4flow; $i++ ) {
		#	print("color_flow,_SaveAs_button, _good_values_aref2,
		#	@{@{$color_flow_href->{_good_values_aref2}}[$i]}\n");
		#}
		#   print("color_flow,_prog_versions_aref,
		#   @{$color_flow_href->{_items_versions_aref}}\n");

		$files_LSU->set_prog_param_labels_aref2($color_flow_href);    # uses x / 61 in
		$files_LSU->set_prog_param_values_aref2($color_flow_href);    # uses x / 61 in
		$files_LSU->set_prog_names_aref($color_flow_href);            # uses x / 61 in
		$files_LSU->set_items_versions_aref($color_flow_href);        # uses x / 61 in
		$files_LSU->set_data();
		$files_LSU->set_message($color_flow_href);                    # uses 1 / 61 in

		$files_LSU->set2pl($color_flow_href);                         # flows saved to PL_SEISMIC
		$files_LSU->save();

		$gui_history->set4_end_of_SaveAs_button();                    # sets: _has_used_SaveAs=true
		$color_flow_href = $gui_history->get_hash_ref();              # 79 out

		return ();

	}
	else {
		print("color_flow,_SaveAs_button, missing topic\n");
	}
}

=head2 sub _perl_flow

  Parse (while reading) perl flows

  foreach my $key (sort keys %$color_flow_href) {
   print (" color_flowkey is $key, value is $color_flow_href->{$key}\n");
  }   
   		my $length = scalar @{$all_values_aref};
   		print("color_flow,perl_flow, length = $length\n");
   		
   		for (my $j=0; $j <$length; $j++) {
   			   	print("color_flow,perl_flow,name & value:@{$all_names_aref}[$j] = @{$all_values_aref}[$j]\n");

   		}     
 
=cut 

sub _perl_flow {
	my ($self) = @_;

	# import modules
	use perl_flow;
	use messages::message_director;
	use param_sunix;
	use control;

	# instantiate modules
	my $perl_flow           = perl_flow->new();
	my $param_sunix         = param_sunix->new();
	my $color_flow_messages = message_director->new();
	my $control             = control->new();

	# messages
	my $message = $color_flow_messages->null_button(0);
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# should be at start of color_flow
	$color_flow_href->{_flow_type} = $flow_type->{_user_built};
	my $flow_name_in = $color_flow_href->{_flow_name_in};

	my $flow_color = $color_flow_href->{_flow_color};

	# read in variables from the perl flow file
	$perl_flow->set_perl_file_in($flow_name_in);
	$perl_flow->parse();

	# clear all signs in GUI and wipe all the memory spaces
	# associated with the contents in the flow listbox that is about to
	# be occupied
	_clear_color_flow();

	my $num_prog_names = $perl_flow->get_num_prog_names();

	for ( my $prog_idx = 0; $prog_idx < $num_prog_names; $prog_idx++ ) {

		# collect info. from perl file
		$perl_flow->set_prog_index($prog_idx);
		$color_flow_href->{_prog_name_sref}              = $perl_flow->get_prog_name_sref();
		$color_flow_href->{_names_aref}                  = $perl_flow->get_all_names_aref();
		$color_flow_href->{_values_aref}                 = $perl_flow->get_all_values_aref();
		$color_flow_href->{_check_buttons_settings_aref} = $perl_flow->get_check_buttons_settings_aref();

		# remove quotes upon input
		$color_flow_href->{_values_aref} =
			$control->get_no_quotes4array( $color_flow_href->{_values_aref} );

		# add single quotes upon input only to strings
		$color_flow_href->{_values_aref} =
			$control->get_string_or_number4array( $color_flow_href->{_values_aref} );

		# my $names = scalar @{$color_flow_href->{_names_aref}};
		$perl_flow->set_prog_index($prog_idx);
		my $number_of_values = scalar @{ $color_flow_href->{_values_aref} };

		$color_flow_href->{_param_sunix_length} = $perl_flow->get_param_sunix_length();

		# int("1. color_flow,perl_flow, length = $number_of_values\n");
		# int("2. color_flow,perl_flow, length = $color_flow_href->{_param_sunix_length} \n");

		# Populate GUI with the parameter values and labels of the first item
		# _add2flow will call _flow_select to select the last flow item loaded
		# _flow select marks the gui history and calls
		# flow_select which will detect any parameter changes
		# and will store
		# upload variables into the param_flow for each program
		_add2flow();

	}

	_flow_select_director('_perl_flow');

	return ();
}

=head2 sub _set_flow_color


=cut 

sub _set_flow_color {
	my ($flow_color) = @_;

	if ($flow_color) {

		$color_flow_href->{_flow_color} = $flow_color;

	}
	else {
		print("color_flow, set_flow_color, missing color\n");
	}
	return ();
}

=head2 sub _local_set_flow_listbox_color_w


=cut 

sub _local_set_flow_listbox_color_w {
	my ($flow_color) = @_;

	if ( $flow_color eq $this_color ) {

		$color_flow_href->{_flow_listbox_color_w} = $color_flow_href->{_flow_listbox_grey_w};

	}
	else {
		print("color_flow,_local_set_flow_listbox_color_w, _local_set_flow_listbox_color_w, missing color\n");
	}

	return ();
}

=head2 sub _set_flow_name_color_w

=cut

sub _set_flow_name_color_w {
	my ($flow_color) = @_;

	if ( $flow_color eq $this_color ) {

		$flow_name_color_w = $color_flow_href->{_flow_name_grey_w};

		#do not export
		$flow_name_color_w = $color_flow_href->{_flow_name_grey_w};

	}
	else {
		print("color_flow,_set_flow_name_color_w, _set_flow_name_color_w, missing color \n");
	}

	return ();
}

=head2 sub _set_flowNsuperflow_name_w

	displays superflow name at top of gui
	
=cut

sub _set_flowNsuperflow_name_w {
	my ($flowNsuperflow_name) = @_;

	if ( $flowNsuperflow_name && $color_flow_href->{_flowNsuperflow_name_w} ) {

		( $color_flow_href->{_flowNsuperflow_name_w} )->configure( -text => $flowNsuperflow_name, );
	}
	else {
		print("color_flow, set_flowNsuperflow_name_w, missing widget or program name\n");
	}

	return ();
}

#=head2 sub  _set_is_last_parameter_index_touched_color
#
#=cut
#
#	sub _set_is_last_parameter_index_touched_color {
#		my ($flow_color) = @_;
#
#		if ( $flow_color eq $this_color ) {
#
#			# not for export
#			$color_flow_href->{_is_last_parameter_index_touched_color} = $color_flow_href->{_is_last_parameter_index_touched_grey};
#
#			print("color_flow,_set_is_last_parameter_index_touched_color, is_last_parameter_index_touched_grey: $color_flow_href->{_is_last_parameter_index_touched_grey}\n");
#
#		}
#		else {
#			print("color_flow,_set_is_last_parameter_index_touched_color, missing color \n");
#		}
#
#		return ();
#	}
#
#=head2 sub  _set_last_parameter_index_touched_color
#
#=cut
#
#	sub _set_last_parameter_index_touched_color {
#		my ($flow_color) = @_;
#
#		if ( $flow_color eq $this_color ) {
#
#			# not for export
#			$color_flow_href->{_last_parameter_index_touched_color} = $color_flow_href->{_last_parameter_index_touched_grey};
#
#			print("color_flow,_set_last_parameter_index_touched_color, last_parameter_index_touched_grey: $color_flow_href->{_last_parameter_index_touched_grey}\n");
#
#		}
#		else {
#			print("color_flow,_set_last_parameter_index_touched_color, , missing color \n");
#		}
#
#		return ();
#	}

=head2 sub _set_user_built_flow_name_w

 place and show the user-built flow name

=cut

sub _set_user_built_flow_name_w {
	my ($user_built_flow_name) = @_;

	if ($user_built_flow_name) {

		if ($flow_name_color_w) {

			# do not export
			$flow_name_color_w = $flow_name_color_w;

			# display name in widget
			$flow_name_color_w->configure( -text => $user_built_flow_name, );

		}
		elsif ( not $flow_name_color_w ) {

			_set_flow_name_color_w($flow_color);

			# do not export
			$flow_name_color_w = $flow_name_color_w;

			# display name in widget
			$flow_name_color_w->configure( -text => $user_built_flow_name, );

		}
		else {
			print("color_flow, set_user_built_flow_name_w, missing flow_name_color_w \n");
		}
	}
	else {
		print("color_flow, set_user_built_flow_name_w, missing program name\n");
	}

	return ();
}

=head2 sub _stack_flow

  store an initial version of the parameters in a 
  namespace different to the one belonging to param_widgets 
  
  The initial version comes from default parameter files
  i.e., the same code as for sunix_select
 
  
=cut

sub _stack_flow {
	my ($self) = @_;
	use control;

	my $control = control->new();

	# my $num_items = $param_flow_color_pkg->get_num_items();
	# print("color_flow,_stack_flow, data before stack num_items=$num_items\n");

	# $param_flow_color_pkg->view_data();

	$param_flow_color_pkg->stack_flow_item( $color_flow_href->{_prog_name_sref} );

	$param_flow_color_pkg->stack_names_aref2( $color_flow_href->{_names_aref} );

	# restore strings to have terminal strings
	# remove quotes upon input
	$color_flow_href->{_values_aref} = $control->get_no_quotes4array( $color_flow_href->{_values_aref} );

	# in case parameter values have been displayed stringless
	$color_flow_href->{_values_aref} = $control->get_string_or_number4array( $color_flow_href->{_values_aref} );

	$param_flow_color_pkg->stack_values_aref2( $color_flow_href->{_values_aref} );

	$param_flow_color_pkg->stack_checkbuttons_aref2( $color_flow_href->{_check_buttons_settings_aref} );

	# $num_items = $param_flow_color_pkg->get_num_items();
	# print("color_flow,_stack_flow, data after stack num_items=$num_items\n");
	# $param_flow_color_pkg->view_data();

	return ();
}

=head2 sub _stack_versions 

   Collect and store latest program versions from changed list 
   
   Will update listbox variables inside flow_widgets.pm
   Therefore pop is not needed on the array
   Use after data have been stored, deleted, or 
   suffered an insertion event

=cut

sub _stack_versions {

	my $_flow_listbox_color_w = _get_flow_listbox_color_w();

	$flow_widgets->set_flow_items($_flow_listbox_color_w);
	$color_flow_href->{_items_versions_aref} = $flow_widgets->items_versions_aref;
	$param_flow_color_pkg->set_flow_items_version_aref( $color_flow_href->{_items_versions_aref} );

}

=head2  _update_most_recent_param_flow2

	used to update prior parameter flows
	only when add2flow_button is used

	# print("color flow,start _update_most_recent_param_flow2  starting \n");
	# print("6start \n");
	# $param_flow_color_pkg->view_data();

			#			print("color flow,start _update_most_recent_param_flow2 most_recent_flow_index_touched=$storage_flow_index \n");
			#			print("7start \n");
			#			$param_flow_color_pkg->view_data();		

			# print("8start \n");
			# $param_flow_color_pkg->view_data();

			# print("6 value0  = @{$color_flow_href->{_values_aref}}[0]\n");
			# print("6 value1 = @{$color_flow_href->{_values_aref}}[1]\n");         	


			#print("8.1start \n");
			#$param_flow_color_pkg->view_data();

			# print("7 all value0  = @{$color_flow_href->{_values_aref}}[0]\n");
			# print("7 all value1 = @{$color_flow_href->{_values_aref}}[1]\n");

			# print("7 all label0  = @{$color_flow_href->{_names_aref}}[0]\n");
			# print("7 all label1 = @{$color_flow_href->{_names_aref}}[1]\n");
			#			print("9start \n");
			#			$param_flow_color_pkg->view_data();

			# print("9 storage index = $storage_flow_index \n");


			#						print("\n10 end\n");
			#			$param_flow_color_pkg->view_data();
=cut 

sub _update_most_recent_param_flow2 {

	my ($self) = @_;
	use control;
	my $control = control->new();

	# $gui_history->view();

	my $prior_flow_index_touched       = ( $color_flow_href->{_flow_select_index_href} )->{_prior};
	my $most_recent_flow_index_touched = ( $color_flow_href->{_flow_select_index_href} )->{_most_recent};

	#following two valuesa are empty until a second program is placed in the flow
	my $last_parameter_index_on_entry      = ( $color_flow_href->{_parameter_index_on_entry_click_seq_href} )->{_most_recent};
	my $last_parameter_index_touched_color = ( $color_flow_href->{_parameter_index_on_exit_click_seq_href} )->{_most_recent};

	my $prior_flow_color       = ( $color_flow_href->{_flow_select_color_href} )->{_prior};
	my $most_recent_flow_color = ( $color_flow_href->{_flow_select_color_href} )->{_most_recent};

	my $storage_flow_index = $most_recent_flow_index_touched;

	if (   $most_recent_flow_index_touched >= 0
		or $last_parameter_index_touched_color >= 0 )
	{
		# prior flow must have the same color as the current one or
		# we have just clicked an sunix program (neutral-flow case)
		if (   $prior_flow_color eq 'neutral'
			or $prior_flow_color eq $most_recent_flow_color )
		{

			# the checkbuttons, values and names of ONLY the last program used
			# are stored in param_widgets at any ONE time
			$color_flow_href->{_values_aref} = $param_widgets->get_values_aref();

			# restore terminal ticks in strings after reading from the GUI
			# remove  possible terminal strings
			$color_flow_href->{_values_aref} = $control->get_no_quotes4array( $color_flow_href->{_values_aref} );

			# in case parameter values have been displayed stringless
			$color_flow_href->{_values_aref} = $control->get_string_or_number4array( $color_flow_href->{_values_aref} );

			$color_flow_href->{_names_aref}                  = $param_widgets->get_labels_aref();
			$color_flow_href->{_check_buttons_settings_aref} = $param_widgets->get_check_buttons_aref();

			$param_flow_color_pkg->set_flow_index($storage_flow_index);

			# The following 3 lines save old changed values and names but not the versions
			$param_flow_color_pkg->set_values_aref( $color_flow_href->{_values_aref} );
			$param_flow_color_pkg->set_names_aref( $color_flow_href->{_names_aref} );
			$param_flow_color_pkg->set_check_buttons_settings_aref( $color_flow_href->{_check_buttons_settings_aref} );

			$param_widgets->set_entry_change_status($false);    # changes are now complete, needwd??
			$color_flow_href->{_last_flow_color} = $color_flow_href->{_flow_color};

			# print("color flow,leaving _update_most_recent_param_flow2 \n");
			# $param_flow_color_pkg->view_data();

		}
		else {
			#NADA
		}
	}
	else {
	}

	return ();
}

=head2  _update_prior_param_flow

	Updates the values for parameters stored via param_flow
	param-flow takes uses parameters from param_widgets
	BUT param_widgets needs to have been updated by _update_most_recent_flow? or 
	user changes on the screen will not chave been updated

	Apply every time that a flow item is selected 
	1. Assume that selection of a flow item implies pre-existing parameter values were changed/added
	
	2. Opening a file dialog assumes parameter values were also changed (Entry widget) 
	-- this means that a prior program must have been touched and that the color must change 
	from either neutral to the current color or be overwritten by the same color
		 
	Exceptions include the 
	(1) case when you have just left a flow of a different color 
	and are returning to previous settings.
	(2) case when you are using the first item in a flow for the first time, i.e. it has never been
	used before
	
	Find out the previous color, then ... there are
	2 possible CASES
		 CASE 1
		 The current color is the same as the previously touched color
		 i.e., if the last color-flow box touched was of the current flow color
		 i.e., consider situation when we are still using the same colored list box
		 
		 in which case...		
		 1. Find out which index was touched in "color"-flow box
		 2. Find out which program was previously touched
		 3. Assume the touched program had its parameter values modified
		 4. Update all the previously touched program's values in storage via param_flow
		 
		 CASE 2
		 If the current color is different to the previously touched color, then 		
		 2. ELIMINATE all the previous changes
  		 print("2. color_flow flow_select, param_flow_view_data:\n");
  		 $param_flow_color_pkg->view_data();
  		 
  		 
  	Clicking Save will activate _update_prior_param_flow.  
  			Before Save is clicked:
  			 the 
  			_last_parameter_index_touched_color = 0
         	_last_flow_index_touched 			= -1
         	_last_flow_color 					= current flow color
 
 
			# print("1. color_flow, _update_prior_param_flow, start\n");
			# $param_flow_color_pkg->view_data();

			# print("2 NEW color_flow _update_prior_param_flow, most_recent_flow_index-touched ($this_color) is:  $most_recent_flow_index_touched \n");
			# print("2 NEW color_flow _update_prior_param_flow, prior_flow_index-touched ($this_color) is:  $prior_flow_index_touched \n");
			# print("OLD color_flow update_prior_param_flow,store changes in param_flow, storage_flow_index: $storage_flow_index\n");
			# print("OLD color_flow update_prior_param_flow,store changes in param_flow, last changed flow index $color_flow_href->{_last_flow_index_touched}\n");

			# print("2. color_flow, _update_prior_param_flow, print gui_history.txt\n");
			# $gui_history->view();
 
 
	#	print("1 OLD olor_flow _update_prior_param_flow, last_flow_color is:  $color_flow_href->{_last_flow_color} \n");
	#	print("1 OLD color_flow _update_prior_param_flow, current flow_color is:  $color_flow_href->{_flow_color} \n");
	#	print("1 OLD color_flow _update_prior_param_flow, _last_parameter_index_touched_color ($this_color) is:  $color_flow_href->{_last_parameter_index_touched_color} \n");
	#	print("1 OLD color_flow _update_prior_param_flow, _last_flow_index_touched is:  $color_flow_href->{_last_flow_index_touched} \n");
	# print("color_flow _update_prior_param_flow,print gui history.txt\n");
	# $gui_history->view();
	

	#	print("2 color_flow _update_prior_param_flow, last_parameter_index_touched_color ($this_color) is:  $last_parameter_index_touched_color \n");
	#	print("2 color_flow _update_prior_param_flow, last_parameter_index_on entry ($this_color) is:  $last_parameter_index_on_entry \n");

	#	print("1. color_flow, _update_prior_param_flow, print gui_history.txt\n");
	#	$gui_history->view();


			# print("2. color_flow, update_prior_param_flow, prior labels:--@{$color_flow_href->{_names_aref}}--\n");
			# print("2. color_flow, update_prior_param_flow, prior values:--@{$color_flow_href->{_values_aref}}--\n");
			# OLD
			# $param_flow_color_pkg->set_flow_index( $color_flow_href->{_last_flow_index_touched} );


			# print("color_flow, _update_prior_param_flow, after saving values\n");
			#$param_flow_color_pkg->view_data();	
         	
=cut 

sub _update_prior_param_flow {

	my ($self) = @_;
	use control;

	my $control = control->new();

	my $prior_flow_index_touched       = ( $color_flow_href->{_flow_select_index_href} )->{_prior};
	my $most_recent_flow_index_touched = ( $color_flow_href->{_flow_select_index_href} )->{_most_recent};

	#following two valuesa are empty until a second program is placed in the flow
	my $last_parameter_index_on_entry      = ( $color_flow_href->{_parameter_index_on_entry_click_seq_href} )->{_most_recent};
	my $last_parameter_index_touched_color = ( $color_flow_href->{_parameter_index_on_exit_click_seq_href} )->{_most_recent};

	my $prior_flow_color       = ( $color_flow_href->{_flow_select_color_href} )->{_prior};
	my $most_recent_flow_color = ( $color_flow_href->{_flow_select_color_href} )->{_most_recent};

	my $storage_flow_index = $prior_flow_index_touched;

	if (   $most_recent_flow_index_touched >= 0
		or $last_parameter_index_touched_color >= 0 )
	{
		# prior flow must have the same color as the current one or
		# we have just clicked an sunix program (neutral-flow case)
		if (   $prior_flow_color eq 'neutral'
			or $prior_flow_color eq $most_recent_flow_color )
		{

			# the checkbuttons, values and names of ONLY the last program used
			# are stored in param_widgets at any ONE time
			$color_flow_href->{_values_aref} = $param_widgets->get_values_aref();

			# restore terminal ticks in strings after reading from the GUI
			# remove  possible terminal strings
			$color_flow_href->{_values_aref} = $control->get_no_quotes4array( $color_flow_href->{_values_aref} );

			# correct parameter values that have been displayed stringless
			$color_flow_href->{_values_aref} = $control->get_string_or_number4array( $color_flow_href->{_values_aref} );

			$color_flow_href->{_names_aref}                  = $param_widgets->get_labels_aref();
			$color_flow_href->{_check_buttons_settings_aref} = $param_widgets->get_check_buttons_aref();

			$param_flow_color_pkg->set_flow_index($storage_flow_index);

			# The following 3 lines save old changed values and names but not the versions
			$param_flow_color_pkg->set_values_aref( $color_flow_href->{_values_aref} );
			$param_flow_color_pkg->set_names_aref( $color_flow_href->{_names_aref} );
			$param_flow_color_pkg->set_check_buttons_settings_aref( $color_flow_href->{_check_buttons_settings_aref} );

			$param_widgets->set_entry_change_status($false);    # changes are now complete, needwd??
			$color_flow_href->{_last_flow_color} = $color_flow_href->{_flow_color};

			# print("color flow,leaving _update_prior_param_flow \n");
			# $param_flow_color_pkg->view_data();

		}
		else {
			#NADA
		}
	}
	else {
	}

	return ();
}

#=head2  _update_onlyvalues4most_recent_param_flow
#
#	No change to flow selection but save flow parameters to param_flow anyway
#
#	Assume that the program of interest within an active flow stays the same
#	But, assume that a parameter within a fixed program has changed so that
#	the stored parameters for that program need to be updated.
#	that is, param_flow will update the stored parameters for a member of the flow
#	without having to change with which flow item/program we interact.
#
#	N.B. The checkbuttons, values and names of only the present program in use
#  	are stored in param_widgets at any one time
#
#  	For example, after selecting  a data file name, the file name is automatically inserted
#  	into the GUI. Following, we update the data file name into the stored parameters via param_flow
#
#  	Required: the current flow item number and the current parameter index in use
#
#=cut
#
#sub _update_only_values4most_recent_param_flow {
#	my ($self) = @_;
#	my $storage_flow_index 		= 0;
#
#	$color_flow_href->{_values_aref}  = $param_widgets->get_values_aref();
#
#
#	# save current values and names
#			$param_flow_color_pkg->set_values_aref( $color_flow_href->{_values_aref} );                                    # but not the versions
#
#			$param_widgets->set_entry_change_status($false);                                                               # changes are now complete
#
#
#	return ();
#}

=head2  _update_most_recent_param_flow
	
	No change to flow selection but save flow parameters to param_flow anyway
	 
	Assume that the program of interest within an active flow stays the same
	But, assume that a parameter within a fixed program has changed so that
	the stored parameters for that program need to be updated.
	that is, param_flow will update the stored parameters for a member of the flow
	without having to change with which flow item/program we interact.
	
	N.B. The checkbuttons, values and names of only the present program in use 
  	are stored in param_widgets at any one time
  	
  	For example, after selecting  a data file name, the file name is automatically inserted
  	into the GUI. Following, we update the data file name into the stored parameters via param_flow
  	
  	Required: the current flow item number and the current parameter index in use
	   
=cut 

sub _update_most_recent_param_flow {
	my ($self) = @_;
	use control;
	my $control = control->new();

	# N.B., {_last_parameter_index_touched_color} < 0
	# does exist and means the parameters are untouched

	my $prior_flow_index_touched       = ( $color_flow_href->{_flow_select_index_href} )->{_prior};
	my $most_recent_flow_index_touched = ( $color_flow_href->{_flow_select_index_href} )->{_most_recent};

	#following two valuesa are empty until a second program is placed in the flow
	my $last_parameter_index_on_entry      = ( $color_flow_href->{_parameter_index_on_entry_click_seq_href} )->{_most_recent};
	my $last_parameter_index_touched_color = ( $color_flow_href->{_parameter_index_on_exit_click_seq_href} )->{_most_recent};

	my $prior_flow_color       = ( $color_flow_href->{_flow_select_color_href} )->{_prior};
	my $most_recent_flow_color = ( $color_flow_href->{_flow_select_color_href} )->{_most_recent};

	my $storage_flow_index = $most_recent_flow_index_touched;

	#	if ( $color_flow_href->{_last_parameter_index_touched_color} >= 0 ) {
	if ( $last_parameter_index_touched_color >= 0 ) {

		# print("color_flow _update_most_recent_param_flow,last changed entry index was $last_parameter_index_touched_color \n");
		# print("color_flow _update_most_recent_param_flow current program name in use: ${$color_flow_href->{_prog_name_sref}}\n");
		# print("2. color_flow, _update_most_recent_param_flow, print gui_history.txt\n");
		# $gui_history->view();
		# Update ONLY the names and check_buttons again, reading in from the gui (param_widgets), just in case
		$color_flow_href->{_names_aref}                  = $param_widgets->get_labels_aref();
		$color_flow_href->{_check_buttons_settings_aref} = $param_widgets->get_check_buttons_aref();

		# restore terminal ticks in strings after reading from the GUI
		# remove  possible terminal strings
		$color_flow_href->{_values_aref} = $control->get_no_quotes4array( $color_flow_href->{_values_aref} );

		#print("8.1start \n");
		#$param_flow_color_pkg->view_data();
		# in case parameter values have been displayed stringless
		$color_flow_href->{_values_aref} = $control->get_string_or_number4array( $color_flow_href->{_values_aref} );

		# $color_flow_href->{_values_aref}					= $param_flow_color_pkg ->get_values_aref();

		# For flow item index of the program in the color-flow listbox that is currently being used,
		# i.e., not the index of the last-used program
		# user-built_flow in current use
		my $_flow_listbox_color_w = _get_flow_listbox_color_w();

		# my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);
		# print("2. OLD color_flow, _update_most_recent_param_flow,current_flow_listbox_index=$current_flow_listbox_index\n");
		# print("2. NEW color_flow, _update_most_recent_param_flow,current_flow_listbox_index=$most_recent_flow_index_touched \n");
		# print("2. NEW color_flow, _update_most_recent_param_flow,pior_flow_listbox_index=$prior_flow_index_touched \n");
		# if ( $current_flow_listbox_index >= 0 ) {    # >=0 11-14-2018 JML

		if ( $storage_flow_index >= 0 ) {    # >=0 10-30-2019 JML
			                                 # select an item from which to extract data
			                                 # old $param_flow_color_pkg->set_flow_index($current_flow_listbox_index);

			$param_flow_color_pkg->set_flow_index($storage_flow_index);

			# save current values and names
			$param_flow_color_pkg->set_values_aref( $color_flow_href->{_values_aref} );                                    # but not the versions
			$param_flow_color_pkg->set_names_aref( $color_flow_href->{_names_aref} );                                      # but not the versions
			$param_flow_color_pkg->set_check_buttons_settings_aref( $color_flow_href->{_check_buttons_settings_aref} );    # BUT not the versions

			$param_widgets->set_entry_change_status($false);                                                               # changes are now complete

			# when last_parameter_index_touched goes back to -1 (default)
			# this subroutine may not be used later
			$color_flow_href->{_last_parameter_index_touched_color} = -1;

			#old $color_flow_href->{_last_flow_index_touched}            = $current_flow_listbox_index;    # for next time
			$color_flow_href->{_last_flow_index_touched} = $storage_flow_index;    # for next time

			$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

			# print("2. color_flow, _update_most_recent_param_flow, last_flow_index_touched $color_flow_href->{_last_flow_index_touched}\n");
			# $param_flow_color_pkg->view_data();

		}
		else {

			# Look for the last flow index that was touched
			# old			my $last_idx_chng = $color_flow_href->{_last_flow_index_touched};
			my $last_idx_chng = $storage_flow_index;
			$param_flow_color_pkg->set_flow_index($last_idx_chng);

			# save current values and names
			$param_flow_color_pkg->set_values_aref( $color_flow_href->{_values_aref} );                                    # but not the versions
			$param_flow_color_pkg->set_names_aref( $color_flow_href->{_names_aref} );                                      # but not the versions
			$param_flow_color_pkg->set_check_buttons_settings_aref( $color_flow_href->{_check_buttons_settings_aref} );    # BUT not the versions

			# changes are now complete
			$param_widgets->set_entry_change_status($false);

			# if reinitialize last_parameter_index_touched goes back to -1 (default)
			# then this subroutine may not be used
			$color_flow_href->{_last_parameter_index_touched_color} = -1;
			$color_flow_href->{_last_flow_index_touched}            = $last_idx_chng;    # for next time
			$color_flow_href->{_is_last_flow_index_touched_grey}    = $true;

			# print("End of $this_color _check4parameterchanges: _last_parameter_index_touched reset: $color_flow_href->{_last_parameter_index_touched_color}\n");

		}

	}
	else {
	}

	return ();
}

=head2

	FileDialog_button: handles Data, SaveAs and (perl) Flow (in) is 
  	
  			 	 foreach my $key (sort keys %$color_flow_href) {
   			print (" color_flowkey is $key, value is $color_flow_href->{$key}\n");
  		}
  		dialog type (option_sref)  can be:
  			Data, 
  			Flow (open an exisiting user-built flow, but not a pre-built
  				superflow), or
  			SaveAs
  				my $uBF      	= $file_dialog->get_hash_ref(); #TODO but some variables will not get Xferred
		foreach my $key (sort keys %$uBF) {
   			print (" color_flowkey is $key, value is $uBF->{$key}\n");
  		}
  		
  	
=cut 

sub FileDialog_button {

	my ( $self, $dialog_type_sref ) = @_;
	use file_dialog;
	use L_SU_global_constants;

	use manage_files_by2;
	use Project_config;
	use control;

	my $file_dialog = file_dialog->new();
	my $get         = L_SU_global_constants->new();

	my $file_dialog_type = $get->file_dialog_type_href();
	my $Project          = Project_config->new();
	my $control          = control->new();

	my $PL_SEISMIC = $Project->PL_SEISMIC();

	# may provide values from the current widget if it is used
	# can also be (1) a previous pre-built superflow that is already in the GUI
	# (2) empty if program is just starting

	if ($dialog_type_sref) {

		$color_flow_href->{_dialog_type} = $$dialog_type_sref;    # dereference scalar
		my $topic = $color_flow_href->{_dialog_type};

		# ONLY for SaveAs
		# i.e., in this module, dialog_type_sref can only be SaveAs

		# Save for 'user-built flows' is accessible via L_SU.pm
		if ( $topic eq $file_dialog_type->{_SaveAs} ) {

			$color_flow_href->{_values_aref} = $param_widgets->get_values_aref();

			# restore strings to have terminal strings
			# remove quotes upon input
			$color_flow_href->{_values_aref} =
				$control->get_no_quotes4array( $color_flow_href->{_values_aref} );

			# in case parameter values have been displayed stringless
			$color_flow_href->{_values_aref} = $control->get_string_or_number4array( $color_flow_href->{_values_aref} );

			$color_flow_href->{_dialog_type} = $$dialog_type_sref;    # dereference scalar

			$file_dialog->set_flow_color( $color_flow_href->{_flow_color} );
			$file_dialog->set_hash_ref($color_flow_href);
			$file_dialog->set_gui_widgets($color_flow_href);

			# $file_dialog	->set_flow_type('user_built'); not needed beacuase file_dialog accounts for SaveAs
			$file_dialog->FileDialog_director();

			# assume that while selecting a data file to open in file-dialog that the
			# GUI has been updated (not very elegant... TODO
			# see if the last index has been touched

			$color_flow_href->{_has_used_SaveAs_button} = $true;

			# new file name will generate a case that an index has been touched
			$color_flow_href->{_last_parameter_index_touched_color} = $file_dialog->get_last_parameter_index_touched_color();

			# print ("1. color_flow,FileDialog_button,_last_parameter_index_touched_color:$color_flow_href->{_last_parameter_index_touched_color} \n");
			# print ("1. color_flow,FileDialog_button, color: $flow_color \n");
			$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;

			# print("color_flow,FileDialog_button,_is_flow_listbox_grey_w:	$color_flow_href->{_is_flow_listbox_grey_w}\n");
			_update_most_recent_param_flow();

			use messages::message_director;
			my $color_flow_messages = message_director->new();

			$color_flow_href->{_flow_name_out} = file_dialog->get_perl_flow_name_out();
			$color_flow_href->{_path}          = file_dialog->get_file_path();

			# consider empty case, for which saving is not possible
			if (   !( $color_flow_href->{_flow_name_out} )
				|| $color_flow_href->{_flow_name_out} eq ''
				|| !( $color_flow_href->{_path} )
				|| $color_flow_href->{_path} eq '' )
			{

				my $message = $color_flow_messages->save_button(1);
				$message_w->delete( "1.0", 'end' );
				$message_w->insert( 'end', $message );

			}
			else {    # Good,  NON-EMPTY case

				# displays user-built flow name at top of grey-flow gui
				_set_flowNsuperflow_name_w( $color_flow_href->{_flow_name_out} );
				_set_user_built_flow_name_w( $color_flow_href->{_flow_name_out} );

				# go save perl flow file
				_SaveAs_button($topic);

				# restore message at the bottom of the string to blank if not already so
				# messages
				my $message = $color_flow_messages->null_button(0);
				$message_w->delete( "1.0", 'end' );
				$message_w->insert( 'end', $message );

			}    # Ends SaveAs option

		}
		elsif ( $topic eq $file_dialog_type->{_Flow} ) {

			# Read perl flow file
			# Write name to the file name in the appropriate flow
			# populate GUI
			# populate hashes (color_flow)and memory spaces (param_flow)
			$file_dialog->set_flow_color( $color_flow_href->{_flow_color} );
			$file_dialog->set_hash_ref($color_flow_href);    # uses values_aref
			$file_dialog->set_gui_widgets($color_flow_href);
			$file_dialog->set_flow_type('user_built');

			$file_dialog->FileDialog_director();

			$color_flow_href->{_flow_name_in} = $file_dialog->get_perl_flow_name_in();

			$color_flow_href->{_flow_name_out}                  = $color_flow_href->{_flow_name_in};
			$color_flow_href->{_has_used_open_perl_file_button} = $true;

			_set_flow_name_color_w($flow_color);

			# Is $flow_name_in empty
			my $file2query = $PL_SEISMIC . '/' . $color_flow_href->{_flow_name_in};

			my $file_exists = manage_files_by2::does_file_exist_sref( \$file2query );

			if ($file_exists) {

				# Place names of the programs at the head of the grey listbox
				$flow_name_color_w->configure( -text => $color_flow_href->{_flow_name_in} );

				# Place names of the programs at the head of the GUI
				$color_flow_href->{_flowNsuperflow_name_w}->configure( -text => $color_flow_href->{_flow_name_in} );

				# populate gui, and bot param_flow and param_widgets namespaces
				_perl_flow();

			}
			else {
				print("3 color_flow,FileDialog_button, Warning: missing file NADA \n");
			}

			# print("3 color_flow,FileDialog_button,_is_flow_listbox_grey_w:	$color_flow_href->{_is_flow_listbox_grey_w}\n");

		}
		elsif ( $topic eq $file_dialog_type->{_Data} ) {

			# print("color_flowFileDialog_button,option_sref $topic\n");

			# assume that after selection to open of a data file in file-dialog the
			# GUI has been updated
			# See if the last parameter index has been touched (>= 0)
			# Assume we are still dealing with the current flow item selected
			$color_flow_href->{_last_parameter_index_touched_color}   = $file_dialog->get_last_parameter_index_touched_color();
			$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;

			# set the current listbox as the last color listbox
			$color_flow_href->{_last_flow_listbox_color_w} = $color_flow_href->{_flow_listbox_color_w};

			# provide values in the current widget
			$color_flow_href->{_values_aref} = $param_widgets->get_values_aref();

			# restore terminal ticks to strings

			# restore strings to have terminal strings
			# remove quotes upon input
			$color_flow_href->{_values_aref} =
				$control->get_no_quotes4array( $color_flow_href->{_values_aref} );

			# in case parameter values have been displayed stringless
			$color_flow_href->{_values_aref} = $control->get_string_or_number4array( $color_flow_href->{_values_aref} );

			#			print(
			#				"color_flow,_FileDialog_button(binding), flow_listbox_color_w: $color_flow_href->{_flow_listbox_color_w} \n"
			#			);
			$file_dialog->set_flow_color( $color_flow_href->{_flow_color} );    # uses 1/ 31 in
			$file_dialog->set_hash_ref($color_flow_href);                       # uses 86/ 114 in  ; uses values_aref
			$file_dialog->set_gui_widgets($color_flow_href);                    # uses 34/ 114 in
			$file_dialog->FileDialog_director();

			#			print(
			#				"color_flow,_FileDialog_button(binding), last_parameter_index_touched_color: $color_flow_href->{_last_parameter_index_touched_color} \n"
			#			);

			# in case _check4changes does not run make sure to use the following line
			# update to parameter values occurs in file_dialog
			$color_flow_href->{_values_aref} = $file_dialog->get_values_aref();

			# set up this flow listbox item as the last item touched
			my $_flow_listbox_color_w      = _get_flow_listbox_color_w();                                 # user-built_flow in current use
			my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);
			$color_flow_href->{_last_flow_index_touched}         = $current_flow_listbox_index;           # for next time
			$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

			# print("color_flow,FileDialog_button(binding), last_flow_index_touched:$color_flow_href->{_last_flow_index_touched} \n");

			# Changes made with another instance of param_widgets (in file_dialog) will require
			# that we also update the namespace of the current param_flow
			# We make this change inside _update_most_recent_param_flow
			_update_most_recent_param_flow();

		}
		else {
			print("1. color_flow, FileDialog_button, missing topic \n");

			# Ends opt_ref
		}
	}
	else {
		print("color_flow,FileDialog_button ,option type missing\ n");
	}

	return ();
}

=head2 sub add2flow_button

	When build a first-time perl flow
	Incorporate new prorgam parameter values and labels into the gui
	and save the values, labels and checkbuttons setting in the param_flow
	namespace

  		foreach my $key (sort keys %$color_flow_href) {
   			print (" color_flow key is $key, value is $color_flow_href->{$key}\n");
  		}
  		
 print("3. color_flow, add2flow_button,color_flow_href->{_log_view} = $ans\n");

	$ans= $color_flow_href->{_param_sunix_length};
	print("1b. color_flow, add2flow_button, _param_sunix_length= $ans\n");



=cut

sub add2flow_button {

	my ( $self, $value ) = @_;

	#	$color_flow_href->{_names_aref} = $param_widgets->get_labels_aref();
	#	print("start add2flow_button all label0  = @{$color_flow_href->{_names_aref}}[0]\n");
	#	print("start add2flow_buttonall label1  = @{$color_flow_href->{_names_aref}}[1]\n");
	#	$color_flow_href->{_values_aref} = $param_widgets->get_values_aref();
	#	print("start add2flow_buttonall value0  = @{$color_flow_href->{_values_aref}}[0]\n");
	#	print("start add2flow_buttonall value1  = @{$color_flow_href->{_values_aref}}[1]\n");

	# There is a case when a flow is used for the first time,
	# a parameter value has been added or
	# modified and the flow item
	# is not selected manually after a change (select_flow_button)
	# If a previous flow item has not been updated (having checked for changes to the parameter values)
	# we must force an update to save parameter values
	# by using _flow_select which calls flow_select.
	# We are coming from selecting an sunix program
	# so the flow listbox has been cleared of selections
	# The last flow listbox selectin was stored in the gui history
	# We can not set flow_select button index
	# fWe will increment the number of clicks
	# (TODO) and that you have not changed color
	my $_flow_listbox_color_w = _get_flow_listbox_color_w();
	my $flow_num_items        = $_flow_listbox_color_w->size();

	$color_flow_href->{_flow_type} = $flow_type->{_user_built};

	#	if ( $flow_num_items == 1 ) {
	#
	#		print("color_flow,add2flow_button, num items=1\n");
	#
	#		#		print("1. color_flow,add2flow_button, view stored data before updating\n");
	#		#	    $param_flow_color_pkg->view_data();
	#		$gui_history->set_button('flow_select');
	#
	#		print("\n2. color_flow,add2flow_button, view stored data before updating\n");
	#		$param_flow_color_pkg->view_data();
	#		_update_only_values4most_recent_param_flow();
	#
	#		print("\n3. color_flow,add2flow_button, view stored data after updating\n");
	#		$param_flow_color_pkg->view_data();
	#
	#		# print(" color_flow, add2flow_button, print gui_history.txt\n");
	#		# $gui_history->view();
	#
	#	}

	use messages::message_director;
	use param_sunix;

	my $param_sunix         = param_sunix->new();
	my $color_flow_messages = message_director->new();
	my $message             = $color_flow_messages->null_button(0);

	$gui_history->set_hash_ref($color_flow_href);
	$gui_history->set4start_of_add2flow_button($flow_color);
	$color_flow_href = $gui_history->get_hash_ref();

	# print("00. color_flow,add2flow_button\n");
	# $param_flow_color_pkg->view_data();

	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# add the most recently selected program
	# name (scalar reference) to the
	# end of the list indside flow_listbox
	_local_set_flow_listbox_color_w($flow_color);    # in "color"_flow namespace

	# append new program names to the end of the list but this item is NOT selected
	# selection occurs inside conditions_gui
	$color_flow_href->{_flow_listbox_color_w}->insert( "end", ${ $color_flow_href->{_prog_name_sref} }, );

	# display default paramters in the GUI
	# same as for sunix_select
	# can not get program name from the item selected in the sunix list box
	# because focus is transferred to another list box

	$param_sunix->set_program_name( $color_flow_href->{_prog_name_sref} );
	$color_flow_href->{_names_aref}                  = $param_sunix->get_names();
	$color_flow_href->{_values_aref}                 = $param_sunix->get_values();
	$color_flow_href->{_check_buttons_settings_aref} = $param_sunix->get_check_buttons_settings();
	$color_flow_href->{_param_sunix_first_idx}       = $param_sunix->first_idx();                    # first index = 0
	$color_flow_href->{_first_idx}                   = $param_sunix->first_idx();                    # first index = 0

	$param_sunix->set_half_length();

	# values not #(values+labels)
	$color_flow_href->{_param_sunix_length} = $param_sunix->get_length();

	# widgets are initialized in a super class
	# Assign program parameters in the GUI
	# no. of parameters defaults to max=61
	$param_widgets->set_labels_w_aref( $color_flow_href->{_labels_w_aref} );
	$param_widgets->set_values_w_aref( $color_flow_href->{_values_w_aref} );
	$param_widgets->set_check_buttons_w_aref( $color_flow_href->{_check_buttons_w_aref} );

	# print(" 1. color_flow, add2flow_button, \n");
	$param_widgets->range($color_flow_href);
	$param_widgets->set_labels( $color_flow_href->{_names_aref} );
	$param_widgets->set_values( $color_flow_href->{_values_aref} );
	$param_widgets->set_check_buttons( $color_flow_href->{_check_buttons_settings_aref} );

	$param_widgets->redisplay_labels();
	$param_widgets->redisplay_values();
	$param_widgets->redisplay_check_buttons();

	# Collect and store prog versions changed in list box
	_stack_versions();

	# Add a single_program to the growing stack
	# store one program name, its associated parameters and their values
	# as well as the checkbuttons settings (on or off) in another namespace
	_stack_flow();

	# print("color_flow,add2flow_button, after stack flow before update\n");
	# $param_flow_color_pkg->view_data();

	$gui_history->set_hash_ref($color_flow_href);
	$gui_history->set4end_of_add2flow_button($flow_color);

	my $flow_index = $flow_widgets->get_flow_selection( $color_flow_href->{_flow_listbox_color_w} );

	$gui_history->set_flow_index_last_touched($flow_index);    # done in conditions_gui, flow color is not reset
	$color_flow_href = $gui_history->get_hash_ref();

	# switch between the correct index of the last parameter that was touched
	# as a function of the flow's color
	# These data are encapsulated
	$color_flow_href->{_last_parameter_index_touched_color}   = 0;       # initialize
	$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;

	_flow_select_director('add2flow_button');

	#$gui_history->view();

	# the following is also carried out in flow_select when  pre_ok=true
	$color_flow_href->{_last_flow_color} = $flow_color;

	return ();
}

=head2 sub delete_from_flow_button
if flow_select was last pushed then $gui_history recorded the chosen flow color
my $flow_color = $gui_history->get_flow_color();
flow color below is identical

   	 	
=cut

sub delete_from_flow_button {

	my ($self) = @_;

	my $flow_color = ( $color_flow_href->{_flow_select_color_href} )->{_most_recent};

	# print("color_flow, delete_from_flow_button, current color= $flow_color\n");

	# print("color_flow, delete_from_flow_button, print gui_history.txt\n");
	# $gui_history->view();

	if ($flow_color) {

		_set_flow_color($flow_color);

		use messages::message_director;
		use decisions 1.00;

		my $color_flow_messages = message_director->new();
		my $decisions           = decisions->new();

		my $message = $color_flow_messages->null_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );

		my $_flow_listbox_color_w = _get_flow_listbox_color_w();

		$gui_history->set_hash_ref($color_flow_href);
		$gui_history->set_defaults4start_of_delete_from_flow_button($flow_color);
		$color_flow_href = $gui_history->get_hash_ref();

		$decisions->set4delete_from_flow_button($color_flow_href);
		my $pre_req_ok = $decisions->get4delete_from_flow_button();

		# confirm listboxes are active
		if ($pre_req_ok) {

			# location within GUI on first clicking delete button
			$gui_history->set_hash_ref($color_flow_href);

			# $gui_history->set_defaults4start_of_delete_from_flow_button($flow_color);
			$color_flow_href = $gui_history->get_hash_ref();

			# flow_color is in 'color'_flow namespace
			my $index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

			# SPECIAL CASE: LAST ITEM in listbox is deleted
			if ( $index == 0 && $param_flow_color_pkg->get_num_items == 1 ) {

				# last item deleted Shut down delete button\n");

				# For Run and Save button
				$flow_widgets->delete_selection($_flow_listbox_color_w);

				# Blank out the names of the programs in the GUI
				_set_flow_name_color_w($flow_color);
				$flow_name_color_w->configure( -text => $var->{_clear_text} );
				$color_flow_href->{_flowNsuperflow_name_w}->configure( -text => $var->{_clear_text} );

				# delete stored programs and their parameters
				my $index2delete = $flow_widgets->get_index2delete();

				# delete_from_stored_flows();
				$param_flow_color_pkg->delete_selection($index2delete);

				# collect and store latest program versions from changed list
				# clear all the versions from the changed list
				# _stack_versions();
				_clear_stack_versions();

				$gui_history->set_hash_ref($color_flow_href);
				$gui_history->set_defaults4last_delete_from_flow_button();
				$color_flow_href = $gui_history->get_hash_ref();

				# Blank out all the stored parameter values and names within param_flow
				# clear 31 parameters
				$param_flow_color_pkg->clear();

				# clear the parameter values and labels from the gui
				# strange memory leak inside param_widgets
				my $save = clone( $color_flow_href->{_check_buttons_settings_aref} );
				$param_widgets->gui_full_clear();
				@{ $color_flow_href->{_check_buttons_settings_aref} } = @$save;

			}
			elsif ( $index >= 0 ) {    #  i.e., more than one item remains in a listbox

				# note the last program that was touched
				$color_flow_href->{_last_flow_index_touched}         = $index;
				$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

				$flow_widgets->delete_selection($_flow_listbox_color_w);

				# delete stored programs and their parameters
				# delete_from_stored_flows();
				my $index2delete = $flow_widgets->get_index2delete();

				#print("2. color_flow delete_from_stored,index2delete:$index2delete\n");
				$param_flow_color_pkg->delete_selection($index2delete);

				# keep track of flow selection clicks and colors
				$_flow_listbox_color_w->selectionSet( ( $index2delete - 1 ) );
				$gui_history->set_flow_select_color($this_color);
				$gui_history->set_button('flow_select');

				# Update the widget parameter names and values
				# to those of new selection after deletion
				# Only the chkbuttons, values and names of the last program used
				# are stored in param_widgets at any one time
				# Get parameters from storage
				my $next_idx_selected_after_deletion = $index2delete - 1;
				if ( $next_idx_selected_after_deletion == -1 ) {
					$next_idx_selected_after_deletion = 0;
				}    # NOT < 0
				     # $next_idx_selected_after_deletion\n");

				$param_flow_color_pkg->set_flow_index($next_idx_selected_after_deletion);
				$color_flow_href->{_names_aref} = $param_flow_color_pkg->get_names_aref();

				# is @{$color_flow_href->{_names_aref}}\n");
				$color_flow_href->{_values_aref} = $param_flow_color_pkg->get_values_aref();

				# is @{$color_flow_href->{_values_aref}}\n");
				$color_flow_href->{_check_buttons_settings_aref} = $param_flow_color_pkg->get_check_buttons_settings();

				# get stored first index and num of items
				$color_flow_href->{_param_flow_first_idx} = $param_flow_color_pkg->first_idx();
				$color_flow_href->{_param_flow_length}    = $param_flow_color_pkg->length();
				$color_flow_href->{_prog_name_sref}       = $param_widgets->get_current_program( \$_flow_listbox_color_w );
				$param_widgets->set_current_program( $color_flow_href->{_prog_name_sref} );

				# sub saveprint(" 1. color_flow, delete_from-flow_button, \n");
				$param_widgets->gui_full_clear();    # formerly gui_clean
				$param_widgets->range($color_flow_href);
				$param_widgets->set_labels( $color_flow_href->{_names_aref} );
				$param_widgets->set_values( $color_flow_href->{_values_aref} );
				$param_widgets->set_check_buttons( $color_flow_href->{_check_buttons_settings_aref} );

				$param_widgets->redisplay_labels();
				$param_widgets->redisplay_values();
				$param_widgets->redisplay_check_buttons();

				# note the last program that was touched
				$color_flow_href->{_last_flow_index_touched}         = $next_idx_selected_after_deletion;
				$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

				# collect and store latest program versions from changed list
				_stack_versions();
			}
		}    # if pre_req_ok

	}
	else {    # if flow_color
		print("color_flow, delete_from_flow_button, flow color missing: \n");
	}

	# print("color_flow, delete_from_flow_button, print gui_history.txt\n");
	# $gui_history->view();
}

=head2 sub flow_item_down_arrow_button

 	move items down in a flow listbox
    
=cut

sub flow_item_down_arrow_button {

	my ($self) = @_;
	my $prog_name;

	if ($flow_color) {

		_set_flow_color($flow_color);

		# $conditions_gui->set4start_of_flow_item_down_arrow_button($color_flow_href);

		use messages::message_director;
		use decisions 1.00;

		my $color_flow_messages = message_director->new();
		my $decisions           = decisions->new();

		my $message = $color_flow_messages->null_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );

		$prog_name = ${ $color_flow_href->{_prog_name_sref} };

		#  get number of items in the flow listbox
		my $_flow_listbox_color_w = _get_flow_listbox_color_w();                            # user-built_flow in current use
		my $num_items             = $flow_widgets->get_num_items($_flow_listbox_color_w);

		# get the current index
		my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

		# the destination index will be one more
		my $destination_index = $current_flow_listbox_index + 1;

		# limit max index
		if ( $destination_index >= $num_items ) {
			$destination_index = $num_items - 1;
		}

		# MEET THESE conditions, OR do NOTHING
		if (   $prog_name
			&& ( $current_flow_listbox_index >= 0 )
			&& $destination_index < $num_items )
		{

			$color_flow_href->{_index2move}        = $current_flow_listbox_index;
			$color_flow_href->{_destination_index} = $destination_index;

			# get all the elements from inside the listbox
			my @elements = $_flow_listbox_color_w->get( 0, 'end' );

			# rearrange elements
			my $saved_item = $elements[ $color_flow_href->{_index2move} ];

			$color_flow_href->{_flow_listbox_color_w}->delete( $color_flow_href->{_index2move} );
			$color_flow_href->{_flow_listbox_color_w}->insert( $color_flow_href->{_destination_index}, $saved_item );
			$color_flow_href->{_flow_listbox_color_w}->selectionSet( $color_flow_href->{_destination_index} );

			# note the last program that was touched
			$color_flow_href->{_last_flow_index_touched}         = $color_flow_href->{_destination_index};
			$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

			# move stored data within arrays
			my $start = $color_flow_href->{_index2move};
			my $end   = $color_flow_href->{_destination_index};

			$param_flow_color_pkg->set_insert_start($start);
			$param_flow_color_pkg->set_insert_end($end);
			$param_flow_color_pkg->insert_selection();

			# update program versions if listbox changes
			# stored in param_flows
			_stack_versions();

			# update the parameter widget labels and their values

			# highlight new index
			_local_set_flow_listbox_color_w($flow_color);    # in "color"_flow namespace
			$_flow_listbox_color_w->selectionSet( $color_flow_href->{_destination_index}, );

			# carry out all gui updates needed
			# keep track of flow_selection clicks
			_flow_select_director('flow_item_down_arrow_button');

		}
		else {
			print("color_flow, flow_item_down_arrow_button missing program or bad index\n");
		}

	}
	else {
		print("color_flow, flow_item_down_arrow_button missing color \n");
	}

}

=head2 sub flow_item_up_arrow_button

		move items up in a flow listbox
    
=cut

sub flow_item_up_arrow_button {

	my ($self) = @_;
	my $prog_name;

	if ($flow_color) {
		_set_flow_color($flow_color);

		# $conditions_gui->set4start_of_flow_item_up_arrow_button($color_flow_href);

		use messages::message_director;
		use decisions 1.00;

		my $color_flow_messages = message_director->new();
		my $decisions           = decisions->new();

		my $message = $color_flow_messages->null_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );

		$prog_name = ${ $color_flow_href->{_prog_name_sref} };

		#  get number of items in the flow listbox
		my $_flow_listbox_color_w = _get_flow_listbox_color_w();                            # user-built_flow in current use
		my $num_items             = $flow_widgets->get_num_items($_flow_listbox_color_w);

		# get the current index
		my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

		# the destination index will be one less
		my $destination_index = $current_flow_listbox_index - 1;
		if ( $destination_index <= 0 ) {
			$destination_index = 0;
		}                                                                                   # limit min index

		# MEET THESE conditions, OR do NOTHING
		if (   $prog_name
			&& ( $current_flow_listbox_index > 0 )
			&& $destination_index >= 0 )
		{

			$color_flow_href->{_index2move}        = $current_flow_listbox_index;
			$color_flow_href->{_destination_index} = $destination_index;

			# note the last program that was touched
			$color_flow_href->{_last_flow_index_touched}         = $color_flow_href->{_destination_index};
			$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

			# get all the elements from inside the listbox
			my @elements = $_flow_listbox_color_w->get( 0, 'end' );

			# rearrange elements
			my $saved_item = $elements[ $color_flow_href->{_index2move} ];

			$color_flow_href->{_flow_listbox_color_w}->delete( $color_flow_href->{_index2move} );
			$color_flow_href->{_flow_listbox_color_w}->insert( $color_flow_href->{_destination_index}, $saved_item );
			$color_flow_href->{_flow_listbox_color_w}->selectionSet( $color_flow_href->{_destination_index} );

			# note the last program that was touched
			$color_flow_href->{_last_flow_index_touched}         = $color_flow_href->{_destination_index};
			$color_flow_href->{_is_last_flow_index_touched_grey} = $true;

			# move stored data within arrays
			my $start = $color_flow_href->{_index2move};
			my $end   = $color_flow_href->{_destination_index};

			$param_flow_color_pkg->set_insert_start($start);
			$param_flow_color_pkg->set_insert_end($end);
			$param_flow_color_pkg->insert_selection();

			# update program versions if listbox changes
			# stored in param_flows
			_stack_versions();

			# highlight new index
			$_flow_listbox_color_w->selectionSet( $color_flow_href->{_destination_index}, );

			# carry out all gui updates needed
			# keep track of flow_selection clicks
			_flow_select_director('flow_item_up_arrow_button');

		}
		else {
		}

	}
	else {
		print("color_flow, flow_item_up_arrow_button missing color \n");
	}

}

=head2 sub flow_select

Pick a Seismic Unix module
from within a (colored) flow listbox
    	     	 
always takes focus on first entry ; index = 0
if focus is on first entry then also make the
last_parameter_index_touched = 0  
          
=cut

sub flow_select {
	my ($self) = @_;

	use messages::message_director;
	use decisions;

	$color_flow_href->{_flow_type} = $flow_type->{_user_built};

	# print("1. color_flow,flow_select, last_flow_index_touched:$color_flow_href->{_last_flow_index_touched}\n");
	# print("color_flow,flow_select, last_flow_color:$color_flow_href->{_last_flow_color}\n");

	# reset residual flow_listbox_color_w of another color
	# flow_color exists in current (color_flow) namespace
	_local_set_flow_listbox_color_w($flow_color);
	$gui_history->set_flow_select_color($flow_color);

	# print("2\n");
	# $param_flow_color_pkg->view_data();

	my $color_flow_messages = message_director->new();
	my $decisions           = decisions->new();

	my $message = $color_flow_messages->null_button(0);
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	$gui_history->set_hash_ref($color_flow_href);
	$gui_history->set_defaults_4start_of_flow_select($flow_color);
	$color_flow_href = $gui_history->get_hash_ref();

	# print("2. color_flow,flow_select, last_flow_index_touched:$color_flow_href->{_last_flow_index_touched}\n");

	#$param_flow_color_pkg->view_data();

	# update the flow color as per add2flow_select
	my $_flow_listbox_color_w = _get_flow_listbox_color_w();

	$color_flow_href->{_prog_name_sref} = $flow_widgets->get_current_program( \$_flow_listbox_color_w );

=pod

CASE 1: When flow_select is being used for the first time
BUT when no previous flow has been selected
This case can occur when a flow is read into a GUI which is used
for the first time, i.e., when no listboxes have been occupied previously

=cut

	if (  !( $color_flow_href->{_last_flow_color} )
		|| ( $color_flow_href->{_last_flow_color} eq $empty_string ) )
	{
		print("color_flow,flow_select, CASE #1 \n");

		# print( "color_flow,flow_select, color_flow->{_last_flow_color}=$color_flow_href->{_last_flow_color}\n" );

		$color_flow_href->{_last_flow_color} = $color_flow_href->{_flow_color};

		$color_flow_href->{_is_last_flow_index_touched_grey}      = $true;
		$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;
		my $num_indices = $flow_widgets->get_num_indices( \$_flow_listbox_color_w );
		$color_flow_href->{_last_flow_index_touched}            = -1;    # $num_indices;
		$color_flow_href->{_last_parameter_index_touched_color} = 0;

		#print("1. color_flow, flow_select: writing gui_history.txt\n");
		#$gui_history->view();

=pod

CASE 2 flow_select is used actively (directly clicked) by the user for the first time
The first flow of the session has already been run and saved
BUT if the flow has never been actively selected by the user then the following 
parameters are not activated
and so the internal parameters of the flow items will not get saved 
at the start of this subroutine.
This can happen when user
(1) loads, saves and runs a pre-built user-flow
selects a new flow item
WITHOUT selecting an existant flow item
Does not happen if the user chooses a flow item before going on to select a new sunix
program

=cut

	}
	elsif ($color_flow_href->{_last_flow_color} eq 'neutral'
		&& defined $color_flow_href->{_flow_color}
		&& $color_flow_href->{_flow_color} eq $this_color
		&& defined $color_flow_href->{_prog_name_sref}
		&& $color_flow_href->{_prog_name_sref} ne $empty_string
		&& !( $color_flow_href->{_is_last_flow_index_touched_grey} )
		&& !( $color_flow_href->{_is_last_flow_index_touched_pink} )
		&& !( $color_flow_href->{_is_last_flow_index_touched_green} )
		&& !( $color_flow_href->{_is_last_flow_index_touched_blue} ) )
	{

		print("CASE # 2\n");

		# $param_flow_color_pkg->view_data();

		$color_flow_href->{_last_flow_color}                      = $color_flow_href->{_flow_color};
		$color_flow_href->{_is_last_flow_index_touched_grey}      = $true;
		$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;
		my $num_indices = $flow_widgets->get_num_indices( \$_flow_listbox_color_w );
		$color_flow_href->{_last_flow_index_touched}            = $num_indices;
		$color_flow_href->{_last_parameter_index_touched_color} = 0;

		#			print("2. color_flow, flow_select: writing gui_history.txt\n");
		#			$gui_history->view();
	}

	else {
		# NADA
	}

	$decisions->set4flow_select($color_flow_href);

	# print("3. color_flow, flow_select: writing gui_history.txt\n");
	# $gui_history->view();

	my $pre_req_ok = $decisions->get4flow_select();

	if ($pre_req_ok) {

		use binding;
		my $binding = binding->new();
		my ($ans);
		use Clone 'clone';

		# print("5 flow_select \n");
		# my $ans = ( ( $gui_history->get_defaults )->{_flow_select_index_href} )->{_most_recent};
		# print("6 flow_select, most_recent_index = $ans\n");
		$gui_history->set_button('flow_select');

		$ans = ( ( $gui_history->get_defaults )->{_flow_select_index_href} )->{_most_recent};
		print(" flow_select, most_recent_index = $ans\n");
		print(" flow_select, view stored param flow data before update of prior\n");
		$param_flow_color_pkg->view_data();

		# consider prior flow-color changes
		# unticked strings from GUI are corrected here
		_update_prior_param_flow();

		print("4. color_flow, add2flow_button: view stored data after update of prior\n");
		$param_flow_color_pkg->view_data();

		# print("9 flow_select current values \n");

		# Update last flow color just selected
		#  in case it does not get updated by _update_prior_param_flow (above)
		$color_flow_href->{_last_flow_color} = $flow_color;

		#		my $ans = @{$color_flow_href->{_values_w_aref}}[0]->get;
		#		print("9 color_flow,flow_select value 0 --$ans--\n");
		#		my $ans1 = @{$color_flow_href->{_values_w_aref}}[1]->get;
		#		print("9 color_flow,flow_select value 1 --$ans1--\n");
		#		 $ans = @{$color_flow_href->{_names_aref}}[0];
		#		print("9 color_flow,flow_select label 0 --$ans--\n");
		#		 $ans1 = @{$color_flow_href->{_names_aref}}[1];
		#		print("9 color_flow,flow_select label 1 --$ans1--\n\n");

		# for just-selected program name
		# get its flow parameters from storage
		# and redisplay the widgets with parameters

		# Update the flow item index to that of
		# the newly selected program in the flow instead
		# of prior program
		# Warning: Flow selection gets reset if user double-clicks on a parameter value
		# in another window

		# current selection in the flow
		my $index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

		# print("9 flow_select, stored values and labels for currently selected flow_index = $index\n");

		# extract saved values and labels for the current selection
		$param_flow_color_pkg->set_flow_index($index);
		$color_flow_href->{_names_aref}  = $param_flow_color_pkg->get_names_aref();
		$color_flow_href->{_values_aref} = $param_flow_color_pkg->get_values_aref();

		#		$ans = @{$color_flow_href->{_values_aref}}[0];
		#		print("10 color_flow,flow_select value 0 --$ans--\n");
		#		$ans1 = @{$color_flow_href->{_values_aref}}[1];
		#		print("10 color_flow,flow_select value 1 --$ans1--\n");
		#		 $ans = @{$color_flow_href->{_names_aref}}[0];
		#		print("9 color_flow,flow_select label 0 --$ans--\n");
		#		 $ans1 = @{$color_flow_href->{_names_aref}}[1];
		#		print("9 color_flow,flow_select label 1 --$ans1--\n\n");

		# print("10 flow_select\n");
		# $param_flow_color_pkg->view_data();

		$color_flow_href->{_check_buttons_settings_aref} = $param_flow_color_pkg->get_check_buttons_settings();

		# get stored first index and num of items
		$color_flow_href->{_param_flow_first_idx} = $param_flow_color_pkg->first_idx();
		$color_flow_href->{_param_flow_length}    = $param_flow_color_pkg->length();

		$param_widgets->set_current_program( $color_flow_href->{_prog_name_sref} );

		# print("4. color_flow, flow_select: writing gui_history.txt\n");
		# $gui_history->view();

		# widgets were initialized in super class
		# 1. prepare to update gui by assigning widgets
		# TODO are the next 3 lines needed now that we share gui_history?
		$param_widgets->set_labels_w_aref( $color_flow_href->{_labels_w_aref} );
		$param_widgets->set_values_w_aref( $color_flow_href->{_values_w_aref} );
		$param_widgets->set_check_buttons_w_aref( $color_flow_href->{_check_buttons_w_aref} );

		$color_flow_href->{_prog_name_sref} = $flow_widgets->get_current_program( \$_flow_listbox_color_w );

		# wipes out values labels and checkbuttons from the gui

		# print(" 1. color_flow, FLOW_SELECT, \n");
		$param_widgets->range($color_flow_href);

		# strange memory leak inside param_widgets
		my $save = clone( $color_flow_href->{_check_buttons_settings_aref} );
		$param_widgets->gui_full_clear();
		@{ $color_flow_href->{_check_buttons_settings_aref} } = @$save;

		$param_widgets->set_labels( $color_flow_href->{_names_aref} );
		$param_widgets->set_values( $color_flow_href->{_values_aref} );
		$param_widgets->set_check_buttons( $color_flow_href->{_check_buttons_settings_aref} );

		# print("3\n");
		# $param_flow_color_pkg->view_data();

		$param_widgets->redisplay_labels();
		$param_widgets->redisplay_values();
		$param_widgets->redisplay_check_buttons();
		$param_widgets->set_entry_change_status($false);

		# unxpectedly  Entry focus is delayed until the end of this method becore
		# completion;
		# that is we get to gui_history->view before we can update the focus
		# mysterious!!!!!
		$param_widgets->set_focus_on_Entry_w(0);    # put focus on first entry widget, index=0

		# Force the parameter index = 0 (this is NOT the flow index that marks the index of the programs in the flow);
		# If parameter_index >= 0 stored values will also be updated via update_static_param_flow
		# TODO the parameter_index_touched may become  .n.e. 0 but >=0
		# $color_flow_href->{_last_parameter_index_touched_color} = 0;
		# the changed parameter value in the Entry widget should force an update of stored values
		# in the current flow item (not the last flow item touched)
		# _update_most_recent_param_flow(); # is only active if
		# $color_flow_href->{_last_parameter_index_touched_color} >= 0

		# Here is where you rebind the different buttons depending on the
		# program name that is selected (i.e., through spec.pm)
		$binding->set_prog_name_sref( $color_flow_href->{_prog_name_sref} );
		$binding->set_values_w_aref( $param_widgets->get_values_w_aref );

		# reference to local subroutine that will be run when MB3 is pressed
		$binding->setFileDialog_button_sub_ref( \&_FileDialog_button );
		$binding->set();

		$gui_history->set_hash_ref($color_flow_href);
		$gui_history->set4end_of_flow_select($flow_color);
		$gui_history->set_flow_index_last_touched($index);
		$color_flow_href = $gui_history->get_hash_ref();    # now color_flow= 0; flow_type=user_built

		# Update thr entry button value that displays the currently active
		# flow or superflow name, by using the currently selected program name from the flow list
		# e.g. data_in, suximage, suxgraph etc.
		( $color_flow_href->{_flowNsuperflow_name_w} )->configure( -text => ${ $color_flow_href->{_prog_name_sref} } );

		# needed in possible export via get_hash_ref to help
		my $prog_name_sref = $color_flow_href->{_prog_name_sref};

		# will not reflect the Entry focus change
		# print("color_flow_href flow_select, log view is on\n");
		# $gui_history->view();

	}    # end pre_ok

	return ();
}

=head2 sub get_hash_ref 
exports private hash	
46 
 
=cut

sub get_hash_ref {
	my ($self) = @_;

	return ($color_flow_href);

}

=head2 sub get_flow_color

	exports private hash value
 
=cut

sub get_flow_color {
	my ($self) = @_;

	if ( $color_flow_href->{_flow_color} ) {
		my $color;

		$color = $color_flow_href->{_flow_color};
		return ($color);

	}
	else {
		print("color_flow, missing flow color\n");
	}

}

=head2 sub get_flow_type

	exports private hash value
 
=cut

sub get_flow_type {
	my ($self) = @_;

	if ( $color_flow_href->{_flow_type} ) {
		my $flow_type;

		$flow_type = $color_flow_href->{_flow_type};
		return ($flow_type);

	}
	else {
		print("color_flow, missing flow type\n");
	}

}

#=head2 sub get_last_flow_color
#
#		returns current color ($this_color) as the last fow color
# 	    get_hash_ref is intentionally not used
# 	    and a specific method is used for simplicity
#
#=cut
#
#sub get_last_flow_color {
#
#	my ($self) = @_;
#
#	if ( $color_flow_href->{_flow_color} ) {
#
#		$color_flow_href->{_last_flow_color} = $color_flow_href->{_flow_color};
#
#		# for export
#		$last_flow_color = $color_flow_href->{_last_flow_color};
#
#		return ($last_flow_color);
#
#	}
#	else {
#		print("color_flow, set_last_flow_color,  flow_color missing \n");
#	}
#
#	return ();
#}

=head2 sub get_prog_name_sref 

	exports private hash value
 
=cut

sub get_prog_name_sref {
	my ($self) = @_;

	if ( $color_flow_href->{_prog_name_sref} ) {
		my $name;

		$name = $color_flow_href->{_prog_name_sref};
		return ($name);

	}
	else {
		print("color_flow, missing \n");
	}

}

=head2 sub increase_vigil_on_delete_counter

	Helps keep check of whether an item
    is deleted from the listbox
    during dragging and dropping    

=cut

sub increase_vigil_on_delete_counter {
	my ($self) = @_;
	$flow_widgets->inc_vigil_on_delete_counter;

	return ();
}

=head2 sub help

 Callback sequence following MB3 click 
 activation of a sunix (Listbox) item
 program name is a scalar reference
 
 Let help decide whether it is a superflow
 or a user-created flow
 
 Show a window with the perldoc to the user
 

=cut 

sub help {
	my ($self) = @_;
	use help;
	use decisions;

	my $decisions = decisions->new();
	my $help      = new help();
	my $pre_req_ok;

	$decisions->set4help($color_flow_href);
	$pre_req_ok = $decisions->get4help();

	if ($pre_req_ok) {

		$help->set_name( $color_flow_href->{_prog_name_sref} );
		$help->tkpod();

	}
	else {

	}

	return ();
}

=head2 sub save_button

	topic: only 'Save'
  	for safety, place set_hash_ref first
  	run from L_SU.pm
  	
   	my	$m          	= "color_flow, _save_button, Test,set_specs,message,$message_w\n";
 	$message_w->delete("1.0",'end');
 	$message_w->insert('end', $m);

=cut

sub save_button {
	my ( $self, $topic ) = @_;

	# Double-check we are in the correct place:
	if ( $topic eq 'Save' ) {

		use files_LSU;
		use control;

		my $files_LSU = new files_LSU();
		my $control   = new control();

		# user-built_flow in current use
		my $flow_listbox_color_w = _get_flow_listbox_color_w();

		# Start refocus index in flow, in case focus has been removed
		# e.g., by double-clicking in parameter values window
		my $most_recent_flow_index_touched = ( $color_flow_href->{_flow_select_index_href} )->{_most_recent};
		my $prior_flow_index_touched       = ( $color_flow_href->{_flow_select_index_href} )->{_prior};
		my $most_recent_flow_color         = ( $color_flow_href->{_flow_select_color_href} )->{_most_recent};
		my $last_flow_index                = $most_recent_flow_index_touched;

		print("1 save_button, most_recent_flow_index is:  $most_recent_flow_index_touched\n");
		print("1 save_button, prior_flow_index is:  $prior_flow_index_touched\n");
		print("1 new save, last_flow_color is:  $most_recent_flow_color \n");
		print("1 new save, last_flow_color is also:  $color_flow_href->{_last_flow_color}\n");
		$last_flow_color = $color_flow_href->{_last_flow_color};

		if (   $last_flow_color
			&& $last_flow_index >=1
			&& $flow_listbox_color_w )
		{
			# print("CASE 1 grey_flow, save_button \n");
			# BUT one parameter-index (=0) has been selected then
			# assume that the recent selection is valid for this current save

			# keep track of flow_selection clicks
			$flow_listbox_color_w->selectionSet($last_flow_index);
			$gui_history->set_flow_select_color($this_color);
			$gui_history->set_button('flow_select');
					}
		else {
			print("grey_flow, save_button , unexpected missing variables NADA\n");
		}

=pod
A CASE considered When save_button is being used for the first time
BUT when no flow has been selected previously (_last_flow_index_touched=-1)
This case can occur when a flow is read into a GUI that is used
for the first time that is when no listboxes have been occupied previously
		
=cut

			$param_flow_color_pkg->set_flow_index($last_flow_index);

			# collect the values from the stored Data in param_flow
			# because the values from the widgets have not been updated
			$color_flow_href->{_values_aref} = $param_flow_color_pkg->get_values_aref();

			# restore strings to have terminal strings
			# remove quotes upon input
			$color_flow_href->{_values_aref} =
				$control->get_no_quotes4array( $color_flow_href->{_values_aref} );

			# in case parameter values have been displayed stringless
			$color_flow_href->{_values_aref} =
				$control->get_string_or_number4array( $color_flow_href->{_values_aref} );

			$color_flow_href->{_last_parameter_index_touched_color}   = 0;
			$color_flow_href->{_is_last_parameter_index_touched_grey} = $true;

			# update changes to parameter values between 'SaveAs' and 'Save'
			# assume a parameter index has been changed so that
			# _update_most_recent_param_flow is forced to update changes before updating
			# these changes via param_flow

			_update_most_recent_param_flow();

			#print("grey_flow, save_button , before updates to recent and prior flow param values\n");
			#$param_flow_color_pkg->view_data();
			#_update_prior_param_flow();

			print("grey_flow, save_button , after update to recent and prior flow param values\n");
			$param_flow_color_pkg->view_data();

			$color_flow_href->{_names_aref} = $param_flow_color_pkg->get_names_aref();

			$param_flow_color_pkg->set_good_values();
			$param_flow_color_pkg->set_good_labels();

			$color_flow_href->{_good_labels_aref2}   = $param_flow_color_pkg->get_good_labels_aref2();
			$color_flow_href->{_items_versions_aref} = $param_flow_color_pkg->get_flow_items_version_aref();
			$color_flow_href->{_good_values_aref2}   = $param_flow_color_pkg->get_good_values_aref2();
			$color_flow_href->{_prog_names_aref}     = $param_flow_color_pkg->get_flow_prog_names_aref();

			$files_LSU->set_prog_param_labels_aref2($color_flow_href);    # uses 1 / 114 in
			$files_LSU->set_prog_param_values_aref2($color_flow_href);    # uses 1 / 114 in
			$files_LSU->set_prog_names_aref($color_flow_href);            # uses 1 / 114 in
			$files_LSU->set_items_versions_aref($color_flow_href);        # uses 1 / 114 in
			$files_LSU->set_data();
			$files_LSU->set_message($color_flow_href);                    # uses 1 / 114 in
			                                                              # update PL_SEISMIC in case user has changed project area
			$files_LSU->set_PL_SEISMIC();
			$files_LSU->set2pl($color_flow_href);                         # flows saved to PL_SEISMIC
			$files_LSU->save();


	}
	else {
		print("color_flow, missing topic Save\n");
	}
	return ();
}

=head2 sub set_hash_ref

	copies with simplified names are also kept (40) so later
	the hash can be returned to a calling module
	
	imports external hash into private settings via gui_history 
	accessory

print("color_flow,set_hash_ref,hash_ref->{_log_view}: $ans\n");
my $ans = $gui_history->get_log_view();
print("2. color_flow,set_hash_ref: gui_history->get_log_view:$ans \n");
 	
=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	$gui_history->set_defaults($hash_ref);

	# $gui_history->set_log_view($true);

	$color_flow_href = $gui_history->get_defaults();

	# REALLY?
	# set up param_widgets for later use
	# give param_widgets the needed values
	$param_widgets->set_hash_ref($color_flow_href);

	$flow_color       = $color_flow_href->{_flow_color};
	$gui_history_aref = $color_flow_href->{_gui_history_aref};

	#for export?
	$last_flow_color               = $color_flow_href->{_last_flow_color};                 # used in flow_select
	$message_w                     = $color_flow_href->{_message_w};
	$parameter_values_frame        = $color_flow_href->{_parameter_values_frame};
	$parameter_values_button_frame = $color_flow_href->{_parameter_values_button_frame};

	# $sunix_listbox                 = $color_flow_href->{_sunix_listbox};

	# print("color_flow,set_hash_ref: ->get_log_view:$ans \n");
	#		$gui_history->view();

	return ();
}

=head2 sub set_occupied_listbox_aref


=cut

sub set_occupied_listbox_aref {

	my ( $self, $occupied_listbox_aref ) = @_;

	if ($occupied_listbox_aref) {

		$color_flow_href->{_occupied_listbox_aref} = $occupied_listbox_aref;

	}
	else {
		print("color_flow,_set_occupied_listbox_aref, missing occupied_listbox_aref \n");
	}

}

__PACKAGE__->meta->make_immutable;
1;
