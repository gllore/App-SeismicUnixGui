package run_button;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: run_button.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 16 2018 

 DESCRIPTION 
     
 BASED ON:
 
 previous version (V 0.2) of the main L_SU.pl (V 0.3)
  
=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl
 
 TODO: Encapsulate better
 
  gets from
  	$decisions
  	$run_button
  	$name->get_alias_superflow_names
  sets
  	$pre_req_ok
  	
  calls 
	$conditions_gui		->set4run_button_start();
	$conditions_gui		->set4run_button();     
	$decisions		      	->set4run_select($run_button);
	$conditions_gui		->set4run_button_end();
	$whereami				->in_gui();
	message box: 			$message
	$run_button 			= $conditions_gui->get_hash_ref();	
	
=cut 

=head2 Notes from bash
 
=cut 

use Moose;
our $VERSION = '0.0.1';

use Tk;
use conditions_gui;
use decisions 1.00;

# potentially used in all packages
use L_SU_global_constants;
use name;
use message_director;

# use control;
use whereami;

my $decisions           = decisions->new();
my $get                 = L_SU_global_constants->new();
my $conditions_gui      = conditions_gui->new();
my $name                = name->new();
my $run_button_messages = message_director->new();
my $whereami            = whereami->new();

my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type_h      = $get->flow_type_href();

my $var             = $get->var();
my $on              = $var->{_on};
my $true            = $var->{_true};
my $false           = $var->{_false};
my $superflow_names = $get->superflow_names_h();
my $global_libs     = $get->global_libs();

# print("L_SU,run_button,flow_name_out: $run_button->{_flow_name_out}\n");

=head2 declare variables

	8 off

=cut

my $message_w;
my $mw;
my $parameter_values_frame;
my $parameter_value_index;
my $values_aref;
my ( $flow_listbox_grey_w, $flow_listbox_pink_w, $flow_listbox_green_w, $flow_listbox_blue_w );
my $sub_ref;

=head2 private hash

125 off

not in calling module L_SU: 
	_flow_name_out

=cut

my $run_button = {

	_Data_menubutton                       => '',
	_Flow_menubutton                       => '',
	_FileDialog_sub_ref                    => '',
	_FileDialog_option                     => '',
	_add2flow_button_grey                  => '',
	_add2flow_button_pink                  => '',
	_add2flow_button_green                 => '',
	_add2flow_button_blue                  => '',
	_check_code_button                     => '',
	_check_buttons_settings_aref           => '',
	_check_buttons_w_aref                  => '',
	_delete_from_flow_button               => '',
	_destination_index                     => '',
	_dialog_type                           => '',     #set_dialog_type
	_dnd_token_grey                        => '',
	_dnd_token_pink                        => '',
	_dnd_token_green                       => '',
	_dnd_token_blue                        => '',
	_dropsite_token_grey                   => '',
	_dropsite_token_pink                   => '',
	_dropsite_token_green                  => '',
	_dropsite_token_blue                   => '',
	_file_menubutton                       => '',
	_flow_color                            => '',
	_flow_item_down_arrow_button           => '',
	_flow_item_up_arrow_button             => '',
	_flow_listbox_grey_w                   => '',
	_flow_listbox_pink_w                   => '',
	_flow_listbox_green_w                  => '',
	_flow_listbox_blue_w                   => '',
	_flow_listbox_color_w                  => '',
	_flow_name_grey_w                      => '',
	_flow_name_pink_w                      => '',
	_flow_name_green_w                     => '',
	_flow_name_blue_w                      => '',
	_flow_name_in                          => '',
	_flow_name_out                         => '',
	_flow_type                             => '',     # set_flow_type
	_flow_widget_index                     => '',
	_flowNsuperflow_name_w                 => '',
	_good_labels_aref2                     => '',
	_good_values_aref2                     => '',
	_has_used_check_code_button            => '',
	_has_used_open_perl_file_button        => '',
	_has_used_Save_button                  => '',
	_has_used_Save_superflow               => '',
	_has_used_SaveAs_button                => '',
	_has_used_run_button                   => '',
	_index2move                            => '',
	_is_SaveAs_file_button                 => '',
	_is_SaveAs_button                      => '',
	_is_Save_button                        => '',
	_is_add2flow_button                    => '',
	_is_check_code_button                  => '',
	_is_delete_from_flow_button            => '',
	_is_dragNdrop                          => '',
	_is_flow_item_down_arrow_button        => '',
	_is_flow_item_up_arrow_button          => '',
	_is_flow_listbox_grey_w                => '',
	_is_flow_listbox_green_w               => '',
	_is_flow_listbox_pink_w                => '',
	_is_flow_listbox_blue_w                => '',
	_is_flow_listbox_color_w               => '',
	_is_last_flow_index_touched            => '',
	_is_last_flow_index_touched_grey       => '',
	_is_last_flow_index_touched_pink       => '',
	_is_last_flow_index_touched_green      => '',
	_is_last_flow_index_touched_blue       => '',
	_is_last_parameter_index_touched_color => '',
	_is_last_parameter_index_touched_grey  => '',
	_is_last_parameter_index_touched_pink  => '',
	_is_last_parameter_index_touched_green => '',
	_is_last_parameter_index_touched_blue  => '',
	_is_moveNdrop_in_flow                  => '',
	_is_new_listbox_selection              => '',
	_is_open_file_button                   => '',
	_is_pre_built_superflow                => '',
	_is_prog_name                          => '',
	_is_run_button                         => '',
	_is_select_file_button                 => '',
	_is_selected_file_name                 => '',
	_is_selected_path                      => '',
	_is_sunix_listbox                      => '',
	_is_superflow                          => '',     # should it be _pre_built_superflow?
	_is_superflow_select_button            => '',
	_is_user_built_flow                    => '',
	_items_checkbuttons_aref2              => '',
	_items_names_aref2                     => '',
	_items_values_aref2                    => '',
	_items_versions_aref                   => '',
	_labels_w_aref                         => '',
	_last_flow_index_touched               => -1,
	_last_flow_index_touched_grey          => -1,
	_last_flow_index_touched_pink          => -1,
	_last_flow_index_touched_green         => -1,
	_last_flow_index_touched_blue          => -1,
	_last_flow_listbox_touched             => '',
	_last_flow_listbox_touched_w           => '',
	_last_parameter_index_touched_color    => -1,
	_last_parameter_index_touched_grey     => -1,
	_last_parameter_index_touched_pink     => -1,
	_last_parameter_index_touched_green    => -1,
	_last_parameter_index_touched_blue     => -1,
	_last_path_touched                     => './',
	_message_w                             => '',
	_mw                                    => '',     # main window widget
	_names_aref                            => '',
	_occupied_listbox_aref                 => '',
	_param_flow_length                     => '',
	_parameter_names_frame                 => '',
	_param_sunix_first_idx                 => 0,
	_param_sunix_length                    => '',
	_parameter_values_frame                => '',
	_parameter_values_button_frame         => '',
	_parameter_value_index                 => '',
	_path                                  => '',
	_prog_names_aref                       => '',
	_prog_name_sref                        => '',     # set_prog_name_sref
	_run_button                            => '',
	_save_button                           => '',
	_selected_file_name                    => '',
	_sub_ref                               => '',
	_sunix_listbox                         => '',     # pre-built-superflow or flow name as well
	_superflow_first_idx                   => '',
	_superflow_length                      => '',
	_values_aref                           => '',
	_values_w_aref                         => '',

};

=head2 _Run_pre_built_superflow
 
 	only useful for saved superflow configuration files
 	
 	decisions.pm tests:
 	_has_used_SaveAs_file_button
 	_has_used_Save_button

    	  foreach my $key (sort keys %$run_button) {
           print (" run_button,_Run_pre_built_superflow: key is $key, value is $run_button->{$key}\n");
          }
 	
=cut

sub _Run_pre_built_superflow {
	my ($self) = @_;

	my $message = $run_button_messages->null_button(0);
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# print("1.run_button, _values_aref[0]: @{$run_button->{_values_aref}}[0]\n");
	$conditions_gui->set_hash_ref($run_button);              #3 5 used / 80 in
	$conditions_gui->set_gui_widgets($run_button);           # 22 used/ 80 in
	$conditions_gui->set4start_of_superflow_run_button();    # 1 set
	$run_button = $conditions_gui->get_hash_ref();

	# print("2. L_SU, run_button, _values_aref[0]: @{$run_button->{_values_aref}}[0]\n");
	$decisions->set4run_select($run_button);                 # 2 used/ 80 in
	my $pre_req_ok = $decisions->get4run_select();

	# print("1. run_button,_Run_pre_built_superflow\n");
	# must have saved files already
	if ($pre_req_ok) {

		# print("2. run_button,_Run_pre_built_superflow, passed pre_ok check\n");
		# if( $run_button->{_is_superflow_select_button} ) {
		# 	print("3. run_button,program name is ${$run_button->{_prog_name_sref}}\n");
		# }

		my $run_name = $name->get_alias_superflow_names( $run_button->{_prog_name_sref} );

		# print("4. run_button,program name is ${$run_button->{_prog_name_sref}}\n");
		# print("4. run_button,program run name is $run_name \n");
		# print("4. run_button,program name is $global_libs->{_superflows}$run_name \n");

		# Instruction runs in system
		system("sh $global_libs->{_superflows}$run_name");

	}
	else {
		# print("3. run_button,_Run_pre_built_superflow\n");
		my $message = $run_button_messages->run_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );
	}

	$conditions_gui->set4end_of_superflow_run_button();
	$run_button = $conditions_gui->get_hash_ref();    # return 89
	return ();
}

=head2 sub _Run_user_built_flow 
for saved regular flows 
		
		  foreach my $key (sort keys %$run_button) {
           print (" run_button,_Run_pre_built_superflow: key is $key, value is $run_button->{$key}\n");
          }	
=cut

sub _Run_user_built_flow {
	my ($self) = @_;

	# print("run_button,_Run_user_built_flow\n");

	my $message = $run_button_messages->null_button(0);
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# print("1 run_button,_Run_user_built_flow is_last_parameter_index_touched_color:	$run_button->{_is_last_parameter_index_touched_color} \n");
	$conditions_gui->set_hash_ref($run_button);       # used 35 / 80 in
	$conditions_gui->set_gui_widgets($run_button);    # used 23 / 80  in
	$conditions_gui->set4start_of_run_button();       # 1 set, out of 59
	                                                  #$L_SU				= $conditions_gui->get4start_of_run_button(); 51 out
	$run_button = $conditions_gui->get_hash_ref();    # returns 89
	                                                  # print("2 run_button,_Run_user_built_flow is_last_parameter_index_touched_color:	$run_button->{_is_last_parameter_index_touched_color} \n");

	# tests whether has_used_Save OR has_used_SaveAs
	# must be: has_used_Save AND has_used_SaveAs  OR has_used_SaveAs but NOT only has_used_Save
	$decisions->set4run_select($run_button);    # 2 set
	my $pre_req_ok = $decisions->get4run_select();    # 2 tested
	                                                  #$whereami				->in_gui();
	                                                  # print("run_button,_Run_user_built_flow, program name is $run_button->{_has_used_SaveAs_button}\n");

	# must have saved files already
	if ($pre_req_ok) {

		# print("run_button,_Run_user_built_flow, program name is $run_button->{_flow_name_out}\n");
		# print("run button, _Run_user_built_flow, checking accuracy of inserted values\n");
		#
		#			# TODO: pre-run check
		#    		# $control	->set_prog_param_labels_aref2($run_button);
		# 			# $control	->set_prog_param_values_aref2($run_button);
		# 			# $control	->set_prog_names_aref($run_button);
		# 			# $control	->set_items_versions_aref($run_button);
		# 			# my $ok2run	= $control->get_conditions();
		#
		my $ok2run = $true;

		if ($ok2run) {
			my $run_name = $run_button->{_flow_name_out};
			use Project_config;
			my $Project    = Project_config->new();
			my $PL_SEISMIC = $Project->PL_SEISMIC();

			# print("L_SU,run_button, running: $run_name\n");
			system("perl $PL_SEISMIC/$run_name");
		}

		$conditions_gui->set4run_button();
		$run_button = $conditions_gui->get_hash_ref();

	}
	else {
		my $message = $run_button_messages->run_button(1);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );
	}

	$conditions_gui->set4end_of_run_button();    # 2 set
	$run_button = $conditions_gui->get_hash_ref();    # 89 returned
	return ();

}

=head2 sub _get_flow_type

	user_built_flow
	or
	pre_built_superflow
	
	
=cut

sub _get_flow_type {
	my ($self) = @_;

	my $how_built = $run_button->{_flow_type};

	if ( $run_button->{_flow_type} ) {

		return ($how_built);

	}
	else {
		print("run_button, _get_flow_type , missing topic\n");
		return ();
	}

}

=head2 sub director

 prior to running
 determine if we are dealing with superflow 
 (" menubutton" widget)   
 - collect and/or access flow parameters
 
 Analysis:
 
 i/p: $parameter_values_frame
 i/p: $run_button_messages
 i/p: $message
 i/p: $param_flow
 i/p: $run_button
 i/p: $config_superflows
 
 o/p: $conditions_gui	->set4start_of_run_button();
 o/p: $conditions_gui	->set4_run_button
 o/p: $conditions_gui	->set4end_of_run_button();
  $run_button 			= $conditions_gui->get_hash_ref();
 o/p: _check4changes();
 
 o/p: $run_button
 o/p: $files_LSU
 
Run can be of 2 types
 
 dialog type can only be Run  (Main menu)

 
 i.e. 'either'
 
 or
 	Run (perl program of user-built flow
 or	
 	Run pre-built superflow configuration files
 	my $run_dialog_type		= $file_dialog_type->{_Run} ;

=cut

sub director {
	my ($self) = @_;

	my $flow_type = _get_flow_type();

	if ( $flow_type eq $flow_type_h->{_user_built} ) {

		# print("run_button, director, flow_type: $flow_type\n");
		_Run_user_built_flow();

	}
	elsif ( $flow_type eq $flow_type_h->{_pre_built_superflow} ) {

		# print("run_button, director, is superflow_type:$flow_type\n");
		_Run_pre_built_superflow();

	}
	else {
		print("run_button, director has a flow-type problem\n");
	}
	return ();
}

=head2 sub get_all_hash_ref

	return ALL values of the private hash, supposedly
	improtant external widgets have not been reset.. only conditions
	are reset
	TODO: perhaps it is better to have a specific method
		to return one specific widget address at a time?
	}
	
=cut

sub get_all_hash_ref {
	my ($self) = @_;

	if ($run_button) {

		# print("run_button, get_hash_ref , run_button->{_flow_color}: $run_button->{_flow_color}\n");
		return ($run_button);

	}
	else {
		print("run_button, get_hash_ref , missing hrun_button hash_ref\n");
	}
}

=head2 sub set_gui_widgets

	bring it important widget addresses
	42
	
	make convenient locat shorter names for 9
	
=cut

sub set_gui_widgets {
	my ( $self, $gui_widgets ) = @_;

	if ($gui_widgets) {

		$run_button->{_Data_menubutton}               = $gui_widgets->{_Data_menubutton};
		$run_button->{_Flow_menubutton}               = $gui_widgets->{_Flow_menubutton};
		$run_button->{_add2flow_button_grey}          = $gui_widgets->{_add2flow_button_grey};
		$run_button->{_add2flow_button_pink}          = $gui_widgets->{_add2flow_button_pink};
		$run_button->{_add2flow_button_green}         = $gui_widgets->{_add2flow_button_green};
		$run_button->{_add2flow_button_blue}          = $gui_widgets->{_add2flow_button_blue};
		$run_button->{_check_code_button}             = $gui_widgets->{_check_code_button};
		$run_button->{_check_buttons_w_aref}          = $gui_widgets->{_check_buttons_w_aref};
		$run_button->{_delete_from_flow_button}       = $gui_widgets->{_delete_from_flow_button};
		$run_button->{_dnd_token_grey}                = $gui_widgets->{_dnd_token_grey};
		$run_button->{_dnd_token_pink}                = $gui_widgets->{_dnd_token_pink};
		$run_button->{_dnd_token_green}               = $gui_widgets->{_dnd_token_green};
		$run_button->{_dnd_token_blue}                = $gui_widgets->{_dnd_token_blue};
		$run_button->{_dropsite_token_grey}           = $gui_widgets->{_dropsite_token_grey};
		$run_button->{_dropsite_token_pink}           = $gui_widgets->{_dropsite_token_pink};
		$run_button->{_dropsite_token_green}          = $gui_widgets->{_dropsite_token_green};
		$run_button->{_dropsite_token_blue}           = $gui_widgets->{_dropsite_token_blue};
		$run_button->{_file_menubutton}               = $gui_widgets->{_file_menubutton};
		$run_button->{_flow_color}                    = $gui_widgets->{_flow_color};
		$run_button->{_flow_item_down_arrow_button}   = $gui_widgets->{_flow_item_down_arrow_button};
		$run_button->{_flow_item_up_arrow_button}     = $gui_widgets->{_flow_item_up_arrow_button};
		$run_button->{_flow_listbox_grey_w}           = $gui_widgets->{_flow_listbox_grey_w};
		$run_button->{_flow_listbox_pink_w}           = $gui_widgets->{_flow_listbox_pink_w};
		$run_button->{_flow_listbox_green_w}          = $gui_widgets->{_flow_listbox_green_w};
		$run_button->{_flow_listbox_blue_w}           = $gui_widgets->{_flow_listbox_blue_w};
		$run_button->{_flow_listbox_color_w}          = $gui_widgets->{_flow_listbox_color_w};
		$run_button->{_flow_name_grey_w}              = $gui_widgets->{_flow_name_grey_w};
		$run_button->{_flow_name_pink_w}              = $gui_widgets->{_flow_name_pink_w};
		$run_button->{_flow_name_green_w}             = $gui_widgets->{_flow_name_green_w};
		$run_button->{_flow_name_blue_w}              = $gui_widgets->{_flow_name_blue_w};
		$run_button->{_flowNsuperflow_name_w}         = $gui_widgets->{_flowNsuperflow_name_w};
		$run_button->{_flow_widget_index}             = $gui_widgets->{_flow_widget_index};
		$run_button->{_labels_w_aref}                 = $gui_widgets->{_labels_w_aref};
		$run_button->{_message_w}                     = $gui_widgets->{_message_w};
		$run_button->{_mw}                            = $gui_widgets->{_mw};
		$run_button->{_parameter_values_frame}        = $gui_widgets->{_parameter_values_frame};
		$run_button->{_parameter_values_button_frame} = $gui_widgets->{_parameter_values_button_frame};
		$run_button->{_parameter_value_index}         = $gui_widgets->{_parameter_value_index};
		$run_button->{_run_button}                    = $gui_widgets->{_run_button};
		$run_button->{_save_button}                   = $gui_widgets->{_save_button};
		$run_button->{_values_aref}                   = $gui_widgets->{_values_aref};
		$run_button->{_values_w_aref}                 = $gui_widgets->{_values_w_aref};

		$mw                     = $run_button->{_mw};
		$parameter_values_frame = $run_button->{_parameter_values_frame};
		$parameter_value_index  = $run_button->{_parameter_value_index};
		$values_aref            = $run_button->{_values_aref};
		$message_w              = $run_button->{_message_w};
		$flow_listbox_grey_w    = $run_button->{_flow_listbox_grey_w};
		$flow_listbox_pink_w    = $run_button->{_flow_listbox_pink_w};
		$flow_listbox_green_w   = $run_button->{_flow_listbox_green_w};
		$flow_listbox_blue_w    = $run_button->{_flow_listbox_blue_w};

		# print("run_button, set_gui_widgets	parameter_values_frame: $parameter_values_frame\n");
	}
	else {

		print("run_button, set_gui_widgets, missing gui_widgets\n");
	}
	return ();
}

=head2 sub set_flow_type

	user_built_flow
	or
	pre_built_superflow
	
=cut

sub set_flow_type {
	my ( $self, $how_built ) = @_;

	if ($how_built) {
		$run_button->{_flow_type} = $how_built;

		# print("run_button, set_flow_type : $run_button->{_flow_type}\n");

	}
	else {
		print("run_button, set_flow_type , missing how_built\n");
	}
	return ();
}

=head2 sub set_hash_ref

	bring in important widget addresses 
	96
	
=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	if ($hash_ref) {

		$run_button->{_FileDialog_sub_ref}                    = $hash_ref->{_ileDialog_sub_ref};
		$run_button->{_FileDialog_option}                     = $hash_ref->{_FileDialog_option};
		$run_button->{_check_buttons_settings_aref}           = $hash_ref->{_check_buttons_settings_aref};
		$run_button->{_destination_index}                     = $hash_ref->{_destination_index};
		$run_button->{_dialog_type}                           = $hash_ref->{_dialog_type};
		$run_button->{_flow_color}                            = $hash_ref->{_flow_color};
		$run_button->{_flow_name_in}                          = $hash_ref->{_flow_name_in};
		$run_button->{_flow_name_out}                         = $hash_ref->{_flow_name_out};
		$run_button->{_flow_type}                             = $hash_ref->{_flow_type};
		$run_button->{_flow_widget_index}                     = $hash_ref->{_flow_widget_index};
		$run_button->{_good_labels_aref2}                     = $hash_ref->{_good_labels_aref2};
		$run_button->{_good_values_aref2}                     = $hash_ref->{_good_values_aref2};
		$run_button->{_has_used_check_code_button}            = $hash_ref->{_has_used_check_code_button};
		$run_button->{_has_used_open_perl_file_button}        = $hash_ref->{_has_used_open_perl_file_button};
		$run_button->{_has_used_Save_button}                  = $hash_ref->{_has_used_Save_button};
		$run_button->{_has_used_Save_superflow}               = $hash_ref->{_has_used_Save_superflow};
		$run_button->{_has_used_SaveAs_button}                = $hash_ref->{_has_used_SaveAs_button};
		$run_button->{_has_used_run_button}                   = $hash_ref->{_has_used_run_button};
		$run_button->{_is_add2flow_button}                    = $hash_ref->{_is_add2flow_button};
		$run_button->{_is_check_code_button}                  = $hash_ref->{_is_check_code_button};
		$run_button->{_is_delete_from_flow_button}            = $hash_ref->{_is_delete_from_flow_button};
		$run_button->{_is_dragNdrop}                          = $hash_ref->{_is_dragNdrop};
		$run_button->{_is_flow_item_down_arrow_button}        = $hash_ref->{_is_flow_item_down_arrow_button};
		$run_button->{_is_flow_item_up_arrow_button}          = $hash_ref->{_is_flow_item_up_arrow_button};
		$run_button->{_is_flow_listbox_grey_w}                = $hash_ref->{_is_flow_listbox_grey_w};
		$run_button->{_is_flow_listbox_pink_w}                = $hash_ref->{_is_flow_listbox_pink_w};
		$run_button->{_is_flow_listbox_green_w}               = $hash_ref->{_is_flow_listbox_green_w};
		$run_button->{_is_flow_listbox_blue_w}                = $hash_ref->{_is_flow_listbox_blue_w};
		$run_button->{_is_flow_listbox_color_w}               = $hash_ref->{_is_flow_listbox_color_w};
		$run_button->{_flow_name_grey_w}                      = $hash_ref->{_flow_name_grey_w};
		$run_button->{_flow_name_pink_w}                      = $hash_ref->{_flow_name_pink_w};
		$run_button->{_flow_name_green_w}                     = $hash_ref->{_flow_name_green_w};
		$run_button->{_flow_name_blue_w}                      = $hash_ref->{_flow_name_blue_w};
		$run_button->{_items_checkbuttons_aref2}              = $hash_ref->{_items_checkbuttons_aref2};
		$run_button->{_items_names_aref2}                     = $hash_ref->{_items_names_aref2};
		$run_button->{_items_values_aref2}                    = $hash_ref->{_items_values_aref2};
		$run_button->{_items_versions_aref}                   = $hash_ref->{_items_versions_aref};
		$run_button->{_is_last_flow_index_touched}            = $hash_ref->{_is_last_flow_index_touched};
		$run_button->{_is_last_flow_index_touched_grey}       = $hash_ref->{_is_last_flow_index_touched_grey};
		$run_button->{_is_last_flow_index_touched_pink}       = $hash_ref->{_is_last_flow_index_touched_pink};
		$run_button->{_is_last_flow_index_touched_green}      = $hash_ref->{_is_last_flow_index_touched_green};
		$run_button->{_is_last_flow_index_touched_blue}       = $hash_ref->{_is_last_flow_index_touched_blue};
		$run_button->{_is_last_parameter_index_touched_color} = $hash_ref->{_is_last_parameter_index_touched_color};
		$run_button->{_is_last_parameter_index_touched_grey}  = $hash_ref->{_is_last_parameter_index_touched_grey};
		$run_button->{_is_last_parameter_index_touched_pink}  = $hash_ref->{_is_last_parameter_index_touched_pink};
		$run_button->{_is_last_parameter_index_touched_green} = $hash_ref->{_is_last_parameter_index_touched_green};
		$run_button->{_is_last_parameter_index_touched_blue}  = $hash_ref->{_is_last_parameter_index_touched_blue};
		$run_button->{_last_path_touched}                     = $hash_ref->{_last_path_touched};
		$run_button->{_index2move}                            = $hash_ref->{_index2move};
		$run_button->{_is_open_file_button}                   = $hash_ref->{_is_open_file_button};
		$run_button->{_is_run_button}                         = $hash_ref->{_is_run_button};
		$run_button->{_is_moveNdrop_in_flow}                  = $hash_ref->{_is_moveNdrop_in_flow};
		$run_button->{_is_user_built_flow}                    = $hash_ref->{_is_user_built_flow};
		$run_button->{_is_select_file_button}                 = $hash_ref->{_is_select_file_button};
		$run_button->{_is_Save_button}                        = $hash_ref->{_is_Save_button};
		$run_button->{_is_SaveAs_file_button}                 = $hash_ref->{_is_SaveAs_file_button};
		$run_button->{_is_SaveAs_button}                      = $hash_ref->{_is_SaveAs_button};
		$run_button->{_is_new_listbox_selection}              = $hash_ref->{_is_new_listbox_selection};
		$run_button->{_is_pre_built_superflow}                = $hash_ref->{_is_pre_built_superflow};
		$run_button->{_is_selected_file_name}                 = $hash_ref->{_is_selected_file_name};
		$run_button->{_is_selected_path}                      = $hash_ref->{_is_selected_path};
		$run_button->{_is_sunix_listbox}                      = $hash_ref->{_is_sunix_listbox};
		$run_button->{_is_superflow_select_button}            = $hash_ref->{_is_superflow_select_button};
		$run_button->{_is_superflow}                          = $hash_ref->{_is_superflow};
		$run_button->{_is_moveNdrop_in_flow}                  = $hash_ref->{_is_moveNdrop_in_flow};
		$run_button->{_items_checkbuttons_aref2}              = $hash_ref->{_items_checkbuttons_aref2};
		$run_button->{_items_names_aref2}                     = $hash_ref->{_items_names_aref2};
		$run_button->{_items_values_aref2}                    = $hash_ref->{_items_values_aref2};
		$run_button->{_items_versions_aref}                   = $hash_ref->{_items_versions_aref};
		$run_button->{_last_flow_index_touched_grey}          = $hash_ref->{_last_flow_index_touched_grey};
		$run_button->{_last_flow_index_touched_pink}          = $hash_ref->{_last_flow_index_touched_pink};
		$run_button->{_last_flow_index_touched_green}         = $hash_ref->{_last_flow_index_touched_green};
		$run_button->{_last_flow_index_touched_blue}          = $hash_ref->{_last_flow_index_touched_blue};
		$run_button->{_last_flow_index_touched}               = $hash_ref->{_last_flow_index_touched};
		$run_button->{_last_parameter_index_touched_color}    = $hash_ref->{_last_parameter_index_touched_color};
		$run_button->{_last_parameter_index_touched_grey}     = $hash_ref->{_last_parameter_index_touched_grey};
		$run_button->{_last_parameter_index_touched_pink}     = $hash_ref->{_last_parameter_index_touched_pink};
		$run_button->{_last_parameter_index_touched_green}    = $hash_ref->{_last_parameter_index_touched_green};
		$run_button->{_last_parameter_index_touched_blue}     = $hash_ref->{_last_parameter_index_touched_blue};
		$run_button->{_last_path_touched}                     = $hash_ref->{_last_path_touched};
		$run_button->{_names_aref}                            = $hash_ref->{_names_aref};
		$run_button->{_occupied_listbox_aref}                 = $hash_ref->{_occupied_listbox_aref};
		$run_button->{_param_flow_length}                     = $hash_ref->{_param_flow_length};
		$run_button->{_parameter_names_frame}                 = $hash_ref->{_parameter_names_frame};
		$run_button->{_param_sunix_first_idx}                 = $hash_ref->{_param_sunix_first_idx};
		$run_button->{_param_sunix_length}                    = $hash_ref->{_param_sunix_length};
		$run_button->{_path}                                  = $hash_ref->{_path};
		$run_button->{_prog_names_aref}                       = $hash_ref->{_prog_names_aref};
		$run_button->{_prog_name_sref}                        = $hash_ref->{_prog_name_sref};
		$run_button->{_selected_file_name}                    = $hash_ref->{_selected_file_name};
		$run_button->{_sub_ref}                               = $hash_ref->{_sub_ref};
		$run_button->{_sunix_listbox}                         = $hash_ref->{_sunix_listbox};                           # pre-built-superflow or flow name as well
		$run_button->{_superflow_first_idx}                   = $hash_ref->{_superflow_first_idx};
		$run_button->{_superflow_length}                      = $hash_ref->{_superflow_length};
		$run_button->{_values_aref}                           = $hash_ref->{_values_aref};
		$run_button->{_values_w_aref}                         = $hash_ref->{_values_w_aref};

		# print("run_button, set_hash_ref, is superflow: $run_button->{_is_superflow_select_button} \n");
		# print("run_button, set_hash_ref, user-built _flow_name_out: $run_button->{_flow_name_out} \n");

	}
	else {

		print("run_button, set_gui_widgets, missing hash_ref\n");
	}
	return ();
}

#=head2
#

#
#           	print("run_button,_ Save_pre_built_superflow \n");
#
#=cut
#
# sub _Run_pre_built_superflow {
# 	my ($self) = @_;
#
# 	use save;
#	use files_LSU;
#	use message_director;
#
#		# for 2.built_in_flow.pm ONLY run_button superflow_select check_code_button
#	use config_superflows;
#	use whereami;
#
#	my $run_button_messages = message_director->new();
#	my $whereami			= whereami->new();
# 	my $save 				= new save();
# 	my $files_LSU			= new files_LSU();
# 	my $config_superflows   = config_superflows	->new();
#
#	my $message          	= $run_button_messages->null_button(0);
# 	$message_w   			->delete("1.0",'end');
# 	$message_w   			->insert('end', $message);
#
# 	$conditions_gui			->set_hash_ref($run_button);
#	$conditions_gui			->set_gui_widgets($run_button);
#	$conditions_gui			->set4start_of_run_button();
#	$conditions_gui			->set4superflow_select();
#	$run_button 			= $conditions_gui->get_hash_ref();
#
#        	# location within GUI
#	my $widget_type		= $whereami->widget_type($parameter_values_frame);
#
#			# print("run_button,_Run_pre_built_superflow,widget_type = $widget_type\n");
#			# print("run_button,run_button,_Run_pre_built_superflow:$run_button->{_is_superflow_select_button}\n");
#
#    if($run_button->{_is_superflow_select_button}) {
#		$config_superflows	->save($run_button);
#		$conditions_gui		->set4_Run_button();
#		$run_button 		= $conditions_gui->get_hash_ref();
#
##
##	} else { # if flow first needs a change for activation
##
##		$message          	= $run_button_messages->run_button(0);
## 	  	$message_w			->delete("1.0",'end');
## 	  	$message_w			->insert('end', $message);
#	}
#
#	$conditions_gui			->set4end_of_Run_button();
#	$run_button 			= $conditions_gui->get_hash_ref();
#
# 	return();
# }
#
# sub set_run_button_sub_ref {
# 	my ($self,$sub_ref) = @_;
#
# 	if ($sub_ref) {
# 				print("binding  set_run_button_sub_ref, $sub_ref\n");
# 		$run_button->{_sub_ref} = $sub_ref;
#
# 	} else{
#		print("run_button, set_run_button_sub_ref, missing sub ref\n");
# 	}
# 	return();
# }
#
#
#=head2 sub _run_button
#
#=cut
##
##sub _run_button {
## 	my ($self) 				= @_;
##
## 	use save;
##	use files_LSU;
##	use message_director;
##
##	# use whereami;
##
##	my $run_button_messages 	    = message_director->new();
##	# my $whereami			= whereami->new();
##
## 	my $save 				= new save();
## 	my $files_LSU			= new files_LSU();
##
##	my $message          	= $run_button_messages->null_button(0);
## 	$message_w   			->delete("1.0",'end');
## 	$message_w   			->insert('end', $message);
##
## 	$conditions_gui			->set_hash_ref($run_button);
##	$conditions_gui			->set_gui_widgets($run_button);
##	$conditions_gui			->set4start_of_run_button();
##	$run_button 					= $conditions_gui->get_hash_ref();
##
##        	# location within GUI
##	my $widget_type		= $whereami->widget_type($parameter_values_frame);
##			# print("L_SU,run_button,widget_type = $widget_type\n");
##
##			# FOR SUPERFLOWS only
##			# print("L_SU,run_button,is_superflow_select_button:$run_button->{_is_superflow_select_button}\n");
##    if($run_button->{_is_superflow_select_button}) {
##		$config_superflows	->save($run_button);
##		$conditions_gui		->set4_run_button();
##		 $run_button 			= $conditions_gui->get_hash_ref();
##
##		# for REGULAR FLOWS but only if activated
##	} elsif ( ($run_button->{_is_flow_listbox_grey_w} ||
##	    $run_button->{_is_flow_listbox_green_w}) &&
##	    $widget_type eq 'Entry' )  {
##
##			# consider empty case
##		if( !($run_button->{_flow_name_out}) ||
##			$run_button->{_flow_name_out} eq '') {
##
##			$message          = $run_button_messages->run_button(1);
## 	  		$message_w		->delete("1.0",'end');
## 	  		$message_w		->insert('end', $message);
##
##		} else {  # good case
##			# print("1. run_button, saving flow: $run_button->{_flow_name_out}\n");
##    	}
##
##		_check4changes();
##		$param_flow						->set_good_values;
##		$param_flow						->set_good_labels;
##		$run_button->{_good_labels_aref2}		= $param_flow->get_good_labels_aref2;
##		$run_button->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref;
##		$run_button->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
##		$run_button->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref;
##
##		 		# print("run_button,_prog_names_aref,
##		 		# @{$run_button->{_prog_names_aref}}\n");
##		# my $num_items4flow = scalar @{$run_button->{_good_labels_aref2}};
##
##				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
##					# print("run_button,_good_labels_aref2,
##				# @{@{$run_button->{_good_labels_aref2}}[$i]}\n");
##				# }
##
##				# for (my $i=0; $i < $num_items4flow; $i++ ) {
##				#	print("run_button,_good_values_aref2,
##				#	@{@{$run_button->{_good_values_aref2}}[$i]}\n");
##				#}
##				#   print("run_button,_prog_versions_aref,
##				#   @{$run_button->{_items_versions_aref}}\n");
##
## 		$files_LSU	->set_prog_param_labels_aref2($run_button);
## 		$files_LSU	->set_prog_param_values_aref2($run_button);
## 		$files_LSU	->set_prog_names_aref($run_button);
## 		$files_LSU	->set_items_versions_aref($run_button);
## 		$files_LSU	->set_data();
## 		$files_LSU	->set_message($run_button);
##		$files_LSU	->set2pl($run_button); # flows saved to PL_SEISMIC
##		$files_LSU	->save();
##		$conditions_gui	->set4_run_button();
##		$run_button 			= $conditions_gui->get_hash_ref();
##
##	} else { # if flow first needs a change for activation
##
##		$message          	= $run_button_messages->run_button(0);
## 	  	$message_w			->delete("1.0",'end');
## 	  	$message_w			->insert('end', $message);
##	}
##
##	$conditions_gui	->set4end_of_run_button();
##	$run_button 			= $conditions_gui->get_hash_ref();
##   	return();
##}

#
#=head2 sub set_dialog_type
#
# save can be of 2 generic types:
#
# dialog type can only be Run  (Main menu)
#
#
# i.e., 'either':
#
# or
# 	Run  (perl program of user-built flow
# or
# 	Run pre-built superflow configuration files
#
#
#=cut
#
# sub set_dialog_type {
# 	my ($self,$topic) = @_;
#
# 	if ( $topic) {
# 		$run_button->{_dialog_type} = $topic;
# 		 print("run_button, set_dialog_type , $run_button->{_dialog_type} \n");
#
# 	} else {
# 		print("run_button, set_dialog_type , missing topic\n");
# 	}
# 	return();
# }

#
# sub _get_dialog_type {
# 	my ($self) = @_;
#
# 	my $topic = $run_button->{_dialog_type};
# 	 		# print("run_button, _get_dialog_type = $topic\n");
#
# 	if ( $topic) {
#		return($topic);
#
# 	} else {
# 		# print("run_button, _get_dialog_type , missing topic\n");
# 		return();
# 	}
# }
#
#

=head2 sub set_flow_name_out

	user-built flow name
	
=cut

sub set_flow_name_out {
	my ( $self, $name ) = @_;

	if ($name) {
		$run_button->{_flow_name_out} = $name;

		# print("run_button, set_flow_name_out, $run_button->{_flow_name_out}\n");

	}
	else {
		print("run_button, set_flow_name_out, missing name\n");
	}
	return ();
}

=head2 sub set_prog_name_sref

	in order to know what
	_spec file to read for
	behaviors
	THis program has a pre-existing module
	
=cut

sub set_prog_name_sref {
	my ( $self, $name_sref ) = @_;

	if ($name_sref) {
		$run_button->{_prog_name_sref} = $name_sref;

		# print("run_button, set_prog_name_sref , ${$run_button->{_prog_name_sref}}\n");

	}
	else {
		print("run_button, set_prog_name_sref , missing name\n");
	}
	return ();
}

1;
