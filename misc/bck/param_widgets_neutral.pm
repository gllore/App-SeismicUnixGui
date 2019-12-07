package param_widgets_neutral;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: param_widgets_neutral
 AUTHOR:  Juan Lorenzo

=head2 CHANGES and their DATES

 DATE: V 1.0.1 May 6 2018


=head2 DESCRIPTION

   manages the parameter labels, values and their
   checkboxes in the mguis

=head2 USE

=head2 Examples

=head2 

=head2 STEPS


=head2 NOTES 

=cut

use Moose;
our $VERSION = '1.0.1';
use Tk;
use L_SU_global_constants;
use check_buttons;
my $check_buttons = new check_buttons();

my $get                 = new L_SU_global_constants();
my $default_param_specs = $get->param();
my $var                 = $get->var();
my $on                  = $var->{_on};
my $off                 = $var->{_off};
my $nu                  = $var->{_nu};
my $no                  = $var->{_no};

# print("param_widgets_neutral, default_param_specs,first entry num=$default_param_specs->{_first_entry_num}\n");

=head2 private hash references

32 off

=cut

my $param_widgets_neutral = {

    _changed_entry               => 0,
    _check_buttons_settings_aref => '',
    _check_buttons_frame_href    => '',
    _check_buttons_w_aref        => '',
    _current_program_name        => '',
    _entry_button_chosen_index   => '',
    _entry_button_chosen_widget  => '',
    _location_in_gui             => '',
    _first_idx                   => $default_param_specs->{_first_entry_idx},
    _index                      => '',    # for current program in a listbox
    _is_delete_from_flow_button => '',
    _is_flow_listbox_grey_w     => '',
    _is_flow_listbox_pink_w     => '',
    _is_flow_listbox_green_w    => '',
    _is_flow_listbox_blue_w     => '',
    _is_flow_listbox_color_w    => '',
    _is_moveNdrop_in_flow       => '',
    _is_new_listbox_selection   => '',
    _is_sunix_listbox           => '',
    _is_superflow_select_button => '',
    _labels_aref                => '',
    _labels_frame_href          => '',
    _labels_w_aref              => '',

    #_last_changed_program_index => '',
    _last_changed_entry_index => '',
    _last                     => '',
    _length                   => $default_param_specs->{_length},
    _prog_name                => '',
    _prog_name_sref           => '',
    _values_aref              => '',
    _values_frame_href        => '',
    _values_w_aref            => '',

};

my $true  = 1;
my $false = 0;

=head2 sub _reset

	private reset of "condition" variables
	do not reset incoming widgets
	
=cut

sub _reset {
    my ($self) = @_;

    $param_widgets_neutral->{_is_flow_listbox_grey_w}  = $false;
    $param_widgets_neutral->{_is_flow_listbox_pink_w}  = $false;
    $param_widgets_neutral->{_is_flow_listbox_green_w} = $false;
    $param_widgets_neutral->{_is_flow_listbox_blue_w}  = $false;
    $param_widgets_neutral->{_is_flow_listbox_color_w} = $false;
    $param_widgets_neutral->{_is_add2flow} =
      $false;    # needed? double confirmation?
    $param_widgets_neutral->{_is_add2flow_button} =
      $false;    # needed? double confirmation?
    $param_widgets_neutral->{_is_delete_from_flow_button} = $false;
    $param_widgets_neutral->{_is_new_listbox_selection}   = $false;
    $param_widgets_neutral->{_is_superflow_select_button} = $false;
    $param_widgets_neutral->{_is_delete_from_flow_button} = $false;
    $param_widgets_neutral->{_is_moveNdrop_in_flow}       = $false;
    $param_widgets_neutral->{_is_sunix_listbox}           = $false;

    return ();
}

=head2 sub error_check

 When entry values are in error 

=cut

sub error_check {
    my ($self) = @_;
    print("param_widgets_neutral,error_check return is $true\n");
    return ($true);
}

=head2 sub get_check_buttons_w_aref


=cut

sub get_check_buttons_w_aref {
    my ($self) = @_;

    if ( $param_widgets_neutral->{_check_buttons_w_aref} ) {

        my $check_buttons_w_aref =
          $param_widgets_neutral->{_check_buttons_w_aref};
        return ($check_buttons_w_aref);

    }
    else {
        print(
"param_widgets_neutral, get_check_buttons_w_aref, missing check_buttons_w_aref \n"
        );
        return ();
    }
}

=head2 sub 

=cut

sub get_current_program {

    my ( $self, $widget_ref ) = @_;
    my @selection_index = $$widget_ref->curselection();
    my $prog_name       = $$widget_ref->get( $selection_index[0] );

# print("param_widgets_neutral get_current_program: $prog_name,index:$selection_index[0] \n");
    return ( \$prog_name );
}

=head2 sub get_entry_change_status

=cut

sub get_entry_change_status {
    my @self   = @_;
    my $status = $param_widgets_neutral->{_changed_entry};

# print("param_widgets_neutral, get_entry_change_status,changed_entry: $param_widgets_neutral->{_changed_entry}\n");
    return ($status);
}

=head2 sub get_labels_w_aref

=cut

sub get_labels_w_aref {
    my ($self) = @_;

    if ( $param_widgets_neutral->{_labels_w_aref} ) {

        my $labels_w_aref = $param_widgets_neutral->{_labels_w_aref};
        return ($labels_w_aref);

    }
    else {
        print(
            "param_widgets_neutral,get_labels_w_aref, missing labels_w_aref \n"
        );
        return ();
    }
}

=head2 sub get_length_check_buttons_on

=cut

sub get_length_check_buttons_on {
    my ($self) = @_;
    my ( $length, $count );
    my $check_buttons_aref = _get_check_buttons_aref();

# print("param_widgets_neutral,get_length_check_buttons_on, @$check_buttons_aref)\n");
    my @button_settings = @$check_buttons_aref;
    $length = scalar @button_settings;

    for ( my $i = 0, $count = 0 ; $i < $length ; $i++ ) {
        if ( $button_settings[$i] ) {
            if ( $button_settings[$i] eq 'on' ) {
                $count++;
            }
        }
    }

    $length = $count;
    return ($length);
}

=head2 sub get_index_check_buttons_on

=cut

sub get_index_check_buttons_on {
    my ($self) = @_;
    my ( $length, $count );
    my $check_buttons_aref = _get_check_buttons_aref();

# print("param_widgets_neutral,get_length_check_buttons_on, @$check_buttons_aref)\n");
    my @button_settings = @$check_buttons_aref;
    $length = scalar @button_settings;
    my @saved_index_on;
    my $j = 0;
    for ( my $i = 0, $count = 0 ; $i < $length ; $i++ ) {
        if ( $button_settings[$i] ) {
            if ( $button_settings[$i] eq 'on' ) {
                $saved_index_on[$j] = $i;
                $j++;
            }
        }
    }

    return ( \@saved_index_on );
}

=head2 get_values_w_aref

	return an array widget references

=cut

sub get_values_w_aref {
    my ($self) = @_;

    if ( $param_widgets_neutral->{_values_w_aref} ) {

        my $values_w_aref = $param_widgets_neutral->{_values_w_aref};
        return ($values_w_aref);

    }
    else {
        print(
            "param_widgets_neutral,get_values_w_aref, missing values_w_aref \n"
        );
        return ();
    }
}

sub gui_clean {
    my ($self) = @_;

    use wipe;
    my $wipe = new wipe();

# print("param_widgets_neutral, gui_clean, _values_w_aref, $param_widgets_neutral->{_values_w_aref} \n");
# print("param_widgets_neutral, gui_clean, _labels_w_aref, $param_widgets_neutral->{_labels_w_aref} \n");
    $wipe->range($param_widgets_neutral);
    $wipe->values();
    $wipe->labels();
    $wipe->check_buttons();

    return ();
}

=head2 sub gui_full_clear

clear the gui compeltely of 61 parameter values

=cut

sub gui_full_clear {
    my ($self) = @_;

    use wipe;

    my $wipe = new wipe();

    $param_widgets_neutral->{_length} = $default_param_specs->{_length};

# print("param_widgets_neutral, gui_clean, _values_w_aref, $param_widgets_neutral->{_values_w_aref} \n");
# print("param_widgets_neutral, gui_clean, _labels_w_aref, $param_widgets_neutral->{_labels_w_aref} \n");
    $wipe->range($param_widgets_neutral);
    $wipe->values();
    $wipe->labels();
    $wipe->check_buttons();

    return ();
}

=head2 sub  local_set_entry_change_status

=cut

sub local_set_entry_change_status {
    my ($ans) = @_;
    $param_widgets_neutral->{_changed_entry} = $ans;

# print("param_widgets_neutral,local_set_entry_change_status,changed_entry,is: success \n");

    return ();
}

=head2 sub local_update_check_button_setting

 update for one parameter index 
 in currently active program
 
 Entry widget uses textvariables

=cut

sub local_update_check_button_setting {
    my ($index) = @_;
    my $idx     = $index;
    my @values  = @{ $param_widgets_neutral->{_values_aref} };
    my (@on_off);

    # apparently empty cases
    # equal to 0 or 0.0 or empty or undefined
    if ( !( $values[$idx] ) ) {

        # if value is defined and initialized
        if ( defined( $values[$idx] ) ) {

            if ( $values[$idx] eq '0' ) {

                $on_off[$idx] = $on;

# print("1.20 param_widgets_neutral,,local_update_check_button_setting index: $idx , value:$values[$idx] or '0' \n");

            }
            elsif ( $values[$idx] eq '0.0' ) {

                $on_off[$idx] = $on;

# print("1.21 param_widgets_neutral,local_update_check_button_setting, ndex: $idx , value:$values[$idx] or 0.0 \n");

            }
            elsif ( $values[$idx] eq '0' ) {

                $on_off[$idx] = $on;

# print("1.22 param_widgets_neutral,,local_update_check_button_setting index: $idx , value:$values[$idx] or '0' \n");

            }
            elsif ( $values[$idx] eq '0.0' ) {

                $on_off[$idx] = $on;

# print("1.23 param_widgets_neutral,local_update_check_button_setting, ndex: $idx , value:$values[$idx] or 0.0 \n");

            }
            else {

# print("1.24 param_widgets_neutral,local_update_check_button_setting; empty value,  :index $idx value: $values[$idx]\n");
                $on_off[$idx] = $off;
            }

        }
        else {

# print("param_widgets_neutral,local_update_check_button_setting; unexpected cases\n");
            $on_off[$idx] = $off;
        }

        # apparently non-empty cases
    }
    elsif ( $values[$idx] ) {

        if ( $values[$idx] eq "0" ) {

            $on_off[$idx] = $on;

# print("1.11.23 1 param_widgets_neutral,local_update_check_button_setting, index: $idx value: $values[$idx]\n");

        }
        elsif ( $values[$idx] eq '0.0' ) {

            $on_off[$idx] = $on;

# print("1.12 param_widgets_neutral,local_update_check_button_setting, ndex: $idx , value:$values[$idx] or 0.0 \n");

        }
        elsif ( $values[$idx] eq "" ) {

            $on_off[$idx] = $off;

# print("1.13 param_widgets_neutral,local_update_check_button_setting, \"\" \n");

        }
        elsif ( $values[$idx] eq '' ) {

# print("1.14 param_widgets_neutral,local_update_check_button_setting, \'\' \n");
            $on_off[$idx] = $off;

        }
        elsif ( $values[$idx] eq "'nu'" ) {

            $on_off[$idx] = $off;

# print("1. param_widgets_neutral,local_update_check_button_setting, \"\'nu\'\"  \n");

        }
        elsif ( $values[$idx] eq $nu ) {
            $on_off[$idx] = $off;

# print("1.15 param_widgets_neutral,local_update_check_button_setting, \$nu \n");

        }
        elsif ( $values[$idx] eq $no ) {
            $on_off[$idx] = $off;

 # print("2. param_widgets_neutral,local_update_check_button_setting, \$no \n");

        }
        elsif ( $values[$idx] eq "'0'" ) {
            $on_off[$idx] = $on;

# print("2.1 param_widgets_neutral,local_update_check_button_setting, \"\'0\'\" \n");

        }
        else {
# print("3.1 param_widgets_neutral,local_update_check_button_setting, all else\n");
            $on_off[$idx] = $on;
        }

    }
    else {
        print(
"param-widgets,local_update_check_button_setting, apparently unconsidered case\n"
        );    # weird TODO
    }

    $check_buttons->set_index($idx);
    $check_buttons->set_switch( \@on_off );

    # update a single change in private hash
    @{ $param_widgets_neutral->{_check_buttons_settings_aref} }[$idx] =
      $on_off[$idx];

# print("param_widgets_neutral: local_update_check_button_setting :index $idx setting is: $on_off[$idx]\n");
# print("param_widgets_neutral: update_check_buttons_settings_aref @{$param_widgets_neutral->{_check_buttons_settings_aref}}\n");

    return ();
}

#=head2 sub get_last_changed_program_index
#
#=cut
#
#sub get_last_changed_program_index{
#	my @self = @_;
#    my $idx = $param_widgets_neutral->{_last_changed_program_index};
#    return($idx);
#}

=head2 sub local_set_last_changed_entry_index

=cut

sub local_set_last_changed_entry_index {
    my ($self) = @_;
    $param_widgets_neutral->{_last_changed_entry_index} = $self;

# print("param_widgets_neutral,local_set_last_changed_entry_index:  $param_widgets_neutral->{_last_changed_entry_index} \n");
    return ();
}

=head2 sub set_check_buttons
 a widget reference

=cut

sub set_check_buttons {
    my ( $self, $check_buttons_settings_aref ) = @_;
    if ($check_buttons_settings_aref) {
        $param_widgets_neutral->{_check_buttons_settings_aref} =
          $check_buttons_settings_aref;

# print("param_widgets_neutral,set_check_buttons, settings are @{$param_widgets_neutral->{_check_buttons_settings_aref}}\n");
    }
    return ();
}

=head2 sub get_current_widget_name

 screen location by using part of the widget name
    print(" self:$self widget: $widget\n");
    print(" currently  focus lies in: $screen_location\n");
    print(" reference: $reference\n");
   foreach my $i (@fields) {
    print(" 2. widget is $i\n");
    my $screen_location = $widget->focusCurrent;
    my $reference       = ref $screen_location;
    print(" 1. widget is $a\n");
    print ( "widget is $fields[-1]\n");
    name is in the last element of the split array 

  if widget_name= frame then we have flow
              $var->{_flow}
  if widget_name= menubutton we have superflow 
              $var->{_tool}
=cut

sub get_current_widget_name {
    my ( $self, $widget_ref ) = @_;
    my @fields = split( /\./, $widget_ref->PathName() );
    my $widget_name = $fields[-1];
    return ($widget_name);
}

=head2 sub get_check_buttons_aref

=cut

sub get_check_buttons_aref {
    my ($self) = @_;
    my $check_buttons_settings_aref =
      \@{ $param_widgets_neutral->{_check_buttons_settings_aref} };
    my $check_buttons_aref = $check_buttons_settings_aref;

# print("param_widgets_neutral,get_check_buttons_aref: @{$param_widgets_neutral->{_check_buttons_settings_aref}}\n");
    return ($check_buttons_aref);
}

sub set_entry_button_chosen_index {

    my ( $self, $index ) = @_;
    $param_widgets_neutral->{_entry_button_chosen_index} = $index;

   # print (" param_widgets_neutral,set_entry_button_chosen_index, #$index \n");

}

=head2 sub _get_check_buttons_aref

=cut

sub _get_check_buttons_aref {
    my ($self) = @_;
    my $check_buttons_settings_aref =
      \@{ $param_widgets_neutral->{_check_buttons_settings_aref} };
    my $check_buttons_aref = $check_buttons_settings_aref;

#print("param_widgets_neutral,get_check_buttons_aref: @{$param_widgets_neutral->{_check_buttons_settings_aref}}\n");
    return ($check_buttons_aref);
}

sub set_entry_button_chosen_widget {

    my ( $self, $widget_h ) = @_;
    $param_widgets_neutral->{_entry_button_chosen_widget} = $widget_h;

# print (" param_widgets_neutral,set_entry_button_chosen_widget, #$widget_h \n");

}

=head2 sub get_entry_button_chosen_index 


=cut

sub get_entry_button_chosen_index {

    my ($self) = @_;
    my $index;

    # first and last indices
    my $first  = $param_widgets_neutral->{_first_idx};
    my $length = $param_widgets_neutral->{_length};

# print("param_widget,get_entry_button_chosen_index,first_index=$param_widgets_neutral->{_first_idx}\n");
# print("param_widget,get_entry_button_chosen_index,length_=$param_widgets_neutral->{_length} \n");

    my $widget = $param_widgets_neutral->{_entry_button_chosen_widget};

    # print("param_widget,get_entry_button_chosen_index,widget,=$widget\n");

    for ( my $choice = $first ; $choice < $length ; $choice++ ) {
        if ( $widget eq @{ $param_widgets_neutral->{_values_w_aref} }[$choice] )
        {

            $param_widgets_neutral->{_entry_button_chosen_index} = $choice;

  # print (" param_widgets_neutral,get_entry_button_chosen_index, #$choice \n");
            $index = $choice;
        }
    }

    return ($index);
}

=head2 sub get_label4entry_button_chosen

 determine which Entry Button is chosen

    print("param is $entry_param;\n");
         print ("selected widget is # $LSU->{_parameter_value_index}\");
         print ("label is  $out\n");

=cut

sub get_label4entry_button_chosen {
    my ($self) = @_;
    my $label;

    # first and last indices
    my $first  = $param_widgets_neutral->{_first_idx};
    my $length = $param_widgets_neutral->{_length};

# print("param_widget,get_entry_button_chosen,first_index=$param_widgets_neutral->{_first_idx}\n");
# print("param_widget,get_entry_button_chosen,length_=$param_widgets_neutral->{_length} \n");

    my $widget = $param_widgets_neutral->{_entry_button_chosen_widget};

    # print("param_widget,get_entry_button_chosen,widget,=$widget\n");

    for ( my $choice = $first ; $choice < $length ; $choice++ ) {
        if ( $widget eq @{ $param_widgets_neutral->{_values_w_aref} }[$choice] )
        {
            my $parameter_value_index = $choice;
            my $parameter_name_index  = $choice;
            $label = @{ $param_widgets_neutral->{_labels_w_aref} }[$choice]
              ->cget('-text');
            my $value =
              @{ $param_widgets_neutral->{_values_w_aref} }[$choice]->get;

            # print("param_widget,get_entry_button_chosen,label,=$label\n");
            # print("param_widget,get_entry_button_chosen,value,=$value\n");
            # print("param_widget,get_entry_button_chosen,index,=$choice\n");
        }
    }
    return ($label);
}

=head2 sub get_value4entry_button_chosen

 determine which Entry Button is chosen

    print("param is $entry_param;\n");
         print ("selected widget is # $LSU->{_parameter_value_index}\");
         print ("label is  $out\n");

=cut

sub get_value4entry_button_chosen {
    my ($self) = @_;
    my $value;

    # first and last indices
    my $first  = $param_widgets_neutral->{_first_idx};
    my $length = $param_widgets_neutral->{_length};

# print("param_widgets_neutral,get_entry_button_chosen,first_index=$param_widgets->{_first_idx}\n");
# print("param_widgets_neutral,get_entry_button_chosen,length_=$param_widgets->{_length} \n");

    my $widget = $param_widgets_neutral->{_entry_button_chosen_widget};

    # print("param_widgets_neutral,get_entry_button_chosen,widget,=$widget\n");

    for ( my $choice = $first ; $choice < $length ; $choice++ ) {
        if ( $widget eq @{ $param_widgets_neutral->{_values_w_aref} }[$choice] )
        {
            my $parameter_value_index = $choice;
            my $parameter_name_index  = $choice;

          #$label = @{$param_widgets->{_labels_w_aref}}[$choice]->cget('-text');
            $value =
              @{ $param_widgets_neutral->{_values_w_aref} }[$choice]->get;

       #print("param_widgets_neutral,get_entry_button_chosen,label,=$label\n");
       # print("param_widgets_neutral,get_entry_button_chosen,value,=$value\n");
       #print("param_widgets_neutral,get_entry_button_chosen,index,=$choice\n");
        }
    }
    return ($value);
}

=head2 sub get_values_aref

	all the values for one program at a time

=cut

sub get_values_aref {
    my ($self) = @_;

    if ( $param_widgets_neutral->{_values_aref} ne '' ) {
        my $values_aref = \@{ $param_widgets_neutral->{_values_aref} };

# print("param_widgets_neutral,get_values_aref,value[0]= @{$param_widgets_neutral->{_values_aref}}[0]\n");
        return ($values_aref);

    }
    else {
      # print("param_widgets_neutral, get_values_aref,  missing values_aref\n");
    }

}

=head2 sub get_labels_aref

	equivalent to get_naems_aref

=cut

sub get_labels_aref {

    my ($self) = @_;
    my $labels_aref = \@{ $param_widgets_neutral->{_labels_aref} };

# print("param_widgets_neutral,get_labels_aref: @{$param_widgets_neutral->{_labels_aref}}\n"); # all labels in array may not be there
    return ( $param_widgets_neutral->{_labels_aref} );
}

=head2 sub get_names_aref

	equivalent to get_labels_aref

=cut

sub get_names_aref {

    my ($self) = @_;
    my $labels_aref = \@{ $param_widgets_neutral->{_labels_aref} };
    print(
"param_widgets_neutral,get_labels_aref: @{$param_widgets_neutral->{_labels_aref}}\n"
    );    # all labels in array may not be there
    return ( $param_widgets_neutral->{_labels_aref} );
}

=head2 sub initialize_check_buttons

 same set of check buttons for all programs 

=cut

sub initialize_check_buttons {
    my ($self) = @_;
    my ( $first, $length );
    my (@off);

    $first  = $param_widgets_neutral->{_first_idx};
    $length = $param_widgets_neutral->{_length};

    for ( my $i = $first ; $i < $length ; $i++ ) {
        $off[$i] = 'off';
    }

    $check_buttons->specs($default_param_specs);
    $check_buttons->frame(
        $param_widgets_neutral->{_check_buttons_frame_href} );
    $check_buttons->make( \@off );

    $param_widgets_neutral->{_check_buttons_w_aref} =
      $check_buttons->get_w_aref();

# print("param_widgets, initialize_check_buttons check_buttons_w_aref: $param_widgets_neutral->{_check_buttons_w_aref}\n");

}

=head2 sub initialize_labels


=cut

sub initialize_labels {

    my ($self) = @_;
    my ( $labels, $first, $length );
    my (@blank_labels);

    use label_boxes;

    $labels = label_boxes->new();
    $first  = $param_widgets_neutral->{_first_idx};
    $length = $param_widgets_neutral->{_length};

    # print("param_widgets_neutral,initialize_labels,first:$first\n");
    # print("param_widgets_neutral,initialize_labels,length:$length\n");

    for ( my $i = $first ; $i < $length ; $i++ ) {
        $blank_labels[$i] = '';
    }

    $labels->specs($default_param_specs);
    $labels->frame( $param_widgets_neutral->{_labels_frame_href} );
    $labels->texts( \@blank_labels );

    $param_widgets_neutral->{_labels_w_aref} = $labels->get_w_aref();
}

=head2 sub initialize_values


=cut

sub initialize_values {
    my ($self) = @_;
    my ( $values, $first, $length );
    my @blank_values = ();
    use value_boxes;
    $values = value_boxes->new();

    $first  = $param_widgets_neutral->{_first_idx};
    $length = $param_widgets_neutral->{_length};

    for ( my $i = $first ; $i < $length ; $i++ ) {
        $blank_values[$i] = '';
    }

    $values->specs($default_param_specs);
    $values->frame( $param_widgets_neutral->{_values_frame_href} );
    $values->texts( \@blank_values );

    $param_widgets_neutral->{_values_w_aref} = $values->get_w_aref();

}

# find out what the label is and if it is datain then go ahead
# default is to do nothing
# if (not $datain) {
# 	# do nothing
# } else {
#
# 	# proceed to find the data

# $$option_sref == 'Select'
# in main you should then go ahead and activate the File Dialog to open a file
# }
#print("TODO: value_boxes,_callback from MB_3 on index= $index entry that has as label datain\n");
#return();

#}

=head2 changes

 to only one paramter
 some changes will be false and should be rejected

 If you are at this subroutine it means that
 a possible change has been detected in
 the Entry Widget TODO: but it has yet to be ratified

 Currently if we reach this subroutine we assume that changes always occur to 
 all parametrs and so we 
 forcibly check for changes always
 
 changes are only allowed for those sunix programs whose spec files
 have a max_index defined
 
 currently changes in param_widgets_neutral package only works with regular flows 
 and not with pre-built superflows
 

=cut

sub changes {
    my ($index) = @_;
    my $idx = $index;    # individual parameter line
    use control;
    my $control = new control;

    # two cases possible
    # in general L_SU
    if ( $param_widgets_neutral->{_current_program_name} ) {
        my $prog_name = $param_widgets_neutral->{_current_program_name};

        # print(" param_widgets_neutral, changes, prog_name: $prog_name \n");
        # print(" param_widgets_neutral, changes, index: $idx \n");
        # print(" param_widgets_neutral, changes, index: $idx \n");
        my $max_idx = $control->get_max_index($prog_name);

        # print(" param_widgets_neutral,max_index, $max_idx \n");
        if ( $idx >= 0 && $idx <= $control->get_max_index($prog_name) )
        {    # cautious, index must be reasonable
            local_set_entry_change_status($true);
            my $changed_entry =
              $param_widgets_neutral->{_changed_entry};    #always
             # print("param_widgets_neutral,changes,changed 1-yes 0 -no? $changed_entry\n");
            local_update_check_button_setting($idx);

            # local_set_last_changed_entry_index($idx);
        }

        return ($true);    # for Entry widget to say there is not error

   # second case is when we are using project_selector
   # project_selector does not yet have a max_index defined in a separate module
    }
    else {

        return ($true);    # for Entry widget to say there is not error
    }

}

=head2 sub local_checks 
 When original value of Entry widget (package create, sub valuesc) 
 is modified:
  test the new value
  a true response means changes are actually happening
  a false response means there is no reall change
  occurring.

  E.g., A  test for integers or decimal values as follows:
  if (($test =~ /^-?\d+/) || ($test =~ /^-?\d+\.\d+/)) {
  print ("Error: Entered an integer (First check)\n");
  print ("or a decimal (2nd check)\n");

 TODO multiple values

 NB.
  Dereference one scalar reference 
  within an array of references 
  First ascertain values are not blank
  as during initialization of GUI. 

 DB

=cut

=head2 sub local_checks 

  the first time a flow is added (add2flow) or just looked at
  by clicking the sunix-listbox item no changes can be made


=cut

# sub local_checks {
#   my ($index) = @_;
#
#   # changed entry updates automatically
#   my $first 		= $param_widgets_neutral->{_first_idx};
#   my $length  		= $param_widgets_neutral->{_length};
#		     # print("1. param_widgets_neutral,local_checks,number of items in program: $length\n");
#		     # print("1. param_widgets_neutral,local_checks,recently current entry was index: $index\n");
#		    # print("1. param_widgets_neutral,local_checks,is new listbox selected? : $param_widgets_neutral->{_is_new_listbox_selection}\n\n");
#		   # print("1. param_widgets_neutral,local_checks,result of add2flow_button selected? : $param_widgets_neutral->{_is_add2flow_button}\n\n");
#
#					# first-time selection program but program has not been modified or just added to flow iwhtout modification
# # or a drag and drop has just occurred in which case we assume
# # that changes were implemented fully (i.e. no effective change on this round
# # or that a flow prgram has just been moved and inserted in the flow
#   if ($param_widgets_neutral->{_is_new_listbox_selection} || $param_widgets_neutral->{_is_add2flow_button} || $param_widgets_neutral->{_is_moveNdrop_in_flow}) {
#
#					# work through a program's entries
#	 if( $index == ($length-1) ) {      				# at last  entry (via local subs: redisplay or gui_update)
#	    $param_widgets_neutral->{_is_new_listbox_selection} = $false;
#	    $param_widgets_neutral->{_is_add2flow_button} 		= $false;
#										  # print("2. param_widgets_neutral,local_checks, at last item#; # $length\n\n");
#   	    return($false);  # false change detected
#     } elsif( $index < ($length-2) ) {  #unlikely case but answer is still false
#	     $param_widgets_neutral->{_is_new_listbox_selection} = $true;
#	      $param_widgets_neutral->{_is_add2flow_button} 	 = $true;
#										   # print("3. param_widgets_neutral,local_checks,new flow selection, idx=$index\n\n");
#   	    return($false);  # false change detected
#     }
#   } elsif ($param_widgets_neutral->{_is_delete_from_flow_button} || $param_widgets_neutral->{_is_sunix_listbox} ) {
#   	    return($false);	# do nothing, false change detected
#
#   } else {  # By exclusion of everything we can ONLY be but truly CHANGING entries
#	    								   print("4. param_widgets_neutral,local_checks,leaving index:  $index\n\n");
#   	    								  print("4. param_widgets_neutral,local_checks, value just changed to: @{$param_widgets_neutral->{_values_aref}}[$index]\n");
#   	    if( $index < $length) { # not beyond parameter range
#             return($true);    # true change detected
#        }
#   }
# }

#

=head2 sub set_values_frame

 a widget reference
  #$param_widgets_neutral->{_values_frame_href} 

=cut

sub set_values_frame {
    my ( $self, $values_frame_href ) = @_;
    $param_widgets_neutral->{_values_frame_href} = $values_frame_href;
}

=head2 sub range 

	establish the first and last
    indices of the array
  	  foreach my $key (sort keys %$param_widgets_neutral) {
   print (" param_widgets_neutral,key is $key, value is $param_widgets_neutral->{$key}\n");
  } 

=cut 

sub range {
    my ( $self, $ref_hash ) = @_;

    # for adding to flows as a user-built flow
    if (   $param_widgets_neutral->{_is_add2flow_button}
        || $param_widgets_neutral->{_is_add2flow} )
    {

        $param_widgets_neutral->{_first_idx} =
          $ref_hash->{_param_sunix_first_idx};
        $param_widgets_neutral->{_length} = $ref_hash->{_param_sunix_length};

# print("1.param_widgets_neutral,range,  (add2flow_button and add2flow)  first idx:$param_widgets_neutral->{_first_idx}, and length:$param_widgets_neutral->{_length}\n");
    }

    # for sunix selections
    if ( $param_widgets_neutral->{_is_sunix_listbox} ) {

        $param_widgets_neutral->{_first_idx} =
          $ref_hash->{_param_sunix_first_idx};
        $param_widgets_neutral->{_length} = $ref_hash->{_param_sunix_length};

#print("2. param_widgets_neutral,range, (sunix_listbox) first idx:$param_widgets_neutral->{_first_idx}, and length:$param_widgets_neutral->{_length}\n");
    }

    # for user-built flows
    if (   $param_widgets_neutral->{_is_flow_listbox_grey_w}
        || $param_widgets_neutral->{_is_flow_listbox_pink_w}
        || $param_widgets_neutral->{_is_flow_listbox_green_w}
        || $param_widgets_neutral->{_is_flow_listbox_blue_w}
        || $param_widgets_neutral->{_is_flow_listbox_color_w}
        || $param_widgets_neutral->{_is_user_built_flow} )
    {

        $param_widgets_neutral->{_first_idx} =
          $ref_hash->{_param_flow_first_idx};
        $param_widgets_neutral->{_length} = $ref_hash->{_param_flow_length};

# print("3. param_widgets_neutral,range, (user-built-flow)  first idx:$param_widgets_neutral->{_first_idx}, and length:$param_widgets_neutral->{_length}\n");
    }

    # button for L_SU and no button for project selector
    if (   $ref_hash->{_is_superflow_select_button}
        || $ref_hash->{_is_superflow} )
    {

        $param_widgets_neutral->{_first_idx} =
          $ref_hash->{_superflow_first_idx};
        $param_widgets_neutral->{_length} = $ref_hash->{_superflow_length};

# print("4. param_widgets_neutral,range, (superflows) first idx:$param_widgets_neutral->{_first_idx}, and length:$param_widgets_neutral->{_length}\n");
    }

# print ("5. param_widgets_neutral,range, _values_w_aref:  $param_widgets_neutral->{_values_w_aref}\n");
    return ();
}

=head2 sub redisplay_check_buttons 
    
    update colors in check button boxes


=cut

sub redisplay_check_buttons {
    my ($self)        = @_;
    my $button_w_aref = $param_widgets_neutral->{_check_buttons_w_aref};
    my $first         = $param_widgets_neutral->{_first_idx};
    my $length =
      scalar @{ $param_widgets_neutral->{_check_buttons_settings_aref} }
      ;    # $param_widgets_neutral->{_length};
    my $settings_aref = $param_widgets_neutral->{_check_buttons_settings_aref};

# print("1. param_widgets_neutral,redisplay_check_buttons,settings @{$settings_aref}[0]\n");
# print("2. param_widgets_neutral,redisplay_check_buttons,settings @{$param_widgets_neutral->{_check_buttons_settings_aref}}[0]\n");

    if ( $button_w_aref && $settings_aref ) {

        for ( my $i = $first ; $i < $length ; $i++ ) {

            @$button_w_aref[$i]->configure(
                -onvalue          => 'on',
                -offvalue         => 'off',
                -selectcolor      => 'green',
                -activebackground => 'red',
                -background       => 'red',
                -variable         => \@$settings_aref[$i],
            );
        }
    }
    else {
        print(
"param_widgets_neutral, redisplay_check_buttons missing parameters\n"
        );
    }
    return ();
}

=head2 sub redisplay_labels 

  print("1. redisplay, resdisplay_labels, text is @{$label_array_ref}[$i]\n");
  print("redisplay, resdisplay_labels, i is $i\n");
  print("2. redisplay, resdisplay_labels, text is @{$LSU->{_label_array_ref}}[$i]\n");

=cut

sub redisplay_labels {
    my ($self)        = @_;
    my $labels_w_aref = $param_widgets_neutral->{_labels_w_aref};
    my $labels_aref   = $param_widgets_neutral->{_labels_aref};
    my $first         = $param_widgets_neutral->{_first_idx};
    my $length        = scalar @{ $param_widgets_neutral->{_labels_aref} };

    if ($labels_w_aref) {
        for ( my $i = $first ; $i < $length ; $i++ ) {

      # print("i:$i   param_widgets_neutral,redisplay_labels length:$length\n");
      # print(" text is @{$labels_aref}\n");
            @$labels_w_aref[$i]->configure( -text => @$labels_aref[$i], );
        }
    }
    else {
        print(
"param_widgets_neutral,redisplay labels, Warning parameters or labels_w_aref missing \n"
        );
    }
    return ();
}

=head2 sub redisplay_values 

  i/p: 2 array references
  o/p: array reference

  N.B. This is an ENTRY widget
  textvariables must be a reference in order
  for -validatecommand to work. BEWARE!

  DB

=cut 

sub redisplay_values {
    my ($self)        = @_;
    my $values_w_aref = $param_widgets_neutral->{_values_w_aref};
    my $values_aref   = $param_widgets_neutral->{_values_aref};
    my $first         = $param_widgets_neutral->{_first_idx};
    my $length        = scalar @{ $param_widgets_neutral->{_values_aref} };

    if ( $values_w_aref && $values_aref ) {
        use control;

        for ( my $i = $first ; $i < $length ; $i++ ) {

# print("1. param_widgets_neutral,redisplay_values,chkbtn @{$param_widgets_neutral->{_check_buttons_settings_aref}}[$i]\n");

            my $control = control->new();

# print("param_widgets_neutral, redisplay_values, i is $i\n");
# print("param_widgets_neutral, redisplay_values, value is @{$param_widgets_neutral->{_values_aref}}[$i]\n");

            #  &changes is invoked if
            #  there is a new selection after an entry change
            #  or even just if redisplay is selected
            #  a return of 0 by changes invokes error check
            # -validate				=> 'focusout',

            # remove terminal quotes for values, only for display purposes
            # when later read again the values will be given quotes if they
            # do not look like a number-- this occurs in a superclass
            @{$values_aref}[$i] =
              $control->get_no_quotes( @{$values_aref}[$i] );

            @$values_w_aref[$i]->configure(
                -textvariable    => \@{$values_aref}[$i],
                -validate        => 'all',
                -validatecommand => [ \&changes, $i ],
                -invalidcommand  => \&error_check,
            );

# print("2. param_widgets_neutral,redisplay_values,chkbtn @{$param_widgets_neutral->{_check_buttons_settings_aref}}[$i]\n");
        }
    }
    else {
        print("2. param_widgets_neutral,redisplay_values,missing parameters\n");
    }

# print("param_widgets_neutral, redisplay_values, first item's value is  @{$values_aref}[$first]\n");
# print("param_widgets_neutral, redisplay_values, last item's values is  @{$values_aref}[($length-1)]\n");
    return ();
}

=head2 sub set_current_program

	used in main by
	flow_select, 
	sunix_select 
	and delete_from_flow_button

=cut

sub set_current_program {

    my ( $self, $prog_name_sref ) = @_;
    if ($prog_name_sref) {
        $param_widgets_neutral->{_current_program_name} = $$prog_name_sref;

# print("param_widgets_neutral,set_current_program, program name: $param_widgets_neutral->{_current_program_name}\n");
    }
}

=head2 sub set_first_idx

=0

=cut

sub set_first_idx {

    my ($self) = @_;
    $param_widgets_neutral->{_first_idx} = 0;

    # print("param-widgets,first_idx:$param_widgets_neutral->{_first_idx}\n");
    return ();
}

=head2 sub set_labels_frame

 a widget reference

=cut

sub set_labels_frame {
    my ( $self, $labels_frame_href ) = @_;
    $param_widgets_neutral->{_labels_frame_href} = $labels_frame_href;

}

=head2 sub set_length

 override default length values
 
=cut

sub set_length {

    my ( $self, $length ) = @_;
    if ($length) {

        $param_widgets_neutral->{_length} = $length;

# print("param_widgets_neutral,set_length = $param_widgets_neutral->{_length}\n");

    }
    else {
        print("param_widgets_neutral,missing length\n");
    }
}

=head2 sub set_check_buttons_w_aref


=cut

sub set_check_buttons_w_aref {
    my ( $self, $check_buttons_w_aref ) = @_;

    if ($check_buttons_w_aref) {

        $param_widgets_neutral->{_check_buttons_w_aref} = $check_buttons_w_aref;

# print("param_widgets_neutral,set_check_buttons_w_aref, $check_buttons_w_aref \n");

    }
    else {
        print(
"param_widgets_neutral, set_check_buttons_w_aref,missing check_buttons_w_aref \n"
        );

    }
    return ();
}

=head2 set_labels_w_aref

=cut

sub set_labels_w_aref {
    my ( $self, $labels_w_aref ) = @_;

    if ($labels_w_aref) {

        $param_widgets_neutral->{_labels_w_aref} = $labels_w_aref;

        # print("param_widgets_neutral,set_labels_w_aref, $labels_w_aref \n");

    }
    else {
        print(
            "param_widgets_neutral,set_labels_w_aref, missing labels_w_aref \n"
        );

    }
    return ();
}

=head2 set_values_w_aref

=cut

sub set_values_w_aref {
    my ( $self, $values_w_aref ) = @_;

    if ($values_w_aref) {

        $param_widgets_neutral->{_values_w_aref} = $values_w_aref;

# print("param_widgets_neutral,set_values_w_aref,  $param_widgets_neutral->{_values_w_aref}\n");

    }
    else {
        print(
            "param_widgets_neutral,set_values_w_aref, missing values_w_aref \n"
        );
    }
    return ();
}

=head2 sub show_values 

packing

=cut

sub show_values {
    my ($self) = @_;
    my ( $first, $length );
    my (@values_w);

    @values_w = @{ $param_widgets_neutral->{_values_w_aref} };
    $first    = $param_widgets_neutral->{_first_idx};
    $length   = $param_widgets_neutral->{_length};

    # print("param_widgets_neutral,show_values,first:$first\n");
    # print("param_widgets_neutral,show_values,length:$length\n");

    for ( my $i = $first ; $i < $length ; $i++ ) {

    # print("param_widgets_neutral,show_values,values_w at $i $values_w[$i]\n");
        $values_w[$i]->pack(
            -side   => 'top',
            -anchor => 'w',
            -fill   => 'x'
        );
    }
    return ();
}

=head2 sub set_check_buttons_frame
 
 set check_buttons by user from outside 

=cut

sub set_check_buttons_frame {
    my ( $self, $check_buttons_frame_href ) = @_;
    $param_widgets_neutral->{_check_buttons_frame_href} =
      $check_buttons_frame_href;

    return ();
}

=head2 sub set_entry_change_status 

=cut

sub set_entry_change_status {
    my ( $self, $status ) = @_;
    $param_widgets_neutral->{_changed_entry} = $status;

    # print("param_widgets_neutral, set_entry_change_status: to $status\n");
    return ();
}

=head2 sub set_location_in_gui

 set check_buttons by user from outside 
 
	     	foreach my $key (sort keys %$here) {
   			print (" param_widgets,set_location_in_gui, key is $key, value is $here->{$key}\n");
  		} 

=cut

sub set_location_in_gui {
    my ( $self, $location_href ) = @_;
    my $here = $location_href;

#print("param_widgets_neutral, set_location_in_gui , _values_w_aref, $param_widgets_neutral->{_values_w_aref} \n");

    if ( $here->{_is_flow_listbox_grey_w} && $here->{_is_add2flow} ) {

        _reset $param_widgets_neutral->{_is_flow_listbox_grey_w} = $true;
        $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_flow_listbox_grey_w and _is_add2flow \n");

    }
    elsif ( $here->{_is_flow_listbox_grey_w} ) {

        _reset $param_widgets_neutral->{_is_flow_listbox_grey_w} = $true;
        $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_flow_listbox_grey_w ++ true\n");

    }
    elsif ( $here->{_is_flow_listbox_pink_w} ) {

        _reset $param_widgets_neutral->{_is_flow_listbox_pink_w} = $true;
        $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_flow_listbox_pink_w ++\n");

    }
    elsif ( $here->{_is_flow_listbox_green_w} ) {

        _reset $param_widgets_neutral->{_is_flow_listbox_green_w} = $true;
        $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_flow_listbox_green_w ++\n");

    }
    elsif ( $here->{_is_flow_listbox_blue_w} ) {

        _reset $param_widgets_neutral->{_is_flow_listbox_blue_w} = $true;
        $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_flow_listbox_blue_w ++\n");

    }
    elsif ( $here->{_is_flow_listbox_color_w} ) {

        _reset $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_flow_listbox_color_w\n");

    }
    elsif ( $here->{_is_add2flow} ) {

        $param_widgets_neutral->{_is_new_listbox_selection} =
          $true;    # so change not allowed
         # print("param_widgets_neutral, set_location_in_gui, _is_new_listbox_selection \n");

    }
    elsif ( $here->{_is_add2flow_button} ) {

        _reset $param_widgets_neutral->{_is_new_listbox_selection} =
          $true;    # so change not allowed
         # print("param_widgets_neutral, set_location_in_gui, _is_new_listbox_selection \n");

    }
    elsif ( $here->{_is_sunix_listbox} ) {

        _reset();
        $param_widgets_neutral->{_is_new_listbox_selection} =
          $true;    # so changes not allowed
        $param_widgets_neutral->{_is_sunix_listbox} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_sunix_listbox and _is_new_listbox_selection\n");

    }
    elsif ( $here->{_is_moveNdrop_in_flow} ) {

        _reset();
        $param_widgets_neutral->{_is_flow_listbox_grey_w}  = $true;
        $param_widgets_neutral->{_is_flow_listbox_pink_w}  = $true;
        $param_widgets_neutral->{_is_flow_listbox_green_w} = $true;
        $param_widgets_neutral->{_is_flow_listbox_blue_w}  = $true;
        $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;
        $param_widgets_neutral->{_is_moveNdrop_in_flow}    = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_moveNdrop_in_flow ++ \n");

    }
    elsif ( $here->{_is_delete_from_flow_button} ) {

        _reset();
        $param_widgets_neutral->{_is_delete_from_flow_button} = $true;

        # TODO double check if next 2-5 lines should be flse instead
        $param_widgets_neutral->{_is_flow_listbox_grey_w}  = $true;
        $param_widgets_neutral->{_is_flow_listbox_pink_w}  = $true;
        $param_widgets_neutral->{_is_flow_listbox_green_w} = $true;
        $param_widgets_neutral->{_is_flow_listbox_blue_w}  = $true;
        $param_widgets_neutral->{_is_flow_listbox_color_w} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_delete_from_flow_button ++\n");

    }
    elsif ( $here->{_is_superflow_select_button} ) {

        _reset

# print("param_widgets_neutral,NEW set_location_in_gui, superflow_select_button\n");
          $param_widgets_neutral->{_is_superflow_select_button} = $true;

# print("param_widgets_neutral, set_location_in_gui, _is_superflow_select_button \n")

    }
    else {
        print("param_widgets_neutral, set_location_in_gui, missing  params \n");
    }
    return ();
}

=head2 sub set_labels 
 
 set labels by user from outside 

=cut

sub set_labels {
    my ( $self, $labels_aref ) = @_;
    $param_widgets_neutral->{_labels_aref} = $labels_aref;
    return ();
}

=head2 sub set_prog_name_sref 
 set prog_name by user from outside 

=cut

sub set_prog_name_sref {
    my ( $self, $prog_name_sref ) = @_;

    if ($prog_name_sref) {
        $param_widgets_neutral->{_prog_name_sref} = $prog_name_sref;

        print("param_widgets_neutral,set_prog_name_sref, $$prog_name_sref\n");

    }
    else {
        print("param_widgets_neutral, set_prog_name_sref, missing prog name\n");
    }
    return ();
}

=head2 sub set_value4entry_button_chosen

 dassign value to  Entry Buttonchosen

    print("param is $entry_param;\n");
         print ("selected widget is # $LSU->{_parameter_value_index}\");
         print ("label is  $out\n");

=cut

sub set_value4entry_button_chosen {
    my ( $self, $value ) = @_;

    # first and last indices
    my $first  = $param_widgets_neutral->{_first_idx};
    my $length = $param_widgets_neutral->{_length};

# print("param_widgets_neutral,set_entry_button_chosen,length_=$param_widgets_neutral->{_length} \n");

    my $widget = $param_widgets_neutral->{_entry_button_chosen_widget};
    print("param_widgets_neutral,set_entry_button_chosen,widget,=$widget\n");

    # run through widgets until the match is made
    for ( my $choice = $first ; $choice < $length ; $choice++ ) {
        if ( $widget eq @{ $param_widgets_neutral->{_values_w_aref} }[$choice] )
        {

            @{ $param_widgets_neutral->{_values_w_aref} }[$choice]
              ->configure( -text => $value );

            print(
"param_widgets_neutral,set_entry_button_chosen,value= @{$param_widgets_neutral->{_values_w_aref}}[$choice]\n"
            );
            print(
"param_widgets_neutral,set_entry_button_chosen,choice= $choice\n"
            );

        }
    }
    return ($value);
}

=head2 sub set_values 
 
 set values by user from outside 

=cut

sub set_values {
    my ( $self, $values_aref ) = @_;

    if ($values_aref) {
        $param_widgets_neutral->{_values_aref} = $values_aref;

#print("param_widgets_neutral,set_values,@{$param_widgets_neutral->{_values_aref}}\n");
    }
    else {
        print("param_widgets_neutral,set_values,_values_aref missing\n");
    }

    return ();
}

=head2 sub show_check_buttons 

packing

=cut

sub show_check_buttons {
    my ($self)       = @_;
    my $button_w_ref = $param_widgets_neutral->{_check_buttons_w_aref};
    my $first        = $param_widgets_neutral->{_first_idx};
    my $length       = $param_widgets_neutral->{_length};

    for ( my $i = $first ; $i < $length ; $i++ ) {
        @$button_w_ref[$i]->pack( -anchor => 'n', -fill => 'y' );
    }
    return ();

}

=head2 sub show_labels 
 
 specs come from local private variables
 uses default specs, unless overwritten
 specs are not fed from above
 
 packing

=cut

sub show_labels {
    my ($self) = @_;
    my ( $first, $length );
    my (@labels_w);

    @labels_w = @{ $param_widgets_neutral->{_labels_w_aref} };
    $first    = $param_widgets_neutral->{_first_idx};
    $length   = $param_widgets_neutral->{_length};

    # print("param_widgets_neutral,show_labels,first:$first\n");
    # print("param_widgets_neutral,show_labels,length:$length\n");
    for ( my $i = $first ; $i < $length ; $i++ ) {
        $labels_w[$i]->pack(
            -side   => 'top',
            -anchor => 'w',
            -fill   => 'x'
        );
    }
    return ();
}

1;
