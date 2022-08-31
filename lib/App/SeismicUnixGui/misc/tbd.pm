package App::SeismicUnixGui::misc::L_SU_global_constants;

use Moose;
use aliased 'App::SeismicUnixGui::misc::manage_dirs_by';

my $path4SeismicUnixGui_lib;
my $path4SeismicUnixGui;
my $L_SU;

BEGIN {
	# searching for directory: SeismicUnixGui
	use Shell qw(echo);
	use Carp;
	$path4SeismicUnixGui = ` echo \$SeismicUnixGui`;
	chomp $path4SeismicUnixGui;

	if ( length $path4SeismicUnixGui ) {

		$L_SU               		= $path4SeismicUnixGui;
		$path4SeismicUnixGui_lib 	= $path4SeismicUnixGui;

 #   print ("L_SU_global_constants,SeismicUnixGui_lib = $path4SeismicUnixGui_lib\n");
#		print("L_SU_global_constants,SeismicUnixGui = $path4SeismicUnixGui\n");
	}
	else {
		print("SeismicUnixGui=$path4SeismicUnixGui\n");
		print("L_SU_global_constants, Missing value unexpected\n");
	}
}

=head2 private hash

=cut

my $L_SU_global_constants = {

	_CHILD_DIR          => '',
	_CHILD_DIR_CONVERT  => '',
	_CHILD_DIR_GUI      => '',
	_CHILD_DIR_TOOLS    => '',
	_CHILD_DIR_SPECS    => '',
	_CHILD_DIR_SU       => '',
	_GRANDPARENT_DIR    => '',
	_PARENT_DIR         => '',
	_PARENT_DIR_CONVERT => '',
	_PARENT_DIR_GEN     => '',
	_PARENT_DIR_GUI     => '',
	_PARENT_DIR_TOOLS   => '',
	_PARENT_DIR_SPECS   => '',
	_PARENT_DIR_SU      => '',
	_file_name          => '',
	_program_name	    => '',

};

=head2 sub clear

wipe clean private hash values

=cut

sub clear {
	my ($self) = @_;
	$L_SU_global_constants->{_CHILD_DIR}  		 = '';
	$L_SU_global_constants->{_CHILD_DIR_CONVERT} = '';
	$L_SU_global_constants->{_CHILD_DIR_GUI}      = '';
	$L_SU_global_constants->{_CHILD_DIR_TOOLS}    = '';
	$L_SU_global_constants->{_CHILD_DIR_SPECS}    = '';
	$L_SU_global_constants->{_CHILD_DIR_SU}       = '';
	$L_SU_global_constants->{_GRANDPARENT_DIR}    = '';
	$L_SU_global_constants->{_PARENT_DIR}         = '';
	$L_SU_global_constants->{_PARENT_DIR_CONVERT} = '';
	$L_SU_global_constants->{_PARENT_DIR_GEN}     = '';
	$L_SU_global_constants->{_PARENT_DIR_GUI}     = '';
	$L_SU_global_constants->{_PARENT_DIR_TOOLS}   = '';
	$L_SU_global_constants->{_PARENT_DIR_SPECS}   = '';
	$L_SU_global_constants->{_PARENT_DIR_SU}      = '';
	$L_SU_global_constants->{_file_name}          = '',
	$L_SU_global_constants->{_program_name}	      = '';
	return();
}



=head2 Default Tk settings

 _first_entry_num is normally 1 _max_entry_num is defaulted to

=cut

my $alias_superflow_names_h = {
	fk                => 'Sudipfilt',
	ProjectVariables  => 'Project_Variables',
	SetProject        => 'SetProject',
	iPick             => 'iPick',
	iSpectralAnalysis => 'iSpectralAnalysis',
	iVelAnalysis      => 'iVA',
	iTopMute          => 'iTopMute',
	iBottomMute       => 'iBottomMute',
	Project           => 'Project',
	Synseis           => 'Synseis',
	Sseg2su           => 'Sseg2su',
	Sucat             => 'Sucat',
	immodpg           => 'immodpg',
	temp              => 'temp',                # make last
};

my $alias_superflow_spec_names_h = {
	fk                => 'Sudipfilt',
	ProjectVariables  => 'Project_Variables',
	SetProject        => 'SetProject',
	iPick             => 'iPick',
	iSpectralAnalysis => 'iSpectralAnalysis',
	iVelAnalysis      => 'iVA',
	iVA               => 'iVA',
	iTopMute          => 'iTopMute',
	iBottomMute       => 'iBottomMute',
	Project           => 'Project',
	Synseis           => 'Synseis',
	Sseg2su           => 'Sseg2su',
	Sucat             => 'Sucat',
	Sudipfilt         => 'Sudipfilt',
	immodpg           => 'immodpg',
	temp              => 'temp',                # make last
};

=head2 

  hash that assigns numbers to each color
  
=cut

my $number_from_color = {
	_grey  => 0,
	_pink  => 1,
	_green => 2,
	_blue  => 3,
};

#print("my constants, alias for fk: $alias_h->{fk}\n");

my $superflow_names_h = {
	_fk                => 'fk',
	_Sudipfilt         => 'Sudipfilt',
	_ProjectVariables  => 'ProjectVariables',
	_iPick             => 'iPick',
	_SetProject        => 'SetProject',
	_iSpectralAnalysis => 'iSpectralAnalysis',
	_iVelAnalysis      => 'iVelAnalysis',
	_iVA               => 'iVA',
	_iTopMute          => 'iTopMute',
	_iBottomMute       => 'iBottomMute',
	_Project           => 'Project',
	_Synseis           => 'Synseis',
	_Sseg2su           => 'Sseg2su',
	_Sucat             => 'Sucat',
	_immodpg           => 'immodpg',
	_temp              => 'temp',                # make last
};

=head2

 as shown in gui

=cut

my @superflow_names_gui;
$superflow_names_gui[0]  = 'Project';
$superflow_names_gui[1]  = 'Sseg2su';
$superflow_names_gui[2]  = 'Sucat';
$superflow_names_gui[3]  = 'iSpectralAnalysis';
$superflow_names_gui[4]  = 'iVelAnalysis';
$superflow_names_gui[5]  = 'iTopMute';
$superflow_names_gui[6]  = 'iBottomMute';
$superflow_names_gui[7]  = 'fk';
$superflow_names_gui[8]  = 'Synseis';
$superflow_names_gui[9]  = 'iPick';
$superflow_names_gui[10] = 'immodpg';
$superflow_names_gui[11] = 'temp';                # make last

my @superflow_names;
$superflow_names[0]  = 'fk';
$superflow_names[1]  = 'ProjectVariables';
$superflow_names[2]  = 'SetProject';
$superflow_names[3]  = 'iSpectralAnalysis';
$superflow_names[4]  = 'iVelAnalysis';
$superflow_names[5]  = 'iTopMute';
$superflow_names[6]  = 'iBottomMute';
$superflow_names[7]  = 'Project';
$superflow_names[8]  = 'Synseis';
$superflow_names[9]  = 'Sseg2su';
$superflow_names[10] = 'Sucat';
$superflow_names[11] = 'iPick';
$superflow_names[12] = 'immodpg';
$superflow_names[13] = 'temp';                # make last

my @alias_superflow_names;
$alias_superflow_names[0]  = 'Sudipfilt';
$alias_superflow_names[1]  = 'SetProject';
$alias_superflow_names[2]  = 'SetProject';
$alias_superflow_names[3]  = 'iSpectralAnalysis';
$alias_superflow_names[4]  = 'iVA';
$alias_superflow_names[5]  = 'iTopMute';
$alias_superflow_names[6]  = 'iBottomMute';
$alias_superflow_names[7]  = 'Project';
$alias_superflow_names[8]  = 'Synseis';
$alias_superflow_names[9]  = 'Sseg2su';
$alias_superflow_names[10] = 'Sucat';
$alias_superflow_names[11] = 'iPick';
$alias_superflow_names[12] = 'immodpg';
$alias_superflow_names[13] = 'temp';                # make last

# to match each alias_superflow_names (above)
# Tools subdirectories
my @developer_Tools_categories;
$developer_Tools_categories[0]  = 'big_streams';
$developer_Tools_categories[1]  = '.';
$developer_Tools_categories[2]  = '.';
$developer_Tools_categories[3]  = 'big_streams';
$developer_Tools_categories[4]  = 'big_streams';
$developer_Tools_categories[5]  = 'big_streams';
$developer_Tools_categories[6]  = 'big_streams';
$developer_Tools_categories[7]  = '.';
$developer_Tools_categories[8]  = 'big_streams';
$developer_Tools_categories[9]  = 'big_streams';
$developer_Tools_categories[10] = 'big_streams';
$developer_Tools_categories[11] = 'big_streams';
$developer_Tools_categories[12] = 'big_streams';
$developer_Tools_categories[13] = 'big_streams';

my @superflow_config_names;
$superflow_config_names[0]  = 'Sudipfilt';
$superflow_config_names[1]  = 'ProjectVariables';
$superflow_config_names[2]  = 'ProjectVariables';
$superflow_config_names[3]  = 'iSpectralAnalysis';
$superflow_config_names[4]  = 'iVA';
$superflow_config_names[5]  = 'iTopMute';
$superflow_config_names[6]  = 'iBottomMute';
$superflow_config_names[7]  = 'Project';
$superflow_config_names[8]  = 'Synseis';
$superflow_config_names[9]  = 'Sseg2su';
$superflow_config_names[10] = 'Sucat';
$superflow_config_names[11] = 'iPick';
$superflow_config_names[12] = 'immodpg';
$superflow_config_names[13] = 'temp';                # make last

my @alias_superflow_config_names;
$alias_superflow_config_names[0]  = 'Sudipfilt';
$alias_superflow_config_names[1]  = 'Project_Variables';
$alias_superflow_config_names[2]  = 'Project# make last_Variables';
$alias_superflow_config_names[3]  = 'iSpectralAnalysis';
$alias_superflow_config_names[4]  = 'iVA';
$alias_superflow_config_names[5]  = 'iTopMute';
$alias_superflow_config_names[6]  = 'iBottomMute';
$alias_superflow_config_names[7]  = 'Project';
$alias_superflow_config_names[8]  = 'Synseis';
$alias_superflow_config_names[9]  = 'Sseg2su';
$alias_superflow_config_names[10] = 'Sucat';
$alias_superflow_config_names[11] = 'iPick';
$alias_superflow_config_names[12] = 'immodpg';
$alias_superflow_config_names[13] = 'temp';                          # make last

# for the visible buttons in the GUI only
# e.g., Path and PL_SEISMIC are not visible to the user
# but Flow and SaveAs are.
my @alias_FileDialog_button_label;

#$alias_FileDialog_button_label[0] = 'Data';
$alias_FileDialog_button_label[0] = 'Flow';
$alias_FileDialog_button_label[1] = 'SaveAs';

my @file_dialog_type;

# for the visible Help button in the GUI
my @alias_help_menubutton_label;
$alias_help_menubutton_label[0] = 'Install',

  my $alias_help_menubutton_label_h = { _Install => 'Install', };

# in spec files Data_PL_SEISMIC, is not necessarily informed by DATA_DIR_IN and DATA_DIR_OUT
$file_dialog_type[0] = 'Data_PL_SEISMIC',

  # in spec files, Data is informed by DATA_DIR_IN and DATA_DIR_OUT
  $file_dialog_type[1] = 'Data';
$file_dialog_type[2] = 'Path';
$file_dialog_type[3] = 'Flow';
$file_dialog_type[4] = 'SaveAs';
$file_dialog_type[5] = 'last_dir_in_path';

my $file_dialog_type_h = {
	_Data_PL_SEISMIC  => 'Data_PL_SEISMIC',
	_Data             => 'Data',
	_Path             => 'Path',
	_last_dir_in_path => 'last_dir_in_path',
	_Flow             => 'Flow',
	_SaveAs           => 'SaveAs',
	_Save             => 'Save',
};
my @flow_type;
$flow_type[0] = 'user_built';
$flow_type[1] = 'pre_built_superflow';

my $flow_type_h = {
	_user_built          => 'user_built',
	_pre_built_superflow => 'pre_built_superflow',
};

my $help_menubutton_type_h = { _Install => 'Install', };

my $purpose = { _geopsy => 'geopsy', };

my $var = {
	_1_character            => '1',
	_14_characters          => '14',
	_13_characters          => '13',
	_12_characters          => '12',
	_11_characters          => '11',
	_2_characters           => '2',
	_3_characters           => '3',
	_4_characters           => '4',
	_5_characters           => '5',
	_6_characters           => '6',
	_7_characters           => '7',
	_8_characters           => '8',
	_10_characters          => '10',
	_15_characters          => '15',
	_20_characters          => '20',
	_30_characters          => '30',
	_32_characters          => '32',
	_35_characters          => '35',
	_37_characters          => '37',
	_40_characters          => '40',
	_45_characters          => '45',
	_ACTIVE_PROJECT         => '/.L_SU/configuration/active',
	_App                    => 'App',
	_SeismicUnixGui         => 'SeismicUnixGui',
	_Project_config         => 'Project.config',
	_skip_directory         => 'archive',
	_base_file_name         => 'base_file_name',
	_clear_text             => '',
	_color_default          => 'grey',           # first color listbox to select
	_config_file_format     => '%-35s%1s%-20s',
	_eight_characters       => '8',
	_empty_string           => '',
	_failure                => -1,
	_false                  => 0,
	_data_name              => 'data_name',
	_base_file_name         => 'base_file_name',
	_five_pixels            => '5',
	_five_pixel_borderwidth => 5,
	_five_lines             => '5',
	_1_line                 => '1',
	_2_lines                => '2',
	_3_lines                => '3',
	_4_lines                => '4',
	_8_lines                => '8',
	_7_lines                => '7',
	_1_pixel                => '1',
	_3_pixels               => '3',
	_6_pixels               => '6',
	_24_pixels              => '24',
	_12_pixels              => '12',
	_18_pixels              => '18',
	_NaN                    => 'NaN',
	_five_characters        => '5',
	_flow                   => 'frame',
	_half_tiny_width        => '6',
	_hundred_characters     => '100',
	_large__width           => '200',
	_light_gray             => 'gray90',
	_literal_empty_string   => '\'\'',
	_l_suplot_box_positionNsize    => '600x800+1000+1000',
	_l_suplot_width                => '500',
	_l_suplot_height               => '300',
	_log_file_txt                  => 'log.txt',
	_main_window_geometry          => '1100x750+12+5',
	_medium_width                  => '100',
	_message_box_geometry          => '400x250+400+400',
	_ms2s                          => 0.001,
	_my_arial                      => "-*-arial-normal-r-*-*-*-120-*-*-*-*-*-*",
	_my_purple                     => 'MediumPurple1',
	_my_white                      => 'white',
	_my_yellow                     => 'LightGoldenrod1',
	_my_dark_grey                  => 'DarkGrey',
	_my_black                      => 'black',
	_my_light_green                => 'LightGreen',
	_my_light_grey                 => 'LightGrey',
	_my_pink                       => 'pink',
	_my_light_blue                 => 'LightBlue',
	_my_dialog_box_geometry        => '400x250+400+400',
	_no_pixel                      => '0',
	_no_dir                        => '/',
	_no_borderwidth                => '0',
	_nu                            => 'nu',
	_no                            => 'no',
	_on                            => 'on',
	_off                           => 'off',
	_one_character                 => '1',
	_one_pixel                     => '1',
	_one_pixel_borderwidth         => '1',
	_program_title                 => 'SeismicUnixGui V0.70.60',
	_project_selector_title        => 'Project Selector',
	_l_suplot_title                => 'L_suplot',
	_project_selector_title        => 'Project Selector',
	_project_selector              => 'Project',
	_project_selector_box_position => '600x600+100+100',
	_null_sunix_value              => '',
	_reservation_color_default     =>
	  'grey',    # first choice for reserving a color listbox
	_suffix_pm              => '.pm',
	_superflow              => 'menubutton',
	_small_width            => '50',
	_string2startFlowSetUp  => '->clear\(\);',    # for regex in perl_flow
	_string2endFlowSetUp    => '->Step\(\);',     # for regex in perl_flow
	_standard_width         => '20',
	_ten_characters         => '10',
	_test_dir_name          => 't',
	_eleven_characters      => '11',
	_five_characters        => '5',
	_thirty_characters      => '30',
	_18_characters          => '18',
	_thirty_five_characters => '35',
	_tiny_width             => '12',
	_true                   => 1,
	_us_per_s               => 1000000,
	_twenty_characters      => '20',
	_us2s                   => 0.000001,
	_username               => 'tester',
	_very_small_width       => '25',
	_very_large_width       => '500',
	_yes                    => 'yes',
	_white                  => 'white',

};

=pod
    _length = (max number of entries + 1)

=cut

my $param = {
	_max_entry_num   => 90,
	_first_entry_num => 0,
	_first_entry_idx => 0,
	_final_entry_num => 90,
	_final_entry_idx => 90,
	_default_index   => 0,
	_length          => 90,    # max number of allowable parameters in GUI
};

# Locate environment variables automatically
my @PARENT_DIR_CONVERT = ( "sunix",   "misc", "configs" );
my @PARENT_DIR_GUI     = ( "configs", "specs" );
my @PARENT_DIR_TOOLS   = ("big_streams");
my @PARENT_DIR_SPECS   = ("specs");
my @PARENT_DIR_SU      = ("sunix");

my @PARENT_DIR_GEN = (
	"misc", "geopsy", "gmt", "messages",
	"developer/code/sunix", "developer/code/gmt", "script", "sqlite", "t",
);

my @CHILD_DIR_CONVERT = (
	"",          "big_streams", "data",      "datum",
	"filter",    "header",      "inversion", "migration",
	"model",     "NMO_Vel_Stk", "par",       "plot",
	"shapeNcut", "shell",       "statsMath", "transform",
	"well"
);

my @CHILD_DIR_GEN = ( "", );

my @CHILD_DIR_GUI = (
	"big_streams", "data",      "datum",     "filter",
	"header",      "inversion", "migration", "model",
	"NMO_Vel_Stk", "par",       "plot",      "shapeNcut",
	"shell",       "statsMath", "transform", "well"
);

my @CHILD_DIR_TOOLS = ("");

my @CHILD_DIR_SPECS = (
	"big_streams", "data",      "datum",     "filter",
	"header",      "inversion", "migration", "model",
	"NMO_Vel_Stk", "par",       "plot",      "shapeNcut",
	"shell",       "statsMath", "transform", "well"
);

#my @CHILD_DIR_SPECS = (
#	"big_streams"
#);

my @CHILD_DIR_SU = (
	"data",      "datum",     "filter",    "header",
	"inversion", "migration", "model",     "NMO_Vel_Stk",
	"par",       "plot",      "shapeNcut", "shell",
	"statsMath", "transform", "well"
);

$L_SU_global_constants->{_PARENT_DIR_CONVERT} = \@PARENT_DIR_CONVERT;
$L_SU_global_constants->{_PARENT_DIR_GUI}     = \@PARENT_DIR_GUI;
$L_SU_global_constants->{_PARENT_DIR_TOOLS}   = \@PARENT_DIR_TOOLS;
$L_SU_global_constants->{_PARENT_DIR_SPECS}   = \@PARENT_DIR_SPECS;
$L_SU_global_constants->{_PARENT_DIR_SU}      = \@PARENT_DIR_SU;
$L_SU_global_constants->{_PARENT_DIR_GEN}     = \@PARENT_DIR_GEN;
$L_SU_global_constants->{_CHILD_DIR_CONVERT}  = \@CHILD_DIR_CONVERT;
$L_SU_global_constants->{_CHILD_DIR_GEN}      = \@CHILD_DIR_GEN;
$L_SU_global_constants->{_CHILD_DIR_GUI}      = \@CHILD_DIR_GUI;
$L_SU_global_constants->{_CHILD_DIR_TOOLS}    = \@CHILD_DIR_TOOLS;
$L_SU_global_constants->{_CHILD_DIR_SPECS}    = \@CHILD_DIR_SPECS;
$L_SU_global_constants->{_CHILD_DIR_SU}       = \@CHILD_DIR_SU;

my @developer_sunix_categories;
$developer_sunix_categories[0]  = 'data';
$developer_sunix_categories[1]  = 'datum';
$developer_sunix_categories[2]  = 'plot';
$developer_sunix_categories[3]  = 'filter';
$developer_sunix_categories[4]  = 'header';
$developer_sunix_categories[5]  = 'inversion';
$developer_sunix_categories[6]  = 'migration';
$developer_sunix_categories[7]  = 'model';
$developer_sunix_categories[8]  = 'NMO_Vel_Stk';
$developer_sunix_categories[9]  = 'par';
$developer_sunix_categories[10] = 'picks';
$developer_sunix_categories[11] = 'shapeNcut';
$developer_sunix_categories[12] = 'shell';
$developer_sunix_categories[13] = 'statsMath';
$developer_sunix_categories[14] = 'transform';
$developer_sunix_categories[15] = 'well';
$developer_sunix_categories[16] = '';
$developer_sunix_categories[17] = '';

my @sunix_data_programs = (
	"ctrlstrip",   "data_in",       "data_out",  "dt1tosu",
	"segbread",    "segdread",      "segyread",  "segyscan",
	"segywrite",   "suoldtonew",    "supack1",   "supack2",
	"suswapbytes", "suunpack1",     "suunpack2", "wpc1uncomp2",
	"wpccompress", "wpcuncompress", "wptcomp",   "wptuncomp",
	"wtcomp",      "wtuncomp",
);

my @sunix_datum_programs =
  ( "sudatumk2dr", "sudatumk2ds", "sukdmdcr", "sukdmdcs", );

my @sunix_filter_programs = (
	"subfilt",      "succfilt",   "sucddecon",  "sudipfilt",
	"sueipofi",     "sufilter",   "sufrac",     "sufxdecon",
	"suk1k2filter", "sukfilter",  "sulfaf",     "sumedian",
	"supef",        "suphase",    "suphidecon", "supofilt",
	"supolar",      "susmgauss2", "sutvband",
);

my @sunix_header_programs = (
	"segyclean",   "segyhdrmod", "segyhdrs",    "setbhed",
	"su3dchart",   "suabshw",    "suaddhead",   "suaddstatics",
	"suahw",       "suascii",    "suazimuth",   "sucdpbin",
	"suchart",     "suchw",      "sucliphead",  "sucountkey",
	"sudumptrace", "suedit",     "sugethw",     "suhtmath",
	"sukeycount",  "sulcthw",    "sulhead",     "supaste",
	"surandhw",    "surange",    "susehw",      "sushw",
	"sustatic",    "sustaticB",  "sustaticrrs", "sustrip",
	"sutrcount",   "suutm",      "suxedit",     "swapbhed",
);

my @sunix_inversion_programs = ( "suinvco3d", "suinvvxzco", "suinvzco3d", );

my @sunix_migration_programs = (
	"sudatumfd",  "sugazmig",   "sukdmig2d",    "suktmig2d",
	"sukdmig3d",
	"sumigfd",   "sumigffd",    "sumiggbzo",    "sumiggbzoan",
	"sumigprefd", "sumigpreffd", "sumigprepspi", "sumigpresp",
	"sumigpspi", "sumigpsti",   "sumigsplit",   "sumigtk",
	"sumigtopo2d", "sustolt",    "sutifowler",
);

my @sunix_shell_programs = ( "catsu", "evince", "sugetgthr", "suputgthr", );

=pod


=cut

my @sunix_model_programs = (
	"addrvl3d",       "cellauto",     "elacheck",     "elamodel",
	"elaray",         "elasyn",       "elatriuni",    "gbbeam",
	"grm",            "normray",      "raydata",      "suaddevent",
	"suaddnoise",     "sudgwaveform", "suea2df",      "sufctanismod",
	"sufdmod1",       "sufdmod2",     "sufdmod2_pml", "sugoupillaud",
	"sugoupillaudpo", "suimp2d",      "suimp3d",      "suimpedance",
	"sujitter",       "sukdsyn2d",    "sunull",       "suplane",
	"surandspike",    "surandstat",   "suremac2d",    "suremel2dan",
	"suspike",        "susyncz",      "susynlv",      "susynlvcw",
	"susynlvfti",     "susynvxz",     "susynvxzcs",
);

my @sunix_NMO_Vel_Stk_programs = (
	"dzdv",      "sucvs4fowler", "sudivstack",   "sudmofk",
	"sudmofkcw", "sudmotivz",    "sudmotx",      "sudmovz",
	"suilog",    "suintvel",     "sulog",        "sunmo",
	"sunmo_a",   "supws",        "surecip",      "sureduce",
	"surelan",   "surelanan",    "suresamp",     "sushift",
	"sustack",   "sustkvel",     "sutaupnmo",    "sutihaledmo",
	"sutivel",   "sutsq",        "suttoz",       "suvel2df",
	"suvelan",   "suvelan_nccs", "suvelan_nsel", "suztot",
);

my @sunix_par_programs = (
	"a2b",        "a2i",       "b2a",      "bhedtopar",
	"cshotplot",  "float2ibm", "ftnstrip", "ftnunstrip",
	"makevel",    "mkparfile", "transp",   "unif2",
	"unif2aniso", "unisam",    "vel2stiff",
);

my @sunix_picks_programs = (

);

my @sunix_plot_programs = (
	"elaps",           "lcmap",     "lprop",         "psbbox",
	"pscontour",       "pscube",    "pscubecontour", "psepsi",
	"psgraph",         "psimage",   "pslabel",       "psmanager",
	"psmerge",         "psmovie",   "pswigb",        "pswigp",
	"scmap",           "spsplot",   "supscontour",   "supscube",
	"supscubecontour", "supsgraph", "supsimage",     "supsmax",
	"supsmovie",       "supswigb",  "supswigp",      "suxcontour",
	"suxgraph",        "suximage",  "suxmax",        "suxmovie",
	"suxpicker",       "suxwigb",   "xgraph",        "ximage",
	"xmovie",          "xwigb",
);

my @sunix_shapeNcut_programs = (
	"suflip", "sugain", "sugprfb", "sukill",
	"sumute", "susort", "susplit", "suwind",
);

my @sunix_statsMath_programs = (
	"cpftrend",   "entropy",     "farith",       "suacor",
	"suacorfrac", "sualford",    "suattributes", "suconv",
	"sufwmix",    "suhistogram", "suhrot",       "suinterp",
	"sumax",      "sumean",      "sumix",        "suop",
	"suop2",      "suxcor",      "suxmax",
);

my @sunix_transform_programs = (
	"dctcomp",     "suamp",  "succepstrum", "sucepstrum",
	"sucwt",       "succwt", "sufft",       "sugabor",
	"suicepstrum", "suifft", "suphasevel",  "suspecfk",
	"suspecfx",    "sutaup",
);

my @sunix_well_programs =
  ( "las2su", "subackus", "subackush", "sugassman", "sulprime", "suwellrf", );

$var->{_sunix_data_programs}        = \@sunix_data_programs;
$var->{_sunix_datum_programs}       = \@sunix_datum_programs;
$var->{_sunix_plot_programs}        = \@sunix_plot_programs;
$var->{_sunix_filter_programs}      = \@sunix_filter_programs;
$var->{_sunix_inversion_programs}   = \@sunix_inversion_programs;
$var->{_sunix_header_programs}      = \@sunix_header_programs;
$var->{_sunix_migration_programs}   = \@sunix_migration_programs;
$var->{_sunix_shell_programs}       = \@sunix_shell_programs;
$var->{_sunix_model_programs}       = \@sunix_model_programs;
$var->{_sunix_NMO_Vel_Stk_programs} = \@sunix_NMO_Vel_Stk_programs;
$var->{_sunix_par_programs}         = \@sunix_par_programs;
$var->{_sunix_picks_programs}       = \@sunix_picks_programs;
$var->{_sunix_shapeNcut_programs}   = \@sunix_shapeNcut_programs;
$var->{_sunix_statsMath_programs}   = \@sunix_statsMath_programs;
$var->{_sunix_transform_programs}   = \@sunix_transform_programs;
$var->{_sunix_well_programs}        = \@sunix_well_programs;


sub _get_path4SeismicUnixGui {
	my ($self) = @_;
	if(length $path4SeismicUnixGui ){
		
		my $result = $path4SeismicUnixGui;
		return($result);
		
	} else {
		print ("L_SU_global_constants, _get_path4SeismicUnixGui,missing variable\n");
	}
	return();	
}

=head2 sub _get_path4spec_file

Find a path for

a given spec file

=cut

sub _get_path4spec_file {

	my (@self) = @_;

	if ( length $L_SU_global_constants->{_file_name} ) {

		my $file_name = $L_SU_global_constants->{_file_name};
		my $result;

=head2 Collect parameters from local hash

=cut

		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
		my @PARENT_DIR_SPECS = @{ $L_SU_global_constants->{_PARENT_DIR_SPECS} };
		my @CHILD_DIR_SPECS  = @{ $L_SU_global_constants->{_CHILD_DIR_SPECS} };

=head2 Collect relevant "spec"

 project paths and files

=cut

		my ( $result_aref3, $dimensions_aref ) = _get_specs_pathNfile2search();
		my @result_aref2                     = @$result_aref3;
		my @directory_contents_specs         = @{ $result_aref2[0] };
		my @dimension                        = @$dimensions_aref;
		my $parent_directory_specs_number_of = $dimension[0];
		my $child_directory_specs_number_of  = $dimension[1];

# test
#		my $parent_specs = 1;
#		my $child_specs  = 1;
#		print(
#"\nFor specs directory paths: $PARENT_DIR_SPECS[$parent_specs]::$CHILD_DIR_SPECS[$child_specs]::\n"
#		);
#		print("@{$directory_contents_specs[$parent_specs][$child_specs]}\n");

=head2 Search all "spec"-relevant 

directories start with 
gui drectory listing

=cut

		for (
			my $parent = 0 ;
			$parent < $parent_directory_specs_number_of ;
			$parent++
		  )
		{

			for (
				my $child = 0 ;
				$child < $child_directory_specs_number_of ;
				$child++
			  )
			{

				my $directory_list_aref =
				  $directory_contents_specs[$parent][$child];
				my @directory_list = @$directory_list_aref;

				my $length_directory_list = scalar @directory_list;

				#				print("@{$directory_contents_specs[$parent][$child]}\n");
				#				print("file_name=$file_name\n");
				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {

					if ( not $file_name eq $directory_list[$i] ) {

						next;

					}
					elsif ( $file_name eq $directory_list[$i] ) {

		 #						print(
		 #"L_SU_global_constants,_get_path4spec_file,found the file $file_name in
		 #				  			  $PARENT_DIR_SPECS[$parent]::$CHILD_DIR_SPECS[$child]\n"
		 #						);
						$result =
							$path4SeismicUnixGui . '/'
						  . $PARENT_DIR_SPECS[$parent] . '/'
						  . $CHILD_DIR_SPECS[$child];

						return ($result);
					}
					else {
						print("change_a_line, unexpected value\n");
						return ();
					}
				}

			}
		}

	}
	else {
		print("L_SU_global_constants,__get_path4spec_file,file_name_missing\n");
		return ();
	}
}

=head2 sub _get_path4su_file

Find a path for

a given spec file

=cut

sub _get_path4su_file {

	my (@self) = @_;

	if ( length $L_SU_global_constants->{_file_name} ) {

		my $file_name = $L_SU_global_constants->{_file_name};
		my $result;

=head2 Collect parameters from local hash

=cut

		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
		my @PARENT_DIR_SPECS = @{ $L_SU_global_constants->{_PARENT_DIR_SPECS} };
		my @CHILD_DIR_SPECS  = @{ $L_SU_global_constants->{_CHILD_DIR_SPECS} };

=head2 Collect relevant "spec"

 project paths and files

=cut

		my ( $result_aref3, $dimensions_aref ) = _get_su_pathNfile2search();
		my @result_aref2                     = @$result_aref3;
		my @directory_contents_su         = @{ $result_aref2[0] };
		my @dimension                        = @$dimensions_aref;
		my $parent_directory_su_number_of = $dimension[0];
		my $child_directory_su_number_of  = $dimension[1];

# test
#		my $parent_su = 1;
#		my $child_su  = 1;
#		print(
#"\nFor su directory paths: $PARENT_DIR_SPECS[$parent_su]::$CHILD_DIR_SPECS[$child_su]::\n"
#		);
#		print("@{$directory_contents_su[$parent_su][$child_su]}\n");

=head2 Search all "spec"-relevant 

directories start with 
gui drectory listing

=cut

		for (
			my $parent = 0 ;
			$parent < $parent_directory_su_number_of ;
			$parent++
		  )
		{

			for (
				my $child = 0 ;
				$child < $child_directory_su_number_of ;
				$child++
			  )
			{

				my $directory_list_aref =
				  $directory_contents_su[$parent][$child];
				my @directory_list = @$directory_list_aref;

				my $length_directory_list = scalar @directory_list;

				#				print("@{$directory_contents_su[$parent][$child]}\n");
				#				print("file_name=$file_name\n");
				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {

					if ( not $file_name eq $directory_list[$i] ) {

						next;

					}
					elsif ( $file_name eq $directory_list[$i] ) {

		 #						print(
		 #"L_SU_global_constants,_get_path4spec_file,found the file $file_name in
		 #				  			  $PARENT_DIR_SPECS[$parent]::$CHILD_DIR_SPECS[$child]\n"
		 #						);
						$result =
							$path4SeismicUnixGui . '/'
						  . $PARENT_DIR_SPECS[$parent] . '/'
						  . $CHILD_DIR_SPECS[$child];

						return ($result);
					}
					else {
						print("change_a_line, unexpected value\n");
						return ();
					}
				}

			}
		}

	}
	else {
		print("L_SU_global_constants,__get_path4spec_file,file_name_missing\n");
		return ();
	}
}


sub _set_file_name {

	my ( $self) = @_;

	if ( length $self ) {

		$L_SU_global_constants->{_file_name} = $self;

#		print("L_SU_global_constants,set_file_name,_set_file_name = $L_SU_global_constants->{_file_name}\n");

	}
	else {
		print("L_SU_global_constants,_set_file_name, missing variable");
	}

}


sub alias_superflow_names_h {

	my ($self) = @_;
	return ($alias_superflow_names_h);

}

sub alias_FileDialog_button_label_aref {    # array ref
											#my 	$self = @_;
	return ( \@alias_FileDialog_button_label );
}

sub alias_help_menubutton_label_aref {    # array ref
										  #my 	$self = @_;
	return ( \@alias_help_menubutton_label );
}

sub alias_help_menubutton_label_h {    # hash ref

	return ($alias_help_menubutton_label_h);
}

sub alias_superflow_names_aref {

	return ( \@alias_superflow_names );

}

sub alias_superflow_spec_names_h {

	return ($alias_superflow_spec_names_h);
}

sub developer_sunix_categories_aref {

	return ( \@developer_sunix_categories );

}

sub developer_Tools_categories_aref {

	return ( \@developer_Tools_categories );

}

sub file_dialog_type_aref {

	return ( \@file_dialog_type );
}

sub file_dialog_type_href {

	return ($file_dialog_type_h);
}

sub flow_type_aref {

	return ( \@flow_type );
}

sub flow_type_href {

	return ($flow_type_h);
}

=head2 sub get_colon_pathNmodule

=cut

sub get_colon_pathNmodule {

	my ($self) = @_;

	if ( length $L_SU_global_constants->{_program_name} ) {


		my $program_name = $L_SU_global_constants->{_program_name};

		my $module_spec    = $program_name . '_spec';
		my $module_spec_pm = $program_name . '_spec.pm';

		_set_file_name($module_spec_pm);
		my $path4spec = _get_path4spec_file();
		
		my $path4SeismicUnixGui = _get_path4SeismicUnixGui;

#		my $pathNmodule_pm   = $path4spec . '/' . $module_spec_pm;
		my $pathNmodule_spec = $path4spec . '/' . $module_spec;

		# carp"pathNmodule_pm = $pathNmodule_pm";

		$pathNmodule_spec =~ s/$path4SeismicUnixGui//g;
		$pathNmodule_spec =~ s/\//::/g;
		my $new_pathNmodule_spec = 'App::SeismicUnixGui' . $pathNmodule_spec;

		my $result = $new_pathNmodule_spec;
		return ($result);

	}
	else {
		carp "missing program name";
		return ();
	}

}

=head2 sub get_colon_pathNmodule_spec

=cut

sub get_colon_pathNmodule_spec {

	my ($self) = @_;

	if ( length $L_SU_global_constants->{_program_name} ) {


		my $program_name = $L_SU_global_constants->{_program_name};

		my $module_spec    = $program_name . '_spec';
		my $module_spec_pm = $program_name . '_spec.pm';

		_set_file_name($module_spec_pm);
		my $path4spec = _get_path4spec_file();
		
		my $path4SeismicUnixGui = _get_path4SeismicUnixGui;

#		my $pathNmodule_pm   = $path4spec . '/' . $module_spec_pm;
		my $pathNmodule_spec = $path4spec . '/' . $module_spec;

		# carp"pathNmodule_pm = $pathNmodule_pm";

		$pathNmodule_spec =~ s/$path4SeismicUnixGui//g;
		$pathNmodule_spec =~ s/\//::/g;
		my $new_pathNmodule_spec = 'App::SeismicUnixGui' . $pathNmodule_spec;

		my $result = $new_pathNmodule_spec;
		return ($result);

	}
	else {
		carp "missing program name";
		return ();
	}

}

sub get_path4SeismicUnixGui {
	my ($self) = @_;
	if(length $path4SeismicUnixGui ){
		
		my $result = $path4SeismicUnixGui;
		return($result);
		
	} else {
		print ("L_SU_global_constants, get_path4SeismicUnixGui,missing variable\n");
	}
	return();	
}

=head2 sub get_pathNmodule_spec

=cut

sub get_pathNmodule_spec {
	my ($self) = @_;

	if ( length $L_SU_global_constants->{_program_name} ) {

		my $program_name = $L_SU_global_constants->{_program_name};
		my $module_spec = $program_name . '_spec';	
		my $module_spec_pm = $module_spec.'.pm';	
		_set_file_name($module_spec_pm);
		
		my $path4spec = _get_path4spec_file();
		
		my $pathNmodule_spec   = $path4spec . '/' . $module_spec;
		# carp "pathNmodule_pm = $pathNmodule_pm";
		my $result = $pathNmodule_spec;
		return ($result);

	}
	else {
		carp "missing program name";
		return ();
	}

}

=head2 sub get_pathNmodule_spec_pm

=cut

sub get_pathNmodule_spec_pm {
	my ($self) = @_;

	if ( length $L_SU_global_constants->{_program_name} ) {

		my $program_name = $L_SU_global_constants->{_program_name};
		my $module_spec_pm = $program_name . '_spec.pm';		
		_set_file_name($module_spec_pm);
		
		my $path4spec = _get_path4spec_file();
		
		my $pathNmodule_spec_pm   = $path4spec . '/' . $module_spec_pm;
		# carp"pathNmodule_pm = $pathNmodule_pm";
		my $result = $pathNmodule_spec_pm;
		return ($result);

	}
	else {
		carp "missing program name";
		return ();
	}

}


sub help_menubutton_type_href {

	return ($help_menubutton_type_h);
}

=head2 sub get_pathNfile2search 

Useful directories to search

=cut

sub get_pathNfile2search {

	my ($self) = @_;

	if (    length $L_SU_global_constants->{_CHILD_DIR}
		and length $L_SU_global_constants->{_GRANDPARENT_DIR}
		and length $L_SU_global_constants->{_PARENT_DIR} )
	{

		my $CHILD_DIR       = $L_SU_global_constants->{_CHILD_DIR};
		my $GRANDPARENT_DIR = $L_SU_global_constants->{_GRANDPARENT_DIR};
		my $PARENT_DIR      = $L_SU_global_constants->{_PARENT_DIR};

=head2 Instantiate modules

=cut

		my $manage_dirs_by = manage_dirs_by->new();

=head2 Define

 variables
 
=cut	

		#		my @result_aref2;
		my @directory_contents;
		my @dimensions;

=head2 Define

 directory search arrays
 
=cut

		my @PARENT_DIR = @{ $L_SU_global_constants->{_PARENT_DIR} };
		my @CHILD_DIR  = @{ $L_SU_global_constants->{_CHILD_DIR} };

		my $parent_directory_number_of = scalar @PARENT_DIR;
		my $child_directory_number_of  = scalar @CHILD_DIR;

		@dimensions =
		  ( $parent_directory_number_of, $child_directory_number_of );

=head2 SU-related matters

=cut

		for (
			my $parent = 0 ;
			$parent < $parent_directory_number_of ;
			$parent++
		  )
		{

			for (
				my $child = 0 ;
				$child < $child_directory_number_of ;
				$child++
			  )
			{

				my $SEARCH_DIR =
					$GRANDPARENT_DIR . '/'
				  . $PARENT_DIR[$parent] . '/'
				  . $CHILD_DIR[$child];

#	  	  			print(
#	  	  "L_SU_global_constants, get_pathNfile2search,SEARCH_DIR=$SEARCH_DIR\n"
#	  	  			);
				$manage_dirs_by->set_directory($SEARCH_DIR);
				my $directory_list_aref = $manage_dirs_by->get_file_list_aref();
				my @directory_list      = @$directory_list_aref;
				my $files_number_of     = scalar @directory_list;
				my @pathNfile;

				for ( my $i = 0 ; $i < $files_number_of ; $i++ ) {

					$pathNfile[$i] = $SEARCH_DIR . '/' . $directory_list[$i];

				}

				$directory_contents[$parent][$child] = \@pathNfile;

#				print("L_SU_global_constants,get_pathNfile2search,dir contents:@{$directory_contents[$parent][$child]}\n");

			}
		}

		my $result_aref2 = \@directory_contents;

		return ( $result_aref2, \@dimensions );
	}
	else {
		print("get_pathNfile2search, missing variable(s)\n");
		print("CHILD_DIR=$L_SU_global_constants->{_CHILD_DIR}\n");
		print("GRANDPARENT_DIR=$L_SU_global_constants->{_GRANDPARENT_DIR}\n");
		print("PARENT_DIR=$L_SU_global_constants->{_PARENT_DIR}\n");
	}

}

=head2 sub _get_convert_pathNfile2search 

Useful directories to search when
converting old perl files to new perl
files (> 0.7)

=cut

sub _get_convert_pathNfile2search {

	my ($self) = @_;

=head2 import modules

=cut

	use Carp;

=head2 Instantiate modules

=cut

	my $manage_dirs_by = manage_dirs_by->new();

=head2 Define

 variables
 
=cut	

	my @result_aref2;
	my @directory_contents_convert;
	my @dimensions;

=head2 Define

 directory search arrays
 
=cut 

	my $GRANDPARENT_DIR = $path4SeismicUnixGui;

#	print ("L_SU_global_constants,_get_convert_pathNfile2search,SeismicUnixGui = $path4SeismicUnixGui\n");

	my @PARENT_DIR_CONVERT = @{ $L_SU_global_constants->{_PARENT_DIR_CONVERT} };
	my @CHILD_DIR_CONVERT  = @{ $L_SU_global_constants->{_CHILD_DIR_CONVERT} };

	#	print("L_SU_global_constants,PARENT_DIR_CONVERT=@PARENT_DIR_CONVERT\n");
	#	print("L_SU_global_constants,CHILD_DIR_CONVERT=@CHILD_DIR_CONVERT\n");

	my $parent_directory_convert_number_of = scalar @PARENT_DIR_CONVERT;
	my $child_directory_convert_number_of  = scalar @CHILD_DIR_CONVERT;

	@dimensions = (
		$parent_directory_convert_number_of,
		$child_directory_convert_number_of
	);

#	$parent_directory_convert_number_of = 2;
#	$child_directory_convert_number_of  = 2;

#		print("L_SU_global_constants,parent_directory_convert_number_of=$parent_directory_convert_number_of\n");
#	    print("L_SU_global_constants,child_directory_convert_number_of=$child_directory_convert_number_of\n");

=head2 CONVERT-related matters first

=cut

	for (
		my $parent = 0 ;
		$parent < $parent_directory_convert_number_of ;
		$parent++
	  )
	{

		for (
			my $child = 0 ;
			$child < $child_directory_convert_number_of ;
			$child++
		  )
		{

			my $SEARCH_DIR =
				$GRANDPARENT_DIR . '/'
			  . $PARENT_DIR_CONVERT[$parent] . '/'
			  . $CHILD_DIR_CONVERT[$child];

			$manage_dirs_by->set_directory($SEARCH_DIR);
			my $directory_list_aref = $manage_dirs_by->get_file_list_aref();

			if ( length $directory_list_aref ) {

				$directory_contents_convert[$parent][$child] =
				  $directory_list_aref;
#				  print("L_SU_global_constants,print search_dir = $SEARCH_DIR\n");
#				  print("L_SU_global_constants,directory_list_aref=@{$directory_list_aref}\n");


			}
			else {
#				print(
#"L_SU_global_constants, _get_convert_pathNfile2search,missing directory\n"
#				);
#				print("print search_dir = $SEARCH_DIR\n");
			}

		}

	}

#	my $parent_convert = 0;
#	my $child_convert  = 0;
#
#	print(
#"\nL_SU_global_constants, get_pathNfile2search, For convert directory paths: $PARENT_DIR_CONVERT[$parent_convert]::$CHILD_DIR_CONVERT[$child_convert]::\n"
#	);
#
#	print("@{$directory_contents_convert[$parent_convert][$child_convert]}\n");

	$result_aref2[0] = \@directory_contents_convert;

	return ( \@result_aref2, \@dimensions );

}

=head2 sub _get_specs_pathNfile2search 

Useful directories to search

=cut

sub _get_specs_pathNfile2search {

	my ($self) = @_;

=head2 Instantiate modules

=cut

	my $manage_dirs_by = manage_dirs_by->new();

=head2 Define

 variables
 
=cut	

	my @result_aref2;
	my @directory_contents_specs;
	my @dimensions;

=head2 Define

 directory search arrays
 
=cut 

	my $GRANDPARENT_DIR = $path4SeismicUnixGui;

	my @PARENT_DIR_SPECS = @{ $L_SU_global_constants->{_PARENT_DIR_SPECS} };
	my @CHILD_DIR_SPECS  = @{ $L_SU_global_constants->{_CHILD_DIR_SPECS} };

	my $parent_directory_specs_number_of = scalar @PARENT_DIR_SPECS;
	my $child_directory_specs_number_of  = scalar @CHILD_DIR_SPECS;

	@dimensions =
	  ( $parent_directory_specs_number_of, $child_directory_specs_number_of );

#	print(
#		"L_SU_global_constants,$parent_directory_specs_number_of, $child_directory_specs_number_of\n"
#	);

=head2 SPECS-related matters

=cut

	for (
		my $parent = 0 ;
		$parent < $parent_directory_specs_number_of ;
		$parent++
	  )
	{

		for (
			my $child = 0 ;
			$child < $child_directory_specs_number_of ;
			$child++
		  )
		{

			my $SEARCH_DIR =
				$GRANDPARENT_DIR . '/'
			  . $PARENT_DIR_SPECS[$parent] . '/'
			  . $CHILD_DIR_SPECS[$child];

#  			print(
#  "L_SU_global_constants, _get_specs_pathNfile2search,SEARCH_DIR=$SEARCH_DIR\n"
#  			);
			$manage_dirs_by->set_directory($SEARCH_DIR);
			my $directory_list_aref = $manage_dirs_by->get_file_list_aref();
			my @directory_list      = @$directory_list_aref;

			$directory_contents_specs[$parent][$child] = $directory_list_aref;

			#			print("@{$directory_contents_specs[$parent][$child]}\n");

		}

	}

#	my $parent_specs = 1;
#	my $child_specs  = 1;
#	print(
#"\nL_SU_global_constants, get_pathNfile2search, For specs directory paths: $PARENT_DIR_GUI[$parent_specs]::$CHILD_DIR_GUI[$child_gui]::\n"
#	);
#	print("@{$directory_contents_specs[$parent_specs][$child_specs]}\n");

	$result_aref2[0] = \@directory_contents_specs;

	return ( \@result_aref2, \@dimensions );

}

=head2 sub _get_tools_pathNfile2search 

Useful directories to search

=cut

sub _get_tools_pathNfile2search {

	my ($self) = @_;

=head2 Instantiate modules

=cut

	my $manage_dirs_by = manage_dirs_by->new();

=head2 Define

 variables
 
=cut	

	my @result_aref2;
	my @directory_contents_tools;
	my @dimensions;

=head2 Define

 directory search arrays
 
=cut 

	my $GRANDPARENT_DIR = $path4SeismicUnixGui;

	#	my @PARENT_DIR_GUI = @{ $L_SU_global_constants->{_PARENT_DIR_GUI} };
	#	my @CHILD_DIR_GUI  = @{ $L_SU_global_constants->{_CHILD_DIR_GUI} };
	my @PARENT_DIR_TOOLS = @{ $L_SU_global_constants->{_PARENT_DIR_TOOLS} };
	my @CHILD_DIR_TOOLS  = @{ $L_SU_global_constants->{_CHILD_DIR_TOOLS} };

	#	my @PARENT_DIR_SU  = @{ $L_SU_global_constants->{_PARENT_DIR_SU} };
	#	my @CHILD_DIR_SU   = @{ $L_SU_global_constants->{_CHILD_DIR_SU} };
	#	my @PARENT_DIR_GEN = @{ $L_SU_global_constants->{_PARENT_DIR_GEN} };

	#	print("PARENT_DIR_GUI=@PARENT_DIR_GUI\n");

	#	my $parent_directory_gui_number_of = scalar @PARENT_DIR_GUI;
	#	my $child_directory_gui_number_of  = scalar @CHILD_DIR_GUI;
	my $parent_directory_tools_number_of = scalar @PARENT_DIR_TOOLS;
	my $child_directory_tools_number_of  = scalar @CHILD_DIR_TOOLS;

	#	my $parent_directory_su_number_of  = scalar @PARENT_DIR_SU;
	#	my $child_directory_su_number_of   = scalar @CHILD_DIR_SU;
	#	my $parent_directory_gen_number_of = scalar @PARENT_DIR_GEN;

	@dimensions =
	  ( $parent_directory_tools_number_of, $child_directory_tools_number_of );

	#	$parent_directory_su_number_of, $child_directory_su_number_of,
	#	  $parent_directory_gen_number_of $parent_directory_gui_number_of,
	#	  $child_directory_gui_number_of,

=head2 TOOLS-related matters first

=cut

	for (
		my $parent = 0 ;
		$parent < $parent_directory_tools_number_of ;
		$parent++
	  )
	{

		for (
			my $child = 0 ;
			$child < $child_directory_tools_number_of ;
			$child++
		  )
		{

			my $SEARCH_DIR =
				$GRANDPARENT_DIR . '/'
			  . $PARENT_DIR_TOOLS[$parent] . '/'
			  . $CHILD_DIR_TOOLS[$child];

#  			print(
#  "L_SU_global_constants, _get_tools_pathNfile2search,SEARCH_DIR=$SEARCH_DIR\n"
#  			);
			$manage_dirs_by->set_directory($SEARCH_DIR);
			my $directory_list_aref = $manage_dirs_by->get_file_list_aref();
			my @directory_list      = @$directory_list_aref;

			$directory_contents_tools[$parent][$child] = $directory_list_aref;

			#			print("@{$directory_contents_TOOLS[$parent][$child]}\n");

		}

	}

#	my $parent_TOOLS = 1;
#	my $child_TOOLS  = 1;
#	print(
#"\nL_SU_global_constants, get_tools_pathNfile2search, For TOOLS directory paths: $PARENT_DIR_TOOLS[$parent_TOOLS]::$CHILD_DIR_TOOLS[$child_tools]::\n"
#	);
#	print("@{$directory_contents_tools[$parent_tools][$child_tools]}\n");

	$result_aref2[0] = \@directory_contents_tools;

	return ( \@result_aref2, \@dimensions );

}

=head2 Find a path for

a given perl file
generated by the convert

=cut

sub get_path4convert_file {

	my (@self) = @_;

	if ( length $L_SU_global_constants->{_file_name} ) {

		my $file_name = $L_SU_global_constants->{_file_name};
		my $result;

=head2 Collect parameters from local hash

=cut

		my $GRANDPARENT_DIR = $path4SeismicUnixGui;
		my @PARENT_DIR_CONVERT =
		  @{ $L_SU_global_constants->{_PARENT_DIR_CONVERT} };
		my @CHILD_DIR_CONVERT =
		  @{ $L_SU_global_constants->{_CHILD_DIR_CONVERT} };

=head2 Collect relevant "convert"

 project paths and files

=cut

		my ( $result_aref3, $dimensions_aref ) =
		  _get_convert_pathNfile2search();
		my @result_aref2                       = @$result_aref3;
		my @directory_contents_convert         = @{ $result_aref2[0] };
		my @dimension                          = @$dimensions_aref;
		my $parent_directory_convert_number_of = $dimension[0];
		my $child_directory_convert_number_of  = $dimension[1];

# test
#		my $parent_convert = 0;
#		my $child_convert  = 0;
#		print(
#"\nL_SU_global_constants,get_path4convert_file, For convert directory paths: App::SeismicUnixGui::$PARENT_DIR_CONVERT[$parent_convert]::$CHILD_DIR_CONVERT[$child_convert]\n"
#		);
#		print(
#			"_SU_global_constants,get_path4convert_file,@{$directory_contents_convert[$parent_convert][$child_convert]}\n"
#		);

=head2 Search all "convert"-relevant 

directories start with 
convert derectory listing

=cut

		for (
			my $parent = 0 ;
			$parent < $parent_directory_convert_number_of ;
			$parent++
		  )
		{

			for (
				my $child = 0 ;
				$child < $child_directory_convert_number_of ;
				$child++
			  )
			{

				my $directory_list_aref =
				  $directory_contents_convert[$parent][$child];

				if ( length $directory_list_aref ) {

					my @directory_list        = @$directory_list_aref;
					my $length_directory_list = scalar @directory_list;

#					print(
#"L_SU_global_contents,@{$directory_contents_convert[$parent][$child]}\n"
#					);
#					print("L_SU_global_contents,file_name=$file_name\n");

					for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {

	#						print("L_SU_global_constants, directory list=$directory_list[$i]\n");
						;
						if ( not $file_name eq $directory_list[$i] ) {

							next;

						}
						elsif ( $file_name eq $directory_list[$i] ) {

#							print(
#"L_SU_global_constants,get_path4convert_file,found the file $file_name in
#	   					$PARENT_DIR_CONVERT[$parent]::$CHILD_DIR_CONVERT[$child]\n"
#							);
							$result =
								$path4SeismicUnixGui . '/'
							  . $PARENT_DIR_CONVERT[$parent] . '/'
							  . $CHILD_DIR_CONVERT[$child];

							return ($result);
						}
						else {
							print("change_a_line, unexpected value\n");
							return ();
						}
					}

				}
				else {
#					print(
#						"L_SU_global_constants, get_path4convert_file, missing directory; NADA\n"
#					);
				}

			}
		}

	}
	else {
		print(
			"L_SU_global_constants,_get_path_4convert_file,file_name_missing\n"
		);
		return ();
	}
}

=head2 sub get_path4spec_file

Find a path for

a given spec file

=cut

sub get_path4spec_file {

	my (@self) = @_;

	if ( length $L_SU_global_constants->{_file_name} ) {

		my $file_name = $L_SU_global_constants->{_file_name};
		my $result;

=head2 Collect parameters from local hash

=cut

		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
		my @PARENT_DIR_SPECS = @{ $L_SU_global_constants->{_PARENT_DIR_SPECS} };
		my @CHILD_DIR_SPECS  = @{ $L_SU_global_constants->{_CHILD_DIR_SPECS} };

=head2 Collect relevant "spec"

 project paths and files

=cut

		my ( $result_aref3, $dimensions_aref ) = _get_specs_pathNfile2search();
		my @result_aref2                     = @$result_aref3;
		my @directory_contents_specs         = @{ $result_aref2[0] };
		my @dimension                        = @$dimensions_aref;
		my $parent_directory_specs_number_of = $dimension[0];
		my $child_directory_specs_number_of  = $dimension[1];

# test
#		my $parent_specs = 1;
#		my $child_specs  = 1;
#		print(
#"\nFor specs directory paths: $PARENT_DIR_SPECS[$parent_specs]::$CHILD_DIR_SPECS[$child_specs]::\n"
#		);
#		print("@{$directory_contents_specs[$parent_specs][$child_specs]}\n");

=head2 Search all "spec"-relevant 

directories start with 
gui drectory listing

=cut

		for (
			my $parent = 0 ;
			$parent < $parent_directory_specs_number_of ;
			$parent++
		  )
		{

			for (
				my $child = 0 ;
				$child < $child_directory_specs_number_of ;
				$child++
			  )
			{

				my $directory_list_aref =
				  $directory_contents_specs[$parent][$child];
				my @directory_list = @$directory_list_aref;

				my $length_directory_list = scalar @directory_list;

				#				print("@{$directory_contents_specs[$parent][$child]}\n");
				#				print("file_name=$file_name\n");
				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {

					if ( not $file_name eq $directory_list[$i] ) {

						next;

					}
					elsif ( $file_name eq $directory_list[$i] ) {

		 #						print(
		 #"L_SU_global_constants,get_path4spec_file,found the file $file_name in
		 #				  			  $PARENT_DIR_SPECS[$parent]::$CHILD_DIR_SPECS[$child]\n"
		 #						);
						$result =
							$path4SeismicUnixGui . '/'
						  . $PARENT_DIR_SPECS[$parent] . '/'
						  . $CHILD_DIR_SPECS[$child];

						return ($result);
					}
					else {
						print("change_a_line, unexpected value\n");
						return ();
					}
				}

			}
		}

	}
	else {
		print("L_SU_global_constants,_get_path4spec_file,file_name_missing\n");
		return ();
	}
}

=head2 Find a path for

a given tools file
You need to pre-determine
you have a "Tools" file

=cut

sub get_path4tools_file {

	my (@self) = @_;

	if ( length $L_SU_global_constants->{_file_name} ) {

		my $file_name = $L_SU_global_constants->{_file_name};
		my $result;

=head2 Collect parameters from local hash

=cut

		my $GRANDPARENT_DIR  = $path4SeismicUnixGui;
		my @PARENT_DIR_TOOLS = @{ $L_SU_global_constants->{_PARENT_DIR_TOOLS} };
		my @CHILD_DIR_TOOLS  = @{ $L_SU_global_constants->{_CHILD_DIR_TOOLS} };

=head2 Collect relevant "tools"

 project paths and files

=cut

		my ( $result_aref3, $dimensions_aref ) = _get_tools_pathNfile2search();
		my @result_aref2                     = @$result_aref3;
		my @directory_contents_tools         = @{ $result_aref2[0] };
		my @dimension                        = @$dimensions_aref;
		my $parent_directory_tools_number_of = $dimension[0];
		my $child_directory_tools_number_of  = $dimension[1];

# test
#		my $parent_tools = 1;
#		my $child_tools  = 1;
#		print(
#"\nFor tools directory paths: $PARENT_DIR_TOOLS[$parent_tools]::$CHILD_DIR_TOOLS[$child_tools]::\n"
#		);
#		print("@{$directory_contents_tools[$parent_tools][$child_tools]}\n");

=head2 Search all "spec"-relevant 

directories start with 
gui drectory listing

=cut

		for (
			my $parent = 0 ;
			$parent < $parent_directory_tools_number_of ;
			$parent++
		  )
		{

			for (
				my $child = 0 ;
				$child < $child_directory_tools_number_of ;
				$child++
			  )
			{

				my $directory_list_aref =
				  $directory_contents_tools[$parent][$child];
				my @directory_list = @$directory_list_aref;

				my $length_directory_list = scalar @directory_list;

				#				print("@{$directory_contents_tools[$parent][$child]}\n");
				#				print("file_name=$file_name\n");
				for ( my $i = 0 ; $i < $length_directory_list ; $i++ ) {

					if ( not $file_name eq $directory_list[$i] ) {

						next;

					}
					elsif ( $file_name eq $directory_list[$i] ) {

		#						print(
		#"L_SU_global_constants,get_path4tools_file,found the file $file_name in
		#				  			  $PARENT_DIR_TOOLS[$parent]::$CHILD_DIR_TOOLS[$child]\n"
		#						);
						$result =
							$path4SeismicUnixGui . '/'
						  . $PARENT_DIR_TOOLS[$parent] . '/'
						  . $CHILD_DIR_TOOLS[$child];

						return ($result);
					}
					else {
						print("change_a_line, unexpected value\n");
						return ();
					}
				}

			}
		}

	}
	else {
		print("L_SU_global_constants,_get_path4tools_file,file_name_missing\n");
		return ();
	}
}

sub number_from_color_href {

	my ($self) = @_;
	return ($number_from_color);

}

sub alias_superflow_config_names_aref {
	return ( \@alias_superflow_config_names );
}

sub set_file_name {

	my ( $self, $file_name ) = @_;

	if ( length $file_name ) {

		$L_SU_global_constants->{_file_name} = $file_name;

#		print("L_SU_global_constants,set_file_name,set_file_name = $L_SU_global_constants->{_file_name}\n");

	}
	else {
		print("L_SU_global_constants,set_file_name,missing variable");
	}

}

=head2 sub set_CHILD_DIR_type

=cut

sub set_CHILD_DIR_type {

	my ( $self, $type ) = @_;

	if ( length $type ) {

		my $CHILD_DIR = '_CHILD_DIR_' . $type;
		$L_SU_global_constants->{_CHILD_DIR} =
		  $L_SU_global_constants->{$CHILD_DIR};

#		print("L_SU_global_constants,set_CHILD_DIR,set_CHILD_DIR_type = $L_SU_global_constants->{_CHILD_DIR}\n");

	}
	else {
		print(
"L_SU_global_constants,set_CHILD_DIR_type, type=$type is missing variable"
		);
	}

}

=head2 sub set_GRANDPARENT_DIR

=cut

sub set_GRANDPARENT_DIR {

	my ( $self, $GRANDPARENT_DIR ) = @_;

	if ( length $GRANDPARENT_DIR ) {

		$L_SU_global_constants->{_GRANDPARENT_DIR} = $GRANDPARENT_DIR;

#		print("L_SU_global_constants,set_GRANDPARENT_DIR,set_GRANDPARENT_DIR = $L_SU_global_constants->{_GRANDPARENT_DIR}\n");

	}
	else {
		print("L_SU_global_constants,set_GRANDPARENT_DIR,missing variable");
	}

}

=head2 sub set_PARENT_DIR_type

=cut

sub set_PARENT_DIR_type {

	my ( $self, $type ) = @_;

	if ( length $type ) {

		my $PARENT_DIR = '_PARENT_DIR_' . $type;
		$L_SU_global_constants->{_PARENT_DIR} =
		  $L_SU_global_constants->{$PARENT_DIR};

#		print("L_SU_global_constants,set_PARENT_DIR,set_PARENT_DIR_type = $L_SU_global_constants->{_PARENT_DIR}\n");

	}
	else {
		print(
"L_SU_global_constants,set_PARENT_DIR_type, type=$type is missing variable"
		);
	}

}

=head2 sub set_program_name

=cut

sub set_program_name {

	my ( $self, $program_name ) = @_;

	if ( length $program_name ) {

		$L_SU_global_constants->{_program_name} = $program_name;

	}
	else {
		carp "missing program_name";
		print("L_SU_global_constants,set_program_name,missing program_name\n");
	}

}


sub superflow_config_names_aref {
	return ( \@superflow_config_names );
}

sub superflow_names_aref {
	return ( \@superflow_names );
}

sub superflow_names_gui_aref {

	return ( \@superflow_names_gui );

}

sub global_libs {
	my (@self) = @_;

	# empty string is predefined herein
	if ( length $L_SU ) {

		#		print("L_SU_global_constants my L_SU = $L_SU\n");

		my $global_libs = {
			_configs             => $L_SU . '/configs',
			_configs_big_streams => $L_SU . '/configs/big_streams',
			_developer           => $L_SU . '/developer/Stripped',
			_misc                => $L_SU . '/misc',
			_param               => $L_SU . '/configs/',
			_specs               => $L_SU . '/specs',
			_sunix               => $L_SU . '/sunix',
			_superflows          => $L_SU . '/big_streams/',
			_images              => $L_SU . '/images/',
			_default_path        => './',
		};

		return ($global_libs);

	}
	else {
		print("L_SU_global_constants, global_libs, L_SU is missing\n");
		return ();
	}

}

sub purpose {
	return ($purpose);
}

sub superflow_names_h {
	return ($superflow_names_h);
}

sub var {
	my ($self) = @_;

	#	print "got to var\n";
	return ($var);
}

sub param {
	return ($param);
}

1;
