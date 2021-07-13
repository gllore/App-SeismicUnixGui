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
	$gui_history		->set4run_button_start();
	$gui_history		->set4run_button();     
	$decisions		      	->set4run_select($run_button);
	$gui_history		->set4run_button_end();
	$whereami				->in_gui();
	message box: 			$message
	$run_button 			= $gui_history->get_hash_ref();	
	
=cut 

=head2 Notes from bash
 
=cut 

use Moose;
our $VERSION = '0.0.1';

use Tk;
#use conditions_gui;
# TODO Do I need decisions???
use decisions 1.00;

# uses conditions_flows which derives
# from conditions_gui
extends 'gui_history' => { -version => 0.0.2 };

# potentially used in all packages
use L_SU_global_constants;
use name;

# use control 0.0.3;
use whereami;

my $gui_history = gui_history->new();
my $decisions           = decisions->new();
my $get                 = L_SU_global_constants->new();
#my $conditions_gui      = conditions_gui->new();
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
my $run_button     = $gui_history->get_defaults();

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


=head2 sub _messages
Show warnings or errors in a message box
Message box is defined in main where it is
also made invisible (withdraw)
Here we turn on the message box (deiconify, raise)
The message does not release the program
until OK is clicked and wait variable changes from yes 
to no.

=cut

sub _messages {
	
	my ($run_name)    = @_;
	
	use message_director;
    my $run_name_message = message_director->new();
    my $message       = $run_name_message->immodpg(0);
	
    # print("1. run_button,_messages,writing gui_history.txt\n");
    # $gui_history->view();
    
    my $message_box   =  $run_button->{_message_box_w};
    my $message_label =  $run_button->{_message_label_w};
    my $message_box_wait=  $run_button->{_message_box_wait};
    my $message_ok_button= $run_button->{_message_ok_button};
    # print("1 run_button,_messages, message_box_wait=$message_box_wait\n");   
  
    $message_box->title( "immodpg" );
	$message_label->configure (
	 	-textvariable => \$message,
        );
    $message_ok_button->configure (
    	-command 		=> sub { 
			$message_box->grabRelease;
			$message_box->withdraw;
		    $message_box_wait = $var->{_no};}
    );
    
	$message_box->deiconify();
	$message_box->raise();
    
	$message_ok_button->waitVariable(\$message_box_wait);
#    print("2 run_button,_messages,message_box_wait=$message_box_wait\n");
     return();
            
}


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
	$message_w = $run_button->{_message_w};
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# print("1.run_button, _values_aref[0]: @{$run_button->{_values_aref}}[0]\n");
#	$conditions_gui->set_hash_ref($run_button);              
#	$conditions_gui->set_gui_widgets($run_button);           
#	$conditions_gui->set4start_of_superflow_run_button();   
#	$run_button = $conditions_gui->get_hash_ref();

	$gui_history->set_hash_ref($run_button);              
#	$gui_history->set_gui_widgets($run_button);           
	$gui_history->set4start_of_superflow_run_button();   
	$run_button = $gui_history->get_hash_ref();

	# print("2. L_SU, run_button, _values_aref[0]: @{$run_button->{_values_aref}}[0]\n");
	$decisions->set4run_select($run_button);     
	my $pre_req_ok = $decisions->get4run_select();

	# print("1. run_button,_Run_pre_built_superflow\n");
	# must have saved files already
	if ($pre_req_ok) {

		# print("2. run_button,_Run_pre_built_superflow, passed pre_ok check\n");
#		if ( $run_button->{_is_superflow_select_button} ) {
#			print("3. run_button,program name is ${$run_button->{_prog_name_sref}}\n");
#		}
		my $run_name = $name->get_alias_superflow_names( $run_button->{_prog_name_sref} );

		if ($run_name eq 'immodpg') {
		 
		   _messages($run_name);	
		
		}
		# print("4. run_button,program name is ${$run_button->{_prog_name_sref}}\n");
		# print("4. run_button,program RUN name is $run_name \n");
		# print("4. run_button,program name is $global_libs->{_superflows}$run_name \n");

		# Instruction runs in system
#		print("4. run_button,running as sh $global_libs->{_superflows}$run_name \n");
		system("sh $global_libs->{_superflows}$run_name");

	} else {

		# print("3. run_button,_Run_pre_built_superflow\n");
		my $message = $run_button_messages->run_button(0);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );
	}

#	$conditions_gui->set4end_of_superflow_run_button();
    $gui_history->set4end_of_superflow_run_button();
#	$run_button = $conditions_gui->get_hash_ref();    # return 89
	$run_button = $gui_history->get_hash_ref();
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
	# replace conditions_gui with gui_history which internally refers to the correct conditions_gui
#	$conditions_gui->set_hash_ref($run_button);       # used 35 / 80 in
#	$conditions_gui->set_gui_widgets($run_button);    # used 23 / 80  in
#	$conditions_gui->set4start_of_run_button();       # 1 set, out of 59
	$gui_history->set_hash_ref($run_button);
#	$gui_history->set_gui_widgets($run_button);
	$gui_history->set4start_of_run_button();
	
													  #$L_SU				= $conditions_gui->get4start_of_run_button(); 51 out
	$run_button = $gui_history->get_hash_ref();    # returns 89
	 # print("2 run_button,_Run_user_built_flow is_last_parameter_index_touched_color:	$run_button->{_is_last_parameter_index_touched_color} \n");

	# tests whether has_used_Save OR has_used_SaveAs
	# must be: has_used_Save AND has_used_SaveAs  OR has_used_SaveAs but NOT only has_used_Save
	$decisions->set4run_select($run_button);          # 2 set
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

		$gui_history->set4run_button();
		$run_button = $gui_history->get_hash_ref();

	} else {
		my $message = $run_button_messages->run_button(1);
		$message_w->delete( "1.0", 'end' );
		$message_w->insert( 'end', $message );
	}

	$gui_history->set4end_of_run_button();         # 2 set
	$run_button = $gui_history->get_hash_ref();    # 89 returned
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

	} else {
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
 
# o/p: $conditions_gui	->set4start_of_run_button();
# o/p: $gui_history	->set4_run_button
# o/p: $gui_history	->set4end_of_run_button();
  $run_button 			= $gui_history->get_hash_ref();
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

	} elsif ( $flow_type eq $flow_type_h->{_pre_built_superflow} ) {

		# print("run_button, director, is superflow_type:$flow_type\n");
		_Run_pre_built_superflow();

	} else {
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

	} else {
		print("run_button, get_hash_ref , missing hrun_button hash_ref\n");
	}
}

#=head2 sub set_gui_widgets
#
#	bring it important widget addresses
#	42
#	
#	make convenient locat shorter names for 9
#	
#=cut
#
#sub set_gui_widgets {
#	my ( $self, $gui_widgets ) = @_;
#
#	if ($gui_widgets) {
#
#		$run_button->{_Data_menubutton}               = $gui_widgets->{_Data_menubutton};
#		$run_button->{_Flow_menubutton}               = $gui_widgets->{_Flow_menubutton};
#		$run_button->{_add2flow_button_grey}          = $gui_widgets->{_add2flow_button_grey};
#		$run_button->{_add2flow_button_pink}          = $gui_widgets->{_add2flow_button_pink};
#		$run_button->{_add2flow_button_green}         = $gui_widgets->{_add2flow_button_green};
#		$run_button->{_add2flow_button_blue}          = $gui_widgets->{_add2flow_button_blue};
#		$run_button->{_check_code_button}             = $gui_widgets->{_check_code_button};
#		$run_button->{_check_buttons_w_aref}          = $gui_widgets->{_check_buttons_w_aref};
#		$run_button->{_delete_from_flow_button}       = $gui_widgets->{_delete_from_flow_button};
#		$run_button->{_dnd_token_grey}                = $gui_widgets->{_dnd_token_grey};
#		$run_button->{_dnd_token_pink}                = $gui_widgets->{_dnd_token_pink};
#		$run_button->{_dnd_token_green}               = $gui_widgets->{_dnd_token_green};
#		$run_button->{_dnd_token_blue}                = $gui_widgets->{_dnd_token_blue};
#		$run_button->{_dropsite_token_grey}           = $gui_widgets->{_dropsite_token_grey};
#		$run_button->{_dropsite_token_pink}           = $gui_widgets->{_dropsite_token_pink};
#		$run_button->{_dropsite_token_green}          = $gui_widgets->{_dropsite_token_green};
#		$run_button->{_dropsite_token_blue}           = $gui_widgets->{_dropsite_token_blue};
#		$run_button->{_file_menubutton}               = $gui_widgets->{_file_menubutton};
#		$run_button->{_flow_color}                    = $gui_widgets->{_flow_color};
#		$run_button->{_flow_item_down_arrow_button}   = $gui_widgets->{_flow_item_down_arrow_button};
#		$run_button->{_flow_item_up_arrow_button}     = $gui_widgets->{_flow_item_up_arrow_button};
#		$run_button->{_flow_listbox_grey_w}           = $gui_widgets->{_flow_listbox_grey_w};
#		$run_button->{_flow_listbox_pink_w}           = $gui_widgets->{_flow_listbox_pink_w};
#		$run_button->{_flow_listbox_green_w}          = $gui_widgets->{_flow_listbox_green_w};
#		$run_button->{_flow_listbox_blue_w}           = $gui_widgets->{_flow_listbox_blue_w};
#		$run_button->{_flow_listbox_color_w}          = $gui_widgets->{_flow_listbox_color_w};
#		$run_button->{_flow_name_grey_w}              = $gui_widgets->{_flow_name_grey_w};
#		$run_button->{_flow_name_pink_w}              = $gui_widgets->{_flow_name_pink_w};
#		$run_button->{_flow_name_green_w}             = $gui_widgets->{_flow_name_green_w};
#		$run_button->{_flow_name_blue_w}              = $gui_widgets->{_flow_name_blue_w};
#		$run_button->{_flowNsuperflow_name_w}         = $gui_widgets->{_flowNsuperflow_name_w};
#		$run_button->{_flow_widget_index}             = $gui_widgets->{_flow_widget_index};
#		$run_button->{_labels_w_aref}                 = $gui_widgets->{_labels_w_aref};
#		$run_button->{_message_w}                     = $gui_widgets->{_message_w};
#		$run_button->{_mw}                            = $gui_widgets->{_mw};
#		$run_button->{_parameter_values_frame}        = $gui_widgets->{_parameter_values_frame};
#		$run_button->{_parameter_values_button_frame} = $gui_widgets->{_parameter_values_button_frame};
#		$run_button->{_parameter_value_index}         = $gui_widgets->{_parameter_value_index};
#		$run_button->{_run_button}                    = $gui_widgets->{_run_button};
#		$run_button->{_save_button}                   = $gui_widgets->{_save_button};
#		$run_button->{_values_aref}                   = $gui_widgets->{_values_aref};
#		$run_button->{_values_w_aref}                 = $gui_widgets->{_values_w_aref};
#
##		$mw                     = $run_button->{_mw};
#		$parameter_values_frame = $run_button->{_parameter_values_frame};
#		$parameter_value_index  = $run_button->{_parameter_value_index};
#		$values_aref            = $run_button->{_values_aref};
#		$flow_listbox_grey_w    = $run_button->{_flow_listbox_grey_w};
#		$flow_listbox_pink_w    = $run_button->{_flow_listbox_pink_w};
#		$flow_listbox_green_w   = $run_button->{_flow_listbox_green_w};
#		$flow_listbox_blue_w    = $run_button->{_flow_listbox_blue_w};
#
#		# print("run_button, set_gui_widgets	parameter_values_frame: $parameter_values_frame\n");
#	} else {
#
#		print("run_button, set_gui_widgets, missing gui_widgets\n");
#	}
#	return ();
#}

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

	} else {
		print("run_button, set_flow_type , missing how_built\n");
	}
	return ();
}


=head2 sub set_hash_ref
	bring in important widget addresses 
	
=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	if (length($hash_ref) ){
		
		$gui_history->set_defaults($hash_ref);
		$run_button = $gui_history->get_defaults();
		$message_w              = $run_button->{_message_w};
        
	}else {
		 print("run_button, set_hash_ref, missing hash_ref\n");
	}
	return ();
}


=head2 sub set_flow_name_out

	user-built flow name
	
=cut

sub set_flow_name_out {
	my ( $self, $name ) = @_;

	if ($name) {
		$run_button->{_flow_name_out} = $name;

		# print("run_button, set_flow_name_out, $run_button->{_flow_name_out}\n");

	} else {
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

	} else {
		print("run_button, set_prog_name_sref , missing name\n");
	}
	return ();
}

1;
