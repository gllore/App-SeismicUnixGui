use Moose;

		use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';

		my $L_SU_global_constants 		= L_SU_global_constants->new();
        my $program_name 				= 'iPick';
		my $module_spec_pm 				= $program_name . '_spec.pm';

		$L_SU_global_constants->set_file_name($module_spec_pm);
		my $slash_path4spec 			= $L_SU_global_constants->get_path4spec_file();
		my $slash_pathNmodule_spec_pm   = $slash_path4spec . '/' . $module_spec_pm;		

		$L_SU_global_constants->set_program_name($program_name);
		my $colon_pathNmodule_spec 		= $L_SU_global_constants->get_colon_pathNmodule_spec();

	 	print("1. _get_suffix_aref, prog_name: $slash_pathNmodule_spec_pm\n");	 
	 	print("1. _get_suffix_aref, prog_name: $colon_pathNmodule_spec\n");

		require $slash_pathNmodule_spec_pm;
		
#		INSTANTIATE
		my $package = $colon_pathNmodule_spec->new();