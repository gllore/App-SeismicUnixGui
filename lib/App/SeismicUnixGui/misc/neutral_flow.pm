package App::SeismicUnixGui::misc::neutral_flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: neutral_flow.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 

 DESCRIPTION 
     
     Is used only to inspect labels/names of different available
     sunix programs 
     'neutral' refers to that no colored box is available to build a flow
     from these selections

 BASED ON:
 previous versions of the main userBuiltFlow.pl
  

=cut

=head2 USE

=head3 NOTES

   Provides in-house macros/superflows
   1. Find widget you have selected

 
     . Disable the following widgets:
       delete_from_flow_button
      (sunix) flow_listbox
    
    sunix_listbox   		-choice of listed sunix modules in a listbox
    

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl
 
 V 0.0.2 Aug 12 2018 
 include multi-"colored" flows
 
 V 0.0.3 Oct. 11 2019
 refactored

=cut 

=head2 Notes from bash
 
=cut 

use Moose;
our $VERSION = '0.0.3';

my $path;
my $SeismicUnixGui;
use Shell qw(echo);

BEGIN {

$SeismicUnixGui = ` echo \$SeismicUnixGui`;
chomp $SeismicUnixGui;
$path = $SeismicUnixGui.'/'.'misc';

}
use lib "$path";
extends 'gui_history' => { -version => 0.0.2 };

use App::SeismicUnixGui::misc::param_widgets_neutral '0.0.2';
use App::SeismicUnixGui::misc::param_flow_neutral '0.0.3';
use App::SeismicUnixGui::misc::flow_widgets;

my $flow_widgets = flow_widgets->new();
my $get          = L_SU_global_constants->new();
my $gui_history  = gui_history->new();
my $param_flow   = param_flow_neutral->new();

# print("user_built flow, make param_flow instance in user_built flow\n");
my $param_widgets   = param_widgets_neutral->new();
my $flow_type       = $get->flow_type_href();
my $color_flow_href = $gui_history->get_defaults();

=head2

 share the following parameters in same name 
 space

=cut

my ($flow_color);
my ($flowNsuperflow_name_w);

# my $last_flow_color;
my $message_w;
my $sunix_listbox;
my $var = $get->var();

#	my $on         						= $var->{_on};
my $true  = $var->{_true};
my $false = $var->{_false};

=head2 sub get_hash_ref 
Exports private hash 
 
=cut

sub get_hash_ref {
	my ($self) = @_;

	# print("neutral_flow, get_hash_ref \n");
	return ($color_flow_href);

}

=head2 sub get_flow_color 
Exports private hash value
 
=cut

sub get_flow_color {
	my ($self) = @_;

	if ( $color_flow_href->{_flow_color} ) {
		my $color;

		$color = $color_flow_href->{_flow_color};
		return ($color);

	} else {
		print("neutral_flow, get_flow_color, missing flow color\n");
	}

}


=head2 sub get_prog_name_sref 
Exports private hash value
 
=cut

sub get_prog_name_sref {
	my ($self) = @_;

	if ( $color_flow_href->{_prog_name_sref} ) {
		my $name;

		$name = $color_flow_href->{_prog_name_sref};

		# print("neutral_flow, get_prog_name_sref,  $$name\n");
		return ($name);

	} else {
		print("neutral_flow, get_prog_name_sref, missing \n");
	}

}

=head2 sub help
Callback sequence following MB3 click 
activation of a sunix (Listbox) item
program name is a scalar reference
 
 Let help decide whether it is a superflow
 or a user-created flow
 
 Show a window with the perldoc to the user
 
=cut 

sub help {
	my ($self) = @_;
	use App::SeismicUnixGui::misc::help;
	my $help = new help();
	$help->set_name( $color_flow_href->{_prog_name_sref} );
	$help->tkpod();
	return ();
}

=head2 sub set_hash_ref
Copies with simplified names are also kept (40) so later
the hash can be returned to a calling module

=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	$gui_history->set_defaults($hash_ref);
	$color_flow_href = $gui_history->get_defaults();

	# REALLY?
	# set up param_widgets for later use
	# give param_widgets the needed values
	$param_widgets->set_hash_ref($color_flow_href);

	#	$file_menubutton               = $color_flow_href->{_file_menubutton};
	$flow_color            = $color_flow_href->{_flow_color};
	$flowNsuperflow_name_w = $color_flow_href->{_flowNsuperflow_name_w};

	#	$last_flow_color               = $color_flow_href->{_last_flow_color};                 # used in flow_select
	#	$labels_w_aref                 = $color_flow_href->{_labels_w_aref};
	$message_w     = $color_flow_href->{_message_w};
	$sunix_listbox = $color_flow_href->{_sunix_listbox};

	# print("neutral_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");

	return ();
}

=head2 sub sunix_select (subroutine is only active in neutral_flow)
Pick Seismic Unix modules

  foreach my $key (sort keys %$color_flow_href) {
   print (" neutral_flowkey is $key, value is $color_flow_href->{$key}\n");
  }
  TODO: encapsulate better
  
  set
  	$param_sunix
  	$param_widgets
  	
  get
  	$color_flow_href_messages
  	$whereami					->set4sunix_listbox()
  	$param_widgets
  	$param_sunix
  	
  call:
    $gui_history			->set4start_of_sunix_select;
    $gui_history	->set4end_of_sunix_select() ;
     $color_flow_href 			= $gui_history->get_hash_ref();
 
=cut 

sub sunix_select {
	my ($self) = @_;

	$color_flow_href->{_flow_type} = $flow_type->{_user_built};    # should be at start of neutral_flow
		 # print("neutral_flow, sunix_select,parameter_values_frame: $parameter_values_frame\n");
	use App::SeismicUnixGui::messages::message_director;
	use App::SeismicUnixGui::misc::param_sunix;
	use Clone 'clone';

	my $neutral_flow_messages = message_director->new();
	my $param_sunix           = param_sunix->new();

	my $message = $neutral_flow_messages->null_button(0);
	$message_w->delete( "1.0", 'end' );
	$message_w->insert( 'end', $message );

	# find out which program was previously touched
	# assume all prior programs touched have
	# modified parameters
	# and update that program's stored values
	# _update_prior_param_flow();

	# print("neutral_flow,1. sunix_select,flow_color: $color_flow_href->{_flow_color}\n");
	# print("neutral_flow,1. sunix_select,_is_flow_listbox_neutral_w:	$color_flow_href->{_is_flow_listbox_neutral_w} \n");

	$gui_history->set_hash_ref($color_flow_href);
	$gui_history->set4start_of_sunix_select();

	# print("neutral_flow, sunix_select print gui_history.txt\n");
	# $gui_history->view();

	#$color_flow_href->{_flow_color} 			= $gui_history->get_flow_color();
	my $flow_color = $color_flow_href->{_flow_color};

	# print("neutral_flow,2. sunix_select,flow_color: $flow_color\n");
	# print("neutral_flow,1. sunix_select,_is_flow_listbox_neutral_w:	$color_flow_href->{_is_flow_listbox_neutral_w} \n");
	# print("1. neutral_flow, sunix_select, _values_w_aref $color_flow_href->{_values_w_aref}\n");

	# get program name
	$color_flow_href->{_prog_name_sref} = $param_widgets->get_current_program( \$sunix_listbox );

	$param_sunix->set_flow_type($color_flow_href->{_flow_type});
	$param_sunix->set_program_name( $color_flow_href->{_prog_name_sref} );
	# print("3. neutral_flow sunix_select, program name is ${$color_flow_href->{_prog_name_sref}}\n");
	
	$color_flow_href->{_names_aref}                  = $param_sunix->get_names();
	$color_flow_href->{_values_aref}                 = $param_sunix->get_values();
	$color_flow_href->{_check_buttons_settings_aref} = $param_sunix->get_check_buttons_settings();
	$color_flow_href->{_param_sunix_first_idx}       = $param_sunix->first_idx();
	
	# use values not index
	$param_sunix->set_half_length();    			
	$color_flow_href->{_param_sunix_length} 		= $param_sunix->get_length();    #
	# print("4. neutral_flow sunix_select, program name is ${$color_flow_href->{_prog_name_sref}}\n");
	# print("2. neutral_flow, sunix_select, length $color_flow_href->{_param_sunix_length}\n");

	# widgets initialized in super class
	$param_widgets->set_labels_w_aref( $color_flow_href->{_labels_w_aref} );
	$param_widgets->set_values_w_aref( $color_flow_href->{_values_w_aref} );
	$param_widgets->set_check_buttons_w_aref( $color_flow_href->{_check_buttons_w_aref} );

	# print("5. neutral_flow sunix_select, program name is ${$color_flow_href->{_prog_name_sref}}\n");
	# print("41. neutral_flow sunix_select, check button settings--@{$color_flow_href->{_check_buttons_settings_aref}}--\n");

	# Correct strange memory leak inside param_widgets
	my $save = clone( $color_flow_href->{_check_buttons_settings_aref} );
	$param_widgets->gui_full_clear();

	# print("42. neutral_flow sunix_select, check button settings--@$save-\n");
	@{ $color_flow_href->{_check_buttons_settings_aref} } = @$save;

	# print("42. neutral_flow sunix_select, check button settings--@{$color_flow_href->{_check_buttons_settings_aref}}--\n");

	# $param_widgets->range($color_flow_href);
	# print("43. neutral_flow sunix_select, check button settings @{$color_flow_href->{_check_buttons_settings_aref}}\n");

	# print("6 neutral_flow sunix_select\n");
	$param_widgets->set_labels( $color_flow_href->{_names_aref} );    # equiv to "labels_aref"
	$param_widgets->set_values( $color_flow_href->{_values_aref} );

	# print("1. neutral_flow, sunix_select, _values_aref @{$color_flow_href->{_values_aref}}\n");
	# print("1. neutral_flow, sunix_select, _names_aref @{$color_flow_href->{_names_aref}}\n");
	# print("44. neutral_flow sunix_select, check button settings @{$color_flow_href->{_check_buttons_settings_aref}}\n");

	$param_widgets->set_check_buttons( $color_flow_href->{_check_buttons_settings_aref} );
	$param_widgets->set_current_program( $color_flow_href->{_prog_name_sref} );

	# print("3. neutral_flow, sunix_select, _values_w_aref $color_flow_href->{_values_w_aref}\n");
	# print("neutral_flow sunix_select, $color_flow_href->{_is_sunix_listbox}\n");
	$param_widgets->redisplay_labels();
	$param_widgets->redisplay_values();
	$param_widgets->redisplay_check_buttons();

	$gui_history->set4end_of_sunix_select();

	# print("neutral_flow,2. sunix_select,1 line after set4end_of_sunix_select\n");
	# $flow_color				= $color_flow_href->{_flow_color};
	# TODo are  following 1 line and past 1 line needed?
	#	print("1. neutral_flow sunix_select, program name is ${$color_flow_href->{_prog_name_sref}}\n");
	# $color_flow_href 		= $gui_history->get_hash_ref();

	# print("2. neutral_flow, sunix_select, _values_aref @{$color_flow_href->{_values_aref}}\n");
	# print("2. neutral_flow, sunix_select, _names_aref @{$color_flow_href->{_names_aref}}\n");

	#	$color_flow_href->{_last_flow_color} = $flow_color;
	#	print("7. neutral_flow sunix_select, program name is ${$color_flow_href->{_prog_name_sref}}\n");
	# for export to other colored flows
	#	$last_flow_color = $flow_color;
	#	print("4. neutral_flow, sunix_select, _values_w_aref $color_flow_href->{_values_w_aref}\n");
	#	print("neutral_flow,3. sunix_select,flow_color: $flow_color\n");
	#	print("8. neutral_flow sunix_select, program name is ${$color_flow_href->{_prog_name_sref}}\n");
	return ();
}

1;
