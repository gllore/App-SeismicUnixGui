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
use messages::message_director;
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

#=head2 private hash_reference
#
#	_sub_ref						=> '',  does not seem to allow
#	intra-namespace transfer of the subroutine reference
# 	125
# 
#=cut

#my $pre_built_big_stream_href = {
#
#    _Data_menubutton                       => '',
#    _Flow_menubutton                       => '',
#    _FileDialog_sub_ref                    => '',
#    _FileDialog_option                     => '',
#    _SaveAs_menubutton                     => '',
#    _add2flow_button_grey                  => '',
#    _add2flow_button_pink                  => '',
#    _add2flow_button_green                 => '',
#    _add2flow_button_blue                  => '',
#    _check_code_button                     => '',
#    _check_buttons_settings_aref           => '',
#    _check_buttons_w_aref                  => '',
#    _delete_from_flow_button               => '',
#    _destination_index                     => '',
#    _dialog_type                           => '',
#    _dnd_token_grey                        => '',
#    _dnd_token_pink                        => '',
#    _dnd_token_green                       => '',
#    _dnd_token_blue                        => '',
#    __token_grey                   => '',
#    _dropsite_token_pink                   => '',
#    _dropsite_token_green                  => '',
#    _dropsite_token_blue                   => '',
#    _file_menubutton                       => '',
#    _flow_color                            => '',
#    _flow_item_down_arrow_button           => '',
#    _flow_item_up_arrow_button             => '',
#    _flow_listbox_grey_w                   => '',
#    _flow_listbox_pink_w                   => '',
#    _flow_listbox_green_w                  => '',
#    _flow_listbox_blue_w                   => '',
#    _flow_listbox_color_w                  => '',
#    _flow_name_grey_w                      => '',
#    _flow_name_pink_w                      => '',
#    _flow_name_green_w                     => '',
#    _flow_name_blue_w                      => '',
#    _flow_name_in                          => '',
#    _flow_name_out                         => '',
#    _flow_type                             => '',
#    _flow_widget_index                     => '',
#    _flowNsuperflow_name_w                 => '',
#    _good_labels_aref2                     => '',
#    _good_values_aref2                     => '',
#    _gui_history_ref                       => '',
#    _has_used_check_code_button            => '',
#    _has_used_Save_button                  => '',
#    _has_used_Save_superflow               => '',
#    _has_used_SaveAs_button                => '',
#    _has_used_open_perl_file_button        => '',
#    _has_used_run_button                   => '',
#    _is_add2flow                           => '',
#    _index2move                            => '',
#    _is_Save_button                        => '',
#    _is_SaveAs_button                      => '',
#    _is_SaveAs_file_button                 => '',
#    _is_add2flow_button                    => '',
#    _is_check_code_button                  => '',
#    _is_delete_from_flow_button            => '',
#    _is_dragNdrop                          => '',
#    _is_flow_item_down_arrow_button        => '',
#    _is_flow_item_up_arrow_button          => '',
#    _is_flow_listbox_grey_w                => 0,
#    _is_flow_listbox_pink_w                => 0,
#    _is_flow_listbox_green_w               => 0,
#    _is_flow_listbox_blue_w                => 0,
#    _is_flow_listbox_color_w               => '',
#    _is_last_flow_index_touched            => '',
#    _is_last_flow_index_touched_grey       => '',
#    _is_last_flow_index_touched_pink       => '',
#    _is_last_flow_index_touched_green      => '',
#    _is_last_flow_index_touched_blue       => '',
#    _is_last_parameter_index_touched       => '',
#    _is_last_parameter_index_touched_grey  => '',
#    _is_last_parameter_index_touched_pink  => '',
#    _is_last_parameter_index_touched_green => '',
#    _is_last_parameter_index_touched_blue  => '',
#    _is_moveNdrop_in_flow                  => '',
#    _is_new_listbox_selection              => '',
#    _is_open_file_button                   => '',
#    _is_pre_built_superflow                => '',
#    _is_prog_name                          => '',
#    _is_run_button                         => '',
#    _is_select_file_button                 => '',
#    _is_selected_file_name                 => '',
#    _is_selected_path                      => '',
#    _is_sunix_listbox                      => '',
#    _is_superflow_select_button            => 0,
#    _is_superflow                          => '',     # should it be _pre_built_superflow?
#    _is_user_built_flow                    => '',
#    _items_checkbuttons_aref2              => '',
#    _items_names_aref2                     => '',
#    _items_values_aref2                    => '',
#    _items_versions_aref                   => '',
#    _labels_w_aref                         => '',
#    _last_flow_index_touched               => -1,
#    _last_flow_index_touched_grey          => -1,
#    _last_flow_index_touched_pink          => -1,
#    _last_flow_index_touched_green         => -1,
#    _last_flow_index_touched_blue          => -1,
#    _last_flow_listbox_touched             => '',
#    _last_flow_listbox_touched_w           => '',
#    _last_parameter_index_touched          => -1,
#    _last_parameter_index_touched_grey     => -1,
#    _last_parameter_index_touched_pink     => -1,
#    _last_parameter_index_touched_green    => -1,
#    _last_parameter_index_touched_blue     => -1,
#    _last_path_touched                     => './',
#    _message_w                             => '',
#    _mw                                    => '',
#    _names_aref                            => '',
#    _param_flow_length                     => '',
#    _parameter_names_frame                 => '',
#    _param_sunix_first_idx                 => 0,
#    _param_sunix_length                    => '',
#    _parameter_values_frame                => '',
#    _parameter_values_button_frame         => '',
#    _parameter_value_index                 => '',
#    _path                                  => '',
#    _prog_names_aref                       => '',
#    _prog_name_sref                        => '',     # has pre-existing _spec.pm and *.pm
#    _run_button                            => '',
#    _save_button                           => '',
#    _selected_file_name                    => '',
#    _sunix_listbox                         => '',     # pre-built-superflow or flow name as well
#    _superflow_first_idx                   => '',
#    _superflow_length                      => '',
#    _values_aref                           => '',
#    _values_w_aref                         => '',
#
#};

=head2 declare variables

	106

=cut

# my $Data_menubutton;
#my $FileDialog_sub_ref;
#my $FileDialog_option;
# my $Flow_menubutton;
# my $SaveAs_menubutton;
#my $add2flow_button_grey;
#my $add2flow_button_pink;
#my $add2flow_button_green;
#my $add2flow_button_blue;
#my $check_buttons_settings_aref;
#my $check_buttons_w_aref;
#my $check_code_button;    #6
#my $delete_from_flow_button;
#my $dialog_type;
#my $dnd_token_grey;
#my $dnd_token_pink;
#my $dnd_token_green;
#my $dnd_token_blue;       #12
#my $dropsite_token_grey;
#my $dropsite_token_pink;
#my $dropsite_token_green;
#my $dropsite_token_blue;    #16
#my $file_menubutton;
#my $flowNsuperflow_name_w;
#my $flow_color;
#my $flow_item_down_arrow_button;    #19
#my $flow_item_up_arrow_button;
#my $flow_listbox_grey_w;
#my $flow_listbox_pink_w;
#my $flow_listbox_green_w;
#my $flow_listbox_blue_w;
#my $flow_listbox_color_w;           #25
#my $flow_name_in;
#my $flow_name_out;
#my $flow_type;                      #28
#my $gui_history_ref;
#my $flow_widget_index;
#my $has_used_check_code_button;
#my $has_used_run_button;
#my $has_used_SaveAs_button;
#my $has_used_Save_button;
#my $has_used_Save_superflow;
#my $has_used_open_perl_file_button;
#my $index2move;
#my $is_add2flow;
#my $is_add2flow_button;
#my $is_check_code_button;
#my $is_delete_from_flow_button;
#my $is_dragNdrop;    #37
#my $is_flow_item_down_arrow_button;
#my $is_flow_item_up_arrow_button;
#my $is_flow_listbox_grey_w;
#my $is_flow_listbox_pink_w;
#my $is_flow_listbox_green_w;
#my $is_flow_listbox_blue_w;
#my $is_flow_listbox_color_w;    #44
#my $is_last_flow_index_touched_grey;
#my $is_last_flow_index_touched_pink;
#my $is_last_flow_index_touched_green;
#my $is_last_flow_index_touched_blue;
#my $is_last_parameter_index_touched_grey;
#my $is_last_parameter_index_touched_pink;
#my $is_last_parameter_index_touched_green;
#my $is_last_parameter_index_touched_blue;
#my $is_last_flow_index_touched;
#my $is_last_parameter_index_touched;
#my $is_moveNdrop_in_flow;
#my $is_new_listbox_selection;    #48
#my $is_open_file_button;
#my $is_pre_built_superflow;
#my $is_prog_name;
#my $is_run_button;
#my $is_select_file_button;       #52
#my $is_selected_file_name;
#my $is_selected_path;
#my $is_Save_button;
#my $is_SaveAs_button;
#my $is_SaveAs_file_button;       #55
#my $is_sunix_listbox;
#my $is_superflow_select_button;
#my $is_superflow;
#my $is_user_built_flow;          #59
#my $labels_w_aref;
#my $last_flow_index_touched_grey;
#my $last_flow_index_touched_pink;
#my $last_flow_index_touched_green;
#my $last_flow_index_touched_blue;
#my $last_flow_index_touched;
#my $last_flow_listbox_touched;
#my $last_flow_listbox_touched_w;    #63
#my $last_parameter_index_touched_grey;
#my $last_parameter_index_touched_pink;
#my $last_parameter_index_touched_green;
#my $last_parameter_index_touched_blue;
#my $last_parameter_index_touched;
#my $message_w;
#my $names_aref;
#my $mw;
#my $parameter_value_index;          #67
#my $parameter_values_frame;
#my $path;
#my $prog_name_sref;
#my $run_button;
#my $labels_w_aref;
#my $selected_file_name;
#my $sub_ref;
#my $values_aref;
#my $values_w_aref;

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

#        $pre_built_big_stream_href->{_Data_menubutton}                       = $Data_menubutton;
#        $pre_built_big_stream_href->{_Flow_menubutton}                       = $Flow_menubutton;
#        $pre_built_big_stream_href->{_SaveAs_menubutton}                     = $SaveAs_menubutton;
#        $pre_built_big_stream_href->{_add2flow_button_grey}                  = $add2flow_button_grey;
#        $pre_built_big_stream_href->{_add2flow_button_pink}                  = $add2flow_button_pink;
#        $pre_built_big_stream_href->{_add2flow_button_green}                 = $add2flow_button_green;
#        $pre_built_big_stream_href->{_add2flow_button_blue}                  = $add2flow_button_blue;
#        $pre_built_big_stream_href->{_check_buttons_settings_aref}           = $check_buttons_settings_aref;
#        $pre_built_big_stream_href->{_check_buttons_w_aref}                  = $check_buttons_w_aref;
#        $pre_built_big_stream_href->{_check_code_button}                     = $check_code_button;                       #6
#        $pre_built_big_stream_href->{_delete_from_flow_button}               = $delete_from_flow_button;
#        $pre_built_big_stream_href->{_dialog_type}                           = $dialog_type;
#        $pre_built_big_stream_href->{_dnd_token_grey}                        = $dnd_token_grey;
#        $pre_built_big_stream_href->{_dnd_token_pink}                        = $dnd_token_pink;
#        $pre_built_big_stream_href->{_dnd_token_green}                       = $dnd_token_green;
#        $pre_built_big_stream_href->{_dnd_token_blue}                        = $dnd_token_blue;
#        $pre_built_big_stream_href->{_dropsite_token_grey}                   = $dropsite_token_grey;
#        $pre_built_big_stream_href->{_dropsite_token_pink}                   = $dropsite_token_pink;
#        $pre_built_big_stream_href->{_dropsite_token_green}                  = $dropsite_token_green;
#        $pre_built_big_stream_href->{_dropsite_token_blue}                   = $dropsite_token_blue;                     #16
#        $pre_built_big_stream_href->{_file_menubutton}                       = $file_menubutton;
#        $pre_built_big_stream_href->{_flow_color}                            = $flow_color;
#        $pre_built_big_stream_href->{_flow_item_down_arrow_button}           = $flow_item_down_arrow_button;
#        $pre_built_big_stream_href->{_flow_item_up_arrow_button}             = $flow_item_up_arrow_button;               #20
#        $pre_built_big_stream_href->{_flow_listbox_grey_w}                   = $flow_listbox_grey_w;
#        $pre_built_big_stream_href->{_flow_listbox_pink_w}                   = $flow_listbox_pink_w;
#        $pre_built_big_stream_href->{_flow_listbox_green_w}                  = $flow_listbox_green_w;
#        $pre_built_big_stream_href->{_flow_listbox_blue_w}                   = $flow_listbox_blue_w;
#        $pre_built_big_stream_href->{_flow_listbox_color_w}                  = $flow_listbox_color_w;                    #25
#        $pre_built_big_stream_href->{_flow_name_in}                          = $flow_name_in;
#        $pre_built_big_stream_href->{_flow_name_out}                         = $flow_name_out;
#        $pre_built_big_stream_href->{_flowNsuperflow_name_w}                 = $flowNsuperflow_name_w;
#        $pre_built_big_stream_href->{_flow_type}                             = $flow_type;                               #28
#        $pre_built_big_stream_href->{_flow_widget_index}                     = $flow_widget_index;                       #29
#        $pre_built_big_stream_href->{_gui_history_ref}                       = $gui_history_ref;                         # 29A
#        $pre_built_big_stream_href->{_has_used_check_code_button}            = $has_used_check_code_button;              #30
#        $pre_built_big_stream_href->{_has_used_run_button}                   = $has_used_run_button;
#        $pre_built_big_stream_href->{_has_used_SaveAs_button}                = $has_used_SaveAs_button;
#        $pre_built_big_stream_href->{_has_used_Save_button}                  = $has_used_Save_button;                    #33
#        $pre_built_big_stream_href->{_has_used_Save_superflow}               = $has_used_Save_superflow;
#        $pre_built_big_stream_href->{_has_used_open_perl_file_button}        = $has_used_open_perl_file_button;
#        $pre_built_big_stream_href->{_is_add2flow}                           = $is_add2flow;
#        $pre_built_big_stream_href->{_index2move}                            = $index2move;
#        $pre_built_big_stream_href->{_is_add2flow_button}                    = $is_add2flow_button;
#        $pre_built_big_stream_href->{_is_check_code_button}                  = $is_check_code_button;
#        $pre_built_big_stream_href->{_is_delete_from_flow_button}            = $is_delete_from_flow_button;
#        $pre_built_big_stream_href->{_is_dragNdrop}                          = $is_dragNdrop;                            #37
#        $pre_built_big_stream_href->{_is_flow_item_up_arrow_button}          = $is_flow_item_up_arrow_button;
#        $pre_built_big_stream_href->{_is_flow_item_down_arrow_button}        = $is_flow_item_down_arrow_button;
#        $pre_built_big_stream_href->{_is_flow_listbox_grey_w}                = $is_flow_listbox_grey_w;
#        $pre_built_big_stream_href->{_is_flow_listbox_pink_w}                = $is_flow_listbox_pink_w;
#        $pre_built_big_stream_href->{_is_flow_listbox_green_w}               = $is_flow_listbox_green_w;
#        $pre_built_big_stream_href->{_is_flow_listbox_blue_w}                = $is_flow_listbox_blue_w;
#        $pre_built_big_stream_href->{_is_flow_listbox_color_w}               = $is_flow_listbox_color_w;                 #44
#        $pre_built_big_stream_href->{_is_last_flow_index_touched_grey}       = $is_last_flow_index_touched_grey;
#        $pre_built_big_stream_href->{_is_last_flow_index_touched_pink}       = $is_last_flow_index_touched_pink;
#        $pre_built_big_stream_href->{_is_last_flow_index_touched_green}      = $is_last_flow_index_touched_green;
#        $pre_built_big_stream_href->{_is_last_flow_index_touched_blue}       = $is_last_flow_index_touched_blue;
#        $pre_built_big_stream_href->{_is_last_parameter_index_touched_grey}  = $is_last_parameter_index_touched_grey;
#        $pre_built_big_stream_href->{_is_last_parameter_index_touched_pink}  = $is_last_parameter_index_touched_pink;
#        $pre_built_big_stream_href->{_is_last_parameter_index_touched_green} = $is_last_parameter_index_touched_green;
#        $pre_built_big_stream_href->{_is_last_parameter_index_touched_blue}  = $is_last_parameter_index_touched_blue;
#        $pre_built_big_stream_href->{_is_last_flow_index_touched}            = $is_last_flow_index_touched;
#        $pre_built_big_stream_href->{_is_last_parameter_index_touched}       = $is_last_parameter_index_touched;         #46
#        $pre_built_big_stream_href->{_is_moveNdrop_in_flow}                  = $is_moveNdrop_in_flow;
#        $pre_built_big_stream_href->{_is_new_listbox_selection}              = $is_new_listbox_selection;                #48
#        $pre_built_big_stream_href->{_is_open_file_button}                   = $is_open_file_button;
#        $pre_built_big_stream_href->{_is_pre_built_superflow}                = $is_pre_built_superflow;                  #50
#        $pre_built_big_stream_href->{_is_prog_name}                          = $is_prog_name;
#        $pre_built_big_stream_href->{_is_run_button}                         = $is_run_button;
#        $pre_built_big_stream_href->{_is_select_file_button}                 = $is_select_file_button;                   #52
#        $pre_built_big_stream_href->{_is_selected_file_name}                 = $is_selected_file_name;
#        $pre_built_big_stream_href->{_is_selected_path}                      = $is_selected_path;
#        $pre_built_big_stream_href->{_is_Save_button}                        = $is_Save_button;
#        $pre_built_big_stream_href->{_is_SaveAs_button}                      = $is_SaveAs_button;                        #54
#        $pre_built_big_stream_href->{_is_SaveAs_file_button}                 = $is_SaveAs_file_button;                   #55
#        $pre_built_big_stream_href->{_is_sunix_listbox}                      = $is_sunix_listbox;                        #56
#        $pre_built_big_stream_href->{_is_superflow}                          = $is_superflow;
#        $pre_built_big_stream_href->{_is_superflow_select_button}            = $is_superflow_select_button;              #58
#        $pre_built_big_stream_href->{_is_user_built_flow}                    = $is_user_built_flow;                      #59
#        $pre_built_big_stream_href->{_labels_w_aref}                         = $labels_w_aref;                           #60
#        $pre_built_big_stream_href->{_last_flow_index_touched_grey}          = $last_flow_index_touched_grey;            #61
#        $pre_built_big_stream_href->{_last_flow_index_touched_pink}          = $last_flow_index_touched_pink;            #61
#        $pre_built_big_stream_href->{_last_flow_index_touched_green}         = $last_flow_index_touched_green;           #61
#        $pre_built_big_stream_href->{_last_flow_index_touched_blue}          = $last_flow_index_touched_blue;            #61
#        $pre_built_big_stream_href->{_last_flow_index_touched}               = $last_flow_index_touched;                 #61
#        $pre_built_big_stream_href->{_last_flow_listbox_touched}             = $last_flow_listbox_touched;               #62
#        $pre_built_big_stream_href->{_last_flow_listbox_touched_w}           = $last_flow_listbox_touched_w;             #63
#        $pre_built_big_stream_href->{_last_parameter_index_touched_grey}     = $last_parameter_index_touched_grey;       #64
#        $pre_built_big_stream_href->{_last_parameter_index_touched_pink}     = $last_parameter_index_touched_pink;       #64
#        $pre_built_big_stream_href->{_last_parameter_index_touched_green}    = $last_parameter_index_touched_green;      #64
#        $pre_built_big_stream_href->{_last_parameter_index_touched_blue}     = $last_parameter_index_touched_blue;       #64
#        $pre_built_big_stream_href->{_last_parameter_index_touched}          = $last_parameter_index_touched;            #64
#        $pre_built_big_stream_href->{_message_w}                             = $message_w;
#        $pre_built_big_stream_href->{_mw}                                    = $mw;
#        $pre_built_big_stream_href->{_names_aref}                            = $names_aref;
#        $pre_built_big_stream_href->{_parameter_value_index}                 = $parameter_value_index;                   #67
#        $pre_built_big_stream_href->{_parameter_values_frame}                = $parameter_values_frame;
#        $pre_built_big_stream_href->{_path}                                  = $path;
#        $pre_built_big_stream_href->{_prog_name_sref}                        = $prog_name_sref;                          #69
#        $pre_built_big_stream_href->{_run_button}                            = $run_button;
#        $pre_built_big_stream_href->{_save_button}                           = $save_button;
#        $pre_built_big_stream_href->{_selected_file_name}                    = $selected_file_name;
#        $pre_built_big_stream_href->{_sub_ref}                               = $sub_ref;
#        $pre_built_big_stream_href->{_values_aref}                           = $values_aref;
#        $pre_built_big_stream_href->{_values_w_aref}                         = $values_w_aref;                           #74

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

 chosen superflow
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
    # gui_history->set_gui_widgets($pre_built_big_stream_href);        # sets 25 / given 103
    gui_history->set_hash_ref($pre_built_big_stream_href);           # sets 49 / given 103
    gui_history->set4start_of_superflow_select();    # sets 3; sets gui_widgets
    $pre_built_big_stream_href = gui_history->get_hash_ref();        # returns 98 !

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

    # OLD WAY: Here is where you would rebind the different buttons depending on the
    # program name that is selected (i.e. through spec.pm... if you did it in param widgets)
    ## $param_widgets			->set_superflow_bindings();
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
	
	print("pre_built_big_stream, set_hash_ref, print gui_history.txt\n");
	$gui_history->view();

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
 $pre_built_big_stream_href->{_sub_ref} is collected but
 can not transfer from the current namespace into the select subroutine
 VERY WEIRD behavior; memory leak? TODO ( is this already working now?)

=cut

sub set_sub_ref {
    my ( $self, $sub_ref ) = @_;

    if ($sub_ref) {

        # $pre_built_big_stream_href->{_sub_ref} = $sub_ref; does not transfer to other subroutine within
        # in the namespace ???
        $pre_built_big_stream_href_sub_ref = $sub_ref;

        #print("pre_built_big_stream, set_sub_ref, sub_ref: $pre_built_big_stream_href->{_sub_ref}\n");
        #print("pre_built_big_stream, set_sub_ref, sub_ref: $pre_built_big_stream_href_sub_ref \n");
    }
    else {
        print("pre_built_big_stream, set_sub_ref, missing sub ref\n");
    }

    return ();
}

1;