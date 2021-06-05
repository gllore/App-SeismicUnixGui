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

=head4 Examples


=head2 CHANGES and their DATES

 V 0.0.3refactoring of 2017 version of L_SU.pl
 
 Feb 24 2020
 V 0.0.4 incldue PL_SEISMIC as a file_dialog_type
 This new file dialog type automatically opens
 PL_SEISMIC path.

=cut 

use Moose;
our $VERSION = '0.0.4';

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

	_check_buttons_settings_aref => '',

};


=head2 private variables

=cut
my $user_built_flow_open_data_widget_type;
my $user_built_flow_open_data_selected_Entry_widget;
my $user_built_flow_open_data_parameter_value_index;


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

	use Tk::JFileDialog;

	# use JFileDialog;    # 4/25/2019
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
		-width        => 52,
		-maxwidth     => 59,
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

=head2  _big_stream_last_dir_in_path

=cut 

sub _big_stream_last_dir_in_path {

	my ($self) = @_;

	#	print("file_dialog, _big_stream_last_dir_in_path\n ");
	use iFile;
	use whereami;
	use L_SU_global_constants;

	my $param_widgets = param_widgets4pre_built_streams->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami->new();
	my $iFile         = iFile->new();

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

	$gui_history->set_hash_ref($file_dialog);
	$gui_history->set4FileDialog_open_start();
	$gui_history->set4superflow_open_path_start();
	$file_dialog = $gui_history->get_hash_ref();    # gets 93

	# If an appropriate Entry widget is first selected,
	# Find out which entry button has been chosen (index)
	# Confirm that it IS the file button

	# print("file_dialog,_big_stream_last_dir_in_path,_FileDialog_button pressed, \n");
	# print("file_dialog, _big_stream_last_dir_in_path selected  _values_aref=@{$file_dialog->{_values_aref}}\n");
	# print("file_dialog, _big_stream_last_dir_in_path selected  _values_aref=@{$file_dialog->{_names_aref}}\n");
	# print("file_dialog  _big_stream_last_dir_in_path selected  parameter_values_frame = $file_dialog->{_parameter_values_frame} \n");

	my $widget_type = $whereami->widget_type( $file_dialog->{_parameter_values_frame} );

	# print("file_dialog  _big_stream_last_dir_in_path selected widget type is = $widget_type	\n");

	if ( $widget_type eq 'Entry' ) {

		# print("1. file_dialog,_big_stream_last_dir_in_path, selected widget_type=$widget_type \n");

		my $selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		# print("file_dialog,_big_stream_last_dir_in_path,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_big_stream_last_dir_in_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

		# print("2. file_dialog  _big_stream_last_dir_in_path, selected_Entry_widget: $selected_Entry_widget\n");

		$file_dialog->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();

		# print("file_dialog,_big_stream_last_dir_in_path,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_big_stream_last_dir_in_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		if ( $file_dialog->{_parameter_value_index} >= 0 ) {    # for additional certainty; but is it needed?
			 # print("4. file_dialog,ig_stream_last_dir_in_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");
			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

			# print("5. file_dialog,_big_stream_last_dir_in_path,entry_button_label = $file_dialog->{_entry_button_label}\n");

			# use iFile to determine the Path stored in the current configuration file
			$iFile->set_entry($file_dialog);                    # selected entry label
			$iFile->set_flow_type_h($file_dialog);              # a pre-built superflow
			$iFile->set_parameter_value_index($file_dialog);    # e.g., 0
			$iFile->set_values_aref($file_dialog);              # e.g., /home/gom/
			$iFile->set_prog_name_sref($file_dialog);           # e.g., Project_config

			$file_dialog->{_path} = $iFile->get_Path();
#			print("1.file_dialog,_pre-built_superflow_path, PATH:  $file_dialog->{_path} \n");

			# print("1.file_dialog,ig_stream_last_dir_in_path, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");

			_FileDialog();                                      # open file dialog widget

			#			print("2.file_dialog,_pre-built_superflow_path, last_path_touched:  $file_dialog->{_last_path_touched} \n");

			_big_stream_last_dir_in_path_close();

			# print("2.file_dialog,ig_stream_last_dir_in_path, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");
			# my $length= scalar @{$file_dialog->{_values_aref}};  # 61 values
			# for (my $i=0; $i < $length; $i++) {
			# 	print("3.file_dialog,ig_stream_last_dir_in_path, _values_aref: @{$file_dialog->{_values_aref}}[$i]\n");
			# }
		}

	} elsif ( $widget_type eq 'MainWindow' ) {    # opening a random file

#		print("file_dialog,_big_stream_last_dir_in_path widget type is 'MainWindow' \n");
		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
		$file_dialog->{_message_w}->delete( "1.0", 'end' );
		$file_dialog->{_message_w}->insert( 'end', $message );

	} else {
		print("file_dialog,big_stream_last_dir_in_path, no widget type selected \n");
	}
}

=head2 sub _big_stream_last_dir_in_path_close

  re-organizing the display after a directory (path) is selected

    TODO: CASE of opening a pre-existing superflow configuration file
        or previously scripted flow by this GUI
        BEFORE or While the menubutton OR Frame are selected
        
 
=cut

sub _big_stream_last_dir_in_path_close {
	my ($self) = @_;

	use iFile;
	use decisions 1.00;
	use control;

	my $iFile         = new iFile;
	my $control       = new control;
	my $param_widgets = param_widgets4pre_built_streams->new();

	my $topic             = $file_dialog->{_dialog_type};
	my $last_path_touched = $file_dialog->{_last_path_touched};

	if ( defined $last_path_touched
		&& $last_path_touched ne $empty_string ) {

		$file_dialog->{_is_selected_path} = $true;

	} else {
		print("file_dialog, _big_stream_last_dir_in_path_close, Cancelled. No path\n");
	}

	$decisions->set4FileDialog_select($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_select();

	# print("1. file_dialog,_big_stream_last_dir_in_path_close, pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		my $result = 0;

		# print("3. file_dialog,_big_stream_last_dir_in_path_close,last_path_touched= $file_dialog->{_last_path_touched}\n");
		# print("4. file_dialog,_big_stream_last_dir_in_path_close,prog_name:${$file_dialog->{_prog_name_sref}}\n");

		if (    defined( $file_dialog->{_last_path_touched} )
			and $file_dialog->{_last_path_touched} ne $empty_string
			and ${ $file_dialog->{_prog_name_sref} } ne $empty_string ) {

			#			print("file_dialog,_big_stream_last_dir_in_path_close, for $file_dialog->{_prog_name_sref} \n");
			use dirs;
			my $dirs = dirs->new();
			$dirs->set_path( $file_dialog->{_last_path_touched} );
			$result = dirs->get_last_dirInpath();    # only keep the last directory name

			#			print("file_dialog,_big_stream_last_dir_in_path_close, is $result  \n");

		} else {
			print("file_dialog,_big_stream_last_dir_in_path_close No path was selected\n");

			# print("4. file_dialog,_big_stream_last_dir_in_path_close,last path touched was
			# $file_dialog->{_last_path_touched}\n") ;
		}

		# print("7. file_dialog,_big_stream_last_dir_in_path_close prog_name=${$file_dialog->{_prog_name_sref}}\n");

		my $current_index = $file_dialog->{_parameter_value_index};

		# both flows and big streams require the following entry updates
		# collect parameter widget values
		$file_dialog->{_values_aref} = $param_widgets->get_values_aref();

		# assign new file name to the array of values
		@{ $file_dialog->{_values_aref} }[$current_index]                 = $result;
		@{ $file_dialog->{_check_buttons_settings_aref} }[$current_index] = $on;

		# update the gui with the new path
		$param_widgets->set_values( $file_dialog->{_values_aref} );

		# print("10. file_dialog,_pre_built_superflow_close_path values are: @{$file_dialog->{_values_aref}} \n");
		# $param_widgets->redisplay_values();

		$gui_history->set4superflow_close_path_end();
		$file_dialog = $gui_history->get_hash_ref();

	}    # if pre_req_OK
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

		# print("file_dialog, _get_dialog_type is $topic\n");
		return ($topic);

	} else {
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
   	 
   	 within program we also have 'Path' or directory
   
=cut 	

sub _get_path {
	my ($self) = @_;

	if ( defined $file_dialog->{_path}
		&& $file_dialog->{_path} ne $empty_string ) {

		my $path = $file_dialog->{_path};
		return ($path);

	} else {
		print(" file_dialog,_get_path, missing file path\n");
		return ();
	}
}

=head2 sub _set_file_path 

   _dialog_type, which can be seen in GUI as
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

		} elsif ( $topic eq $file_dialog_type->{_Flow} ) {    # Open pre-exiting user-built flow
			$file_dialog->{_path} = $PL_SEISMIC;

			# print("file_dialog, _set_file_path ,dialog type:$topic\n");
			# print("file_dialog, _set_file_path ,path:$file_dialog->{_path}\n");

		} elsif ( $topic eq $file_dialog_type->{_SaveAs} ) {    # save a new user-built flow
			$file_dialog->{_path} = $PL_SEISMIC;

			# print("file_dialog, _set_file_path ,dialog type:$topic\n");
			# print("file_dialog, _set_file_path ,path:$file_dialog->{_path}\n");

		} elsif ( $topic eq 'Save' ) {
			$file_dialog->{_path} = $PL_SEISMIC;

			# print("file_dialog, _set_file_path ,dialog type:$topic\n");
			# print("file_dialog, _set_file_path ,path:$file_dialog->{_path}\n");

		} else {
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

	} else {
		print("file_dialog, _get_flow_type , missing topic\n");
		return ();
	}

}

=head2 sub _pre_built_superflow_close_data_file

  reorganizing the display after a file is selected

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
	my $param_widgets = param_widgets4pre_built_streams->new();

	my @fields;
	my $topic     = $file_dialog->{_dialog_type};
	my $pathNfile = $file_dialog->{_selected_file_name};

	if ( defined $pathNfile
		&& $pathNfile ne $empty_string ) {

		@fields = split( /\//, $pathNfile );

		# print("file_dialog, _pre_built_superflow_close_data_file,fields are: @fields\n");
		$file_dialog->{_is_selected_file_name} = $true;

	} else {
		print("file_dialog, _pre_built_superflow_close_data_file,Cancelled. No  name selected\n");
	}

	# TODO: check whether _is_superflow_select_button is needed inside decisions
	$decisions->set4FileDialog_select($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_select();

	# print("1. file_dialog,_pre_built_superflow_close_data_file, pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		# both flows and superflows require the following
		my $current_index = $file_dialog->{_parameter_value_index};

		# print("2. file_dialog,_pre_built_superflow_close_data_file, current parameter index $current_index\n")
		#	;

		@{ $file_dialog->{_check_buttons_settings_aref} }[$current_index] = $on;

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

		} else {
			print("file_dialog,_pre_built_superflow_close_data_file No file was selected\n");
			# print("4. file_dialog,_pre_built_superflow_close_data_file,last path touched was
			# $file_dialog->{_last_path_touched}\n") ;
		}

		# print("7. file_dialog,_pre_built_superflow_close_data_fileprog_name=
		# ${$file_dialog->{_prog_name_sref}}\n");

		# legacy code: only ProjectVariables (a superflow) which does
		# not have files/only directories requires the following
		if ( ${ $file_dialog->{_prog_name_sref} } eq $superflow_names->{_ProjectVariables} ) {

			@{ $file_dialog->{_values_aref} }[$current_index] = $file_dialog->{_last_path_touched};

			# print("8. file_dialog,_pre_built_superflow_close_data_file last path is $file_dialog->{_last_path_touched} \n");
		}

		# print(
		# 	"9. file_dialog,_pre_built_superflow_close_data_file selected_file_name=$file_dialog->{_selected_file_name}\n"
		# );

		# both flows and superflows require the following entry updates
		# collect parameter widget values
		$file_dialog->{_values_aref} = $param_widgets->get_values_aref();  # gets 61 because 61 are initialized
																		   # assign new file name to the array of values

		# print("10. file_dialog,_pre_built_superflow_close_data_file values are: @{$file_dialog->{_values_aref}} \n");
		@{ $file_dialog->{_values_aref} }[$current_index] = $file_dialog->{_selected_file_name};

		# update the gui with the new file name
		$param_widgets->set_values( $file_dialog->{_values_aref} );

		# print("10. file_dialog,_pre_built_superflow_close_data_file values are: @{$file_dialog->{_values_aref}} \n");
		$param_widgets->redisplay_values();

		$gui_history->set4superflow_close_data_file_end();
		$file_dialog = $gui_history->get_hash_ref();                       # retrieves 93

	}    # if prereq_OK
}

=head2 sub _pre_built_superflow_close_path

  re-organizing the display after a directory (path) is selected

    TODO: CASE of opening a pre-existing superflow configuration file
        or previously scripted flow by this GUI
        BEFORE or While the menubutton OR Frame are selected
        
 
=cut

sub _pre_built_superflow_close_path {
	my ($self) = @_;

	use iFile;
	use decisions 1.00;
	use control;

	my $iFile         = new iFile;
	my $control       = new control;
	my $param_widgets = param_widgets4pre_built_streams->new();

	my $topic             = $file_dialog->{_dialog_type};
	my $last_path_touched = $file_dialog->{_last_path_touched};

	if ( defined $last_path_touched
		&& $last_path_touched ne $empty_string ) {

		$file_dialog->{_is_selected_path} = $true;

	} else {
		print("file_dialog, _pre_built_superflow_close_path, Cancelled. No path\n");
	}

	$decisions->set4FileDialog_select($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_select();

	# print("1. file_dialog,_pre_built_superflow_close_path, pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		my $result;

		# print("3. file_dialog,_pre_built_superflow_close_path,last_path_touched= $file_dialog->{_last_path_touched}\n");
		# print("4. file_dialog,_pre_built_superflow_close_path,prog_name:${$file_dialog->{_prog_name_sref}}\n");

		if (    defined( $file_dialog->{_last_path_touched} )
			and $file_dialog->{_last_path_touched} ne $empty_string
			and ${ $file_dialog->{_prog_name_sref} } ne $empty_string ) {

			# print("file_dialog,_pre_built_superflow_close_path,CASE #1  Sucat\n");
			$result = $file_dialog->{_last_path_touched};    # no abbreviation
				# print("4. file_dialog,_pre_built_superflow_close_path,value that will be saved: $result\n");

		} else {
			print("file_dialog,_pre_built_superflow_close_path No path was selected\n");

			# print("4. file_dialog,_pre_built_superflow_close_path,last path touched was
			# $file_dialog->{_last_path_touched}\n") ;
		}

		# print("7. file_dialog,_pre_built_superflow_close_path prog_name=${$file_dialog->{_prog_name_sref}}\n");

		my $current_index = $file_dialog->{_parameter_value_index};

		# both flows and superflows require the following entry updates
		# collect parameter widget values
		$file_dialog->{_values_aref} = $param_widgets->get_values_aref();    # gets 61 because 61 are initialized

		# assign new file name to the array of values
		@{ $file_dialog->{_values_aref} }[$current_index]                 = $result;
		@{ $file_dialog->{_check_buttons_settings_aref} }[$current_index] = $on;

		# update the gui with the new path
		$param_widgets->set_values( $file_dialog->{_values_aref} );

		# print("10. file_dialog,_pre_built_superflow_close_path values are: @{$file_dialog->{_values_aref}} \n");
		# $param_widgets->redisplay_values();

		$gui_history->set4superflow_close_path_end();
		$file_dialog = $gui_history->get_hash_ref();

	}    # if pre_req_OK
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

	use param_widgets4pre_built_streams;
	use L_SU_global_constants;

	my $param_widgets = param_widgets4pre_built_streams->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami->new();
	my $iFile         = iFile->new();

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

	# e.g. Data_Pl_SEISMIC, Data, Path, Flow etc.
	my $topic = _get_dialog_type();

	$gui_history->set_hash_ref($file_dialog);
	$gui_history->set4FileDialog_open_start();
	$gui_history->set4superflow_open_data_file_start();
	$file_dialog = $gui_history->get_hash_ref();

	# Tests follow:
	# 1. if an appropriate entry widget is first selected, ie. Entry
	# 2. get index of entry button pressed
	# 3. find out which entry button has been chosen
	# 4. confirm that it IS the file button
	# TODO determine the required file type and file path
	# TODO from the *_spec.pm file for the particular program in the flow.
	# print("file_dialog,_pre_built_superflow_open_data_file,_FileDialog_button pressed, \n");
	# print("file_dialog, _pre_built_superflow_open_data_file selected  _values_aref=@{$file_dialog->{_values_aref}}\n");
	# print("file_dialog  _pre_built_superflow_open_data_file selected  parameter_values_frame = $file_dialog->{_parameter_values_frame} 	\n");
	my $widget_type = $whereami->widget_type( $file_dialog->{_parameter_values_frame} );

	# print("file_dialog  _pre_built_superflow_open_data_file selected widget type is = $widget_type	\n");

	if ( $widget_type eq 'Entry' ) {

		# print("1. file_dialog,_pre_built_superflow_open_data_file, selected widget_type=$widget_type \n");

		my $selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

		# print("2. file_dialog, _pre_built_superflow_open_data_file, selected_Entry_widget: $selected_Entry_widget\n");

		$file_dialog->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();

		# print("file_dialog,_pre_built_superflow_open_data_file,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_pre_built_superflow_open_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		if ( $file_dialog->{_parameter_value_index} >= 0 ) {    # for additional certainty; but is it needed?

			# e.g. Data_Pl_SEISMIC, Data, Path, Flow etc.
			my $topic = _get_dialog_type();

			# print("4. file_dialog,_pre_built_flow_open_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");
			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

			#print(
			#	"5. file_dialog,_pre_built_superflow_open_data_file,entry_button_label = $file_dialog->{_entry_button_label}\n"
			# );

			# use iFile to determine the correct data path (directory)
			$iFile->set_entry($file_dialog);          # first entry label should be base_file_name
			$iFile->set_flow_type_h($file_dialog);    # pre-built superflow will determine the DIR to find data
			$iFile->set_values_aref($file_dialog);    # may not be needed ( only for user-built_flows) TODO
			$iFile->set_prog_name_sref($file_dialog);
			$iFile->set_dialog_type($topic);

			$file_dialog->{_path} = $iFile->get_Data_path();

			# print("1.file_dialog,_pre-built_superflow_open_data_file, PATH:  $file_dialog->{_path} \n");
			# print(
			# 	"1.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[0]\n"
			# );

			_FileDialog();

			# print("2.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");

			_pre_built_superflow_close_data_file();

			# print("2.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");
			# my $length= scalar @{$file_dialog->{_values_aref}};  # 61 values
			# for (my $i=0; $i < $length; $i++) {
			# 	 print("3.file_dialog,_pre-built_superflow_open_data_file, _values_aref: @{$file_dialog->{_values_aref}}[$i]\n");
			# }
		}
	} elsif ( $widget_type eq 'MainWindow' ) {    # opening a random file
			# print("file_dialog,_pre_built_superflow_open_data_file widget type is 'MainWindow' \n");
		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
		$file_dialog->{_message_w}->delete( "1.0", 'end' );
		$file_dialog->{_message_w}->insert( 'end', $message );

	} else {
		print("file_dialog,_pre-built_superflow_open_data_file no widget type selected \n");
	}

	$gui_history->set4superflow_open_data_file_end();
	$gui_history->set4FileDialog_open_end();        # 2 set
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
	use control;

	my $param_widgets = param_widgets4pre_built_streams->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami->new();
	my $iFile         = iFile->new();
	my $control       = control->new();

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

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

	my $widget_type = $whereami->widget_type( $file_dialog->{_parameter_values_frame} );

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
			$control->set_path( $file_dialog->{_path} );
			$file_dialog->{_path} = $control->get_path_wo_last_slash();

			# print("1.file_dialog,_pre-built_superflow_path, PATH:  $file_dialog->{_path} \n");

			# print("1.file_dialog,_pre-built_superflow_path, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");

			_FileDialog();    # open file dialog widget

			# print("2.file_dialog,_pre-built_superflow_path, last_path_touched:  $file_dialog->{_last_path_touched} \n");

			_pre_built_superflow_close_path();

			# print("2.file_dialog,_pre-built_superflow_path, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");
			# my $length= scalar @{$file_dialog->{_values_aref}};  # 61 values
			# for (my $i=0; $i < $length; $i++) {
			# 	print("3.file_dialog,_pre-built_superflow_path, _values_aref: @{$file_dialog->{_values_aref}}[$i]\n");
			# }
		}
	} elsif ( $widget_type eq 'MainWindow' ) {    # opening a random file

#		print("file_dialog,_pre_built_superflow_open_path widget type is 'MainWindow' \n");
		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
		$file_dialog->{_message_w}->delete( "1.0", 'end' );
		$file_dialog->{_message_w}->insert( 'end', $message );

	} else {
		print("file_dialog,_pre-built_superflow_path no widget type selected \n");
	}

	$gui_history->set4superflow_open_path_end();
	$gui_history->set4FileDialog_open_end();        # 2 set
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

	} elsif ( $topic eq $file_dialog_type->{_Data_PL_SEISMIC} ) {

		# print("file_dialog,_set_FileDialog2pre_built_superflow, topic= $topic\n");
		_user_built_flow_open_data_file();

		# Open pre-exiting user-built flow
	} elsif ( $topic eq $file_dialog_type->{_Flow} ) {

		# print("file_dialog, _set_FileDialog2user_built_flow ,dialog type:$topic\n");
		# print("file_dialog, _set_FileDialog2user_built_flow, flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");

		_user_built_flow_open_perl_file();

	} elsif ( $topic eq $file_dialog_type->{_Path} ) {

#		print("file_dialog,set_FileDialog2user_built_flow, topic= $topic\n");
		_user_built_flow_open_path();

		# Save a new user-built flow
	} elsif ( $topic eq $file_dialog_type->{_SaveAs} ) {

#		print("file_dialog, _set_FileDialog2user_built_flow ,dialog type:$topic\n");
		_user_built_flow_SaveAs_perl_file();

		#	} elsif ($topic eq 'Save') {
		#		_user_built_flow_save_perl_file();

	} else {

		#print("No bindings exist\n");
	}

	# print("file_dialog, End of _set_FileDialog2user_built_flow \n");
	return ();
}

sub _set_FileDialog2pre_built_superflow {
	my ($self) = @_;

	my $topic = _get_dialog_type();

	if ( $topic eq $file_dialog_type->{_Data_PL_SEISMIC} ) {

		# print("file_dialog,_set_FileDialog2pre_built_superflow, topic= $topic\n");
		_pre_built_superflow_open_data_file();

	} elsif ( $topic eq $file_dialog_type->{_Data} ) {

		# print("file_dialog,_set_FileDialog2pre_built_superflow, topic= $topic\n");
		_pre_built_superflow_open_data_file();

	} elsif ( $topic eq $file_dialog_type->{_Path} ) {

		# print("1. file_dialog,set_FileDialog2pre_built_superflow, topic= $topic\n");
		_pre_built_superflow_open_path();

	} elsif ( $topic eq $file_dialog_type->{_last_dir_in_path} ) {

		# print("2. file_dialog,set_FileDialog2pre_built_superflow, topic= $topic\n");
		_big_stream_last_dir_in_path();

	} elsif ( $topic eq $file_dialog_type->{_Flow} ) {

		# print("file_dialog,set_FileDialog2pre_built_superflow, not allowed \n");

		# NADA

	} elsif ( $topic eq $file_dialog_type->{_SaveAs} ) {

		# print("file_dialog,set_FileDialog2pre_built_superflow, not allowed \n");
		# _save_button('SaveAs');  superflow saves flow automatically and should not
		# require this option!  #NADA

	} else {
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

	} else {
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
	$gui_history->set4FileDialog_SaveAs_start();
	$file_dialog = $gui_history->get_hash_ref();

	# print("1. file_dialog, user_built_flow_SaveAs_perl_file _is_user_built_flow: $file_dialog->{_is_user_built_flow}\n");
	$decisions->set4FileDialog_SaveAs($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_SaveAs();

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

		my $whereami            = whereami->new();
		my $default_param_specs = $get->param();

		my @fields;
		my $full_path_name;

		# print ("file_dialog _user_built_flow_SaveAs_perl_file_user_built_flow_SaveAs_perl_file, _last_parameter_index_touched_color: $file_dialog->{_last_parameter_index_touched_color} \n");

		# make the file paths for the current file_dialog type ( Save, SaveAs, Flow, Data etc.)}
		_set_file_path();

		# collects the name of the data file to be opened
		_FileDialog();

		my $topic = $file_dialog->{_dialog_type};

		# print("file-dialog _user_built_flow_SaveAs_perl_file, file_dialog->{_dialog_type}: $topic\n");
		$full_path_name = $file_dialog->{_selected_file_name};

		# print("file-dialog _user_built_flow_SaveAs_perl_file, If not cancelled, full_path_name: $full_path_name\n");

		if ( length $full_path_name ) {

			@fields = split( /\//, $full_path_name );
			$file_dialog->{_is_selected_file_name} = $true;

			# print("file-dialog _user_built_flow_SaveAs_perl_file,file_dialog->{_is_selected_file_name}=$file_dialog->{_is_selected_file_name} \n");

		} else {

			# print("file_dialog, _user_built_flow_SaveAs_perl_file,Cancelled. No output flow name selected NADA\n");
		}

		my $first_idx = $default_param_specs->{_first_entry_idx};
		my $length    = $default_param_specs->{_length};

		# remove suffix (pl, su, txt ) from selected file name
		if ( defined $fields[-1]
			&& $fields[-1] ne $empty_string ) {

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

		} else {

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
	use L_SU_global_constants;

	my $control       = control->new();
	my $param_widgets = param_widgets->new();
	my $get           = L_SU_global_constants->new();
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

	} else {
		# print("file_dialog,_user_built_flow_close_data_file, Cancelled. No output flow name selected NADA\n");
	}

	# Open was used to open a data file
	# But now the _FileDialog is closing
	$decisions->set4FileDialog_select($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_select();
	#	print("1. file_dialog,_user_built_flow_close_data_file,pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		if ( $user_built_flow_open_data_widget_type  eq 'Entry' ) {

			$param_widgets->set_entry_button_chosen_widget($user_built_flow_open_data_selected_Entry_widget);

			# Need to set the length and first_idx either with the following
			# belos, or $param-widgets->set_length($file_dialog_length)
			$param_widgets->set_first_idx($first_idx);
			$param_widgets->set_length($length);

#			print("2. file_dialog  _user_built_flow_close_data_file, selected_Entry_widget: $user_built_flow_open_data_selected_Entry_widget\n");

			$file_dialog->{_parameter_value_index} = $user_built_flow_open_data_parameter_value_index;
			#$param_widgets->get_entry_button_chosen_index();
#			print(
#			"3. file_dialog,_user_built_flow_close_data_file, parameter_value_index= $user_built_flow_open_data_parameter_value_index\n");

			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();
#			print(
#				"5. file_dialog,_user_built_flow_close_data_file,entry_button_label = $file_dialog->{_entry_button_label}\n"
#			);

			# print("file_dialog,_user_built_flow_close_data_file, both flows and superflows require the following\n");
			my $current_index = $user_built_flow_open_data_parameter_value_index;
			
			# $file_dialog->{_parameter_value_index};

			# set index touched so that iFile can highlight the correct index
			# Also update the index touched so that the main program can update it later via _check4changes

			$file_dialog->{_last_parameter_index_touched_color} = $current_index;

#			print("file_dialog,_user_built_flow_close_data_file,Select,current parameter index $current_index\n");

			@{ $file_dialog->{_check_buttons_settings_aref} }[$current_index] = $on;

			if ( $file_dialog->{_selected_file_name} ) {

#				print("1. file_dialog,_user_built_flow_close_data_file, full name with suffix= $fields[-1]\n");

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

			} else {

				# print("file_dialog,user_built_flow_close_data_file No file was selected\n");
				# print("file_dialog,user_built_flow_close_data_file ,last path touched was
				# $file_dialog->{_last_path_touched}\n") ;
			}

			# only user-built flows require the following     TODO: what about {_is_flow_listbox_color_w} ?
			if (   $file_dialog->{_is_flow_listbox_grey_w}
				|| $file_dialog->{_is_flow_listbox_pink_w}
				|| $file_dialog->{_is_flow_listbox_green_w}
				|| $file_dialog->{_is_flow_listbox_blue_w}
				|| $file_dialog->{_is_flow_listbox_color_w} ) {

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

				# Here we update the value of the Entry widget (in GUI) with the selected file name
				# Now might be a good moment to update the parameter_widgets with the updated value
				# update endtry those parameters
				# my $selected_Entry_widget 				= $file_dialog->{_parameter_values_frame}->focusCurrent;
				# param_widgets							->set_entry_button_chosen_widget($selected_Entry_widget);
				# $file_dialog->{_parameter_value_index} 	= $param_widgets->get_entry_button_chosen_index();
				# $file_dialog->{_entry_button_label} 	= $param_widgets->get_label4entry_button_chosen();
				# my $current_index             			= $file_dialog->{_parameter_value_index};
				# $param_widgets							->redisplay_values();
				#
				# Make sure to place focus again on the updated widget so other modules can find the selection
				# $selected_Entry_widget 				->focus;  # from above

				# $file_dialog->{_values_aref} 					= $param_widgets	->get_values_aref();
				# print("file_dialog, _user_built_flow_close_data_file @{$file_dialog->{_values_aref}}[0]\n");
				# print("file_dialog, last_flow_listbox_touched_w: $file_dialog->{_last_flow_listbox_touched_w} \n");

				# highlight the last flow index touched
				# requires that we define the last_lisbtox_color_w in color_flow every time we call this Data
				# for now is too complitacted
				# $iFile->close($file_dialog);  # 7 used / in 38

			}
				
		} else {
			print("file_dialog,_pre-built_superflow_path no widget type selected \n");
			
		}    # widget of type = 'Entry'

		#$file_dialog->set4FileDialog_select_start(); #needed?
	}    # if prereq_OK

}

=head2  sub _user_built_flow_close_path

	if ($topic eq  'Path') {   
	Select was used to open a diretory path
	But now the _FileDialog is closing
		
=cut

sub _user_built_flow_close_path {
	my ($self) = @_;

	use decisions 1.00;
	use control;
	use whereami2;
	use L_SU_global_constants;

	my $control  = control->new();
	my $get      = L_SU_global_constants->new();
	my $whereami = whereami2->new();

	my @fields;
	my ( $full_path_name, $result );
	my $topic             = $file_dialog->{_dialog_type};
	my $last_path_touched = $file_dialog->{_last_path_touched};

	if ( defined $last_path_touched
		&& $last_path_touched ne $empty_string ) {

		$file_dialog->{_is_selected_path} = $true;

	} else {
		print("file_dialog, _user_built_flow_close_path, Cancelled. No path\n");
	}

	# open was used to open a path
	# But now the _FileDialog is closing
	$decisions->set4FileDialog_select($file_dialog);
	my $pre_req_ok = $decisions->get4FileDialog_select();

	# print("1. file_dialog,_user_built_flow_close_path,pre_req_ok= $pre_req_ok \n");

	if ($pre_req_ok) {

		my $widget_type = $whereami->widget_type( $file_dialog->{_parameter_values_frame} );
		print("file_dialog  _user_built_flow_close_path selected widget type is = $widget_type	\n");

		if ( defined( $file_dialog->{_last_path_touched} )
			and $file_dialog->{_last_path_touched} ne $empty_string ) {

			$result = $file_dialog->{_last_path_touched};    # no abbreviation
				# print("4. file_dialog,_user_built_flow_close_path,value that will be saved: $result\n");

		} else {
			print("file_dialog,_user_built_flow_close_path No path was selected\n");
		}

		# update the gui with the new path
		_set_selected_file_name($result);

		$gui_history->set4user_built_flow_close_path_end();
		$file_dialog = $gui_history->get_hash_ref();

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
	use param_widgets;

	my $control              = new control;
	my $file_dialog_messages = message_director->new();
	my $iFile                = new iFile;
	my $param_widgets        = param_widgets->new();

	my @fields;
	my $full_path_name;
	my $topic = $file_dialog->{_dialog_type};    # Should be Flow: Possibles are Data, Flow (open), SaveAs
	$full_path_name = $file_dialog->{_selected_file_name};

	if ($full_path_name) {

		@fields                                = split( /\//, $full_path_name );
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

		} else {

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
 	
 	TODO make sure that when a differently-colored flow is selected the updated widgets
 	are stored
 	
 			foreach my $key (sort keys %$file_dialog) {
           		print (" file_dialog,key is $key, value is $file_dialog->{$key}\n");
    		}
 	
=cut 

sub _user_built_flow_open_data_file {
	my ($self) = @_;

#	print("1. file_dialog,_user_built_flow_open_data_file\n ");
	use iFile;
	use whereami;

	# use param_widgets;
	use L_SU_global_constants;
	use param_widgets;

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
	$gui_history->set4FileDialog_open_start();

	$file_dialog = $gui_history->get_hash_ref();

	# if an appropriate entry widget is first selected, i.e., Entry
	# get index of entry button pressed
	# find out which entry button has been chosen
	# confirm that it IS the file button
	# TODO determine the required file type and file path
	# TODO from the *_spec.pm file for the particular program in the flow.

	$user_built_flow_open_data_widget_type = $whereami->widget_type( $file_dialog->{_parameter_values_frame} );

	if ( $user_built_flow_open_data_widget_type eq 'Entry' ) {  # for extra certainty

#		print("1. file_dialog,_user_built_flow_open_data_file, selected widget_type=$user_built_flow_open_data_widget_type \n");

		$user_built_flow_open_data_selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($user_built_flow_open_data_selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

#		print("2. file_dialog  _user_built_flow_open_data_file, selected_Entry_widget: $user_built_flow_open_data_selected_Entry_widget\n");
		$user_built_flow_open_data_parameter_value_index = $param_widgets->get_entry_button_chosen_index();
		$file_dialog->{_parameter_value_index} = $user_built_flow_open_data_parameter_value_index;
        my $index = $user_built_flow_open_data_parameter_value_index;
		# print("file_dialog,_user_built_flow_open_data_file,selection_Entry_widget HASH = $selected_Entry_widget\n");
#		print("file_dialog,_user_built_flow_open_data_file, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		if ( $index >= 0 ) {    # also for additional certainty

			# e.g. Data_Pl_SEISMIC, Data, Path, Flow etc.
			my $topic = _get_dialog_type();

#			print(
#				"4. file_dialog,_user_built_flow_open_data_file, parameter_value_index= $index\n"
#			);
  
			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

#			print("5. file_dialog,_user_built_flow_open_data_file,entry_button_label = $file_dialog->{_entry_button_label}\n");

			# use iFile to determine the correct data path (directory )
			$iFile->set_entry($file_dialog);
			$iFile->set_parameter_value_index($file_dialog);			
			$iFile->set_flow_type_h($file_dialog);    # user_built
			$iFile->set_dialog_type($topic);
			$iFile->set_values_aref($file_dialog);    # will determine the DIR based on type of data set
			$iFile->set_prog_name_sref($file_dialog);

			$file_dialog->{_path} = $iFile->get_Data_path();

#			print("5A. file_dialog,_user_built_flow_open_data_file $file_dialog->{_path}\n");

			# collects the name of the data file to be opened
			_FileDialog();
			_user_built_flow_close_data_file();
#			print("6. file_dialog,_user_built_flow_open_data_file End\n");

		}
	} elsif ( $user_built_flow_open_data_widget_type eq 'MainWindow' ) {    # opening a random file
			# print("file_dialog,_user_built_flow_open_data_file widget type is 'MainWindow' \n");
		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
		$file_dialog->{_message_w}->delete( "1.0", 'end' );
		$file_dialog->{_message_w}->insert( 'end', $message );

	} else {
		print("file_dialog,_user_built_flow_open_data_file no widget type selected \n");
	}

	$gui_history->set4FileDialog_open_end();

}

=head2  sub _user_built_flow_open_path
find and get a directory path

=cut 

sub _user_built_flow_open_path {

	my ($self) = @_;

	#	print("file_dialog, _user_built_flow_open_path\n ");
	use iFile;
	use whereami;
	use L_SU_global_constants;
	use param_widgets;

	my $param_widgets = param_widgets->new();
	my $get           = L_SU_global_constants->new();
	my $whereami      = whereami->new();
	my $iFile         = iFile->new();

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

	$gui_history->set_hash_ref($file_dialog);
	$gui_history->set4FileDialog_open_start();

	# $gui_history->set4superflow_open_path_start();
	$file_dialog = $gui_history->get_hash_ref();    # gets 93

	# If an appropriate Entry widget is first selected,
	# Find out which entry button has been chosen (index)
	# Confirm that it IS the file button

	# print("file_dialog,_user_built_flow_open_path,_FileDialog_button pressed, \n");
	# print("file_dialog, _user_built_flow_open_path selected  _values_aref=@{$file_dialog->{_values_aref}}\n");
	# print("file_dialog, _user_built_flow_open_path selected  _values_aref=@{$file_dialog->{_names_aref}}\n");
	# print("file_dialog  _user_built_flow_open_path selected  parameter_values_frame = $file_dialog->{_parameter_values_frame} \n");

	my $widget_type = $whereami->widget_type( $file_dialog->{_parameter_values_frame} );

	#	print("file_dialog  _user_built_flow_open_path selected widget type is = $widget_type	\n");

	if ( $widget_type eq 'Entry' ) {

		#		print("1. file_dialog,_user_built_flow_open_path, selected widget_type=$widget_type \n");

		my $selected_Entry_widget = $file_dialog->{_parameter_values_frame}->focusCurrent;
		$param_widgets->set_entry_button_chosen_widget($selected_Entry_widget);

		# Need to set the length and first_idx or, $param-widgets->set_length($file_dialog_length);
		# print("file_dialog,_user_built_flow_open_path,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_user_built_flow_open_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		$param_widgets->set_first_idx($first_idx);
		$param_widgets->set_length($length);

		#		print("2. file_dialog  _user_built_flow_open_path, selected_Entry_widget: $selected_Entry_widget\n");

		$file_dialog->{_parameter_value_index} = $param_widgets->get_entry_button_chosen_index();

		# print("file_dialog,_user_built_flow_open_path,selection_Entry_widget HASH = $selected_Entry_widget\n");
		# print("file_dialog,_user_built_flow_open_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n");

		if ( $file_dialog->{_parameter_value_index} >= 0 ) {    # for additional certainty; but is it needed?

			# e.g. Data_Pl_SEISMIC, Data, Path, Flow etc.
			my $topic = _get_dialog_type();

			#			print(
			#				"4. file_dialog,_user_built_flow_open_path, parameter_value_index= $file_dialog->{_parameter_value_index}\n"
			#			);
			$file_dialog->{_entry_button_label} = $param_widgets->get_label4entry_button_chosen();

			#			print(
			#				"5. file_dialog,_user_built_flow_open_path,entry_button_label = $file_dialog->{_entry_button_label}\n");

			# use iFile to determine the stored Path in the current configuration file
			$iFile->set_entry($file_dialog);          # selected entry label
			$iFile->set_flow_type_h($file_dialog);    # user_built

			$iFile->set_values_aref($file_dialog);   # will determine the DIR based on type of data set e.g., /home/gom/
			$iFile->set_prog_name_sref($file_dialog);    # e.g., Project_config
			$iFile->set_dialog_type($topic);             # e.g. Data_Pl_SEISMIC, _Data

			$file_dialog->{_path} = $iFile->get_Path();

			#			print("1.file_dialog,_user_built_open_flow_path, PATH:  $file_dialog->{_path} \n");
			#			print("1.file_dialog,_user_built_open_flow_path, _values_aref: @{$file_dialog->{_values_aref}}[0]\n");

			# open file dialog widget
			_FileDialog();

			# updates the gui
			_user_built_flow_close_path();

		}
	} elsif ( $widget_type eq 'MainWindow' ) {    # opening a random file
			#
			#		print("file_dialog,_user_built_flow_open_path widget type is 'MainWindow' \n");
			#		my $message = $file_dialog->{_message_w}->FileDialog_button(0);
			#		$file_dialog->{_message_w}->delete( "1.0", 'end' );
			#		$file_dialog->{_message_w}->insert( 'end', $message );
			#
	} else {
		print("file_dialog,_pre-built_superflow_path no widget type selected \n");
	}

}

=head2 sub _user_built_flow_open_perl_file 
			open flows written in Perl
			
foreach my $key (sort keys %$file_dialog) {
print (" file_dialog,key is $key, value is $file_dialog->{$key}\n");
}		
			
=cut

sub _user_built_flow_open_perl_file {
	my ($self) = @_;

	# print("file_dialog,_user_built_flow_open_perl_file\n ");
	use iFile;
	use whereami;

	use L_SU_global_constants;
	use message_director;
	use param_widgets;

	my $param_widgets           = param_widgets->new();
	my $get                     = L_SU_global_constants->new();
	my $whereami                = whereami->new();
	my $iFile                   = iFile->new();
	my $open_perl_file_messages = message_director->new();

	my $default_param_specs = $get->param();
	my $first_idx           = $default_param_specs->{_first_entry_idx};
	my $length              = $default_param_specs->{_length};

	$gui_history->set_hash_ref($file_dialog);
	$gui_history->set4FileDialog_open_perl_file_start();
	$file_dialog = $gui_history->get_hash_ref();

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
	$file_dialog->{_path} = $iFile->get_Open_perl_flow_path();

	# print("file_dialog,_user_built_flow_open_perl_file, path = $file_dialog->{_path}\n");

	# collects the name of the data file to be opened
	_FileDialog();    # directory mega widget
	my $successful = _user_built_flow_close_perl_file();

	$gui_history->set_hash_ref($file_dialog);
	$gui_history->set4FileDialog_open_perl_file_end();

	$file_dialog = $gui_history->get_hash_ref();

	# print (" file_dialog,_user_built_flow_open_perl_file, print gui_history.txt\n");
	# $gui_history->view();

	#	print("1. file_dialog,_user_built_flow_open_perl_file,_flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");

}

=head2 get_selected_Entry_widget

=cut

sub get_selected_Entry_widget {
	
	my ($self) = @_;
	my $result;
	
	if (length $user_built_flow_open_data_selected_Entry_widget) {

		$result = $user_built_flow_open_data_selected_Entry_widget;
		
	} else {
		print("file_dialog, get_selected_Entry_widget, unexpected value\n");
	}
	
	return($result);
}

=head2 get_current_index

=cut

sub get_current_index {
	
	my ($self) = @_;
	my $result;
	
	if (length $user_built_flow_open_data_parameter_value_index ) {
		
		$result = $user_built_flow_open_data_parameter_value_index;
		
	} else {
		print("file_dialog, get_current_index, unexpected value\n");
	}
	
	return($result);
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

	} else {
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

	} else {
		print("file_dialog,get_hash_ref, missing hash ref\n");
	}

	# print("file_dialog,_update_hash_ref: $gui_history->get_defaults()\n");
}

=head2 sub get_perl_flow_name_in


=cut 

sub get_perl_flow_name_in {
	my ($self) = @_;

	if ( $file_dialog->{_flow_name_in} ) {

		my $perl_flow_name_in = $file_dialog->{_flow_name_in};

		# print("file_dialog,get_flow_name_in, _flow_name_in: $file_dialog->{_flow_name_in}\n");
		return ($perl_flow_name_in);

	} else {

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

	} else {

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

	} else {

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
		&& $file_dialog->{_selected_file_name} ne $empty_string ) {

		my $result = $file_dialog->{_selected_file_name};
		return ($result);

	} else {

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

	} else {
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

		#        print("file_dialog, set_dialog_type  is $file_dialog->{_dialog_type}\n");

	} else {
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

	} else {
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

	} else {
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

	} else {
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

		# print("1. file_dialog, set_hash_ref,output gui history\n");
		# $gui_history->view();
		# print("param_widgets_color,_update_hash_ref: $gui_history->get_defaults()\n");
	}

	return ();
}

sub FileDialog_director {
	my ($self) = @_;

	# print("1. file_dialog, FileDialog_director, flowNsuperflow_name_w:$file_dialog->{_flowNsuperflow_name_w} \n");

	my $file_dialog_flow_type = _get_flow_type();

	# print("file_dialog, FileDialog_director, flow_type:$file_dialog_flow_type\n");

	if ( $file_dialog_flow_type eq $flow_type_h->{_user_built} ) {

		# print("file_dialog, FileDialog_director, should be user_built_flow_type:$file_dialog_flow_type\n");

		_set_FileDialog2user_built_flow();

	} elsif ( $file_dialog_flow_type eq $flow_type_h->{_pre_built_superflow} ) {

		# print("file_dialog, FileDialog_director, should be superflow_type:$file_dialog_flow_type\n");

		_set_FileDialog2pre_built_superflow();

	} else {
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

	} else {
		print("file_dialog, set_FileDialog_button_sub_ref, missing sub ref\n");
	}

	return ();
}

1;
