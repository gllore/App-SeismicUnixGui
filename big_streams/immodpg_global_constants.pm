package immodpg_global_constants;

use Moose;

=head private hash
similar names as the variables in immodpg.for
in the DICTIONARY ~ line 55
and also in moveNzoom.for

loop_limit:			for searching for a locked_file 

=cut

my $var = {
	_Vbot_file							=> 'Vbot', 
	_Vbot_minus_opt						=> 21,
	_Vbot_plus_opt						=> 22,
	_Vbot_upper_layer_file				=> 'Vbot_upper_layer', 	
	_VbotNVtop_lower_layer_plus_opt		=> 62,
    _VbotNVtop_lower_layer_minus_opt	=> 61,	
	_VbotNtop_minus_opt					=> 41,
	_VbotNtop_plus_opt					=> 42,
	_Vincrement_file					=> 'Vincrement',
	_Vincrement_opt						=> 7,
	_Vtop_file							=> 'Vtop',
	_Vtop_lower_layer_file				=> 'Vtop_lower_layer',					
    _Vtop_minus_opt						=> 12,
	_Vtop_plus_opt						=> 13,
    _VbotNtop_factor_file               => 'VbotNtop_factor',  
	_VbotNtop_multiply_opt				=> 16,
	_VtopNVbot_upper_layer_minus_opt   	=> 51,
	_VtopNVbot_upper_layer_plus_opt   	=> 52,
	_Vbot_opt						    => 20,	
	_Vbot_upper_layer_opt		    => 23,
	_Vtop_lower_layer_opt				=> 11,			
	_Vtop_opt							=> 10,	
	_changeVbotNtop_factor_opt			=> 68,
	_VbotNtop_factor_opt			    => 68,
	_change_default						=> 'no',
	_change_file						=> 'change',
	_change_layer_number_opt			=> 0,
	_change_thickness_m_opt				=> 14,
	_change_thickness_increment_m_opt		=> 15,	
	_clip_file							=> 'clip',
    _clip4plot_opt						=> 9,
    _config_file_format			        => '%-35s%1s%-20s',
    _config_file_format_clip			=> '%-35s%1s%-5.1f',
    _config_file_format_real			=> '%-35s%1s%-10.3f', 
    _config_file_format_signed_integer	=> '%-35s%1s%-2d', 
    _format_integer							=>'%i',
     _format_real							   =>'%7.1f',  
     _format_string							=>'%s',      
    _exit_opt							=> 99,
    _immodpg_model	                    => 'immodpg.out',
    _immodpg_model_file_text		    => 'model.txt',
    _layer_file							=> 'layer',
    _loop_limit							=> 100,
    _move_down_opt						=> 83, 
	_move_left_opt						=> 84,
	_move_up_opt						=> 81,
	_move_right_opt						=> 82,
#	_multiply_velocities_by_constant_opt =>11,
    _option_file						=> 'option',
    _thickness_increment_m_file			=> 'thickness_increment_m',     
     _thickness_m_file			=> 'thickness_m', 
    _thickness_m_minus_opt					=> 140,
    _thickness_m_plus_opt					=> 141,
	_zoom_minus_opt						=> 86,
	_zoom_plus_opt						=> 85,
};


sub var {
	my ($self) = @_;
	
    return ($var);
}

1;