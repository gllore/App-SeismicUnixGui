package pre_built_big_stream;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: pre_built_superflow
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 19 2018 

 DESCRIPTION 
     
 BASED ON:
 previous versions of the main L_SU.pm V0.1.1
  
=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 During refactoring of 2017 V 0.1.0 L_SU.pl

=cut

use Moose;
our $VERSION = '0.1.0';

extends 'gui_history' => { -version => 0.0.2 };

my $pre_built_big_stream_href_sub_ref;    # $pre_built_big_stream_href->{_sub_ref} does not transfer in namespace between subs

# potentially in all packages
use L_SU_global_constants;
use message_director;
use whereami;
use param_widgets4pre_built_streams;

=head2 Instantiation

=cut

# my $conditions4big_streams = conditions4big_streams->new();
my $get 					= L_SU_global_constants->new();
my $param_widgets 			= param_widgets4pre_built_streams->new();
my $whereami      			= whereami->new();
my $gui_history  			= gui_history->new();
my $pre_built_big_stream_href = $gui_history->get_defaults();


=head2

 share the following parameters in same name 
 space

=cut

my $message_w;
my ($values_aref,$names_aref,$check_buttons_settings_aref);

=head2 sub get_hash_ref

	return ALL values of the private hash, supposedly
	improtant external widgets have not been reset.. only conditions
	are reset
	TODO: perhaps it is better to have a specific method
		to return one specific widget address at a time?
	}	
		foreach my $key (sort keys %$pre_built_big_stream_href) {
         print (" pre_built_superflow,key is $key, value is $pre_built_big_stream_href->{$key}\n");
      }
	
	104
	 
=cut

sub get_hash_ref {
    my ($self) = @_;

    if ($pre_built_big_stream_href) {
        # print("pre_built_big_stream, get_hash_ref ,values_aref=@{$values_aref}\n");
        # print("pre_built_big_stream, get_hash_ref ,check_buttons_settings_aref=@{$check_buttons_settings_aref}\n");

        return ($pre_built_big_stream_href);

    }
    else {
        print("superflow, get_hash_ref , missing superflow hash_ref\n");
    }
}

=head2 sub set_flowNsuperflow_name_w

=cut

sub set_flowNsuperflow_name_w {

    my ( $self, $flowNsuperflow_name_w ) = @_;

    if ($flowNsuperflow_name_w) {

        $pre_built_big_stream_href->{_flowNsuperflow_name_w} = $flowNsuperflow_name_w;

        if ( $pre_built_big_stream_href->{_prog_name_sref} ) {    # previously loaded

            my $flowNsuperflow_name = ${ $pre_built_big_stream_href->{_prog_name_sref} };
            $flowNsuperflow_name_w->configure( -text => $flowNsuperflow_name, );
        }
        else {
            print( "pre_built_big_stream, set_flowNsuperflow_name_w, missing widget name\n" );
        }

    }
    else {
        print( "pre_built_big_stream, set_flowNsuperflow_name_w, missing program name\n" );
    }

    return ();
}



=head2 sub select

 chosen big stream
 displays the parameter names and their values
 but does not write them to a file
   	
 foreach my $key (sort keys %$pre_built_big_stream_href) {
         print (" pre_built_superflow,key is $key, value is $pre_built_big_stream_href->{$key}\n");
 }
 
=cut

sub select {
    my ($self) = @_;

    use binding;
    use name;
    use config_superflows;

    my $binding            				= binding->new();
    my $name               				= name->new();
    my $pre_built_big_stream_messages 	= message_director->new();
    my $config_superflows  				= config_superflows->new();
    my $Project            				= 'Project';

    my $prog_name_sref = $pre_built_big_stream_href->{_prog_name_sref};

    # print("1. pre_built_superflow,select,prog=${$pre_built_big_stream_href->{_prog_name_sref}}\n");
    my $message = $pre_built_big_stream_messages->null_button(0);

    # print("pre_built_big_stream,select,message_w:$pre_built_big_stream_href->{_message_w}\n");
    $message_w->delete( "1.0", 'end' );
    $message_w->insert( 'end', $message );

    # print("1. pre_built_superflow,select,should be NO values=@{$pre_built_big_stream_href->{_values_aref}}\n");
    # local location within GUI
    # gui_history->set_gui_widgets($pre_built_big_stream_href);  
    gui_history->set_hash_ref($pre_built_big_stream_href); 
    gui_history->set4start_of_superflow_select(); 
    $pre_built_big_stream_href = gui_history->get_hash_ref(); 

    # print("pre_built_big_stream,select,_is_pre_built_superflow: $pre_built_big_stream_href->{_is_pre_built_superflow}\n");
    # print("pre_built_big_stream,select,_flow_type: $pre_built_big_stream_href->{_flow_type}\n");
    # set location in gui
    $whereami->set4superflow_select_button();

    # print("1. pre_built_superflow,_is_superflow_select_button,$pre_built_big_stream_href->{_is_superflow_select_button}\n");
    $config_superflows->set_program_name($prog_name_sref);        # gets 1
    $config_superflows->set_prog_name_config($prog_name_sref);    # gets 1
    my $prog_name_config = $config_superflows->get_prog_name_config();    # gets 1

    # case for Project.config
    if ( $prog_name_config eq $Project . '.config' ) {

        use L_SU_local_user_constants;
        my $user_constants = L_SU_local_user_constants->new();

        if ( $user_constants->user_configuration_Project_config_exists() ) {
            # read active configuration file

        }
        elsif ( not $user_constants->user_configuration_Project_config_exists ) {

            # need to tell the user that they have to go back and create a Project
            my $message = $pre_built_big_stream_messages->superflow(0);
            $pre_built_big_stream_href->{_message_w}->delete( "1.0", 'end' );
            $pre_built_big_stream_href->{_message_w}->insert( 'end', $message );

            # print("pre_built_big_stream,superflow_select,prog_name_config = $prog_name_config\n");

        }
        else {
            print("pre_built_big_stream,superflow_select, bad file name\n");
        }

        # Case for any OTHER superflow
    }
    else {
        $config_superflows->inbound();
        $config_superflows->check2read();
    }

    # parameter names from superflow configuration file
    $pre_built_big_stream_href->{_names_aref} = $config_superflows->get_names();

    # print("pre_built_big_stream,superflow_select,parameter labels=@{$pre_built_big_stream_href->{_names_aref}}\n");

    # parameter values from superflow configuration file
    $pre_built_big_stream_href->{_values_aref} = $config_superflows->get_values();

    # print("2. pre_built_superflow,select,values=@{$pre_built_big_stream_href->{_values_aref}}\n");
    # print("3. pre_built_superflow,_is_superflow_select,$pre_built_big_stream_href->{_is_superflow_select_button}\n");

    $pre_built_big_stream_href->{_check_buttons_settings_aref} = $config_superflows->get_check_buttons_settings();

    # print("1 pre_built_superflow,superflow_select,chkb=@{$pre_built_big_stream_href->{_check_buttons_settings_aref}}\n");

    $pre_built_big_stream_href->{_superflow_first_idx} = $config_superflows->first_idx();
    $pre_built_big_stream_href->{_superflow_length}    = $config_superflows->length();

    # print("4. pre_built_superflow,_is_superflow_select,$pre_built_big_stream_href->{_is_superflow_select_button}\n");
    # Blank out all the widget parameter names and their values
    # print("3. pre_built_superflow,select,values=@{$pre_built_big_stream_href->{_values_aref}}\n");
    # print("3. pre_built_superflow,length,values=@{$pre_built_big_stream_href->{_values_aref}}\n");
    # print("pre_built_big_stream,length = maximum default! $pre_built_big_stream_href->{_superflow_length}\n");
    my $here = $whereami->get4superflow_select_button();

    # $param_widgets->set_location_in_gui($here);

    # widgets initialized in a super class
    #$param_widgets		->set_labels_w_aref($pre_built_big_stream_href->{_labels_w_aref} );
    #$param_widgets		->set_values_w_aref($pre_built_big_stream_href->{_values_w_aref} );
    #$param_widgets		->set_check_buttons_w_aref($pre_built_big_stream_href->{_check_buttons_w_aref} );
    # print("5. pre_built_superflow,_is_superflow_select,$pre_built_big_stream_href->{_is_superflow_select_button}\n");
    $param_widgets->gui_full_clear();

    # print("6. pre_built_superflow,_is_superflow_select_button,$pre_built_big_stream_href->{_is_superflow_select_button}\n");
    $param_widgets->range($pre_built_big_stream_href);
    $param_widgets->set_labels( $pre_built_big_stream_href->{_names_aref} );
    $param_widgets->set_values( $pre_built_big_stream_href->{_values_aref} );
    $param_widgets->set_check_buttons( $pre_built_big_stream_href->{_check_buttons_settings_aref} );
    $param_widgets->set_current_program($prog_name_sref);

    $param_widgets->redisplay_labels();
    $param_widgets->redisplay_values();
    $param_widgets->redisplay_check_buttons();

    # print("2 pre_built_superflow,superflow_select,chkb=@{$pre_built_big_stream_href->{_check_buttons_settings_aref}}\n");
    # put focus on first entry widget in new value and paramter list
    my @Entry_widget = @{ $param_widgets->get_values_w_aref() };

    # print("L_SU,flow_select,Entry_widgets@Entry_widget\n");
    $Entry_widget[0]->focus;

    # print("3 pre_built_superflow,superflow_select,chkb=@{$pre_built_big_stream_href->{_check_buttons_settings_aref}}\n");
    # Here is where you rebind the different buttons depending on the
    # program name that is selected (i.e. through spec.pm)
    # send superflow names through an alias filter
    # that links their GUI name to their program name
    # e.g. iVelAnalysis (GUI) is actually IVA.pm (shortened)

    my $run_name = $name->get_alias_superflow_names($prog_name_sref);

    # print("pre_built_big_stream,select,run_name: $run_name\n");

    $binding->set_prog_name_sref( \$run_name );
    $binding->set_values_w_aref( $param_widgets->get_values_w_aref );

    # print("pre_built_big_stream, select sub_ref: $pre_built_big_stream_href_sub_ref\n");
    $binding->setFileDialog_button_sub_ref($pre_built_big_stream_href_sub_ref);
    $binding->set();

    # print("4 pre_built_superflow,superflow_select,chkb=@{$pre_built_big_stream_href->{_check_buttons_settings_aref}}\n");

    # in order to export this private hash we need to send if back via a private variable
    # values_aref that will be assigned in pre_built_superflow, get_hash_ref.
    $values_aref = $pre_built_big_stream_href->{_values_aref};

    # print("4. pre_built_superflow,select,values=@{$pre_built_big_stream_href->{_values_aref}}\n");

    # gui_history->set_gui_widgets($pre_built_big_stream_href);      # sets 25 / given 103
    gui_history->set_hash_ref($pre_built_big_stream_href);         # sets 49 / given 103
    gui_history->set4end_of_superflow_select();    # sets 3; sets gui_widgets
    $pre_built_big_stream_href = gui_history->get_hash_ref();      # returns 98 !
                                                       # print("6. pre_built_superflow,_is_superflow_select,$pre_built_big_stream_href->{_is_superflow_select_button}\n");

    # for export via get_hash_ref
    # $pre_built_big_stream_href_first_idx  	 			= $config_superflows->first_idx();
    # $pre_built_big_stream_href_length  	     			= $config_superflows->length();
    $names_aref                  = $pre_built_big_stream_href->{_names_aref};
    $values_aref                 = $pre_built_big_stream_href->{_values_aref};
    $check_buttons_settings_aref = $pre_built_big_stream_href->{_check_buttons_settings_aref};

    # print("5 pre_built_superflow,superflow_select,chkb=@{$pre_built_big_stream_href->{_check_buttons_settings_aref}}\n");
    # print("5 pre_built_superflow,superflow_select,values=@{$pre_built_big_stream_href->{_values_aref}}\n");

}

#=head2 sub set_gui_widgets
#
#	bring it important widget addresses
#	
#	26 and 26
#	
#=cut
#
#sub set_gui_widgets {
#    my ( $self, $widget_hash_ref ) = @_;
#
#    if ($widget_hash_ref) {
#
#        $pre_built_big_stream_href->{_Data_menubutton}             = $widget_hash_ref->{_Data_menubutton};
#        $pre_built_big_stream_href->{_Flow_menubutton}             = $widget_hash_ref->{_Flow_menubutton};
#        $pre_built_big_stream_href->{_SaveAs_menubutton}           = $widget_hash_ref->{_SaveAs_menubutton};
#        $pre_built_big_stream_href->{_add2flow_button_grey}        = $widget_hash_ref->{_add2flow_button_grey};
#        $pre_built_big_stream_href->{_add2flow_button_pink}        = $widget_hash_ref->{_add2flow_button_pink};
#        $pre_built_big_stream_href->{_add2flow_button_green}       = $widget_hash_ref->{_add2flow_button_green};
#        $pre_built_big_stream_href->{_add2flow_button_blue}        = $widget_hash_ref->{_add2flow_button_blue};
#        $pre_built_big_stream_href->{_check_buttons_w_aref}        = $widget_hash_ref->{_check_buttons_w_aref};
#        $pre_built_big_stream_href->{_check_code_button}           = $widget_hash_ref->{_check_code_button};
#        $pre_built_big_stream_href->{_delete_from_flow_button}     = $widget_hash_ref->{_delete_from_flow_button};
#        $pre_built_big_stream_href->{_file_menubutton}             = $widget_hash_ref->{_file_menubutton};
#        $pre_built_big_stream_href->{_flowNsuperflow_name_w}       = $widget_hash_ref->{_flowNsuperflow_name_w};
#        $pre_built_big_stream_href->{_flow_item_down_arrow_button} = $widget_hash_ref->{_flow_item_down_arrow_button};
#        $pre_built_big_stream_href->{_flow_item_up_arrow_button}   = $widget_hash_ref->{_flow_item_up_arrow_button};
#        $pre_built_big_stream_href->{_flow_listbox_grey_w}         = $widget_hash_ref->{_flow_listbox_grey_w};
#        $pre_built_big_stream_href->{_flow_listbox_pink_w}         = $widget_hash_ref->{_flow_listbox_pink_w};
#        $pre_built_big_stream_href->{_flow_listbox_green_w}        = $widget_hash_ref->{_flow_listbox_green_w};
#        $pre_built_big_stream_href->{_flow_listbox_blue_w}         = $widget_hash_ref->{_flow_listbox_blue_w};
#        $pre_built_big_stream_href->{_flow_listbox_color_w}        = $widget_hash_ref->{_flow_listbox_color_w};
#        $pre_built_big_stream_href->{_labels_w_aref}               = $widget_hash_ref->{_labels_w_aref};
#        $pre_built_big_stream_href->{_message_w}                   = $widget_hash_ref->{_message_w};
#        $pre_built_big_stream_href->{_mw}                          = $widget_hash_ref->{_mw};
#        $pre_built_big_stream_href->{_parameter_values_frame}      = $widget_hash_ref->{_parameter_values_frame};
#        $pre_built_big_stream_href->{_run_button}                  = $widget_hash_ref->{_run_button};
#        $pre_built_big_stream_href->{_save_button}                 = $widget_hash_ref->{_save_button};
#        $pre_built_big_stream_href->{_values_w_aref}               = $widget_hash_ref->{_values_w_aref};

        # $Data_menubutton             = $pre_built_big_stream_href->{_Data_menubutton};
        # $Flow_menubutton             = $pre_built_big_stream_href->{_Flow_menubutton};
        # $SaveAs_menubutton           = $pre_built_big_stream_href->{_SaveAs_menubutton};
#        $add2flow_button_grey        = $pre_built_big_stream_href->{_add2flow_button_grey};
#        $add2flow_button_pink        = $pre_built_big_stream_href->{_add2flow_button_pink};
#        $add2flow_button_green       = $pre_built_big_stream_href->{_add2flow_button_green};
#        $add2flow_button_blue        = $pre_built_big_stream_href->{_add2flow_button_blue};
#        $check_buttons_w_aref        = $pre_built_big_stream_href->{_check_buttons_w_aref};
#        $check_code_button           = $pre_built_big_stream_href->{_check_code_button};
#        $delete_from_flow_button     = $pre_built_big_stream_href->{_delete_from_flow_button};
#        $file_menubutton             = $pre_built_big_stream_href->{_file_menubutton};
#        $flowNsuperflow_name_w       = $pre_built_big_stream_href->{_flowNsuperflow_name_w};
#        $flow_item_down_arrow_button = $pre_built_big_stream_href->{_flow_item_down_arrow_button};
#        $flow_item_up_arrow_button   = $pre_built_big_stream_href->{_flow_item_up_arrow_button};
#        $flow_listbox_grey_w         = $pre_built_big_stream_href->{_flow_listbox_grey_w};
#        $flow_listbox_pink_w         = $pre_built_big_stream_href->{_flow_listbox_pink_w};
#        $flow_listbox_green_w        = $pre_built_big_stream_href->{_flow_listbox_green_w};
#        $flow_listbox_blue_w         = $pre_built_big_stream_href->{_flow_listbox_blue_w};
#        $flow_listbox_color_w        = $pre_built_big_stream_href->{_flow_listbox_color_w};
#        $labels_w_aref               = $pre_built_big_stream_href->{_labels_w_aref};
#        $message_w                   = $pre_built_big_stream_href->{_message_w};
#        $mw                          = $pre_built_big_stream_href->{_mw};
#        $parameter_values_frame      = $pre_built_big_stream_href->{_parameter_values_frame};
#        $run_button                  = $pre_built_big_stream_href->{_run_button};
#        $save_button                 = $pre_built_big_stream_href->{_save_button};
#        $values_w_aref               = $pre_built_big_stream_href->{_values_w_aref};
#
#        # print("superflow, set_gui_widgets , superflow->{_delete_from_flow_button: $pre_built_big_stream_href->{_delete_from_flow_button}\n");
#
#    }
#    else {
#
#        print("superflow, set_gui_widgets , missing hash_ref\n");
#    }
#    return ();
#}


=cut


=head2 sub set_hash_ref 

	imports external hash into private settings
	print(" pre_built_big_stream,set_hash_refderefed _prog_name_sref: ${$pre_built_big_stream_href->{_prog_name_sref}}\n");	 	 	 
 
  78 off, 78 off
  new variables are created with abbreviated names out of convenience
  
=cut

sub set_hash_ref {

    my ( $self, $hash_ref ) = @_;
	
	$gui_history->set_defaults($hash_ref);
	$pre_built_big_stream_href = $gui_history->get_defaults();
	
	# set up param_widgets for later use
	# give param_widgets the needed values
	$param_widgets->set_hash_ref($pre_built_big_stream_href);
	$message_w     = $pre_built_big_stream_href->{_message_w};
	
	# print("pre_built_big_stream, set_hash_ref, print gui_history.txt\n");
	# $gui_history->view();

#    $check_buttons_settings_aref           = $hash_ref->{_check_buttons_settings_aref};
#    $dialog_type                           = $hash_ref->{_dialog_type};
#    $dnd_token_grey                        = $hash_ref->{_dnd_token_grey};
#    $dnd_token_pink                        = $hash_ref->{_dnd_token_pink};
#    $dnd_token_green                       = $hash_ref->{_dnd_token_green};
#    $dnd_token_blue                        = $hash_ref->{_dnd_token_blue};                          #12
#    $dropsite_token_grey                   = $hash_ref->{_dropsite_token_grey};
#    $dropsite_token_pink                   = $hash_ref->{_dropsite_token_pink};
#    $dropsite_token_green                  = $hash_ref->{_dropsite_token_green};
#    $dropsite_token_blue                   = $hash_ref->{_dropsite_token_blue};                     #16
#    $flow_color                            = $hash_ref->{_flow_color};                              #18
#    $flow_name_in                          = $hash_ref->{_flow_name_in};
#    $flow_name_out                         = $hash_ref->{_flow_name_out};
#    $flow_type                             = $hash_ref->{_flow_type};                               #28
#    $flow_widget_index                     = $hash_ref->{_flow_widget_index};                       #29
#    $gui_history_ref                       = $hash_ref->{_gui_history_ref};
#    $has_used_check_code_button            = $hash_ref->{_has_used_check_code_button};
#    $has_used_run_button                   = $hash_ref->{_has_used_run_button};                     #31
#    $has_used_SaveAs_button                = $hash_ref->{_has_used_SaveAs_button};
#    $has_used_Save_button                  = $hash_ref->{_has_used_Save_button};                    #33
#    $has_used_Save_superflow               = $hash_ref->{_has_used_Save_superflow};
#    $has_used_open_perl_file_button        = $hash_ref->{_has_used_open_perl_file_button};
#    $is_add2flow                           = $hash_ref->{_is_add2flow};
#    $index2move                            = $hash_ref->{_index2move};
#    $is_add2flow_button                    = $hash_ref->{_is_add2flow_button};
#    $is_check_code_button                  = $hash_ref->{_is_check_code_button};
#    $is_delete_from_flow_button            = $hash_ref->{_is_delete_from_flow_button};
#    $is_dragNdrop                          = $hash_ref->{_is_dragNdrop};                            #37
#    $is_flow_item_up_arrow_button          = $hash_ref->{_is_flow_item_up_arrow_button};
#    $is_flow_item_down_arrow_button        = $hash_ref->{_is_flow_item_down_arrow_button};
#    $is_flow_listbox_grey_w                = $hash_ref->{_is_flow_listbox_grey_w};
#    $is_flow_listbox_pink_w                = $hash_ref->{_is_flow_listbox_pink_w};
#    $is_flow_listbox_green_w               = $hash_ref->{_is_flow_listbox_green_w};
#    $is_flow_listbox_blue_w                = $hash_ref->{_is_flow_listbox_blue_w};
#    $is_flow_listbox_color_w               = $hash_ref->{_is_flow_listbox_color_w};                 #44
#    $is_last_flow_index_touched_grey       = $hash_ref->{_is_last_flow_index_touched_grey};
#    $is_last_flow_index_touched_pink       = $hash_ref->{_is_last_flow_index_touched_pink};
#    $is_last_flow_index_touched_green      = $hash_ref->{_is_last_flow_index_touched_green};
#    $is_last_flow_index_touched_blue       = $hash_ref->{_is_last_flow_index_touched_blue};
#    $is_last_parameter_index_touched_grey  = $hash_ref->{_is_last_parameter_index_touched_grey};
#    $is_last_parameter_index_touched_pink  = $hash_ref->{_is_last_parameter_index_touched_pink};
#    $is_last_parameter_index_touched_green = $hash_ref->{_is_last_parameter_index_touched_green};
#    $is_last_parameter_index_touched_blue  = $hash_ref->{_is_last_parameter_index_touched_blue};
#    $is_last_flow_index_touched            = $hash_ref->{_is_last_flow_index_touched};
#    $is_last_parameter_index_touched       = $hash_ref->{_is_last_parameter_index_touched};         #46
#    $is_moveNdrop_in_flow                  = $hash_ref->{_is_moveNdrop_in_flow};
#    $is_new_listbox_selection              = $hash_ref->{_is_new_listbox_selection};                #48
#    $is_open_file_button                   = $hash_ref->{_is_open_file_button};
#    $is_pre_built_superflow                = $hash_ref->{_is_pre_built_superflow};                  #50
#    $is_prog_name                          = $hash_ref->{_is_prog_name};
#    $is_run_button                         = $hash_ref->{_is_run_button};
#    $is_select_file_button                 = $hash_ref->{_is_select_file_button};                   #52
#    $is_selected_file_name                 = $hash_ref->{_is_selected_file_name};
#    $is_selected_path                      = $hash_ref->{_is_selected_path};
#    $is_Save_button                        = $hash_ref->{_is_Save_button};
#    $is_SaveAs_button                      = $hash_ref->{_is_SaveAs_button};
#    $is_SaveAs_file_button                 = $hash_ref->{_is_SaveAs_file_button};                   #55
#    $is_sunix_listbox                      = $hash_ref->{_is_sunix_listbox};                        #56
#    $is_superflow_select_button            = $hash_ref->{_is_superflow_select_button};
#    $is_superflow                          = $hash_ref->{_is_superflow};                            #58
#    $is_user_built_flow                    = $hash_ref->{_is_user_built_flow};                      #59
#    $last_flow_index_touched_grey          = $hash_ref->{_last_flow_index_touched_grey};
#    $last_flow_index_touched_pink          = $hash_ref->{_last_flow_index_touched_pink};
#    $last_flow_index_touched_green         = $hash_ref->{_last_flow_index_touched_green};
#    $last_flow_index_touched_blue          = $hash_ref->{_last_flow_index_touched_blue};
#    $last_flow_index_touched               = $hash_ref->{_last_flow_index_touched};
#    $last_flow_listbox_touched             = $hash_ref->{_last_flow_listbox_touched};
#    $last_flow_listbox_touched_w           = $hash_ref->{_last_flow_listbox_touched_w};
#    $last_parameter_index_touched_grey     = $hash_ref->{_last_parameter_index_touched_grey};       #64
#    $last_parameter_index_touched_pink     = $hash_ref->{_last_parameter_index_touched_pink};       #64
#    $last_parameter_index_touched_green    = $hash_ref->{_last_parameter_index_touched_green};      #64
#    $last_parameter_index_touched_blue     = $hash_ref->{_last_parameter_index_touched_blue};       #64
#    $last_parameter_index_touched          = $hash_ref->{_last_parameter_index_touched};            #64
#    $names_aref                            = $hash_ref->{_names_aref};
#    $parameter_value_index                 = $hash_ref->{_parameter_value_index};
#    $path                                  = $hash_ref->{_path};
#    $prog_name_sref                        = $hash_ref->{_prog_name_sref};
#    $selected_file_name                    = $hash_ref->{_selected_file_name};
#    $sub_ref                               = $hash_ref->{_sub_ref};
#    $values_aref                           = $hash_ref->{_values_aref};
#
#    $pre_built_big_stream_href->{_check_buttons_settings_aref}           = $hash_ref->{_check_buttons_settings_aref};
#    $pre_built_big_stream_href->{_dialog_type}                           = $hash_ref->{_dialog_type};
#    $pre_built_big_stream_href->{_dnd_token_grey}                        = $hash_ref->{_dnd_token_grey};
#    $pre_built_big_stream_href->{_dnd_token_pink}                        = $hash_ref->{_dnd_token_pink};
#    $pre_built_big_stream_href->{_dnd_token_green}                       = $hash_ref->{_dnd_token_green};
#    $pre_built_big_stream_href->{_dnd_token_blue}                        = $hash_ref->{_dnd_token_blue};                          #12
#    $pre_built_big_stream_href->{_dropsite_token_grey}                   = $hash_ref->{_dropsite_token_grey};
#    $pre_built_big_stream_href->{_dropsite_token_pink}                   = $hash_ref->{_dropsite_token_pink};
#    $pre_built_big_stream_href->{_dropsite_token_green}                  = $hash_ref->{_dropsite_token_green};
#    $pre_built_big_stream_href->{_dropsite_token_blue}                   = $hash_ref->{_dropsite_token_blue};                     #16
#    $pre_built_big_stream_href->{_flow_color}                            = $hash_ref->{_flow_color};                              #18
#    $pre_built_big_stream_href->{_flow_name_in}                          = $hash_ref->{_flow_name_in};
#    $pre_built_big_stream_href->{_flow_name_out}                         = $hash_ref->{_flow_name_out};
#    $pre_built_big_stream_href->{_flow_type}                             = $hash_ref->{_flow_type};
#    $pre_built_big_stream_href->{_flow_widget_index}                     = $hash_ref->{_flow_widget_index};
#    $pre_built_big_stream_href->{_gui_history_ref}                       = $hash_ref->{_gui_history_ref};
#    $pre_built_big_stream_href->{_has_used_check_code_button}            = $hash_ref->{_has_used_check_code_button};
#    $pre_built_big_stream_href->{_has_used_run_button}                   = $hash_ref->{_has_used_run_button};
#    $pre_built_big_stream_href->{_has_used_SaveAs_button}                = $hash_ref->{_has_used_SaveAs_button};
#    $pre_built_big_stream_href->{_has_used_Save_button}                  = $hash_ref->{_has_used_Save_button};
#    $pre_built_big_stream_href->{_has_used_Save_superflow}               = $hash_ref->{_has_used_Save_superflow};
#    $pre_built_big_stream_href->{_has_used_open_perl_file_button}        = $hash_ref->{_has_used_open_perl_file_button};
#    $pre_built_big_stream_href->{_is_add2flow}                           = $hash_ref->{_is_add2flow};
#    $pre_built_big_stream_href->{_index2move}                            = $hash_ref->{_index2move};
#    $pre_built_big_stream_href->{_is_add2flow_button}                    = $hash_ref->{_is_add2flow_button};
#    $pre_built_big_stream_href->{_is_check_code_button}                  = $hash_ref->{_is_check_code_button};
#    $pre_built_big_stream_href->{_is_delete_from_flow_button}            = $hash_ref->{_is_delete_from_flow_button};
#    $pre_built_big_stream_href->{_is_dragNdrop}                          = $hash_ref->{_is_dragNdrop};
#    $pre_built_big_stream_href->{_is_flow_item_up_arrow_button}          = $hash_ref->{_is_flow_item_up_arrow_button};
#    $pre_built_big_stream_href->{_is_flow_item_down_arrow_button}        = $hash_ref->{_is_flow_item_down_arrow_button};
#    $pre_built_big_stream_href->{_is_flow_listbox_grey_w}                = $hash_ref->{_is_flow_listbox_grey_w};
#    $pre_built_big_stream_href->{_is_flow_listbox_pink_w}                = $hash_ref->{_is_flow_listbox_pink_w};
#    $pre_built_big_stream_href->{_is_flow_listbox_green_w}               = $hash_ref->{_is_flow_listbox_green_w};
#    $pre_built_big_stream_href->{_is_flow_listbox_blue_w}                = $hash_ref->{_is_flow_listbox_blue_w};
#    $pre_built_big_stream_href->{_is_flow_listbox_color_w}               = $hash_ref->{_is_flow_listbox_color_w};                 #44
#    $pre_built_big_stream_href->{_is_last_flow_index_touched_grey}       = $hash_ref->{_is_last_flow_index_touched_grey};
#    $pre_built_big_stream_href->{_is_last_flow_index_touched_pink}       = $hash_ref->{_is_last_flow_index_touched_pink};
#    $pre_built_big_stream_href->{_is_last_flow_index_touched_green}      = $hash_ref->{_is_last_flow_index_touched_green};
#    $pre_built_big_stream_href->{_is_last_flow_index_touched_blue}       = $hash_ref->{_is_last_flow_index_touched_blue};
#    $pre_built_big_stream_href->{_is_last_parameter_index_touched_grey}  = $hash_ref->{_is_last_parameter_index_touched_grey};
#    $pre_built_big_stream_href->{_is_last_parameter_index_touched_pink}  = $hash_ref->{_is_last_parameter_index_touched_pink};
#    $pre_built_big_stream_href->{_is_last_parameter_index_touched_green} = $hash_ref->{_is_last_parameter_index_touched_green};
#    $pre_built_big_stream_href->{_is_last_parameter_index_touched_blue}  = $hash_ref->{_is_last_parameter_index_touched_blue};
#    $pre_built_big_stream_href->{_is_last_flow_index_touched}            = $hash_ref->{_is_last_flow_index_touched};
#    $pre_built_big_stream_href->{_is_last_parameter_index_touched}       = $hash_ref->{_is_last_parameter_index_touched};
#    $pre_built_big_stream_href->{_is_moveNdrop_in_flow}                  = $hash_ref->{_is_moveNdrop_in_flow};
#    $pre_built_big_stream_href->{_is_new_listbox_selection}              = $hash_ref->{_is_new_listbox_selection};
#    $pre_built_big_stream_href->{_is_open_file_button}                   = $hash_ref->{_is_open_file_button};
#    $pre_built_big_stream_href->{_is_pre_built_superflow}                = $hash_ref->{_is_pre_built_superflow};
#    $pre_built_big_stream_href->{_is_prog_name}                          = $hash_ref->{_is_prog_name};
#    $pre_built_big_stream_href->{_is_run_button}                         = $hash_ref->{_is_run_button};
#    $pre_built_big_stream_href->{_is_select_file_button}                 = $hash_ref->{_is_select_file_button};
#    $pre_built_big_stream_href->{_is_selected_file_name}                 = $hash_ref->{_is_selected_file_name};
#    $pre_built_big_stream_href->{_is_selected_path}                      = $hash_ref->{_is_selected_path};
#    $pre_built_big_stream_href->{_is_Save_button}                        = $hash_ref->{_is_Save_button};
#    $pre_built_big_stream_href->{_is_SaveAs_button}                      = $hash_ref->{_is_SaveAs_button};
#    $pre_built_big_stream_href->{_is_SaveAs_file_button}                 = $hash_ref->{_is_SaveAs_file_button};
#    $pre_built_big_stream_href->{_is_sunix_listbox}                      = $hash_ref->{_is_sunix_listbox};
#    $pre_built_big_stream_href->{_is_superflow_select_button}            = $hash_ref->{_is_superflow_select_button};
#    $pre_built_big_stream_href->{_is_superflow}                          = $hash_ref->{_is_superflow};
#    $pre_built_big_stream_href->{_is_user_built_flow}                    = $hash_ref->{_is_user_built_flow};
#    $pre_built_big_stream_href->{_last_flow_index_touched_grey}          = $hash_ref->{_last_flow_index_touched_grey};
#    $pre_built_big_stream_href->{_last_flow_index_touched_pink}          = $hash_ref->{_last_flow_index_touched_pink};
#    $pre_built_big_stream_href->{_last_flow_index_touched_green}         = $hash_ref->{_last_flow_index_touched_green};
#    $pre_built_big_stream_href->{_last_flow_index_touched_blue}          = $hash_ref->{_last_flow_index_touched_blue};
#    $pre_built_big_stream_href->{_last_flow_index_touched}               = $hash_ref->{_last_flow_index_touched};
#    $pre_built_big_stream_href->{_last_flow_listbox_touched}             = $hash_ref->{_last_flow_listbox_touched};
#    $pre_built_big_stream_href->{_last_flow_listbox_touched_w}           = $hash_ref->{_last_flow_listbox_touched_w};
#    $pre_built_big_stream_href->{_last_parameter_index_touched_grey}     = $hash_ref->{_last_parameter_index_touched_grey};
#    $pre_built_big_stream_href->{_last_parameter_index_touched_pink}     = $hash_ref->{_last_parameter_index_touched_pink};
#    $pre_built_big_stream_href->{_last_parameter_index_touched_green}    = $hash_ref->{_last_parameter_index_touched_green};
#    $pre_built_big_stream_href->{_last_parameter_index_touched_blue}     = $hash_ref->{_last_parameter_index_touched_blue};
#    $pre_built_big_stream_href->{_last_parameter_index_touched}          = $hash_ref->{_last_parameter_index_touched};
#    $pre_built_big_stream_href->{_names_aref}                            = $hash_ref->{_names_aref};
#    $pre_built_big_stream_href->{_parameter_value_index}                 = $hash_ref->{_parameter_value_index};
#    $pre_built_big_stream_href->{_path}                                  = $hash_ref->{_path};
#    $pre_built_big_stream_href->{_prog_name_sref}                        = $hash_ref->{_prog_name_sref};
#    $pre_built_big_stream_href->{_selected_file_name}                    = $hash_ref->{_selected_file_name};
#    $pre_built_big_stream_href->{_sub_ref}                               = $hash_ref->{_sub_ref};
#    $pre_built_big_stream_href->{_values_aref}                           = $hash_ref->{_values_aref};

    return ();
}

=head2 sub set_name_sref
  is this sub needed?
  $pre_built_big_stream_href->{_prog_name_sref} can also be imported via
  set_hash_ref if the calling module has set the program name previously
 
=cut

sub set_name_sref {
    my ( $self, $prog_name_sref ) = @_;

    if ($prog_name_sref) {
        $pre_built_big_stream_href->{_prog_name_sref} = $prog_name_sref;

        # print("pre_built_big_stream, set_name_sref, $$prog_name_sref\n");

    }
    else {
        print("pre_built_big_stream, set_name_sref, missing name\n");
    }
    return ();
}
=head2
 
 The $pre_built_big_stream_href->{_sub_ref} is collected but
and transferred from the current namespace 
into the selected subroutine in the superclass

=cut

sub set_sub_ref {
    my ( $self, $sub_ref ) = @_;

    if (length $sub_ref) {

        # $pre_built_big_stream_href->{_sub_ref} = $sub_ref; does not transfer to other subroutine within
        # in the namespace ???
        $pre_built_big_stream_href_sub_ref = $sub_ref;

       #  print("pre_built_big_stream, set_sub_ref, sub_ref: $pre_built_big_stream_href_sub_ref \n");
    }
    else {
        print("pre_built_big_stream, set_sub_ref, missing sub ref\n");
    }

    return ();
}

1;