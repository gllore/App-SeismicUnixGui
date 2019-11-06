package neutral_flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: neutral_flow.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 

 DESCRIPTION 
     
     Is used only to inspect labels/names of different available
     sunix programs 
     'neutral' refers to that no colored box is available to build a flow
     from these selections

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
    
    flow_listbox_neutral_w  	-top left listbox, input by user selection
    flow_listbox_green_w  	-bottom right listbox,input by user selection
    sunix_listbox   		-choice of listed sunix modules in a listbox
    

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl
 
 V 0.0.2 Aug 12 2018 
 include multi-"colored" flows

=cut 

=head2 Notes from bash
 
=cut 

 	use Moose;
 	our $VERSION = '0.0.2';			 
	
	use param_widgets_neutral;  # K
	use param_flow_neutral; # K		
	use whereami;  # used extensively for whole-gui awareness
	use flow_widgets;
	use conditions_gui;
	
 	my $conditions_gui		= conditions_gui 	->new();
 	my $flow_widgets		= flow_widgets		->new();
 	my $get					= L_SU_global_constants->new();
 	my $param_flow     		= param_flow_neutral 	->new();
 			# print("user_built flow, make param_flow instance in user_built flow\n");
 	my $param_widgets		= param_widgets_neutral ->new();
 	my $whereami           	= whereami			->new();
 	my $flow_type			= $get->flow_type_href();

 
=head2

 share the following parameters in same name 
 space

=cut
 	my $FileDialog_sub_ref;
 	my $FileDialog_option;
 	my ($dnd_token_grey,$dnd_token_pink,$dnd_token_green,$dnd_token_blue,$dnd_token_neutral);
 	my ($dropsite_token_grey, $dropsite_token_pink,$dropsite_token_green,$dropsite_token_blue,$dropsite_token_neutral);
 	my ($mw);
 	my ($parameter_values_button_frame );
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($flow_listbox_grey_w,$flow_listbox_pink_w,$flow_listbox_green_w,$flow_listbox_blue_w,$flow_listbox_color_w,$flow_listbox_neutral_w);
 	my ($flow_color);
 	my ($flow_name_grey_w,$flow_name_pink_w,$flow_name_green_w,$flow_name_blue_w,$flow_name_neutral_w);
 	my ($flowNsuperflow_name_w);
 	my ($labels_w_aref, $values_w_aref, $check_buttons_w_aref);
 	my $last_flow_color;
 	my $message_w;
 	my $sunix_listbox;
 	my  $save_button;
	my ($add2flow_button_grey, $add2flow_button_pink, $add2flow_button_green, $add2flow_button_blue, $add2flow_button_neutral, $check_code_button);
	my ($delete_from_flow_button);
	my $dialog_type;	
 	my ($file_menubutton);
 	my ($flow_item_down_arrow_button, $flow_item_up_arrow_button);

	my $var								= $get->var();
#	my $on         						= $var->{_on};
	my $true       						= $var->{_true};
	my $false      						= $var->{_false};
#   my $superflow_names     			= $get->superflow_names_h();	
  	my @empty_array = (0); # length=1
 

=head2 private hash

	92 off 
	_is_flow_listbox_color_w is generic colored widget
	Warning: conditions_gui.pm does not contain all the hash keys and values
	that follow-- these variables will be reset by conditions_gui.p.

=cut

my $neutral_flow   = {
	
	_FileDialog_sub_ref				=> '',
	_FileDialog_option				=> '',
 	_add2flow_button_grey			=> '',#
 	_add2flow_button_pink			=> '',#
 	_add2flow_button_green			=> '',#
 	_add2flow_button_blue			=> '',#
 	_check_code_button				=> '', #
 	_check_buttons_settings_aref    => '',
 	_check_buttons_w_aref			=> '',#		 		
 	_delete_from_flow_button		=> '', #
 	_destination_index	 			=> '',
 	_dialog_type					=> '',#
 	_dnd_token_grey					=> '',
  	_dnd_token_pink					=> '', 
   	_dnd_token_green				=> '', 
    _dnd_token_blue					=> '',  
 	_dropsite_token_grey			=> '',
  	_dropsite_token_pink			=> '',
   	_dropsite_token_green			=> '',
    _dropsite_token_blue			=> '', 
 	_file_menubutton				=> '',#
 	_flow_color						=> '',#
 	_flow_item_down_arrow_button	=> '',
 	_flow_item_up_arrow_button		=> '', 	
 	_flow_listbox_grey_w			=> '',#
 	_flow_listbox_pink_w			=> '', # 
  	_flow_listbox_green_w			=> '',#
   	_flow_listbox_blue_w			=> '',#
    _flow_listbox_neutral_w			=> '',
   	_flow_listbox_color_w			=> '', #
   	_flow_name_grey_w				=> '',
   	_flow_name_pink_w				=> '',
   	_flow_name_green_w				=> '',
   	_flow_name_blue_w				=> '',  	
   	_flow_name_out					=> '',#
  	_flow_type						=> $flow_type->{_user_built},#
    _flow_widget_index				=> '',#
 	_flowNsuperflow_name_w			=> '',
	_good_labels_aref2				=> '',
	_good_values_aref2 				=> '',
	_has_used_open_perl_file_butt	 => '',
    _has_used_Save_button			=> '',	#
    _has_used_Save_superflow		=> '',	#
    _has_used_SaveAs_button			=> '',#
    _has_used_run_button			=> '',#
    _index2move	    				=> '',
	_is_check_code_button          	=> '',#
    _is_SaveAs_file_button			=> '',#	
	_is_add2flow_button	   			=> '',#
	_is_check_code_button          	=> '',#
	_is_delete_from_flow_button	   	=> '',#
 	_is_flow_item_down_arrow_button	=> '',
 	_is_flow_item_up_arrow_button	=> '', 	
	_is_flow_listbox_grey_w			=> '',#
	_is_flow_listbox_pink_w			=> '',#	
	_is_flow_listbox_green_w		=> '',#
	_is_flow_listbox_blue_w			=> '',#
	_is_flow_listbox_color_w		=> '',#
    _is_pre_built_superflow			=> '',
	_is_run_button          		=> '',#
	_is_sunix_listbox				=> '',#
	_is_superflow_select_button		=> 0,#
	_is_superflow 					=> '',  # should it be _pre_built_superflow?#
	_is_user_built_flow				=> '',
  	_items_checkbuttons_aref2 		=> '',
  	_items_names_aref2  			=> '',
  	_items_values_aref2  			=> '',
  	_items_versions_aref 			=> '',	
  	_labels_w_aref					=> '',#
 	_last_flow_index_touched	 	=> -1,#
 	_last_flow_listbox_touched 		=> '',
 	_last_flow_listbox_touched_w	=> -1,
 	_last_parameter_index_touched_color   => -1,#
 	_last_path_touched				=> './',
  	_message_w						=> '', # 
   	_mw								=> '',#
  	_names_aref    					=> '',
 	_param_flow_length        		=> '', 	
   	_parameter_names_frame  		=> '',
	_param_sunix_first_idx      	=> 0,
	_param_sunix_length  			=> '', 
 	_parameter_values_frame 		=> '', #
 	_parameter_values_button_frame	=> '', 
	_parameter_value_index  		=> -1,#
	_prog_name_sref					=> '',#
	_prog_names_aref 				=> '',
	_run_button						=> '',#
	_save_button					=> '', #
 	_sunix_listbox					=> '', 
	_values_aref  					=> \@empty_array,  # initialise empty array
	_values_w_aref					=> '',#
	
    };


=head2 sub _FileDialog_button
	
 	
=cut

 sub _FileDialog_button {   # N.B. Another FileDialog_button in L_SU needs to be updated too!!!!!!!
	
	my ($self,$option_sref) = @_;
	use file_dialog;
	my $file_dialog			= file_dialog ->new();
	
	if ($option_sref)  {
		
		$neutral_flow		->{_dialog_type}  = $$option_sref;  # dereference scalar
		
		$file_dialog		->set_flow_color($neutral_flow->{_flow_color}); 	# uses 1/ 31 in	 
		$file_dialog 		->set_hash_ref($neutral_flow);       # uses 7/ 31 in  ; uses values_aref
		$file_dialog		->set_gui_widgets($neutral_flow);    # uses 18/ 31 in
		$file_dialog 		->FileDialog_director();
		
		# assume that while selecting a data file to open in file-dialog that the
		# GUI has been updated (not very elegant... TODO
		# See if the last parameter index has been touched (>= 0)
		# assume we are still dealing with the current flow item selected
		$neutral_flow->{_last_parameter_index_touched_color} = $file_dialog->get_last_parameter_index_touched_color();
		_check4parameter_changes();
				
	} else {		
		print("neutral_flow,_FileDialog_button (binding),option type missing \n");
	}
	return();
 }

=head2  _check4flow_changes

	assume now that selection of a flow item will always change a previously existing
	assume that opening a file dialog will change a parameter (Entry widget) value
	set of flow parameters, That is, a prior program must have been touched
	
	if ($param_widgets->get_entry_change_status && $neutral_flow->{_last_flow_index_touched} >= 0) {		
    	  foreach my $key (sort keys %$neutral_flow) {
           print (" neutral_flowkey is $key, value is $neutral_flow->{$key}\n");
           used only by flow_select and sunix_select
          }
             
		 ( $neutral_flow->{_last_parameter_index_touched_color} ) >= 0)        
=cut 

sub _check4flow_changes {
	my ($self) = @_;	
 	use control;
	my $control				= new control();
	
   # print("neutral_flow check4flow_changes: _last_flow_index_touched $neutral_flow->{_last_flow_index_touched}\n");
   # print("neutral_flow check4flow_changes: _last_parameter_index_touched_color $neutral_flow->{_last_parameter_index_touched_color}\n");
   
	if ( $neutral_flow->{_last_flow_index_touched} >= 0 ){  # <-1 does exist and means the flow was not touched

		my $last_idx_chng = $neutral_flow->{_last_flow_index_touched} ;

	 					      # print("neutral_flow_check4flow_changes,
	 					      # last changed entry index was $last_idx_chng\n");
  							  # print("neutral_flow _check4flow_changes program name is 
  							  # ${$neutral_flow->{_prog_name_sref}}\n");
  							  # the chekbuttons, values and names of only the last program used 
  							  # is stored in param_widgets at any one time			
		$neutral_flow->{_values_aref} 					= $param_widgets	->get_values_aref();
		$neutral_flow->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$neutral_flow->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();
	
		# restore strings to have terminal strings
		# remove quotes upon input	
 		$neutral_flow->{_values_aref}					= $control->get_no_quotes4array ($neutral_flow->{_values_aref}); 
		# in case parameter values have been displayed stringless
 		$neutral_flow->{_values_aref}					= $control->get_string_or_number4array($neutral_flow->{_values_aref});
		
  							#print("neutral_flowflow_select,changed values_aref: @{$neutral_flow->{_values_aref}}\n");
  							#print("neutral_flow_changes4changes,changed names_aref: @{$neutral_flow->{_names_aref}}\n");
  							#print(" neutral_flowflow_select,changes, check_buttons_settings_aref: @{$neutral_flow->{_check_buttons_settings_aref}}\n");
  							#
   		 $param_flow	-> set_flow_index($last_idx_chng);
  						 	     # print("neutral_flow check4flow_changes ,store changes in param_flow, last changed entry index $last_idx_chng\n");
  						 	    
								# save old changed values
		 $param_flow	->set_values_aref($neutral_flow->{_values_aref}); 		# but not the versions
	 	 $param_flow	->set_names_aref($neutral_flow->{_names_aref}); 		# but not the versions
		 $param_flow	->set_check_buttons_settings_aref($neutral_flow->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
	 	 						 # print("neutral_flow flow_select, set_entry_change_status: to 0\n");
	}  						

	return();
 }


=head2  _check4parameter_changes

	Assume that the program of interest within an activate flow does not change
	Assume that a parameter within a fixed program has changed so that
	the stored paramters for that program need to be updated.
	That is param_flow will update the stored parameters for a member of the flow
	without having to change with which flow item/program we interact.
	
	N.B. The checkbuttons, values and names of only the present program in use 
  	are stored in param_widgets at any one time
  	
  	For example, after selecting  a data file name, the file name is automatically inserted
  	into the GUI. Following we update the data file name into the stored parameters via param_flow
  	
  	Required: current flow item number, current parameter index in use
	   
=cut 

sub _check4parameter_changes {
	my ($self) = @_;	
 	use control;
	my $control				= new control();
		
   		# print("B4 neutral_flow check4changes: _last_flow_index_touched $neutral_flow->{_last_flow_index_touched}\n");
   		# print("B4 neutral_flow check4changes: _last_parameter_index_touched_color: $neutral_flow->{_last_parameter_index_touched_color}\n");
   
	if ( $neutral_flow->{_last_parameter_index_touched_color} >= 0 ){  # <-1 does exist and means the parameters are untouched

		my $last_parameter_idx_touched = $neutral_flow->{_last_parameter_index_touched_color} ;

	 		# print("neutral_flow_check4parameter_changes,last changed entry index was $last_parameter_idx_touched \n");
  		# print("neutral_flow _check4parameter_changes current program name in use: ${$neutral_flow->{_prog_name_sref}}\n");
  							 							  		
		$neutral_flow->{_values_aref} 					= $param_widgets	->get_values_aref();
		$neutral_flow->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$neutral_flow->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();
	
		# restore strings to have terminal strings
		# remove quotes upon input	
 		$neutral_flow->{_values_aref}					= $control->get_no_quotes4array ($neutral_flow->{_values_aref}); 
		# in case parameter values have been displayed stringless
 		$neutral_flow->{_values_aref}					= $control->get_string_or_number4array($neutral_flow->{_values_aref});

  							# print("neutral_flow flow_select,changed values_aref: @{$neutral_flow->{_values_aref}}[0]\n");
  							#print("neutral_flow_changes4changes,changed names_aref: @{$neutral_flow->{_names_aref}}\n");
  							#print(" neutral_flowflow_select,changes, check_buttons_settings_aref: @{$neutral_flow->{_check_buttons_settings_aref}}\n");
  							
	
  		# flow item index of the program in the neutral-flow listbox that is currently being used, i.e., not the index of the last-used program
  		my $flow_listbox_color_w 		= _get_flow_listbox_color_w();  # user-built_flow in current use 
   		my $current_flow_listbox_index 	= $flow_widgets->get_flow_selection($flow_listbox_color_w);
		$param_flow						-> set_flow_index($current_flow_listbox_index);
							# print("neutral_flow check4parameter_changes ,current_flow_listbox_index: $current_flow_listbox_index \n");
  						 	    
								# save current values
		 $param_flow	->set_values_aref($neutral_flow->{_values_aref}); 		# but not the versions
	 	 $param_flow	->set_names_aref($neutral_flow->{_names_aref}); 		# but not the versions
		 $param_flow	->set_check_buttons_settings_aref($neutral_flow->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
	 	 		# print("neutral_flow ,check4paramter_changes, set_entry_change_status: to 0\n");
	 	 						 # if er reinitialize last_paramter_index_touched to -1
	 	 						 # then this subroutine may not be used
	 	 $neutral_flow->{_last_parameter_index_touched_color} = -1;
	 	 $neutral_flow->{_last_flow_index_touched}      = $current_flow_listbox_index; # for next time
	 	 
	 	# print("End neutral_flow check4changes: _last_flow_index_touched $neutral_flow->{_last_flow_index_touched}\n");
   		# print("BEndneutral_flow check4changes: _last_parameter_index_touched_color reset: $neutral_flow->{_last_parameter_index_touched_color}\n");
	}  						

	return();
 }



=head2 sub _get_flow_listbox_color_w


=cut 

 sub _get_flow_listbox_color_w {
	my ($self)   = @_;
	my $flow_color;
	my $correct_flow_listbox_color_w;
	
	$flow_color 		= $neutral_flow->{_flow_color};
	
	if ($flow_color eq 'grey') {
		$correct_flow_listbox_color_w =  $neutral_flow->{_flow_listbox_grey_w};
		
	} elsif ($flow_color eq 'pink')  {
		$correct_flow_listbox_color_w = $neutral_flow->{_flow_listbox_pink_w};
		
	} elsif ($flow_color eq 'green') {
		$correct_flow_listbox_color_w =  $neutral_flow->{_flow_listbox_green_w};
		
	} elsif ($flow_color eq 'blue')  {
		$correct_flow_listbox_color_w =  $neutral_flow->{_flow_listbox_blue_w};
		
	} elsif ($flow_color eq 'neutral'){
		print("neutral_flow, _get_flow_listbox_color_w, neutral color\n");
	} else {
		print("neutral_flow, _get_flow_listbox_color_w, missing color\n");
		
	}
    print("neutral_flow, _get_flow_listbox_color_w, current color is $flow_color\n");
	return($correct_flow_listbox_color_w);
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
	my $self 		= @_;
   
	$neutral_flow->{_index2move}        	= $flow_widgets->index2move();
   	$neutral_flow->{_destination_index} 	= $flow_widgets->destination_index();

   	my $start	= $neutral_flow->{_index2move};
  	my $end	    = $neutral_flow->{_destination_index};
   			 # print("neutral_flow_move_in_stored_flows,start index is the $start\n");
   			 # print("neutral_flow_move_in_stored_flows, insertion index is $end \n");

   	$param_flow	->set_insert_start($start);
   	$param_flow	->set_insert_end($end);
   	$param_flow	->insert_selection(); 
  	return(); 
 }




=head2 sub _SaveAs_button

	topic: only for 'SaveAs'
  	for safety, place set_hash_ref first
  	
   	my	$m          	= "neutral_flow, _SaveAs_button, Test,set_specs,message,$message_w\n";
 	$message_w->delete("1.0",'end');
 	$message_w->insert('end', $m);

=cut

 sub _SaveAs_button {
 	my ($topic) = @_;
 	
	if ($topic eq 'SaveAs') {
		
		use files_LSU;

		my $files_LSU			= new files_LSU();
		
		#$conditions_gui			->set_hash_ref();       # 36 used of 85 in
		#$conditions_gui			->set_gui_widgets();	# 23 used of 85 in
		#$conditions_gui			->set4_start_of_SaveAs_button();

		my $num_items 			= $param_flow->get_num_items();
  			# print("1. neutral_flow, _SaveAs_button, B4 stored number of prgrams: $num_items\n");
  	 	$neutral_flow->{_names_aref} 	= $param_flow->get_names_aref();
  			# print("2. neutral_flow ,_SaveAs_button parameter names: @{$neutral_flow->{_names_aref}}[0]\n");
	
		$param_flow				->set_good_values();
		$param_flow				->set_good_labels();
		
		$neutral_flow->{_good_labels_aref2}	= $param_flow->get_good_labels_aref2();
		$neutral_flow->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref();
		$neutral_flow->{_good_values_aref2} 	= $param_flow->get_good_values_aref2();
		$neutral_flow->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref();

		 		 # print("neutral_flow,_prog_names_aref,
		 		 # @{$neutral_flow->{_prog_names_aref}}\n");
		# my $num_items4flow = scalar @{$neutral_flow->{_good_labels_aref2}};

				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
					# print("userBuiltFlow,_good_labels_aref2,
				# @{@{$neutral_flow->{_good_labels_aref2}}[$i]}\n");
				# }

				# for (my $i=0; $i < $num_items4flow; $i++ ) {
				#	print("userBuiltFlow,_good_values_aref2,
				#	@{@{$neutral_flow->{_good_values_aref2}}[$i]}\n");
				#}
				#   print("userBuiltFlow,_prog_versions_aref,
				#   @{$neutral_flow->{_items_versions_aref}}\n");
				
 		$files_LSU	->set_prog_param_labels_aref2($neutral_flow);	# uses x / 61 in
 		$files_LSU	->set_prog_param_values_aref2($neutral_flow);	# uses x / 61 in
 		$files_LSU	->set_prog_names_aref($neutral_flow);			# uses x / 61 in
 		$files_LSU	->set_items_versions_aref($neutral_flow);		# uses x / 61 in
 		$files_LSU	->set_data();
 		$files_LSU	->set_message($neutral_flow);  				# uses 1 / 61 in

 	  	
		$files_LSU	->set2pl($neutral_flow); 			# flows saved to PL_SEISMIC
		$files_LSU	->save();
		
		print("1. neutral_flow, _SaveAs_button, has_used_SaveAs: $neutral_flow->{_has_used_SaveAs}\n");
		$conditions_gui			    ->set4_end_of_SaveAs_button();
		#$neutral_flow 			= $conditions_gui->get_hash_ref(); # 78 out
 	
 		return();
 		
	} else {		
		print("neutral_flow,_SaveAs_button, missing topic\n");
	}
	
 	
 } 	


=head2 sub _set_flow_color


=cut 

 sub _set_flow_color {
	my ($self)   = @_;
	
	if ($neutral_flow->{_flow_color}) {

		$neutral_flow->{_flow_color}  			= $flow_color;
		print("neutral_flow _set_flow_color, color exists correctly\n");
		print("neutral_flow flow_color , color:$flow_color\n");
		
	} else  {
	 	print("neutral_flow, _set_flow_color, missing color\n");
	}
	return();
 }



=head2 sub _set_flow_listbox_color_w

=cut 

 sub _set_flow_listbox_color_w {
	my ($flow_color)   = @_;
		
	if ($flow_color eq 'grey') {
		$neutral_flow->{_flow_listbox_color_w} =  $neutral_flow->{_flow_listbox_grey_w};
			#print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'pink')  {
		$neutral_flow->{_flow_listbox_color_w} = $neutral_flow->{_flow_listbox_pink_w};
			#print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'green') {
		$neutral_flow->{_flow_listbox_color_w} =  $neutral_flow->{_flow_listbox_green_w};
			#print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'blue')  {
		$neutral_flow->{_flow_listbox_color_w} =  $neutral_flow->{_flow_listbox_blue_w};
			#print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} else {
		print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, missing color\n");
	}
    
	return();
 }



=head2 sub _set_flowNsuperflow_name_w

	displays superflow name at top of gui
	
=cut

sub _set_flowNsuperflow_name_w {	
	my ($flowNsuperflow_name) = @_;
		
	if ($flowNsuperflow_name && $flowNsuperflow_name_w) {
		
		$neutral_flow->{_flowNsuperflow_name_w} = $flowNsuperflow_name_w;
		
		$flowNsuperflow_name_w->configure(-text => $flowNsuperflow_name,);				
	} else {		
			print("userBuiltFlow, set_flowNsuperflow_name_w, missing widget or program name\n");
	}

	return();
}
 		
=head2 sub _set_user_built_flow_name_w

=cut

sub _set_user_built_flow_name_w {	
	my ($user_built_flow_name) = @_;
		
	if ($user_built_flow_name && $flow_name_neutral_w) {
		
		$neutral_flow->{_flow_name_neutral_w} = $flow_name_neutral_w;	

		$flow_name_neutral_w->configure(-text => $user_built_flow_name);				
	} else {		
			print("userBuiltFlow, set_user_built_flow_name_w, missing widget or program name\n");
	}

	return();
}



=head2 sub _stack_flow

  store an initial version of the parameters in a 
  namespace different to the one belonginf to param_widgets 
  
  The initial version comes from default parameter files
  i.e., sing the same code as for sunix_select
  
  print("neutral_flow_stack_flow,last left listbox flow program touched had index = $neutral_flow->{_last_flow_index_touched}\n");
  print("neutral_flow_stack_flow,values= @{$neutral_flow->{_values_aref}}\n");
  
=cut


sub _stack_flow {
  my( $self) = @_;
    	
       # my $num_items = $param_flow->get_num_items();
  		# print("1. neutral_flow, _stack_flow, B4 stored number of prgroams: $num_items\n");
  		# print("neutral_flow,_stack_flow,userBuiltFlow->listbox_widget: $neutral_flow->{_flow_listbox_color_w}\n");

  		# print("neutral_flow, _stack_flow, color: $flow_color \n");
  $param_flow		->stack_flow_item($neutral_flow->{_prog_name_sref});
  $param_flow		->stack_values_aref2($neutral_flow->{_values_aref});
  $param_flow		->stack_names_aref2($neutral_flow->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($neutral_flow->{_check_buttons_settings_aref});	
  
   	    # my $num_items = $param_flow->get_num_items;
  		# print("2. neutral_flow, _stack_flow, End- stored programs num_items: $num_items\n");			 
						
  return();
}


=head2 sub _stack_versions 

   Collect and store latest program versions from changed list 
   
   Will update listbox variables inside flow_widgets package
   Therefore pop is not needed on the array
   Use after data have been stored, deleted, or 
   suffered an insertion event

=cut

sub _stack_versions {
	my $flow_listbox_color_w 			= _get_flow_listbox_color_w();
	   			# print("neutral_flow, _stack_versions ,userBuiltFlow->listbox_widget: $flow_listbox_color_w\n");
    $flow_widgets						->set_flow_items($flow_listbox_color_w );
    $neutral_flow->{_items_versions_aref} 	= $flow_widgets->items_versions_aref;
    $param_flow						->set_flow_items_version_aref($neutral_flow->{_items_versions_aref});
 			 # print("_stack_versions,items_versions_aref: @{$neutral_flow->{_items_versions_aref}}\n");
}



=head2

	FileDialog_button
	 	 foreach my $key (sort keys %$neutral_flow) {
   			print (" neutral_flow key is $key, value is $neutral_flow->{$key}\n");
  		} 	
  	
  	Once the file name is selected the paramter value is upadate in the GUI
  	
=cut 

 sub FileDialog_button {   # N.B. Another _FileDialog_button in L_SU needs to be updated too!!!!!!!
	
	my ($self,$option_sref) = @_;
	use file_dialog;
	use L_SU_global_constants;
	
	my $file_dialog			= file_dialog ->new();
		
	my $get					= L_SU_global_constants->new();
	my $conditions_gui		= conditions_gui ->new();
	my $file_dialog_type	= $get->file_dialog_type_href();
	
	if ($option_sref)  {
		
		$neutral_flow		->{_dialog_type}  = $$option_sref;  # dereference scalar
		
		$file_dialog		->set_flow_color($neutral_flow->{_flow_color}); 	# uses 1/ 31 in	 
		$file_dialog 		->set_hash_ref($neutral_flow);       # uses 7/ 31 in  ; uses values_aref
		$file_dialog		->set_gui_widgets($neutral_flow);    # uses 18/ 31 in
		$file_dialog 		->FileDialog_director();
		
			# save flows if possible
		my $topic = $neutral_flow ->{_dialog_type}; # in this module can only be SaveAs
													 # Save for user-built flows is accessible via L_SU.pm
		
		if ($topic eq $file_dialog_type->{_SaveAs} ) {
	
					# assume that while selecting a data file to open in file-dialog that the
					# GUI has been updated (not very elegant... TODO
					# see if the last index has been touched
					# print ("neutral_flow,FileDialog_button, last_parameter_index_touched_color: $neutral_flow->{_last_parameter_index_touched_color} \n");
						
			$neutral_flow->{_has_used_SaveAs_button}   	= $true;
			$neutral_flow->{_last_parameter_index_touched_color} = $file_dialog->get_last_parameter_index_touched_color();
			_check4parameter_changes();
			
			use messages::message_director;
			my $neutral_flow_messages 				= message_director->new();
			
			$neutral_flow->{_flow_name_out} 		= file_dialog->get_perl_flow_name_out();
			$neutral_flow-> {_path}    			= file_dialog->get_file_path();
			
				# consider empty case	for which saving is not possible
			if( !($neutral_flow->{_flow_name_out}) 		||
				$neutral_flow	->{_flow_name_out} eq '' 	|| 
				!($neutral_flow-> {_path})	 				||
				$neutral_flow	-> {_path} 		    eq ''     ) {
				
				my $message          = $neutral_flow_messages->save_button(1);
 	  			$message_w			 ->delete("1.0",'end');
 	  			$message_w			 ->insert('end', $message);

			} else {  # Good,  NON-EMPTY case
			
			 	# displays user-built flow name at top of neutral-flow gui
 				_set_flowNsuperflow_name_w( $neutral_flow->{_flow_name_out} );
 				_set_user_built_flow_name_w( $neutral_flow->{_flow_name_out} );
				print("1. neutral_flow, FileDialog_button, saving flow: $neutral_flow->{_flow_name_out}\n");
				
				# go save perl flow file
				_SaveAs_button($topic);	

				# print("neutral_flow,FileDialog_button,_flow_name_out: $neutral_flow->{_flow_name_out}  \n");
				# print("neutral_flow,FileDialog_button,_path: $neutral_flow->{_path}  \n");
    		}
						
		} else {
		   # do nothing	
		}				
	} else {		
		print("neutral_flow,FileDialog_button ,option type missing\ n");
	}
	return();
 }




=head2 sub get_hash_ref 

	exports private hash 
 
=cut

 	sub get_hash_ref {
 		my ($self) 	= @_;
 				# print("neutral_flow, get_hash_ref \n");		
 		return($neutral_flow);

 	}

=head2 sub get_flow_color 

	exports private hash value
 
=cut

 	sub get_flow_color {
 		my ($self) 	= @_;
 		
 		if( $neutral_flow->{_flow_color}) {
 			my $color;
 			
 			$color = $neutral_flow->{_flow_color}; 
 			return($color);
 			
 		} else {
 			print("neutral_flow, missing flow color\n");
 		}

 	}


=head2 sub get_last_flow_color
	
		returns current folor (neutral) as the last fow color
		get_hash_ref is NOT USED intentionally
		The variabels needed by other colored flows exceed the capacity of the current package
		I opt for enacapsulation
 	
=cut

 sub get_last_flow_color {
	
	my ($self) = @_;	
	
	if ($neutral_flow ->{_flow_color}) {
		
		$neutral_flow ->{_last_flow_color} = $neutral_flow ->{_flow_color};
		
		# for export
		$last_flow_color		= $neutral_flow ->{_last_flow_color};
		# print("neutral_flow, set_last_flow_color, last_flow_color:  $last_flow_color\n");
		return($last_flow_color);
		
	} else {
		print("neutral_flow, set_last_flow_color,  flow_color missing \n");
	}
 
 	return();
 }
 

=head2 sub get_prog_name_sref 

	exports private hash value
 
=cut

 	sub get_prog_name_sref {
 		my ($self) 	= @_;
 		
 		if( $neutral_flow->{_prog_name_sref}) {
 			my $name;
 			
 			$name = $neutral_flow->{_prog_name_sref}; 
 			return($name);
 			
 		} else {
 			print("neutral_flow, missing \n");
 		}

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
   	my $help = new help();  	
   	$help->set_name($neutral_flow->{_prog_name_sref});
   	$help->tkpod();
   	return();
}




=head2 sub set_hash_ref

	copies with simplified names are also kept (40) so later
	the hash can be returned to a calling module
	
	imports external hash into private settings 
 	40 and 33 
 	
 	local extra  
 	
=cut

 	sub set_hash_ref {
 		my ($self,$hash_ref) 	= @_;
 		
 		$FileDialog_sub_ref		= $hash_ref->{_FileDialog_sub_ref};
 		$FileDialog_option		= $hash_ref->{_FileDialog_option};
 		$add2flow_button_grey	= $hash_ref->{_add2flow_button_grey};
 		$add2flow_button_pink	= $hash_ref->{_add2flow_button_pink};
 		$add2flow_button_green	= $hash_ref->{_add2flow_button_green};
 		$add2flow_button_blue	= $hash_ref->{_add2flow_button_blue};
 		$check_buttons_w_aref 	= $hash_ref->{_check_buttons_w_aref};
 		$check_code_button		= $hash_ref->{_check_code_button};
 		$delete_from_flow_button= $hash_ref->{_delete_from_flow_button};
  		$dialog_type			= $hash_ref->{_dialog_type};
 		$dnd_token_grey			= $hash_ref->{_dnd_token_grey}; # K
 		$dnd_token_pink			= $hash_ref->{_dnd_token_pink}; 
 		$dnd_token_green		= $hash_ref->{_dnd_token_green}; 
 		$dnd_token_blue			= $hash_ref->{_dnd_token_blue}; 
 		$dropsite_token_grey	= $hash_ref->{_dropsite_token_grey};# K
  		$dropsite_token_pink	= $hash_ref->{_dropsite_token_pink}; 
   		$dropsite_token_green	= $hash_ref->{_dropsite_token_green};
    	$dropsite_token_blue	= $hash_ref->{_dropsite_token_blue}; 
 	 	$file_menubutton		= $hash_ref->{_file_menubutton};	 	
 	 	$flow_color				= $hash_ref->{_flow_color};
 	  	$flow_item_down_arrow_button	= $hash_ref->{_flow_item_down_arrow_button};
 		$flow_item_up_arrow_button		= $hash_ref->{_flow_item_up_arrow_button};
 	 	$flow_listbox_grey_w	= $hash_ref->{_flow_listbox_grey_w};
 	 	$flow_listbox_pink_w	= $hash_ref->{_flow_listbox_pink_w};
 	 	$flow_listbox_green_w	= $hash_ref->{_flow_listbox_green_w};
  	 	$flow_listbox_blue_w	= $hash_ref->{_flow_listbox_blue_w};
  	 	$flow_name_grey_w		= $hash_ref->{_flow_name_grey_w};
  	 	$flow_name_pink_w		= $hash_ref->{_flow_name_pink_w};
  	 	$flow_name_green_w		= $hash_ref->{_flow_name_green_w};
  	 	$flow_name_blue_w		= $hash_ref->{_flow_name_blue_w};
  	 	$flowNsuperflow_name_w	= $hash_ref->{_flowNsuperflow_name_w};
		$last_flow_color		= $hash_ref->{_last_flow_color}; # used in flow_select  	 	
  		$labels_w_aref 			= $hash_ref->{_labels_w_aref};
  		$message_w				= $hash_ref->{_message_w}; 
   		$mw						= $hash_ref->{_mw};
 	 	$parameter_names_frame  = $hash_ref->{_parameter_names_frame}; 	
 	 	$parameter_values_frame = $hash_ref->{_parameter_values_frame};
 		$parameter_values_button_frame	 = $hash_ref->{_parameter_values_button_frame};
 		$save_button			= $hash_ref->{_save_button};
 		$sunix_listbox			= $hash_ref->{_sunix_listbox};
  		$values_w_aref 			= $hash_ref->{_values_w_aref};
 		 	 		
 		$neutral_flow->{_add2flow_button_grey}			= $hash_ref->{_add2flow_button_grey};
 		$neutral_flow->{_add2flow_button_pink}			= $hash_ref->{_add2flow_button_pink};
 		$neutral_flow->{_add2flow_button_green}			= $hash_ref->{_add2flow_button_green};
 		$neutral_flow->{_add2flow_button_blue}			= $hash_ref->{_add2flow_button_blue};
 		$neutral_flow->{_check_code_button}				= $hash_ref->{_check_code_button};
 		$neutral_flow->{_check_buttons_w_aref}	 		= $hash_ref->{_check_buttons_w_aref};
 		$neutral_flow->{_delete_from_flow_button}		= $hash_ref->{_delete_from_flow_button};
 		$neutral_flow->{_dnd_token_grey}				= $hash_ref->{_dnd_token_grey};
 		$neutral_flow->{_dropsite_token_grey}			= $hash_ref->{_dropsite_token_grey};
 		$neutral_flow->{_flow_color}					= $hash_ref->{_flow_color}; 
 		$neutral_flow->{_flow_item_down_arrow_button}	= $hash_ref->{_flow_item_down_arrow_button};
 		$neutral_flow->{_flow_item_up_arrow_button}		= $hash_ref->{_flow_item_up_arrow_button};		
 	 	$neutral_flow->{_file_menubutton}				= $hash_ref->{_file_menubutton};
 	 	$neutral_flow->{_flow_listbox_grey_w}			= $hash_ref->{_flow_listbox_grey_w};
 	 	$neutral_flow->{_flow_listbox_pink_w}			= $hash_ref->{_flow_listbox_pink_w};
  	 	$neutral_flow->{_flow_listbox_green_w}			= $hash_ref->{_flow_listbox_green_w};
 	 	$neutral_flow->{_flow_listbox_blue_w}			= $hash_ref->{_flow_listbox_blue_w};
  	 	$neutral_flow->{_flow_name_grey_w}				= $hash_ref->{_flow_name_grey_w};
 	 	$neutral_flow->{_flow_name_pink_w}				= $hash_ref->{_flow_name_pink_w};
 	 	$neutral_flow->{_flow_name_green_w}				= $hash_ref->{_flow_name_green_w};
  	 	$neutral_flow->{_flow_name_blue_w}				= $hash_ref->{_flow_name_blue_w};
  	 	$neutral_flow->{_flowNsuperflow_name_w}			= $hash_ref->{_flowNsuperflow_name_w};
   		$neutral_flow->{_labels_w_aref}		 			= $hash_ref->{_labels_w_aref};
   		$neutral_flow->{_last_flow_color}				= $hash_ref->{_last_flow_color};   		
		$neutral_flow->{_message_w}						= $hash_ref->{_message_w}; 
   		$neutral_flow->{_mw}							= $hash_ref->{_mw};
 	 	$neutral_flow->{_parameter_names_frame}  		= $hash_ref->{_parameter_names_frame}; 	
 	 	$neutral_flow->{_parameter_values_frame} 		= $hash_ref->{_parameter_values_frame};
 		$neutral_flow->{_parameter_values_button_frame}	= $hash_ref->{_parameter_values_button_frame};
 		$neutral_flow->{_prog_name_sref}		 		= $hash_ref->{_prog_name_sref};
 		$neutral_flow->{_run_button}					= $hash_ref->{_run_button}; 	 	
 		$neutral_flow->{_save_button}					= $hash_ref->{_save_button}; 
 		$neutral_flow->{_sunix_listbox}					= $hash_ref->{_sunix_listbox};
 		$neutral_flow->{_values_w_aref} 				= $hash_ref->{_values_w_aref};
 		
 		 # print("neutral_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		 # print("neutral_flowset_hash_ref,parameter_values_frame: $neutral_flow->{_parameter_values_frame}\n");
 		 # print("1. neutral_flowset_hash_ref,_message_w: $neutral_flow->{_message_w}\n");
 		 # print("neutral_flowset_hash_ref,parameter_values_frame: $parameter_values_frame\n"); 	
 		 # print("neutral_flowset_hash_ref,add2flow_button_neutral,$add2flow_button_neutral	\n");
 		 # print("neutral_flow,set_hash_ref,userBuiltFlow->{_flow_color}: $neutral_flow->{_flow_color}	\n");
 		 # print("neutral_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		 # print("neutral_flow,set_hash_ref,flow_color: $flow_color\n");
 		return();
 	}



=head2 sub sunix_select (subroutine is only active in neutral_flow)

  Pick Seismic Unix modules

  foreach my $key (sort keys %$neutral_flow) {
   print (" neutral_flowkey is $key, value is $neutral_flow->{$key}\n");
  }
  TODO: encapsulate better
  
  set
  	$param_sunix
  	$param_widgets
  	
  get
  	$neutral_flow_messages
  	$whereami					->set4sunix_listbox()
  	$param_widgets
  	$param_sunix
  	
  call:
    $conditions_gui			->set4start_of_sunix_select;
    $conditions_gui	->set4end_of_sunix_select() ;
     $neutral_flow 			= $conditions_gui->get_hash_ref();
 
=cut 

sub sunix_select {
   	my ($self) = @_;	
   	
   		
   	$neutral_flow->{_flow_type} = $flow_type->{_user_built}; # should be at start of neutral_flow
   	 		 # print("neutral_flow, sunix_select,parameter_values_frame: $parameter_values_frame\n"); 	
   	  	
   	use messages::message_director; 
   	use param_sunix;
   	  	
	my $neutral_flow_messages 	    = message_director->new();
	my $param_sunix        			= param_sunix->new();
   	
   	my $message          	= $neutral_flow_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message);

		                     # find out which program was previously touched
		                     # assume all prior programs touched have
		                     # modified parameters 
		                     # and update that program's stored values
	_check4flow_changes();
	
     	# print("neutral_flow,1. sunix_select,flow_color: $neutral_flow->{_flow_color}\n");
     	# print("neutral_flow,1. sunix_select,_is_flow_listbox_neutral_w:	$neutral_flow->{_is_flow_listbox_neutral_w} \n");	
   	  	     
    $conditions_gui						    ->set_gui_widgets($neutral_flow);
    $conditions_gui							->set4start_of_sunix_select();
    #$neutral_flow->{_flow_color} 			= $conditions_gui->get_flow_color();
    my $flow_color							= $neutral_flow->{_flow_color};
    	# print("neutral_flow,2. sunix_select,flow_color: $flow_color\n");
    	# print("neutral_flow,1. sunix_select,_is_flow_listbox_neutral_w:	$neutral_flow->{_is_flow_listbox_neutral_w} \n");	
    	# print("1. neutral_flow, sunix_select, _values_w_aref $neutral_flow->{_values_w_aref}\n");
   	$whereami								->set4sunix_listbox($flow_color); # purpose? needed? TODO
   	my $here 								= $whereami->get4sunix_listbox();

        # get program name
   	$neutral_flow->{_prog_name_sref} 				= $param_widgets->get_current_program(\$sunix_listbox);
				# print("neutral_flow sunix_select, program name is ${$neutral_flow->{_prog_name_sref}}\n");
   	$param_sunix   							->set_program_name($neutral_flow->{_prog_name_sref});
   	$neutral_flow->{_names_aref}  					= $param_sunix->get_names();
   	$neutral_flow->{_values_aref} 					= $param_sunix->get_values();
   	$neutral_flow->{_check_buttons_settings_aref}  = $param_sunix->get_check_buttons_settings();
   	$neutral_flow->{_param_sunix_first_idx}  		= $param_sunix->first_idx();
   	$param_sunix									->set_half_length(); # # values not index 
   	$neutral_flow->{_param_sunix_length}  			= $param_sunix->get_length(); # 
   			# print("2. neutral_flow, sunix_select, length $neutral_flow->{_param_sunix_length}\n");
			# $neutral_flow->{_param_sunix_length}  			= $param_sunix->length();

   	$param_widgets      ->set_location_in_gui($here);
   				# print("2. neutral_flow, sunix_select, _values_w_aref $neutral_flow->{_values_w_aref}\n");
   	   			# widgets initialized in super class	
	$param_widgets		->set_labels_w_aref($neutral_flow->{_labels_w_aref} );
  	$param_widgets		->set_values_w_aref($neutral_flow->{_values_w_aref} );
  	$param_widgets		->set_check_buttons_w_aref($neutral_flow->{_check_buttons_w_aref});
  	
  	$param_widgets		->gui_full_clear();
  	
  	$param_widgets		->range($neutral_flow);
   	$param_widgets		->set_labels($neutral_flow->{_names_aref}); # equiv to "labels_aref"
   	$param_widgets		->set_values($neutral_flow->{_values_aref});
   	$param_widgets		->set_check_buttons(
						$neutral_flow->{_check_buttons_settings_aref});
   	$param_widgets		->set_current_program($neutral_flow->{_prog_name_sref});
		# print("3. neutral_flow, sunix_select, _values_w_aref $neutral_flow->{_values_w_aref}\n");
						 # print("neutral_flow sunix_select, $neutral_flow->{_is_sunix_listbox}\n");
   	$param_widgets       ->set_location_in_gui($here);
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

    $conditions_gui		->set4end_of_sunix_select();
    $neutral_flow->{_last_flow_color} = $flow_color;
    
    # for export to other colored flows
    $last_flow_color	=	$flow_color;
    
    # print("neutral_flow,2. sunix_select,1 line after set4end_of_sunix_select\n");
    # $flow_color				= $neutral_flow->{_flow_color};
    # TODo are  following 1 line and past 1 line needed?
    # $neutral_flow 		= $conditions_gui->get_hash_ref();
    	# print("4. neutral_flow, sunix_select, _values_w_aref $neutral_flow->{_values_w_aref}\n");
	 # print("neutral_flow,3. sunix_select,flow_color: $flow_color\n");
   	return();
}

 
1;