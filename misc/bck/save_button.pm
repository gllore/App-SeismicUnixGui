package save_button;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: save_button.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 16 2018 

 DESCRIPTION 
     
 BASED ON:
 
 previous version (V 0.2) of the main L_SU.pl (V 0.3)
  
=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl

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
	
	
	my $decisions					= decisions ->new();
	my $get							= L_SU_global_constants->new();
	my $conditions_gui				= conditions_gui ->new();
	
	my $file_dialog_type			= $get->file_dialog_type_href();
 	my $flow_type_h					= $get->flow_type_href();
	
	my $var							= $get->var();
	my $on         					= $var->{_on};	 
	my $true       					= $var->{_true};
	my $false      					= $var->{_false};
	my $superflow_names     		= $get->superflow_names_h();	
	
=head2 private hash

132 off

=cut

	my $save_button = {
		
		_Data_menubutton				=> '',
		_FileDialog_sub_ref				=> '',
		_FileDialog_option				=> '',
		_Flow_menubutton				=> '',
		_SaveAs_menubutton				=> '',
		_add2flow_button_grey			=> '',
		_add2flow_button_pink			=> '',
		_add2flow_button_green			=> '',
		_add2flow_button_blue			=> '',
		_check_code_button				=> '',
		_check_buttons_settings_aref	=> '',
		_check_buttons_w_aref 			=> '',
		_delete_from_flow_button		=> '',
  		_destination_index	 			=> '',
		_dialog_type					=> '', 	#set_dialog_type
 		_dnd_token_grey					=> '',
  		_dnd_token_pink					=> '', 
   		_dnd_token_green				=> '', 
   		_dnd_token_blue					=> '', 
    	_dropsite_token_grey			=> '',
  		_dropsite_token_pink			=> '',
   		_dropsite_token_green			=> '',
   		_dropsite_token_blue			=> '',  
		_file_menubutton				=> '',
		_flowNsuperflow_name_w			=> '',
		_flow_color						=> '',	
   		_flow_item_down_arrow_button	=> '',
 		_flow_item_up_arrow_button		=> '',	
		_flow_listbox_grey_w			=> '',
		_flow_listbox_pink_w			=> '',
		_flow_listbox_green_w			=> '',
		_flow_listbox_blue_w			=> '',
		_flow_listbox_color_w			=> '',
  		_flow_name_grey_w				=> '',
 		_flow_name_pink_w				=> '', 
  		_flow_name_green_w				=> '',
 		_flow_name_blue_w				=> '', 
		_flow_name_out					=> '',
		_flow_name_in					=> '',
		_flow_type						=> '', 	# set_flow_type
		_flow_widget_index				=> '',
		_gui_history_aref				=> '',
 		_has_used_check_code_button		=> '',
 		_has_used_open_perl_file_button	=> '',
 		_has_used_run_button			=> '',
    	_has_used_Save_button			=> '',
    	_has_used_Save_superflow		=> '',
		_has_used_SaveAs_button			=> '',
		_index2move						=> '',
		_is_SaveAs_file_button			=> '',
		_is_SaveAs_button				=> '',
		_is_Save_button					=> '',	
		_is_add2flowbutton				=> '',
		_is_check_code_button			=> '',
		_is_delete_from_flow_button		=> '',
		_is_dragNdrop					=> '',
		_is_flow_item_down_arrow_button	=> '',
		_is_flow_item_up_arrow_button	=> '',
		_is_flow_listbox_grey_w			=> '',
		_is_flow_listbox_green_w		=> '',
		_is_flow_listbox_pink_w			=> '',
		_is_flow_listbox_blue_w			=> '',
		_is_flow_listbox_color_w		=> '',
		_is_last_flow_index_touched_grey 		=> '', 
		_is_last_flow_index_touched_pink 		=>  '',
		_is_last_flow_index_touched_green 		=>  '',
		_is_last_flow_index_touched_blue 		=>  '',
		_is_last_flow_index_touched 			=>  '',
		_is_last_parameter_index_touched_grey 	=> '',
		_is_last_parameter_index_touched_pink 	=> '',
		_is_last_parameter_index_touched_green 	=> '',
		_is_last_parameter_index_touched_blue	=> '',
		_is_last_parameter_index_touched_color	=> '',	
		_is_moveNdrop_in_flow			=> '',
		_is_new_listbox_selection		=> '',
		_is_open_file_button			=> '',
		_is_pre_built_superflow			=> '',
		_is_run_button					=> '',
		_is_select_file_button			=> '',
		_is_selected_file_name			=> '',
		_is_selected_path				=> '',			
		_is_sunix_listbox				=> '',
   		_is_superflow 					=> '',
		_is_superflow_select_button		=> '',
		_is_user_built_flow				=> '',
  		_items_checkbuttons_aref2 		=> '',
  		_items_names_aref2  			=> '',
   	 	_items_values_aref2  			=> '',
		_items_versions_aref 			=> '',
		_labels_aref					=> '', # equiv no names but not used... legacy
		_labels_w_aref					=> '',
 		_last_flow_index_touched    	=> -1,
  	 	_last_flow_index_touched_grey   => -1,
   		_last_flow_index_touched_pink   => -1,
    	_last_flow_index_touched_green  => -1,
    	_last_flow_index_touched_blue   => -1,
    	_last_flow_listbox_touched  	=> '',
 		_last_flow_listbox_touched_w	=> '',
   		_last_path_touched				=> './', 		
		_message_w						=> '',		
		_mw								=> '',	 # main window widget
		_names_aref    					=> '',   # equiv labels
   		_occupied_listbox_aref					=> '',
		_param_flow						=> '',
		_param_flow_length        		=> '',
 		_parameter_names_frame  		=> '',
 		_param_sunix_first_idx      	=> 0,
 		_param_sunix_length  			=> '', 
		_parameter_values_frame			=> '',
   	 	_parameter_values_button_frame	=> '',
		_parameter_value_index     		=> '',
		_path							=> '',
 		_prog_names_aref 				=> '', 
		_prog_name_sref    				=> '',	  # set_prog_name_sref			
		_run_button						=> '',
  	 	_save_button 					=> '',
 		_selected_file_name				=> '',
		_sub_ref						=> '',
 		_sunix_listbox					=> '',  # pre-built-superflow or flow name as well
		_superflow_first_idx			=>'',
		_superflow_length				=>'',
		_values_aref					=> '',
		_values_w_ref					=> '',

	};
	
=head2 declare variables

	8 off

=cut

	my $message_w;		
	my $mw;
	my $parameter_values_frame;
	my $parameter_value_index;
	my $values_aref;
	my ($flow_listbox_grey_w,$flow_listbox_green_w);
	my $sub_ref;



=head2 sub _user_built_flow_Save_perl_file 


=cut

 sub _user_built_flow_Save_perl_file {
 	my ($self) = @_;
 	# print("save_button,_user_built_flow_Save_perl_file\n");
 	return();
 }



sub set_param_flow {
	my ($self,$param_flow_ref) = @_;
	
	$save_button->{_param_flow}  = &$param_flow_ref;
	# print("set_param_flow, $param_flow_ref\n");
	
}

=head2 sub _user_built_flow_SaveAs_perl_file 


=cut
 
 sub _user_built_flow_SaveAs_perl_file {
 	my ($self) = @_; 	

 	
	if ( $save_button->{_is_flow_listbox_grey_w} 	||
		 $save_button->{_is_flow_listbox_pink_w} 	||
		 $save_button->{_is_flow_listbox_green_w} 	||
		 $save_button->{_is_flow_listbox_blue_w} )   {
		 	

    		
#		$param_flow						->set_good_values;
#		$param_flow						->set_good_labels;
#		$save_button->{_good_labels_aref2}		= $param_flow->get_good_labels_aref2;
#		$save_button->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref;
#		$save_button->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
#		$save_button->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref;
#
#		 		# print("save_button,_prog_names_aref,
#		 		# @{$save_button->{_prog_names_aref}}\n");
#		# my $num_items4flow = scalar @{$save_button->{_good_labels_aref2}};
#
#				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
#					# print("save_button,_good_labels_aref2,
#				# @{@{$save_button->{_good_labels_aref2}}[$i]}\n");
#				# }
#
#				# for (my $i=0; $i < $num_items4flow; $i++ ) {
#				#	print("save_button,_good_values_aref2,
#				#	@{@{$save_button->{_good_values_aref2}}[$i]}\n");
#				#}
#				#   print("save_button,_prog_versions_aref,
#				#   @{$save_button->{_items_versions_aref}}\n");
#
# 		$files_LSU	->set_prog_param_labels_aref2($save_button);
# 		$files_LSU	->set_prog_param_values_aref2($save_button);
# 		$files_LSU	->set_prog_names_aref($save_button);
# 		$files_LSU	->set_items_versions_aref($save_button);
# 		$files_LSU	->set_data();
# 		$files_LSU	->set_message($save_button);
#		$files_LSU	->set2pl($save_button); # flows saved to PL_SEISMIC
#		$files_LSU	->save();
#		$conditions_gui	->set4_save_button();
#		$save_button 			= $conditions_gui->get_hash_ref();

	}	
 	return();	
 }

=head2 sub _Save_pre_built_superflow 
 						
    	  foreach my $key (sort keys %$save_button) {
           print (" save_button,_Save_pre_built_superflow: key is $key, value is $save_button->{$key}\n");
          }	
          
           	print("save_button,_ Save_pre_built_superflow \n");
           	
           	conditions for set4start of save button:
           	
           	   	$conditions_gui->{_is_Save_button}			= $true;
   				$conditions_gui->{_has_used_Save_button}	= $true;
   				
   			conditions for set4superflow_select:
   			
   				$conditions_gui->{_is_new_listbox_selection} 	= $true;
 				$conditions_gui->{_is_superflow_select_button}	= $true;
 				$conditions_gui->{_is_pre_built_superflow}		= $true;
 				also 13 widget settings
 				
 		set4_Save_button
 		   	$conditions_gui->{_has_used_Save_button} = true
			$conditions_gui->{_is_Save_button}		= $false;
 				
 				print("save_button 2.built_in_flow.pm ONLY save_button superflow_select check_code_button\n");

=cut

 sub _Save_pre_built_superflow {
 	my ($self) = @_; 	

 	use save;
	use files_LSU;
	use messages::message_director;		
	use config_superflows;	
	use whereami;
	
	my $save_button_messages = message_director->new();
	my $whereami			= whereami->new();
 	my $save 				= new save();
 	my $files_LSU			= new files_LSU();
 	my $config_superflows   = config_superflows	->new();
 	
	my $message          	= $save_button_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message); 	

 	$conditions_gui			->set_hash_ref($save_button);    #    uses 36 /69 in
	$conditions_gui			->set_gui_widgets($save_button); #    uses 22 / 69 in
	
	$conditions_gui			->set4start_of_superflow_Save();
	$save_button 			= $conditions_gui->get_hash_ref();    # returns 89
	
				# print("1. save_button,_Save_pre_built_superflow,has_used_Save_superflow: $save_button->{_has_used_Save_superflow}\n");
 				# print("1. save_button,_Save_pre_built_superflow,has_used_SaveAs_button: $save_button->{_has_used_SaveAs_button}\n");
 				# print("1. save_button,_Save_pre_built_superflow, has_used_Save_button(only for user-built): $save_button->{_has_used_Save_button}\n");
 
        	# location within GUI   
	my $widget_type		= $whereami->widget_type($parameter_values_frame);

			# print("save_button,_Save_pre_built_superflow, values_aref :@{$save_button->{_values_aref}}[0]\n");
				# print("2. save_button,_Save_pre_built_superflow,has_used_Save_superflow: $save_button->{_has_used_Save_superflow}\n");
 				# print("2. save_button,_Save_pre_built_superflow,has_used_SaveAs_button: $save_button->{_has_used_SaveAs_button}\n");
 				# print("2. save_button,_Save_pre_built_superflow, has_used_Save_button(only for user-built): $save_button->{_has_used_Save_button}\n");
   			#  print("2. save_button,_Save_pre_built_superflow,_is_Save_button: $save_button->{_is_Save_button}\n");
			
    if($save_button->{_flow_type} eq 'pre_built_superflow') {  # from conditions_gui
 				
    				# print("2. save_button, Save_pre_built_superflow,_values_aref: @{$save_button->{_values_aref}}[0]\n");
     				# my $thinks = scalar @{$save_button->{_values_aref}};
     				# print("3. save_button, Save_pre_built_superflow, default no. values=61!! values: $thinks\n");    				
		$config_superflows	->save($save_button);  # in 69
		$conditions_gui		->set4superflow_Save();
		$save_button 		= $conditions_gui->get_hash_ref();		
		
	} else { # if flow first needs a change to activate
		print("save_button,_Save_pre_built_superflow, _is_superflow_select_button = $save_button->{_is_superflow_select_button}\n");
			#
			#		$message          	= $save_button_messages->save_button(0);
			# 	  	$message_w			->delete("1.0",'end');
			# 	  	$message_w			->insert('end', $message);
	}
	
	$conditions_gui			->set4end_of_superflow_Save();
	$save_button 			= $conditions_gui->get_hash_ref();    # returns 89

 	return();	
 }
 
 

=head2 sub _get_dialog_type

e.g, topic can be Save 


=cut

 sub _get_dialog_type {
 	my ($self) = @_;
 	
 	my $topic = $save_button->{_dialog_type};
 	 		# print("save_button, _get_dialog_type = $topic\n");
 	
 	if ( $topic) { 		
		return($topic);
 			
 	} else {		
 		print("save_button, _get_dialog_type , missing topic\n");
 		return();
 	}
 }

	
=head2 sub _get_flow_type

	user_built_flow
	or
	pre_built_superflow
	
	
=cut

 sub _get_flow_type {
 	my ($self) = @_;
 	
 	my $how_built= $save_button->{_flow_type};
 	
 	if ($save_button->{_flow_type} ) { 		
		return($how_built );
 			
 	} else {		
 		print("save_button, _get_flow_type , missing topic\n");
 		return();
 	}

 }



=head2 sub director


 prior to saving
 determine if we are dealing with superflow 
 (" menubutton" widget)   
 - collect and/or access flow parameters
 - default path is the current path

 TODO:
 or with GUI-made flows ("frame widget")
 - collect and/or access flow parameters
 - default path is the current path

DB:
 print("current widget is $LSU->{_current_widget}\n"); 
 
 TODO: improve ENCAPSULATION:
 
 Analysis:
 
 i/p: $parameter_values_frame
 i/p: $L_SU_messages
 i/p: $message
 i/p: $param_flow
 i/p: $L_SU
 i/p: $config_superflows
 
 o/p: $conditions_gui	->set4start_of_Save_button();
 o/p: $conditions_gui	->set4_save_button
 o/p: $conditions_gui	->set4end_of_save_button();
  $L_SU 			= $conditions_gui->get_hash_ref();
 o/p: _check4changes();
 
 o/p: $L_SU
 o/p: $files_LSU
 
 
 save can be of 3 generic types:
 
 dialog type can be save  (Main menu)
 or SaveAs (FileDialog_button function)
 
 i.e. 'either'
 
 or
 	Save  perl program of user-built flow
 or
 	SaveAs perl program of user-built flow
 or	
 	Save pre-built superflow configuration files
		
=cut

=head2 sub director 

=cut
	
 sub director {
	my ($self) = @_;
	
	my $flow_type 			= _get_flow_type();
	my $save_dialog_type	= _get_dialog_type();
	
	
	if($flow_type eq $flow_type_h->{_user_built}) 					{
			print("save_button, director, is user_built flow_type:$flow_type\n");
		
		if ($save_dialog_type eq $file_dialog_type->{_Save} ) 		{
			# does not seem to do anything
			_user_built_flow_Save_perl_file();
			
		} elsif ($save_dialog_type eq $file_dialog_type->{_SaveAs} ) {
			# does not seem to be used	
			_user_built_flow_SaveAs_perl_file();
			
		} else {			
			print("save_button, director has a user_built Save or SaveAs problem \n");
		}
			
	} elsif ($flow_type eq $flow_type_h->{_pre_built_superflow} ) 	{
		 # print("save_button, director, is superflow_type:$flow_type\n");
		
		 # print("save_button, director, save_dialog_type: $save_dialog_type\n");
		
		if ($save_dialog_type eq $file_dialog_type->{_Save} ) 		{
			_Save_pre_built_superflow();
			
		}elsif ($save_dialog_type eq $file_dialog_type->{_SaveAs} )	{
			
			# do nothing ... superflows are not saved under a pseudonym
		} else {			
			print("save_button, director has superflow Save or SaveAs problem\n");			
		}
	
	} else {		
		 print("save_button, director has a flow-type problem\n");
	}
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
    
    if($save_button) {
    	 		# print("save_button, get_hash_ref , save_button->{_flow_color}: $save_button->{_flow_color}\n");  	
   		 	return($save_button);
   		
 	} else {		
 		print("save_button, get_hash_ref , missing hsave_button hash_ref\n");
 	}
 }
	  	 
 
=head2 sub _save_button_sub_ref

=cut

 sub set_save_button_sub_ref {
 	my ($self,$sub_ref) = @_;
 	
 	if ($sub_ref) {
 				print("binding  set_save_button_sub_ref, $sub_ref\n");
 		$save_button->{_sub_ref} = $sub_ref;
 		
 	} else{
		print("save_button, set_save_button_sub_ref, missing sub ref\n");
 	} 	
 	return();
 }
 

=head2 sub _save_button 

=cut
#
#sub _save_button {
# 	my ($self) 				= @_;
# 	
# 	use save;
#	use files_LSU;
#	use messages::message_director;
#	
#	# use whereami;
#	
#	my $L_SU_messages 	    = message_director->new();
#	# my $whereami			= whereami->new();
#	
# 	my $save 				= new save();
# 	my $files_LSU			= new files_LSU();
# 	
#	my $message          	= $L_SU_messages->null_button(0);
# 	$message_w   			->delete("1.0",'end');
# 	$message_w   			->insert('end', $message); 	
# 	
# 	$conditions_gui			->set_hash_ref($L_SU);
#	$conditions_gui			->set_gui_widgets($L_SU);
#	$conditions_gui			->set4start_of_Save_button();
#	$L_SU 					= $conditions_gui->get_hash_ref();
#	
#        	# location within GUI   
#	my $widget_type		= $whereami->widget_type($parameter_values_frame);
#			# print("L_SU,save_button,widget_type = $widget_type\n");
#
#			# FOR SUPERFLOWS only
#			# print("L_SU,save_button,is_superflow_select_button:$L_SU->{_is_superflow_select_button}\n");
#    if($L_SU->{_is_superflow_select_button}) {
#		$config_superflows	->save($L_SU);
#		$conditions_gui		->set4_save_button();
#		 $L_SU 			= $conditions_gui->get_hash_ref();
#		
#		# for REGULAR FLOWS but only if activated
#	} elsif ( ($L_SU->{_is_flow_listbox_grey_w} || 
#	    $L_SU->{_is_flow_listbox_green_w}) &&
#	    $widget_type eq 'Entry' )  {		
#
#			# consider empty case	
#		if( !($L_SU->{_flow_name_out}) ||
#			$L_SU->{_flow_name_out} eq '') {
#
#			$message          = $L_SU_messages->save_button(1);
# 	  		$message_w		->delete("1.0",'end');
# 	  		$message_w		->insert('end', $message);
#
#		} else {  # good case
#			# print("1. save_button, saving flow: $L_SU->{_flow_name_out}\n");
#    	}
#    	
#		_check4changes(); 	
#		$param_flow						->set_good_values;
#		$param_flow						->set_good_labels;
#		$L_SU->{_good_labels_aref2}		= $param_flow->get_good_labels_aref2;
#		$L_SU->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref;
#		$L_SU->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
#		$L_SU->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref;
#
#		 		# print("save_button,_prog_names_aref,
#		 		# @{$L_SU->{_prog_names_aref}}\n");
#		# my $num_items4flow = scalar @{$L_SU->{_good_labels_aref2}};
#
#				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
#					# print("save_button,_good_labels_aref2,
#				# @{@{$L_SU->{_good_labels_aref2}}[$i]}\n");
#				# }
#
#				# for (my $i=0; $i < $num_items4flow; $i++ ) {
#				#	print("save_button,_good_values_aref2,
#				#	@{@{$L_SU->{_good_values_aref2}}[$i]}\n");
#				#}
#				#   print("save_button,_prog_versions_aref,
#				#   @{$L_SU->{_items_versions_aref}}\n");
#
# 		$files_LSU	->set_prog_param_labels_aref2($L_SU);
# 		$files_LSU	->set_prog_param_values_aref2($L_SU);
# 		$files_LSU	->set_prog_names_aref($L_SU);
# 		$files_LSU	->set_items_versions_aref($L_SU);
# 		$files_LSU	->set_data();
# 		$files_LSU	->set_message($L_SU);
#		$files_LSU	->set2pl($L_SU); # flows saved to PL_SEISMIC
#		$files_LSU	->save();
#		$conditions_gui	->set4_save_button();
#		$L_SU 			= $conditions_gui->get_hash_ref();
#		
#	} else { # if flow first needs a change for activation
#
#		$message          	= $L_SU_messages->save_button(0);
# 	  	$message_w			->delete("1.0",'end');
# 	  	$message_w			->insert('end', $message);
#	}
#	
#	$conditions_gui	->set4end_of_save_button();
#	$L_SU 			= $conditions_gui->get_hash_ref();
#   	return();
#}



=head2 sub set_dialog_type

 save can be of 3 generic types:
 
 dialog type can be save  (Main menu)
 or SaveAs (FileDialog_button function)
 
 i.e. 'either'
 
 or
 	save  (perl program of user-built flow
 or
 	saveas perl program of user-built flow
 or	
 	save pre-built superflow configuration files
		
	
=cut

 sub set_dialog_type {
 	my ($self,$topic) = @_;
 	
 	if ( $topic) {		
 		$save_button->{_dialog_type} = $topic;
 		 # print("save_button, set_dialog_type , $save_button->{_dialog_type} \n");
 			
 	} else {		
 		print("save_button, set_dialog_type , missing topic\n");
 	}
 	return();
 }






=head2 sub set_flow_type

	user_built_flow
	or
	pre_built_superflow
	
=cut
 sub set_flow_type {
 	my ($self,$how_built) = @_;
 	
 	if ( $how_built ) { 		
 		$save_button->{_flow_type} = $how_built;
 			# print("save_button, set_flow_type : $save_button->{_flow_type}\n");
 			
 	} else {		
 		print("save_button, set_flow_type , missing how_built\n");
 	}
 	return();
 }


 	
=head2 sub set_gui_widgets

	bring it important widget addresses
	37 
	
	make convenient locat shorter names for 7
	
=cut

 sub set_gui_widgets {
 	my ($self,$gui_widgets) = @_;
 	
 	if ( $gui_widgets) {

      	$save_button->{_Data_menubutton}				= $gui_widgets->{_Data_menubutton};		
      	$save_button->{_Flow_menubutton}				= $gui_widgets->{_Flow_menubutton};
     	$save_button->{_SaveAs_menubutton}				= $gui_widgets->{_SaveAs_menubutton};      				
     	$save_button->{_add2flow_button_grey}			= $gui_widgets->{_add2flow_button_grey};
      	$save_button->{_add2flow_button_pink}			= $gui_widgets->{_add2flow_button_pink}; 
      	$save_button->{_add2flow_button_green}			= $gui_widgets->{_add2flow_button_green}; 
     	$save_button->{_add2flow_button_blue}			= $gui_widgets->{_add2flow_button_blue};
  		$save_button->{_check_code_button} 				= $gui_widgets->{_check_code_button};
 		$save_button->{_check_buttons_w_aref}			= $gui_widgets->{_check_buttons_w_aref};
 		$save_button->{_delete_from_flow_button}		= $gui_widgets->{_delete_from_flow_button};		
 	 	$save_button->{_dnd_token_grey}					= $gui_widgets->{_dnd_token_grey};
  		$save_button->{_dnd_token_pink}					= $gui_widgets->{_dnd_token_pink};
   		$save_button->{_dnd_token_green}				= $gui_widgets->{_dnd_token_green};
   		$save_button->{_dnd_token_blue}					= $gui_widgets->{_dnd_token_blue};
   		$save_button->{_dropsite_token_grey}			= $gui_widgets->{_dropsite_token_grey};
  		$save_button->{_dropsite_token_pink}			= $gui_widgets->{_dropsite_token_pink};
   		$save_button->{_dropsite_token_green}			= $gui_widgets->{_dropsite_token_green};
   		$save_button->{_dropsite_token_blue}			= $gui_widgets->{_dropsite_token_blue};
   		$save_button->{_file_menubutton} 				= $gui_widgets->{_file_menubutton}; 
   		$save_button->{_flowNsuperflow_name_w}			= $gui_widgets->{_flowNsuperflow_name_w};	
   		$save_button->{_flow_item_down_arrow_button}	= $gui_widgets->{_flow_item_down_arrow_button};
 		$save_button->{_flow_item_up_arrow_button}		= $gui_widgets->{_flow_item_up_arrow_button};	
 		$save_button->{_flow_listbox_grey_w} 			= $gui_widgets->{_flow_listbox_grey_w};
 		$save_button->{_flow_listbox_pink_w} 			= $gui_widgets->{_flow_listbox_pink_w}; 		
 		$save_button->{_flow_listbox_green_w} 			= $gui_widgets->{_flow_listbox_green_w};
  		$save_button->{_flow_listbox_blue_w} 			= $gui_widgets->{_flow_listbox_blue_w};
  		$save_button->{_flow_listbox_color_w} 			= $gui_widgets->{_flow_listbox_color_w}; 
  		$save_button->{_flow_name_grey_w} 				= $gui_widgets->{_flow_name_grey_w}; 
 		$save_button->{_flow_name_pink_w} 				= $gui_widgets->{_flow_name_pink_w};	 
  		$save_button->{_flow_name_green_w} 				= $gui_widgets->{_flow_name_green_w};	
 		$save_button->{_flow_name_blue_w} 				= $gui_widgets->{_flow_name_blue_w}; 		
  		$save_button->{_flow_widget_index}				= $gui_widgets->{_flow_widget_index};
    	$save_button->{_labels_w_aref}					= $gui_widgets->{_labels_w_aref};
    	$save_button->{_last_flow_listbox_touched_w} 	= $gui_widgets->{_last_flow_listbox_touched_w};
   		$save_button->{_message_w}						= $gui_widgets->{_message_w};
   		$save_button->{_mw}								= $gui_widgets->{_mw};
   		$save_button->{_parameter_names_frame}  		= $gui_widgets->{_parameter_names_frame};
   		$save_button->{_parameter_values_button_frame}	= $gui_widgets->{_parameter_values_button_frame};
    	$save_button->{_parameter_values_frame} 		= $gui_widgets->{_parameter_values_frame};
		$save_button->{_parameter_value_index}			= $gui_widgets->{_parameter_value_index};
    	$save_button->{_run_button} 					= $gui_widgets->{_run_button};
    	$save_button->{_save_button} 					= $gui_widgets->{_save_button};
    	$save_button->{_values_w_aref}					= $gui_widgets->{_values_w_aref};	
		
		$mw											= $save_button->{_mw};
		$parameter_values_frame						= $save_button->{_parameter_values_frame};
		$parameter_value_index						= $save_button->{_parameter_value_index};
		$values_aref								= $save_button->{_values_aref};
 		$message_w									= $save_button->{_message_w};
 		$flow_listbox_grey_w						= $save_button->{_flow_listbox_grey_w};
 		$flow_listbox_green_w						= $save_button->{_flow_listbox_green_w};
 				
 				# print("save_button, set_gui_widgets	parameter_values_frame: $parameter_values_frame\n");				
 	} else {
		
 		print("save_button, set_gui_widgets, missing gui_widgets\n");
 	}
 	return();
 }

	
=head2 sub set_hash_ref

	bring in important widget addresses 
	78 off
	
=cut

 sub set_hash_ref {
 	my ($self,$hash_ref) = @_;
 	
 	if ( $hash_ref) {
 		
		$save_button->{_FileDialog_sub_ref}					= $hash_ref->{_FileDialog_sub_ref};		 
		$save_button->{_FileDialog_option}					= $hash_ref->{_FileDialog_option};
  		$save_button->{_check_buttons_settings_aref}		= $hash_ref->{_check_buttons_settings_aref};
  		$save_button->{_destination_index}					= $hash_ref->{_destination_index};
		$save_button->{_dialog_type} 						= $hash_ref->{_dialog_type};
		$save_button->{_flow_color} 						= $hash_ref->{_flow_color};
 		$save_button->{_flow_name_in} 						= $hash_ref->{_flow_name_in};
   		$save_button->{_flow_name_out} 						= $hash_ref->{_flow_name_out};
   		$save_button->{_flow_type} 							= $hash_ref->{_flow_type};
		$save_button->{_flow_widget_index} 					= $hash_ref->{_flow_widget_index};
		$save_button->{_gui_history_aref} 					= $hash_ref->{_gui_history_aref};		
		$save_button->{_has_used_check_code_button}			= $hash_ref->{_has_used_check_code_button};
		$save_button->{_has_used_open_perl_file_button}		= $hash_ref->{_has_used_open_perl_file_button};
		$save_button->{_has_used_run_button} 				= $hash_ref->{_has_used_run_button};
		$save_button->{_has_used_Save_button} 				= $hash_ref->{_has_used_Save_button};
		$save_button->{_has_used_Save_superflow} 			= $hash_ref->{_has_used_Save_superflow};
		$save_button->{_has_used_SaveAs_button} 			= $hash_ref->{_has_used_SaveAs_button}; 	
 		$save_button->{_is_add2flow_button} 				= $hash_ref->{_is_add2flow_button};
 		$save_button->{_index2move}							= $hash_ref->{_index2move};
 		$save_button->{_is_check_code_button} 				= $hash_ref->{_is_check_code_button};
 		$save_button->{_is_delete_from_flow_button} 		= $hash_ref->{_is_delete_from_flow_button};
 		$save_button->{_is_dragNdrop} 						= $hash_ref->{_is_dragNdrop};
 		$save_button->{_is_flow_listbox_grey_w} 			= $hash_ref->{_is_flow_listbox_grey_w};
 		$save_button->{_is_flow_listbox_pink_w} 			= $hash_ref->{_is_flow_listbox_pink_w};
 		$save_button->{_is_flow_listbox_green_w} 			= $hash_ref->{_is_flow_listbox_green_w};
 		$save_button->{_is_flow_listbox_blue_w} 			= $hash_ref->{_is_flow_listbox_blue_w};
 		$save_button->{_is_flow_listbox_color_w} 			= $hash_ref->{_is_flow_listbox_color_w}; 		
  		$save_button->{_is_last_flow_index_touched_grey} 	= $hash_ref->{_is_last_flow_index_touched_grey}; 		 
		$save_button->{_is_last_flow_index_touched_pink} 	= $hash_ref->{_is_last_flow_index_touched_pink};		
		$save_button->{_is_last_flow_index_touched_green}	= $hash_ref->{_is_last_flow_index_touched_green};  	
		$save_button->{_is_last_flow_index_touched_blue}	= $hash_ref->{_is_last_flow_index_touched_blue};  		
		$save_button->{_is_last_flow_index_touched}  		= $hash_ref->{_is_last_flow_index_touched};			
		$save_button->{_is_last_parameter_index_touched_grey}  	= $hash_ref->{_is_last_parameter_index_touched_grey};
		$save_button->{_is_last_parameter_index_touched_pink}  	= $hash_ref->{_is_last_parameter_index_touched_pink};
		$save_button->{_is_last_parameter_index_touched_green}  = $hash_ref->{_is_last_parameter_index_touched_green};	
		$save_button->{_is_last_parameter_index_touched_blue} = $hash_ref->{_is_last_parameter_index_touched_blue};	
		$save_button->{_is_last_parameter_index_touched_color} = $hash_ref->{_is_last_parameter_index_touched_color};		
		$save_button->{_is_Save_button} 				= $hash_ref->{_is_Save_button};	
	   	$save_button->{_is_SaveAs_button} 				= $hash_ref->{_is_SaveAs_button};
  		$save_button->{_is_SaveAs_file_button} 			= $hash_ref->{_is_SaveAs_file_button};
  		$save_button->{_is_open_file_button} 			= $hash_ref->{_is_open_file_button};
  		$save_button->{_is_run_button} 					= $hash_ref->{_is_run_button};
		$save_button->{_is_moveNdrop_in_flow} 			= $hash_ref->{_is_moveNdrop_in_flow};
		$save_button->{_is_user_built_flow} 			= $hash_ref->{_is_user_built_flow};
 		$save_button->{_is_select_file_button} 			= $hash_ref->{_is_select_file_button};
  		$save_button->{_is_selected_file_name}			= $hash_ref->{_is_selected_file_name};
  		$save_button->{_is_selected_path}				= $hash_ref->{_is_selected_path};  		
 		$save_button->{_is_superflow}					= $hash_ref->{_is_superflow};
  		$save_button->{_is_new_listbox_selection} 		= $hash_ref->{_is_new_listbox_selection};
  		$save_button->{_is_pre_built_superflow}			= $hash_ref->{_is_pre_built_superflow}; 
   		$save_button->{_is_sunix_listbox} 				= $hash_ref->{_is_sunix_listbox};
    	$save_button->{_is_superflow}					= $hash_ref->{_is_superflow};
   		$save_button->{_is_superflow_select_button} 	= $hash_ref->{_is_superflow_select_button};			
   		$save_button->{_is_moveNdrop_in_flow} 			= $hash_ref->{_is_moveNdrop_in_flow};			
  		$save_button->{_items_checkbuttons_aref2} 		= $hash_ref->{_items_checkbuttons_aref2};		 
  		$save_button->{_items_names_aref2}   			= $hash_ref->{_items_names_aref2};		 
 		$save_button->{_items_values_aref2}   			= $hash_ref->{_items_values_aref2};		 
		$save_button->{_items_versions_aref}  			= $hash_ref->{_items_versions_aref}; 		 
   		$save_button->{_last_flow_index_touched}		= $hash_ref->{_last_flow_index_touched};
    	$save_button->{_last_flow_index_touched_grey}	= $hash_ref->{_last_flow_index_touched_grey};
   		$save_button->{_last_flow_index_touched_pink}	= $hash_ref->{_last_flow_index_touched_pink};
   		$save_button->{_last_flow_index_touched_green}	= $hash_ref->{_last_flow_index_touched_green};
   		$save_button->{_last_flow_index_touched_blue}	= $hash_ref->{_last_flow_index_touched_blue};
   		$save_button->{_last_flow_listbox_touched}    	= $hash_ref->{_last_flow_listbox_touched};
   		$save_button->{_last_path_touched} 				= $hash_ref->{_last_path_touched};
   		$save_button->{_names_aref}						= $hash_ref->{_names_aref};    		
      	$save_button->{_occupied_listbox_aref}    		= $hash_ref->{_occupied_listbox_aref};
   		$save_button->{_param_flow_length}      		= $hash_ref->{_param_flow_length};  		 
 		$save_button->{_param_sunix_first_idx}       	= $hash_ref->{_param_sunix_first_idx};
 		$save_button->{_param_sunix_length}   			= $hash_ref->{_param_sunix_length};		  	  
		$save_button->{_path} 							= $hash_ref->{_path}; 		 
 		$save_button->{_prog_names_aref}  				= $hash_ref->{_prog_names_aref};		  		
  		$save_button->{_selected_file_name} 			= $hash_ref->{_selected_file_name};			 
   		$save_button->{_sub_ref}						= $hash_ref->{_sub_ref};  
   		$save_button->{_sunix_listbox} 					= $hash_ref->{_sunix_listbox};  
		$save_button->{_superflow_first_idx} 			= $hash_ref->{_superflow_first_idx};
		$save_button->{_superflow_length} 				= $hash_ref->{_superflow_length};		 
   		$save_button->{_values_aref}					= $hash_ref->{_values_aref};
   		$save_button->{_prog_name_sref}					= $hash_ref->{_prog_name_sref};	
 
 			# print("save_button,set_hash_ref, values_aref :@{$save_button->{_values_aref}}[0]\n");
 			# print("save_button,set_hash_ref, names_aref :@{$save_button->{_names_aref}}[0]\n");
 			
 	} else {
		
 		print("save_button, set_gui_widgets, missing hash_ref\n");
 	}
 	return();
 }
 
 
=head2 sub set_prog_name_sref

	in order to know what
	_spec file to read for
	behaviors
	
=cut
 sub set_prog_name_sref {
 	my ($self,$name_sref) = @_;
 	
 	if ( $name_sref) {		
 		$save_button->{_prog_name_sref} = $name_sref;
 			# print("save_button, set_prog_name_sref , ${$save_button->{_prog_name_sref}}\n");
 			
 	} else {		
 		print("save_button, set_prog_name_sref , missing name\n");
 	}
 	return();
 }
 	

1;