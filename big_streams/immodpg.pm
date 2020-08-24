package immodpg;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: immodpg 
 AUTHOR: Juan Lorenzo
 DATE:   Feb 6 2020
 DESCRIPTION: 
 Version: 0.0.1
 

=head2 USE

=head3 NOTES
	    
	   Original Fortran code is by Emilio Vera
	   and is called mmodpg
	   
	   Modeling of Traveltime (T-X) Curves
	    
	   LDG:146O , 1984-1989
	   BOIGM, 1993
	   Depto. de Geofisica, U. de Chile, 1996-**
	    
	   Computations are carried out for a model consisting
	   of a mixture of horizontal constant velocity, and
   	  constant velocity gradient layers.Low velocity zones
	   can be included. Each layer is specified by its top
       and bottom velocity. Rays are traced using equispaced
	   ray parameterss.
	    
	   Data traces are presented  as a grey scale plot.
	   
	   TODO: _Vbot vs. _Vbot_current may confuse
	   key _Vbot is used only initially herein
	   _Vbot_current is the latest value in the gui
	   
	   The following order of operations is needed
	   to prevent the fortran programs from quickly 
	   reading the change (yes) BEFORE the options
	   and values are written out.
	   
	  _setVtop( $immodpg->{_Vtop_current} );
	  _set_option($changeVtop_opt);
	 _set_change($yes);
	   

=head4 
 Examples

=head3 

=head4 CHANGES and their DATES


=cut

use Moose;
our $VERSION = '0.0.1';
use L_SU_global_constants();
use Project_config;
use immodpg_config;
use immodpg_global_constants();
use Scalar::Util qw(looks_like_number);

my $Project        = Project_config->new();
my $get_L_SU       = new L_SU_global_constants();
my $get_immodpg    = new immodpg_global_constants;
my $immodpg_config = immodpg_config->new();

my $var_L_SU          = $get_L_SU->var();
my $var_immodpg       = $get_immodpg->var();
my $IMMODPG           = $Project->IMMODPG();
my $IMMODPG_INVISIBLE = $Project->IMMODPG_INVISIBLE();

my $empty_string = $var_L_SU->{_empty_string};
my $yes          = $var_L_SU->{_yes};
my $no           = $var_L_SU->{_no};

=head2 private anonymous array

=cut

my $immodpg = {
	_Vbot                             => '',
	_VbotEntry                        => '',
	_Vbot_current                     => '',
	_Vbot_default                     => '',
	_Vbot_multiplied                  => '',
	_Vbot_prior                       => '',
	_Vbot_upper_layer                 => '',
	_Vbot_upper_layerEntry            => '',
	_Vbot_upper_layer_current         => '',
	_Vbot_upper_layer_default         => '',
	_Vbot_upper_layer_prior           => '',
	_Vincrement                       => '',
	_VincrementEntry                  => '',
	_Vincrement_current               => '',
	_Vincrement_default               => '',
	_Vincrement_prior                 => '',
	_Vtop                             => '',
	_Vtop_current                     => '',
	_Vtop_prior                       => '',
	_Vtop_lower_layer_current         => '',
	_Vtop_lower_layer                 => '',
	_Vtop_lower_layer_prior           => '',
	_Vtop_multiplied                  => '',
	_VbotNtop_factor                  => '',
	_VbotNtop_factorEntry             => '',
	_VbotNtop_factor_current          => '',
	_VbotNtop_factor_default          => '',
	_VbotNtop_factor_prior            => '',
	_base_file_name                   => '',
	_cdp                              => '',
	_change_file                      => '',
	_change_default                   => $no,
	_clip                             => '',
	_clip_file                        => '',
	_clip4plot                        => '',
	_clip4plotEntry                   => '',
	_clip4plot_current                => '',
	_clip4plot_default                => '',
	_clip4plot_prior                  => '',
	_data_traces                      => '',
	_control_layer                    => '',
	_control_layer_external           => '',
	_inVbot                           => '',
	_inVbot_upper_layer               => '',
	_inVincrement                     => '',
	_inVtop                           => '',
	_inVtop_lower_layer               => '',
	_inVbotNtop_factor                => '',
	_in_clip                          => '',
	_in_layer                         => '',
	_layerEntry                       => '',
	_layer_current                    => '',
	_layer_default                    => '',
	_layer_prior                      => '',
	_in_thickness_increment_m         => '',
	_invert                           => '',
	_isVbot_changed                   => $no,
	_isVbot_upper_layer_changed       => $no,
	_isVincrement_changed             => $no,
	_isVtop_changed                   => $no,
	_isVtop_lower_layer_changed       => $no,
	_isVbotNtop_factor_changed        => $no,
	_is_clip_changed                  => $no,
	_is_layer_changed                 => $no,
	_is_thickness_increment_m_changed => $no,
	_layer                            => '',
	_layer_file                       => '',
	_lmute                            => '',
	_lower_layerLabel                 => '',
	_min_t_s                          => '',
	_min_x_m                          => '',
	_model_file_text                  => $var_immodpg->{_immodpg_model_file_text},
	_model_layer_number               => '',
	_new_model                        => '',
	_option_default                   => -1,
	_option_file                      => '',
	_outsideVbot                      => '',
	_outsideVbot_upper_layer          => '',
	_outsideVincrement                => '',
	_outsideVtop                      => '',
	_outsideVtop_lower_layer          => '',
	_outsideVbotNtop_factor           => '',
	_outside_clip                     => '',
	_outside_layer                    => '',
	_outside_thickness_increment_m    => '',
	_par                              => '',
	_plot_max_t_s                     => '',
	_plot_max_x_m                     => '',
	_plot_min_t_s                     => '',
	_plot_min_x_m                     => '',
	_pre_digitized_XT_pairs           => '',
	_previous_model                   => '',
	_receiver_depth_m                 => '',
	_reducing_vel_mps                 => '',
	_scaled_par                       => '',
	_smute                            => '',
	_source_depth_m                   => '',
	_sscale                           => '',
	_tnmo                             => '',
	_upper_layerLabel                 => '',
	_upward                           => '',
	_vnmo                             => '',
	_voutfile                         => '',
	_thickness_increment_m            => '',
	_thickness_increment_mEntry       => '',
	_thickness_increment_m_current    => '',
	_thickness_increment_m_default    => '',
	_thickness_increment_m_prior      => '',
	_Step                             => '',
	_note                             => '',
};

#	print("immodpg, starting, _isVtop_lower_layer_changed: $immodpg->{_isVtop_lower_layer_changed}\n");

=head2 Define
private variables

=cut

$immodpg->{_Vbot_file}                  = $var_immodpg->{_Vbot_file};
$immodpg->{_Vbot_upper_layer_file}      = $var_immodpg->{_Vbot_upper_layer_file};
$immodpg->{_Vincrement_file}            = $var_immodpg->{_Vincrement_file};
$immodpg->{_Vtop_file}                  = $var_immodpg->{_Vtop_file};
$immodpg->{_Vtop_lower_layer_file}      = $var_immodpg->{_Vtop_lower_layer_file};
$immodpg->{_VbotNtop_factor_file}       = $var_immodpg->{_VbotNtop_factor_file};
$immodpg->{_VbotNtop_multiply_file}     = $var_immodpg->{_VbotNtop_multiply_file};
$immodpg->{_option_file}                = $var_immodpg->{_option_file};
$immodpg->{_change_file}                = $var_immodpg->{_change_file};
$immodpg->{_clip_file}                  = $var_immodpg->{_clip_file};
$immodpg->{_layer_file}                 = $var_immodpg->{_layer_file};
$immodpg->{_immodpg_model}              = $var_immodpg->{_immodpg_model};
$immodpg->{_thickness_m_file}           = $var_immodpg->{_thickness_m_file};
$immodpg->{_thickness_increment_m_file} = $var_immodpg->{_thickness_increment_m_file};

=head2 Coded user options
Only used in message files
for communication with
immopg.for
'change*_opt' subs change values of repeatedly
used variables whereas other subs change
values of variables more frequently modified
by user

=cut

my $move_down_opt         = $var_immodpg->{_move_down_opt};
my $move_left_opt         = $var_immodpg->{_move_left_opt};
my $move_minus_opt        = $var_immodpg->{_move_minus_opt};
my $move_right_opt        = $var_immodpg->{_move_right_opt};
my $move_up_opt           = $var_immodpg->{_move_up_opt};
my $thickness_m_plus_opt  = $var_immodpg->{_thickness_m_plus_opt};
my $thickness_m_minus_opt = $var_immodpg->{_thickness_m_minus_opt};
my $zoom_minus_opt        = $var_immodpg->{_zoom_minus_opt};
my $zoom_plus_opt         = $var_immodpg->{_zoom_plus_opt};

my $Vbot_opt                        = $var_immodpg->{_Vbot_opt};
my $Vbot_upper_layer_opt            = $var_immodpg->{_Vbot_upper_layer_opt};
my $Vbot_minus_opt                  = $var_immodpg->{_Vbot_minus_opt};
my $Vbot_plus_opt                   = $var_immodpg->{_Vbot_plus_opt};
my $Vtop_opt                        = $var_immodpg->{_Vtop_opt};
my $Vtop_lower_layer_opt            = $var_immodpg->{_Vtop_lower_layer_opt};
my $Vtop_minus_opt                  = $var_immodpg->{_Vtop_minus_opt};
my $Vtop_plus_opt                   = $var_immodpg->{_Vtop_plus_opt};
my $VbotNVtop_lower_layer_minus_opt = $var_immodpg->{_VbotNVtop_lower_layer_minus_opt};
my $VbotNVtop_lower_layer_plus_opt  = $var_immodpg->{_VbotNVtop_lower_layer_plus_opt};
my $VtopNVbot_upper_layer_minus_opt = $var_immodpg->{_VtopNVbot_upper_layer_minus_opt};
my $VtopNVbot_upper_layer_plus_opt  = $var_immodpg->{_VtopNVbot_upper_layer_plus_opt};
my $VbotNtop_multiply_opt           = $var_immodpg->{_VbotNtop_multiply_opt};
my $VbotNtop_plus_opt               = $var_immodpg->{_VbotNtop_plus_opt};
my $VbotNtop_minus_opt              = $var_immodpg->{_VbotNtop_minus_opt};
my $update_opt                      = $var_immodpg->{_update_opt};

my $change_clip_opt                  = $var_immodpg->{_clip4plot_opt};
my $change_layer_number_opt          = $var_immodpg->{_change_layer_number_opt};
my $change_thickness_increment_m_opt = $var_immodpg->{_change_thickness_increment_m_opt};
my $change_thickness_m_opt           = $var_immodpg->{_change_thickness_m_opt};
my $changeVtop_opt                   = $var_immodpg->{_Vtop_opt};
my $changeVincrement_opt             = $var_immodpg->{_Vincrement_opt};
my $changeVbotNtop_factor_opt        = $var_immodpg->{_VbotNtop_factor_opt};

=head2 sub Step
collects switches and assembles bash instructions
by adding the program name

=cut

sub Step {

	$immodpg->{_Step} = 'mmodpg' . $immodpg->{_Step};
	return ( $immodpg->{_Step} );

}

=head2 sub note
collects switches and assembles bash instructions
by adding the program name

=cut

sub note {

	$immodpg->{_note} = 'mmodpg' . $immodpg->{_note};
	return ( $immodpg->{_note} );

}

=head2 sub _checkVbot
When you use setVbot
check what the current Vbot value is
compared to former Vbot values

=cut

sub _checkVbot {

	my ($self) = @_;

	# print("immodpg, _checkVbot, $immodpg->{_VbotEntry}\n");

	if (   defined $immodpg->{_VbotEntry}
		&& $immodpg->{_VbotEntry} ne $empty_string
		&& $immodpg->{_inVbot} ne $empty_string
		&& $immodpg->{_outsideVbot} ne $empty_string
		&& $immodpg->{_Vbot_current} ne $empty_string
		&& $immodpg->{_Vbot_prior} ne $empty_string ) {

		# rename for convenience
		my $inVbot       = $immodpg->{_inVbot};
		my $outsideVbot  = $immodpg->{_outsideVbot};
		my $Vbot_current = $immodpg->{_Vbot_current};
		my $Vbot_prior   = $immodpg->{_Vbot_prior};

		# print("immodpg,_checkVbot, inVbot:$inVbot\n");
		# print("immodpg,_checkVbot, outsideVbot: $outsideVbot\n");
		if (   $inVbot eq $yes
			&& $outsideVbot eq $no ) {

			# print("immodpg, _checkVbot, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$Vbot_current = $immodpg->{_VbotEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$inVbot      = $no;
			$outsideVbot = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_inVbot}       = $inVbot;
			$immodpg->{_outsideVbot}  = $outsideVbot;
			$immodpg->{_Vbot_current} = $Vbot_current;

			return ();

		} elsif ( $inVbot eq $no
			&& $outsideVbot eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$Vbot_prior   = $Vbot_current;
			$Vbot_current = $immodpg->{_VbotEntry}->get();

			# print("immodpg, _checkVbot, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$inVbot      = $yes;
			$outsideVbot = $no;

			# reset module values for convenience of renaming
			$immodpg->{_inVbot}       = $inVbot;
			$immodpg->{_outsideVbot}  = $outsideVbot;
			$immodpg->{_Vbot_current} = $Vbot_current;
			$immodpg->{_Vbot_prior}   = $Vbot_prior;
			return ();

		} else {
			print("immodpg, _checkVbot, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _checkVbot, missing widget\n");
		return ();
	}
}

=head2 sub _checkVbot_upper_layer

When you use setVbot_upper_layer
check what the current setVbot_upper_layer value is
compared to former setVbot_upper_layer values

=cut

sub _checkVbot_upper_layer {

	my ($self) = @_;

	#	print("immodpg, _checkVbot_upper_layer, $immodpg->{_Vbot_upper_layerEntry}\n");

	if (   length( $immodpg->{_Vbot_upper_layerEntry} )
		&& $immodpg->{_Vbot_upper_layerEntry} ne $empty_string
		&& $immodpg->{_inVbot_upper_layer} ne $empty_string
		&& $immodpg->{_outsideVbot_upper_layer} ne $empty_string
		&& $immodpg->{_Vbot_upper_layer_current} ne $empty_string
		&& $immodpg->{_Vbot_upper_layer_prior} ne $empty_string ) {

		# rename for convenience
		my $inVbot_upper_layer       = $immodpg->{_inVbot_upper_layer};
		my $outsideVbot_upper_layer  = $immodpg->{_outsideVbot_upper_layer};
		my $Vbot_upper_layer_current = $immodpg->{_Vbot_upper_layer_current};
		my $Vbot_upper_layer_prior   = $immodpg->{_Vbot_upper_layer_prior};

		# print("immodpg,_checkVbot_upper_layer, inVbot_upper_layer:$inVbot_upper_layer\n");
		# print("immodpg,_checkVbot_upper_layer, outsideVbot_upper_layer: $outsideVbot_upper_layer\n");
		if (   $inVbot_upper_layer eq $yes
			&& $outsideVbot_upper_layer eq $no ) {

			#			print("immodpg, _checkVbot_upper_layer, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$Vbot_upper_layer_current = $immodpg->{_Vbot_upper_layerEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$inVbot_upper_layer      = $no;
			$outsideVbot_upper_layer = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_inVbot_upper_layer}       = $inVbot_upper_layer;
			$immodpg->{_outsideVbot_upper_layer}  = $outsideVbot_upper_layer;
			$immodpg->{_Vbot_upper_layer_current} = $Vbot_upper_layer_current;

			return ();

		} elsif ( $inVbot_upper_layer eq $no
			&& $outsideVbot_upper_layer eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$Vbot_upper_layer_prior   = $Vbot_upper_layer_current;
			$Vbot_upper_layer_current = $immodpg->{_Vbot_upper_layerEntry}->get();

			#			print("immodpg, _checkVbot_upper_layer, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$inVbot_upper_layer      = $yes;
			$outsideVbot_upper_layer = $no;

			# reset module values for convenience of renaming
			$immodpg->{_inVbot_upper_layer}       = $inVbot_upper_layer;
			$immodpg->{_outsideVbot_upper_layer}  = $outsideVbot_upper_layer;
			$immodpg->{_Vbot_upper_layer_current} = $Vbot_upper_layer_current;
			$immodpg->{_Vbot_upper_layer_prior}   = $Vbot_upper_layer_prior;
			return ();

		} else {
			print("immodpg, _checkVbot_upper_layer, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _checkVbot_upper_layer, missing widget or values\n");
		return ();
	}
}

=head2 sub _checkVincrement

When you use Vincrement
check what the current Vincrement value is
compared to former Vincrement values

=cut

sub _checkVincrement {

	my ($self) = @_;

	# print("immodpg, _checkVincrement, $immodpg->{_VincrementEntry}\n");

	if (   defined $immodpg->{_VincrementEntry}
		&& $immodpg->{_VincrementEntry} ne $empty_string
		&& $immodpg->{_inVincrement} ne $empty_string
		&& $immodpg->{_outsideVincrement} ne $empty_string
		&& $immodpg->{_Vincrement} ne $empty_string ) {

		# rename for convenience
		my $inVincrement       = $immodpg->{_inVincrement};
		my $outsideVincrement  = $immodpg->{_outsideVincrement};
		my $Vincrement_current = $immodpg->{_Vincrement_current};
		my $Vincrement_prior   = $immodpg->{_Vincrement_prior};

		# print("immodpg,_checkVincrement, inVincrement:$inVincrement\n");
		# print("immodpg,_checkVincrement, outsideVincrement: $outsideVincrement\n");
		if (   $inVincrement eq $yes
			&& $outsideVincrement eq $no ) {

			# print("immodpg, _checkVincrement, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$Vincrement_current = $immodpg->{_VincrementEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$inVincrement      = $no;
			$outsideVincrement = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_inVincrement}       = $inVincrement;
			$immodpg->{_outsideVincrement}  = $outsideVincrement;
			$immodpg->{_Vincrement_current} = $Vincrement_current;

			return ();

		} elsif ( $inVincrement eq $no
			&& $outsideVincrement eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$Vincrement_prior   = $Vincrement_current;
			$Vincrement_current = $immodpg->{_VincrementEntry}->get();

			# print("immodpg, _checkVincrement, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$inVincrement      = $yes;
			$outsideVincrement = $no;

			# reset module values for convenience of renaming
			$immodpg->{_inVincrement}       = $inVincrement;
			$immodpg->{_outsideVincrement}  = $outsideVincrement;
			$immodpg->{_Vincrement_current} = $Vincrement_current;
			$immodpg->{_Vincrement_prior}   = $Vincrement_prior;
			return ();

		} else {
			print("immodpg, _checkVincrement, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _checkVincrement, missing widget\n");
		return ();
	}
}

=head2 sub _checkVtop

When you modify, enter or leave VtopEntry widget
check what the current Vtop value is
compared to former Vtop values

=cut

sub _checkVtop {

	my ($self) = @_;

	# print("immodpg, _checkVtop, $immodpg->{_VtopEntry}\n");

	if (   defined $immodpg->{_VtopEntry}
		&& $immodpg->{_VtopEntry} ne $empty_string
		&& $immodpg->{_inVtop} ne $empty_string
		&& $immodpg->{_outsideVtop} ne $empty_string
		&& $immodpg->{_Vtop_current} ne $empty_string
		&& $immodpg->{_Vtop_prior} ne $empty_string ) {

		# rename for convenience
		my $inVtop       = $immodpg->{_inVtop};
		my $outsideVtop  = $immodpg->{_outsideVtop};
		my $Vtop_current = $immodpg->{_Vtop_current};
		my $Vtop_prior   = $immodpg->{_Vtop_prior};

		# print("immodpg,_checkVtop, inVtop:$inVtop\n");
		# print("immodpg,_checkVtop, outsideVtop: $outsideVtop\n");
		# print("immodpg,_checkVtop, Vtop_current: $Vtop_current\n");
		if (   $inVtop eq $yes
			&& $outsideVtop eq $no ) {

			#			print("immodpg, _checkVtop, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$Vtop_current = $immodpg->{_VtopEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$inVtop      = $no;
			$outsideVtop = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_inVtop}       = $inVtop;
			$immodpg->{_outsideVtop}  = $outsideVtop;
			$immodpg->{_Vtop_current} = $Vtop_current;

			return ();

		} elsif ( $inVtop eq $no
			&& $outsideVtop eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$Vtop_prior   = $Vtop_current;
			$Vtop_current = $immodpg->{_VtopEntry}->get();

			#			print("immodpg, _checkVtop, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$inVtop      = $yes;
			$outsideVtop = $no;

			# reset module values for convenience of renaming
			$immodpg->{_inVtop}       = $inVtop;
			$immodpg->{_outsideVtop}  = $outsideVtop;
			$immodpg->{_Vtop_current} = $Vtop_current;
			$immodpg->{_Vtop_prior}   = $Vtop_prior;
			return ();

		} else {
			print("immodpg, _checkVtop, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _checkVtop, missing widget\n");
		return ();
	}
}

=head2 sub _checkVtop_lower_layer

When you use Vtop_lower_layer
check what the current Vtop_lower_layer value is
compared to former Vtop_lower_layer values

=cut

sub _checkVtop_lower_layer {

	my ($self) = @_;

	#	print("immodpg, _checkVtop_lower_layer, $immodpg->{_Vtop_lower_layerEntry}\n");

	if (   defined $immodpg->{_Vtop_lower_layerEntry}
		&& $immodpg->{_Vtop_lower_layerEntry} ne $empty_string
		&& $immodpg->{_inVtop_lower_layer} ne $empty_string
		&& $immodpg->{_outsideVtop_lower_layer} ne $empty_string
		&& $immodpg->{_Vtop_lower_layer_current} ne $empty_string
		&& $immodpg->{_Vtop_lower_layer_prior} ne $empty_string ) {

		# rename for convenience
		my $inVtop_lower_layer       = $immodpg->{_inVtop_lower_layer};
		my $outsideVtop_lower_layer  = $immodpg->{_outsideVtop_lower_layer};
		my $Vtop_lower_layer_current = $immodpg->{_Vtop_lower_layer_current};
		my $Vtop_lower_layer_prior   = $immodpg->{_Vtop_lower_layer_prior};

		# print("immodpg,_checkVtop_lower_layer, inVtop_lower_layer:$inVtop_lower_layer\n");
		# print("immodpg,_checkVtop_lower_layer, outsideVtop_lower_layer: $outsideVtop_lower_layer\n");
		if (   $inVtop_lower_layer eq $yes
			&& $outsideVtop_lower_layer eq $no ) {

			#			print("immodpg, _checkVtop_lower_layer, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$Vtop_lower_layer_current = $immodpg->{_Vtop_lower_layerEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$inVtop_lower_layer      = $no;
			$outsideVtop_lower_layer = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_inVtop_lower_layer}       = $inVtop_lower_layer;
			$immodpg->{_outsideVtop_lower_layer}  = $outsideVtop_lower_layer;
			$immodpg->{_Vtop_lower_layer_current} = $Vtop_lower_layer_current;

			#			print("1 _Vtop_lower_layer_current=$immodpg->{_Vtop_lower_layer_current}\n");
			return ();

		} elsif ( $inVtop_lower_layer eq $no
			&& $outsideVtop_lower_layer eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$Vtop_lower_layer_prior   = $Vtop_lower_layer_current;
			$Vtop_lower_layer_current = $immodpg->{_Vtop_lower_layerEntry}->get();

			#			print("immodpg, _checkVtop_lower_layer, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$inVtop_lower_layer      = $yes;
			$outsideVtop_lower_layer = $no;

			# reset module values for convenience of renaming
			$immodpg->{_inVtop_lower_layer}       = $inVtop_lower_layer;
			$immodpg->{_outsideVtop_lower_layer}  = $outsideVtop_lower_layer;
			$immodpg->{_Vtop_lower_layer_current} = $Vtop_lower_layer_current;
			$immodpg->{_Vtop_lower_layer_prior}   = $Vtop_lower_layer_prior;

			#			print("2 _Vtop_lower_layer_current=$immodpg->{_Vtop_lower_layer_current}\n");
			return ();

		} else {
			print("immodpg, _checkVtop_lower_layer, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _checkVtop_lower_layer, missing widget\n");
		return ();
	}
}

=head2 sub _checkVbotNtop_factor

When you enter or leave
check what the current VbotNtop_factor value is
compared to former VbotNtop_factor values

=cut

sub _checkVbotNtop_factor {

	my ($self) = @_;

	# print("immodpg, _checkVbotNtop_factor, $immodpg->{_VbotNtop_factor4Entry}\n");

	if (   defined $immodpg->{_VbotNtop_factorEntry}
		&& $immodpg->{_VbotNtop_factorEntry} ne $empty_string
		&& $immodpg->{_inVbotNtop_factor} ne $empty_string
		&& $immodpg->{_outsideVbotNtop_factor} ne $empty_string
		&& $immodpg->{_VbotNtop_factor_current} ne $empty_string
		&& $immodpg->{_VbotNtop_factor_prior} ne $empty_string ) {

		# rename for convenience
		my $inVbotNtop_factor       = $immodpg->{_inVbotNtop_factor};
		my $outsideVbotNtop_factor  = $immodpg->{_outsideVbotNtop_factor};
		my $VbotNtop_factor_current = $immodpg->{_VbotNtop_factor_current};
		my $VbotNtop_factor_prior   = $immodpg->{_VbotNtop_factor_prior};

		# print("immodpg,_checkVbotNtop_factor, inVbotNtop_factor:$inVbotNtop_factor\n");
		# print("immodpg,_checkVbotNtop_factor, outsideVbotNtop_factor: $outsideVbotNtop_factor\n");
		if (   $inVbotNtop_factor eq $yes
			&& $outsideVbotNtop_factor eq $no ) {

			# print("immodpg, _checkVbotNtop_factor, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$VbotNtop_factor_current = $immodpg->{_VbotNtop_factorEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$inVbotNtop_factor      = $no;
			$outsideVbotNtop_factor = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_inVbotNtop_factor}       = $inVbotNtop_factor;
			$immodpg->{_outsideVbotNtop_factor}  = $outsideVbotNtop_factor;
			$immodpg->{_VbotNtop_factor_current} = $VbotNtop_factor_current;

			return ();

		} elsif ( $inVbotNtop_factor eq $no
			&& $outsideVbotNtop_factor eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$VbotNtop_factor_prior   = $VbotNtop_factor_current;
			$VbotNtop_factor_current = $immodpg->{_VbotNtop_factorEntry}->get();

			# print("immodpg, _checkVbotNtop_factor, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$inVbotNtop_factor      = $yes;
			$outsideVbotNtop_factor = $no;

			# reset module values for convenience of renaming
			$immodpg->{_inVbotNtop_factor}       = $inVbotNtop_factor;
			$immodpg->{_outsideVbotNtop_factor}  = $outsideVbotNtop_factor;
			$immodpg->{_VbotNtop_factor_current} = $VbotNtop_factor_current;
			$immodpg->{_VbotNtop_factor_prior}   = $VbotNtop_factor_prior;
			return ();

		} else {
			print("immodpg, _checkVbotNtop_factor, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _checkVbotNtop_factor, missing widget\n");
		return ();
	}
}

=head2 sub _check_clip

When you enter or leave
check what the current clip value is
compared to former clip values

=cut

sub _check_clip {

	my ($self) = @_;

	# print("immodpg, _check_clip, $immodpg->{_clip4plotEntry}\n");

	if (   defined( $immodpg->{_clip4plotEntry} )
		&& $immodpg->{_clip4plotEntry} ne $empty_string
		&& $immodpg->{_in_clip} ne $empty_string
		&& $immodpg->{_outside_clip} ne $empty_string
		&& $immodpg->{_clip4plot_current} ne $empty_string
		&& $immodpg->{_clip4plot_prior} ne $empty_string ) {

		# rename for convenience
		my $in_clip           = $immodpg->{_in_clip};
		my $outside_clip      = $immodpg->{_outside_clip};
		my $clip4plot_current = $immodpg->{_clip4plot_current};
		my $clip4plot_prior   = $immodpg->{_clip4plot_prior};

		# print("immodpg,_check_clip, in_clip:$in_clip\n");
		# print("immodpg,_check_clip, outside_clip: $outside_clip\n");
		if (   $in_clip eq $yes
			&& $outside_clip eq $no ) {

			# print("immodpg, _check_clip, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$clip4plot_current = $immodpg->{_clip4plotEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$in_clip      = $no;
			$outside_clip = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_in_clip}           = $in_clip;
			$immodpg->{_outside_clip}      = $outside_clip;
			$immodpg->{_clip4plot_current} = $clip4plot_current;

			return ();

		} elsif ( $in_clip eq $no
			&& $outside_clip eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$clip4plot_prior   = $clip4plot_current;
			$clip4plot_current = $immodpg->{_clip4plotEntry}->get();

			# print("immodpg, _check_clip, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$in_clip      = $yes;
			$outside_clip = $no;

			# reset module values for convenience of renaming
			$immodpg->{_in_clip}           = $in_clip;
			$immodpg->{_outside_clip}      = $outside_clip;
			$immodpg->{_clip4plot_current} = $clip4plot_current;
			$immodpg->{_clip4plot_prior}   = $clip4plot_prior;
			return ();

		} else {
			print("immodpg, _check_clip, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _check_clip, missing widget\n");
		return ();
	}
}

=head2 sub _check_layer

When you enter or leave
check what the current layer value is
compared to former layer values

If you enter the LayerEntry widget it will be before you change
its value
If you enter another widget that now has the focus you
will have to recall the current and prior values of the 
layerEntry widget

=cut

sub _check_layer {

	my ($self) = @_;

	# print("immodpg, _check_layer, $immodpg->{_layerEntry}\n");

	if (   length( $immodpg->{_layerEntry} )
		&& length( $immodpg->{_in_layer} )
		&& length( $immodpg->{_outside_layer} )
		&& length( $immodpg->{_layer_current} )
		&& length( $immodpg->{_layer_prior} ) ) {

		# rename for convenience
		my $in_layer      = $immodpg->{_in_layer};
		my $outside_layer = $immodpg->{_outside_layer};
		my $layer_current = $immodpg->{_layer_current};
		my $layer_prior   = $immodpg->{_layer_prior};

		#		print("immodpg,_check_layer, in_layer:$in_layer\n");
		#		print("immodpg,_check_layer, outside_layer: $outside_layer\n");
		if (   $in_layer eq $yes
			&& $outside_layer eq $no ) {

			# CASE 1: Previously, inside Entry widget
			#			print("immodpg, _check_layer, left widget\n");
			# possible layer number idiosyncracies
			my $temp_layer_current = $immodpg->{_layerEntry}->get();

			# print("immodpg, _check_layer, temp layer number = $temp_layer_current\n");
			_set_layer_control($temp_layer_current);
			my $new_layer_current = _get_control_layer();

			# $new_layer_current=99;
			$immodpg->{_layerEntry}->delete( 0, 'end' );
			$immodpg->{_layerEntry}->insert( 0, $new_layer_current );

			# reverse the conditions now
			# when user leaves widget
			# Next will enter layerEntry widget
			$in_layer      = $no;
			$outside_layer = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_in_layer}      = $in_layer;
			$immodpg->{_outside_layer} = $outside_layer;
			$immodpg->{_layer_current} = $new_layer_current;

			return ();

		} elsif ( $in_layer eq $no
			&& $outside_layer eq $yes ) {

			# CASE 2: Previously, outside layerEntry widget
			# Now entering entering the layerEntry widget
			#			print("immodpg, _check_layer, Entering widget\n");
			$layer_current = $immodpg->{_layerEntry}->get();

			#			print("immodpg, _check_layer,prior =$immodpg->{_layer_prior} current= $layer_current\n\n");

			# reverse the conditions now
			# when user enters Entry widget
			$in_layer      = $yes;
			$outside_layer = $no;

			# reset module values for convenience of renaming
			$immodpg->{_in_layer}      = $in_layer;
			$immodpg->{_outside_layer} = $outside_layer;
			$immodpg->{_layer_current} = $layer_current;

			# $immodpg->{_layer_prior}   = $new_layer_prior;
			return ();

		} else {
			print("immodpg, _check_layer, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _check_layer, missing widget\n");
		return ();
	}
}

=head2 sub _check_thickness_m

When you modify, enter or leave thickness_mEntry widget
check what the current thickness_m value is
compared to former thickness_m values

=cut

sub _check_thickness_m {

	my ($self) = @_;

	# print("immodpg, _check_thickness_m, $immodpg->{_thickness_mEntry}\n");

	if (   defined $immodpg->{_thickness_mEntry}
		&& $immodpg->{_thickness_mEntry} ne $empty_string
		&& $immodpg->{_in_thickness_m} ne $empty_string
		&& $immodpg->{_outside_thickness_m} ne $empty_string
		&& $immodpg->{_thickness_m} ne $empty_string ) {

		# rename for convenience
		my $in_thickness_m       = $immodpg->{_in_thickness_m};
		my $outside_thickness_m  = $immodpg->{_outside_thickness_m};
		my $_thickness_m_current = $immodpg->{_thickness_m_current};
		my $_thickness_m_prior   = $immodpg->{_thickness_m_prior};

		# print("immodpg,_check_thickness_m, in_thickness_m:$in_thickness_m\n");
		# print("immodpg,_check_thickness_m, outside_thickness_m: $outside_thickness_m\n");
		# print("immodpg,_check_thickness_m, _thickness_m_current: $_thickness_m_current\n");
		if (   $in_thickness_m eq $yes
			&& $outside_thickness_m eq $no ) {

			# print("immodpg, _check_thickness_m, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$_thickness_m_current = $immodpg->{_thickness_mEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$in_thickness_m      = $no;
			$outside_thickness_m = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_in_thickness_m}      = $in_thickness_m;
			$immodpg->{_outside_thickness_m} = $outside_thickness_m;
			$immodpg->{_thickness_m_current} = $_thickness_m_current;

			return ();

		} elsif ( $in_thickness_m eq $no
			&& $outside_thickness_m eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$_thickness_m_prior   = $_thickness_m_current;
			$_thickness_m_current = $immodpg->{_thickness_mEntry}->get();

			# print("immodpg, _check_thickness_m, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$in_thickness_m      = $yes;
			$outside_thickness_m = $no;

			# reset module values for convenience of renaming
			$immodpg->{_in_thickness_m}      = $in_thickness_m;
			$immodpg->{_outside_thickness_m} = $outside_thickness_m;
			$immodpg->{_thickness_m_current} = $_thickness_m_current;
			$immodpg->{_thickness_m_prior}   = $_thickness_m_prior;
			return ();

		} else {
			print("immodpg, _check_thickness_m, unexpected values\n");
			return ();
		}

	} else {
		print("immodpg, _check_thickness_m, missing widget\n");
		return ();
	}
}

=head2 sub _check_thickness_increment_m

When you enter or leave
check what the current thickness_increment_mvalue is
compared to former thickness_increment_mvalues

=cut

sub _check_thickness_increment_m {

	my ($self) = @_;

	# print("immodpg, _check_thickness_increment_m, $immodpg->{_thickness_increment_mEntry}\n");

	if (   defined( $immodpg->{_thickness_increment_mEntry} )
		&& $immodpg->{_thickness_increment_mEntry} ne $empty_string
		&& $immodpg->{_in_thickness_increment_m} ne $empty_string
		&& $immodpg->{_outside_thickness_increment_m} ne $empty_string
		&& $immodpg->{_thickness_increment_m_current} ne $empty_string
		&& $immodpg->{_thickness_increment_m_prior} ne $empty_string ) {

		# rename for convenience
		my $in_thickness_increment_m      = $immodpg->{_in_thickness_increment_m};
		my $outside_thickness_increment_m = $immodpg->{_outside_thickness_increment_m};
		my $thickness_increment_m_current = $immodpg->{_thickness_increment_m_current};
		my $thickness_increment_m_prior   = $immodpg->{_thickness_increment_m_prior};

		# print("immodpg,_check_thickness_increment_m, in_thickness_increment_m:$in_thickness_increment_m\n");
		# print("immodpg,_check_thickness_increment_m, outside_thickness_increment_m: $outside_thickness_increment_m\n");
		if (   $in_thickness_increment_m eq $yes
			&& $outside_thickness_increment_m eq $no ) {

			# print("immodpg, _check_thickness_increment_m, Leaving widget\n");

			# CASE 1: Previously, inside Entry widget
			# Now leaving Entry widget
			$thickness_increment_m_current = $immodpg->{_thickness_increment_mEntry}->get();

			# reverse the conditions now
			# when user leaves Entry widget
			$in_thickness_increment_m      = $no;
			$outside_thickness_increment_m = $yes;

			# reset module values for convenience of renaming
			$immodpg->{_in_thickness_increment_m}      = $in_thickness_increment_m;
			$immodpg->{_outside_thickness_increment_m} = $outside_thickness_increment_m;
			$immodpg->{_thickness_increment_m_current} = $thickness_increment_m_current;

			return ();

		} elsif ( $in_thickness_increment_m eq $no
			&& $outside_thickness_increment_m eq $yes ) {

			# CASE 2: Previously, outside Entry widget
			# Now entering Entry widget
			$thickness_increment_m_prior   = $thickness_increment_m_current;
			$thickness_increment_m_current = $immodpg->{_thickness_increment_mEntry}->get();

			# print("immodpg, _check_thickness_increment_m, Entering widget\n");

			# reverse the conditions now
			# when user enters Entry widget
			$in_thickness_increment_m      = $yes;
			$outside_thickness_increment_m = $no;

			# reset module values for convenience of renaming
			$immodpg->{_in_thickness_increment_m}      = $in_thickness_increment_m;
			$immodpg->{_outside_thickness_increment_m} = $outside_thickness_increment_m;
			$immodpg->{_thickness_increment_m_current} = $thickness_increment_m_current;
			$immodpg->{_thickness_increment_m_prior}   = $thickness_increment_m_prior;
			return ();

		} else {
			return ();
			print("immodpg, _check_thickness_increment_m, unexpected values\n");
		}

	} else {
		print("immodpg, _check_thickness_increment_m, missing widget\n");
		return ();
	}
}

=head2 sub _get_control_VbotNtop_factor
adjust  bad VbotNtop_factor value
set defaults

=cut

sub _get_control_VbotNtop_factor {

	my ($self) = @_;

	my $result;

	if ( not( looks_like_number( $immodpg->{_control_VbotNtop_factor} ) ) ) {

		$immodpg->{_VbotNtop_factor_current} = $immodpg->{_VbotNtop_factor_default};
		$immodpg->{_VbotNtop_factor_prior}   = $immodpg->{_VbotNtop_factor_default};
		$immodpg->{_VbotNtop_factorEntry}->delete( 0, 'end' );
		$immodpg->{_VbotNtop_factorEntry}->insert( 0, $immodpg->{_VbotNtop_factor_current} );
		$immodpg->{_isVbotNtop_factor_changed} = $no,;

	} else {
		print("immodpg, _get_control_VbotNtop_factor,  bad value\n");
	}

	return ();
}

=head2 sub _get_control_clip
adjust clip value

=cut

sub _get_control_clip {

	my ($self) = @_;

	my $result;

	if ( length( $immodpg->{_control_clip} ) ) {

		#		print("1. immodpg, _get_control_clip, old control_clip= $immodpg->{_control_clip}\n");
		my $control_clip = $immodpg->{_control_clip};

		if ( $control_clip <= 0 ) {

			# case 1 layer number exceeds possible value
			$control_clip = 1;
			$result       = $control_clip;

		} else {

			#			print("immodpg, _get_control_clip, NADA\n");
			$result = $control_clip;
		}

		#		print("2. immodpg, _get_control_clip, new control_clip= $control_clip\n");
		return ($result);

	} else {
		print("immodpg, _get_control_clip,  missing clip value\n");
	}
	return ();
}

=head2 sub _get_control_layer
adjust layer number

=cut

sub _get_control_layer {

	my ($self) = @_;

	my $result;

	if ( length( $immodpg->{_control_layer} ) ) {

		# print("1. immodpg, _get_control_layer, control_layer= $immodpg->{_control_layer}\n");
		my $control_layer    = $immodpg->{_control_layer};
		my $number_of_layers = _get_number_of_layers();

		if ( $control_layer > $number_of_layers ) {

			# case 1 layer number exceeds possible value
			# print("case1: immodpg, _get_control_layer, layer number too large\n");
			# print("immodpg, _get_control_layer, layer_number=$control_layer}\n");
			$control_layer = $number_of_layers - 1;

			# print("immodpg, _get_control_layer, new layer_number=$control_layer}\n");
			$result = $control_layer;

		} elsif ( $control_layer < 1 ) {

			$control_layer = 1;
			$result        = $control_layer;

		} elsif ( ( $control_layer == 1 ) ) {

			$control_layer = 1;
			$result        = $control_layer;

			# NADA

		} elsif ( ( $control_layer < $number_of_layers ) ) {

			#print("immodpg, get_control_layer, layer=$control_layer\n");
			$result = $control_layer;

			# NADA

		} elsif ( ( $control_layer == $number_of_layers ) ) {

			# print("immodpg, get_control_layer, layer=$control_layer\n");
			$result = $control_layer - 1;

		} else {

			# print("immodpg, _get_control_layer, unexpected layer number\n");
			$result = $empty_string;
		}

	} else {

		# print("immodpg, _get_control_layer, empty string, result = 1\n");
		$result = 1;
	}

	return ($result);
}

=head2 sub _get_data_scale

get scalco or scalel from file header

=cut

sub _get_data_scale {
	my ($self) = @_;
	use header_values;

=head2 instantiate class

=cut

	print("immodpg, _get_data_scale, _base_file_name=$immodpg->{_base_file_name}\n");

	# ???
	my $header_values = header_values->new();

	if ( defined $immodpg->{_base_file_name}
		&& $immodpg->{_base_file_name} ne $empty_string ) {

		$header_values->set_base_file_name( $immodpg->{_base_file_name} );
		$header_values->set_header_name('scalel');
		my $data_scale = $header_values->get_number();

		my $result = $data_scale;

		#		print("immodpg, _get_data_scale, data_scale = $data_scale\n");
		return ($result);

	} else {

		my $data_scale = 1;
		my $result     = $data_scale;

		#		print("immodpg, _get_data_scale, data_scale = 1:1\n");
		return ($result);

	}
}

=head2 _get_model

 PERL PACKAGE NAME: read_get_model_wPDL
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 21 2020

 DESCRIPTION:  
    
   read Fortran 77 unformatted binary model file
   from mmodpg

=cut

=head2 USE

=over

=item

Number of layers is passed as a variable
Number of layers is read from an ascii 
version of the model data file

=item


=back
	
=cut

=head2 NOTES

	
=cut	

=head4 Examples

=cut

=head2 CHANGES and their DATES


=cut 

sub _get_model {

	my ($self) = @_;
	#
	use Project_config;
	use PDL;
	use PDL::Core;
	use PDL::IO::FlexRaw;
	use immodpg_global_constants;

	my $Project = Project_config->new();
	my $IMMODPG = $Project->IMMODPG();
	my $var     = ( immodpg_global_constants->new() )->var;

	my ( @VPtop, @VStop, @density_top, @dz );
	my ( @VPbot, @VSbot, @density_bot );
	my ( @VP,    @VS,    @model );

	my $inbound = $IMMODPG . '/' . $var->{_immodpg_model};
	my $cols    = 9;                                         #default
	my $km2m    = 1000;
	my $gcc2MKS = 1000;

	# print("immodpg, _get_model,model_layer_number =$immodpg->{_model_layer_number}\n");
	my $number_of_layers = _get_number_of_layers();

	#	print("immodpg, _get_model,number_of_layers = $number_of_layers\n");

	if (   $immodpg->{_model_layer_number} > 0
		&& $immodpg->{_model_layer_number} <= $number_of_layers ) {

		my $header = [
			{ Type => 'f77' },
			{
				Type  => 'float',
				NDims => 2,
				Dims  => [ $cols, ($number_of_layers) ]
			}
		];

		my $model_pdl = readflex( $inbound, $header );

		# print("$model_pdl\n");
		my $nelem = nelem($model_pdl);

		# print("nelem=$nelem,#cols=$cols,#layers=$number_of_layers\n");

		for ( my $layer_index = 0; $layer_index < $number_of_layers; $layer_index++ ) {
			my $value_indices = '0:1';
			my $full_indices  = $value_indices . ',' . $layer_index;

			# pdl 2 perl
			@VP                  = ( $model_pdl->slice($full_indices) )->list;
			$VPtop[$layer_index] = sprintf( "%.2f", ( $VP[0] * $km2m ) );
			$VPbot[$layer_index] = sprintf( "%.2f", ( $VP[1] * $km2m ) );

			$value_indices = '2:6';
			$full_indices  = $value_indices . ',' . $layer_index;

			# pdl 2 perl
			@model                     = ( $model_pdl->slice($full_indices) )->list;
			$dz[$layer_index]          = sprintf( "%.3f", ( $model[0] * $km2m ) );
			$VStop[$layer_index]       = sprintf( "%.3f", ( $model[1] * $km2m ) );
			$VSbot[$layer_index]       = sprintf( "%.3f", ( $model[2] * $km2m ) );
			$density_top[$layer_index] = sprintf( "%.3f", ( $model[3] * $gcc2MKS ) );
			$density_bot[$layer_index] = sprintf( "%.3f", ( $model[4] * $gcc2MKS ) );

			#			print("VPtop = $VPtop[$layer_index], VPbot=$VPbot[$layer_index],layer_index=$layer_index\n");
			#			print("VStop = $VStop[$layer_index], VSbot=$VSbot[$layer_index],layer_index=$layer_index\n");
			#			print("dz = $dz[$layer_index], rho_top=$density_top[$layer_index],rho_bot=$density_bot[$layer_index]\n");

			my $x_indices     = pdl(5);
			my $layer_indices = pdl(2);

			#	        print pdl(@VPtop,@VPbot,@dz,@VStop,@VSbot,@density_top,@density_bot);
			#	        print ("\n");
			#			print $model_pdl->index2d($x_indices,$layer_indices);
			#			print ("\n");
			#			print $model_pdl;
		}

		return ( \@VPtop, \@VPbot, \@dz );

	} else {

		# print("immodpg,_get_model,number of layers exceeds default\n");
		# print("immodpg,_get_model,number of layers= $number_of_layers\n");
		# print("immodpg, _get_model,model_layer_number =$immodpg->{_model_layer_number}\n");
		return ();
	}

}

=head2

determine number of layers
from model.text file

=cut

sub _get_number_of_layers {

	my ($self) = @_;
	my $number_of_layers;

	if ( length( $immodpg->{_model_file_text} ) ) {

		my $count                   = 0;
		my $magic_number            = 4;
		my $inbound_model_file_text = $IMMODPG_INVISIBLE . '/' . $immodpg->{_model_file_text};

		#		print ("immodpg,_get_number_of_layers,inbound_model_file_text=$inbound_model_file_text\n");

		open( my $fh, '<', $inbound_model_file_text );

		while (<$fh>) {

			$count++;

		}
		close($fh);

		$number_of_layers = $count - $magic_number;

		#		print("immodpg,_get_number_of_layers, layers = $number_of_layers \n");

	} else {

		#		print("immodpg,_get_number_of_layers, missing values\n");
		$number_of_layers = 0;
	}

	my $result = $number_of_layers;
	return ($result);
}

=head2 sub _getVp_dz_initial

=cut

sub _getVp_dz_initial {

	my ($self) = @_;

	if ( length( $immodpg->{_model_layer_number} ) ) {

		my ( $_thickness_m_upper_layer, $Vbot_lower_layer );
		my ( @V,                        @result );

		my $layer = $immodpg->{_model_layer_number};
		my ( $ref_VPtop, $ref_VPbot, $ref_dz ) = _get_model();

		my @VPtop = @$ref_VPtop;
		my @VPbot = @$ref_VPbot;
		my @dz    = @$ref_dz;

		#		print("immodpg,_getVp_dz_initial VPtop= @VPtop\n");
		#		print("immodpg,_getVp_dz_initial VPbot= @VPbot\n");
		#		print("immodpg,_getVp_dz_initial layer_number = $layer \n");

		my $layer_index             = $layer - 1;
		my $layer_index_upper_layer = $layer - 2;
		my $layer_index_lower_layer = $layer;

		# For all cases
		my $Vtop = $VPtop[$layer_index];
		my $Vbot = $VPbot[$layer_index];
		my $dz   = $dz[$layer_index];

		if ( $layer >= 2 ) {

			# CASE of second of two or more layers
			my $Vbot_upper_layer = $VPbot[$layer_index_upper_layer];
			my $Vtop_lower_layer = $VPtop[$layer_index_lower_layer];

			$V[0] = $Vbot_upper_layer;
			$V[1] = $Vtop;
			$V[2] = $Vbot;
			$V[3] = $Vtop_lower_layer;

			@result = @V;

			#			print("immodpg_getVp_dz_initial: velocities are:  @V \n");
			return ( \@result, $dz );

		} elsif ( $layer >= 1 ) {

			# CASE of first of one or more layers
			my $Vbot_upper_layer = $empty_string;
			my $Vtop_lower_layer = $VPtop[$layer_index_lower_layer];

			$V[0] = $Vbot_upper_layer;
			$V[1] = $Vtop;
			$V[2] = $Vbot;
			$V[3] = $Vtop_lower_layer;

			@result = @V;
			return ( \@result, $dz );

		} else {
			print("immodpg, _getVp_dz_initial, unexpected layer number \n");
			return ();
		}

	} else {
		return ();
		print("immodpg,_getVp_dz_initial, missing layer\n");
	}
	return ();
}

=head2 sub _setVbot

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files
_setVbot

=cut

sub _setVbot {
	my ($Vbot) = @_;

	if ( looks_like_number($Vbot)
		&& $immodpg->{_isVbot_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $Vbot_file = $immodpg->{_Vbot_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $Vbot_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $Vbot;
				$format = $var_immodpg->{_format_real};
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_isVbot_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _setVbot, unexpected answer\n");
	}

	return ();
}

=head2 sub _setVbot_upper_layer

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files
_setVbot_upper_layer

=cut

sub _setVbot_upper_layer {
	my ($Vbot_upper_layer) = @_;

	if (   $Vbot_upper_layer ne $empty_string
		&& $immodpg->{_isVbot_upper_layer_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $Vbot_upper_layer_file = $immodpg->{_Vbot_upper_layer_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $Vbot_upper_layer_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $Vbot_upper_layer;
				$format = $var_immodpg->{_format_real};
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_isVbot_upper_layer_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _setVbot_upper_layer, unexpected answer\n");
	}

	return ();
}

=head2 sub _setVbotNtop_factor

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files
_setVbotNtop_factor

=cut

sub _setVbotNtop_factor {
	my ($VbotNtop_factor) = @_;

	if (   $VbotNtop_factor ne $empty_string
		&& $immodpg->{_isVbotNtop_factor_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $VbotNtop_factor_file = $immodpg->{_VbotNtop_factor_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $VbotNtop_factor_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $VbotNtop_factor;
				$format = '%5.1f';
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_isVbotNtop_factor_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _setVbotNtop_factor, unexpected answer\n");
	}

	return ();
}

=head2 sub _setVbotNtop_multiply
Verify another lock file does not exist and
only then:
Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files
_setVbotNtop_multiply

=cut

sub _setVbotNtop_multiply {
	my ($self) = @_;

	if (   looks_like_number( $immodpg->{_Vbot_multiplied} )
		&& looks_like_number( $immodpg->{_Vtop_multiplied} )
		&& looks_like_number( $immodpg->{_Vbot_current} )
		&& looks_like_number( $immodpg->{_Vtop_current} ) ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $file = $immodpg->{_VbotNtop_multiply_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0]   = $immodpg->{_Vbot_multiplied};
				$X[1]   = $immodpg->{_Vtop_multiplied};
				$format = $var_immodpg->{_format_real};
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} else {
		print("immodpg, _setVbotNtop_multiply, unexpected answer\n");
	}

	return ();
}

=head2 sub _setVincrement

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub _setVincrement {
	my ($Vincrement) = @_;

	if (   $Vincrement ne $empty_string
		&& $immodpg->{_isVincrement_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $Vincrement_file = $immodpg->{_Vincrement_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $Vincrement_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $Vincrement;
				$format = '%5.1f';
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_isVincrement_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _setVincrement, unexpected answer\n");
	}

	return ();
}

=head2 sub _setVtop

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub _setVtop {

	my ($Vtop) = @_;

	if ( looks_like_number($Vtop)
		&& $immodpg->{_isVtop_changed} eq $yes ) {

		print("immodpg,_setVtop,write out fortran value of Vtop\n");

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $Vtop_file = $immodpg->{_Vtop_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $Vtop_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $Vtop;
				$format = $var_immodpg->{_format_real};
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_isVtop_changed} eq $no ) {

		# NADA
		print("immodpg, _setVtop, no change\n");

	} else {
		print("immodpg, _setVtop, unexpected answer\n");
	}

	return ();
}

=head2 sub _setVtop_lower_layer

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub _setVtop_lower_layer {
	my ($Vtop_lower_layer) = @_;

	if ( looks_like_number($Vtop_lower_layer)
		&& $immodpg->{_isVtop_lower_layer_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $Vtop_lower_layer_file = $immodpg->{_Vtop_lower_layer_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $Vtop_lower_layer_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $Vtop_lower_layer;
				$format = $var_immodpg->{_format_real};
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_isVtop_lower_layer_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _setVtop_lower_layer, unexpected answer\n");
	}

	return ();
}

=head2 sub _set_change

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub _set_change {

	my ($yes_or_no) = @_;

	if (   length($yes_or_no)
		&& length( $immodpg->{_change_file} ) ) {

		#		print("immodpg, _set_change, yes_or_no:$yes_or_no\n");

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $test   = $yes;
		my $change = $immodpg->{_change_file};

		my $outbound        = $IMMODPG_INVISIBLE . '/' . $change;
		my $outbound_locked = $outbound . '_locked';
		my $format          = $var_immodpg->{_format_string};

		for ( my $i = 0; $test eq $yes; $i++ ) {

			#			print("in loop \n");

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {

				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				# print("immodpg, _set_change, outbound_locked=$outbound_locked\n");
				# print("immodpg, _set_change, IMMODPG_INVISIBLE=$IMMODPG_INVISIBLE\n");
				# print("immodpg, _set_change, created empty locked file=$X[0]\n");
				$X[0] = $yes_or_no;

				# print("immodpg, _set_change, outbound=$outbound\n");
				#				# print("immodpg, _set_change, IMMODPG_INVISIBLE=$IMMODPG_INVISIBLE\n");
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);

				#				print("1. immodpg, _set_change, delete locked file\n");
				#				print("immodpg, _set_change, yes_or_no=$X[0]\n");

				# print("2. immodpg, _set_change, delete locked file\n");
				$test = $no;

			}    # if
		}    # for

	} else {
		print("immodpg, _set_change, missing values\n");
	}

	return ();
}

=head2 sub _set_clip

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub _set_clip {
	my ($clip) = @_;

	if (   $clip ne $empty_string
		&& $immodpg->{_is_clip_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $clip_file = $immodpg->{_clip_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $clip_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $clip;
				$format = '%5.1f';
				$files->write_1col_aref( \@X, \$outbound, \$format );
				print("immodpg, _set_clip, output clip = $clip\n");
				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_is_clip_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _set_clip, unexpected answer\n");
	}

	return ();
}

=head2 sub _set_thickness_m

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub _set_thickness_m {
	my ($thickness_m) = @_;

	if (   $thickness_m ne $empty_string
		&& $immodpg->{_is_thickness_m_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $thickness_m_file = $immodpg->{_thickness_m_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $thickness_m_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $thickness_m;
				$format = '%5.1f';
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_is_thickness_m_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _set_thickness_m, unexpected answer\n");
	}

	return ();
}

=head2 sub _set_thickness_increment_m

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub _set_thickness_increment_m {
	my ($thickness_increment_m) = @_;

	if (   $thickness_increment_m ne $empty_string
		&& $immodpg->{_is_thickness_increment_m_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $thickness_increment_m_file = $immodpg->{_thickness_increment_m_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $thickness_increment_m_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $thickness_increment_m;
				$format = '%5.1f';
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);
				$test = $yes;

			}    # if
		}    # for

	} elsif ( $immodpg->{_is_thickness_increment_m_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _set_thickness_increment_m, unexpected answer\n");
	}

	return ();
}

=head2 sub _fortran_layer

set layer
Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files


=cut

sub _fortran_layer {
	my ($layer) = @_;

	if (   $layer ne $empty_string
		&& $immodpg->{_is_layer_changed} eq $yes ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $layer_file = $immodpg->{_layer_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $layer_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			# print("in loop \n");

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $layer;
				$format = '%i';
				$files->write_1col_aref( \@X, \$outbound, \$format );
				unlink($outbound_locked);

				$test = $yes;
			}    # if
		}    # for

	} elsif ( $immodpg->{_is_layer_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _fortran_layer, unexpected answer\n");
	}

	return ();

}

=head2 sub _set_clip_control
value adjusts to current
clip value in use

=cut

sub _set_clip_control {

	my ($control_clip) = @_;

	my $result;

	if ( length($control_clip) ) {

		$immodpg->{_control_clip} = $control_clip;

		# print("immodpg,_set_clip_control, control_clip=$immodpg->{_control_clip}\n");

	} elsif ( not( length($control_clip) ) ) {

		# print("immodpg,_set_clip_control, empty string\n");
		$immodpg->{_control_clip} = $control_clip;

	} else {
		print("immodpg,_set_clip_control, missing value\n");
	}

	return ();
}

=head2 sub _set_layer_control
value adjusts to current
layer number in use

=cut

sub _set_layer_control {

	my ($control_layer) = @_;

	my $result;

	if ( length($control_layer) ) {

		$immodpg->{_control_layer} = $control_layer;

		#		print("immodpg,_set_layer_control, control_layer=$immodpg->{_control_layer}\n");

	} elsif ( not( length($control_layer) ) ) {

		#		print("immodpg,_set_layer_control, empty string\n");
		$immodpg->{_control_layer} = $control_layer;

	} else {
		print("immodpg,_set_layer_control, missing value\n");
	}

	return ();
}

=head2 _set_model_layer
Set the number of layers in 
mmodpg 

=cut

sub _set_model_layer {

	my ($model_layer_number) = @_;

	if ( $model_layer_number != 0
		&& length($model_layer_number) ) {

		$immodpg->{_model_layer_number} = $model_layer_number;

	} else {
		print("immodpg, _set_model_layer, unexpected layer# \n");
	}

	#	print("immodpg, _set_model_layer,model layer# =$immodpg->{_model_layer_number}\n");

	return ();
}

=head2 sub _set_option

Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files


=cut

sub _set_option {

	my ($option) = @_;

	# print("immodpg, set_option, option:$option\n");

	if ( defined($option)
		&& $immodpg->{_option_file} ne $empty_string ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $option_file = $immodpg->{_option_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $option_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			# print("in loop \n");

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $option;
				$format = '%2i';

				#				print("immodpg,_set_option,option=$option\n");
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);

				$test = $yes;
			}    # if
		}    # for

	} elsif ( $immodpg->{_is_option_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, _set_option, unexpected answer\n");
	}
	return ();
}

=head2 sub _updateVbot

keep tabs on Vbot values
and change the values on the 
GUI

=cut

sub _updateVbot {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_Vbot_current} )
		&& $immodpg->{_Vbot_current} != $immodpg->{_Vbot_prior} ) {

		# CASE Vbot has not changed
		$immodpg->{_isVbot_changed} = $yes;
		$immodpg->{_Vbot_prior}     = $immodpg->{_Vbot_current};

		# print("immodpg,_updateVbot,Vbot_current=$immodpg->{_Vbot_current}\n");
		# print("immodpg,_updateVbot,Vbot_prior=$immodpg->{_Vbot_prior}\n");
		return ();

	} elsif ( $immodpg->{_Vbot_current} == $immodpg->{_Vbot_prior} ) {

		# CASE Vbot has unchanged
		# print("immodpg, _updateVbot, unchanged\n");
		$immodpg->{_isVbot_changed} = $no;

		# print("immodpg,_updateVbot,Vbot_current=$immodpg->{_Vbot_current}\n");
		# print("immodpg,_updateVbot,Vbot_prior=$immodpg->{_Vbot_prior}\n");
		return ();

	} else {
		print("immodpg, _updateVbot, unexpected\n");
		return ();
	}
}

=head2 sub _updateVbot_upper_layer

keep tabs on upper layer Vbottom values
and change the values on the 
GUI
current layer must >0

=cut

sub _updateVbot_upper_layer {

	my ($self) = @_;

	#	print("mmodpg, _updateVbot_upper_layer, Vbot_upper_layer_current=..$immodpg->{_Vbot_upper_layer_current}..\n");
	if (   looks_like_number( $immodpg->{_Vbot_upper_layer_current} )
		&& $immodpg->{_layer_current} > 0
		&& $immodpg->{_Vbot_upper_layer_current} != $immodpg->{_Vbot_upper_layer_prior} ) {

		# CASE Vbot_upper_layer changed
		$immodpg->{_isVbot_upper_layer_changed} = $yes;
		$immodpg->{_Vbot_upper_layer_prior}     = $immodpg->{_Vbot_upper_layer_current};

		# print("immodpg, _updateVbot_upper_layer, updated to $immodpg->{_Vbot_upper_layer_current}\n");
		# print("immodpg,_updateVbot_upper_layer,Vbot_upper_layer_current=$immodpg->{_Vbot_upper_layer_current}\n");
		# print("immodpg,_updateVbot_upper_layer,Vbot_upper_layer_prior=$immodpg->{_Vbot_upper_layer_prior}\n");
		return ();

	} elsif ( looks_like_number( $immodpg->{_Vbot_upper_layer_current} )
		&& $immodpg->{_Vbot_upper_layer_current} == $immodpg->{_Vbot_upper_layer_prior} ) {

		# CASE clip has unchanged
		# print("immodpg, _updateVbot_upper_layer, unchanged\n");
		$immodpg->{_isVbot_upper_layer_changed} = $no;

		# print("immodpg,_updateVbot_upper_layer,Vbot_upper_layer_prior=$immodpg->{_Vbot_upper_layer_prior}\n");
		return ();

	} elsif ( not( looks_like_number( $immodpg->{_Vbot_upper_layer_current} ) ) ) {

		# CASE clip has unchanged
		#		print("immodpg, _updateVbot_upper_layer, no value in Vbot_upper_layer NADA\n");
		# print("immodpg,_updateVbot_upper_layer,Vbot_upper_layer_prior=$immodpg->{_Vbot_upper_layer_prior}\n");
		return ();

	} else {
		print("immodpg, _updateVbot_upper_layer, unexpected\n");

		#		print("immodpg,_updateVbot_upper_layer,Vbot_upper_layer_current=$immodpg->{_Vbot_upper_layer_current}\n");
		return ();
	}
}

=head2 sub _update_Vincrement

keep tabs on clip values
and change the values on the 
GUI

=cut

sub _updateVincrement {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_Vincrement_current} )
		&& $immodpg->{_Vincrement_current} != $immodpg->{_Vincrement_prior} ) {

		# CASE Vincrement changed
		$immodpg->{_Vincrement_current}   = $immodpg->{_Vincrement_current};
		$immodpg->{_isVincrement_changed} = $yes;

		# print("immodpg, _updateVincrement, updated to $immodpg->{_Vincrement_current}\n");

		#		print("immodpg,_updateVincrement,Vincrement_current=$immodpg->{_Vincrement_current}\n");
		#		print("immodpg,_updateVincrement,Vincrement_prior=$immodpg->{_Vincrement_prior}\n");
		return ();

	} elsif ( $immodpg->{_Vincrement_current} == $immodpg->{_Vincrement_prior} ) {

		# CASE clip has unchanged
		# print("immodpg, _updateVincrement, unchanged\n");
		$immodpg->{_isVincrement_changed} = $no;

		# print("immodpg,_updateVincrement,Vincrement_current=$immodpg->{_Vincrement_current}\n");
		# print("immodpg,_updateVincrement,Vincrement_prior=$immodpg->{_Vincrement_prior}\n");
		return ();

	} else {
		print("immodpg, _updateVincrement, unexpected\n");
		return ();
	}
}

=head2 sub _updateVtop

keep tabs on Vtop values
and change the values on the 
GUI

=cut

sub _updateVtop {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_Vtop_current} )
		&& $immodpg->{_Vtop_current} != $immodpg->{_Vtop_prior} ) {

		# CASE Vtop changed
		$immodpg->{_isVtop_changed} = $yes;
		$immodpg->{_Vtop_prior}     = $immodpg->{_Vtop_current};

		#		print("immodpg, _updateVtop, updated to $immodpg->{_Vtop_current}\n");
		#		print("immodpg,_updateVtop,Vtop_current=$immodpg->{_Vtop_current}\n");
		#		print("immodpg,_updateVtop,Vtop_prior=$immodpg->{_Vtop_prior}\n");
		return ();

	} elsif ( $immodpg->{_Vtop_current} == $immodpg->{_Vtop_prior} ) {

		# CASE Vtop has unchanged
		#		print("immodpg, _updateVtop, unchanged\n");
		$immodpg->{_isVtop_changed} = $no;

		#		print("immodpg,_updateVtop,Vtop_current=$immodpg->{_Vtop_current}\n");
		#		print("immodpg,_updateVtop,Vtop_prior=$immodpg->{_Vtop_prior}\n");
		return ();

	} else {
		print("immodpg, _updateVtop, unexpected\n");
		return ();
	}
}

=head2 sub _updateVtop_lower_layer

keep tabs on clip values
and change the values on the 
GUI

=cut

sub _updateVtop_lower_layer {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_Vtop_lower_layer_current} )
		&& $immodpg->{_Vtop_lower_layer_current} != $immodpg->{_Vtop_lower_layer_prior} ) {

		# CASE Vtop changed
		#		print("immodpg, _updateVtop_lower_layer, Vcurrent=$immodpg->{_Vtop_lower_layer_current}\n");
		$immodpg->{_isVtop_lower_layer_changed} = $yes;
		$immodpg->{_Vtop_lower_layer_prior}     = $immodpg->{_Vtop_lower_layer_current};

		#		print("immodpg, _updateVtop_lower_layer, changed\n");
		return ();

	} elsif ( $immodpg->{_Vtop_lower_layer_current} == $immodpg->{_Vtop_lower_layer_prior} ) {

		# CASE clip has unchanged
		#		print("immodpg, _updateVtop_lower_layer, unchanged\n");
		#		print("immodpg, _updateVtop_lower_layer, Vcurrent=$immodpg->{_Vtop_lower_layer_current}\n");
		$immodpg->{_isVtop_lower_layer_changed} = $no;

		return ();

	} else {
		print("immodpg, _updateVtop_lower_layer, unexpected\n");

		#		         print("immodpg, 4_updateVtop_lower_layer, _isVtop_lower_layer_changed=$immodpg->{_isVtop_lower_layer_changed} \n");
		return ();
	}
}

=head2 sub _updateVbotNtop_factor

keep tabs on clip values
and change the values on the 
GUI

=cut

sub _updateVbotNtop_factor {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_VbotNtop_factor_current} )
		&& $immodpg->{_VbotNtop_factor_current} != $immodpg->{_VbotNtop_factor_prior} ) {

		# CASE clip changed
		$immodpg->{_VbotNtop_factor_current}   = $immodpg->{_VbotNtop_factor_current};
		$immodpg->{_isVbotNtop_factor_changed} = $yes;

		# print("immodpg, _updateVbotNtop_factor, updated to $immodpg->{_VbotNtop_factor_current}\n");
		#		print("immodpg,_updateVbotNtop_factor,VbotNtop_factor_current=$immodpg->{_VbotNtop_factor_current}\n");
		#		print("immodpg,_updateVbotNtop_factor,VbotNtop_factor_prior=$immodpg->{_VbotNtop_factor_prior}\n");
		return ();

	} elsif ( $immodpg->{_VbotNtop_factor_current} == $immodpg->{_VbotNtop_factor_prior} ) {

		# CASE VbotNtop_factor has unchanged
		# print("immodpg, _updateVbotNtop_factor, unchanged\n");
		$immodpg->{_isVbotNtop_factor_changed} = $no;

		# print("immodpg,_updateVbotNtop_factor,VbotNtop_factor_current=$immodpg->{_VbotNtop_factor_current}\n");
		# print("immodpg,_updateVbotNtop_factor,VbotNtop_factor_prior=$immodpg->{_VbotNtop_factor_prior}\n");
		return ();

	} else {
		print("immodpg, _updateVbotNtop_factor, unexpected\n");
		return ();
	}
}

=head2 sub _updateVbotNtop_multiply

keep tabs on Vbot AND Vtop values together
and change the values on the 
GUI

=cut

sub _updateVbotNtop_multiply {

	my ($self) = @_;

	if (   looks_like_number( $immodpg->{_Vbot_current} )
		&& looks_like_number( $immodpg->{_Vtop_current} )
		&& looks_like_number( $immodpg->{_Vbot_multiplied} )
		&& looks_like_number( $immodpg->{_Vtop_multiplied} ) ) {

		$immodpg->{_Vbot_prior}   = $immodpg->{_Vbot_current};
		$immodpg->{_Vbot_current} = $immodpg->{_Vbot_multiplied};

		$immodpg->{_Vtop_prior}   = $immodpg->{_Vtop_current};
		$immodpg->{_Vtop_current} = $immodpg->{_Vtop_multiplied};

		# conveniently short variable names
		my $Vtop_current = $immodpg->{_Vtop_current};
		my $Vbot_current = $immodpg->{_Vbot_current};

		$immodpg->{_VtopEntry}->delete( 0, 'end' );
		$immodpg->{_VtopEntry}->insert( 0, $Vtop_current );
		$immodpg->{_VbotEntry}->delete( 0, 'end' );
		$immodpg->{_VbotEntry}->insert( 0, $Vbot_current );

		# print("immodpg, _updateVbotNtop_multiply, updated to $immodpg->{_VbotNtop_multiply_current}\n");
		# print("immodpg,_updateVbotNtop_multiply,VbotNtop_multiply_current=$immodpg->{_VbotNtop_multiply_current}\n");
		# print("immodpg,_updateVbotNtop_multiply,VbotNtop_multiply_prior=$immodpg->{_VbotNtop_multiply_prior}\n");

	} else {
		print("immodpg, _updateVbotNtop_factor, unexpected\n");
		return ();
	}
}

=head2 sub _update_clip

keep tabs on clip values
and change the values on the 
GUI

=cut

sub _update_clip {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_clip4plot_current} )
		&& $immodpg->{_clip4plot_current} != $immodpg->{_clip4plot_prior} ) {

		# CASE clip changed
		$immodpg->{_clip4plot_current} = $immodpg->{_clip4plot_current};
		$immodpg->{_is_clip_changed}   = $yes;

		# print("immodpg, _update_clip, updated to $immodpg->{_clip4plot_current}\n");
		# print("immodpg,_update_clip,clip4plot_current=$immodpg->{_clip4plot_current}\n");
		# print("immodpg,_update_clip,clip4plot_prior=$immodpg->{_clip4plot_prior}\n");
		return ();

	} elsif ( $immodpg->{_clip4plot_current} == $immodpg->{_clip4plot_prior} ) {

		# CASE clip has unchanged
		# print("immodpg, _update_clip, unchanged\n");
		$immodpg->{_is_clip_changed} = $no;

		# print("immodpg,_update_clip,clip4plot_current=$immodpg->{_clip4plot_current}\n");
		# print("immodpg,_update_clip,clip4plot_prior=$immodpg->{_clip4plot_prior}\n");
		return ();

	} else {
		print("immodpg, _update_clip, unexpected\n");
		return ();
	}
}

=head2 sub _update_thickness_m

keep tabs on thickness_m values
and change the values on the 
GUI

=cut

sub _update_thickness_m {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_thickness_m_current} )
		&& $immodpg->{_thickness_m_current} != $immodpg->{_thickness_m_prior} ) {

		# CASE _thickness_m changed
		$immodpg->{_is_thickness_m_changed} = $yes;

		# print("immodpg, _update_thickness_m, updated to $immodpg->{_thickness_m_current}\n");

		#		print("immodpg,_update_thickness_m,_thickness_m_current=$immodpg->{_thickness_m_current}\n");
		# print("immodpg,_update_thickness_m,_thickness_m_prior=$immodpg->{_thickness_m_prior}\n");
		return ();

	} elsif ( $immodpg->{_thickness_m_current} == $immodpg->{_thickness_m_prior} ) {

		# CASE _thickness_m has unchanged
		# print("immodpg, _update_thickness_m, unchanged\n");
		$immodpg->{_is_thickness_m_changed} = $no;

		# print("immodpg,_update_thickness_m,_thickness_m_current=$immodpg->{_thickness_m_current}\n");
		# print("immodpg,_update_thickness_m,_thickness_m_prior=$immodpg->{_thickness_m_prior}\n");
		return ();

	} else {
		print("immodpg, _update_thickness_m, unexpected\n");
		return ();
	}
}

=head2 sub _update_thickness_increment_m

keep tabs on thickness_increment_m values
and change the values on the 
GUI

=cut

sub _update_thickness_increment_m {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_thickness_increment_m_current} )
		&& $immodpg->{_thickness_increment_m_current} != $immodpg->{_thickness_increment_m_prior} ) {

		# CASE clip changed
		$immodpg->{_thickness_increment_m_current}    = $immodpg->{_thickness_increment_m_current};
		$immodpg->{_is_thickness_increment_m_changed} = $yes;

		# print("immodpg, _update_thickness_increment_m, updated to $immodpg->{_thickness_increment_m_current}\n");
		# print("immodpg,_update_thickness_increment_m,thickness_increment_m_current=$immodpg->{_thickness_increment_m_current}\n");
		# print("immodpg,_update_thickness_increment_m,thickness_increment_m_prior=$immodpg->{_thickness_increment_m_prior}\n");
		return ();

	} elsif ( $immodpg->{_thickness_increment_m_current} == $immodpg->{_thickness_increment_m_prior} ) {

		# CASE thickness_increment_mhas unchanged
		# print("immodpg, _update_thickness_increment_m, unchanged\n");
		$immodpg->{_is_thickness_increment_m_changed} = $no;

		# print("immodpg,_update_thickness_increment_m,thickness_increment_m_current=$immodpg->{_thickness_increment_m_current}\n");
		# print("immodpg,_update_thickness_increment_m,thickness_increment_m_prior=$immodpg->{_thickness_increment_m_prior}\n");
		return ();

	} else {
		print("immodpg, _update_thickness_increment_m, unexpected\n");
		return ();
	}
}

=head2 sub _update_layer

keep tabs on layer values
and change the values on the 
GUI

update prior in advance of _check_layer

=cut

sub _update_layer {

	my ($self) = @_;

	if (    looks_like_number( $immodpg->{_layer_current} )
		and length( $immodpg->{_layer_prior} and length( $immodpg->{_layerEntry} ) )
		and ( $immodpg->{_layer_current} != $immodpg->{_layer_prior} ) ) {

		# CASE layer changed
		$immodpg->{_is_layer_changed} = $yes;
		my $layer_current   = $immodpg->{_layer_current};
		my $new_layer_prior = $immodpg->{_layer_current};

		$immodpg->{_layerEntry}->delete( 0, 'end' );
		$immodpg->{_layerEntry}->insert( 0, $layer_current );

		$immodpg->{_layer_prior} = $new_layer_prior;

		#		print("immodpg, _update_layer, prior=$immodpg->{_layer_prior}current= $immodpg->{_layer_current}\n");

		return ();

	} elsif ( looks_like_number( $immodpg->{_layer_current} )
		and looks_like_number( $immodpg->{_layer_prior} )
		and ( $immodpg->{_layer_current} == $immodpg->{_layer_prior} ) ) {

		# CASE layer has not changed
		#		print("immodpg, _update_layer, unchanged\n");
		$immodpg->{_is_layer_changed} = $no;

		$immodpg->{_layerEntry}->delete( 0, 'end' );
		$immodpg->{_layerEntry}->insert( 0, $immodpg->{_layer_current} );

		#		print("immodpg,_update_layer, prior=$immodpg->{_layer_prior},current=$immodpg->{_layer_current}\n");
		return ();

	} else {
		print("immodpg, _update_layer, unexpected\n");
		return ();
	}
	return ();
}

=head2 sub _update_lower_layer

keep tabs on layer values
and change the values on the 
GUI

=cut

sub _update_lower_layer {

	my ($self) = @_;

	if (   $immodpg->{_is_layer_changed} eq $yes
		&& $immodpg->{_layer_current} >= 1 ) {

		# CASE layer changed
		my $lower_layer   = $immodpg->{_layer_current} + 1;
		my $layer_current = ( $immodpg->{_lower_layerLabel} )->configure( -textvariable => \$lower_layer, );

		return ();

	} elsif ( $immodpg->{_is_layer_changed} eq $no ) {

		# CASE layer has unchanged
		#		print("immodpg, _update_lower_layer, unchanged\n");
		return ();

	} else {
		print("immodpg, _update_lower_layer, unexpected\n");
		return ();
	}
}

=head2 sub _update_upper_layer

keep tabs on layer values
and change the values on the 
GUI

=cut

sub _update_upper_layer {

	my ($self) = @_;

	if (   $immodpg->{_is_layer_changed} eq $yes
		&& $immodpg->{_layer_current} >= 1 ) {

		# CASE layer changed
		my $upper_layer = $immodpg->{_layer_current} - 1;

		if ( $upper_layer == 0 ) {

			# control output
			$upper_layer = $empty_string;
		}
		my $layer_current = ( $immodpg->{_upper_layerLabel} )->configure( -textvariable => \$upper_layer, );
		return ();

	} elsif ( $immodpg->{_is_layer_changed} eq $no ) {

		# CASE layer has unchanged
		#		print("immodpg, _update_upper_layer, unchanged\n");
		return ();

	} else {
		return ();
		print("immodpg, _update_upper_layer, unexpected\n");
	}
}

=head2 sub _writeVincrement

write out Vincrement

=cut

sub _writeVincrement {
	my ($self) = @_;

	if ( $immodpg->{_isVincrement_changed} == $yes ) {
		_write_config();

	} elsif ( $immodpg->{_isVincrement_changed} == $no ) {

		#NADA

	} else {
		print("immodpg, _writeVincrement, unexpected\n");
	}
	return ();
}

=head2 sub _writeVbotNtop_factor

write out VbotNtop_factor

=cut

sub _writeVbotNtop_factor {
	my ($self) = @_;

	if ( $immodpg->{_isVbotNtop_factor_changed} == $yes ) {
		_write_config();

	} elsif ( $immodpg->{_isVbotNtop_factor_changed} == $no ) {

		#NADA

	} else {
		print("immodpg, _writeVbotNtop_factor, unexpected\n");
	}
	return ();
}

=head2 sub _write_clip

write out clip

=cut

sub _write_clip {
	my ($self) = @_;

	if ( $immodpg->{_is_clip_changed} == $yes ) {
		_write_config();

	} elsif ( $immodpg->{_is_clip_changed} == $no ) {

		#NADA

	} else {
		print("immodpg, _write_clip, unexpected\n");
	}
	return ();
}

=head2 sub _write_thickness_increment_m

write out thickness_increment_m

=cut

sub _write_thickness_increment_m {
	my ($self) = @_;

	if ( $immodpg->{_is_thickness_increment_m_changed} == $yes ) {
		_write_config();

	} elsif ( $immodpg->{_is_thickness_increment_m_changed} == $no ) {

		#NADA

	} else {
		print("immodpg, _write_thickness_increment_m, unexpected\n");
	}
	return ();
}

=head2 sub _write_config

write out the new values
as well as old values and their
names to the configuration file
called immodpg.config
External parameter names do not
agree always with variable names
used inside the programs
e.g., starting_layer versus layer
or   data_x_inc_m_m  versus thickness_increment_m

=cut

sub _write_config {

	my ($self) = @_;
	use immodpg_spec;

=pod 
instantiate modules

=cut	

	my $immodpg_spec = immodpg_spec->new();

=pod import private variables
_config_file_format			        => '%-35s%1s%-20s',

=cut	

	my $variables             = $immodpg_spec->variables();
	my $format_clip  		= $var_immodpg->{_config_file_format_clip};
	my $format_string         = $var_immodpg->{_config_file_format};
	my $format_real           = $var_immodpg->{_config_file_format_real};
	my $format_signed_integer = $var_immodpg->{_config_file_format_signed_integer};
	
=head2 correct errors

=cut

	#print("immodpg, _write_config,base_file_name:$immodpg->{_base_file_name}\n");

=pod
declare private variables

=cut

	my $file     = 'immodpg.config';
	my $outbound = $variables->{_CONFIG} . '/' . $file;

	open( OUT, ">$outbound" );

	printf OUT $format_string . "\n",         "base_file_name ",         "= ", $immodpg->{_base_file_name};
	printf OUT $format_string . "\n",         "pre_digitized_XT_pairs ", "= ", $immodpg->{_pre_digitized_XT_pairs};
	printf OUT $format_string . "\n",         "data_traces ",            "= ", $immodpg->{_data_traces};
	printf OUT $format_clip . "\n",           "clip ",                   "= ", $immodpg->{_clip4plot_current};
	printf OUT $format_real . "\n",           "min_t_s ",                "= ", $immodpg->{_min_t_s};
	printf OUT $format_real . "\n",           "min_x_m ",                "= ", $immodpg->{_min_x_m};
	printf OUT $format_real . "\n",           "data_x_inc_m ",           "= ", $immodpg->{_data_x_inc_m};
	printf OUT $format_real . "\n",           "source_depth_m ",         "= ", $immodpg->{_source_depth_m};
	printf OUT $format_real . "\n",           "receiver_depth_m ",       "= ", $immodpg->{_receiver_depth_m};
	printf OUT $format_real . "\n",           "reducing_vel_mps ",       "= ", $immodpg->{_reducing_vel_mps};
	printf OUT $format_real . "\n",           "plot_min_x_m ",           "= ", $immodpg->{_plot_min_x_m};
	printf OUT $format_real . "\n",           "plot_max_x_m ",           "= ", $immodpg->{_plot_max_x_m};
	printf OUT $format_real . "\n",           "plot_min_t_s ",           "= ", $immodpg->{_plot_min_t_s};
	printf OUT $format_real . "\n",           "plot_max_t_s ",           "= ", $immodpg->{_plot_max_t_s};
	printf OUT $format_string . "\n",         "previous_model ",         "= ", $immodpg->{_previous_model};
	printf OUT $format_string . "\n",         "new_model ",              "= ", $immodpg->{_new_model};
	printf OUT $format_signed_integer . "\n", "starting_layer ",         "= ", $immodpg->{_layer_current};
	printf OUT $format_real . "\n",           "VbotNtop_factor ",        "= ", $immodpg->{_VbotNtop_factor_current};
	printf OUT $format_real . "\n",           "Vincrement_mps",          "= ", $immodpg->{_Vincrement_current};
	printf OUT $format_real . "\n", "thickness_increment_m ", "= ", $immodpg->{_thickness_increment_m_current};

	close(OUT);

}

=head2 sub getVp_dz_initial

=cut

sub getVp_dz_initial {

	my ($self) = @_;

	if ( looks_like_number( $immodpg->{_model_layer_number} ) ) {

		my ( $_thickness_m_upper_layer, $Vbot_lower_layer );
		my ( @V,                        @result );

		my $layer = $immodpg->{_model_layer_number};
		my ( $ref_VPtop, $ref_VPbot, $ref_dz ) = _get_model();

		my @VPtop = @$ref_VPtop;
		my @VPbot = @$ref_VPbot;
		my @dz    = @$ref_dz;

		#		print("immodpg,getVp_dz_initial VPtop= @VPtop\n");
		#		print("immodpg,getVp_dz_initial VPbot= @VPbot\n");
		#		print("immodpg,getVp_dz_initial layer_number = $layer \n");
		#
		my $layer_index             = $layer - 1;
		my $layer_index_upper_layer = $layer - 2;
		my $layer_index_lower_layer = $layer;

		# For all cases
		my $Vtop = $VPtop[$layer_index];
		my $Vbot = $VPbot[$layer_index];
		my $dz   = $dz[$layer_index];

		if ( $layer >= 2 ) {

			# CASE of second of two or more layers
			my $Vbot_upper_layer = $VPbot[$layer_index_upper_layer];
			my $Vtop_lower_layer = $VPtop[$layer_index_lower_layer];

			$V[0] = $Vbot_upper_layer;
			$V[1] = $Vtop;
			$V[2] = $Vbot;
			$V[3] = $Vtop_lower_layer;

			@result = @V;

			#			print("immodpggetVp_dz_initial: velocities are:  @V \n");
			return ( \@result, $dz );

		} elsif ( $layer >= 1 ) {

			# CASE of first of one or more layers
			my $Vbot_upper_layer = $empty_string;
			my $Vtop_lower_layer = $VPtop[$layer_index_lower_layer];

			$V[0] = $Vbot_upper_layer;
			$V[1] = $Vtop;
			$V[2] = $Vbot;
			$V[3] = $Vtop_lower_layer;

			@result = @V;
			return ( \@result, $dz );

		} else {
			print("immodpg, getVp_dz_initial, unexpected layer number \n");
			return ();
		}

	} else {
		return ();
		print("immodpg,getVp_dz_initial, missing layer\n");
	}
	return ();
}

=head2 set_defaults
1. Get starting configuration 
parameters from configuration file
directly and independently of main

=cut

sub set_defaults {

	my ($self) = @_;

	my ( $CFG_h, $CFG_aref ) = $immodpg_config->get_values();

	$immodpg->{_base_file_name}         = $CFG_h->{immodpg}{1}{base_file_name};
	$immodpg->{_pre_digitized_XT_pairs} = $CFG_h->{immodpg}{1}{pre_digitized_XT_pairs};
	$immodpg->{_data_traces}            = $CFG_h->{immodpg}{1}{data_traces};
	$immodpg->{_clip}                   = $CFG_h->{immodpg}{1}{clip};
	$immodpg->{_min_t_s}                = $CFG_h->{immodpg}{1}{min_t_s};
	$immodpg->{_min_x_m}                = $CFG_h->{immodpg}{1}{min_x_m};
	$immodpg->{_data_x_inc_m}           = $CFG_h->{immodpg}{1}{data_x_inc_m};
	$immodpg->{_source_depth_m}         = $CFG_h->{immodpg}{1}{source_depth_m};
	$immodpg->{_receiver_depth_m}       = $CFG_h->{immodpg}{1}{receiver_depth_m};
	$immodpg->{_reducing_vel_mps}       = $CFG_h->{immodpg}{1}{reducing_vel_mps};
	$immodpg->{_plot_min_x_m}           = $CFG_h->{immodpg}{1}{plot_min_x_m};
	$immodpg->{_plot_max_x_m}           = $CFG_h->{immodpg}{1}{plot_max_x_m};
	$immodpg->{_plot_min_t_s}           = $CFG_h->{immodpg}{1}{plot_min_t_s};
	$immodpg->{_plot_max_t_s}           = $CFG_h->{immodpg}{1}{plot_max_t_s};
	$immodpg->{_previous_model}         = $CFG_h->{immodpg}{1}{previous_model};
	$immodpg->{_new_model}              = $CFG_h->{immodpg}{1}{new_model};
	$immodpg->{_layer}                  = $CFG_h->{immodpg}{1}{layer};
	$immodpg->{_VbotNtop_factor}        = $CFG_h->{immodpg}{1}{VbotNtop_factor};
	$immodpg->{_Vincrement}             = $CFG_h->{immodpg}{1}{Vincrement_mps};
	$immodpg->{_thickness_increment_m}  = $CFG_h->{immodpg}{1}{thickness_increment_m};

	#    print("immodpg,set_defaults,data_x_inc_m=$immodpg->{_data_x_inc_m}\n");

=head2 Error control
 - clip ( ne 0)
 - layer number can be no smaller than 1
 or greater than max-1
 
 clip >=0
 
=cut

	_set_clip_control( $immodpg->{_clip} );
	$immodpg->{_clip} = _get_control_clip();

	_set_layer_control( $immodpg->{_layer} );
	$immodpg->{_layer} = _get_control_layer();

	_set_model_layer( $immodpg->{_layer} );
	my ( $Vp_ref, $dz ) = _getVp_dz_initial();
	my @V = @$Vp_ref;
	$immodpg->{_thickness_m} = $dz;

	my $Vbot_upper_layer = $V[0];
	my $Vtop             = $V[1];
	my $Vbot             = $V[2];
	my $Vtop_lower_layer = $V[3];

	$immodpg->{_Vbot}             = $Vbot;
	$immodpg->{_Vbot_upper_layer} = $Vbot_upper_layer;
	$immodpg->{_Vtop}             = $Vtop;
	$immodpg->{_Vtop_lower_layer} = $Vtop_lower_layer;

	# default values for Vbot-related variables
	$immodpg->{_Vbot_default} = $immodpg->{_Vbot};
	$immodpg->{_Vbot_current} = $immodpg->{_Vbot_default};
	$immodpg->{_Vbot_prior}   = $immodpg->{_Vbot_default};
	$immodpg->{_inVbot}       = $no;
	$immodpg->{_outsideVbot}  = $yes;

	# default values for Vbot_upper_layer-related variables
	$immodpg->{_Vbot_upper_layer_default} = $immodpg->{_Vbot_upper_layer};
	$immodpg->{_Vbot_upper_layer_current} = $immodpg->{_Vbot_upper_layer_default};
	$immodpg->{_Vbot_upper_layer_prior}   = $immodpg->{_Vbot_upper_layer_default};
	$immodpg->{_inVbot_upper_layer}       = $no;
	$immodpg->{_outsideVbot_upper_layer}  = $yes;

	# default values for Vincrement-related variables
	$immodpg->{_Vincrement_default} = $immodpg->{_Vincrement};
	$immodpg->{_Vincrement_current} = $immodpg->{_Vincrement_default};
	$immodpg->{_Vincrement_prior}   = $immodpg->{_Vincrement_default};
	$immodpg->{_inVincrement}       = $no;
	$immodpg->{_outsideVincrement}  = $yes;

	# default values for Vtop-related variables
	$immodpg->{_Vtop_default} = $immodpg->{_Vtop};
	$immodpg->{_Vtop_current} = $immodpg->{_Vtop_default};
	$immodpg->{_Vtop_prior}   = $immodpg->{_Vtop_default};
	$immodpg->{_inVtop}       = $no;
	$immodpg->{_outsideVtop}  = $yes;

	# default values for Vtop_lower_layer-related variables
	$immodpg->{_Vtop_lower_layer_default} = $immodpg->{_Vtop_lower_layer};
	$immodpg->{_Vtop_lower_layer_current} = $immodpg->{_Vtop_lower_layer_default};
	$immodpg->{_Vtop_lower_layer_prior}   = $immodpg->{_Vtop_lower_layer_default};
	$immodpg->{_inVtop_lower_layer}       = $no;
	$immodpg->{_outsideVtop_lower_layer}  = $yes;

	# default values for VbotNtop_factor-related variables
	$immodpg->{_VbotNtop_factor_default} = $immodpg->{_VbotNtop_factor};
	$immodpg->{_VbotNtop_factor_current} = $immodpg->{_VbotNtop_factor_default};
	$immodpg->{_VbotNtop_factor_prior}   = $immodpg->{_VbotNtop_factor_default};
	$immodpg->{_inVbotNtop_factor}       = $no;
	$immodpg->{_outsideVbotNtop_factor}  = $yes;

	# default values for clip-related variables
	$immodpg->{_clip4plot_default} = $immodpg->{_clip};
	$immodpg->{_clip4plot_current} = $immodpg->{_clip4plot_default};
	$immodpg->{_clip4plot_prior}   = $immodpg->{_clip4plot_default};
	$immodpg->{_clip4plot}         = $immodpg->{_clip4plot_default};
	$immodpg->{_in_clip}           = $no;
	$immodpg->{_outside_clip}      = $yes;

	# default values for layer-related variables
	$immodpg->{_layer_default} = $immodpg->{_layer};
	$immodpg->{_layer_current} = $immodpg->{_layer_default};
	$immodpg->{_layer_prior}   = $immodpg->{_layer_default};
	$immodpg->{_in_layer}      = $no;
	$immodpg->{_outside_layer} = $yes;

	# default values for thickness_m-related variables
	$immodpg->{_thickness_m_default} = $immodpg->{_thickness_m};
	$immodpg->{_thickness_m_current} = $immodpg->{_thickness_m_default};
	$immodpg->{_thickness_m_prior}   = $immodpg->{_thickness_m_default};
	$immodpg->{_in_thickness_m}      = $no;
	$immodpg->{_outside_thickness_m} = $yes;

	# default values for thickness_increment_m-related variables
	$immodpg->{_thickness_increment_m_default} = $immodpg->{_thickness_increment_m};
	$immodpg->{_thickness_increment_m_current} = $immodpg->{_thickness_increment_m_default};
	$immodpg->{_thickness_increment_m_prior}   = $immodpg->{_thickness_increment_m_default};
	$immodpg->{_in_thickness_increment_m}      = $no;
	$immodpg->{_outside_thickness_increment_m} = $yes;

}

=head2 sub setVbot_minus

update Vbot value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVbot_minus {

	my ($self) = @_;

	if ( length( $immodpg->{_VbotEntry} )
		and looks_like_number( $immodpg->{_Vincrement_current} ) ) {

		my $Vbot = ( $immodpg->{_VbotEntry} )->get();

		if ( looks_like_number($Vbot) ) {

			my $Vincrement = ( $immodpg->{_VincrementEntry} )->get();
			my $new_Vbot   = $Vbot - $Vincrement;

			$immodpg->{_Vbot_prior}   = $immodpg->{_Vbot_current};
			$immodpg->{_Vbot_current} = $new_Vbot;

			$immodpg->{_VbotEntry}->delete( 0, 'end' );
			$immodpg->{_VbotEntry}->insert( 0, $new_Vbot );

			$immodpg->{_isVbot_changed} = $yes;

			#						print("immodpg, setVbot_minus, new Vbot= $new_Vbot\n");
			#						print("immodpg, setVbot_minus, Vincrement= $Vincrement\n");

			if ( $immodpg->{_isVbot_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, setVbot_minus, Vbot is changed: $yes \n");

				_set_option($Vbot_minus_opt);
				_set_change($yes);

				#								print("immodpg, setVbot_minus,option:$Vbot_minus_opt\n");
				#				print("immodpg, setVbot_minus, V=$immodpg->{_Vbot_current}\n");

			} else {

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				# print("immodpg, setVbot_minus, same Vbot NADA\n");
			}

		} else {
			print("immodpg, setVbot_minus, Vbot value missing\n");
		}

	} else {
		print("immodpg, setVbot_minus, missing widget or Vincrement\n");

		#		print("immodpg, setVbot_minus, VbotEntry=$immodpg->{_VbotEntry}\n");
		#		print("immodpg, setVbot_minus, Vincrement=$immodpg->{_Vincrement_current}\n");
	}
	return ();
}

=head2 sub setVbot_plus

update Vbot value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVbot_plus {

	my ($self) = @_;

	if ( length( $immodpg->{_VbotEntry} )
		&& looks_like_number( $immodpg->{_Vincrement_current} ) ) {

		my $Vbot = ( $immodpg->{_VbotEntry} )->get();

		if ( looks_like_number($Vbot) ) {

			my $Vincrement = ( $immodpg->{_VincrementEntry} )->get();
			my $new_Vbot   = $Vbot + $Vincrement;

			$immodpg->{_Vbot_prior}   = $immodpg->{_Vbot_current};
			$immodpg->{_Vbot_current} = $new_Vbot;

			$immodpg->{_VbotEntry}->delete( 0, 'end' );
			$immodpg->{_VbotEntry}->insert( 0, $new_Vbot );

			$immodpg->{_isVbot_changed} = $yes;

			#			print("immodpg, setVbot_plus, new Vbot= $new_Vbot\n");
			#			print("immodpg, setVbot_plus, Vincrement= $Vincrement\n");

			if ( $immodpg->{_isVbot_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, setVbot_plus, Vbot is changed: $yes \n");

				_set_option($Vbot_plus_opt);
				_set_change($yes);

				#				print("immodpg, setVbot_plus,option:$Vbot_plus_opt\n");
				#				print("immodpg, setVbot_plus, V=$immodpg->{_Vbot_current}\n");

			} else {

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#				print("immodpg, setVbot_plus, same Vbot NADA\n");
			}

		} else {
			print("immodpg, setVbot_plus, Vbot value missing\n");
		}

	} else {
		print("immodpg, setVbot_plus, missing widget or Vincrement\n");

		#		print("immodpg, setVbot_plus, VbotEntry=$immodpg->{_VbotEntry}\n");
		#		print("immodpg, setVbot_plus, Vincrement=$immodpg->{_Vincrement}\n");
	}
	return ();
}

=head2 sub setVtop_minus

update Vtop value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVtop_minus {

	my ($self) = @_;

	if ( length( $immodpg->{_VtopEntry} )
		&& looks_like_number( $immodpg->{_Vincrement_current} ) ) {

		my $Vtop = ( $immodpg->{_VtopEntry} )->get();

		if ( looks_like_number($Vtop) ) {

			my $Vincrement = ( $immodpg->{_VincrementEntry} )->get();
			my $new_Vtop   = $Vtop - $Vincrement;

			$immodpg->{_Vtop_prior}   = $immodpg->{_Vtop_current};
			$immodpg->{_Vtop_current} = $new_Vtop;

			$immodpg->{_VtopEntry}->delete( 0, 'end' );
			$immodpg->{_VtopEntry}->insert( 0, $new_Vtop );

			$immodpg->{_isVtop_changed} = $yes;

			#			print("immodpg, setVtop_minus, new Vtop= $new_Vtop\n");
			#			print("immodpg, setVtop_minus, Vincrement= $Vincrement\n");

			if ( $immodpg->{_isVtop_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, set_Vtop_minus, Vtop is changed: $yes \n");

				_set_option($Vtop_minus_opt);
				_set_change($yes);

				#				print("immodpg, setVtop_minus,option:$Vtop_minus_opt\n");
				#				print("immodpg, setVtop_minus, V=$immodpg->{_Vtop_current}\n");

			} else {

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				print("immodpg, setVtop_minus, same Vtop NADA\n");
			}

		} else {
			print("immodpg, setVtop_minus, Vtop value missing\n");
		}

	} else {
		print("immodpg, setVtop_minus, missing widget or Vincrement\n");

		print("immodpg, setVtop_minus, VtopEntry=$immodpg->{_VtopEntry}\n");
		print("immodpg, setVtop_minus, Vincrement=$immodpg->{_Vincrement_current}\n");
	}
	return ();
}

=head2 sub setVtop_plus

update Vtop value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVtop_plus {

	my ($self) = @_;

	#   print("0. immodpg, setVtop_plus, VtopEntry=$immodpg->{_VtopEntry}\n");
	if (   length( $immodpg->{_VtopEntry} )
		&& length( $immodpg->{_VincrementEntry} ) ) {

		#		print("1. immodpg, setVtop_plus, VtopEntry=$immodpg->{_VtopEntry}\n");
		my $Vtop = ( $immodpg->{_VtopEntry} )->get();

		if ( looks_like_number($Vtop) ) {

			my $Vincrement = ( $immodpg->{_VincrementEntry} )->get();
			my $new_Vtop   = $Vtop + $Vincrement;

			$immodpg->{_Vtop_prior}   = $immodpg->{_Vtop_current};
			$immodpg->{_Vtop_current} = $new_Vtop;

			$immodpg->{_VtopEntry}->delete( 0, 'end' );
			$immodpg->{_VtopEntry}->insert( 0, $new_Vtop );

			$immodpg->{_isVtop_changed} = $yes;

			#			print("immodpg, set new Vtop= $new_Vtop\n");
			#			print("immodpg, setVtop_plus, Vincrement= $Vincrement\n");
			#			print("2. immodpg, setVtop_plus, VtopEntry=$immodpg->{_VtopEntry}\n");
			if ( $immodpg->{_isVtop_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, set_Vtop_plus, Vtop is changed: $yes \n");

				_set_option($Vtop_plus_opt);
				_set_change($yes);

				#				print("immodpg, setVtop_plus,option:$Vtop_plus_opt\n");
				#				print("immodpg, setVtop_plus, V=$immodpg->{_Vtop_current}\n");

			} else {

				#				print("immodpg, setVtop_plus, VtopEntry=$immodpg->{_VtopEntry}\n");
				#				print("immodpg, setVtop_plus, Vincrement=$immodpg->{_Vincrement_current}\n");

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#				print("immodpg, setVtop_plus, same Vtop NADA\n");
			}

		} else {
			print("immodpg, setVtop_plus, Vtop value missing\n");

			#			print("immodpg, setVtop_plus, VtopEntry=$immodpg->{_VtopEntry}\n");
			#			print("immodpg, setVtop_plus, Vincrement=$immodpg->{_Vincrement_current}\n");
		}

	} else {
		print("immodpg, setVtop_plus, missing widget or Vincrement\n");
		print("immodpg, setVtop_plus, VtopEntry=$immodpg->{_VtopEntry}\n");
		print("immodpg, setVtop_plus, Vincrement=$immodpg->{_Vincrement_current}\n");
	}
	return ();
}

=head2 sub cdp 


=cut

sub cdp {

	my ( $self, $cdp ) = @_;
	if ($cdp) {

		$immodpg->{_cdp}  = $cdp;
		$immodpg->{_note} = $immodpg->{_note} . ' cdp=' . $immodpg->{_cdp};
		$immodpg->{_Step} = $immodpg->{_Step} . ' cdp=' . $immodpg->{_cdp};

	} else {
		print("immodpg, cdp, missing cdp,\n");
	}
}

=head2 sub clean_trash
delete remaining locked files
reset default files as well

=cut

sub clean_trash {
	my ($self) = @_;
	use File::stat;

	my ($outbound_locked);

	my @X;
	my $Vbot_file                  = $immodpg->{_Vbot_file};
	my $VbotNtop_factor_file       = $immodpg->{_VbotNtop_factor_file};
	my $Vbot_upper_layer_file      = $immodpg->{_Vbot_upper_layer_file};
	my $Vincrement_file            = $immodpg->{_Vincrement_file};
	my $Vtop_file                  = $immodpg->{_Vtop_file};
	my $Vtop_lower_layer_file      = $immodpg->{_Vtop_lower_layer_file};
	my $change_file                = $immodpg->{_change_file};
	my $clip_file                  = $immodpg->{_clip_file};
	my $immodpg_model              = $immodpg->{_immodpg_model};
	my $layer_file                 = $immodpg->{_layer_file};
	my $option_file                = $immodpg->{_option_file};
	my $thickness_m_file           = $immodpg->{_thickness_m_file};
	my $thickness_increment_m_file = $immodpg->{_thickness_increment_m_file};

	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $Vbot_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $VbotNtop_factor_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $Vbot_upper_layer_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $Vincrement_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $Vtop_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $Vtop_lower_layer_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $change_file . '_locked';

	# print("delete $outbound_locked\n");
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $clip_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG . '/' . $immodpg_model . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $layer_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $option_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $thickness_m_file . '_locked';
	unlink($outbound_locked);
	$outbound_locked = $IMMODPG_INVISIBLE . '/' . $thickness_increment_m_file . '_locked';
	unlink($outbound_locked);

	_fortran_layer( $immodpg->{_layer_default} );
	_set_option( $immodpg->{_option_default} );
	_set_change( $immodpg->{_change_default} );

	# delete empty files
	my ( @size,      @file_name, @inode );
	my ( $i,         $junk,      $cmd_file_name, $num_file_names );
	my ( $cmd_inode, $cmd_size,  $index_node_number );

	# remove weird lock files from the main directory
	$cmd_file_name  = "ls -1 $IMMODPG";
	$cmd_size       = "ls -s1 $IMMODPG";
	$cmd_inode      = "ls -i1 $IMMODPG";
	@file_name      = `$cmd_file_name`;
	@size           = `$cmd_size`;
	@inode          = `$cmd_inode`;
	$num_file_names = scalar @file_name;

	for ( my $i = 0; $i < $num_file_names; $i++ ) {
		chomp $file_name[$i];
		chomp $inode[$i];

		$inode[$i] =~ s/^\s+//g;    # trim spaces at start
		( $inode[$i], $junk ) = split( / /, $inode[$i] );

	}

	for ( my $i = 1; $i <= $num_file_names; $i++ ) {

		chomp $size[$i];
		$size[$i] =~ s/^\s+//g;     # trim spaces at start
		( $size[$i], $junk ) = split( / /, $size[$i] );

	}

	for ( my $i = 0, my $j = 1; $i < $num_file_names; $i++, $j++ ) {

#		print("CASE VISIBLE  name inode size = $file_name[$i] $inode[$i] $size[$j]\n");

		if ( $size[$j] == 0 ) {
			$index_node_number = $inode[$i];
			my $flow = (
				"cd $IMMODPG
								find . -inum $index_node_number -exec rm {} \\;"
			);
#			print $flow;
			system $flow;

		} else {
#			print("immodpg,clean_trash,size>0,line=$i, NADA\n");
		}
	}
	# remove weird lock files from the invisible  directory inside the main directory
	$cmd_file_name  = "ls -1 $IMMODPG_INVISIBLE";
	$cmd_size       = "ls -s1 $IMMODPG_INVISIBLE";
	$cmd_inode      = "ls -i1 $IMMODPG_INVISIBLE";
	@file_name      = `$cmd_file_name`;
	@size           = `$cmd_size`;
	@inode          = `$cmd_inode`;
	$num_file_names = scalar @file_name;

	for ( my $i = 0; $i < $num_file_names; $i++ ) {
		chomp $file_name[$i];
		chomp $inode[$i];

		$inode[$i] =~ s/^\s+//g;    # trim spaces at start
		( $inode[$i], $junk ) = split( / /, $inode[$i] );

	}

	for ( my $i = 1; $i <= $num_file_names; $i++ ) {

		chomp $size[$i];
		$size[$i] =~ s/^\s+//g;     # trim spaces at start
		( $size[$i], $junk ) = split( / /, $size[$i] );

	}

	for ( my $i = 0, my $j = 1; $i < $num_file_names; $i++, $j++ ) {

#		print("CASE 2 INVISIBLE name inode size = $file_name[$i] $inode[$i] $size[$j]\n");

		if ( $size[$j] == 0 ) {
			$index_node_number = $inode[$i];
			my $flow = (
				"cd $IMMODPG_INVISIBLE
								find . -inum $index_node_number -exec rm {} \\;"
			);
#			print $flow;
			system $flow;

		} else {
#			print("immodpg,clean_trash,size>0,line=$i, NADA\n");
		}
	}

	return ();
}

=head2 sub clear

=cut

sub clear {
	$immodpg->{_base_file_name} = '';
	$immodpg->{_cdp}            = '';
	$immodpg->{_invert}         = '';
	$immodpg->{_lmute}          = '';
	$immodpg->{_smute}          = '';
	$immodpg->{_sscale}         = '';
	$immodpg->{_scaled_par}     = '';
	$immodpg->{_tnmo}           = '';
	$immodpg->{_upward}         = '';
	$immodpg->{_vnmo}           = '';
	$immodpg->{_voutfile}       = '';
	$immodpg->{_Step}           = '';
	$immodpg->{_note}           = '';
}

=head2 subroutine exit

=cut

sub exit {

	use xk;
	my $xk = xk->new();

	$xk->set_process('immodpg1.1');

	#	print("immodpg,exit: kill immodpg1.1\n");
	$xk->kill_process();

	$xk->set_process('pgxwin_server');

	#	print("immodpg,exit: kill pgxwin_server\n");
	$xk->kill_process();

	print("immodpg,exit: Goodbye!\n");

	return ();

}

=head2 sub get_control_clip
adjust clip value

=cut

sub get_control_clip {

	my ($self) = @_;

	my $result;

	if ( length( $immodpg->{_control_clip} ) ) {

		#		print("1. immodpg, get_control_clip, old control_clip= $immodpg->{_control_clip}\n");
		my $control_clip = $immodpg->{_control_clip};

		if ( $control_clip <= 0 ) {

			# case 1 layer number exceeds possible value
			$control_clip = 1;
			$result       = $control_clip;

		} else {

			#			print("immodpg, get_control_clip, NADA\n");
			$result = $control_clip;
		}

		#		print("2. immodpg, get_control_clip, new control_clip= $control_clip\n");
		return ($result);

	} else {
		print("immodpg, get_control_clip,  missing clip value\n");
	}
	return ();
}

=head2 sub  get_control_layer
Layer value is adjustable
Working layer
number must be
>= 1

=cut

sub get_control_layer {

	my ($self) = @_;

	my $result;

	#	print("1. immodpg, get_control_layer, control_layer_external= $immodpg->{_control_layer_external}\n");

	if ( length( $immodpg->{_control_layer_external} ) ) {

		# CASE 1
		#		print("CASE 1: immodpg, get_control_layer, control_layer_external= $immodpg->{_control_layer_external}\n");

		my $layer_current    = $immodpg->{_control_layer_external};
		my $number_of_layers = _get_number_of_layers();

		# print("2. immodpg, get_control_layer, number_of_layers= $number_of_layers\n");

		if ( $layer_current > $number_of_layers ) {

			# case 1A layer number exceeds possible value
			#			print("case1A: immodpg, get_control_layer, layer number too large\n");
			#			print("immodpg, get_control_layer, layer_number=$layer_current}\n");
			$layer_current = $number_of_layers - 1;

			# print("immodpg, get_control_layer, new layer_number=$layer_current}\n");
			$result = $layer_current;

		} elsif ( $layer_current < 1 ) {

			$layer_current = 1;
			$result        = $layer_current;

			#			print("CASE 1B immodpg, get_control_layer, layer_number=$layer_current}\n");

		} elsif ( $layer_current == 1 ) {

			$layer_current = 1;
			$result        = $layer_current;

			#			print("CASE 1 C immodpg, get_control_layer, layer=$layer_current\n");

		} elsif ( ( $layer_current < $number_of_layers ) ) {

			$result = $layer_current;

			#			print("CASE 1 D immodpg, get_control_layer, layer=$layer_current\n");

			# NADA

		} elsif ( ( $layer_current == $number_of_layers ) ) {

			$result = $layer_current - 1;

			#			print("iCASE 1 E mmodpg, get_control_layer, layer=$layer_current\n");
			# NADA

		} else {
			print("immodpg, get_control_layer, unexpected layer number\n");
			$result = $empty_string;
		}

	} elsif ( length( $immodpg->{_control_layer_external} ) == 0 ) {

		$result = 1;

		#		print("CASE 2immodpg, get_control_layer, empty string layer updated to $result\n");

	} else {
		print("immodpg, get_control_layer, unexpected value\n");
	}

	return ($result);
}

=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut

sub get_max_index {
	my ($self) = @_;
	my $max_index = 14;

	return ($max_index);
}

=head2

determine number of layers
from model.text file

=cut

sub get_number_of_layers {

	my ($self) = @_;
	my $number_of_layers;

	if ( length( $immodpg->{_model_file_text} ) ) {

		my $count                   = 0;
		my $magic_number            = 4;
		my $inbound_model_file_text = $IMMODPG_INVISIBLE . '/' . $immodpg->{_model_file_text};

		#		print ("immodpg,_get_number_of_layers,inbound_model_file_text=$inbound_model_file_text\n");

		open( my $fh, '<', $inbound_model_file_text );

		while (<$fh>) {

			$count++;

		}
		close($fh);

		$number_of_layers = $count - $magic_number;

		#		print("immodpg,_get_number_of_layers, layers = $number_of_layers \n");

	} else {

		# print("immodpg,_get_number_of_layers, missing values\n");
		$number_of_layers = 0;
	}

	my $result = $number_of_layers;
	return ($result);
}

=head2 sub setVbot

When you enter or leave
check what the current Vbot value is
compared to former Vbot values
Vtop value is updated in immodpg.for 
through a message in file= "Vbot"
(&_setVbot)

=cut

sub setVbot {

	my ($self) = @_;

	my $isVbot_changed = $immodpg->{_isVbot_changed};

	if ( length( $immodpg->{_VbotEntry} ) ) {

		$immodpg->{_Vbot_current} = ( $immodpg->{_VbotEntry} )->get();

		# redefinition required ???
		$immodpg->{_isVbot_changed} = $isVbot_changed;

		#		print("immodpg, setVbot, $immodpg->{_isVbot_changed}\n");

		_checkVbot();
		_updateVbot();

		if ( length( $immodpg->{_isVbot_changed} )
			&& $immodpg->{_isVbot_changed} eq $yes ) {

			# for fortran program to read
			# print("immodpg, set_Vbot, Vbot is changed: $yes \n");

			_setVbot( $immodpg->{_Vbot_current} );
			_set_option($Vbot_opt);
			_set_change($yes);

			# print("immodpg, setVbot,option:$Vbot_opt\n");
			#			print("immodpg, setVbot, V=$immodpg->{_Vbot_current}\n");

		} else {

			#			negative cases are reset by fortran program
			#			and so eliminate need to read locked files
			#			while use of locked files helps most of the time
			#			creation and deletion of locked files in perl are not
			#			failsafe

			#  print("immodpg, setVbot, same Vbot NADA\n");
		}

	} else {

	}
}

=head2 sub setVbot_upper_layer

When you enter or leave
check what the current Vbot_upper_layer value is
compared to former Vbot_upper_layer values
Vtop value is updated in immodpg.for 
through a message in file= "Vbot_lower"
(&_setVbot_upper_layer)

=cut

sub setVbot_upper_layer {

	my ($self) = @_;

	# for convenience
	my $isVbot_upper_layer_changed = $immodpg->{_isVbot_upper_layer_changed};
	my $layer_current              = $immodpg->{_layer_current};

	# print("immodpg, setVbot_upper_layer, self, $self\n");

	if ( length( $immodpg->{_Vbot_upper_layerEntry} ) ) {

		my $Vbot_upper_layer_current = ( $immodpg->{_Vbot_upper_layerEntry} )->get();

		# redfinition of lost value ????
		$immodpg->{_isVbot_upper_layer_changed} = $isVbot_upper_layer_changed;

		if (    $Vbot_upper_layer_current ne $empty_string
			and looks_like_number($Vbot_upper_layer_current)
			and $layer_current > 0 ) {

			#			print("immodpg, setVbot_upper_layer, V=$immodpg->{_Vbot_upper_layer}\n");

			_checkVbot_upper_layer();
			_updateVbot_upper_layer();

			if ( $immodpg->{_isVbot_upper_layer_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, set_Vbot_upper_layer, Vbot_upper_layer is changed: $yes \n");

				_setVbot_upper_layer( $immodpg->{_Vbot_upper_layer_current} );
				_set_option($Vbot_upper_layer_opt);
				_set_change($yes);

				#				print("immodpg, setVbot_upper_layer,option:$Vbot_upper_layer_opt\n");
				#				print("immodpg, setVbot_upper_layer,V= $immodpg->{_Vbot_upper_layer_current}\n");

			} else {

				#			negative cases are reset by fortran program
				#			and so eliminate need to read locked files
				#			while use of locked files helps most of the time
				#			creation and deletion of locked files in perl are not
				#			failsafe

				# print("immodpg, setVbot_upper_layer, same Vbot NADA\n");
			}

		} else {

			# print("immodpg, setVbot_upper_layer, Velocity is empty in non-layer NADA\n");
		}

	} else {

	}
}

=head2 setVbotNVtop_lower_layer_minus
update Vbot value in gui
update Vtop_lower_layer value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVbotNVtop_lower_layer_minus {

	my ($self) = @_;

	if (   looks_like_number( $immodpg->{_Vincrement_current} )
		&& length( $immodpg->{_Vtop_lower_layerEntry} )
		&& length( $immodpg->{_VbotEntry} ) ) {

		my $Vbot             = ( $immodpg->{_VbotEntry} )->get();
		my $Vtop_lower_layer = ( $immodpg->{_Vtop_lower_layerEntry} )->get();
		my $Vincrement       = ( $immodpg->{_VincrementEntry} )->get();

		if (   looks_like_number($Vtop_lower_layer)
			&& looks_like_number($Vbot) ) {

			my $new_Vtop_lower_layer = $Vtop_lower_layer - $Vincrement;
			my $new_Vbot             = $Vbot - $Vincrement;

			$immodpg->{_Vtop_lower_layer_prior}   = $immodpg->{_Vtop_lower_layer_current};
			$immodpg->{_Vtop_lower_layer_current} = $new_Vtop_lower_layer;

			$immodpg->{_Vbot_prior}   = $immodpg->{_Vbot_current};
			$immodpg->{_Vbot_current} = $new_Vbot;

			$immodpg->{_Vtop_lower_layerEntry}->delete( 0, 'end' );
			$immodpg->{_Vtop_lower_layerEntry}->insert( 0, $new_Vtop_lower_layer );

			$immodpg->{_VbotEntry}->delete( 0, 'end' );
			$immodpg->{_VbotEntry}->insert( 0, $new_Vbot );

			$immodpg->{_isVtop_lower_layer_changed} = $yes;
			$immodpg->{_isVbot_changed}             = $yes;

			#			print("immodpg, setVbotNVtop_lower_layer_minus, new Vtop_lower_layer= $new_Vtop_lower_layer\n");
			#			print("immodpg, setVbotNVtop_lower_layer_minus, Vincrement= $Vincrement\n");

			if (   $immodpg->{_isVtop_lower_layer_changed} eq $yes
				&& $immodpg->{_isVbot_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, setVbotNVtop_lower_layer_minus, Vbot is changed: $yes \n");

				_set_option($VbotNVtop_lower_layer_minus_opt);
				_set_change($yes);

				#				print("immodpg, setVbotNVtop_lower_layer_minus,option:$VbotNVtop_lower_layer_minus_opt\n");
				#				print("immodpg, setVbotNVtop_lower_layer_minus, V=$immodpg->{_Vtop_lower_layer_current}\n");

			} else {

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#				print("immodpg, setVbotNVtop_lower_layer_minus, same Vbot and Vtop_lower_layer; NADA\n");
			}

		} else {
			print("immodpg, setVbotNVtop_lower_layer_minus, Vbot or Vtop_lower_layer value missing\n");
		}

	} else {
		print("immodpg, setVbotNVtop_lower_layer_minus, missing widget or Vincrement\n");

		#		print("immodpg, setVtopNVtop_lower_layer_minus, Vtop_lower_layerEntry=$immodpg->{_Vtop_lower_layerEntry}\n");
		#		print("immodpg, setVtopNVtop_lower_layer_minus, Vincrement=$immodpg->{_Vincrement_current}\n");
	}
	return ();
}

=head2 setVbotNVtop_lower_layer_plus
update Vbot value in gui
update Vtop_lower_layer value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVbotNVtop_lower_layer_plus {

	my ($self) = @_;

	if (   looks_like_number( $immodpg->{_Vincrement_current} )
		&& length( $immodpg->{_Vtop_lower_layerEntry} )
		&& length( $immodpg->{_VbotEntry} ) ) {

		my $Vbot             = ( $immodpg->{_VbotEntry} )->get();
		my $Vtop_lower_layer = ( $immodpg->{_Vtop_lower_layerEntry} )->get();
		my $Vincrement       = ( $immodpg->{_VincrementEntry} )->get();

		if (   looks_like_number($Vtop_lower_layer)
			&& looks_like_number($Vbot) ) {

			my $new_Vtop_lower_layer = $Vtop_lower_layer - $Vincrement;
			my $new_Vbot             = $Vbot - $Vincrement;

			$immodpg->{_Vtop_lower_layer_prior}   = $immodpg->{_Vtop_lower_layer_current};
			$immodpg->{_Vtop_lower_layer_current} = $new_Vtop_lower_layer;

			$immodpg->{_Vbot_prior}   = $immodpg->{_Vbot_current};
			$immodpg->{_Vbot_current} = $new_Vbot;

			$immodpg->{_Vtop_lower_layerEntry}->delete( 0, 'end' );
			$immodpg->{_Vtop_lower_layerEntry}->insert( 0, $new_Vtop_lower_layer );

			$immodpg->{_VbotEntry}->delete( 0, 'end' );
			$immodpg->{_VbotEntry}->insert( 0, $new_Vbot );

			$immodpg->{_isVtop_lower_layer_changed} = $yes;
			$immodpg->{_isVbot_changed}             = $yes;

			#			print("immodpg, setVbotNVtop_lower_layer_plus, new Vtop_lower_layer= $new_Vtop_lower_layer\n");
			#			print("immodpg, setVbotNVtop_lower_layer_plus, Vincrement= $Vincrement\n");

			if (   $immodpg->{_isVtop_lower_layer_changed} eq $yes
				&& $immodpg->{_isVbot_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, setVbotNVtop_lower_layer_plus, Vbot is changed: $yes \n");

				_set_option($VbotNVtop_lower_layer_plus_opt);
				_set_change($yes);

				#				print("immodpg, setVbotNVtop_lower_layer_plus,option:$VbotNVtop_lower_layer_plus_opt\n");
				#				print("immodpg, setVbotNVtop_lower_layer_plus, V=$immodpg->{_Vtop_lower_layer_current}\n");

			} else {

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#				print("immodpg, setVbotNVtop_lower_layer_plus, same Vbot and Vtop_lower_layer; NADA\n");
			}

		} else {
			print("immodpg, setVbotNVtop_lower_layer_plus, Vbot or Vtop_lower_layer value missing\n");
		}

	} else {
		print("immodpg, setVbotNVtop_lower_layer_plus, missing widget or Vincrement\n");

		#		print("immodpg, setVtopNVtop_lower_layer_plus, Vtop_lower_layerEntry=$immodpg->{_Vtop_lower_layerEntry}\n");
		print("immodpg, setVtopNVtop_lower_layer_plus, Vincrement=$immodpg->{_Vincrement_current}\n");
	}
	return ();
}

=head2 sub setVtopNVbot_upper_layer_minus
update Vtop value in gui
update Vbot_upper_layer value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVtopNVbot_upper_layer_minus {

	my ($self) = @_;

	if (
		   looks_like_number( $immodpg->{_Vincrement_current} )
		&& length( $immodpg->{_Vbot_upper_layerEntry} )
		&& length( $immodpg->{_VtopEntry} )

	) {

		my $Vtop             = ( $immodpg->{_VtopEntry} )->get();
		my $Vbot_upper_layer = ( $immodpg->{_Vbot_upper_layerEntry} )->get();
		my $Vincrement       = ( $immodpg->{_VincrementEntry} )->get();
		my $layer_current    = $immodpg->{_layer_current};

		if ( looks_like_number($Vbot_upper_layer) && looks_like_number($Vtop)
			and $layer_current > 0 ) {

			my $new_Vbot_upper_layer = $Vbot_upper_layer - $Vincrement;
			my $new_Vtop             = $Vtop - $Vincrement;

			$immodpg->{_Vbot_upper_layer_prior}   = $immodpg->{_Vbot_upper_layer_current};
			$immodpg->{_Vbot_upper_layer_current} = $new_Vbot_upper_layer;

			$immodpg->{_Vtop_prior}   = $immodpg->{_Vtop_current};
			$immodpg->{_Vtop_current} = $new_Vtop;

			$immodpg->{_Vbot_upper_layerEntry}->delete( 0, 'end' );
			$immodpg->{_Vbot_upper_layerEntry}->insert( 0, $new_Vbot_upper_layer );

			$immodpg->{_VtopEntry}->delete( 0, 'end' );
			$immodpg->{_VtopEntry}->insert( 0, $new_Vtop );

			$immodpg->{_isVbot_upper_layer_changed} = $yes;
			$immodpg->{_isVtop_changed}             = $yes;

			#			print("immodpg, setVtopNVbot_upper_layer_minus, new Vbot_upper_layer= $new_Vbot_upper_layer\n");
			#			print("immodpg, setVtopNVbot_upper_layer_minus, Vincrement= $Vincrement\n");

			if (   $immodpg->{_isVbot_upper_layer_changed} eq $yes
				&& $immodpg->{_isVtop_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, setVtopNVbot_upper_layer_minus, Vbot is changed: $yes \n");

				_set_option($VtopNVbot_upper_layer_minus_opt);
				_set_change($yes);

				#				print("immodpg, setVtopNVbot_upper_layer_minus,option:$VtopNVbot_upper_layer_minus_opt\n");
				#				print("immodpg, setVtopNVbot_upper_layer_minus, V=$immodpg->{_Vbot_upper_layer_current}\n");

			} else {

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#				print("immodpg, setVtopNVbot_upper_layer_minus, same Vtop and Vbot_upper_layer; NADA\n");
			}

		} else {

			# print("immodpg, setVtopNVbot_upper_layer_minus, Vtop or Vbot_upper_layer value missing-NADA\n");
		}

	} else {
		print("immodpg, setVtopNVbot_upper_layer_minus, missing widget or Vincrement\n");

		#		print("immodpg, setVtopNVbot_upper_layer_minus, Vbot_upper_layerEntry=$immodpg->{_Vbot_upper_layerEntry}\n");
		#		print("immodpg, setVtopNVbot_upper_layer_minus, Vincrement=$immodpg->{_Vincrement_current}\n");
	}
	return ();
}

=head2 sub setVtopNVbot_upper_layer_plus

update Vtop value in gui
update Vbot_upper_layer value in gui
update private value in this module

output option for immodpg.for

=cut

sub setVtopNVbot_upper_layer_plus {

	my ($self) = @_;

	if (
		   looks_like_number( $immodpg->{_Vincrement_current} )
		&& length( $immodpg->{_Vbot_upper_layerEntry} )
		&& length( $immodpg->{_VtopEntry} )

	) {

		my $Vtop             = ( $immodpg->{_VtopEntry} )->get();
		my $Vbot_upper_layer = ( $immodpg->{_Vbot_upper_layerEntry} )->get();
		my $Vincrement       = ( $immodpg->{_VincrementEntry} )->get();
		my $layer_current    = $immodpg->{_layer_current};

		if ( looks_like_number($Vbot_upper_layer) && looks_like_number($Vtop)
			and $layer_current > 0 ) {

			my $new_Vbot_upper_layer = $Vbot_upper_layer + $Vincrement;
			my $new_Vtop             = $Vtop + $Vincrement;

			$immodpg->{_Vbot_upper_layer_prior}   = $immodpg->{_Vbot_upper_layer_current};
			$immodpg->{_Vbot_upper_layer_current} = $new_Vbot_upper_layer;

			$immodpg->{_Vtop_prior}   = $immodpg->{_Vtop_current};
			$immodpg->{_Vtop_current} = $new_Vtop;

			$immodpg->{_Vbot_upper_layerEntry}->delete( 0, 'end' );
			$immodpg->{_Vbot_upper_layerEntry}->insert( 0, $new_Vbot_upper_layer );

			$immodpg->{_VtopEntry}->delete( 0, 'end' );
			$immodpg->{_VtopEntry}->insert( 0, $new_Vtop );

			$immodpg->{_isVbot_upper_layer_changed} = $yes;
			$immodpg->{_isVtop_changed}             = $yes;

			#			print("immodpg, setVtopNVbot_upper_layer_plus, new Vbot_upper_layer= $new_Vbot_upper_layer\n");
			#			print("immodpg, setVtopNVbot_upper_layer_plus, Vincrement= $Vincrement\n");

			if (   $immodpg->{_isVbot_upper_layer_changed} eq $yes
				&& $immodpg->{_isVtop_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, setVtopNVbot_upper_layer_plus, Vbot is changed: $yes \n");

				_set_option($VtopNVbot_upper_layer_plus_opt);
				_set_change($yes);

				#				print("immodpg, setVtopNVbot_upper_layer_plus,option:$VtopNVbot_upper_layer_plus_opt\n");
				#				print("immodpg, setVtopNVbot_upper_layer_plus, V=$immodpg->{_Vbot_upper_layer_current}\n");

			} else {

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#				print("immodpg, setVtopNVbot_upper_layer_plus, same Vtop and Vbot_upper_layer; NADA\n");
			}

		} else {

			#			print("immodpg, setVtopNVbot_upper_layer_plus, Vtop or Vbot_upper_layer value missing NADA\n");
		}

	} else {
		print("immodpg, setVtopNVbot_upper_layer_plus, missing widget or Vincrement\n");

		#		print("immodpg, setVtopNVbot_upper_layer_plus, Vbot_upper_layerEntry=$immodpg->{_Vbot_upper_layerEntry}\n");
		#		print("immodpg, setVtopNVbot_upper_layer_plus, Vincrement=$immodpg->{_Vincrement}\n");
	}
	return ();
}

=head2 sub setVincrement

When you enter or leave
check what the current Vincrement value is
compared to former Vincrement values

=cut

sub setVincrement {

	my ($self) = @_;

	# print("immodpg,  setVincrement, self, $self\n");

	if ( looks_like_number( $immodpg->{_Vincrement} ) ) {

		_checkVincrement();
		_updateVincrement();
		_write_config();

		if ( $immodpg->{_isVincrement_changed} eq $yes ) {

			# for fortran program to read
			# print("immodpg, set_Vincrement, Vincrement is changed: $yes \n");

			_setVincrement( $immodpg->{_Vincrement_current} );
			_set_option($changeVincrement_opt);
			_set_change($yes);

			# print("immodpg, setVincrement,option:$changeVincrement_opt\n");
			# print("immodpg, setVincrement, $immodpg->{_Vincrement_current}\n");

		} else {

			#			negative cases are reset by fortran program
			#			and so eliminate need to read locked files
			#			while use of locked files helps most of the time
			#			creation and deletion of locked files in perl are not
			#			failsafe

			# print("immodpg, setVincrement, same Vincrement NADA\n");
		}

	} else {

	}

}

=head2 sub setVtop

When you enter or leave,
check what the current Vtop value is
compared to former Vtop values

Vtop value is updated in immodpg.for 
through a message in file= "Vtop"
(&_setVtop)

=cut

sub setVtop {

	my ($self) = @_;
	my $isVtop_changed = $immodpg->{_isVtop_changed};

	if ( length( $immodpg->{_VtopEntry} ) ) {

		$immodpg->{_Vtop_current} = ( $immodpg->{_VtopEntry} )->get();

		#		print("immodpg, setVtop, $immodpg->{_Vtop}\n");
		#      redefinition required ???
		$immodpg->{_isVtop_changed} = $isVtop_changed;

		_checkVtop();
		_updateVtop();

		if ( $immodpg->{_isVtop_changed} eq $yes ) {

			# for fortran program to read
			#			print("immodpg, set_Vtop, Vtop is changed: $yes \n");

			_setVtop( $immodpg->{_Vtop_current} );
			_set_option($changeVtop_opt);
			_set_change($yes);

			#			print("immodpg, setVtop,option:$changeVtop_opt\n");
			#			print("immodpg, setVtop, V=$immodpg->{_Vtop_current}\n");

		} else {

			#			negative cases are reset by fortran program
			#			and so eliminate need to read locked files
			#			while use of locked files helps most of the time
			#			creation and deletion of locked files in perl are not
			#			failsafe

			#					print("immodpg, setVtop, same Vtop NADA\n");
		}

	} else {
		print("immodpg, setVtop, _Vtop value missing\n");
		print("immodpg, setVtop, Vtop=$immodpg->{_Vtop}\n");
	}
}

=head2 sub setVtop_lower_layer

When you enter or leave
check what the current Vtop_lower_layer value is
compared to former Vtop_lower_layer values
Vtop value is updated in immodpg.for 
through a message in file= "Vtop_lower_layer"
(&_setVtop_lower_layer)

=cut

sub setVtop_lower_layer {

	my ($self) = @_;
	my $isVtop_lower_layer_changed = $immodpg->{_isVtop_lower_layer_changed};

	if ( length( $immodpg->{_Vtop_lower_layerEntry} ) ) {

		$immodpg->{_Vtop_lower_layer} = ( $immodpg->{_Vtop_lower_layerEntry} )->get();

		# unexpectedly during "get" (above) the following value is made blank
		# redefinition required ??
		$immodpg->{_isVtop_lower_layer_changed} = $isVtop_lower_layer_changed;

		_checkVtop_lower_layer();
		_updateVtop_lower_layer();

		# print("0 after update  immodpg, set_Vtop_lower_layer, isVtop_lower_layer is changed= $immodpg->{_isVtop_lower_layer_changed}\n");

		if ( $immodpg->{_isVtop_lower_layer_changed} eq $yes ) {

			# for fortran program to read

			_setVtop_lower_layer( $immodpg->{_Vtop_lower_layer_current} );
			_set_option($Vtop_lower_layer_opt);
			_set_change($yes);

			#	print("immodpg, setVtop_lower_layer,option:$Vtop_lower_layer_opt\n");

		} else {

			#			negative cases are reset by fortran program
			#			and so eliminate need to read locked files
			#			while use of locked files helps most of the time
			#			creation and deletion of locked files in perl are not
			#			failsafe

			#			print("immodpg, setVtop_lower_layer, same Vtop_lower_layer NADA\n");
		}

	} else {
		("immodpg, setVtop_lower_layer, missing widget\n");
	}
}

=head2 sub setVbotNtop_factor

When you enter or leave
check what the current VbotNtop_factor value is
compared to former VbotNtop_factor values

=cut

sub setVbotNtop_factor {

	my ($self) = @_;

	# print("immodpg, _setVbotNtop_factor, self, $self\n");
	#	print("immodpg, setVbotNtop_factor, $immodpg->{_VbotNtop_factor_current}\n");
	if ( length( $immodpg->{_VbotNtop_factorEntry} )
		&& looks_like_number( $immodpg->{_VbotNtop_factor_current} ) ) {

		_checkVbotNtop_factor();
		_updateVbotNtop_factor();
		_write_config();

		if ( $immodpg->{_isVbotNtop_factor_changed} eq $yes ) {

			# print("immodpg, setVbotNtop_factor,  VbotNtop_factor is changed: $yes \n");

			_setVbotNtop_factor( $immodpg->{_VbotNtop_factor_current} );
			_set_option($changeVbotNtop_factor_opt);
			_set_change($yes);

			# print("immodpg, setVbotNtop_factor,option:$changeVbotNtop_factor_opt\n");

		} else {
			_set_change($no);

			# print("immodpg, setVbotNtop_factor, same VbotNtop_factor_opt NADA\n");
		}

	} else {
		print("immodpg, setVbotNtop_factor, bad factor or widget\n");

		# correct for bad typing
		_set_VbotNtop_factor_control();
		_get_control_VbotNtop_factor();
	}
}

=head2 sub _set_VbotNtop_factor_control
value adjusts to current
clip value in use

=cut

sub _set_VbotNtop_factor_control {

	my ( $self, $VbotNtop_factor ) = @_;

	my $result;

	if ( length($VbotNtop_factor)
		&& ( not( looks_like_number($VbotNtop_factor) ) ) ) {

	} else {
		print("immodpg,_set_VbotNtop_factor_control, unexpectedvalue\n");
	}

	return ();
}

=head2 sub setVbotNtop_multiply
Multiply Vbot and Vtop with factor

_updateVbotNtop_multiply
gui values for widgets
VbotEntry and VtopEntry 
	
output option for immodpg.for

=cut

sub setVbotNtop_multiply {

	my ($self) = @_;

	# print("immodpg, _setVbotNtop_multiply, self, $self\n");
	#	print(
	#		"immodpg, setVbotNtop_multiply, \n
	#	_VbotNtop_factor_current=$immodpg->{_VbotNtop_factor_current}\n"
	#	);

	if (   looks_like_number( $immodpg->{_VbotNtop_factor_current} )
		&& length( $immodpg->{_VbotEntry}->get() )
		&& length( $immodpg->{_VtopEntry}->get() ) ) {

		my $factor          = $immodpg->{_VbotNtop_factor_current};
		my $Vbot            = ( $immodpg->{_VbotEntry} )->get();
		my $Vtop            = ( $immodpg->{_VtopEntry} )->get();
		my $Vbot_multiplied = $Vbot * $factor;
		my $Vtop_multiplied = $Vtop * $factor;
		$immodpg->{_Vtop_multiplied} = $Vtop_multiplied;
		$immodpg->{_Vbot_multiplied} = $Vtop_multiplied;

		# print("immodpg, setVbotNtop_multiply, Vbot=$Vbot_multiplied=, Vtop= $Vtop_multiplied\n");

		_updateVbotNtop_multiply();
		_set_option($VbotNtop_multiply_opt);
		_set_change($yes);

	} else {
		print("immodpg, setVbotNtop_multiply, missing value\n");
	}

	return ();

}

=head2 get_model

 PERL PACKAGE NAME: _get_model
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 21 2020

 DESCRIPTION:  
    
   read Fortran 77 unformatted binary model file
   from mmodpg using PDL

=cut

=head2 USE

=over

=item

Number of layers is passed as a variable

=item


=back
	
=cut

=head2 NOTES

	
=cut	

=head4 Examples

=cut

=head2 CHANGES and their DATES


=cut 

sub get_model {

	my ($self) = @_;

	use Project_config;
	use PDL::Core;
	use PDL::IO::FlexRaw;
	use immodpg_global_constants;

	my $Project = Project_config->new();
	my $IMMODPG = $Project->IMMODPG();
	my $var     = ( immodpg_global_constants->new() )->var;

	my @VPtop;
	my @VPbot;
	my @VP;

	my $inbound = $IMMODPG . '/' . $var->{_immodpg_model};
	my $cols    = 9;                                         #default
	my $km2m    = 1000;

	print("immodpg, get_model,model_layer_number =$immodpg->{_model_layer_number}\n");
	my $number_of_layers = _get_number_of_layers;

	if (   $immodpg->{_model_layer_number} > 0
		&& $immodpg->{_model_layer_number} < $number_of_layers ) {

		my $magic_number_str = '0:1';

		my $header = [
			{ Type => 'f77' },
			{
				Type  => 'float',
				NDims => 2,
				Dims  => [ $cols, $number_of_layers ]
			}
		];

		my $model_pdl = readflex( $inbound, $header );

		print("$model_pdl\n");

		my $nelem = nelem($model_pdl);

		print("nelem=$nelem,#cols=$cols,#layers=$number_of_layers\n");

		for ( my $layer_index = 0; $layer_index < $number_of_layers; $layer_index++ ) {
			my $value_indices = $magic_number_str;
			my $full_indices  = $value_indices . ',' . $layer_index;

			# pdl 2 perl
			@VP                  = ( $model_pdl->slice($full_indices) )->list;
			$VPtop[$layer_index] = sprintf( "%.3f", ( $VP[0] * $km2m ) );
			$VPbot[$layer_index] = sprintf( "%.3f", ( $VP[1] * $km2m ) );

			#	print("VPtop = $VPtop[$layer_index], VPbot=$VPbot[$layer_index],layer_index=$layer_index\n");
		}

		return ( \@VPtop, \@VPbot );

	} else {
		print("immodpg,get_model,number of layers exceeds default\n");
		return ();
	}

}

=head2 sub invert 


=cut

sub invert {

	my ( $self, $invert ) = @_;
	if ( $invert ne $empty_string ) {

		$immodpg->{_invert} = $invert;
		$immodpg->{_note}   = $immodpg->{_note} . ' invert=' . $immodpg->{_invert};
		$immodpg->{_Step}   = $immodpg->{_Step} . ' invert=' . $immodpg->{_invert};

	} else {
		print("immodpg, invert, missing invert,\n");
	}
}

=head2 sub lmute 


=cut

sub lmute {

	my ( $self, $lmute ) = @_;
	if ($lmute) {

		$immodpg->{_lmute} = $lmute;
		$immodpg->{_note}  = $immodpg->{_note} . ' lmute=' . $immodpg->{_lmute};
		$immodpg->{_Step}  = $immodpg->{_Step} . ' lmute=' . $immodpg->{_lmute};

	} else {
		print("immodpg, lmute, missing lmute,\n");
	}
}

=head2 sub premmod 

prepare su file as a binary file for (i)mmodpg
This program read a SU file, and creates the file: 
datammod
which is a binary fortran file containing the SU file with 
no headers, and that
can be read by program mmodpg.  It also create the ascii 
file: parmmod  
containing
basic parameters of the SU file (ntr,ns,dt) also used by mmodpg.

=cut

sub premmod {
	my ($self) = @_;

	#	_set_inbound;
	#	my $inbound = _get_inbound();
	my $inbound;

	if ( $inbound ne $empty_string ) {

	} else {
		print("immodpg,premmod, unexpected result\n");
	}

}

=head2 sub set_clip

When you enter or leave
check what the current clip value is
compared to former clip values

=cut

sub set_clip {

	my ($self) = @_;

	if ( length( $immodpg->{_clip4plotEntry} )
		&& looks_like_number( $immodpg->{_clip4plot_current} ) ) {

		#		print("immodpg, set_clip, $immodpg->{_clip4plotEntry}\n");
		_check_clip();
		_update_clip();
		_write_config();

		if ( $immodpg->{_is_clip_changed} eq $yes ) {

			#			print("immodpg, set_clip, clip is changed: $yes \n");
			_set_clip( $immodpg->{_clip4plot_current} );
			_set_option($change_clip_opt);
			_set_change($yes);

			#			print("immodpg, set_clip,option:$change_clip_opt\n");
			#			print("immodpg, set_clip,immodpg->{_clip4plot_current}=$immodpg->{_clip4plot_current}\n");

		} else {
			_set_change($no);

			# print("immodpg, set_clip, same clip NADA\n");
		}

	} else {

	}
}

=head2 sub set_layer
When you enter or leave
check what the current layer value is
compared to former layer values

=cut

sub set_layer {
	my ($self) = @_;

	#  print("1. immodpg, set_layer\n");
	#	print("immodpg, set_layer, $immodpg->{_layerEntry}\n");

	if (   length( $immodpg->{_layerEntry} )
		&& looks_like_number( $immodpg->{_layer_current} )
		&& $immodpg->{_VbotEntry} ne $empty_string
		&& $immodpg->{_VtopEntry} ne $empty_string
		&& $immodpg->{_Vbot_upper_layerEntry} ne $empty_string
		&& $immodpg->{_Vtop_lower_layerEntry} ne $empty_string 
		&& length($immodpg->{_thickness_mEntry})
		&& looks_like_number( $immodpg->{_thickness_m_current} )
		) {

		# print("2. immodpg, layer, $immodpg->{_layerEntry}\n");
		_check_layer();
		_update_layer();
		_update_upper_layer();
		_update_lower_layer();
		_check_thickness_m();
		_update_thickness_m();
		_write_config();

		if ( $immodpg->{_is_layer_changed} eq $yes ) {

=head3 Get model values from
immodpg.out for initial settings
in GUI
also change associated velocity values
and thickness values of the new layer

=cut

			_set_model_layer( $immodpg->{_layer_current} );
			my ( $Vp_ref, $dz ) = _getVp_dz_initial();
			my @V = @$Vp_ref;
			my $thickness_m = $dz;
#			print("immodpg,set_layer,thickness=$thickness_m \n");

			my $Vbot_upper_layer = $V[0];
			my $Vtop             = $V[1];
			my $Vbot             = $V[2];
			my $Vtop_lower_layer = $V[3];

			# print("immodpg, set_layer, Vbot=$Vbot\n");
			$immodpg->{_thickness_mEntry}->delete( 0, 'end' );
			$immodpg->{_thickness_mEntry}->insert( 0, $thickness_m);
			
			# print("immodpg, set_layer, Vbot=$Vbot\n");
			$immodpg->{_VbotEntry}->delete( 0, 'end' );
			$immodpg->{_VbotEntry}->insert( 0, $Vbot );

			# print("immodpg, set_layer, Vtop=$Vtop\n");
			$immodpg->{_VtopEntry}->delete( 0, 'end' );
			$immodpg->{_VtopEntry}->insert( 0, $Vtop );

			# print("immodpg, set_layer, Vbot_upper_layer=$Vbot_upper_layer\n");
			$immodpg->{_Vbot_upper_layerEntry}->delete( 0, 'end' );
			$immodpg->{_Vbot_upper_layerEntry}->insert( 0, $Vbot_upper_layer );

			# print("immodpg, set_layer, Vtop_lower_layer=$Vtop_lower_layer\n");
			$immodpg->{_Vtop_lower_layerEntry}->delete( 0, 'end' );
			$immodpg->{_Vtop_lower_layerEntry}->insert( 0, $Vtop_lower_layer );

			# update stored values
			$immodpg->{_Vtop_prior}               = $immodpg->{_Vtop_current};
			$immodpg->{_Vtop_current}             = $Vtop;
			$immodpg->{_Vbot_prior}               = $immodpg->{_Vbot_current};
			$immodpg->{_Vbot_current}             = $Vbot;
			$immodpg->{_Vbot_upper_layer_prior}   = $immodpg->{_Vbot_upper_layer_current};
			$immodpg->{_Vbot_upper_layer_current} = $Vbot_upper_layer;
			$immodpg->{_Vtop_lower_layer_prior}   = $immodpg->{_Vtop_lower_layer_current};
			$immodpg->{_Vtop_lower_layer_current} = $Vtop_lower_layer;
			$immodpg->{_thickness_m_prior}   = $immodpg->{_thickness_m_current};
			$immodpg->{_thickness_m_current} = $thickness_m;			

			# affects immodpg.for
			# print("3. immodpg, set_layer, layer is changed: $yes \n");
			_fortran_layer( $immodpg->{_layer_current} );
			_set_option($change_layer_number_opt);
			_set_change($yes);

			# print("immodpg, set_layer,option:$change_layer_number_opt\n");

		} else {
			_set_change($no);

			#	print("immodpg, layer, same layer NADA\n");
		}

	} else {

	}
}

=head2 sub set_layer_control
Value adjusts to current
layer number in use

=cut

sub set_layer_control {

	my ( $self, $control_layer_external ) = @_;

	my $result;

	if ( length($control_layer_external) ) {

		$immodpg->{_control_layer_external} = $control_layer_external;

		#		print("immodpg,set_layer_control,control_layer_external = $control_layer_external \n");

	} elsif ( not( length($control_layer_external) ) ) {

		#		print("immodpg,set_layer_control, empty string\n");
		$immodpg->{_control_layer_external} = $control_layer_external;

	} else {
		print("immodpg,set_layer_control, missing value\n");
	}

	return ();
}

=head2 set_model_layer
Set the number of layers in
mmodpg

=cut

sub set_model_layer {

	my ( $self, $model_layer_number ) = @_;

	if ( $model_layer_number != 0
		&& length($model_layer_number) ) {

		$immodpg->{_model_layer_number} = $model_layer_number;

	} else {
		print("immodpg, set_model_layer, unexpected layer# \n");
	}

	#	print("immodpg, set_model_layer,modellayer# =$immodpg->{_model_layer_number}\n");

	return ();
}

=head2 sub set_thickness_m_minus

update _thickness_m value in gui
update private value in this module

output option for immodpg.for

=cut

sub set_thickness_m_minus {

	my ($self) = @_;

	if ( length( $immodpg->{_thickness_mEntry} )
		&& looks_like_number( $immodpg->{_thickness_increment_m} ) ) {

		my $thickness_m = ( $immodpg->{_thickness_mEntry} )->get();

		if ( looks_like_number($thickness_m) ) {

			my $thickness_increment_m = ( $immodpg->{_thickness_increment_mEntry} )->get();
			my $new_thickness_m       = $thickness_m - $thickness_increment_m;

			$immodpg->{_thickness_m_prior}   = $immodpg->{_thickness_m_current};
			$immodpg->{_thickness_m_current} = $new_thickness_m;

			$immodpg->{_thickness_mEntry}->delete( 0, 'end' );
			$immodpg->{_thickness_mEntry}->insert( 0, $new_thickness_m );

			$immodpg->{_is_thickness_m_changed} = $yes;

			#			print("immodpg, set new _thickness_m= $new_thickness_m\n");
			#			print("immodpg, set_thickness_m_minus, thickness_increment_m= $thickness_increment_m\n");

			if ( $immodpg->{_is_thickness_m_changed} eq $yes ) {

				# for fortran program to read
				#								print("immodpg, set_thickness_m_minus, _thickness_m is changed: $yes \n");

				_set_option($thickness_m_minus_opt);
				_set_change($yes);

				#								print("immodpg, set_thickness_m_minus,option:$thickness_m_minus_opt\n");
				#								print("immodpg, set_thickness_m_minus, V=$immodpg->{_thickness_m_current}\n");

			} else {

				#				print("immodpg, set_thickness_m_minus, _thickness_mEntry=$immodpg->{_thickness_mEntry}\n");
				#				print("immodpg, set_thickness_m_minus, thickness_increment_m=$immodpg->{_thickness_increment_m}\n");

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#	print("immodpg, set_thickness_m_minus, same _thickness_m NADA\n");
			}

		} else {
			print("immodpg, set_thickness_m_minus, _thickness_m value missing\n");

			#			print("immodpg, set_thickness_m_minus, _thickness_mEntry=$immodpg->{_thickness_mEntry}\n");
			#			print("immodpg, set_thickness_m_minus, thickness_increment_m=$immodpg->{_thickness_increment_m}\n");
		}

	} else {
		print("immodpg, set_thickness_m_minus, missing widget or thickness_increment_m\n");
	}
	return ();
}

=head2 sub set_thickness_m_plus

update _thickness_m value in gui
update private value in this module

output option for immodpg.for

=cut

sub set_thickness_m_plus {

	my ($self) = @_;

	if ( length( $immodpg->{_thickness_mEntry} )
		&& looks_like_number( $immodpg->{_thickness_increment_m} ) ) {

		my $thickness_m = ( $immodpg->{_thickness_mEntry} )->get();

		if ( looks_like_number($thickness_m) ) {

			my $thickness_increment_m = ( $immodpg->{_thickness_increment_mEntry} )->get();
			my $new_thickness_m       = $thickness_m + $thickness_increment_m;

			$immodpg->{_thickness_m_prior}   = $immodpg->{_thickness_m_current};
			$immodpg->{_thickness_m_current} = $new_thickness_m;

			$immodpg->{_thickness_mEntry}->delete( 0, 'end' );
			$immodpg->{_thickness_mEntry}->insert( 0, $new_thickness_m );

			$immodpg->{_is_thickness_m_changed} = $yes;

			#			print("immodpg, set new _thickness_m= $new_thickness_m\n");
			#			print("immodpg, set_thickness_m_plus, thickness_increment_m= $thickness_increment_m\n");

			if ( $immodpg->{_is_thickness_m_changed} eq $yes ) {

				# for fortran program to read
				#				print("immodpg, set_thickness_m_plus, _thickness_m is changed: $yes \n");

				_set_option($thickness_m_plus_opt);
				_set_change($yes);

				#				print("immodpg, set_thickness_m_plus,option:$_thickness_m_plus_opt\n");
				#				print("immodpg, set_thickness_m_plus, V=$immodpg->{_thickness_m_current}\n");

			} else {

				#				print("immodpg, set_thickness_m_plus, _thickness_mEntry=$immodpg->{_thickness_mEntry}\n");
				#				print("immodpg, set_thickness_m_plus, thickness_increment_m=$immodpg->{_thickness_increment_m}\n");

				#	negative cases are reset by fortran program
				#	and so eliminate need to read locked files
				#	while use of locked files helps most of the time
				#	creation and deletion of locked files in perl are not
				#	failsafe
				#
				#	print("immodpg, set_thickness_m_plus, same _thickness_m NADA\n");
			}

		} else {
			print("immodpg, set_thickness_m_plus, _thickness_m value missing\n");

			#			print("immodpg, set_thickness_m_plus, _thickness_mEntry=$immodpg->{_thickness_mEntry}\n");
			#			print("immodpg, set_thickness_m_plus, thickness_increment_m=$immodpg->{_thickness_increment_m}\n");
		}

	} else {
		print("immodpg, set_thickness_m_plus, missing widget or thickness_increment_m\n");
	}
	return ();
}

=head2 sub set_update
Save all values in the immodpg
gui to immodpg.config

=cut

sub set_update {
	my ($self) = @_;

	#	print("immodpg, set_update\n");

	setVincrement();
	set_thickness_increment_m();
	set_thickness_m();
	setVbotNtop_factor();
	set_clip();

	setVbot();
	setVtop();
	setVbot_upper_layer();
	setVtop_lower_layer();
	set_layer();

}

sub set_widgets {

	my ( $self, $widget_h ) = @_;

	if ($widget_h) {

		# print("immodpg, set_widgets, immodpg->{_clip4plotEntry}: $immodpg->{_clip4plotEntry}\n");

		$immodpg->{_VbotEntry}                  = $widget_h->{_VbotEntry};
		$immodpg->{_Vbot_upper_layerEntry}      = $widget_h->{_Vbot_upper_layerEntry};
		$immodpg->{_VincrementEntry}            = $widget_h->{_VincrementEntry};
		$immodpg->{_VtopEntry}                  = $widget_h->{_VtopEntry};
		$immodpg->{_Vtop_lower_layerEntry}      = $widget_h->{_Vtop_lower_layerEntry};
		$immodpg->{_VbotNtop_factorEntry}       = $widget_h->{_VbotNtop_factorEntry};
		$immodpg->{_clip4plotEntry}             = $widget_h->{_clip4plotEntry};
		$immodpg->{_layerEntry}                 = $widget_h->{_layerEntry};
		$immodpg->{_thickness_mEntry}           = $widget_h->{_thickness_mEntry};
		$immodpg->{_thickness_increment_mEntry} = $widget_h->{_thickness_increment_mEntry};
		$immodpg->{_upper_layerLabel}           = $widget_h->{_upper_layerLabel};
		$immodpg->{_lower_layerLabel}           = $widget_h->{_lower_layerLabel};

		#		print("immodpg, set_widgets, immodpg->{_Vtop_lower_layerEntry}: $immodpg->{_Vtop_lower_layerEntry}\n");

		#		print("immodpg, set_widgets, immodpg->{_VtopEntry}: $immodpg->{_VtopEntry}\n");
		# print("immodpg, set_widgets, OK\n");
		return ();

	} else {
		print("immodpg, set_widgets, unexpected\n");
	}

}

=head2 sub set_base_file_name

=cut

sub set_base_file_name {

	my ( $self, $base_file_name ) = @_;

	if ( $base_file_name ne $empty_string ) {

		$immodpg->{_base_file_name} = $base_file_name;

		print("header_values,set_base_file_name,$immodpg->{_base_file_name}\n");

	} else {
		print("header_values,set_base_file_name, missing base file name\n");
	}

	return ();

}

=head2 sub set_change 
verify another lock file does not exist and
only then:

create another lock file
while change file is written.
that revents fortran file from reading
Then delete lock file
Aavoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub set_change {

	my ( $self, $yes_or_no ) = @_;

	# print("immodpg, set_change, yes_or_no:$yes_or_no\n");

	if ( defined($yes_or_no)
		&& $immodpg->{_change_file} ne $empty_string ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $change = $immodpg->{_change_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $change;
		my $outbound_locked = $outbound . '_locked';
		my $format          = $var_immodpg->{_format_string};

		for ( my $i = 0; $test eq $no; $i++ ) {

			# print("in loop \n");

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {

				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				# print("immodpg, set_change, outbound_locked=$outbound_locked\n");
				# print("immodpg, set_change, IMMODPG_INVISIBLE=$IMMODPG_INVISIBLE\n");
				# print("immodpg, set_change, created empty locked file=$X[0]\n");
				$X[0] = $yes_or_no;

				# print("immodpg, set_change, outbound=$outbound\n");
				# print("immodpg, set_change, IMMODPG_INVISIBLE=$IMMODPG_INVISIBLE\n");
				$files->write_1col_aref( \@X, \$outbound, \$format );

				# print("immodpg, set_change, yes_or_no=$X[0]\n");
				# print("1. immodpg, set_change, delete locked file\n");
				unlink($outbound_locked);

				# print("2. immodpg, set_change, delete locked file\n");
				$test = $yes;

			}    # if
		}    # for

	} else {
		print("immodpg, set_change, unexpected answer\n");
	}

	return ();
}    # sub

=head2 sub set_clip_control
value adjusts to current
clip value in use

=cut

sub set_clip_control {

	my ( $self, $control_clip ) = @_;

	my $result;

	if ( length($control_clip)
		&& $control_clip > 0 ) {

		$immodpg->{_control_clip} = $control_clip;

		#		print("immodpg,set_clip_control, control_clip=$immodpg->{_control_clip}\n");

	} elsif ( not( length($control_clip) ) ) {

		# print("immodpg,_set_clip_control, empty string\n");
		$immodpg->{_control_clip} = $control_clip;

	} else {
		print("immodpg,set_clip_control, missing value\n");
	}

	return ();
}

=head2 sub set_option
Verify another lock file does not exist and
only then:

Create another lock file
while change file is written
that prevents fortran file from reading.
Then, delete the lock file
Avoids crash between asynchronous 
reading (fortran) and
writing (Perl) of files

=cut

sub set_option {

	my ( $self, $option ) = @_;

	if ( looks_like_number($option)
		&& $immodpg->{_option_file} ne $empty_string ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 Define local
variables

=cut		

		my @X;
		my $option_file = $immodpg->{_option_file};

		my $test            = $no;
		my $outbound        = $IMMODPG_INVISIBLE . '/' . $option_file;
		my $outbound_locked = $outbound . '_locked';

		for ( my $i = 0; $test eq $no; $i++ ) {

			if ( not( $files->does_file_exist( \$outbound_locked ) ) ) {
				my $format = $var_immodpg->{_format_string};
				$X[0] = $empty_string;
				$files->write_1col_aref( \@X, \$outbound_locked, \$format );

				$X[0] = $option;
				$format = '%i';

				#				print("immodpg,set_option,option=$option\n");
				$files->write_1col_aref( \@X, \$outbound, \$format );

				unlink($outbound_locked);

				$test = $yes;
			}    # if
		}    # for

	} elsif ( $immodpg->{_is_option_changed} eq $no ) {

		# NADA

	} else {
		print("immodpg, set_option, unexpected answer\n");
	}

	return ();
}

=head2 sub smute 


=cut

sub smute {

	my ( $self, $smute ) = @_;
	if ($smute) {

		$immodpg->{_smute} = $smute;
		$immodpg->{_note}  = $immodpg->{_note} . ' smute=' . $immodpg->{_smute};
		$immodpg->{_Step}  = $immodpg->{_Step} . ' smute=' . $immodpg->{_smute};

	} else {
		print("immodpg, smute, missing smute,\n");
	}
}

=head2 sub sscale 


=cut

sub sscale {

	my ( $self, $sscale ) = @_;
	if ($sscale) {

		$immodpg->{_sscale} = $sscale;
		$immodpg->{_note}   = $immodpg->{_note} . ' sscale=' . $immodpg->{_sscale};
		$immodpg->{_Step}   = $immodpg->{_Step} . ' sscale=' . $immodpg->{_sscale};

	} else {
		print("immodpg, sscale, missing sscale,\n");
	}
}

=head2 sub set_thickness_m

When you enter or leave,
check what the current thickness_m value is
compared to former thickness_m values

thickness_m value is updated in immodpg.for 
through a message in file= "thickness_m"
(&_set_thickness_m)

=cut

sub set_thickness_m {

	my ($self) = @_;

	#	print("immodpg, set_thickness_m,immodpg->{_thickness_m_current} =$immodpg->{_thickness_m_current} \n");
	#	print("immodpg, set_thickness_m,immodpg->{_thickness_m_current} =$immodpg->{_thickness_m_current} \n");
	#	print("immodpg, set_thickness_m,immodpg->{_thickness_m_current} =$immodpg->{_thickness_m_current} \n");

	if ( looks_like_number( $immodpg->{_thickness_m_current} ) ) {

		_check_thickness_m();
		_update_thickness_m();

		if ( $immodpg->{_is_thickness_m_changed} eq $yes ) {

			# for fortran program to read
			# print("immodpg, set_thickness_m, thickness_m is changed: $yes \n");

			_set_thickness_m( $immodpg->{_thickness_m_current} );
			_set_option($change_thickness_m_opt);
			_set_change($yes);

			# print("immodpg, set_thickness_m,option:$change_thickness_m_opt\n");
			# print("immodpg, set_thickness_m, V=$immodpg->{_thickness_m_current}\n");

		} else {

			#			negative cases are reset by fortran program
			#			and so eliminate need to read locked files
			#			while use of locked files helps most of the time
			#			creation and deletion of locked files in perl are not
			#			failsafe

			# print("immodpg, set_thickness_m, same thickness_m NADA\n");
		}

	} else {
		print("immodpg, set_thickness_m, _thickness_m value missing\n");
		print("immodpg, set_thickness_m, thickness_m=$immodpg->{_thickness_m}\n");
	}
}

=head2 sub set_thickness_increment_m
When you enter or leave
check what the current thickness_increment_m value is
compared to former thickness_increment_m values

thickness_increment_m value is updated in immodpg.for 
through a message in file= "thickness_increment_m"
(&_set_thickness_increment_m)

=cut

sub set_thickness_increment_m {

	my ($self) = @_;

	# print("immodpg, set_thickness_increment_m, self, $self\n");

	if ( defined $immodpg->{_thickness_increment_mEntry}
		&& $immodpg->{_thickness_increment_mEntry} ne $empty_string ) {

		# print("immodpg, set_thickness_increment_m, $immodpg->{_thickness_increment_mEntry}\n");
		_check_thickness_increment_m();
		_update_thickness_increment_m();
		_write_config();

		if ( $immodpg->{_is_thickness_increment_m_changed} eq $yes ) {

			print("immodpg, set_thickness_increment_m, thickness_increment_m is changed: $yes \n");
			_set_thickness_increment_m( $immodpg->{_thickness_increment_m_current} );
			_set_option($change_thickness_increment_m_opt);
			_set_change($yes);

			print("immodpg, set_thickness_increment_m,option:$change_thickness_increment_m_opt\n");
			print(
				"immodpg, set_thickness_increment_m,immodpg->{_thickness_increment_m_current}=$immodpg->{_thickness_increment_m_current}\n"
			);

		} else {
			_set_change($no);

			# print("immodpg, set_thickness_increment_m, same thickness_increment_m NADA\n");
		}

	} else {

	}
}

=head2 sub tnmo 


=cut

sub tnmo {

	my ( $self, $tnmo ) = @_;
	if ( $tnmo ne $empty_string ) {

		$immodpg->{_tnmo} = $tnmo;
		$immodpg->{_note} = $immodpg->{_note} . ' tnmo=' . $immodpg->{_tnmo};
		$immodpg->{_Step} = $immodpg->{_Step} . ' tnmo=' . $immodpg->{_tnmo};

	} else {
		print("immodpg, tnmo, missing tnmo,\n");
	}
}

=head2 sub upward 


=cut

sub upward {

	my ( $self, $upward ) = @_;
	if ( $upward ne $empty_string ) {

		$immodpg->{_upward} = $upward;
		$immodpg->{_note}   = $immodpg->{_note} . ' upward=' . $immodpg->{_upward};
		$immodpg->{_Step}   = $immodpg->{_Step} . ' upward=' . $immodpg->{_upward};

	} else {
		print("immodpg, upward, missing upward,\n");
	}
}

=head2 sub vnmo 


=cut

sub vnmo {

	my ( $self, $vnmo ) = @_;
	if ($vnmo) {

		$immodpg->{_vnmo} = $vnmo;
		$immodpg->{_note} = $immodpg->{_note} . ' vnmo=' . $immodpg->{_vnmo};
		$immodpg->{_Step} = $immodpg->{_Step} . ' vnmo=' . $immodpg->{_vnmo};

	} else {
		print("immodpg, vnmo, missing vnmo,\n");
	}
}

=head2 sub vnmo_mps 


=cut

sub vnmo_mps {

	my ( $self, $vnmo ) = @_;
	if ($vnmo) {

		$immodpg->{_vnmo} = $vnmo;
		$immodpg->{_note} = $immodpg->{_note} . ' vnmo=' . $immodpg->{_vnmo};
		$immodpg->{_Step} = $immodpg->{_Step} . ' vnmo=' . $immodpg->{_vnmo};

	} else {
		print("immodpg, vnmo, missing vnmo,\n");
	}
}

=head2 sub voutfile 


=cut

sub voutfile {

	my ( $self, $voutfile ) = @_;
	if ($voutfile) {

		$immodpg->{_voutfile} = $voutfile;
		$immodpg->{_note}     = $immodpg->{_note} . ' voutfile=' . $immodpg->{_voutfile};
		$immodpg->{_Step}     = $immodpg->{_Step} . ' voutfile=' . $immodpg->{_voutfile};

	} else {
		print("immodpg, voutfile, missing voutfile,\n");
	}
}

1;
