
			if ( ( $gui_history->get_defaults() )->{_wipe_plots_button_click_seq_href} ) {

				# print additional subsets: _wipe_plots_button
				$key_hash_ref
					= ( $gui_history->get_defaults() )->{_wipe_plots_button_click_seq_href};

				# print("gui_history, view, key_hash_ref = $key_hash_ref \n");
				foreach my $sub2_key ( sort keys %{$key_hash_ref} ) {
					my $ans = $key_hash_ref->{$sub2_key};
					if ( defined $ans and $ans ne $empty_string ) {

						# print(" key_hash_ref->{$sub2_key}: $sub2_key= $ans\n");
						print $fh (
							" ( (gui_history->get_defaults() )->{_wipe_plots_button_click_seq_href})->{$sub2_key}: $sub2_key= $ans\n"
						);
