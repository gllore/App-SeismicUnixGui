package grey_flow;

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
our $VERSION = '0.0.2';

use param_widgets_grey;
use param_flow_grey 0.0.2;
use whereami;    # for whole-gui awareness
use flow_widgets;
use conditions_gui;
use L_SU_global_constants;

my $conditions_gui = conditions_gui->new();
my $flow_widgets   = flow_widgets->new();
my $get            = L_SU_global_constants->new();

my $param_flow = param_flow_grey->new();

my $param_widgets = param_widgets_grey->new();
my $whereami      = whereami->new();
my $flow_type     = $get->flow_type_href();
my $var           = $get->var();
my $empty_string  = $var->{_empty_string};
my $this_color    = 'grey';

=head2

 share the following parameters in same name 
 space
 
 51 + 1

=cut

my $Data_menubutton;
my $Flow_menubutton;
my $SaveAs_menubutton;
my $FileDialog_sub_ref;
my $FileDialog_option;
my $add2flow_button_grey;
my $add2flow_button_pink;
my $add2flow_button_green;
my $add2flow_button_blue;
my $check_code_button;
my $check_buttons_w_aref;
my $delete_from_flow_button;
my $dialog_type;
my $dnd_token_grey;
my $dnd_token_pink;
my $dnd_token_green;
my $dnd_token_blue;
my $dropsite_token_grey;
my $dropsite_token_pink;
my $dropsite_token_green;
my $dropsite_token_blue;
my $file_menubutton;
my $flow_item_down_arrow_button;
my $flow_item_up_arrow_button;
my $flow_listbox_grey_w;
my $flow_listbox_pink_w;
my $flow_listbox_green_w;
my $flow_listbox_blue_w;
my $flow_listbox_color_w;
my $flow_color;
my $flow_name_grey_w;
my $flow_name_pink_w;
my $flow_name_green_w;
my $flow_name_blue_w;
my $flow_name_color_w;
my $flowNsuperflow_name_w;
my $is_pre_built_superflow;
my $is_user_built_flow;
my $labels_w_aref;
my $last_flow_color;

# my $lightning_button;
my $message_w;
my $mw;
my $occupied_listbox_aref;
my $parameter_values_button_frame;
my $parameter_names_frame;
my $parameter_values_frame;
my $prog_name_sref;
my $run_button;
my $save_button;
my $sunix_listbox;
my $values_w_aref;

# global variable
our $gui_history_aref;

# instance (i) of a hash reference
# value of the hash changes depending on the color-flow in use
# value is changed in _set_param_flow_color_i
# not for export
# actually is the same as param_flow_color
my $param_flow_color_pkg;

my $true        = $var->{_true};
my $false       = $var->{_false};
my @empty_array = (0);              # length=1

=head2 private hash

	114 off 
	_is_flow_listbox_color_w is generic colored widget
	Warning: conditions_gui.pm does not contain all the hash keys and values
	that follow-- these variables will be reset by conditions_gui.p.

=cut

my $color_flow = {

	_Data_menubutton                       => '',
	_Flow_menubutton                       => '',
	_FileDialog_sub_ref                    => '',
	_FileDialog_option                     => '',
	_SaveAs_menubutton                     => '',
	_add2flow_button_grey                  => '',                          #
	_add2flow_button_pink                  => '',                          #
	_add2flow_button_green                 => '',                          #
	_add2flow_button_blue                  => '',                          #
	_check_code_button                     => '',                          #
	_check_buttons_settings_aref           => '',
	_check_buttons_w_aref                  => '',                          #
	_delete_from_flow_button               => '',                          #
	_destination_index                     => '',
	_dialog_type                           => '',                          #
	_dnd_token_grey                        => '',
	_dnd_token_pink                        => '',
	_dnd_token_green                       => '',
	_dnd_token_blue                        => '',
	_dropsite_token_grey                   => '',
	_dropsite_token_pink                   => '',
	_dropsite_token_green                  => '',
	_dropsite_token_blue                   => '',
	_file_menubutton                       => '',                          #
	_flow_color                            => '',                          #
	_flow_item_down_arrow_button           => '',
	_flow_item_up_arrow_button             => '',
	_flow_listbox_grey_w                   => '',                          #
	_flow_listbox_pink_w                   => '',                          #
	_flow_listbox_green_w                  => '',                          #
	_flow_listbox_blue_w                   => '',                          #
	_flow_listbox_color_w                  => '',                          #
	_flow_name_grey_w                      => '',
	_flow_name_pink_w                      => '',
	_flow_name_green_w                     => '',
	_flow_name_blue_w                      => '',
	_flow_name_color_w                     => '',                          # TBAdded to all programs
	_flow_name_out                         => '',                          #
	_flow_name_in                          => '',
	_flow_type                             => $flow_type->{_user_built},
	_flow_widget_index                     => '',
	_flowNsuperflow_name_w                 => '',
	_good_labels_aref2                     => '',
	_good_values_aref2                     => '',
	_gui_history_aref                      => '',
	_has_used_open_perl_file_button        => '',
	_has_used_Save_button                  => '',
	_has_used_SaveAs_button                => '',
	_has_used_run_button                   => '',
	_index2move                            => '',
	_is_check_code_button                  => '',
	_is_SaveAs_file_button                 => '',
	_is_add2flow_button                    => '',
	_is_check_code_button                  => '',
	_is_delete_from_flow_button            => '',
	_is_flow_item_down_arrow_button        => '',
	_is_flow_item_up_arrow_button          => '',
	_is_flow_listbox_grey_w                => $false,
	_is_flow_listbox_pink_w                => $false,
	_is_flow_listbox_green_w               => $false,
	_is_flow_listbox_blue_w                => $false,
	_is_flow_listbox_color_w               => $false,
	_is_last_flow_index_touched_grey       => $false,
	_is_last_flow_index_touched_pink       => $false,
	_is_last_flow_index_touched_green      => $false,
	_is_last_flow_index_touched_blue       => $false,
	_is_last_flow_index_touched            => $false,
	_is_last_parameter_index_touched_grey  => $false,
	_is_last_parameter_index_touched_pink  => $false,
	_is_last_parameter_index_touched_green => $false,
	_is_last_parameter_index_touched_blue  => $false,
	_is_last_parameter_index_touched_color => $false,

	#	_is_lightning_button                   => '',
	_is_moveNdrop_in_flow               => '',
	_is_pre_built_superflow             => '',
	_is_run_button                      => '',
	_is_sunix_listbox                   => '',
	_is_superflow_select_button         => 0,
	_is_superflow                       => '',
	_is_user_built_flow                 => '',
	_items_checkbuttons_aref2           => '',
	_items_names_aref2                  => '',
	_items_values_aref2                 => '',
	_items_versions_aref                => '',
	_labels_w_aref                      => '',
	_last_flow_index_touched            => -1,
	_last_flow_index_touched_grey       => -1,
	_last_flow_index_touched_pink       => -1,
	_last_flow_index_touched_green      => -1,
	_last_flow_index_touched_blue       => -1,
	_last_flow_listbox_touched          => '',
	_last_flow_listbox_touched_w        => -1,
	_last_parameter_index_touched_color => -1,
	_last_parameter_index_touched_grey  => -1,
	_last_parameter_index_touched_pink  => -1,
	_last_parameter_index_touched_green => -1,
	_last_parameter_index_touched_blue  => -1,
	_last_path_touched                  => './',

	#	_lightning_button                      => '',
	_message_w                     => '',
	_mw                            => '',
	_names_aref                    => '',
	_occupied_listbox_aref         => '',
	_param_flow_length             => '',
	_parameter_names_frame         => '',
	_param_sunix_first_idx         => 0,
	_param_sunix_length            => '',
	_parameter_values_frame        => '',
	_parameter_values_button_frame => '',
	_parameter_value_index         => -1,
	_prog_name_sref                => '',
	_prog_names_aref               => '',
	_run_button                    => '',
	_save_button                   => '',
	_sunix_listbox                 => '',
	_values_aref                   => \@empty_array,    # initialise empty array
	_values_w_aref                 => '',

};

=head2 sub _add2flow

	When reading a user-built perl flow
	Incorporate new program parameter values and labels into the gui
	and save the values, labels and checkbuttons setting in the param_flow
	namespace

=cut

sub _add2flow {

	my ( $self, $value ) = @_;

	$color_flow->{_flow_type} = $flow_type->{_user_built};

	use message_director;

	my $color_flow_messages = message_director->new();
	my $message             = $color_flow_messages->null_button(0);

	my $here;

	$conditions_gui->set_gui_widgets($color_flow);          # 26 used  / 114 in
	$conditions_gui->set_hash_ref($color_flow);             # 62 used / 114 in
	$conditions_gui->set4start_of_add2flow($flow_color);    #  set and 10 widgets configured
	$color_flow = $conditions_gui->get_hash_ref();          # 88 returned

	my $test = $param_flow_color_pkg->get_flow_prog_names_aref();

	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# add the most recently selected program
	# name (scalar reference) to the
	# end of the list inside flow_listbox
	_set_flow_listbox_color_w($flow_color);    # in "color"_flow namespace

	# append new program names to the end of the list but this item is NOT selected
	# selection occurs inside conditions_gui
	$color_flow->{_flow_listbox_color_w}->insert( "end", ${ $color_flow->{_prog_name_sref} }, );

	# display default paramters in the GUI
	# same as for sunix_select
	# can not get program name from the item selected in the sunix list box
	# because focus is transferred to a flow list box  ($this_color)

	$here = $whereami->set4add2flow();    # checking
	$here = $whereami->get4add2flow();
	$param_widgets->set_location_in_gui($here);

	# widgets are initialized in a super class
	# Assign program parameters in the GUI
	# no. of parameters defaults to max=114
	# See: L_SU_global_constants.pl

	# my $length = scalar @{$color_flow->{_values_aref}};

	#foreach my $key (sort keys %$color_flow) {
	#   print (" color_flow _add2flow,key is $key, value is $color_flow->{$key}\n");
	#  }

	$param_widgets->set_labels_w_aref( $color_flow->{_labels_w_aref} );
	$param_widgets->set_values_w_aref( $color_flow->{_values_w_aref} );
	$param_widgets->set_check_buttons_w_aref( $color_flow->{_check_buttons_w_aref} );

	$param_widgets->range($color_flow);
	$param_widgets->set_labels( $color_flow->{_names_aref} );

	$param_widgets->set_values( $color_flow->{_values_aref} );

	$param_widgets->set_check_buttons( $color_flow->{_check_buttons_settings_aref} );

	# wipes out values labels and checkbuttons from the gui
	$param_widgets->gui_full_clear();
	$param_widgets->redisplay_labels();

	$param_widgets->redisplay_values();

	$param_widgets->redisplay_check_buttons();

	# Collect and store prog versions changed in list box
	_stack_versions();

	# $test 	= $param_flow_color_pkg->get_flow_prog_names_aref();
	# Add a single_program to the growing stack
	# store one program name, its associated parameters and their values
	# as well as the checkbuttons settings (on or off) in another namespace
	_stack_flow();

	$test = $param_flow_color_pkg->get_flow_prog_names_aref();

	$conditions_gui->set_gui_widgets($color_flow);    # includes _values_w_aref; 29 used / 114 in
	$conditions_gui->set_hash_ref($color_flow);       # 70 used / 114 in
	$conditions_gui->set4end_of_add2flow($flow_color);

	my $index = $flow_widgets->get_flow_selection( $color_flow->{_flow_listbox_color_w} );

	$conditions_gui->set_flow_index_last_touched($index);    # flow color is not reset

	$color_flow = $conditions_gui->get_hash_ref();

	# switch between the correct index of the last parameter that was touched
	# as a function of the flow's color
	# These data are encapsulated
	# _set_last_parameter_index_touched_color($flow_color);
	# _set_is_last_parameter_index_touched_color($flow_color);

	$color_flow->{_last_parameter_index_touched_color}   = 0;       # initialize
	$color_flow->{_is_last_parameter_index_touched_grey} = $true;

	# $test 	= $param_flow_color_pkg->get_flow_prog_names_aref();

	return ();

}

=head2 sub _clear_color_flow

	wipe out color-flow list box with programs
	wipe out param_widgets_color
	wipe out parameters stored for color flow

=cut

sub _clear_color_flow {
	my ($self) = @_;

	#  switch between instances of the correct param_flow_color
	#	param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	# my $number = $param_flow_color_pkg->get_num_items();

	#clear all stored parameters and versions in the param_flow
	$param_flow_color_pkg->clear();
	my $number = $param_flow_color_pkg->get_num_items();

	# my $test 	= $param_flow_color_pkg->get_flow_prog_names_aref();

	# clear the parameter values and labels belonging to the gui
	$param_widgets->gui_full_clear();

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
  	print ("color_flow,_FileDialog_button(binding), _is_flow_listbox_color_w: $color_flow->{_is_flow_listbox_color_w} \n");
  	
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
		$color_flow->{_values_aref}    = $param_widgets->get_values_aref();
		$param_widgets->{_values_aref} = $param_widgets->get_values_aref();

		# restore strings to have terminal strings
		# remove quotes upon input
		$color_flow->{_values_aref} =
			$control->get_no_quotes4array( $color_flow->{_values_aref} );

		# in case parameter values have been displayed stringless
		$color_flow->{_values_aref} = $control->get_string_or_number4array( $color_flow->{_values_aref} );

		$color_flow->{_dialog_type} = $$option_sref;    # dereference scalar

		$file_dialog->set_flow_color( $color_flow->{_flow_color} );    # uses 1/ 31 in
		$file_dialog->set_hash_ref($color_flow);                       # uses 7/ 31 in  ; uses values_aref
		$file_dialog->set_gui_widgets($color_flow);                    # uses 18/ 31 in
		$file_dialog->FileDialog_director();

		# print("4. color_flow, _FileDialog_button, last_flow_color:$color_flow->{_last_flow_color}\n");

		# file_dialog updates of parameter values
		# values are retrieved
		$color_flow->{_values_aref} = $file_dialog->get_values_aref();

		# print("color_flow, _FileDialog_button, param_widgets values_aref: @{$param_widgets->{_values_aref}}\n");

		# assume that after selection to open of a data file while using file-dialog button the
		# GUI has been updated
		# See if the last parameter index has been touched (>= 0)
		# Assume we are still dealing with the current flow item selected

		$color_flow->{_last_parameter_index_touched_color}   = $file_dialog->get_last_parameter_index_touched_color();
		$color_flow->{_is_last_parameter_index_touched_grey} = $true;

		# the parameter_index_touched changes only when an effective change to the parameter is made
		# print ("color_flow,_FileDialog_button(binding), last_parameter_index_touched: $color_flow->{_last_parameter_index_touched_color} \n");
		# in case _check4changes does not run make sure to use the following line
		# update to parameter values occurs in file_dialog

		# Here we update the value of the Entry widget (in GUI) with the selected file name
		# Now might be a good moment to update the parameter_widgets with the updated value
		# update endtry those parameters
		my $selected_Entry_widget = $parameter_values_frame->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);
		$color_flow->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();
		$color_flow->{_entry_button_label}    = $param_widgets->get_label4entry_button_chosen();
		my $current_index = $color_flow->{_parameter_value_index};
		@{ $param_widgets->{_values_aref} }[$current_index] = $file_dialog->get_selected_file_name();
		@{ $color_flow->{_values_aref} }[$current_index]    = $file_dialog->get_selected_file_name();
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
		# $color_flow->{_last_parameter_index_touched_color}  = $current_index;

		#		print("13 color_flow, _FileDialog_button,color_flow selected_file_name: @{ $param_widgets->{_values_aref} }[$current_index]\n");
		#		print("13 color_flow, _FileDialog_button,color_flow values: @{ $color_flow->{_values_aref} }\n");

		# print("9. color_flow, _FileDialog_button, last_flow_color:$color_flow->{_last_flow_color}\n");
		# print("1. color_flow, _FileDialog_button, last_flow_index_touched $color_flow->{_last_flow_index_touched}\n");
		# set up this flow listbox item as the last item touched
		my $_flow_listbox_color_w      = _get_flow_listbox_color_w();                                 # user-built_flow in current use
		my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);
		$color_flow->{_last_flow_index_touched}         = $current_flow_listbox_index;                # for next time
		$color_flow->{_is_last_flow_index_touched_grey} = $true;

		# print("2. color_flow, _FileDialog_button, last_flow_index_touched $color_flow->{_last_flow_index_touched}\n");
		# print("10. color_flow, _FileDialog_button, last_flow_color:$color_flow->{_last_flow_color}\n");
		# Changes made with another instance of param_widgets (in file_dialog) will require
		# that we update the namespace of the current param_flow
		# We make this change inside _check4parameter_changes
		_check4parameter_changes();

	}
	else {
		print("color_flow,_FileDialog_button (binding),option type missing ");
	}
	return ();
}

=head2  _check4flow_changes

	Updates the values for parameters stored via param_flow
	param-flow takes saves parameters from param_widgets
	BUT param_widgets need to have been updated by check4param_changes or 
	user changes on the screen will not chave been updated

	Applied every time that a flow item is selected 
	1. Assume that selection of a flow item implies pre-existing parameter values were changed/added
	
	2. Opening a file dialog assumes parameter values were also changed (Entry widget) 
	-- this means that a prior program must have been touched and that the color must change 
	from either neutral to the current color or be overwritten by the same color
	
	if ($param_widgets->get_entry_change_status && $color_flow->{_last_flow_index_touched} >= 0) {		
    	  foreach my $key (sort keys %$color_flow) {
           print (" color_flowkey is $key, value is $color_flow->{$key}\n");
           used only by flow_select and sunix_select
          }
             
		 ( $color_flow->{_last_parameter_index_touched_color} ) >= 0)
		 
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
  		 
  		 
  	Clicking Save will activate _check4flow_changes.  Before Save is clicked, the 
  			_last_parameter_index_touched_color = 0
         	_last_flow_index_touched 			= -1
         	_last_flow_color 					= current flow color
         	
=cut 

sub _check4flow_changes {

	my ($self) = @_;
	use control;

	my $control = control->new();

	# print("1 color_flow _check4flow_changes, last_flow_color is:  $color_flow->{_last_flow_color} \n");
	# print("1 color_flow _check4flow_changes, current flow_color is:  $color_flow->{_flow_color} \n");
	# print("1 color_flow _check4flow_changes, _last_parameter_index_touched_color ($this_color) is:  $color_flow->{_last_parameter_index_touched_color} \n");
	# print("1 color_flow _check4flow_changes, _last_flow_index_touched is:  $color_flow->{_last_flow_index_touched} \n");

	# both must be defined but can = 0
	# a flow in the grey box must have been touched or a parameter value in the flow must have been touched
	# < -1 does exist and means the flow/parameter was not previously touched
	if (   $color_flow->{_last_flow_index_touched} >= 0
		or $color_flow->{_last_parameter_index_touched_color} >= 0 )
	{
		# prior flow must have the same color as the current one or we have just clicked an sunit progfram (neutral-flow case)

		if (   $color_flow->{_last_flow_color} eq 'neutral'
			or $color_flow->{_last_flow_color} eq $color_flow->{_flow_color}

			)
		{

			# switch between instances of the correct param_flow_color
			# param_flow_color stores Data
			_set_param_flow_color_i($flow_color);

			# print("7\n");
			# $param_flow_color_pkg->view_data();
			my $last_flow_index_touched = $color_flow->{_last_flow_index_touched};

			# the checkbuttons, values and names of ONLY the last program used
			# are stored in param_widgets at any ONE time
			$color_flow->{_values_aref} = $param_widgets->get_values_aref();

			# restore terminal ticks in strings after reading from the GUI
			# remove  possible terminal strings
			$color_flow->{_values_aref} =
				$control->get_no_quotes4array( $color_flow->{_values_aref} );

			# in case parameter values have been displayed stringless
			$color_flow->{_values_aref}                 = $control->get_string_or_number4array( $color_flow->{_values_aref} );
			$color_flow->{_names_aref}                  = $param_widgets->get_labels_aref();
			$color_flow->{_check_buttons_settings_aref} = $param_widgets->get_check_buttons_aref();

			$param_flow_color_pkg->set_flow_index($last_flow_index_touched);

			# print("color_flow check4flow_changes,store changes in param_flow, last changed flow index $last_flow_index_touched\n");

			# The following 3 lines save old changed values and names but not the versions
			$param_flow_color_pkg->set_values_aref( $color_flow->{_values_aref} );
			$param_flow_color_pkg->set_names_aref( $color_flow->{_names_aref} );
			$param_flow_color_pkg->set_check_buttons_settings_aref( $color_flow->{_check_buttons_settings_aref} );

			# print("9\n");
			# $param_flow_color_pkg->view_data();

			$param_widgets->set_entry_change_status($false);    # changes are now complete
			$color_flow->{_last_flow_color} = $color_flow->{_flow_color};

			# FOR EXPORT
			$last_flow_color = $color_flow->{_flow_color};      # reset to working only in current flow color

			# print("8 leaving _check4flow_changes \n");
			# $param_flow_color_pkg->view_data();

		}
		else {
		}

	}
	else {
	}

	return ();
}

=head2  _check4parameter_changes

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

sub _check4parameter_changes {
	my ($self) = @_;

	# switch between instances of the correct param_flow_color
	# param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	# N.B., {_last_parameter_index_touched_color} < 0
	# does exist and means the parameters are untouched
	if ( $color_flow->{_last_parameter_index_touched_color} >= 0 ) {

		my $last_parameter_idx_touched = $color_flow->{_last_parameter_index_touched_color};

		# print("color_flow _check4parameter_changes,last changed entry index was $last_parameter_idx_touched \n");
		# print("color_flow _check4parameter_changes current program name in use: ${$color_flow->{_prog_name_sref}}\n");

		# Update ONLY the names and check_buttons again, reading in from the gui (param_widgets), just in case
		$color_flow->{_names_aref}                  = $param_widgets->get_labels_aref();
		$color_flow->{_check_buttons_settings_aref} = $param_widgets->get_check_buttons_aref();

		# $color_flow->{_values_aref}					= $param_flow_color_pkg ->get_values_aref();

		# For flow item index of the program in the color-flow listbox that is currently being used,
		# i.e., not the index of the last-used program
		# user-built_flow in current use
		my $_flow_listbox_color_w = _get_flow_listbox_color_w();

		my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

		if ( $current_flow_listbox_index >= 0 ) {    # >=0 11-14-2018 JML

			$param_flow_color_pkg->set_flow_index($current_flow_listbox_index);

			# save current values and names
			$param_flow_color_pkg->set_values_aref( $color_flow->{_values_aref} );                                    # but not the versions
			$param_flow_color_pkg->set_names_aref( $color_flow->{_names_aref} );                                      # but not the versions
			$param_flow_color_pkg->set_check_buttons_settings_aref( $color_flow->{_check_buttons_settings_aref} );    # BUT not the versions

			$param_widgets->set_entry_change_status($false);                                                          # changes are now complete

			# when last_parameter_index_touched goes back to -1 (default)
			# this subroutine may not be used later
			$color_flow->{_last_parameter_index_touched_color} = -1;
			$color_flow->{_last_flow_index_touched}            = $current_flow_listbox_index;    # for next time

			$color_flow->{_is_last_flow_index_touched_grey} = $true;

			# print("2. color_flow, _check4parameter_changes, last_flow_index_touched $color_flow->{_last_flow_index_touched}\n");
			# $param_flow_color_pkg->view_data();

		}
		else {

			# Look for the last flow index that was touched

			my $last_idx_chng = $color_flow->{_last_flow_index_touched};

			$param_flow_color_pkg->set_flow_index($last_idx_chng);

			# save current values and names
			$param_flow_color_pkg->set_values_aref( $color_flow->{_values_aref} );                                    # but not the versions
			$param_flow_color_pkg->set_names_aref( $color_flow->{_names_aref} );                                      # but not the versions
			$param_flow_color_pkg->set_check_buttons_settings_aref( $color_flow->{_check_buttons_settings_aref} );    # BUT not the versions

			# changes are now complete
			$param_widgets->set_entry_change_status($false);

			# if reinitialize last_parameter_index_touched goes back to -1 (default)
			# then this subroutine may not be used
			$color_flow->{_last_parameter_index_touched_color} = -1;
			$color_flow->{_last_flow_index_touched}            = $last_idx_chng;    # for next time
			$color_flow->{_is_last_flow_index_touched_grey}    = $true;

			# print("End of $this_color _check4parameterchanges: _last_parameter_index_touched reset: $color_flow->{_last_parameter_index_touched_color}\n");

		}

	}
	else {
	}

	return ();
}

=head2 sub _clear_stack_versions 

	clear items_versions_aref
	when last flow item is deleted
	in the listbox

=cut

sub _clear_stack_versions {

	# switch between instances of the correct param_flow_color
	# param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	my $_flow_listbox_color_w = _get_flow_listbox_color_w();

	$flow_widgets->clear_flow_items($_flow_listbox_color_w);
	$flow_widgets->clear_items_versions_aref();

	# hash value = ''
	_clear_items_version_aref();

	$param_flow_color_pkg->clear_flow_items_version_aref();

}

=head2 sub _flow_select

	private alias for flow_select

=cut

sub _flow_select {

	my ($self) = @_;

	flow_select();

}

=head2 sub _get_flow_listbox_color_w


=cut 

sub _get_flow_listbox_color_w {
	my ($self) = @_;
	my $flow_color;
	my $correct_flow_listbox_color_w;

	$flow_color = $color_flow->{_flow_color};

	if ( $flow_color eq $this_color ) {

		$correct_flow_listbox_color_w = $color_flow->{_flow_listbox_grey_w};

	}
	else {
		print("color_flow, _get_flow_listbox_color_w, missing color\n");
	}

	return ($correct_flow_listbox_color_w);
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

	# switch between instances of the correct param_flow_color
	# param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	$color_flow->{_index2move}        = $flow_widgets->index2move();
	$color_flow->{_destination_index} = $flow_widgets->destination_index();

	my $start = $color_flow->{_index2move};
	my $end   = $color_flow->{_destination_index};
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
  	
   	my	$m          	= "color_flow, _SaveAs_button, Test,set_specs,message,$message_w\n";
 	$message_w->delete("1.0",'end');
 	$message_w->insert('end', $m);

=cut

sub _SaveAs_button {
	my ($topic) = @_;

	if ( $topic eq 'SaveAs' ) {

		use files_LSU;

		my $files_LSU = new files_LSU();

		# switch between instances of the correct param_flow_color
		# param_flow_color stores Data
		_set_param_flow_color_i($flow_color);

		$conditions_gui->set_hash_ref($color_flow);       # 57 used of 114 in
		$conditions_gui->set_gui_widgets($color_flow);    # 26 used of 114 in
		$conditions_gui->set4_start_of_SaveAs_button();

		my $num_items = $param_flow_color_pkg->get_num_items();

		$color_flow->{_names_aref} = $param_flow_color_pkg->get_names_aref();

		$param_flow_color_pkg->set_good_values();
		$param_flow_color_pkg->set_good_labels();

		# collect information to be saved in a perl flow
		$color_flow->{_good_labels_aref2}   = $param_flow_color_pkg->get_good_labels_aref2();
		$color_flow->{_items_versions_aref} = $param_flow_color_pkg->get_flow_items_version_aref();
		$color_flow->{_good_values_aref2}   = $param_flow_color_pkg->get_good_values_aref2();
		$color_flow->{_prog_names_aref}     = $param_flow_color_pkg->get_flow_prog_names_aref();

		# @{$color_flow->{_prog_names_aref}}\n");
		my $num_items4flow = scalar @{ $color_flow->{_good_labels_aref2} };

		# for (my $i=0; $i < $num_items4flow; $i++ ) {
		# @{@{$color_flow->{_good_labels_aref2}}[$i]}\n");
		# }

		#f or (my $i=0; $i < $num_items4flow; $i++ ) {
		#	print("color_flow,_SaveAs_button, _good_values_aref2,
		#	@{@{$color_flow->{_good_values_aref2}}[$i]}\n");
		#}
		#   print("color_flow,_prog_versions_aref,
		#   @{$color_flow->{_items_versions_aref}}\n");

		$files_LSU->set_prog_param_labels_aref2($color_flow);    # uses x / 61 in
		$files_LSU->set_prog_param_values_aref2($color_flow);    # uses x / 61 in
		$files_LSU->set_prog_names_aref($color_flow);            # uses x / 61 in
		$files_LSU->set_items_versions_aref($color_flow);        # uses x / 61 in
		$files_LSU->set_data();
		$files_LSU->set_message($color_flow);                    # uses 1 / 61 in

		$files_LSU->set2pl($color_flow);                         # flows saved to PL_SEISMIC
		$files_LSU->save();

		$conditions_gui->set4_end_of_SaveAs_button();            # sets: _has_used_SaveAs=true
		$color_flow = $conditions_gui->get_hash_ref();           # 79 out

		return ();

	}
	else {
		print("color_flow,_SaveAs_button, missing topic\n");
	}
}

=head2 sub _perl_flow

  Parse (while reading) perl flows

  foreach my $key (sort keys %$color_flow) {
   print (" color_flowkey is $key, value is $color_flow->{$key}\n");
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
	use message_director;
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

	# switch between instances of the correct param_flow_color
	# param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	# should be at start of color_flow
	$color_flow->{_flow_type} = $flow_type->{_user_built};
	my $flow_name_in = $color_flow->{_flow_name_in};

	my $flow_color = $color_flow->{_flow_color};

	# read in variables from the perl flow file
	$perl_flow->set_perl_file_in($flow_name_in);
	$perl_flow->parse();

	# clear all signs in GUI and wipe all the memory spaces
	# associated with the contents in the flow listbox that is about to
	# be occupied
	_clear_color_flow();

	my $num_prog_names = $perl_flow->get_num_prog_names();

	for ( my $prog_idx = 0; $prog_idx < $num_prog_names; $prog_idx++ ) {

		# collect info from perl file
		$perl_flow->set_prog_index($prog_idx);
		$color_flow->{_prog_name_sref}              = $perl_flow->get_prog_name_sref();
		$color_flow->{_names_aref}                  = $perl_flow->get_all_names_aref();
		$color_flow->{_values_aref}                 = $perl_flow->get_all_values_aref();
		$color_flow->{_check_buttons_settings_aref} = $perl_flow->get_check_buttons_settings_aref();

		# remove quotes upon input
		$color_flow->{_values_aref} =
			$control->get_no_quotes4array( $color_flow->{_values_aref} );

		# add single quotes upon input only to strings
		$color_flow->{_values_aref} =
			$control->get_string_or_number4array( $color_flow->{_values_aref} );

		# my $names = scalar @{$color_flow->{_names_aref}};
		# my $values = scalar @{$color_flow->{_values_aref}};

		#

		# Populate GUI with the parameter values and labels of the first item
		_add2flow();

	}

	# select the last flow item loaded
	# flow_select with also help start detect any parameter changes
	# will store
	# upload variables into the param_flow for each program
	_flow_select();

	return ();
}

=head2 sub _set_flow_color


=cut 

sub _set_flow_color {
	my ($flow_color) = @_;

	if ($flow_color) {

		$color_flow->{_flow_color} = $flow_color;

	}
	else {
		print("color_flow, set_flow_color, missing color\n");
	}
	return ();
}

=head2 sub _set_flow_listbox_color_w


=cut 

sub _set_flow_listbox_color_w {
	my ($flow_color) = @_;

	if ( $flow_color eq $this_color ) {

		$color_flow->{_flow_listbox_color_w} = $color_flow->{_flow_listbox_grey_w};

	}
	else {
		print("color_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, missing color\n");
	}

	return ();
}

=head2 sub _set_flow_name_color_w

=cut

sub _set_flow_name_color_w {
	my ($flow_color) = @_;

	if ( $flow_color eq $this_color ) {

		$flow_name_color_w = $color_flow->{_flow_name_grey_w};

		#do not export
		$flow_name_color_w = $color_flow->{_flow_name_grey_w};

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

	if ( $flowNsuperflow_name && $flowNsuperflow_name_w ) {

		$color_flow->{_flowNsuperflow_name_w} = $flowNsuperflow_name_w;

		$flowNsuperflow_name_w->configure( -text => $flowNsuperflow_name, );
	}
	else {
		print("color_flow, set_flowNsuperflow_name_w, missing widget or program name\n");
	}

	return ();
}

=head2 sub  _set_is_last_parameter_index_touched_color

=cut 

sub _set_is_last_parameter_index_touched_color {
	my ($flow_color) = @_;

	if ( $flow_color eq $this_color ) {

		# not for export
		$color_flow->{_is_last_parameter_index_touched_color} = $color_flow->{_is_last_parameter_index_touched_grey};

		print("color_flow,_set_is_last_parameter_index_touched_color, is_last_parameter_index_touched_grey: $color_flow->{_is_last_parameter_index_touched_grey}\n");

	}
	else {
		print("color_flow,_set_is_last_parameter_index_touched_color, missing color \n");
	}

	return ();
}

=head2 sub  _set_last_parameter_index_touched_color

=cut 

sub _set_last_parameter_index_touched_color {
	my ($flow_color) = @_;

	if ( $flow_color eq $this_color ) {

		# not for export
		$color_flow->{_last_parameter_index_touched_color} = $color_flow->{_last_parameter_index_touched_grey};

		print("color_flow,_set_last_parameter_index_touched_color, last_parameter_index_touched_grey: $color_flow->{_last_parameter_index_touched_grey}\n");

	}
	else {
		print("color_flow,_set_last_parameter_index_touched_color, , missing color \n");
	}

	return ();
}

=head2 sub _set_param_flow_color_i


=cut

sub _set_param_flow_color_i {
	my ($flow_color) = @_;

	if ($flow_color) {

		# not for export outside this package
		$param_flow_color_pkg = $param_flow;

	}
	else {
		print("color_flow,_set_param_flow_color_i, __set_param_flow_color_i, missing color \n");
	}

	return ();
}

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
  namespace different to the one belonginf to param_widgets 
  
  The initial version comes from default parameter files
  i.e., sing the same code as for sunix_select
  
  print("color_flow stack_flow,last left listbox flow program touched had index = $color_flow->{_last_flow_index_touched}\n");
  print("color_flow stack_flow,values= @{$color_flow->{_values_aref}}\n");
  
=cut

sub _stack_flow {
	my ($self) = @_;
	use control;

	my $control = control->new();

	# switch between instances of the correct param_flow_color
	# param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	# my $num_items = $param_flow_color_pkg->get_num_items();

	# $param_flow_color_pkg->view_data();

	$param_flow_color_pkg->stack_flow_item( $color_flow->{_prog_name_sref} );

	$param_flow_color_pkg->stack_names_aref2( $color_flow->{_names_aref} );

	# restore strings to have terminal strings
	# remove quotes upon input
	$color_flow->{_values_aref} =
		$control->get_no_quotes4array( $color_flow->{_values_aref} );

	# in case parameter values have been displayed stringless
	$color_flow->{_values_aref} =
		$control->get_string_or_number4array( $color_flow->{_values_aref} );

	$param_flow_color_pkg->stack_values_aref2( $color_flow->{_values_aref} );

	$param_flow_color_pkg->stack_checkbuttons_aref2( $color_flow->{_check_buttons_settings_aref} );

	# $param_flow_color_pkg 		->view_data();
	# my $num_items = $param_flow_color_pkg->get_num_items;

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

	# switch between instances of the correct param_flow_color
	# param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	my $_flow_listbox_color_w = _get_flow_listbox_color_w();

	$flow_widgets->set_flow_items($_flow_listbox_color_w);
	$color_flow->{_items_versions_aref} = $flow_widgets->items_versions_aref;
	$param_flow_color_pkg->set_flow_items_version_aref( $color_flow->{_items_versions_aref} );

}

=head2 sub _clear_items_version_aref 

	clear items_versions_aref
	used when last item is removed from the listbox

=cut

sub _clear_items_version_aref {

	my ($self) = @_;

	if ($color_flow) {

		$color_flow->{_items_versions_aref} = '';
		return ();

	}
	else {
		print("color_flow, _clear_items_version_aref, missing color_flow \n");
		return ();
	}

}

=head2

	FileDialog_button 	: handles Data, SaveAs and (perl) Flow (in) is 
  	
  			 	 foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
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
  		
  		foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  		}
  	
=cut 

sub FileDialog_button {

	my ( $self, $dialog_type_sref ) = @_;
	use file_dialog;
	use L_SU_global_constants;
	use conditions_gui;
	use manage_files_by2;
	use Project_config;
	use control;

	my $file_dialog      = file_dialog->new();
	my $get              = L_SU_global_constants->new();
	my $conditions_gui   = conditions_gui->new();
	my $file_dialog_type = $get->file_dialog_type_href();
	my $Project          = Project_config->new();
	my $control          = control->new();

	my $PL_SEISMIC = $Project->PL_SEISMIC();

	# may provide values from the current widget if it is used
	# can also be (1) a previous pre-built superflow that is already in the GUI
	# (2) empty if program is just starting

	if ($dialog_type_sref) {

		$color_flow->{_dialog_type} = $$dialog_type_sref;    # dereference scalar
		my $topic = $color_flow->{_dialog_type};

		# ONLY for SaveAs
		# In this module, dialog_type_sref can only be SaveAs

		# Save for 'user-built flows' is accessible via L_SU.pm
		if ( $topic eq $file_dialog_type->{_SaveAs} ) {

			$color_flow->{_values_aref} = $param_widgets->get_values_aref();

			# restore strings to have terminal strings
			# remove quotes upon input
			$color_flow->{_values_aref} =
				$control->get_no_quotes4array( $color_flow->{_values_aref} );

			# in case parameter values have been displayed stringless
			$color_flow->{_values_aref} = $control->get_string_or_number4array( $color_flow->{_values_aref} );

			$color_flow->{_dialog_type} = $$dialog_type_sref;    # dereference scalar

			$file_dialog->set_flow_color( $color_flow->{_flow_color} );    # uses 1/ 114 in
			$file_dialog->set_hash_ref($color_flow);                       # uses 86/ 114 in  ; uses values_aref
			$file_dialog->set_gui_widgets($color_flow);                    # uses 34/ 114 in
			                                                               # $file_dialog		->set_flow_type('user_built'); not needed beacuase file_dialog accounts forSaveAs

			$file_dialog->FileDialog_director();

			# assume that while selecting a data file to open in file-dialog that the
			# GUI has been updated (not very elegant... TODO
			# see if the last index has been touched

			$color_flow->{_has_used_SaveAs_button} = $true;

			# new file name will generate a case that an index has been touched
			$color_flow->{_last_parameter_index_touched_color} = $file_dialog->get_last_parameter_index_touched_color();

			#			print ("1. color_flow,FileDialog_button,_last_parameter_index_touched_color:$color_flow->{_last_parameter_index_touched_color} \n");
			#			print ("1. color_flow,FileDialog_button, color: $flow_color \n");
			$color_flow->{_is_last_parameter_index_touched_grey} = $true;

			#			print("color_flow,FileDialog_button,_is_flow_listbox_grey_w:	$color_flow->{_is_flow_listbox_grey_w}\n");
			_check4parameter_changes();

			use message_director;
			my $color_flow_messages = message_director->new();

			$color_flow->{_flow_name_out} = file_dialog->get_perl_flow_name_out();
			$color_flow->{_path}          = file_dialog->get_file_path();

			# consider empty case, for which saving is not possible
			if (   !( $color_flow->{_flow_name_out} )
				|| $color_flow->{_flow_name_out} eq ''
				|| !( $color_flow->{_path} )
				|| $color_flow->{_path} eq '' )
			{

				my $message = $color_flow_messages->save_button(1);
				$message_w->delete( "1.0", 'end' );
				$message_w->insert( 'end', $message );

			}
			else {    # Good,  NON-EMPTY case

				# displays user-built flow name at top of grey-flow gui
				_set_flowNsuperflow_name_w( $color_flow->{_flow_name_out} );
				_set_user_built_flow_name_w( $color_flow->{_flow_name_out} );

				# go save perl flow file
				_SaveAs_button($topic);

				# restore message at the bottom of the string to blank if not already so
				# messages
				my $message = $color_flow_messages->null_button(0);
				$message_w->delete( "1.0", 'end' );
				$message_w->insert( 'end', $message );

			}    #Ends SaveAs option

		}
		elsif ( $topic eq $file_dialog_type->{_Flow} ) {

			# Read perl flow file
			# Write name to the file name in the appropriate flow
			# populate GUI
			# populate hashes (color_flow)and memory spaces (param_flow)
			$file_dialog->set_flow_color( $color_flow->{_flow_color} );    # uses 1/ 31 in
			$file_dialog->set_hash_ref($color_flow);                       # uses 7/ 31 in  ; uses values_aref
			$file_dialog->set_gui_widgets($color_flow);                    # uses 18/ 31 in
			$file_dialog->set_flow_type('user_built');

			$file_dialog->FileDialog_director();

			$color_flow->{_flow_name_in} = $file_dialog->get_perl_flow_name_in();

			# $conditions_gui				->set_hash_ref($file_dialog); # uses 75 / 123 given
			# $conditions_gui				->set_gui_widgets($conditions_gui); # uses 29  /123 given
			# $conditions_gui   			->set4FileDialog_open_perl_file_end(); # sets 2

			$color_flow->{_flow_name_out}                  = $color_flow->{_flow_name_in};
			$color_flow->{_has_used_open_perl_file_button} = $true;

			_set_flow_name_color_w($flow_color);

			# Is $flow_name_in empty
			my $file2query = $PL_SEISMIC . '/' . $color_flow->{_flow_name_in};

			my $file_exists = manage_files_by2::does_file_exist_sref( \$file2query );

			if ($file_exists) {

				# Place names of the programs at the head of the grey listbox
				$flow_name_color_w->configure( -text => $color_flow->{_flow_name_in} );

				# $color_flow->{_flow_name_grey_w}     -> configure(-text => $color_flow->{_flow_name_in});

				# Place names of the programs at the head of the GUI
				$color_flow->{_flowNsuperflow_name_w}->configure( -text => $color_flow->{_flow_name_in} );

				# populate gui, and bot param_flow and param_widgets namespaces
				_perl_flow();

			}
			else {
			}

			#			print("3 color_flow,FileDialog_button,_is_flow_listbox_grey_w:	$color_flow->{_is_flow_listbox_grey_w}\n");

		}
		elsif ( $topic eq $file_dialog_type->{_Data} ) {

			# print("color_flowFileDialog_button,option_sref $topic\n");

			# assume that after selection to open of a data file in file-dialog the
			# GUI has been updated
			# See if the last parameter index has been touched (>= 0)
			# Assume we are still dealing with the current flow item selected
			$color_flow->{_last_parameter_index_touched_color}   = $file_dialog->get_last_parameter_index_touched_color();
			$color_flow->{_is_last_parameter_index_touched_grey} = $true;

			# set the current listbox as the last color listbox
			$color_flow->{_last_flow_listbox_color_w} = $color_flow->{_flow_listbox_color_w};

			# provide values in the current widget
			$color_flow->{_values_aref} = $param_widgets->get_values_aref();

			# restgore terminal ticks to strings

			# restore strings to have terminal strings
			# remove quotes upon input
			$color_flow->{_values_aref} =
				$control->get_no_quotes4array( $color_flow->{_values_aref} );

			# in case parameter values have been displayed stringless
			$color_flow->{_values_aref} = $control->get_string_or_number4array( $color_flow->{_values_aref} );

			#			print(
			#				"color_flow,_FileDialog_button(binding), flow_listbox_color_w: $color_flow->{_flow_listbox_color_w} \n"
			#			);
			$file_dialog->set_flow_color( $color_flow->{_flow_color} );    # uses 1/ 31 in
			$file_dialog->set_hash_ref($color_flow);                       # uses 86/ 114 in  ; uses values_aref
			$file_dialog->set_gui_widgets($color_flow);                    # uses 34/ 114 in
			$file_dialog->FileDialog_director();

			#			print(
			#				"color_flow,_FileDialog_button(binding), last_parameter_index_touched_color: $color_flow->{_last_parameter_index_touched_color} \n"
			#			);

			# in case _check4changes does not run make sure to use the following line
			# update to parameter values occurs in file_dialog
			$color_flow->{_values_aref} = $file_dialog->get_values_aref();

			# set up this flow listbox item as the last item touched
			my $_flow_listbox_color_w      = _get_flow_listbox_color_w();                                 # user-built_flow in current use
			my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);
			$color_flow->{_last_flow_index_touched}         = $current_flow_listbox_index;                # for next time
			$color_flow->{_is_last_flow_index_touched_grey} = $true;

			# print("color_flow,FileDialog_button(binding), last_flow_index_touched:$color_flow->{_last_flow_index_touched} \n");

			# Changes made with another instance of param_widgets (in file_dialog) will require
			# that we also update the namespace of the current param_flow
			# We make this change inside _check4parameter_changes
			_check4parameter_changes();

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

  		foreach my $key (sort keys %$color_flow) {
   			print (" color_flow key is $key, value is $color_flow->{$key}\n");
  		}

=cut

sub add2flow_button {

	my ( $self, $value ) = @_;

	# There is a case when a flow is used for the first time,
	# a parameter value has been added or
	# modified and the flow item
	# is not selected manually after a change (select_flow_button)
	# If a previous flow item has not been updated (having checked for changes to the parameter values)
	# we must force an update to save parameter values
	# by using _flow_select which calls flow_select.
	#
	# make sure that the first flow item exists,
	# (TODO) and that you have not changed color
	my $_flow_listbox_color_w = _get_flow_listbox_color_w();
	my $flow_num_items        = $_flow_listbox_color_w->size();

	if ( $flow_num_items == 1 ) {

		_check4flow_changes();
	}
	else {
	}

	$color_flow->{_flow_type} = $flow_type->{_user_built};

	use message_director;
	use param_sunix;

	my $param_sunix         = param_sunix->new();
	my $color_flow_messages = message_director->new();
	my $message             = $color_flow_messages->null_button(0);

	my $here;

	$conditions_gui->set_gui_widgets($color_flow);                 # 26 used  / 114 in
	$conditions_gui->set_hash_ref($color_flow);                    # 62 used / 114 in
	$conditions_gui->set4start_of_add2flow_button($flow_color);    # 5 set and 10 widgets configured
	$color_flow = $conditions_gui->get_hash_ref();                 # 88 returned

	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# $whereami					->set4flow_listbox($flow_color);
	# clear all the indices of selected elements
	$sunix_listbox->selectionClear( $sunix_listbox->curselection );

	# add the most recently selected program
	# name (scalar reference) to the
	# end of the list indside flow_listbox
	_set_flow_listbox_color_w($flow_color);    # in "color"_flow namespace

	# append new program names to the end of the list but this item is NOT selected
	# selection occurs inside conditions_gui
	$color_flow->{_flow_listbox_color_w}->insert( "end", ${ $color_flow->{_prog_name_sref} }, );

	# display default paramters in the GUI
	# same as for sunix_select
	# can not get program name from the item selected in the sunix list box
	# because focus is transferred to another list box

	$param_sunix->set_program_name( $color_flow->{_prog_name_sref} );
	$color_flow->{_names_aref}                  = $param_sunix->get_names();
	$color_flow->{_values_aref}                 = $param_sunix->get_values();
	$color_flow->{_check_buttons_settings_aref} = $param_sunix->get_check_buttons_settings();
	$color_flow->{_param_sunix_first_idx}       = $param_sunix->first_idx();                    # first index = 0
	$param_sunix->set_half_length();                                                            # values not #(values+labels)

	# my $length = $param_sunix-> get_length();

	$whereami->set4add2flow_button();

	$here = $whereami->get4add2flow_button();
	$param_widgets->set_location_in_gui($here);

	# widgets are initialized in a super class
	# Assign program parameters in the GUI
	# no. of parameters defaults to max=61
	$param_widgets->set_labels_w_aref( $color_flow->{_labels_w_aref} );
	$param_widgets->set_values_w_aref( $color_flow->{_values_w_aref} );
	$param_widgets->set_check_buttons_w_aref( $color_flow->{_check_buttons_w_aref} );

	$param_widgets->range($color_flow);
	$param_widgets->set_labels( $color_flow->{_names_aref} );
	$param_widgets->set_values( $color_flow->{_values_aref} );
	$param_widgets->set_check_buttons( $color_flow->{_check_buttons_settings_aref} );
	$param_widgets->redisplay_labels();
	$param_widgets->redisplay_values();

	$param_widgets->redisplay_check_buttons();

	# Collect and store prog versions changed in list box
	_stack_versions();

	# Add a single_program to the growing stack
	# store one program name, its associated parameters and their values
	# as well as the checkbuttons settings (on or off) in another namespace
	_stack_flow();

	$conditions_gui->set_gui_widgets($color_flow);    # includes _values_w_aref; 26 used / 61 in
	$conditions_gui->set_hash_ref($color_flow);       # 61 used / 61 in
	$conditions_gui->set4end_of_add2flow_button($flow_color);

	my $flow_index = $flow_widgets->get_flow_selection( $color_flow->{_flow_listbox_color_w} );

	$conditions_gui->set_flow_index_last_touched($flow_index);    # flow color is not reset
	$color_flow = $conditions_gui->get_hash_ref();

	$color_flow->{_last_parameter_index_touched_color}   = 0;       # initialize
	$color_flow->{_is_last_parameter_index_touched_grey} = $true;

	flow_select();

	# the following is also carried out in flow_select when  pre_ok=true
	$color_flow->{_last_flow_color} = $flow_color;

	# for export
	$last_flow_color = $flow_color;

	return ();
}

=head2 sub delete_from_flow_button
   	 	
 set:
     $decisions
 
 get:
     $color_flow_messages
     $flow_widgets
     $param_flow_color_pkg	
 
 call:
    _stack_versions();	
	$conditions_gui->set4last_delete_from_flow_button();
    $conditions_gui->set4delete_from_flow_button();
    $color_flow 			= $conditions_gui->get_hash_ref();
  
  		
  		foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  		}
    
=cut

sub delete_from_flow_button {

	my ($self) = @_;

	# if flow_select was last pushed then conditions_gui conserved the flow color chosen:
	my $flow_color = $conditions_gui->get_flow_color();

	if ($flow_color) {

		_set_flow_color($flow_color);

		# switch between instances of the correct param_flow_color
		# param_flow_color stores Data
		_set_param_flow_color_i($flow_color);

		use message_director;
		use decisions 1.00;

		my $color_flow_messages = message_director->new();
		my $decisions           = decisions->new();

		my $message = $color_flow_messages->null_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );

		my $_flow_listbox_color_w = _get_flow_listbox_color_w();

		$conditions_gui->set_hash_ref($color_flow);                            # 57 used  /114 in
		$conditions_gui->set_gui_widgets($color_flow);                         # 26 used  /114 in
		$conditions_gui->set4start_of_delete_from_flow_button($flow_color);    # 3 set /  72 max
		$color_flow = $conditions_gui->get_hash_ref();                         # find out if delete button is active    64 returned / 72 max

		$decisions->set4delete_from_flow_button($color_flow);
		my $pre_req_ok = $decisions->get4delete_from_flow_button();

		# confirm listboxes are active
		if ($pre_req_ok) {

			$whereami->set4delete_from_flow_button();
			my $here = $whereami->get4delete_from_flow_button();

			# location within GUI on first clicking delete button
			$conditions_gui->set_hash_ref($color_flow);
			$conditions_gui->set_gui_widgets($color_flow);
			$conditions_gui->set4start_of_delete_from_flow_button($flow_color);
			$color_flow = $conditions_gui->get_hash_ref();

			# _set_flow_listbox_color_w($flow_color);
			my $index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

			# SPECIAL CASE: LAST ITEM in listbox is deleted
			if ( $index == 0 && $param_flow_color_pkg->get_num_items == 1 ) {

				# last item deleted Shut down delete button\n");

				# For Run and Save button
				$flow_widgets->delete_selection($_flow_listbox_color_w);

				# Blank out the names of the programs in the GUI
				_set_flow_name_color_w($flow_color);
				$flow_name_color_w->configure( -text => $var->{_clear_text} );
				$color_flow->{_flowNsuperflow_name_w}->configure( -text => $var->{_clear_text} );

				# delete stored programs and their parameters
				my $index2delete = $flow_widgets->get_index2delete();

				# delete_from_stored_flows();
				$param_flow_color_pkg->delete_selection($index2delete);

				# collect and store latest program versions from changed list
				# clear all the versions from the changed list
				# _stack_versions();
				_clear_stack_versions();

				$conditions_gui->set_hash_ref($color_flow);
				$conditions_gui->set_gui_widgets($color_flow);
				$conditions_gui->set4last_delete_from_flow_button();
				$color_flow = $conditions_gui->get_hash_ref();

				# Blank out all the stored parameter values and names within param_flow
				# clear 31 parameters
				$param_flow_color_pkg->clear();

				$whereami->set4delete_from_flow_button();
				$here = $whereami->get4delete_from_flow_button();
				$param_widgets->set_location_in_gui($here);

				# clear the parameter values and labels from the gui
				$param_widgets->gui_full_clear();

			}
			elsif ( $index >= 0 ) {    #  i.e., more than one item remains in a listbox

				# note the last program that was touched
				$color_flow->{_last_flow_index_touched}         = $index;
				$color_flow->{_is_last_flow_index_touched_grey} = $true;

				$flow_widgets->delete_selection($_flow_listbox_color_w);

				# delete stored programs and their parameters
				# delete_from_stored_flows();
				my $index2delete = $flow_widgets->get_index2delete();

				#print("2. color_flow delete_from_stored,index2delete:$index2delete\n");
				$param_flow_color_pkg->delete_selection($index2delete);

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
				$color_flow->{_names_aref} = $param_flow_color_pkg->get_names_aref();

				# is @{$color_flow->{_names_aref}}\n");
				$color_flow->{_values_aref} = $param_flow_color_pkg->get_values_aref();

				# is @{$color_flow->{_values_aref}}\n");
				$color_flow->{_check_buttons_settings_aref} = $param_flow_color_pkg->get_check_buttons_settings();

				# check_buttons_settings no changes,
				# @{$color_flow->{_check_buttons_settings_aref}}, index;$index\n#");

				# get stored first index and num of items
				$color_flow->{_param_flow_first_idx} = $param_flow_color_pkg->first_idx();
				$color_flow->{_param_flow_length}    = $param_flow_color_pkg->length();
				$color_flow->{_prog_name_sref}       = $param_widgets->get_current_program( \$_flow_listbox_color_w );
				$param_widgets->set_current_program( $color_flow->{_prog_name_sref} );
				$whereami->set4flow_listbox($flow_color);
				$here = $whereami->get4flow_listbox();

				$param_widgets->set_location_in_gui($here);
				$param_widgets->gui_clean();
				$param_widgets->range($color_flow);
				$param_widgets->set_labels( $color_flow->{_names_aref} );
				$param_widgets->set_values( $color_flow->{_values_aref} );
				$param_widgets->set_check_buttons( $color_flow->{_check_buttons_settings_aref} );

				$param_widgets->redisplay_labels();
				$param_widgets->redisplay_values();
				$param_widgets->redisplay_check_buttons();

				#  			$param_widgets				->set_entry_change_status($false);

				# note the last program that was touched
				$color_flow->{_last_flow_index_touched}         = $next_idx_selected_after_deletion;
				$color_flow->{_is_last_flow_index_touched_grey} = $true;

				# collect and store latest program versions from changed list
				_stack_versions();
			}
		}    # if pre_req_ok

	}
	else {    # if flow_color
		print("color_flow, delete_from_flow_button, flow color missing: \n");
	}
}

=head2 sub drag

  Drag and Drop do not delete 
  the program name from param_flow stored data
  when the program name disappears from the GUI

  User must delete the item and its parameters
  from stored memory after the Drop, i.e.
  When  
  (1) Drag is selected a second time or
  (2) when any other button in the GUI is selected
 
  print("drag,check $check\n");

  check if previous index was deleted by DnD 
  if so they delete that program 
  delete the stored parameter entries via param_flow.pm
  delete stored parameter values, names and checkbuttons
  also make sure that you can not drag if there is only one item left
  
  TODO: encapsulate and refactor
  gets from :
  	$color_flow
  	$flow_widgets
  	
  sets to:
  	$param_flow_color_pkg
  	$flow_widgets
  	
  calls: _stack_versions
  o/p need
	
=cut

sub drag {
	my ($self) = @_;

	my $prog_name;
	if ( $color_flow->{_prog_name_sref} ) {
		$prog_name = ${ $color_flow->{_prog_name_sref} };

	}

	#			# was a program deleted through a previous dragNdrop?
	#			# Has a program name even been selected or is user just playing aimlessly? # K
	# 	if( $prog_name && $flow_widgets->is_drag_deleted($flow_listbox_grey_w) ) {
	#
	# 		# switch between instances of the correct param_flow_color
	#		# param_flow_color stores Data
	#		_set_param_flow_color_i($flow_color);
	#
	#			print("2.color_flowdrag; prior index was deleted\n");
	#        my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_grey_w);
	#
	#			print("color_flowdrag,deleting flow_listbox,idx=$this_index\n");
	#    	print("index $this_index was just removed from widget\n");
	#
	#						# delete stored values from param_flow
	#    	$param_flow_color_pkg->delete_selection($this_index);
	#
	#						# update program versions if listbox changes
	#						# store via param_flows
	#    	_stack_versions();
	#		$flow_widgets->set_vigil_on_delete();
	#  	}
	# in case a previous drag updated the
	# vigil_on_delete counter
	# reset drag and drop vigil_on_delete counter
	#$flow_widgets->set_vigil_on_delete();

	my $num_items = $flow_widgets->get_num_items($flow_listbox_grey_w);

	if ( $num_items > 1 ) {    # num_items PRIOR to deletion
		$flow_widgets->drag_start($dnd_token_grey);

	}
	else {
	}
}

=head2 sub drop

   Item is successfully moved from one part of the flow
   listbox to another part of the same listbox
   
   drop does not occur if the user drags the item out of
   the listbox area
   
	
	$whereami					->set4moveNdrop_in_flow();
	my $here 					= $whereami->get4moveNdrop_in_flow();
	$param_widgets				->set_location_in_gui($here);

    print("drop,confirm done\n");
    
	make param_widgets not detect any entry changes
	This IS needed for sub flow_select also not to sense previous changes
	or else the stored parameters in the flow will not be correct
   	$param_widgets->set_entry_change_status($false);
   	
   	TODO: Refactoring
   	Encapsulation is poor:
   		gets from:
   			$color_flow
   			$flow_widgets
   			$flow_listbox_color_w  	
   	
   	 	sets:
   	 		$color_flow
   			$flow_listbox_color_w
   			$flow_widgets

	calls external _stack_versions
	calls external _move_in_stored_flows
	
	happens inside a Listbox only
	
=cut

sub drop {
	my ($self) = @_;
	my $done;
	my $chosen_index_to_drop = $flow_widgets->drag_end($dnd_token_grey);
	my $prog_name;

	# listbox must have at least one item
	if ( $color_flow->{_prog_name_sref} ) {
		$prog_name = ${ $color_flow->{_prog_name_sref} };

	}

	if ( $prog_name && $chosen_index_to_drop && $chosen_index_to_drop >= 0 ) {    # same as destination_index

		# if insertion occurs within the listbox
		$color_flow->{_index2move}        = $flow_widgets->index2move();
		$color_flow->{_destination_index} = $flow_widgets->destination_index;

		# note the last program that was touched
		$color_flow->{_last_flow_index_touched}         = $color_flow->{_destination_index};
		$color_flow->{_is_last_flow_index_touched_grey} = $true;

		# move stored data in agreement with this drop
		_move_in_stored_flows();

		# update program versions if listbox changes
		# stored in param_flows
		_stack_versions();

		# If there is no delete while dragging
		# the counter is also increased, so
		# reset drag and drop vigil_on_delete counter
		# this is a bug in the DragandDrop package

		$flow_widgets->set_vigil_on_delete();

		$flow_widgets->dec_vigil_on_delete_counter(2);

		# highlight new index
		_set_flow_listbox_color_w($flow_color);    # in "color"_flow namespace
		$flow_listbox_color_w->selectionSet( $color_flow->{_destination_index}, );

		#$flow_listbox_grey_w    ->selectionSet( $color_flow->{_destination_index},);

	}
}

=head2 sub flow_item_down_arrow_button

 	move items down in a flow listbox
    
=cut

sub flow_item_down_arrow_button {

	my ($self) = @_;
	my $prog_name;

	if ($flow_color) {

		_set_flow_color($flow_color);

		# switch between instances of the correct param_flow_color
		# param_flow_color stores Data
		_set_param_flow_color_i($flow_color);

		# $conditions_gui->set4start_of_flow_item_down_arrow_button($color_flow);

		use message_director;
		use decisions 1.00;

		my $color_flow_messages = message_director->new();
		my $decisions           = decisions->new();

		my $message = $color_flow_messages->null_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );

		$prog_name = ${ $color_flow->{_prog_name_sref} };

		#  get number of items in the flow listbox
		# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
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

			$color_flow->{_index2move}        = $current_flow_listbox_index;
			$color_flow->{_destination_index} = $destination_index;

			# modify flow listbox
			# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace

			# get all the elements from inside the listbox
			my @elements = $_flow_listbox_color_w->get( 0, 'end' );

			# rearrange elements
			my $saved_item = $elements[ $color_flow->{_index2move} ];

			$color_flow->{_flow_listbox_color_w}->delete( $color_flow->{_index2move} );
			$color_flow->{_flow_listbox_color_w}->insert( $color_flow->{_destination_index}, $saved_item );
			$color_flow->{_flow_listbox_color_w}->selectionSet( $color_flow->{_destination_index} );

			# note the last program that was touched
			$color_flow->{_last_flow_index_touched}         = $color_flow->{_destination_index};
			$color_flow->{_is_last_flow_index_touched_grey} = $true;

			# move stored data within arrays
			my $start = $color_flow->{_index2move};
			my $end   = $color_flow->{_destination_index};

			$param_flow_color_pkg->set_insert_start($start);
			$param_flow_color_pkg->set_insert_end($end);
			$param_flow_color_pkg->insert_selection();

			# update program versions if listbox changes
			# stored in param_flows
			_stack_versions();

			# update the parameter widget labels and their values

			# highlight new index
			_set_flow_listbox_color_w($flow_color);    # in "color"_flow namespace
			$_flow_listbox_color_w->selectionSet( $color_flow->{_destination_index}, );

			#$flow_listbox_grey_w    ->selectionSet( $color_flow->{_destination_index},);

			# carry out all gui updates needed
			flow_select();

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

		# switch between instances of the correct param_flow_color
		# param_flow_color stores Data
		_set_param_flow_color_i($flow_color);

		# $conditions_gui->set4start_of_flow_item_up_arrow_button($color_flow);

		use message_director;
		use decisions 1.00;

		my $color_flow_messages = message_director->new();
		my $decisions           = decisions->new();

		my $message = $color_flow_messages->null_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );

		$prog_name = ${ $color_flow->{_prog_name_sref} };

		#  get number of items in the flow listbox
		my $_flow_listbox_color_w = _get_flow_listbox_color_w();                            # user-built_flow in current use
		my $num_items             = $flow_widgets->get_num_items($_flow_listbox_color_w);

		# my $num_items 						= $flow_widgets->get_num_items($flow_listbox_grey_w);

		# get the current index

		my $current_flow_listbox_index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

		# the destination index will be one less
		my $destination_index = $current_flow_listbox_index - 1;
		if ( $destination_index <= 0 ) {
			$destination_index = 0;
		}    # limit min index

		# MEET THESE conditions, OR do NOTHING
		if (   $prog_name
			&& ( $current_flow_listbox_index > 0 )
			&& $destination_index >= 0 )
		{

			$color_flow->{_index2move}        = $current_flow_listbox_index;
			$color_flow->{_destination_index} = $destination_index;

			# note the last program that was touched
			$color_flow->{_last_flow_index_touched}         = $color_flow->{_destination_index};
			$color_flow->{_is_last_flow_index_touched_grey} = $true;

			# modify flow listbox#

			# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace

			# get all the elements from inside the listbox
			my @elements = $_flow_listbox_color_w->get( 0, 'end' );

			# rearrange elements
			my $saved_item = $elements[ $color_flow->{_index2move} ];

			$color_flow->{_flow_listbox_color_w}->delete( $color_flow->{_index2move} );
			$color_flow->{_flow_listbox_color_w}->insert( $color_flow->{_destination_index}, $saved_item );
			$color_flow->{_flow_listbox_color_w}->selectionSet( $color_flow->{_destination_index} );

			# note the last program that was touched
			$color_flow->{_last_flow_index_touched}         = $color_flow->{_destination_index};
			$color_flow->{_is_last_flow_index_touched_grey} = $true;

			# move stored data within arrays
			my $start = $color_flow->{_index2move};
			my $end   = $color_flow->{_destination_index};

			$param_flow_color_pkg->set_insert_start($start);
			$param_flow_color_pkg->set_insert_end($end);
			$param_flow_color_pkg->insert_selection();

			# update program versions if listbox changes
			# stored in param_flows
			_stack_versions();

			# highlight new index
			# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
			$_flow_listbox_color_w->selectionSet( $color_flow->{_destination_index}, );

			#$flow_listbox_grey_w    ->selectionSet( $color_flow->{_destination_index},);

			# carry out all gui updates needed
			flow_select();

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
  
  This module was placed here 
  for the case when there was only one item left in the
  listbox drag and drop became blocked
  
  N.B. Assume that _check4flow_changes will prove false in this case
  check whether any programs were deleted by dragging previously
  If so, delete stored values from param_flow
  
  if($color_flow->{_prog_name_sref}) {
 		print("\n1. color_flow flow_select, program name is $color_flow->{_prog_name_sref}\n");
 	}

  	gets from:
    	flow_widgets
    	param_widgets
  
  	sets 
   		param_flow
  		param_widgets
    color_flow

 	calls
 	  	_stack_versions
  		_check4flow_changes();
 		$conditions_gui->set4start_of_flow_select(); 
  		$conditions_gui->set4end_of_flow_select();
  	 $color_flow 			= $conditions_gui->get_hash_ref();
  	 
    	  foreach my $key (sort keys %$color_flow) {
           print (" color_flowkey is $key, value is $color_flow->{$key}\n");
          }
    	     	 
  	always takes focus on first entry ; index = 0
  	if focus is on first entry then also make the last_parameter_index_touched = 0
  	
  	TODO: via conditions package
    	  foreach my $key (sort keys %$color_flow) {
           print ("color_flow, key is $key, value is $color_flow->{$key}\n");
          }	  
          
    Important variables:
      $color_flow->{_prog_name_sref}  : selected program name as a scalar reference
      
    foreach my $key (sort keys %$color_flow) {
   			print (" color_flow key is $key, value is $color_flow->{$key}\n");
  	}
  	
=cut

sub flow_select {
	my ($self) = @_;

	use message_director;
	use decisions;

	$color_flow->{_flow_type} = $flow_type->{_user_built};

	# print("1. color_flow,flow_select, last_flow_index_touched:$color_flow->{_last_flow_index_touched}\n");
	# print("gui_history_aref = $gui_history_aref\n");
	# print("color_flow,flow_select, last_flow_color:$color_flow->{_last_flow_color}\n");

	# reset residual flow_listbox_color_w of another color
	_set_flow_listbox_color_w($flow_color);

	# switch between instances of the correct param_flow_color
	# param_flow_color stores Data
	_set_param_flow_color_i($flow_color);

	# print("2\n");
	# $param_flow_color_pkg->view_data();

	my $color_flow_messages = message_director->new();
	my $decisions           = decisions->new();

	my $message = $color_flow_messages->null_button(0);
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	$conditions_gui->set_gui_widgets($color_flow);
	$conditions_gui->set_hash_ref($color_flow);
	$conditions_gui->set4start_of_flow_select($flow_color);
	$color_flow = $conditions_gui->get_hash_ref();

	# print("2. color_flow,flow_select, last_flow_index_touched:$color_flow->{_last_flow_index_touched}\n");

	# $param_flow_color_pkg->view_data();

	# update the flow color as per add2flow_select
	my $_flow_listbox_color_w = _get_flow_listbox_color_w();

	$color_flow->{_prog_name_sref} = $flow_widgets->get_current_program( \$_flow_listbox_color_w );

=pod

CASE 1: When flow_select is being used for the first time
BUT when no previous flow has been selected
This case can occur when a flow is read into a GUI which is used
for the first time that is when no listboxes have been occupied previously

=cut

	if (  !( $color_flow->{_last_flow_color} )
		|| ( $color_flow->{_last_flow_color} eq $empty_string ) )
	{

		# print("color_flow,flow_select, CASE #1 \n");
		# print( "color_flow,flow_select, color_flow->{_last_flow_color}=$color_flow->{_last_flow_color}\n" );

		$color_flow->{_last_flow_color} = $color_flow->{_flow_color};

		$color_flow->{_is_last_flow_index_touched_grey}      = $true;
		$color_flow->{_is_last_parameter_index_touched_grey} = $true;
		my $num_indices = $flow_widgets->get_num_indices( \$_flow_listbox_color_w );
		$color_flow->{_last_flow_index_touched}            = -1;    # $num_indices;
		$color_flow->{_last_parameter_index_touched_color} = 0;

=pod

CASE 2 flow_select is used actively by the user for the first time
The first flow of the session has already been run and saved
BUT if the flow has never been actively selected by the user then the following parameters are not activated
and so the internal parameters of the flow items will not get saved at the start of this subroutine.
This can happen when user
(1) loads, saves and runs a pre-built user-flow
selects a new flow item
WITHOUT selecting an existant flow item
Does not happen if the user chooses a flow item before going on to select a new sunix
program

=cut

	}
	elsif ($color_flow->{_last_flow_color} eq 'neutral'
		&& defined $color_flow->{_flow_color}
		&& $color_flow->{_flow_color} eq $this_color
		&& defined $color_flow->{_prog_name_sref}
		&& $color_flow->{_prog_name_sref} ne $empty_string
		&& !( $color_flow->{_is_last_flow_index_touched_grey} )
		&& !( $color_flow->{_is_last_flow_index_touched_pink} )
		&& !( $color_flow->{_is_last_flow_index_touched_green} )
		&& !( $color_flow->{_is_last_flow_index_touched_blue} ) )
	{

		# print("CASE # 2\n");
		# $param_flow_color_pkg->view_data();

		$color_flow->{_last_flow_color} = $color_flow->{_flow_color};

		$color_flow->{_is_last_flow_index_touched_grey}      = $true;
		$color_flow->{_is_last_parameter_index_touched_grey} = $true;
		my $num_indices = $flow_widgets->get_num_indices( \$_flow_listbox_color_w );
		$color_flow->{_last_flow_index_touched}            = $num_indices;
		$color_flow->{_last_parameter_index_touched_color} = 0;

	}

=pod

CASE 3
Flow selected is used a second time only

=cut

	else {
		# print("color_flow,flow_select CASE NADA\n");
		# print( "1 color_flow , flow_select, last_flow_color is:  $color_flow->{_last_flow_color}\n" );
		# print( "1 color_flow , flow_select, flow_color is:  $color_flow->{_flow_color}\n" );
		# print("1 color_flow , flow_select, this flow color is:  $this_color\n");
		# print( "1 color_flow , flow_select, _is_last_flow_index_touched_grey:  $color_flow->{_is_last_flow_index_touched_grey}\n" );
		# print( "1 color_flow , flow_select, _is_last_flow_index_touched_gpink:  $color_flow->{_is_last_flow_index_touched_pink}\n" );
		# print( "1 color_flow , flow_select, _is_last_flow_index_touched_green:  $color_flow->{_is_last_flow_index_touched_green}\n" );
		# print( "1 color_flow , flow_select, _is_last_flow_index_touched_blue:  $color_flow->{_is_last_flow_index_touched_blue}\n" );
		# print( "1 color_flow , flow_select, last_flow_index_touched:  $color_flow->{_last_flow_index_touched}\n" );
	}

	$decisions->set4flow_select($color_flow);

	# print("4\n");
	# $param_flow_color_pkg->view_data();

	my $pre_req_ok = $decisions->get4flow_select();

	if ($pre_req_ok) {

		use binding;
		my $binding = binding->new();
		my $here;

		$color_flow->{_prog_name_sref} = $flow_widgets->get_current_program( \$_flow_listbox_color_w );

		# print("5 flow_select \n");
		# $param_flow_color_pkg->view_data();

		# consider flow-color changes
		# unticked strings from GUI are corrected here
		_check4flow_changes();

		# print("6 flow_select \n");
		# $param_flow_color_pkg->view_data();

		# Update last flow color in case it does not get updated by _check4flow_changes (above)
		# flow selection needs to update the last flow color selected by the user
		$color_flow->{_last_flow_color} = $flow_color;

		# for export
		$last_flow_color = $flow_color;

		# my $value = @{$color_flow->{_values_w_aref}}[1]->get;

		# for just-selected program name
		# get its flow parameters from storage
		# and redisplay the widgets with parameters

		# Update the flow item index to the program that is currently being used, instead of last-used program
		# Warning: Flow selection gets reset if user double-clicks on a parameter value
		# in another window
		my $index = $flow_widgets->get_flow_selection($_flow_listbox_color_w);

		# number of programs in flow
		# my $num_items 					= $param_flow_color_pkg->get_num_items();

		$param_flow_color_pkg->set_flow_index($index);
		$color_flow->{_names_aref}  = $param_flow_color_pkg->get_names_aref();
		$color_flow->{_values_aref} = $param_flow_color_pkg->get_values_aref();

		# print("2\n");
		# $param_flow_color_pkg->view_data();

		$color_flow->{_check_buttons_settings_aref} = $param_flow_color_pkg->get_check_buttons_settings();

		# get stored first index and num of items
		$color_flow->{_param_flow_first_idx} = $param_flow_color_pkg->first_idx();
		$color_flow->{_param_flow_length}    = $param_flow_color_pkg->length();

		$param_widgets->set_current_program( $color_flow->{_prog_name_sref} );

		$whereami->set4flow_listbox($flow_color);
		$here = $whereami->get4flow_listbox();

		$param_widgets->set_location_in_gui($here);

		# widgets were initialized in super class
		$param_widgets->set_labels_w_aref( $color_flow->{_labels_w_aref} );
		$param_widgets->set_values_w_aref( $color_flow->{_values_w_aref} );
		$param_widgets->set_check_buttons_w_aref( $color_flow->{_check_buttons_w_aref} );

		# wipes out values labels and checkbuttons from the gui
		$param_widgets->gui_full_clear();
		$param_widgets->range($color_flow);
		$param_widgets->set_labels( $color_flow->{_names_aref} );
		$param_widgets->set_values( $color_flow->{_values_aref} );
		$param_widgets->set_check_buttons( $color_flow->{_check_buttons_settings_aref} );

		$whereami->set4flow_listbox($flow_color);
		$here = $whereami->get4flow_listbox();

		# print("3\n");
		# $param_flow_color_pkg->view_data();

		$param_widgets->set_location_in_gui($here);
		$param_widgets->redisplay_labels();
		$param_widgets->redisplay_values();
		$param_widgets->redisplay_check_buttons();
		$param_widgets->set_entry_change_status($false);

		my @Entry_widget = @{ $param_widgets->get_values_w_aref() };

		$Entry_widget[0]->focus;    # always put focus on first entry widget

		# Force the parameter index = 0 (this is NOT the flow index that marks the index of the programs in the flow);
		# If parameter_index >= 0 stored values will also be updated via check4parameter_changes
		# TODO the parameter_index_touched may become  .n.e. 0 but >=0
		# $color_flow->{_last_parameter_index_touched_color} = 0;
		# the changed parameter value in the Entry widget should force an update of stored values
		# in the current flow item (not the last flow item touched)
		# _check4parameter_changes(); # is only active if $color_flow->{_last_parameter_index_touched_color} >= 0

		# Here is where you rebind the different buttons depending on the
		# program name that is selected (i.e., through spec.pm)
		$binding->set_prog_name_sref( $color_flow->{_prog_name_sref} );
		$binding->set_values_w_aref( $param_widgets->get_values_w_aref );

		#reference to local subroutine that will be run when MB3 is pressed
		$binding->setFileDialog_button_sub_ref( \&_FileDialog_button );
		$binding->set();

		$conditions_gui->set_gui_widgets($color_flow);
		$conditions_gui->set_hash_ref($color_flow);
		$conditions_gui->set4end_of_flow_select($flow_color);
		$conditions_gui->set_flow_index_last_touched($index);

		$color_flow = $conditions_gui->get_hash_ref();    # now color_flow= 0; flow_type=user_built

		# Here is where you update th entry button value that displays the currently active
		# flow or superflow name, by using the currently selected program name from the flow list
		# e.g. data_in, suximage, suxgraph etc.

		$color_flow->{_flowNsuperflow_name_w}->configure( -text => ${ $color_flow->{_prog_name_sref} } );

		# needed in possible export via get_hash_ref to help
		$prog_name_sref = $color_flow->{_prog_name_sref};

		return ();
	}    # end pre_ok
}

=head2 sub get_hash_ref 

	exports private hash
	
	46 
 
=cut

sub get_hash_ref {
	my ($self) = @_;

	$color_flow->{_Data_menubutton}             = $Data_menubutton;
	$color_flow->{_Flow_menubutton}             = $Flow_menubutton;
	$color_flow->{_FileDialog_sub_ref}          = $FileDialog_sub_ref;
	$color_flow->{_FileDialog_option}           = $FileDialog_option;
	$color_flow->{_SaveAs_menubutton}           = $SaveAs_menubutton;
	$color_flow->{_add2flow_button_grey}        = $add2flow_button_grey;
	$color_flow->{_add2flow_button_pink}        = $add2flow_button_pink;
	$color_flow->{_add2flow_button_green}       = $add2flow_button_green;
	$color_flow->{_add2flow_button_blue}        = $add2flow_button_blue;
	$color_flow->{_check_code_button}           = $check_code_button;
	$color_flow->{_check_buttons_w_aref}        = $check_buttons_w_aref;
	$color_flow->{_delete_from_flow_button}     = $delete_from_flow_button;
	$color_flow->{_dnd_token_grey}              = $dnd_token_grey;
	$color_flow->{_dnd_token_pink}              = $dnd_token_pink;
	$color_flow->{_dnd_token_green}             = $dnd_token_green;
	$color_flow->{_dnd_token_blue}              = $dnd_token_blue;
	$color_flow->{_dropsite_token_grey}         = $dropsite_token_grey;
	$color_flow->{_dropsite_token_pink}         = $dropsite_token_pink;
	$color_flow->{_dropsite_token_green}        = $dropsite_token_green;
	$color_flow->{_dropsite_token_blue}         = $dropsite_token_blue;
	$color_flow->{_file_menubutton}             = $file_menubutton;
	$color_flow->{_flow_item_down_arrow_button} = $flow_item_down_arrow_button;
	$color_flow->{_flow_item_up_arrow_button}   = $flow_item_up_arrow_button;
	$color_flow->{_flow_listbox_grey_w}         = $flow_listbox_grey_w;
	$color_flow->{_flow_listbox_pink_w}         = $flow_listbox_pink_w;
	$color_flow->{_flow_listbox_green_w}        = $flow_listbox_green_w;
	$color_flow->{_flow_listbox_blue_w}         = $flow_listbox_blue_w;
	$color_flow->{_flowNsuperflow_name_w}       = $flowNsuperflow_name_w;
	$color_flow->{_flow_name_grey_w}            = $flow_name_grey_w;
	$color_flow->{_flow_name_pink_w}            = $flow_name_pink_w;
	$color_flow->{_flow_name_green_w}           = $flow_name_green_w;
	$color_flow->{_flow_name_blue_w}            = $flow_name_blue_w;

	$color_flow->{_gui_history_aref} = $gui_history_aref;

	#  	 	$color_flow->{_is_flow_listbox_grey_w}		= $is_flow_listbox_grey_w;   # set in condition_gui
	#  	 	$color_flow->{_is_flow_listbox_pink_w}		= $is_flow_listbox_pink_w;   # set in condition_gui
	#  	 	$color_flow->{_is_flow_listbox_green_w}		= $is_flow_listbox_green_w;  # set in condition_gui
	#  	 	$color_flow->{_is_flow_listbox_blue_w}		= $is_flow_listbox_blue_w;   # set in condition_gui

	$color_flow->{_is_pre_built_superflow} = $is_pre_built_superflow;
	$color_flow->{_is_user_built_flow}     = $is_user_built_flow;
	$color_flow->{_labels_w_aref}          = $labels_w_aref;
	$color_flow->{_last_flow_color}        = $last_flow_color;

	#	$color_flow->{_lightning_button}       = $lightning_button;
	$color_flow->{_message_w}                     = $message_w;
	$color_flow->{_mw}                            = $mw;
	$color_flow->{_parameter_names_frame}         = $parameter_names_frame;
	$color_flow->{_parameter_values_frame}        = $parameter_values_frame;
	$color_flow->{_parameter_values_button_frame} = $parameter_values_button_frame;
	$color_flow->{_prog_name_sref}                = $prog_name_sref;
	$color_flow->{_run_button}                    = $run_button;
	$color_flow->{_save_button}                   = $save_button;
	$color_flow->{_sunix_listbox}                 = $sunix_listbox;
	$color_flow->{_values_w_aref}                 = $values_w_aref;

	# $color_flow->{_flow_name_color_w}			= $flow_name_color_w; do not export
	# $color_flow->{_flow_color}					= $flow_color;
	return ($color_flow);

}

=head2 sub get_flow_color

	exports private hash value
 
=cut

sub get_flow_color {
	my ($self) = @_;

	if ( $color_flow->{_flow_color} ) {
		my $color;

		$color = $color_flow->{_flow_color};
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

	if ( $color_flow->{_flow_type} ) {
		my $flow_type;

		$flow_type = $color_flow->{_flow_type};
		return ($flow_type);

	}
	else {
		print("color_flow, missing flow type\n");
	}

}

=head2 sub get_last_flow_color
	
		returns current color ($this_color) as the last fow color
 	    get_hash_ref is intentionally not used 
 	    and a specific method is used for simplicity
 	    
=cut

sub get_last_flow_color {

	my ($self) = @_;

	if ( $color_flow->{_flow_color} ) {

		$color_flow->{_last_flow_color} = $color_flow->{_flow_color};

		# for export
		$last_flow_color = $color_flow->{_last_flow_color};

		return ($last_flow_color);

	}
	else {
		print("color_flow, set_last_flow_color,  flow_color missing \n");
	}

	return ();
}

=head2 sub get_prog_name_sref 

	exports private hash value
 
=cut

sub get_prog_name_sref {
	my ($self) = @_;

	if ( $color_flow->{_prog_name_sref} ) {
		my $name;

		$name = $color_flow->{_prog_name_sref};
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

	$decisions->set4help($color_flow);
	$pre_req_ok = $decisions->get4help();

	if ($pre_req_ok) {

		$help->set_name( $color_flow->{_prog_name_sref} );
		$help->tkpod();

	}
	else {

	}

	return ();
}

#=head2 sub lightning_button
#
#		remove item in a flow listbox
#
#=cut
#
#sub lightning_button {
#
#	my ($self) = @_;
#	my $prog_name;
#
#	if ($flow_color) {
#		_set_flow_color($flow_color);
#
#		# switch between instances of the correct param_flow_color
#		# param_flow_color stores Data
#		_set_param_flow_color_i($flow_color);
#
#	}
#	else {
#		print("color_flow, lightning_button missing color \n");
#	}
#
#}

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

	#Double-check we are in the correct place:

	if ( $topic eq 'Save' ) {

		use files_LSU;
		use control;

		my $files_LSU = new files_LSU();
		my $control   = new control();

		# user-built_flow in current use
		my $flow_listbox_color_w = _get_flow_listbox_color_w();

		# Start refocus index in flow, in case focus has been removed
		# e.g., by double-clicking in parameter values window
		my $last_flow_index = $color_flow->{_last_flow_index_touched};
		$last_flow_color = $color_flow->{_last_flow_color};

		if (   $last_flow_color
			&& $last_flow_index
			&& $flow_listbox_color_w )
		{
			# print("CASE 1 grey_flow, save_button \n");
			# BUT one parameter-index (=0) has been selected then
			# assume that the recent selection is valid for this current save

			$flow_listbox_color_w->selectionSet($last_flow_index);

		}
		else {
			print("grey_flow, save_button , unexpected missing variables NADA\n");
		}

=pod
A CASE considered When save_button is being used for the first time
BUT when no flow has been selected previously (_last_flow_index_touched=-1)
This case can occur when a flow is read into a GUI which is used
for the first time that is when no listboxes have been occupied previously
		
=cut

		# switch between instances of the correct param_flow_color
		# param_flow_color stores Data
		_set_param_flow_color_i($flow_color);
		$param_flow_color_pkg->set_flow_index($last_flow_index);

		# collect the values from the stored Data in param_flow
		# because the values from the widgets have not been updated
		$color_flow->{_values_aref} = $param_flow_color_pkg->get_values_aref();

		# restore strings to have terminal strings
		# remove quotes upon input
		$color_flow->{_values_aref} =
			$control->get_no_quotes4array( $color_flow->{_values_aref} );

		# in case parameter values have been displayed stringless
		$color_flow->{_values_aref} =
			$control->get_string_or_number4array( $color_flow->{_values_aref} );

		$color_flow->{_last_parameter_index_touched_color}   = 0;
		$color_flow->{_is_last_parameter_index_touched_grey} = $true;

		# update changes to parameter values between 'SaveAs' and 'Save'
		# assume a parameter index has been changed so that
		# _check4parameter_changes is forced to update changes before updating
		# these changes via param_flow
		_check4parameter_changes();
		_check4flow_changes();

		# $conditions_gui				-> set_gui_widgets($color_flow);  # uses 29/  114 in
		# $conditions_gui				-> set_hash_ref($color_flow);     # uses 70/  114 in
		# $conditions_gui				-> set4start_of_SaveAs_button();	# sets 2

		$color_flow->{_names_aref} = $param_flow_color_pkg->get_names_aref();

		$param_flow_color_pkg->set_good_values();
		$param_flow_color_pkg->set_good_labels();

		$color_flow->{_good_labels_aref2}   = $param_flow_color_pkg->get_good_labels_aref2();
		$color_flow->{_items_versions_aref} = $param_flow_color_pkg->get_flow_items_version_aref();
		$color_flow->{_good_values_aref2}   = $param_flow_color_pkg->get_good_values_aref2();
		$color_flow->{_prog_names_aref}     = $param_flow_color_pkg->get_flow_prog_names_aref();

		$files_LSU->set_prog_param_labels_aref2($color_flow);    # uses 1 / 114 in
		$files_LSU->set_prog_param_values_aref2($color_flow);    # uses 1 / 114 in
		$files_LSU->set_prog_names_aref($color_flow);            # uses 1 / 114 in
		$files_LSU->set_items_versions_aref($color_flow);        # uses 1 / 114 in
		$files_LSU->set_data();
		$files_LSU->set_message($color_flow);                    # uses 1 / 114 in
		                                                         # update PL_SEISMIC in case user has changed project area
		$files_LSU->set_PL_SEISMIC();
		$files_LSU->set2pl($color_flow);                         # flows saved to PL_SEISMIC
		$files_LSU->save();

		#		$conditions_gui	->set4end_of_SaveAs_button();   			# uses 2/
		#		$color_flow 	= $conditions_gui->get_hash_ref();   		# returns 89

	}
	else {
		print("color_flow, missing topic Save\n");
	}
	return ();
}

=head2 sub set_hash_ref

	copies with simplified names are also kept (40) so later
	the hash can be returned to a calling module
	
	imports external hash into private settings 
 	48 and 48 
 	
 	local extra  
 	
=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	$color_flow->{_Data_menubutton}             = $hash_ref->{_Data_menubutton};
	$color_flow->{_Flow_menubutton}             = $hash_ref->{_Flow_menubutton};
	$color_flow->{_FileDialog_sub_ref}          = $hash_ref->{_FileDialog_sub_ref};
	$color_flow->{_FileDialog_option}           = $hash_ref->{_FileDialog_option};
	$color_flow->{_SaveAs_menubutton}           = $hash_ref->{_SaveAs_menubutton};
	$color_flow->{_add2flow_button_grey}        = $hash_ref->{_add2flow_button_grey};
	$color_flow->{_add2flow_button_pink}        = $hash_ref->{_add2flow_button_pink};
	$color_flow->{_add2flow_button_green}       = $hash_ref->{_add2flow_button_green};
	$color_flow->{_add2flow_button_blue}        = $hash_ref->{_add2flow_button_blue};
	$color_flow->{_check_code_button}           = $hash_ref->{_check_code_button};
	$color_flow->{_check_buttons_w_aref}        = $hash_ref->{_check_buttons_w_aref};
	$color_flow->{_delete_from_flow_button}     = $hash_ref->{_delete_from_flow_button};
	$color_flow->{_dialog_type}                 = $hash_ref->{_dialog_type};
	$color_flow->{_dnd_token_grey}              = $hash_ref->{_dnd_token_grey};
	$color_flow->{_dnd_token_pink}              = $hash_ref->{_dnd_token_pink};
	$color_flow->{_dnd_token_green}             = $hash_ref->{_dnd_token_green};
	$color_flow->{_dnd_token_blue}              = $hash_ref->{_dnd_token_blue};
	$color_flow->{_dropsite_token_grey}         = $hash_ref->{_dropsite_token_grey};
	$color_flow->{_dropsite_token_pink}         = $hash_ref->{_dropsite_token_pink};
	$color_flow->{_dropsite_token_green}        = $hash_ref->{_dropsite_token_green};
	$color_flow->{_dropsite_token_blue}         = $hash_ref->{_dropsite_token_blue};
	$color_flow->{_file_menubutton}             = $hash_ref->{_file_menubutton};
	$color_flow->{_flow_color}                  = $hash_ref->{_flow_color};
	$color_flow->{_flow_item_down_arrow_button} = $hash_ref->{_flow_item_down_arrow_button};
	$color_flow->{_flow_item_up_arrow_button}   = $hash_ref->{_flow_item_up_arrow_button};
	$color_flow->{_flow_listbox_grey_w}         = $hash_ref->{_flow_listbox_grey_w};
	$color_flow->{_flow_listbox_pink_w}         = $hash_ref->{_flow_listbox_pink_w};
	$color_flow->{_flow_listbox_green_w}        = $hash_ref->{_flow_listbox_green_w};
	$color_flow->{_flow_listbox_blue_w}         = $hash_ref->{_flow_listbox_blue_w};
	$color_flow->{_flowNsuperflow_name_w}       = $hash_ref->{_flowNsuperflow_name_w};
	$color_flow->{_flow_name_grey_w}            = $hash_ref->{_flow_name_grey_w};
	$color_flow->{_flow_name_pink_w}            = $hash_ref->{_flow_name_pink_w};
	$color_flow->{_flow_name_green_w}           = $hash_ref->{_flow_name_green_w};
	$color_flow->{_flow_name_blue_w}            = $hash_ref->{_flow_name_blue_w};
	$color_flow->{_is_pre_built_superflow}      = $hash_ref->{_is_pre_built_superflow};
	$color_flow->{_is_user_built_flow}          = $hash_ref->{_is_user_built_flow};

	$color_flow->{_gui_history_aref} = $hash_ref->{_gui_history_aref};
	$color_flow->{_labels_w_aref}    = $hash_ref->{_labels_w_aref};
	$color_flow->{_last_flow_color}  = $hash_ref->{_last_flow_color};

	#	$color_flow->{_lightning_button}      = $hash_ref->{_lightning_button};
	$color_flow->{_message_w}                     = $hash_ref->{_message_w};
	$color_flow->{_mw}                            = $hash_ref->{_mw};
	$color_flow->{_parameter_names_frame}         = $hash_ref->{_parameter_names_frame};
	$color_flow->{_parameter_values_frame}        = $hash_ref->{_parameter_values_frame};
	$color_flow->{_parameter_values_button_frame} = $hash_ref->{_parameter_values_button_frame};
	$color_flow->{_prog_name_sref}                = $hash_ref->{_prog_name_sref};
	$color_flow->{_run_button}                    = $hash_ref->{_run_button};
	$color_flow->{_save_button}                   = $hash_ref->{_save_button};
	$color_flow->{_sunix_listbox}                 = $hash_ref->{_sunix_listbox};
	$color_flow->{_values_w_aref}                 = $hash_ref->{_values_w_aref};

	# $color_flow->{_flow_name_color_w				= $hash_ref->{_flow_name_color_w}; do not import

	#private and for potential export
	$Data_menubutton             = $hash_ref->{_Data_menubutton};
	$Flow_menubutton             = $hash_ref->{_Flow_menubutton};
	$FileDialog_sub_ref          = $hash_ref->{_FileDialog_sub_ref};
	$FileDialog_option           = $hash_ref->{_FileDialog_option};
	$SaveAs_menubutton           = $hash_ref->{_SaveAs_menubutton};
	$add2flow_button_grey        = $hash_ref->{_add2flow_button_grey};
	$add2flow_button_pink        = $hash_ref->{_add2flow_button_pink};
	$add2flow_button_green       = $hash_ref->{_add2flow_button_green};
	$add2flow_button_blue        = $hash_ref->{_add2flow_button_blue};
	$check_code_button           = $hash_ref->{_check_code_button};
	$check_buttons_w_aref        = $hash_ref->{_check_buttons_w_aref};
	$delete_from_flow_button     = $hash_ref->{_delete_from_flow_button};
	$dialog_type                 = $hash_ref->{_dialog_type};
	$dnd_token_grey              = $hash_ref->{_dnd_token_grey};
	$dnd_token_pink              = $hash_ref->{_dnd_token_pink};
	$dnd_token_green             = $hash_ref->{_dnd_token_green};
	$dnd_token_blue              = $hash_ref->{_dnd_token_blue};
	$dropsite_token_grey         = $hash_ref->{_dropsite_token_grey};
	$dropsite_token_pink         = $hash_ref->{_dropsite_token_pink};
	$dropsite_token_green        = $hash_ref->{_dropsite_token_green};
	$dropsite_token_blue         = $hash_ref->{_dropsite_token_blue};
	$file_menubutton             = $hash_ref->{_file_menubutton};
	$flow_color                  = $hash_ref->{_flow_color};
	$flow_item_down_arrow_button = $hash_ref->{_flow_item_down_arrow_button};
	$flow_item_up_arrow_button   = $hash_ref->{_flow_item_up_arrow_button};
	$flow_listbox_grey_w         = $hash_ref->{_flow_listbox_grey_w};
	$flow_listbox_pink_w         = $hash_ref->{_flow_listbox_pink_w};
	$flow_listbox_green_w        = $hash_ref->{_flow_listbox_green_w};
	$flow_listbox_blue_w         = $hash_ref->{_flow_listbox_blue_w};
	$flowNsuperflow_name_w       = $hash_ref->{_flowNsuperflow_name_w};
	$flow_name_grey_w            = $hash_ref->{_flow_name_grey_w};
	$flow_name_pink_w            = $hash_ref->{_flow_name_pink_w};
	$flow_name_green_w           = $hash_ref->{_flow_name_green_w};
	$flow_name_blue_w            = $hash_ref->{_flow_name_blue_w};
	$flowNsuperflow_name_w       = $hash_ref->{_flowNsuperflow_name_w};
	$gui_history_aref            = $hash_ref->{_gui_history_aref};
	$is_pre_built_superflow      = $hash_ref->{_is_pre_built_superflow};
	$is_user_built_flow          = $hash_ref->{_is_user_built_flow};
	$labels_w_aref               = $hash_ref->{_labels_w_aref};
	$last_flow_color             = $hash_ref->{_last_flow_color};               # used in flow_select

	#	$lightning_button = $hash_ref->{_lightning_button};
	$message_w                     = $hash_ref->{_message_w};
	$mw                            = $hash_ref->{_mw};
	$parameter_names_frame         = $hash_ref->{_parameter_names_frame};
	$parameter_values_frame        = $hash_ref->{_parameter_values_frame};
	$parameter_values_button_frame = $hash_ref->{_parameter_values_button_frame};
	$prog_name_sref                = $hash_ref->{_prog_name_sref};
	$save_button                   = $hash_ref->{_save_button};
	$sunix_listbox                 = $hash_ref->{_sunix_listbox};
	$values_w_aref                 = $hash_ref->{_values_w_aref};

	# $flow_name_color_w					= $hash_ref->{_flow_name_color_w}; do not import

	return ();
}

=head2 sub set_occupied_listbox_aref


=cut

sub set_occupied_listbox_aref {

	my ( $self, $occupied_listbox_aref ) = @_;

	if ($occupied_listbox_aref) {

		$color_flow->{_occupied_listbox_aref} = $occupied_listbox_aref;

	}
	else {
		print("color_flow,_set_occupied_listbox_aref, missing occupied_listbox_aref \n");
	}

}

1;
