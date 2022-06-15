package L_SU_global_constants;

use Moose;

=head2 Default Tk settings 

 _first_entry_num is normally 1
 _max_entry_num is defaulted to 

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
$alias_superflow_config_names[13] = 'temp';                           # make last

# for the visible buttons in the GUI only
# e.g., Path and PL_SEISMIC are not visible to the user
# but Data Flow and SaveAs are.
my @alias_FileDialog_button_label;
$alias_FileDialog_button_label[0] = 'Data';
$alias_FileDialog_button_label[1] = 'Flow';
$alias_FileDialog_button_label[2] = 'SaveAs';

my @file_dialog_type;

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

my $purpose = { _geopsy => 'geopsy', };

my $var = {
	_1_character                   => '1',
	_14_characters                 => '14',
	_13_characters                 => '13',
	_12_characters                 => '12',
	_11_characters                 => '11',
	_2_characters                  => '2',
	_3_characters                  => '3',
	_4_characters                  => '4',
	_5_characters                  => '5',
	_6_characters                  => '6',
	_7_characters                  => '7',
	_8_characters                  => '8',
	_10_characters                 => '10',
	_15_characters                 => '15',
	_20_characters                 => '20',
	_30_characters                 => '30',
	_32_characters                 => '32',
	_35_characters                 => '35',
	_40_characters                 => '40',
	_45_characters                 => '45',
	_base_file_name                => 'base_file_name',
	_clear_text                    => '',
	_color_default                 => 'grey',  # first color listbox to select
	_config_file_format            => '%-35s%1s%-20s',
	_eight_characters              => '8',
	_empty_string                  => '',
	_failure                       => -1,
	_false                         => 0,
	_data_name                     => 'data_name',
	_base_file_name                => 'base_file_name',
	_five_pixels                   => '5',
	_five_pixel_borderwidth        => 5,
	_five_lines                    => '5',
	_1_line                        => '1',
	_2_lines                       => '2',
	_3_lines                       => '3',
	_4_lines                       => '4',
	_8_lines                       => '8',
	_7_lines                       => '7',
	_1_pixel                       => '1',
	_3_pixels                      => '3',
	_6_pixels                      => '6',
	_24_pixels                     => '24',
	_12_pixels                     => '12',
	_18_pixels                     => '18',
	_NaN                           => 'NaN',
	_five_characters               => '5',
	_flow                          => 'frame',
	_half_tiny_width               => '6',
	_hundred_characters            => '100',
	_large__width                  => '200',
	_light_gray                    => 'gray90',
	_literal_empty_string          => '\'\'',
	_l_suplot_box_positionNsize    => '600x800+1000+1000',
	_l_suplot_width                => '500',
	_l_suplot_height               => '300',
	_log_file_txt                  => 'log.txt',
	_main_window_geometry          => '1100x750+12+5',
	_medium_width                  => '100',
	_message_box_geometry          => '400x250+400+400',
	_ms2s						   => 0.001,
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
	_program_title                 => 'LSeismicUnix V0.6.6',
	_l_suplot_title                => 'L_suplot',
	_project_selector_title        => 'Project Selector',
	_project_selector_box_position => '600x600+100+100',
	_null_sunix_value              => '',
	_reservation_color_default     => 'grey',            # first choice for reserving a color listbox
	_superflow                     => 'menubutton',
	_small_width                   => '50',
	_string2startFlowSetUp         => '->clear\(\);',    # for regex in perl_flow
	_string2endFlowSetUp           => '->Step\(\);',     # for regex in perl_flow
	_standard_width                => '20',
	_ten_characters                => '10',
	_test_dir_name                 => 't',
	_eleven_characters             => '11',
	_five_characters               => '5',
	_thirty_characters             => '30',
	_18_characters                 => '18',
	_thirty_five_characters        => '35',
	_tiny_width                    => '12',
	_true                          => 1,
	_us_per_s                      => 1000000,
	_twenty_characters             => '20',
	_us2s						   => 0.000001,
	_username                      => 'tester',
	_very_small_width              => '25',
	_very_large_width              => '500',
	_yes                           => 'yes',
	_white                         => 'white',

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

my $L_SU = $ENV{'L_SU'};
my $global_libs;

# empty string is predefined herein
if ( $L_SU ne $var->{_empty_string} ) {

	$global_libs = {
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

} else {
	print("L_SU_global_constants, L_SU is missing\n");
}

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
	"ctrlstrip",
	"data_in",
	"data_out",
	"dt1tosu",
	"segbread",
	"segdread",
	"segyread",
	"segyscan",
	"segywrite",
	"suoldtonew",
	"supack1",
	"supack2",
	"suswapbytes",
	"suunpack1",
	"suunpack2",
	"wpc1uncomp2",
	"wpccompress",
	"wpcuncompress",
	"wptcomp",
	"wptuncomp",
	"wtcomp",
	"wtuncomp",
);

my @sunix_datum_programs = ( 
	"sudatumk2dr",
	"sudatumk2ds",
	"sukdmdcr",
	"sukdmdcs",
 );

my @sunix_filter_programs = (
	"subfilt",
	"succfilt",
	"sucddecon",
	"sudipfilt",
	"sueipofi",
	"sufilter",
	"sufrac",
	"sufwatrim",
	"sufxdecon",
	"suk1k2filter",
	"sukfilter",
	"sukfrac",
	"sulfaf",
	"sumedian",
	"supef",
	"suphase",
	"suphidecon",
	"supofilt",
	"supolar",
	"sushape",
	"susmgauss2",
	"sutvband",
);

my @sunix_header_programs = (
	"segyclean",
	"segyhdrmod",
	"segyhdrs",
	"setbhed",
	"su3dchart",
	"suabshw",
	"suaddhead",
	"suaddstatics",
	"suahw",
	"suascii",
	"suazimuth",
	"sucdpbin",
	"suchart",
	"suchw",
	"sucliphead",
	"sucommand",
	"sucountkey",
	"sudumptrace",
	"suedit",
	"sugethw",
	"suhtmath",
	"sukeycount",
	"sulcthw",
	"sulhead",
	"supaste",
	"surandhw",
	"surange",
	"suresstat",
	"susehw",
	"sushw",
	"sustatic",
	"sustaticB",
	"sustaticrrs",
	"sustrip",
	"sutrcount",
	"suutm",
	"suxedit",
	"swapbhed",
);

my @sunix_inversion_programs = (
	"suinvco3d",
	"suinvvxzco",
	"suinvzco3d",
);

my @sunix_migration_programs = (
	"sudatumfd",
	"sugazmig",
	"sukdmig2d",
	"suktmig2d",
	"sumigfd",
	"sumigffd",
	"sumiggbzo",
	"sumiggbzoan",
	"sumigprefd",
	"sumigpreffd",
	"sumigprepspi",
	"sumigpresp",
	"sumigpspi",
	"sumigpsti",
	"sumigsplit",
	"sumigtk",
	"sumigtopo2d",
	"sustolt",
	"sutifowler",
 );
 
my @sunix_shell_programs     = ( 
	"catsu",
	"evince",
	"sugetgthr",
	"suputgthr",
);

=pod


=cut

my @sunix_model_programs = (
	"addrvl3d",
	"cellauto",
	"elacheck",
	"elamodel",
	"elaray",
	"elasyn",
	"elatriuni",
	"gbbeam",
	"grm",
	"normray",
	"randvel3d",
	"raydata",
	"rayt2d",
	"rayt2dan",
	"regrid3",
	"resamp",
	"smooth2",
	"smooth3d",
	"smoothint2",
	"stiff2vel",
	"suaddevent",
	"suaddnoise",
	"sudgwaveform",
	"suea2df",
	"sufctanismod",
	"sufdmod1",
	"sufdmod2",
	"sufdmod2_pml",
	"sugoupillaud",
	"sugoupillaudpo",
	"suimp2d",
	"suimp3d",
	"suimpedance",
	"sujitter",
	"sukdsyn2d",
	"sunull",
	"suplane",
	"surandspike",
	"surandstat",
	"suremac2d",
	"suremel2dan",
	"suspike",
	"susyncz",
	"susynlv",
	"susynlvcw",
	"susynlvfti",
	"susynvxz",
	"susynvxzcs",
	"sutetraray",
	"suvibro",
	"suwaveform",
	"sxplot",
	"tetramod",
	"thom2hti",
	"thom2stiff",
	"tri2uni",
	"trimodel",
	"trip",
	"triray",
	"triseis",
	"uni2tri",
	"unif2",
	"unif2aniso",
	"unif2ti2",
	"vel2stiff",
	"wkbj",
);

my @sunix_NMO_Vel_Stk_programs = ( 
	"dzdv",
	"sucvs4fowler",
	"sudivstack",
	"sudmofk",
	"sudmofkcw",
	"sudmotivz",
	"sudmotx",
	"sudmovz",
	"suilog",
	"suintvel",
	"sulog",
	"sunmo",
	"sunmo_a",
	"supws",
	"surecip",
	"sureduce",
	"surelan",
	"surelanan",
	"suresamp",
	"sushift",
	"sustack",
	"sustkvel",
	"sutaupnmo",
	"sutihaledmo",
	"sutivel",
	"sutsq",
	"suttoz",
	"suvel2df",
	"suvelan",
	"suvelan_nccs",
	"suvelan_nsel",
	"suztot",
	"tvnmoqc",
  );

my @sunix_par_programs = (
	"a2b",
	"a2i",
	"b2a",
	"bhedtopar",
	"cshotplot",
	"float2ibm",
	"ftnstrip",
	"ftnunstrip",
	"h2b",
	"hti2stiff",
	"hudson",
	"i2a",
	"ibm2float",
	"kaperture",
	"linrort",
	"lorenz",
	"makevel",
	"mkparfile",
	"mrafxzwt",
	"pdfhistogram",
	"prplot",
	"recast",
	"refRealAziHTI",
	"refRealVTI",
	"rossler",
	"subset",
	"transp",
	"transp3d",
	"unisam",
	"unisam2",
	"utmconv",
	"velpert",
	"verhulst",
	"vtlvz",
	"xy2z",
	"z2xyz",
);

my @sunix_picks_programs = (
	"",
	"sufbpickw",
	"sufnzero",
	"supickamp",
);

my @sunix_plot_programs = (
	"elaps",
	"lcmap",
	"lprop",
	"psbbox",
	"pscontour",
	"pscube",
	"pscubecontour",
	"psepsi",
	"psgraph",
	"psimage",
	"pslabel",
	"psmanager",
	"psmerge",
	"psmovie",
	"pswigb",
	"pswigp",
	"scmap",
	"spsplot",
	"supscontour",
	"supscube",
	"supscubecontour",
	"supsgraph",
	"supsimage",
	"supsmax",
	"supsmovie",
	"supswigb",
	"supswigp",
	"suxcontour",
	"suxgraph",
	"suximage",
	"suxmax",
	"suxmovie",
	"suxpicker",
	"suxwigb",
	"viewer3",
	"xcontour",
	"xepsb",
	"xepsp",
	"xgraph",
	"ximage",
	"xmovie",
	"xpicker",
	"xpsp",
	"xwigb",
);

my @sunix_shapeNcut_programs = (
	"sucentsamp",
	"sudipdivcor",
	"suflip",
	"sugain",
	"sugausstaper",
	"sugprfb",
	"sukill",
	"sumute",
	"supad",
	"supgc",
	"suramp",
	"susort",
	"susorty",
	"susplit",
	"sutxtaper",
	"suvcat",
	"suvlength",
	"suwind",
	"suwindpoly",
	"suzero",
);

my @sunix_statsMath_programs = (
	"cpftrend",
	"entropy",
	"farith",
	"suacor",
	"suacorfrac",
	"sualford",
	"suattributes",
	"suconv",
	"sufwmix",
	"suharlan",
	"suhistogram",
	"suhrot",
	"suinterp",
	"suinterpfowler",
	"sultt",
	"sumath",
	"sumax",
	"sumean",
	"sumix",
	"sumixgathers",
	"sunan",
	"sunormalize",
	"suocext",
	"suop",
	"suop2",
	"supermute",
	"suquantile",
	"surefcon",
	"sutaper",
	"suweight",
	"suxcor",
	"suxmax",
);

my @sunix_transform_programs = (
	"dctcomp",
	"dctuncomp",
	"suamp",
	"suanalytic",
	"succepstrum",
	"succwt",
	"sucepstrum",
	"suclogfft",
	"sucwt",
	"sufft",
	"sugabor",
	"suhilb",
	"suicepstrum",
	"suiclogfft",
	"suifft",
	"suminphase",
	"suphasevel",
	"suradon",
	"suspecfk",
	"suspecfx",
	"sutaup",
);

my @sunix_well_programs = (
	"las2su",
	"subackus",
	"subackush",
	"sugassman",
	"sulprime",
	"suwellrf",
 );

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

sub alias_superflow_names_h {
	my ($self) = @_;
	return ($alias_superflow_names_h);
}

sub alias_FileDialog_button_label_aref {    # array ref
											#my 	$self = @_;
	return ( \@alias_FileDialog_button_label );
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

sub number_from_color_href {

	my ($self) = @_;
	return ($number_from_color);

}

sub alias_superflow_config_names_aref {
	return ( \@alias_superflow_config_names );
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
	return ($global_libs);
}

sub purpose {
	return ($purpose);
}

sub superflow_names_h {
	return ($superflow_names_h);
}

sub var {
	return ($var);
}

sub param {
	return ($param);
}

1;



































































































































































































































































































