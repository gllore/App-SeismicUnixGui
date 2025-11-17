# sub set_defaults4end_of_delete_whole_flow_button {
# 	my ($self) = @_;

# 	my $color = _get_flow_color();

# 	if (   $color eq 'grey'
# 		|| $color eq 'pink'
# 		|| $color eq 'green'
# 		|| $color eq 'blue' ) {

# 		# the last program that was touched is cancelled out
# 		$last_flow_index_touched = -1;

# 		$flow_item_down_arrow_button->configure( -state => 'disabled', );
# 		$flow_item_up_arrow_button->configure( -state => 'disabled', );
# 		$delete_from_flow_button->configure( -state => 'disabled', );
# 		$delete_whole_flow_button->configure( -state => 'disabled', );

# 	} else {
# 		print("conditions4flows, set_defaults4delete_whole_flow_button, color missing: $color\n");
# 	}

# 	if ( $color eq 'grey' ) {

# 		$conditions4flows->{_is_flow_listbox_grey_w} = $false;
# 		@{ $conditions4flows->{_occupied_listbox_aref} }[0] = $false;
# 		@{ $conditions4flows->{_vacant_listbox_aref} }[0]   = $true;

# 		# turn off flow listbox
# 		$flow_listbox_grey_w->configure( -state => 'disabled', );

# 		# name is removed from the namespace
# 		$conditions4flows->{_flow_name_out_grey} = $empty_string;

# 		# for export
# 		$is_flow_listbox_grey_w = $false;
# 		$flow_name_out_grey     = $empty_string;

# 		# the last program that was touched is cancelled out
# 		$is_last_flow_index_touched_grey = $false;

# 	} elsif ( $color eq 'pink' ) {

# 		$conditions4flows->{_is_flow_listbox_pink_w} = $false;
# 		@{ $conditions4flows->{_occupied_listbox_aref} }[1] = $false;
# 		@{ $conditions4flows->{_vacant_listbox_aref} }[1]   = $true;

# 		# turn off flow -listbox
# 		$flow_listbox_pink_w->configure( -state => 'disabled', );

# 		# name is removed from the namespace
# 		$conditions4flows->{_flow_name_out_pink} = $empty_string;

# 		# for export
# 		$is_flow_listbox_pink_w = $false;
# 		$flow_name_out_pink          = $empty_string;

# 		# the last program that was touched is cancelled out
# 		$is_last_flow_index_touched_pink = $false;

# 	} elsif ( $color eq 'green' ) {

# 		$conditions4flows->{_is_flow_listbox_green_w} = $false;
# 		@{ $conditions4flows->{_occupied_listbox_aref} }[2] = $false;
# 		@{ $conditions4flows->{_vacant_listbox_aref} }[2]   = $true;

# 		# turn off flow -listbox
# 		$flow_listbox_green_w->configure( -state => 'disabled', );

# 		# name is removed from the namespace
# 		$conditions4flows->{_flow_name_out_green} = $empty_string;

# 		# for export
# 		$is_flow_listbox_green_w = $false;
# 		$flow_name_out_green           = $empty_string;

# 		# the last program that was touched is cancelled out
# 		$is_last_flow_index_touched_green = $false;

# 	} elsif ( $color eq 'blue' ) {

# 		$conditions4flows->{_is_flow_listbox_blue_w} = $false;
# 		@{ $conditions4flows->{_occupied_listbox_aref} }[3] = $false;
# 		@{ $conditions4flows->{_vacant_listbox_aref} }[3]   = $true;

# 		# turn off flow -listbox
# 		$flow_listbox_blue_w->configure( -state => 'disabled', );

# 		# name is removed from the namespace
# 		$conditions4flows->{_flow_name_out_blue} = $empty_string;

# 		# for export
# 		$is_flow_listbox_blue_w = $false;
# 		$flow_name_out_blue          = $empty_string;

# 		# the last program that was touched is cancelled out
# 		$is_last_flow_index_touched_blue = $false;

# 	} else {
# 		print("conditions4flows, set_defaults4delete_whole_flow_buttonset, color missing: $color\n");
# 	}

# 	my $number = _get_num_listboxes_occupied();

# 	# print("conditions4flows, set_defaults4delete_whole_flow_button, number of list boxes occupied=$number\n");

# 	# because the last item in last listbox is deleted
# 	# print("conditions4flows, set_defaults4delete_whole_flow_button, if number < 0 remove this if statement\n");
# 	# turn off delete button
# 	$delete_from_flow_button->configure( -state => 'disabled', );

# 	# turn off delete whole flow button
# 	$delete_whole_flow_button->configure( -state => 'disabled', );

# 	# turn off up-arrow
# 	$flow_item_up_arrow_button->configure( -state => 'disabled', );

# 	# turn off down_arrow
# 	$flow_item_down_arrow_button->configure( -state => 'disabled', );

# 	# turn off run button
# 	#		$run_button->configure( -state => 'disabled' );

# 	#		# turn off SaveAs menu button
# 	#		$SaveAs_menubutton->configure( -state => 'disabled' );

# 	#		# turn off Data menu button
# 	#		$Data_menubutton->configure( -state => 'disabled' );

# 	#		# turn on Flow menu button
# 	$Open_menubutton->configure( -state => 'normal' );

# 	# turn off save button
# 	#		$save_button->configure( -state => 'disabled' );

# 	# turn off  check_code_button
# #	$check_code_button->configure( -state => 'disabled' );

# 	$conditions4flows->{_is_flow_listbox_color_w}        = $false;
# 	$conditions4flows->{_is_user_built_flow}             = $false;
# 	$conditions4flows->{_is_sunix_listbox}               = $false;
# 	$conditions4flows->{_is_delete_from_flow_button}     = $false;
# 	$conditions4flows->{_is_delete_whole_flow_button}    = $false;
# 	$conditions4flows->{_is_flow_item_down_arrow_button} = $false;
# 	$conditions4flows->{_is_flow_item_up_arrow_button}   = $false;

# 	# for export
# 	$is_delete_from_flow_button     = $false;
# 	$is_delete_whole_flow_button    = $false;
# 	$is_flow_item_down_arrow_button = $false;
# 	$is_flow_item_up_arrow_button   = $false;

# 	$is_flow_listbox_color_w = $false;
# 	$is_sunix_listbox        = $false;
# 	$is_user_built_flow      = $false;

# 	return ();
# }
