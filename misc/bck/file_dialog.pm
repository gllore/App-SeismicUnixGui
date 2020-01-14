package file_dialog;

=head1 DOCUMENTATION

=head2 SYNOPSIS
 PERL PACKAGE NAME: file_dialog.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 16 2018 

 DESCRIPTION 
     
 BASED ON:
 
 previous version (V 0.0.1) of the main L_SU.pl (V 0.3)
  
=cut

=head2 USE

=head3 NOTES


	#				# confirm listboxes are active
#  	if ($pre_req_ok) {

    #my $entry_changed = $param_widgets->get_entry_change_status();
     					 	# print(" L_SU, FileDialog_button, entry_change_status= $entry_changed\n"); 
    # if($entry_changed) {  
							# get program index most recently selected from left flow
     $index = $L_SU->{_last_flow_index_touched};
     print("L_SU,FileDialog_button,in left flow, program index= $index\n");

    						# get entry values of selected program from storage
# 	$param_flow			->set_flow_index($index);
# 	$L_SU->{_values_aref} 	=	$param_flow->get_values_aref();
  						 # print("2. L_SU, FileDialog_button,parameter values is @{$L_SU->{_values_aref}}\n");
							 $whereami->in_gui();
 my $index = $L_SU->{_last_flow_index_touched};
     print("L_SU,FileDialog_button,in left flow, program index= $index\n");

				
	sets
		$messages in gui
		param_widgets
		iFile
	
	gets from
		whereami ( which sees all gui)
		parameter_values_frame
		param_widgets
		iFile
	
	calls
		_conditions   		-> set4FileDialog_select_start()
		$file_dialog   	-> set4FileDialog_select_end();
	sees:
		messages box

=head4 Examples


=head2 CHANGES and their DATES

 V 0.0.23refactoring of 2017 version of L_SU.pl

=cut 

use Moose;
our $VERSION = '0.0.3';

use Tk;

use decisions 1.00;

# potentially used in all packages
use L_SU_global_constants;

extends 'gui_history' => { -version => 0.0.2 };

my $decisions   = decisions->new();
my $get         = L_SU_global_constants->new();
my $gui_history = gui_history->new();


my $file_dialog_type = $get->file_dialog_type_href();
my $flow_type_h      = $get->flow_type_href();

my $var             = $get->var();
my $empty_string    = $var->{_empty_string};
my $on              = $var->{_on};
my $true            = $var->{_true};
my $false           = $var->{_false};
my $superflow_names = $get->superflow_names_h();

=head2 Declare 
local variables

=cut

my $file_dialog = $gui_history->get_defaults();

# print("param_widgets_neutral, default_param_specs,first entry num=$default_param_specs->{_first_entry_num}\n");

=head2 private hash

=cut

$file_dialog = {
#
#	_Data_menubutton                       => '',
#	_FileDialog_sub_ref                    => '',
#	_FileDialog_option                     => '',
#	_Flow_menubutton                       => '',
#	_SaveAs_menubutton                     => '',
#	_add2flow_button_grey                  => '',
#	_add2flow_button_pink                  => '',
#	_add2flow_button_green                 => '',
#	_add2flow_button_blue                  => '',
#	_check_code_button                     => '',
	_check_buttons_settings_aref           => '',
#	_check_buttons_w_aref                  => '',
#	_delete_from_flow_button               => '',
#	_destination_index                     => '',
#	_dialog_type                           => '',
#	_dnd_token_grey                        => '',
#	_dnd_token_pink                        => '',
#	_dnd_token_green                       => '',
#	_dnd_token_blue                        => '',
#	_dropsite_token_grey                   => '',
#	_dropsite_token_pink                   => '',
#	_dropsite_token_green                  => '',
#	_dropsite_token_blue                   => '',
#	_file_menubutton                       => '',
#	_flow_color                            => '',
#	_flow_item_down_arrow_button           => '',
#	_flow_item_up_arrow_button             => '',
#	_flow_listbox_grey_w                   => '',
#	_flow_listbox_pink_w                   => '',
#	_flow_listbox_green_w                  => '',
#	_flow_listbox_blue_w                   => '',
#	_flow_listbox_color_w                  => '',
#	_flow_name_grey_w                      => '',
#	_flow_name_pink_w                      => '',
#	_flow_name_green_w                     => '',
#	_flow_name_blue_w                      => '',
#	_flow_name_in                          => '',
#	_flow_name_out                         => '',
#	_flow_type                             => '',
#	_flow_widget_index                     => '',
#	_flowNsuperflow_name_w                 => '',
#	_gui_history_ref                       => '',
#	_has_used_check_code_button            => '',
#	_has_used_open_perl_file_button        => '',
#	_has_used_run_button                   => '',
#	_has_used_Save_button                  => '',
#	_has_used_Save_superflow               => '',
#	_has_used_SaveAs_button                => '',
#	_index2move                            => '',
#	_is_SaveAs_file_button                 => '',
#	_is_SaveAs_button                      => '',
#	_is_Save_button                        => '',
#	_is_add2flow_button                    => '',
#	_is_check_code_button                  => '',
#	_is_delete_from_flow_button            => '',
#	_is_dragNdrop                          => '',
#	_is_flow_item_down_arrow_button        => '',
#	_is_flow_item_up_arrow_button          => '',
#	_is_flow_listbox_grey_w                => '',
#	_is_flow_listbox_pink_w                => '',
#	_is_flow_listbox_green_w               => '',
#	_is_flow_listbox_blue_w                => '',
#	_is_flow_listbox_color_w               => '',
#	_is_last_flow_index_touched_grey       => '',
#	_is_last_flow_index_touched_pink       => '',
#	_is_last_flow_index_touched_green      => '',
#	_is_last_flow_index_touched_blue       => '',
#	_is_last_flow_index_touched            => '',
#	_is_last_parameter_index_touched_grey  => '',
#	_is_last_parameter_index_touched_pink  => '',
#	_is_last_parameter_index_touched_green => '',
#	_is_last_parameter_index_touched_blue  => '',
#	_is_last_parameter_index_touched_color => '',
#	_is_moveNdrop_in_flow                  => '',
#	_is_new_listbox_selection              => '',
#	_is_open_file_button                   => '',
#	_is_pre_built_superflow                => '',
#	_is_run_button                         => '',
#	_is_select_file_button                 => '',
#	_is_selected_file_name                 => '',
#	_is_selected_path                      => '',
#	_is_sunix_listbox                      => '',
#	_is_superflow                          => '',
#	_is_superflow_select_button            => '',
#	_is_user_built_flow                    => '',
#	_items_checkbuttons_aref2              => '',
#	_items_names_aref2                     => '',
#	_items_values_aref2                    => '',
#	_items_versions_aref                   => '',
#	_labels_w_aref                         => '',
#	_last_flow_color                       => '',
#	_last_flow_index_touched               => -1,
#	_last_flow_index_touched_grey          => -1,
#	_last_flow_index_touched_pink          => -1,
#	_last_flow_index_touched_green         => -1,
#	_last_flow_index_touched_blue          => -1,
#	_last_flow_listbox_touched             => -1,
#	_last_flow_listbox_touched_w           => '',
#	_last_parameter_index_touched_grey     => -1,
#	_last_parameter_index_touched_pink     => -1,
#	_last_parameter_index_touched_green    => -1,
#	_last_parameter_index_touched_blue     => -1,
#	_last_parameter_index_touched_color    => -1,
#	_last_path_touched                     => './',
#	_message_w                             => '',
#	_mw                                    => '',
#	_names_aref                            => '',
#	_occupied_listbox_aref                 => '',
#	_param_flow_length                     => '',
#	_parameter_names_frame                 => '',
#	_param_sunix_first_idx                 => 0,
#	_param_sunix_length                    => '',
#	_parameter_value_index                 => '',
#	_parameter_values_button_frame         => '',
#	_parameter_values_frame                => '',
#	_path                                  => '',
#	_prog_name_sref                        => '',
#	_prog_names_aref                       => '',
#	_run_button                            => '',
#	_save_button                           => '',
#	_sub_ref                               => '',
#	_selected_file_name                    => '',
#	_sunix_listbox                         => '',     # pre-built-superflow or flow name as well
#	_values_aref                           => '',
#	_values_w_ref                          => '',
#	_selected_file_name                    => '',
#	_superflow_first_idx                   => '',
#	_superflow_length                      => '',
#
};

=head2 
 
  124 of convenient private abbreviated-variable names
  These are defiend in every subroutine so that get_hash_ref can export them
  
=cut

# my $Data_menubutton;
# my $FileDialog_sub_ref;
# my $FileDialog_option;
#my $Flow_menubutton;
#my $SaveAs_menubutton;
#my $add2flow_button_grey;
#my $add2flow_button_pink;
#my $add2flow_button_green;
#my $add2flow_button_blue;
# my $check_buttons_settings_aref;
#my $check_buttons_w_aref;
#my $check_code_button;
#my $delete_from_flow_button;
#my $destination_index;
# my $dialog_type;
# my $dnd_token_grey;
# my $dnd_token_pink;
# my $dnd_token_green;
# my $dnd_token_blue;
# my $dropsite_token_grey;
# my $dropsite_token_pink;
# my $dropsite_token_green;
# my $dropsite_token_blue;
#my $file_menubutton;
#my $flowNsuperflow_name_w;
#my $flow_color;
#my $flow_item_down_arrow_button;
#my $flow_item_up_arrow_button;
#my $flow_listbox_grey_w;
#my $flow_listbox_pink_w;
#my $flow_listbox_green_w;
#my $flow_listbox_blue_w;
#my $flow_listbox_color_w;
#my $flow_name_grey_w;
#my $flow_name_pink_w;
#my $flow_name_green_w;
#my $flow_name_blue_w;
#my $flow_name_in;
#my $flow_name_out;
# my $flow_type;
# my $flow_widget_index;
# my $gui_history_ref;
#my $has_used_check_code_button;
#my $has_used_open_perl_file_button;
#my $has_used_run_button;
#my $has_used_SaveAs_button;
#my $has_used_Save_button;
#my $has_used_Save_superflow;
# my $index2move;
#my $is_Save_button;
#my $is_SaveAs_button;
#my $is_SaveAs_file_button;
#my $is_add2flow_button;
#my $is_check_code_button;
#my $is_delete_from_flow_button;
#my $is_dragNdrop;
#my $is_flow_item_down_arrow_button;
#my $is_flow_item_up_arrow_button;
#my $is_flow_listbox_grey_w;
#my $is_flow_listbox_pink_w;
#my $is_flow_listbox_green_w;
#my $is_flow_listbox_blue_w;
#my $is_flow_listbox_color_w;
#my $is_last_flow_index_touched_grey;
#my $is_last_flow_index_touched_pink;
#my $is_last_flow_index_touched_green;
#my $is_last_flow_index_touched_blue;
#my $is_last_flow_index_touched;
#my $is_last_parameter_index_touched_grey;
#my $is_last_parameter_index_touched_pink;
#my $is_last_parameter_index_touched_green;
#my $is_last_parameter_index_touched_blue;
#my $is_last_parameter_index_touched_color;
#my $is_moveNdrop_in_flow;
#my $is_new_listbox_selection;
#my $is_open_file_button;
#my $is_pre_built_superflow;
#my $is_run_button;
#my $is_select_file_button;
#my $is_selected_file_name;
#my $is_selected_path;
#my $is_sunix_listbox;
#my $is_superflow_select_button;
#my $is_superflow;
#my $is_user_built_flow;
#my $items_checkbuttons_aref2;
#my $items_names_aref2;
#my $items_values_aref2;
#my $items_versions_aref;
# my $labels_w_aref;
#my $last_flow_color;
#my $last_flow_listbox_touched;
#my $last_flow_listbox_touched_w;
#my $last_flow_index_touched_grey;
#my $last_flow_index_touched_pink;
#my $last_flow_index_touched_green;
#my $last_flow_index_touched_blue;
#my $last_flow_index_touched;
#my $last_parameter_index_touched_grey;
#my $last_parameter_index_touched_pink;
#my $last_parameter_index_touched_green;
#my $last_parameter_index_touched_blue;
#my $last_parameter_index_touched_color;
#my $last_path_touched;
# my $message_w;
# my $mw;
# my $names_aref;
# my $occupied_listbox_aref;
#my $param_flow_length;
#my $parameter_names_frame;
#my $param_sunix_first_idx;
#my $param_sunix_length;
#my $parameter_value_index;
#my $parameter_values_frame;
#my $parameter_values_button_frame;
# my $path;
# my $prog_names_aref;
# my $prog_name_sref;
# my $run_button;
# my $save_button;
# my $selected_file_name;
# my $sunix_listbox;
# my $superflow_first_idx;
# my $superflow_length;
# my $sub_ref;
# my $values_aref;
# my $values_w_aref;

=head2 sub _FileDialog

     print ("my file is $file_dialog->{_selected_file_name}\n");
     will NOT:
        print ("1. label is @{$file_dialog->{_ref_labels_w}}[$first]->cget('-text') \n");

    WILL print:
     print ("2. label is  $out\n");

     $who[$first] = $parameter_values_frame->focusCurrent;
     print("who is $who[$first]\n");
     if ($who[$first] eq @{$file_dialog->{_ref_values_w}}[$first]) { 
       print("who is also @{$file_dialog->{_ref_values_w}}[$first]\n");
       print ("2. label is  $out\n");
     }

   Assume that file name in labels is always first
   print ("1. Full path is  $file_dialog->{_selected_file_name}\n");

	Cancel returns undefined file name

=cut

sub _FileDialog {

	my ($self) = @_;

	# use Tk::JFileDialog;
	use JFileDialog;    # 4/25/2019
	my $my_title        = _get_dialog_type();    # e.g., 'SaveAs' or 'Save' or 'Flow'
	my $FileDialog_path = _get_path();           # e.g., $PL or $DATA_SEISMIC_SU

	my $fileDialog_w;

	# can be for a data or pl directory or for only a directory
	# print("file_dialog,_FileDialog, path:$file_dialog->{_path}\n");
	# print("file_dialog,_FileDialog, mytitle :$my_title\n");

	$fileDialog_w = $file_dialog->{_mw}->JFileDialog(
		-Title        => $my_title,
		-Path         => $FileDialog_path,
		-History      => 12,
		-HistDeleteOk => 1,
		-HistUsePath  => 1,
		-HistFile     => "./.FileHistory.txt",
		-PathFile     => "./.Bookmarks.txt",
		-Create       => 1,
	);

	# results from interactive file selection

	$file_dialog->{_selected_file_name} = $fileDialog_w->Show();
	$file_dialog->{_last_path_touched}  = $fileDialog_w->cget('-Path');

	# print("file_dialog,_FileDialog,last path is
	# $file_dialog->{_last_path_touched} \n");
	# print("file_dialog,_FileDialog,selected_file_name
	# is $file_dialog->{_selected_file_name} \n");
	return ();
}

=head2 sub _get_dialog_type 

	Open/see as Data in GUI (data for user-built and pre-built superflows)
	
	Open/seen as Flow ( in GUI (perl programs of user-built flows)
	
	Save/seen as Save  in GUI ((perl program of user-built flow and pre-built superflows)
	
	SaveAs/seen as SaveAs   in GUI ((perl program of pre-built superflows)
	
	
=cut

sub _get_dialog_type {
	my ($self) = @_;

	if ( $file_dialog->{_dialog_type} ) {

		my $topic = $file_dialog->{_dialog_type};
		return ($topic);

	}
	else {
		print("file_dialog, _get_dialog_type , missing topic\n");
		return ();
	}
}

=head2 sub _get_path 

   _dialog_type can be seen in GUI as
   	 'Data'/open, 
   	 'SaveAs' or 
   	 'Save'
   	 'Flow'/open
   	 
   	 within program we also have 'Path' or directoty
   
=cut 	

sub _get_path {
	my ($self) = @_;

	if ( defined $file_dialog->{_path}
		&& $file_dialog->{_path} ne $empty_string )
	{

		my $path = $file_dialog->{_path};
		return ($path);

	}
	else {
		print(" file_dialog,_get_path, missing file path\n");
		return ();
	}
}

=head2 sub _set_file_path 

   _dialog_type can be seen in GUI as
   	 'Data'/open, 
   	 'SaveAs' or 
   	 'Save'
   	 'Flow'/open
   	 Only used by _user_built_flow_SaveAs_perl_file
   
=cut 	

sub _set_file_path {
	my ($self) = @_;

	my $topic = _get_dialog_type();

	if ($topic) {
		use Project_config;

		my $Project = Project_config->new();

		my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU();
		my $PL_SEISMIC      = $Project->PL_SEISMIC();

		if ( $topic eq $file_dialog_type->{_Data} ) {    # for Data
			$file_dialog->{_path} = $DATA_SEISMIC_SU;

			# print("file_dialog, _set_file_path ,dialog type:$topic\n");
			# print("file_dialog, _set_file_path ,path:$file_dialog->{_path}\n");

		}
		elsif ( $topic eq $file_dialog_type->{_Flow} ) {    # Open pre-exiting user-built flow
			$file_dialog->{_path} = $PL_SEISMIC;

			# print("file_dialog, _set_file_path ,dialog type:$topic\n");
			# print("file_dialog, _set_file_path ,path:$file_dialog->{_path}\n");

		}
		elsif ( $topic eq $file_dialog_type->{_SaveAs} ) {    # save a new user-built flow
			$file_dialog->{_path} = $PL_SEISMIC;

			# print("file_dialog, _set_file_path ,dialog type:$topic\n");
			# rint("file_dialog, _set_file_path ,path:$file_dialog->{_path}\n");
			#
		}
		elsif ( $topic eq 'Save' ) {
			$file_dialog->{_path} = $PL_SEISMIC;

			# print("file_dialog, _set_file_path ,dialog type:$topic\n");
			# print("file_dialog, _set_file_path ,path:$file_dialog->{_path}\n");

		}
		else {
			print(" file_dialog,_set_file_path, missing dialog type\n");
			return ();
		}
	}

}

=head2 sub _get_flow_type

	user_built_flow
	or
	pre_built_superflow
	
	
=cut

sub _get_flow_type {
	my ($self) = @_;

	my $how_built = $file_dialog->{_flow_type};

	if ( $file_dialog->{_flow_type} ) {
		return ($how_built);

	}
	else {
		print("file_dialog, _get_flow_type , missing topic\n");
		return ();
	}

}

=head2 sub _pre_built_superflow_close_data_file

  reorganizing the display after a file is selected

  print("1. OK index:$file_dialog->{_parameter_value_index}\n");
  print("2. value:@$ref_values[$file_dialog->{_parameter_value_index}]\n");
  print("2. chek value:@{$file_dialog->{_ref_param_value_button_w_variable}}[$current_index]\n");

  'menubutton' is for our macro sunix tools
  'frame' is for the regular sunix programs

  TODO: CASE of opening a pre-existing superflow configuration file
        or previously scripted flow  by this GUI
        BEFORE or While the menubutton OR Frame are selected

    # if(entry_button_chosen('file_name') != $failure) {
    # if($file_dialog->{_current_widget} eq 'menubutton' ||  $file_dialog->{_current_widget} eq 'frame' ) { 
		print("file_dialog,_pre_built_superflow_close_data_file, is superflow? $file_dialog->{_is_superflow_select_button}\n");
		print("file_dialog,_pre_built_superflow_close_data_file, is flow? left lstbox:$file_dialog->{_is_flow_listbox_grey_w},right:$file_dialog->{_is_flow_listbox_green_w} \n");

 # Seen as DATA
 Open/data is used to open a data file
 
=cut

sub _pre_built_superflow_close_data_file {
	my ($self) = @_;

	use iFile;
	use decisions 1.00;
	use control;

	my $iFile         = new iFile;
	my $control       = new control;
	my $param_widgets = param_widgets->new();

	my @fields;
	my $topic     = $file_dialog->{_dialog_type};
	my $pathNfile = $file_dialog->{_selected_file_name};

	if ( defined $pathNfile
		&& $pathNfile ne $empty_string )
	{

		@fields = split( /\//, $pathNfile );

		# print("file_dialog, _pre_built_superflow_close_data_file,fields are: @fields\n");
		$file_dialog->{_is_selected_file_name} = $true;

	}
	else {
		print("file_dialog, _pre_built_superflow_close_data_file,Cancelled. No  name selected\n");
	}

	# TODO: check whether _is_superflow_select_button is needed inside decisions
	$decisions->set4FileDialog_select($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_select();

	# print("1. file_dialog,_pre_built_superflow_close_data_file, pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		# both flows and superflows require the following
		my $current_index = $file_dialog->{_parameter_value_index};

		        print(
		"2. file_dialog,_pre_built_superflow_close_data_file, current parameter index $current_index\n"
		        );

		@{ $file_dialog->{_check_buttons_settings_aref} }[$current_index] =
			$on;

		if ( $file_dialog->{_selected_file_name} ) {

			# print("3. file_dialog,_pre_built_superflow_close_data_file,, fields= $fields[-1]\n");

			# remove *.su suffix, get only first name, add single quotes
			$control->set_file_name_sref( \$fields[-1] );
			$control->remove_su_suffix4sref();
			$file_dialog->{_selected_file_name} = $control->get_w_single_quotes();

			# $file_dialog->{_selected_file_name} 	= $control->su_data_name(\$fields[-1]);
			#            print(
			#"file_dialog,_pre_built_superflow_close_data_file selected_file_name: $file_dialog->{_selected_file_name} \n"
			#            );

		}
		else {
			print("file_dialog,_pre_built_superflow_close_data_file No file was selected\n");

			# print("4. file_dialog,_pre_built_superflow_close_data_file,last path touched was
			# $file_dialog->{_last_path_touched}\n") ;
		}

		# print("7. file_dialog,_pre_built_superflow_close_data_fileprog_name=
		# ${$file_dialog->{_prog_name_sref}}\n");

		# legacy code: only ProjectVariables (a superflow) which does
		# not have files/only directories requires the following
		if ( ${ $file_dialog->{_prog_name_sref} } eq $superflow_names->{_ProjectVariables} ) {

			@{ $file_dialog->{_values_aref} }[$current_index] =
				$file_dialog->{_last_path_touched};

			# print("8. file_dialog,_pre_built_superflow_close_data_file last path is $file_dialog->{_last_path_touched} \n");
		}

		# print("9. file_dialog,_pre_built_superflow_close_data_file selected_file_name=$file_dialog->{_selected_file_name}\n");

		# both flows and superflows require the following entry updates
		# collect parameter widget values
		$file_dialog->{_values_aref} = $param_widgets->get_values_aref();    # gets 61 because 61 are initialized
		                                                                     # assign new file name to the array of values
		                                                                     
		print("10. file_dialog,_pre_built_superflow_close_data_file values are: @{$file_dialog->{_values_aref}} \n");
		@{ $file_dialog->{_values_aref} }[$current_index] =
			$file_dialog->{_selected_file_name};

		# update the gui with the new file name
		$param_widgets->set_values( $file_dialog->{_values_aref} );
		# print("10. file_dialog,_pre_built_superflow_close_data_file values are: @{$file_dialog->{_values_aref}} \n");
		$param_widgets->redisplay_values();

		$gui_history->set4superflow_close_data_file_end();
		$file_dialog = $gui_history->get_hash_ref();                      # retrieves 93

	}    # if prereq_OK
}

=head2 sub _pre_built_superflow_close_path

  re-organizing the display after a directory (path) is selected

    TODO: CASE of opening a pre-existing superflow configuration file
        or previously scripted flow  by this GUI
        BEFORE or While the menubutton OR Frame are selected
        
 
=cut

sub _pre_built_superflow_close_path {
	my ($self) = @_;

	use iFile;
	use decisions 1.00;
	use control;

	my $iFile         = new iFile;
	my $control       = new control;
	my $param_widgets = param_widgets->new();

	my $topic             = $file_dialog->{_dialog_type};
	my $last_path_touched = $file_dialog->{_last_path_touched};

	if ( defined $last_path_touched
		&& $last_path_touched ne $empty_string )
	{

		$file_dialog->{_is_selected_path} = $true;

	}
	else {
		print("file_dialog, _pre_built_superflow_close_path, Cancelled. No path\n");
	}

	$decisions->set4FileDialog_select($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_select();

	# print("1. file_dialog,_pre_built_superflow_close_path, pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		my $result;

		if ( defined $file_dialog->{_last_path_touched}
			&& $file_dialog->{_last_path_touched} ne $empty_string )
		{

			use dirs;
			my $dirs = dirs->new();

			# print("3. file_dialog,_pre_built_superflow_close_path,path= $file_dialog->{_last_path_touched}\n");
			dirs->set_path( $file_dialog->{_last_path_touched} );
			$result = dirs->get_last_dirInpath();

			# print("4. file_dialog,_pre_built_superflow_close_path,value that will be saved: $result\n");

		}
		else {
			print("file_dialog,_pre_built_superflow_close_path No path was selected\n");

			# print("4. file_dialog,_pre_built_superflow_close_path,last path touched was
			# $file_dialog->{_last_path_touched}\n") ;
		}

		# print("7. file_dialog,_pre_built_superflow_close_path prog_name=
		# ${$file_dialog->{_prog_name_sref}}\n");

		my $current_index = $file_dialog->{_parameter_value_index};

		# both flows and superflows require the following entry updates
		# collect parameter widget values
		$file_dialog->{_values_aref} = $param_widgets->get_values_aref();    # gets 61 because 61 are initialized

		# assign new file name to the array of values
		@{ $file_dialog->{_values_aref} }[$current_index] = $result;

		@{ $file_dialog->{_check_buttons_settings_aref} }[$current_index] = $on;
		
		# update the gui with the new path
		$param_widgets->set_values( $file_dialog->{_values_aref} );

		print("10. file_dialog,_pre_built_superflow_close_path values are: @{$file_dialog->{_values_aref}} \n");

		# $param_widgets->redisplay_values();

		$gui_history->set4superflow_close_path_end();
		$file_dialog = $gui_history->get_hash_ref();    # retrieves 99

	}    # if prereq_OK
}

=head2  _pre_built_superflow_open_data_file 

		print("file_dialog, _pre_built_superflow_open_data_file, flow_item_up_arrow_button: $file_dialog->{_flow_item_up_arrow_button}\n");
	 	foreach my $key (sort keys %$file_dialog) {
 		print (" file_dialog,key is $key, value is $file_dialog->{$key}\n");
    }
=cut 

sub _pre_built_superflow_open_data_file {

	my ($self) = @_;

	# print("file_dialog, _pre_built_superflow_open_data_file\n ");
	use iFile;
	use whereami;

	use param_widgets;
	use L_SU_global_constants;

	my $param_widgets = param_widgets->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami->new();
	my $iFile         = iFile->new();

	my $default_param_specs = $get->param();
	my $first_idx = $default_param_specs->{_first_entry_idx}, my $length = $default_param_specs->{_length},

		# local location within GUI
		# for both superflow selection (necessary?? we alredy know what we are)
		# and for file dialog

		$gui_history->set_hash_ref($file_dialog);
	# $gui_history->set_gui_widgets($file_dialog);
	$gui_history->set4FileDialog_open_start();
	$gui_history->set4superflow_open_data_file_start();
	$file_dialog = $gui_history->get_hash_ref();    # gets 93

	# if an appropriate entry widget is first selected, ie. Entry
	# get index of entry button pressed
	# find out which entry button has been chosen
	# confirm that it IS the file button
	# TODO determine the required file type and file path
	# TODO from the *_spec.pm file for the particular program in the flow.
	# print("file_dialog,_pre_built_superflow_open_data_file,_FileDialog_button pressed, \n");
	# print("file_dialog, _pre_built_superflow_open_data_file selected  _values_aref=@{$file_dialog->{_values_aref}}\n");
	# print("file_dialog  _pre_built_superflow_open_data_file selected  parameter_values_frame = $file_dialog->{_parameter_values_frame} 	\n");
	my $widget_type = $whereami->widget_type($file_dialog->{_parameter_values_frame});

	# print("file_dialog  _pre_built_superflow_open_data_file selected widget type is = $widget_type	\n");

	if ( $widget_type eq 'Entry' ) {

		# print("1. file_dialog,_pre_built_superflow_open_data_file, selected widget_type=$widget_type \n");

		my $selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

		# print("2. file_dialog  _pre_built_superflow_open_data_file, selected_Entry_widget: $selected_Entry_widget\n");

		$file_dialog->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();

		# print("file_dialog,_pre_built_superflow_open_data_file,selection_Entry_widget HASH = $selected_Entry_widget\n");
		#  print("file_dialog,_pre_built_superflow_open_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		if ( $file_dialog->{_parameter_value_index} >= 0 ) {    # for additional certainty; but is it needed?
			                                                    # print("4. file_dialog,_pre_built_flow_open_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");
			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

			# print("5. file_dialog,_pre_built_superflow_open_data_file,entry_button_label = $file_dialog->{_entry_button_label}\n");

			# use iFile to determine the correct data path (directory)
			$iFile->set_entry($file_dialog);          # first entry label should be base_file_name
			$iFile->set_flow_type_h($file_dialog);    # pre-built superflow will determine the DIR to find data
			$iFile->set_values_aref($file_dialog);    # may not be needed ( only for user-built_flows)TODO
			$iFile->set_prog_name_sref($file_dialog);

			# TODO set direction of data flow $iFile						-> set_in();
			$file_dialog->{_path} = $iFile->get_Data_path();

			# print("1.file_dialog,_pre-built_superflow_open_data_file, PATH:  $file_dialog->{_path} \n");

			# print("1.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");

			_FileDialog();

			# print("2.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");

			_pre_built_superflow_close_data_file();

			# print("2.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");
			# my $length= scalar @{$file_dialog->{_values_aref}};  # 61 values
			# for (my $i=0; $i < $length; $i++) {
			# 	 print("3.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[$i]\n");
			# }
		}
	}
	elsif ( $widget_type eq 'MainWindow' ) {    # opening a random file
		                                        # print("file_dialog,_pre_built_superflow_open_data_file widget type is 'MainWindow' \n");
		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
		$file_dialog->{_message_w}->delete( "1.0", 'end' );
		$file_dialog->{_message_w}->insert( 'end', $message );

	}
	else {
		print("file_dialog,_pre-built_superflow_open_data_file no widget type selected \n");
	}

	$gui_history->set4superflow_open_data_file_end();
	$gui_history->set4FileDialog_open_end();    # 2 set
	$file_dialog = $gui_history->get_hash_ref();    # retrieves 93

}

=head2  _pre_built_superflow_open_path

	 	a directory path
=cut 

sub _pre_built_superflow_open_path {

	my ($self) = @_;

	# print ("file_dialog, _pre_built_superflow_open_path\n ");
	use iFile;
	use whereami;
	use L_SU_global_constants;

	my $param_widgets = param_widgets->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami->new();
	my $iFile         = iFile->new();

	my $default_param_specs = $get->param();
	my $first_idx = $default_param_specs->{_first_entry_idx}, my $length = $default_param_specs->{_length},

	$gui_history->set_hash_ref($file_dialog);
	$gui_history->set4FileDialog_open_start();
	$gui_history->set4superflow_open_path_start();
	$file_dialog = $gui_history->get_hash_ref();    # gets 93

	# If an appropriate Entry widget is first selected,
	# Find out which entry button has been chosen (index)
	# Confirm that it IS the file button

	# print("file_dialog,_pre_built_superflow_open_path,_FileDialog_button pressed, \n");
	# print("file_dialog, _pre_built_superflow_open_path selected  _values_aref=@{$file_dialog->{_values_aref}}\n");
	# print("file_dialog, _pre_built_superflow_open_path selected  _values_aref=@{$file_dialog->{_names_aref}}\n");
	# print("file_dialog  _pre_built_superflow_open_path selected  parameter_values_frame = $file_dialog->{_parameter_values_frame} \n");

	my $widget_type = $whereami->widget_type($file_dialog->{_parameter_values_frame});

	# print("file_dialog  _pre_built_superflow_open_path selected widget type is = $widget_type	\n");

	if ( $widget_type eq 'Entry' ) {

		# print("1. file_dialog,_pre_built_superflow_open_path, selected widget_type=$widget_type \n");

		my $selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		# print("file_dialog,_pre_built_superflow_open_path,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_pre_built_superflow_open_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

		# print("2. file_dialog  _pre_built_superflow_open_path, selected_Entry_widget: $selected_Entry_widget\n");

		$file_dialog->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();

		# print("file_dialog,_pre_built_superflow_open_path,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_pre_built_superflow_open_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		if ( $file_dialog->{_parameter_value_index} >= 0 ) {    # for additional certainty; but is it needed?
			                                                    # print("4. file_dialog,_pre_built_flow_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");
			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

			# print("5. file_dialog,_pre_built_superflow_open_path,entry_button_label = $file_dialog->{_entry_button_label}\n");

			# use iFile to determine the stored Path in the current configuration file
			$iFile->set_entry($file_dialog);                    # selected entry label
			$iFile->set_flow_type_h($file_dialog);              # a pre-built superflow
			$iFile->set_parameter_value_index($file_dialog);    # e.g., 0
			$iFile->set_values_aref($file_dialog);              # e.g., /home/gom/
			$iFile->set_prog_name_sref($file_dialog);           # e.g., Project_config

			$file_dialog->{_path} = $iFile->get_Path();

			# print("1.file_dialog,_pre-built_superflow_path, PATH:  $file_dialog->{_path} \n");
			# print("1.file_dialog,_pre-built_superflow_path, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");

			# TODO move _set_Path to iFile->get_Path

			_FileDialog();    # open file dialog widget

			# print("2.file_dialog,_pre-built_superflow_path, last_path_touched:  $file_dialog->{_last_path_touched} \n");

			_pre_built_superflow_close_path();

			# print("2.file_dialog,_pre-built_superflow_path, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");
			# my $length= scalar @{$file_dialog->{_values_aref}};  # 61 values
			# for (my $i=0; $i < $length; $i++) {
			# 	print("3.file_dialog,_pre-built_superflow_path, _values_aref: @{$file_dialog->{_values_aref}}[$i]\n");
			# }
		}
	}
	elsif ( $widget_type eq 'MainWindow' ) {    # opening a random file

		print("file_dialog,_pre_built_superflow_open_path widget type is 'MainWindow' \n");
		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
		$file_dialog->{_message_w}->delete( "1.0", 'end' );
		$file_dialog->{_message_w}->insert( 'end', $message );

	}
	else {
		print("file_dialog,_pre-built_superflow_path no widget type selected \n");
	}

	$gui_history->set4superflow_open_path_end();
	$gui_history->set4FileDialog_open_end();    # 2 set
	$file_dialog = $gui_history->get_hash_ref();    # retrieves 93
}

=head2  sub  _set_FileDialog2user_built_flow

   {_Data}  	...	open pre-existing data file
   {_Flow} 		...	open pre-existing user-built flow
   {_SaveAs} 	...	save a new user-built flow
   {_Save} 	    ...	re-save a user-built flow 
   
=cut 

sub _set_FileDialog2user_built_flow {
	my ($self) = @_;

	my $topic = _get_dialog_type();

	# print("file_dialog, _set_FileDialog2user_built_flow ,dialog type:$topic\n");

	# for Data
	if ( $topic eq $file_dialog_type->{_Data} ) {

		# print("file_dialog, _set_FileDialog2user_built_flow ,dialog type:$topic\n");

		_user_built_flow_open_data_file();

		# Open pre-exiting user-built flow
	}
	elsif ( $topic eq $file_dialog_type->{_Flow} ) {

		# print("file_dialog, _set_FileDialog2user_built_flow ,dialog type:$topic\n");
		# print("file_dialog, _set_FileDialog2user_built_flow, flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");

		_user_built_flow_open_perl_file();

		# Save a new user-built flow
	}
	elsif ( $topic eq $file_dialog_type->{_SaveAs} ) {

		# print("file_dialog, _set_FileDialog2user_built_flow ,dialog type:$topic\n");

		_user_built_flow_SaveAs_perl_file();

		#	} elsif ($topic eq 'Save') {
		#		_user_built_flow_save_perl_file();

	}
	else {
		#print("No bindings exist\n");
	}

	# print("file_dialog, End of _set_FileDialog2user_built_flow \n");
	return ();
}

sub _set_FileDialog2pre_built_superflow {
	my ($self) = @_;

	my $topic = _get_dialog_type();

	if ( $topic eq $file_dialog_type->{_Data} ) {

		# print("file_dialog,_set_FileDialog2pre_built_superflow, topic= $topic\n");
		_pre_built_superflow_open_data_file();

	}
	elsif ( $topic eq $file_dialog_type->{_Path} ) {

		# print("file_dialog,set_FileDialog2pre_built_superflow, topic= $topic\n");
		_pre_built_superflow_open_path();

	}
	elsif ( $topic eq $file_dialog_type->{_Flow} ) {
		print("file_dialog,set_FileDialog2pre_built_superflow, not allowed \n");

		# NADA

	}
	elsif ( $topic eq $file_dialog_type->{_SaveAs} ) {

		# print("file_dialog,set_FileDialog2pre_built_superflow, not allowed \n");
		# _save_button('SaveAs');  superflow saves flow automatically and should not
		# require this option!  #NADA

	}
	else {
		print("file_dialog,set_FileDialog2pre_built_superflow, problem! \n");
	}
	return ();
}

=head2 sub _set_selected_file_name

=cut

sub _set_selected_file_name {

	my ($selected_file_name) = @_;

	if ( $selected_file_name ne $empty_string ) {

		$file_dialog->{_selected_file_name} = $selected_file_name;

	}
	else {
		print("file_dialog, _set_selected_file_name, empty string NADA\n");
	}

	return ();
}

=head2 sub _user_built_flow_SaveAs_perl_file
 	
 	foreach my $key (sort keys %$file_dialog) {
 		print (" file_dialog,key is $key, value is $file_dialog->{$key}\n");
    }

=cut

sub _user_built_flow_SaveAs_perl_file {

	my ($self) = @_;

	use decisions 1.00;

	# local location within GUI
	# and for file dialog
	# print("0. file_dialog, user_built_flow_SaveAs_perl_file _is_user_built_flow: $file_dialog->{_is_user_built_flow}\n");

	$gui_history->set_hash_ref($file_dialog);
	$gui_history->set4FileDialog_SaveAs_start();    # sets  3
	$file_dialog = $gui_history->get_hash_ref();    # retrieves 93
	                                                   # print("1. file_dialog, user_built_flow_SaveAs_perl_file _is_user_built_flow: $file_dialog->{_is_user_built_flow}\n");
	$decisions->set4FileDialog_SaveAs($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_SaveAs();    # uses 6/38 in

	if ($pre_req_ok) {

		# print("3. file_dialog, _user_built_flow_SaveAs_perl_file ,SaveAs, pre_r_set_file_patheq_ok= $pre_req_ok \n");
		# print("2. file_dialog, _user_built_flow_SaveAs_perl_file _is_user_built_flow: $file_dialog->{_is_user_built_flow}\n");

		use L_SU_global_constants;
		use iFile;
		use control;

		use whereami;

		my $iFile   = iFile->new();
		my $control = control->new();
		my $get     = L_SU_global_constants->new();

		my $whereami = whereami->new();

		my $default_param_specs = $get->param();

		my @fields;
		my $full_path_name;

		# print ("file_dialog _user_built_flow_SaveAs_perl_file, _last_parameter_index_touched_color: $file_dialog->{_last_parameter_index_touched_color} \n");

		# make the file paths for the current file_dialog type ( Save, SaveAs, Flow, Data etc.)}
		_set_file_path();

		# collects the name of the data file to be opened
		_FileDialog();

		my $topic = $file_dialog->{_dialog_type};

		# print("file-dialog _user_built_flow_SaveAs_perl_file, file_dialog->{_dialog_type}: $topic\n");
		$full_path_name = $file_dialog->{_selected_file_name};

		# print("file-dialog _user_built_flow_SaveAs_perl_file, If not cancelled, full_path_name: $full_path_name\n");

		if ( defined $full_path_name
			&& $full_path_name ne $empty_string )
		{

			@fields = split( /\//, $full_path_name );
			$file_dialog->{_is_selected_file_name} = $true;

		}
		else {
			# print("file_dialog, _user_built_flow_SaveAs_perl_file,Cancelled. No output flow name selected NADA\n");
		}

		my $first_idx = $default_param_specs->{_first_entry_idx};
		my $length    = $default_param_specs->{_length};

		# remove suffix (pl, su, txt ) from selected file name
		if ( defined $fields[-1]
			&& $fields[-1] ne $empty_string )
		{

			$control->set_file_name( \$fields[-1] );
			$control->set_suffix();
			$control->set_first_name();
			my $suffix     = $control->get_suffix();
			my $first_name = $control->get_first_name();
			$file_dialog->{_flow_name_out} = $fields[-1];

			# print("file_dialog,_user_built_flow_SaveAs_perl_file, SaveAs,suffix: $suffix\n");
			# print("file_dialog,,_user_built_flow_SaveAs_perl_file, SaveAs,first_name: $first_name\n");
			# print("1. file_dialog,_user_built_flow_SaveAs_perl_file, flow_name_out: $file_dialog->{_flow_name_out}\n");
			# print ("file-dialog _user_built_flow_SaveAs_perl_file, _last_parameter_index_touched_color: $file_dialog->{_last_parameter_index_touched_color} \n");
		}
		else {
			# print("file_dialog,_user_built_flow_SaveAs_perl_file, No file name selected NADA\n");
		}

		$gui_history->set4FileDialog_SaveAs_end();    # ?? purpose? needed?
	}
	return ();
}

=head2  sub _user_built_flow_close_data_file

	if ($topic eq  'Data') {   # Seen as DATA
	Select was used to open a data file
	But now the _FileDialog is closing
	If we are in here it is because we are adding
	a data-file name to the entry widget under a parameter value
	
   We are already inside an Entry Widget!!
   
   		    foreach my $key (sort keys %$gui_history) {
   		print (" file_dialog key is $key, value is $file_dialog->{$key}\n");
  	}
  				
=cut

sub _user_built_flow_close_data_file {
	my ($self) = @_;

	use iFile;
	use decisions 1.00;
	use control;
	use param_widgets;
	use whereami2;
	use L_SU_global_constants;

	my $control       = control->new();
	my $param_widgets = param_widgets->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami2->new();
	my $iFile         = iFile->new();

	my @fields;
	my $full_path_name;
	my $topic = $file_dialog->{_dialog_type};
	$full_path_name = $file_dialog->{_selected_file_name};

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

	if ($full_path_name) {

		@fields = split( /\//, $full_path_name );
		$file_dialog->{_is_selected_file_name} = $true;

	}
	else {
		# print("file_dialog,_user_built_flow_close_data_file, Cancelled. No output flow name selected NADA\n");
	}

	# Open was used to open a data file
	# But now the _FileDialog is closing
	$decisions->set4FileDialog_select($file_dialog);    # 7 used / 38 in
	my $pre_req_ok = $decisions->get4FileDialog_select();

	# print("1. file_dialog,_user_built_flow_close_data_file,pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		my $widget_type = $whereami->widget_type($file_dialog->{_parameter_values_frame});

		# print("file_dialog  _user_built_flow_close_data_file selected widget type is = $widget_type	\n");

		# print("1. file_dialog,_user_built_flow_open_data_file, selected widget_type=$widget_type \n");

		my $selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

		# print("2. file_dialog  _user_built_flow_close_data_file, selected_Entry_widget: $selected_Entry_widget\n");

		$file_dialog->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();

		# print("file_dialog,_user_built_flow_open_data_file,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_user_built_flow_close_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

		# print("5. file_dialog,_user_built_flow_close_data_file,entry_button_label = $file_dialog->{_entry_button_label}\n");

		# print("file_dialog,_user_built_flow_close_data_file, both flows and superflows require the following\n");
		my $current_index = $file_dialog->{_parameter_value_index};

		# set index touched so that iFile can highlight the correct index
		# Also update the index touched so that the main program can update it later via _check4changes

		$file_dialog->{_last_parameter_index_touched_color} = $current_index;

		# print("file_dialog,_user_built_flow_close_data_file,Select,current parameter index $current_index\n");

		@{ $file_dialog->{_check_buttons_settings_aref} }[$current_index] =
			$on;

		if ( $file_dialog->{_selected_file_name} ) {

			# print("1. file_dialog,_user_built_flow_close_data_file, full name with suffix= $fields[-1]\n");

			# remove *.su suffix, get only first name, add single quotes
			$control->set_file_name_sref( \$fields[-1] );
			$control->remove_su_suffix4sref();
			$file_dialog->{_selected_file_name} = $control->get_w_single_quotes();
			_set_selected_file_name( $file_dialog->{_selected_file_name} );

			#        # both flows and superflows require the following entry updates 8-18-19
			#        # 1. collect parameter widget values
			#        $file_dialog->{_values_aref} = $param_widgets->get_values_aref();
			#        print("2. file_dialog,_user_built_flow_close_data_file, values aref= @{$file_dialog->{_values_aref}}\n");
			#        # gets 61 because 61 are initialized
			#        # 2. assign new file name to the array of values
			#        @{ $file_dialog->{_values_aref} }[$current_index] =
			#          $file_dialog->{_selected_file_name};

			# print("2. file_dialog,_user_built_flow_close_data_file, name after control = $file_dialog->{_selected_file_name}\n");

		}
		else {
			# print("file_dialog,user_built_flow_close_data_file No file was selected\n");
			# print("file_dialog,user_built_flow_close_data_file ,last path touched was
			# $file_dialog->{_last_path_touched}\n") ;
		}

		# only user-built flows require the following     TODO: what about {_is_flow_listbox_color_w} ?
		if (   $file_dialog->{_is_flow_listbox_grey_w}
			|| $file_dialog->{_is_flow_listbox_pink_w}
			|| $file_dialog->{_is_flow_listbox_green_w}
			|| $file_dialog->{_is_flow_listbox_blue_w}
			|| $file_dialog->{_is_flow_listbox_color_w} )
		{

			# print("2. file_dialog, _user_built_flow_close_data_file,suffixless selected_file_name: $file_dialog->{_selected_file_name}\n");

			# $file_dialog->{_values_aref} 	= $param_widgets->get_values_aref();

			# print("2. file_dialog, _user_built_flow_open_data_file @{$file_dialog->{_values_aref}}\n");

			# flows will be updated via flow_select, which is activated
			# in iFile->close()    - todo?
			# reset focus on item last touched in flow  - todo?
			# find which listbox and which listbox_item
			# change the Entry Value in param widgets
			# update Entry Value
			#

			# 		# Here we update the value of the Entry widget (in GUI) with the selected file name
			# 		# Now might be a good moment to update the parameter_widgets with the updated value
			# 		# update endtry those parameters
			# 	    my $selected_Entry_widget 				= $file_dialog->{_parameter_values_frame}->focusCurrent;
			#		$param_widgets							->set_entry_button_chosen_widget($selected_Entry_widget);
			#		$file_dialog->{_parameter_value_index} 	= $param_widgets->get_entry_button_chosen_index();
			#		$file_dialog->{_entry_button_label} 	= $param_widgets->get_label4entry_button_chosen();
			# 		my $current_index             			= $file_dialog->{_parameter_value_index};
			# 		$param_widgets							->redisplay_values();
			#
			#		# Make sure to place focus again on the updated widget so other modules can find the selection
			#		$selected_Entry_widget 				->focus;  # from above

			# $file_dialog->{_values_aref} 					= $param_widgets	->get_values_aref();
			# print("file_dialog, _user_built_flow_close_data_file @{$file_dialog->{_values_aref}}[0]\n");
			# print("file_dialog, last_flow_listbox_touched_w: $file_dialog->{_last_flow_listbox_touched_w} \n");

			# highlight the last flow index touched
			# requires that we define the last_lisbtox_color_w in color_flow every time we call this Data
			# for now is too complitacted
			# $iFile->close($file_dialog);  # 7 used / in 38

		}

		#$file_dialog->set4FileDialog_select_start(); #needed?
	}    # if prereq_OK

}

=head2 sub _user_built_flow_close_perl_file 

=cut

sub _user_built_flow_close_perl_file {
	my ($self) = @_;

	use iFile;
	use decisions 1.00;
	use control;
	use message_director;

	my $control              = new control;
	my $file_dialog_messages = message_director->new();
	my $iFile                = new iFile;
	my $param_widgets        = param_widgets->new();

	my @fields;
	my $full_path_name;
	my $topic = $file_dialog->{_dialog_type};    # Should be Flow: Possibles are Data, Flow (open), SaveAs
	$full_path_name = $file_dialog->{_selected_file_name};

	if ($full_path_name) {

		@fields = split( /\//, $full_path_name );
		$file_dialog->{_is_selected_file_name} = $true;
		$file_dialog->{_flow_name_in}          = $fields[-1];

		# print("file_dialog,_user_built_flow_close_perl_file,fields= $fields[-1]\n");
		# rint("file_dialog,_user_built_flow_close_perl_file, flow_name_in: $file_dialog->{_flow_name_in}\n");

		$decisions->set4FileDialog_open($file_dialog);
		my $pre_req_ok = $decisions->get4FileDialog_open();

		if ($pre_req_ok) {

			my @first_name;

			# print("2. file_dialog,_user_built_flow_close_perl_file,Open,pre_req_ok= $pre_req_ok \n");
			$file_dialog->{_path} = $iFile->get_Open_perl_flow_path();
			return ($true);

		}
		else {
			# print("file_dialog,_user_built_flow_close_perl_file,Cancelled. No output flow name selected NADA\n");
			return ($false);
		}
	}
}

=head2 sub _user_built_flow_open_data_file 

	seen in the GUI as "File/Data"
	opens data sets for a user_built_flow
	aka Data
 	Select is for pre-existing Data Sets
 	Then updates the GUI param widgets
 	The updated param values should be saved the next time that the flow is selected
 	
 	TODO make sure that wehn a differently-colored flow is selected the updated widgets
 	are stored
 	
 			foreach my $key (sort keys %$file_dialog) {
           		print (" file_dialog,key is $key, value is $file_dialog->{$key}\n");
    		}
 	
=cut 

sub _user_built_flow_open_data_file {
	my ($self) = @_;

	# print("1. file_dialog,_user_built_flow_open_data_file\n ");
	use iFile;
	use whereami;

	# use param_widgets;
	use L_SU_global_constants;

	my $param_widgets = param_widgets->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami->new();
	my $iFile         = iFile->new();

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

	# print ("1. file_dialog,_user_built_flow_open_data_file, is_last_parameter_index_touched_color: $file_dialog->{_is_last_parameter_index_touched_color} \n");
	# print ("1. file_dialog,_user_built_flow_open_data_file, is_last_flow_index_touched: $file_dialog->{_is_last_flow_index_touched} \n");
	# print (" 2. file_dialog,_user_built_flow_open_data_file->{_is_parameter_listbox_grey_w}: $file_dialog->{_is_parameter_listbox_grey_w}\n");
	# print (" 2. file_dialog,_user_built_flow_open_data_file->{_last_parameter_index_touched_color}: $file_dialog->{_last_parameter_index_touched_color}\n");

	$gui_history->set_hash_ref($file_dialog);
	#$gui_history->set_gui_widgets($file_dialog);
	$gui_history->set4FileDialog_open_start();

	# print (" 1. file_dialog,file_dialog->{_is_flow_listbox_grey_w}: $file_dialog->{_is_flow_listbox_grey_w}\n");

	$file_dialog = $gui_history->get_hash_ref();    # gets 93

	# if an appropriate entry widget is first selected, ie. Entry
	# get index of entry button pressed
	# find out which entry button has been chosen
	# confirm that it IS the file button
	# TODO determine the required file type and file path
	# TODO from the *_spec.pm file for the particular program in the flow.
	# rint("file_dialog,FileDialog_button pressed\n");

	my $widget_type = $whereami->widget_type($file_dialog->{_parameter_values_frame});

	# print("file_dialog  _user_built_flow_open_data_file selected widget type is = $widget_type	\n");

	if ( $widget_type eq 'Entry' ) {

		# print("1. file_dialog,_user_built_flow_open_data_file, selected widget_type=$widget_type \n");

		my $selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

		# print("2. file_dialog  _user_built_flow_open_data_file, selected_Entry_widget: $selected_Entry_widget\n");

		$file_dialog->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();

		# print("file_dialog,_user_built_flow_open_data_file,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_user_built_flow_open_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		if ( $file_dialog->{_parameter_value_index} >= 0 ) {    # for additional certainty; but is it needed?

			# print("4. file_dialog,_user_built_flow_open_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

			# print("5. file_dialog,_user_built_flow_open_data_file,entry_button_label = $file_dialog->{_entry_button_label}\n");

			# use iFile to determine the correct data path (directory )
			$iFile->set_entry($file_dialog);
			$iFile->set_flow_type_h($file_dialog);    # user_built
			$iFile->set_values_aref($file_dialog);    # will determine the DIR based on type of data set
			$iFile->set_prog_name_sref($file_dialog);

			# TODO set direction of data flow $iFile						-> set_in();
			$file_dialog->{_path} = $iFile->get_Data_path();

			# print("5A. file_dialog,_user_built_flow_open_data_file $file_dialog->{_path}\n");

			# collects the name of the data file to be opened
			_FileDialog();
			_user_built_flow_close_data_file();

			# print("6. file_dialog,_user_built_flow_open_data_file End\n");
		}
	}
	elsif ( $widget_type eq 'MainWindow' ) {    # opening a random file
		                                        # print("file_dialog,_user_built_flow_open_data_file widget type is 'MainWindow' \n");
		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
		$file_dialog->{_message_w}->delete( "1.0", 'end' );
		$file_dialog->{_message_w}->insert( 'end', $message );

	}
	else {

		print("file_dialog,_user_built_flow_open_data_file no widget type selected \n");
	}

	$gui_history->set4FileDialog_open_end();

}

=head2 sub _user_built_flow_open_perl_file 

			open flows written in Perl
=cut

sub _user_built_flow_open_perl_file {
	my ($self) = @_;

	# print("file_dialog,_user_built_flow_open_perl_file\n ");
	use iFile;
	use whereami;

	# use param_widgets;
	use L_SU_global_constants;
	use message_director;

	my $param_widgets           = param_widgets->new();
	my $get                     = L_SU_global_constants->new();
	my $whereami                = whereami->new();
	my $iFile                   = iFile->new();
	my $open_perl_file_messages = message_director->new();

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

	# print("0. file_dialog,_user_built_flow_open_data_file,_flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");
	# print (" 2. file_dialog,_user_built_flow_open_data_file->{_is_parameter_listbox_grey_w}: $file_dialog->{_is_parameter_listbox_grey_w}\n");
	# print (" 2. file_dialog,_user_built_flow_open_data_file->{_last_parameter_index_touched_color}: $file_dialog->{_last_parameter_index_touched_color}\n");
	$gui_history->set_hash_ref($file_dialog);

	# print("1. file_dialog,_user_built_flow_open_perl_file,_flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");
	# $gui_history->set_gui_widgets($file_dialog);

	# print("1. file_dialog,_user_built_flow_open_perl_file,_flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");
	$gui_history->set4FileDialog_open_perl_file_start();

	# print("1. file_dialog,_user_built_flow_open_perl_file,_flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");

	$file_dialog = $gui_history->get_hash_ref();    # gets 93
	                                                   # print("1. file_dialog,_user_built_flow_open_perl_file,_flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");
	                                                   # if an appropriate entry widget is first selected, ie. Entry
	                                                   # get index of entry button pressed
	                                                   # find out which entry button has been chosen
	                                                   # confirm that it IS the file button
	                                                   # TODO determine the required file type and file path
	                                                   # TODO from the *_spec.pm file for the particular program in the flow.
	                                                   # print("file_dialog,FileDialog_button pressed\n");

	# a blank message
	my $message = $open_perl_file_messages->null_button(0);
	$file_dialog->{_message_w}->delete( "1.0", 'end' );
	$file_dialog->{_message_w}->insert( 'end', $message );

	# set path to flows
	# print("file_dialog,_user_built_flow_open_perl_file, got here\n");
	$file_dialog->{_path} = $iFile->get_Open_perl_flow_path();

	# collects the name of the data file to be opened
	_FileDialog();    # directory mega widget
	my $successful = _user_built_flow_close_perl_file();

	$gui_history->set_hash_ref($file_dialog);             # uses 74 / 124 given
	$gui_history->set4FileDialog_open_perl_file_end();    # sets 2

#	foreach my $key (sort keys %$file_dialog) {
#		print (" file_dialog,key is $key, value is $file_dialog->{$key}\n");
#}

	$file_dialog = $gui_history->get_hash_ref();
	# print (" file_dialog,_user_built_flow_open_perl_file, print gui_history.txt\n");
	# $gui_history->view();
	
#	print("1. file_dialog,_user_built_flow_open_perl_file,_flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");

}

=head2 sub get_file_path

 obtain the full PATH needed to read and write Perl files


=cut 

sub get_file_path {
	my ($self) = @_;

	if ( $file_dialog->{_path} ) {

		my $perl_path = $file_dialog->{_path};

		# print("file_dialog,get_file_path, _path: $file_dialog->{_path}\n");
		return ($perl_path);

	}
	else {
		print("file_dialog,get_file_path, path is missing \n");

		# my $perl_path 					= $file_dialog->{_path};
		return ();
	}
}

=head2 sub get_hash_ref


 bring gui history parameters in to share
 and update
 # initialize default parameter values from gui_history
# needed herein

	 
=cut

sub get_hash_ref {
	my ($self) = @_;

	if ($file_dialog) {
		
		my $result = $file_dialog;
		return ($result);

	}
	else {
		print("file_dialog,get_hash_ref, missing hash ref\n");
	}

	# print("file_dialog,_update_hash_ref: $gui_history->get_defaults()\n");
}

#		$file_dialog->{_Data_menubutton}                       = $Data_menubutton;
#		$file_dialog->{_Flow_menubutton}                       = $Flow_menubutton;
#		$file_dialog->{_FileDialog_sub_ref}                    = $FileDialog_sub_ref, $file_dialog->{_FileDialog_option} = $FileDialog_option, $file_dialog->{_SaveAs_menubutton} = $SaveAs_menubutton;
#		$file_dialog->{_add2flow_button_grey}                  = $add2flow_button_grey;
#		$file_dialog->{_add2flow_button_pink}                  = $add2flow_button_pink;
#		$file_dialog->{_add2flow_button_green}                 = $add2flow_button_green;
#		$file_dialog->{_add2flow_button_blue}                  = $add2flow_button_blue;
#;
#		$file_dialog->{_check_buttons_w_aref}                  = $check_buttons_w_aref;
#		$file_dialog->{_check_code_button}                     = $check_code_button;
#		$file_dialog->{_delete_from_flow_button}               = $delete_from_flow_button;
#		$file_dialog->{_destination_index}                     = $destination_index;
#		$file_dialog->{_dialog_type}                           = $dialog_type;
#		$file_dialog->{_file_menubutton}                       = $file_menubutton;
#		$file_dialog->{_flowNsuperflow_name_w}                 = $flowNsuperflow_name_w;
#		$file_dialog->{_flow_color}                            = $flow_color;
#		$file_dialog->{_flow_item_down_arrow_button}           = $flow_item_down_arrow_button;
#		$file_dialog->{_flow_item_up_arrow_button}             = $flow_item_up_arrow_button;
#		$file_dialog->{_flow_listbox_grey_w}                   = $flow_listbox_grey_w;
#		$file_dialog->{_flow_listbox_pink_w}                   = $flow_listbox_pink_w;
#		$file_dialog->{_flow_listbox_green_w}                  = $flow_listbox_green_w;
#		$file_dialog->{_flow_listbox_blue_w}                   = $flow_listbox_blue_w;
#		$file_dialog->{_flow_listbox_color_w}                  = $flow_listbox_color_w;
#		$file_dialog->{_flow_name_grey_w}                      = $flow_name_grey_w;
#		$file_dialog->{_flow_name_in}                          = $flow_name_in;
#		$file_dialog->{_flow_name_pink_w}                      = $flow_name_pink_w;
#		$file_dialog->{_flow_name_out}                         = $flow_name_out;
#		$file_dialog->{_flow_name_green_w}                     = $flow_name_green_w;
#		$file_dialog->{_flow_name_blue_w}                      = $flow_name_blue_w;
#		$file_dialog->{_flow_type}                             = $flow_type;
#		$file_dialog->{_flow_widget_index}                     = $flow_widget_index;
#		$file_dialog->{_gui_history_ref}                       = $gui_history_ref;
#		$file_dialog->{_has_used_check_code_button}            = $has_used_check_code_button;
#		$file_dialog->{_has_used_open_perl_file_button}        = $has_used_open_perl_file_button;
#		$file_dialog->{_has_used_run_button}                   = $has_used_run_button;
#		$file_dialog->{_has_used_SaveAs_button}                = $has_used_SaveAs_button;
#		$file_dialog->{_has_used_Save_button}                  = $has_used_Save_button;
#		$file_dialog->{_has_used_Save_superflow}               = $has_used_Save_superflow;
#		$file_dialog->{_index2move}                            = $index2move;
#		$file_dialog->{_is_add2flow_button}                    = $is_add2flow_button;
#		$file_dialog->{_is_check_code_button}                  = $is_check_code_button;
#		$file_dialog->{_is_delete_from_flow_button}            = $is_delete_from_flow_button;
#		$file_dialog->{_is_dragNdrop}                          = $is_dragNdrop;
#		$file_dialog->{_is_flow_item_up_arrow_button}          = $is_flow_item_up_arrow_button;
#		$file_dialog->{_is_flow_item_down_arrow_button}        = $is_flow_item_down_arrow_button;
#		$file_dialog->{_is_flow_listbox_grey_w}                = $is_flow_listbox_grey_w;
#		$file_dialog->{_is_flow_listbox_pink_w}                = $is_flow_listbox_pink_w;
#		$file_dialog->{_is_flow_listbox_green_w}               = $is_flow_listbox_green_w;
#		$file_dialog->{_is_flow_listbox_blue_w}                = $is_flow_listbox_blue_w;
#		$file_dialog->{_is_flow_listbox_color_w}               = $is_flow_listbox_color_w;
#		$file_dialog->{_is_last_flow_index_touched}            = $is_last_flow_index_touched;
#		$file_dialog->{_is_last_flow_index_touched_grey}       = $is_last_flow_index_touched_grey;
#		$file_dialog->{_is_last_flow_index_touched_pink}       = $is_last_flow_index_touched_pink;
#		$file_dialog->{_is_last_flow_index_touched_green}      = $is_last_flow_index_touched_green;
#		$file_dialog->{_is_last_flow_index_touched_blue}       = $is_last_flow_index_touched_blue;
#		$file_dialog->{_is_last_parameter_index_touched_grey}  = $is_last_parameter_index_touched_grey;
#		$file_dialog->{_is_last_parameter_index_touched_pink}  = $is_last_parameter_index_touched_pink;
#		$file_dialog->{_is_last_parameter_index_touched_green} = $is_last_parameter_index_touched_green;
#		$file_dialog->{_is_last_parameter_index_touched_blue}  = $is_last_parameter_index_touched_blue;
#		$file_dialog->{_is_last_parameter_index_touched_color} = $is_last_parameter_index_touched_color;
#		$file_dialog->{_is_open_file_button}                   = $is_open_file_button;
#		$file_dialog->{_is_run_button}                         = $is_run_button;
#		$file_dialog->{_is_moveNdrop_in_flow}                  = $is_moveNdrop_in_flow;
#		$file_dialog->{_is_user_built_flow}                    = $is_user_built_flow;
#		$file_dialog->{_is_select_file_button}                 = $is_select_file_button;
#		$file_dialog->{_is_selected_file_name}                 = $is_selected_file_name;
#		$file_dialog->{_is_selected_path}                      = $is_selected_path;
#		$file_dialog->{_is_Save_button}                        = $is_Save_button;
#		$file_dialog->{_is_SaveAs_button}                      = $is_SaveAs_button;
#		$file_dialog->{_is_SaveAs_file_button}                 = $is_SaveAs_file_button;
#		$file_dialog->{_is_sunix_listbox}                      = $is_sunix_listbox;
#		$file_dialog->{_is_new_listbox_selection}              = $is_new_listbox_selection;
#		$file_dialog->{_is_pre_built_superflow}                = $is_pre_built_superflow;
#		$file_dialog->{_is_superflow_select_button}            = $is_superflow_select_button;
#		$file_dialog->{_is_superflow}                          = $is_superflow;
#		$file_dialog->{_is_user_built_flow}                    = $is_user_built_flow;
#		$file_dialog->{_items_checkbuttons_aref2}              = $items_checkbuttons_aref2;
#		$file_dialog->{_items_names_aref2}                     = $items_names_aref2;
#		$file_dialog->{_items_values_aref2}                    = $items_values_aref2;
#		$file_dialog->{_items_versions_aref}                   = $items_versions_aref;
#		$file_dialog->{_labels_w_aref}                         = $labels_w_aref;
#		$file_dialog->{_last_flow_color}                       = $last_flow_color;
#		$file_dialog->{_last_flow_index_touched_grey}          = $last_flow_index_touched_grey;
#		$file_dialog->{_last_flow_index_touched_pink}          = $last_flow_index_touched_pink;
#		$file_dialog->{_last_flow_index_touched_green}         = $last_flow_index_touched_green;
#		$file_dialog->{_last_flow_index_touched_blue}          = $last_flow_index_touched_blue;
#		$file_dialog->{_last_parameter_index_touched_grey}     = $last_parameter_index_touched_grey;
#		$file_dialog->{_last_parameter_index_touched_pink}     = $last_parameter_index_touched_pink;
#		$file_dialog->{_last_parameter_index_touched_green}    = $last_parameter_index_touched_green;
#		$file_dialog->{_last_parameter_index_touched_blue}     = $last_parameter_index_touched_blue;
#		$file_dialog->{_last_parameter_index_touched_color}    = $last_parameter_index_touched_color;
#		$file_dialog->{_last_flow_index_touched}               = $last_flow_index_touched;
#		$file_dialog->{_last_path_touched}                     = $last_path_touched;
#		$file_dialog->{_message_w}                             = $message_w;
#		$file_dialog->{_mw}                                    = $mw;
#		$file_dialog->{_names_aref}                            = $names_aref;
#		$file_dialog->{_occupied_listbox_aref}                 = $occupied_listbox_aref;
#		$file_dialog->{_param_flow_length}                     = $param_flow_length;
#		$file_dialog->{_parameter_names_frame}                 = $parameter_names_frame;
#		$file_dialog->{_param_sunix_first_idx}                 = $param_sunix_first_idx;
#		$file_dialog->{_param_sunix_length}                    = $param_sunix_length;
#		$file_dialog->{_parameter_values_button_frame}         = $parameter_values_button_frame;
#		$file_dialog->{_parameter_values_frame}                = $parameter_values_frame;
#		$file_dialog->{_parameter_value_index}                 = $parameter_value_index;
#		$file_dialog->{_path}                                  = $path;
#		$file_dialog->{_prog_names_aref}                       = $prog_names_aref;
#		$file_dialog->{_prog_name_sref}                        = $prog_name_sref;
#		$file_dialog->{_run_button}                            = $run_button;
#		$file_dialog->{_save_button}                           = $save_button;
#		$file_dialog->{_selected_file_name}                    = $selected_file_name;
#		$file_dialog->{_sub_ref}                               = $sub_ref;
#		$file_dialog->{_sunix_listbox}                         = $sunix_listbox;
#		$file_dialog->{_superflow_first_idx}                   = $superflow_first_idx;
#		$file_dialog->{_superflow_length}                      = $superflow_length;
#		$file_dialog->{_values_aref}                           = $values_aref;
#		$file_dialog->{_values_w_aref}                         = $values_w_aref;
#
#		return ($file_dialog);
#
#	}
#	else {
#		print("file_dialog, get_hash_ref , missing file_dialog hash ref\n");
#	}
#}

=head2 sub get_perl_flow_name_in


=cut 

sub get_perl_flow_name_in {
	my ($self) = @_;

	if ( $file_dialog->{_flow_name_in} ) {

		my $perl_flow_name_in = $file_dialog->{_flow_name_in};

		# print("file_dialog,get_flow_name_in, _flow_name_in: $file_dialog->{_flow_name_in}\n");
		return ($perl_flow_name_in);

	}
	else {
		# print("file_dialog,get_flow_name_in, _flow_name_in = -1 \n");
		my $perl_flow_name_in = $file_dialog->{_flow_name_in};
		return ($perl_flow_name_in);
	}
}

=head2 sub get_perl_flow_name_out


=cut 

sub get_perl_flow_name_out {
	my ($self) = @_;

	if ( $file_dialog->{_flow_name_out} ) {

		my $perl_flow_name_out = $file_dialog->{_flow_name_out};

		# print("file_dialog,get_flow_name_out, _flow_name_out: $file_dialog->{_flow_name_out}\n");
		return ($perl_flow_name_out);

	}
	else {
		# print("file_dialog,get_flow_name_out, _flow_name_out = -1 \n");
		my $perl_flow_name_out = $file_dialog->{_flow_name_out};
		return ($perl_flow_name_out);
	}
}

=head2 sub get_last_parameter_index_touched_color


=cut 

sub get_last_parameter_index_touched_color {
	my ($self) = @_;

	if ( $file_dialog->{_last_parameter_index_touched_color} >= 0 ) {

		my $change = $file_dialog->{_last_parameter_index_touched_color};

		# print("file_dialog,get_last_parameter_index_touched_color, _last_parameter_index_touched: $file_dialog->{_last_parameter_index_touched_color}\n");
		return ($change);

	}
	else {
		# print("file_dialog,get_last_parameter_index_touched_color, _last_parameter_index_touched_color = -1 NADA\n");
		my $change = $file_dialog->{_last_parameter_index_touched_color};
		return ($change);
	}
}

=head2 sub get_selected_file_name

=cut

sub get_selected_file_name {

	my ($self) = @_;

	if ( defined $file_dialog->{_selected_file_name}
		&& $file_dialog->{_selected_file_name} ne $empty_string )
	{

		my $result = $file_dialog->{_selected_file_name};
		return ($result);

	}
	else {
		# print("file_dialog, get_selected_file_name, empty string\n");
		return ();
	}

}

=head2 sub get_values_aref

	return reference to array of values
	belonging to one program 
	(parameter values in Entry widgets within GUI)
	
=cut 

sub get_values_aref {
	my ($self) = @_;

	if ( $file_dialog->{_values_aref} ) {

		my $values_aref = $file_dialog->{_values_aref};

		# print("file_dialog,,get_values_aref, values_aref: @{$file_dialog->{_values_aref}}\n");
		return ($values_aref);

	}
	else {
		print("file_dialog,get_values_aref missing\n");
	}
}

=head2 sub set_dialog_type

	open (data for user-built and pre-built superflows)
	
	open (perl programs of user-built flows)
	
	save (perl program of user-built flow)
	
	
=cut

sub set_dialog_type {
	my ( $self, $topic ) = @_;

	if ($topic) {
		$file_dialog->{_dialog_type} = $topic;

	}
	else {
		print("file_dialog, set_dialog_type , missing topic\n");
	}
	return ();
}

=head2 sub set_prog_name_sref

	in order to know what
	_spec file to read for
	behaviors
	
=cut

sub set_prog_name_sref {
	my ( $self, $name_sref ) = @_;

	if ($name_sref) {
		$file_dialog->{_prog_name_sref} = $name_sref;

		# print("file_dialog, set_prog_name_sref , $file_dialog->{_prog_name_sref}\n");

	}
	else {
		print("file_dialog, set_prog_name_sref , missing name\n");
	}
	return ();
}

=head2 sub set_flow_color


=cut 

sub set_flow_color {
	my ( $self, $flow_color ) = @_;

	if ($flow_color) {

		my $is_flow_listbox_color_w_text = '_is_flow_listbox_' . $flow_color . '_w';
		$file_dialog->{_flow_color} = $flow_color;

		# print("file_dialog, set_flow_color:$file_dialog->{_flow_color}\n");
		$file_dialog->{$is_flow_listbox_color_w_text} = $true;

	}
	else {
		print("file_dialog, set_flow_color, missing color\n");
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
		$file_dialog->{_flow_type} = $how_built;

	}
	else {
		print("file_dialog, set_flow_type , missing how_built\n");
	}
	return ();
}

=head2 sub set_hash_ref

	bring in important values and their keys 
	87  and 91
	
	
=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	if ($hash_ref) {
		$gui_history->set_defaults($hash_ref);
		$file_dialog = $gui_history->get_defaults();

		#		 print("1. param_widgets_color,_update_hash_ref: ENTERING\n");
		#		 $gui_history->view();

		# print("param_widgets_color,_update_hash_ref: $gui_history->get_defaults()\n");
	}
	#
	#		$file_dialog->{_FileDialog_sub_ref}                    = $hash_ref->{_FileDialog_sub_ref};
	#		$file_dialog->{_FileDialog_option}                     = $hash_ref->{_FileDialog_option};
	#		$file_dialog->{_check_buttons_settings_aref}           = $hash_ref->{_check_buttons_settings_aref};
	#		$file_dialog->{_destination_index}                     = $hash_ref->{_destination_index};
	#		$file_dialog->{_dialog_type}                           = $hash_ref->{_dialog_type};
	#		$file_dialog->{_dnd_token_grey}                        = $hash_ref->{_dnd_token_grey};
	#		$file_dialog->{_dnd_token_pink}                        = $hash_ref->{_dnd_token_pink};
	#		$file_dialog->{_dnd_token_green}                       = $hash_ref->{_dnd_token_green};
	#		$file_dialog->{_dnd_token_blue}                        = $hash_ref->{_dnd_token_blue};
	#		$file_dialog->{_dropsite_token_grey}                   = $hash_ref->{_dropsite_token_grey};
	#		$file_dialog->{_dropsite_token_pink}                   = $hash_ref->{_dropsite_token_pink};
	#		$file_dialog->{_dropsite_token_green}                  = $hash_ref->{_dropsite_token_green};
	#		$file_dialog->{_dropsite_token_blue}                   = $hash_ref->{_dropsite_token_blue};
	#		$file_dialog->{_flow_color}                            = $hash_ref->{_flow_color};
	#		$file_dialog->{_flow_item_down_arrow_button}           = $hash_ref->{_flow_item_down_arrow_button};
	#		$file_dialog->{_flow_item_up_arrow_button}             = $hash_ref->{_flow_item_up_arrow_button};
	#		$file_dialog->{_flow_name_in}                          = $hash_ref->{_flow_name_in};
	#		$file_dialog->{_flow_name_out}                         = $hash_ref->{_flow_name_out};
	#		$file_dialog->{_flow_type}                             = $hash_ref->{_flow_type};
	#		$file_dialog->{_flow_widget_index}                     = $hash_ref->{_flow_widget_index};
	#		$file_dialog->{_gui_history_ref}                       = $hash_ref->{_gui_history_ref};
	#		$file_dialog->{_has_used_check_code_button}            = $hash_ref->{_has_used_check_code_button};
	#		$file_dialog->{_has_used_open_perl_file_button}        = $hash_ref->{_has_used_open_perl_file_button};
	#		$file_dialog->{_has_used_run_button}                   = $hash_ref->{_has_used_run_button};
	#		$file_dialog->{_has_used_SaveAs_button}                = $hash_ref->{_has_used_SaveAs_button};
	#		$file_dialog->{_has_used_Save_button}                  = $hash_ref->{_has_used_Save_button};
	#		$file_dialog->{_has_used_Save_superflow}               = $hash_ref->{_has_used_Save_superflow};
	#		$file_dialog->{_index2move}                            = $hash_ref->{_index2move};
	#		$file_dialog->{_is_Save_button}                        = $hash_ref->{_is_Save_button};
	#		$file_dialog->{_is_SaveAs_button}                      = $hash_ref->{_is_SaveAs_button};
	#		$file_dialog->{_is_SaveAs_file_button}                 = $hash_ref->{_is_SaveAs_file_button};
	#		$file_dialog->{_is_add2flow_button}                    = $hash_ref->{_is_add2flow_button};
	#		$file_dialog->{_is_check_code_button}                  = $hash_ref->{_is_check_code_button};
	#		$file_dialog->{_is_delete_from_flow_button}            = $hash_ref->{_is_delete_from_flow_button};
	#		$file_dialog->{_is_dragNdrop}                          = $hash_ref->{_is_dragNdrop};
	#		$file_dialog->{_is_flow_item_down_arrow_button}        = $hash_ref->{_is_flow_item_down_arrow_button};
	#		$file_dialog->{_is_flow_item_up_arrow_button}          = $hash_ref->{_is_flow_item_up_arrow_button};
	#		$file_dialog->{_is_flow_listbox_grey_w}                = $hash_ref->{_is_flow_listbox_grey_w};
	#		$file_dialog->{_is_flow_listbox_pink_w}                = $hash_ref->{_is_flow_listbox_pink_w};
	#		$file_dialog->{_is_flow_listbox_green_w}               = $hash_ref->{_is_flow_listbox_green_w};
	#		$file_dialog->{_is_flow_listbox_blue_w}                = $hash_ref->{_is_flow_listbox_blue_w};
	#		$file_dialog->{_is_flow_listbox_color_w}               = $hash_ref->{_is_flow_listbox_color_w};
	#		$file_dialog->{_is_last_flow_index_touched_grey}       = $hash_ref->{_is_last_flow_index_touched_grey};
	#		$file_dialog->{_is_last_flow_index_touched_pink}       = $hash_ref->{_is_last_flow_index_touched_pink};
	#		$file_dialog->{_is_last_flow_index_touched_green}      = $hash_ref->{_is_last_flow_index_touched_green};
	#		$file_dialog->{_is_last_flow_index_touched_blue}       = $hash_ref->{_is_last_flow_index_touched_blue};
	#		$file_dialog->{_is_last_parameter_index_touched_grey}  = $hash_ref->{_is_last_parameter_index_touched_grey};
	#		$file_dialog->{_is_last_parameter_index_touched_pink}  = $hash_ref->{_is_last_parameter_index_touched_pink};
	#		$file_dialog->{_is_last_parameter_index_touched_green} = $hash_ref->{_is_last_parameter_index_touched_green};
	#		$file_dialog->{_is_last_parameter_index_touched_blue}  = $hash_ref->{_is_last_parameter_index_touched_blue};
	#		$file_dialog->{_is_last_flow_index_touched}            = $hash_ref->{_is_last_flow_index_touched};
	#		$file_dialog->{_is_last_parameter_index_touched_color} = $hash_ref->{_is_last_parameter_index_touched_color};
	#		$file_dialog->{_is_moveNdrop_in_flow}                  = $hash_ref->{_is_moveNdrop_in_flow};
	#		$file_dialog->{_is_new_listbox_selection}              = $hash_ref->{_is_new_listbox_selection};
	#		$file_dialog->{_is_open_file_button}                   = $hash_ref->{_is_open_file_button};
	#		$file_dialog->{_is_run_button}                         = $hash_ref->{_is_run_button};
	#		$file_dialog->{_is_select_file_button}                 = $hash_ref->{_is_select_file_button};
	#		$file_dialog->{_is_selected_file_name}                 = $hash_ref->{_is_selected_file_name};
	#		$file_dialog->{_is_selected_path}                      = $hash_ref->{_is_selected_path};
	#		$file_dialog->{_is_sunix_listbox}                      = $hash_ref->{_is_sunix_listbox};
	#		$file_dialog->{_is_pre_built_superflow}                = $hash_ref->{_is_pre_built_superflow};
	#		$file_dialog->{_is_superflow}                          = $hash_ref->{_is_superflow};
	#		$file_dialog->{_is_superflow_select_button}            = $hash_ref->{_is_superflow_select_button};
	#		$file_dialog->{_is_user_built_flow}                    = $hash_ref->{_is_user_built_flow};
	#		$file_dialog->{_last_flow_color}                       = $hash_ref->{_last_flow_color};
	#		$file_dialog->{_last_flow_index_touched}               = $hash_ref->{_last_flow_index_touched};
	#		$file_dialog->{_last_flow_index_touched_grey}          = $hash_ref->{_last_flow_index_touched_grey};
	#		$file_dialog->{_last_flow_index_touched_pink}          = $hash_ref->{_last_flow_index_touched_pink};
	#		$file_dialog->{_last_flow_index_touched_green}         = $hash_ref->{_last_flow_index_touched_green};
	#		$file_dialog->{_last_flow_index_touched_blue}          = $hash_ref->{_last_flow_index_touched_blue};
	#		$file_dialog->{_last_parameter_index_touched_color}    = $hash_ref->{_last_parameter_index_touched_color};
	#		$file_dialog->{_last_parameter_index_touched_blue}     = $hash_ref->{_last_parameter_index_touched_blue};
	#		$file_dialog->{_last_parameter_index_touched_grey}     = $hash_ref->{_last_parameter_index_touched_grey};
	#		$file_dialog->{_last_parameter_index_touched_pink}     = $hash_ref->{_last_parameter_index_touched_pink};
	#		$file_dialog->{_last_parameter_index_touched_green}    = $hash_ref->{_last_parameter_index_touched_green};
	#		$file_dialog->{_last_path_touched}                     = $hash_ref->{_last_path_touched};
	#		$file_dialog->{_names_aref}                            = $hash_ref->{_names_aref};
	#		$file_dialog->{_occupied_listbox_aref}                 = $hash_ref->{_occupied_listbox_aref};
	#		$file_dialog->{_param_flow_length}                     = $hash_ref->{_param_flow_length};
	#		$file_dialog->{_parameter_names_frame}                 = $hash_ref->{_parameter_names_frame};
	#		$file_dialog->{_param_sunix_first_idx}                 = $hash_ref->{_param_sunix_first_idx};
	#		$file_dialog->{_param_sunix_length}                    = $hash_ref->{_param_sunix_length};
	#		$file_dialog->{_path}                                  = $hash_ref->{_path};
	#		$file_dialog->{_prog_names_aref}                       = $hash_ref->{_prog_names_aref};
	#		$file_dialog->{_prog_name_sref}                        = $hash_ref->{_prog_name_sref};
	#		$file_dialog->{_selected_file_name}                    = $hash_ref->{_selected_file_name};
	#		$file_dialog->{_superflow_first_idx}                   = $hash_ref->{_superflow_first_idx};
	#		$file_dialog->{_superflow_length}                      = $hash_ref->{_superflow_length};
	#		$file_dialog->{_sub_ref}                               = $hash_ref->{_sub_ref};
	#		$file_dialog->{_values_aref}                           = $hash_ref->{_values_aref};
	#
	#		$FileDialog_sub_ref                    = $hash_ref->{_FileDialog_sub_ref};
	#		$FileDialog_option                     = $hash_ref->{_FileDialog_option};
	#		$check_buttons_settings_aref           = $hash_ref->{_check_buttons_settings_aref};
	#		$destination_index                     = $hash_ref->{_destination_index};
	#		$dialog_type                           = $hash_ref->{_dialog_type};
	#		$dnd_token_grey                        = $hash_ref->{_dnd_token_grey};
	#		$dnd_token_pink                        = $hash_ref->{_dnd_token_pink};
	#		$dnd_token_green                       = $hash_ref->{_dnd_token_green};
	#		$dnd_token_blue                        = $hash_ref->{_dnd_token_blue};
	#		$dropsite_token_grey                   = $hash_ref->{_dropsite_token_grey};
	#		$dropsite_token_pink                   = $hash_ref->{_dropsite_token_pink};
	#		$dropsite_token_green                  = $hash_ref->{_dropsite_token_green};
	#		$dropsite_token_blue                   = $hash_ref->{_dropsite_token_blue};
	#		$flow_color                            = $hash_ref->{_flow_color};
	#		$flow_item_down_arrow_button           = $hash_ref->{_flow_item_down_arrow_button};
	#		$flow_item_up_arrow_button             = $hash_ref->{_flow_item_up_arrow_button};
	#		$flow_name_in                          = $hash_ref->{_flow_name_in};
	#		$flow_name_out                         = $hash_ref->{_flow_name_out};
	#		$flow_type                             = $hash_ref->{_flow_type};
	#		$flow_widget_index                     = $hash_ref->{_flow_widget_index};
	#		$gui_history_ref                       = $hash_ref->{_gui_history_ref};
	#		$has_used_check_code_button            = $hash_ref->{_has_used_check_code_button};
	#		$has_used_open_perl_file_button        = $hash_ref->{_has_used_open_perl_file_button};
	#		$has_used_run_button                   = $hash_ref->{_has_used_run_button};
	#		$has_used_SaveAs_button                = $hash_ref->{_has_used_SaveAs_button};
	#		$has_used_Save_button                  = $hash_ref->{_has_used_Save_button};
	#		$has_used_Save_superflow               = $hash_ref->{_has_used_Save_superflow};
	#		$index2move                            = $hash_ref->{_index2move};
	#		$is_Save_button                        = $hash_ref->{_is_Save_button};
	#		$is_SaveAs_button                      = $hash_ref->{_is_SaveAs_button};
	#		$is_SaveAs_file_button                 = $hash_ref->{_is_SaveAs_file_button};
	#		$is_add2flow_button                    = $hash_ref->{_is_add2flow_button};
	#		$is_check_code_button                  = $hash_ref->{_is_check_code_button};
	#		$is_dragNdrop                          = $hash_ref->{_is_dragNdrop};
	#		$is_delete_from_flow_button            = $hash_ref->{_is_delete_from_flow_button};
	#		$is_flow_item_down_arrow_button        = $hash_ref->{_is_flow_item_down_arrow_button};
	#		$is_flow_item_up_arrow_button          = $hash_ref->{_is_flow_item_up_arrow_button};
	#		$is_flow_listbox_grey_w                = $hash_ref->{_is_flow_listbox_grey_w};
	#		$is_flow_listbox_pink_w                = $hash_ref->{_is_flow_listbox_pink_w};
	#		$is_flow_listbox_green_w               = $hash_ref->{_is_flow_listbox_green_w};
	#		$is_flow_listbox_blue_w                = $hash_ref->{_is_flow_listbox_blue_w};
	#		$is_flow_listbox_color_w               = $hash_ref->{_is_flow_listbox_color_w};
	#		$is_last_flow_index_touched_grey       = $hash_ref->{_is_last_flow_index_touched_grey};
	#		$is_last_flow_index_touched_pink       = $hash_ref->{_is_last_flow_index_touched_pink};
	#		$is_last_flow_index_touched_green      = $hash_ref->{_is_last_flow_index_touched_green};
	#		$is_last_flow_index_touched_blue       = $hash_ref->{_is_last_flow_index_touched_blue};
	#		$is_last_flow_index_touched            = $hash_ref->{_is_last_flow_index_touched};
	#		$is_last_parameter_index_touched_grey  = $hash_ref->{_is_last_parameter_index_touched_grey};
	#		$is_last_parameter_index_touched_pink  = $hash_ref->{_is_last_parameter_index_touched_pink};
	#		$is_last_parameter_index_touched_green = $hash_ref->{_is_last_parameter_index_touched_green};
	#		$is_last_parameter_index_touched_blue  = $hash_ref->{_is_last_parameter_index_touched_blue};
	#		$is_last_parameter_index_touched_color = $hash_ref->{_is_last_parameter_index_touched_color};
	#		$is_moveNdrop_in_flow                  = $hash_ref->{_is_moveNdrop_in_flow};
	#		$is_open_file_button                   = $hash_ref->{_is_open_file_button};
	#		$is_run_button                         = $hash_ref->{_is_run_button};
	#		$is_select_file_button                 = $hash_ref->{_is_select_file_button};
	#		$is_selected_file_name                 = $hash_ref->{_is_selected_file_name};
	#		$is_selected_path                      = $hash_ref->{_is_selected_path};
	#		$is_sunix_listbox                      = $hash_ref->{_is_sunix_listbox};
	#		$is_new_listbox_selection              = $hash_ref->{_is_new_listbox_selection};
	#		$is_pre_built_superflow                = $hash_ref->{_is_pre_built_superflow};
	#		$is_superflow                          = $hash_ref->{_is_superflow};
	#		$is_superflow_select_button            = $hash_ref->{_is_superflow_select_button};
	#		$is_user_built_flow                    = $hash_ref->{_is_user_built_flow};
	#		$items_checkbuttons_aref2              = $hash_ref->{_items_checkbuttons_aref2};
	#		$items_names_aref2                     = $hash_ref->{_items_names_aref2};
	#		$items_values_aref2                    = $hash_ref->{_items_names_aref2};
	#		$items_versions_aref                   = $hash_ref->{_items_values_aref2};
	#		$last_flow_color                       = $hash_ref->{_last_flow_color};
	#		$last_flow_index_touched_grey          = $hash_ref->{_last_flow_index_touched_grey};
	#		$last_flow_index_touched_pink          = $hash_ref->{_last_flow_index_touched_pink};
	#		$last_flow_index_touched_green         = $hash_ref->{_last_flow_index_touched_green};
	#		$last_flow_index_touched_blue          = $hash_ref->{_last_flow_index_touched_blue};
	#		$last_flow_index_touched               = $hash_ref->{_last_flow_index_touched};
	#		$last_parameter_index_touched_grey     = $hash_ref->{_last_parameter_index_touched_grey};
	#		$last_parameter_index_touched_pink     = $hash_ref->{_last_parameter_index_touched_pink};
	#		$last_parameter_index_touched_green    = $hash_ref->{_last_parameter_index_touched_green};
	#		$last_parameter_index_touched_blue     = $hash_ref->{_last_parameter_index_touched_blue};
	#		$last_parameter_index_touched_color    = $hash_ref->{_last_parameter_index_touched_color};
	#		$last_path_touched                     = $hash_ref->{_last_path_touched};
	#		$names_aref                            = $hash_ref->{_names_aref};
	#		$param_flow_length                     = $hash_ref->{_param_flow_length};
	#		$parameter_names_frame                 = $hash_ref->{_parameter_names_frame};
	#		$param_sunix_first_idx                 = $hash_ref->{_param_sunix_first_idx};
	#		$param_sunix_length                    = $hash_ref->{_param_sunix_length};
	#		$path                                  = $hash_ref->{_path};
	#		$prog_names_aref                       = $hash_ref->{_prog_names_aref};
	#		$prog_name_sref                        = $hash_ref->{_prog_name_sref};
	#		$selected_file_name                    = $hash_ref->{_selected_file_name};
	#		$superflow_first_idx                   = $hash_ref->{_superflow_first_idx};
	#		$superflow_length                      = $hash_ref->{_superflow_length};
	#		$sub_ref                               = $hash_ref->{_sub_ref};
	#		$values_aref                           = $hash_ref->{_values_aref};
	#
	#		# print("file_dialog, set_hash_ref, _is_flow_listbox_grey_w: $file_dialog->{_is_flow_listbox_grey_w} \n");
	#		# print("file_dialog, set_hash_ref, _check_buttons_settings_aref: $file_dialog->{_check_buttons_settings_aref} \n");
	#		# print("file_dialog,set_hash_ref, values_aref[0]: $file_dialog->{_values_aref}[0]\n");
	#	}
	#	else {
	#
	#		print("file_dialog, set_gui_widgets, missing hash_ref\n");
return ();
}

#
#=head2 sub set_gui_widgets
#
# bring in important widget addresses: 34
# encapsulate within private scalar carriers: 34
# (private simplified names)
#	
#=cut
#
#sub set_gui_widgets {
#	my ( $self, $widget_hash_ref ) = @_;
#
#	if ($widget_hash_ref) {
#
#		$file_dialog->{_Data_menubutton}               = $widget_hash_ref->{_Data_menubutton};
#		$file_dialog->{_Flow_menubutton}               = $widget_hash_ref->{_Flow_menubutton};
#		$file_dialog->{_SaveAs_menubutton}             = $widget_hash_ref->{_SaveAs_menubutton};
#		$file_dialog->{_add2flow_button_grey}          = $widget_hash_ref->{_add2flow_button_grey};
#		$file_dialog->{_add2flow_button_pink}          = $widget_hash_ref->{_add2flow_button_pink};
#		$file_dialog->{_add2flow_button_green}         = $widget_hash_ref->{_add2flow_button_green};
#		$file_dialog->{_add2flow_button_blue}          = $widget_hash_ref->{_add2flow_button_blue};
#		$file_dialog->{_check_buttons_w_aref}          = $widget_hash_ref->{_check_buttons_w_aref};
#		$file_dialog->{_check_code_button}             = $widget_hash_ref->{_check_code_button};
#		$file_dialog->{_delete_from_flow_button}       = $widget_hash_ref->{_delete_from_flow_button};
#		$file_dialog->{_file_menubutton}               = $widget_hash_ref->{_file_menubutton};
#		$file_dialog->{_flowNsuperflow_name_w}         = $widget_hash_ref->{_flowNsuperflow_name_w};
#		$file_dialog->{_flow_item_down_arrow_button}   = $widget_hash_ref->{_flow_item_down_arrow_button};
#		$file_dialog->{_flow_item_up_arrow_button}     = $widget_hash_ref->{_flow_item_up_arrow_button};
#		$file_dialog->{_flow_listbox_grey_w}           = $widget_hash_ref->{_flow_listbox_grey_w};
#		$file_dialog->{_flow_listbox_pink_w}           = $widget_hash_ref->{_flow_listbox_pink_w};
#		$file_dialog->{_flow_listbox_green_w}          = $widget_hash_ref->{_flow_listbox_green_w};
#		$file_dialog->{_flow_listbox_blue_w}           = $widget_hash_ref->{_flow_listbox_blue_w};
#		$file_dialog->{_flow_listbox_color_w}          = $widget_hash_ref->{_flow_listbox_color_w};
#		$file_dialog->{_flow_name_grey_w}              = $widget_hash_ref->{_flow_name_grey_w};
#		$file_dialog->{_flow_name_pink_w}              = $widget_hash_ref->{_flow_name_pink_w};
#		$file_dialog->{_flow_name_green_w}             = $widget_hash_ref->{_flow_name_green_w};
#		$file_dialog->{_flow_name_blue_w}              = $widget_hash_ref->{_flow_name_blue_w};
#		$file_dialog->{_flow_widget_index}             = $widget_hash_ref->{_flow_widget_index};
#		$file_dialog->{_labels_w_aref}                 = $widget_hash_ref->{_labels_w_aref};
#		$file_dialog->{_message_w}                     = $widget_hash_ref->{_message_w};
#		$file_dialog->{_mw}                            = $widget_hash_ref->{_mw};
#		$file_dialog->{_parameter_values_button_frame} = $widget_hash_ref->{_parameter_values_button_frame};
#		$file_dialog->{_parameter_values_frame}        = $widget_hash_ref->{_parameter_values_frame};
#		$file_dialog->{_parameter_value_index}         = $widget_hash_ref->{_parameter_value_index};
#		$file_dialog->{_run_button}                    = $widget_hash_ref->{_run_button};
#		$file_dialog->{_save_button}                   = $widget_hash_ref->{_save_button};
#		$file_dialog->{_sunix_listbox}                 = $widget_hash_ref->{_sunix_listbox};
#		$file_dialog->{_values_w_aref}                 = $widget_hash_ref->{_values_w_aref};
#
#		$Data_menubutton               = $file_dialog->{_Data_menubutton};
#		$Flow_menubutton               = $file_dialog->{_Flow_menubutton};
#		$SaveAs_menubutton             = $file_dialog->{_SaveAs_menubutton};
#		$add2flow_button_grey          = $file_dialog->{_add2flow_button_grey};
#		$add2flow_button_pink          = $file_dialog->{_add2flow_button_pink};
#		$add2flow_button_green         = $file_dialog->{_add2flow_button_green};
#		$add2flow_button_blue          = $file_dialog->{_add2flow_button_blue};
#		$check_buttons_w_aref          = $file_dialog->{_check_buttons_w_aref};
#		$check_code_button             = $file_dialog->{_check_code_button};
#		$delete_from_flow_button       = $file_dialog->{_delete_from_flow_button};
#		$file_menubutton               = $file_dialog->{_file_menubutton};
#		$flowNsuperflow_name_w         = $file_dialog->{_flowNsuperflow_name_w};
#		$flow_item_down_arrow_button   = $file_dialog->{_flow_item_down_arrow_button};
#		$flow_item_up_arrow_button     = $file_dialog->{_flow_item_up_arrow_button};
#		$flow_listbox_grey_w           = $file_dialog->{_flow_listbox_grey_w};
#		$flow_listbox_pink_w           = $file_dialog->{_flow_listbox_pink_w};
#		$flow_listbox_green_w          = $file_dialog->{_flow_listbox_green_w};
#		$flow_listbox_blue_w           = $file_dialog->{_flow_listbox_blue_w};
#		$flow_listbox_color_w          = $file_dialog->{_flow_listbox_color_w};
#		$flow_name_grey_w              = $file_dialog->{_flow_name_grey_w};
#		$flow_name_pink_w              = $file_dialog->{_flow_name_pink_w};
#		$flow_name_green_w             = $file_dialog->{_flow_name_green_w};
#		$flow_name_blue_w              = $file_dialog->{_flow_name_blue_w};
#		$flow_widget_index             = $file_dialog->{_flow_widget_index};
#		$labels_w_aref                 = $file_dialog->{_labels_w_aref};
#		$message_w                     = $file_dialog->{_message_w};
#		$mw                            = $file_dialog->{_mw};
#		$parameter_values_button_frame = $file_dialog->{parameter_values_button_frame};
#		$parameter_values_frame        = $file_dialog->{_parameter_values_frame};
#		$parameter_value_index         = $file_dialog->{_parameter_value_index};
#		$run_button                    = $file_dialog->{_run_button};
#		$save_button                   = $file_dialog->{_save_button};
#		$sunix_listbox                 = $file_dialog->{_sunix_listbox};
#		$values_w_aref                 = $file_dialog->{_values_w_aref};
#
#		# print("file_dialog, set_gui_widgets	parameter_values_frame: $parameter_values_frame\n");
#		# print("file_dialog, set_gui_widgets	flowNsuperflow_name_w: $flowNsuperflow_name_w\n");
#
#	}
#	else {
#
#		print("file_dialog, set_gui_widgets, missing gui_widgets\n");
#	}
#	return ();
#}

sub FileDialog_director {
	my ($self) = @_;

	# print ("1. file_dialog,FileDialog_director, is_last_parameter_index_touched_color: $file_dialog->{_is_last_parameter_index_touched_color} \n");
	# print ("1. file_dialog,FileDialog_director, is_last_flow_index_touched: $file_dialog->{_is_last_flow_index_touched} \n");
	# print("1. file_dialog, FileDialog_director, flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");

	my $file_dialog_flow_type = _get_flow_type();

	# print("file_dialog, FileDialog_director, flow_type:$file_dialog_flow_type\n");

	if ( $file_dialog_flow_type eq $flow_type_h->{_user_built} ) {

		# print("file_dialog, FileDialog_director, should be user_built_flow_type:$file_dialog_flow_type\n");

		_set_FileDialog2user_built_flow();

	}
	elsif ( $file_dialog_flow_type eq $flow_type_h->{_pre_built_superflow} ) {

		# print("file_dialog, FileDialog_director, should be superflow_type:$file_dialog_flow_type\n");

		_set_FileDialog2pre_built_superflow();

	}
	else {
		print("file_dialog, FileDialog_director has a problem\n");
	}
	return ();
}

=head2 sub set_file_dialog_sub_ref 

=cut

sub set_file_dialog_sub_ref {
	my ( $self, $sub_ref ) = @_;

	if ($sub_ref) {
		print("binding  set_file_dialog_sub_ref, $sub_ref\n");
		$file_dialog->{_sub_ref} = $sub_ref;

	}
	else {
		print("file_dialog, set_FileDialog_button_sub_ref, missing sub ref\n");
	}

	return ();
}

1;
