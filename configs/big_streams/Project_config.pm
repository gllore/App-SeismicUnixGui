package Project_config;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

	NAME:     Project_config 
	Author:   Juan M. Lorenzo 
	Date:     December 31, 2017 
	Purpose:  Helps create Project Directores  
 		      Helps establish system-wide and local directories

=head2 NEEDS

 System_Variables package
 manage_dirs_by package

=cutprint *, 'Project_config, HOME:',HOME

=head2 CHANGES and their DATES

 V. 1.0.2 May 3, 2018  Project.config also exists in
 ~/home/user/.LSU/configuration/Project_name/Project/Project.config
 
 Feb 11, 2019 removed automatic creation of ~segy/raw directory

=head2 Declare variables in namespace

 
=cut

use Moose;
our $VERSION = '1.0.2';

use manage_dirs_by;
use control;
use readfiles;
use L_SU_global_constants;
my $read              = new readfiles;
my $control           = control->new;
my $get               = new L_SU_global_constants();
my $global_lib        = $get->global_libs();
my $GLOBAL_CONFIG_LIB = $global_lib->{_configs_big_streams};

my $Project = {
	_ref_DIR                      => '',
	_ref_DIR_FUNCTION             => '',
	_HOME                         => '',
	_date                         => '',
	_geomaps_is_selected          => '',
	_geopsy_is_selected           => '',
	_gmt_is_selected              => '',
	_grass__is_selected           => '',
	_matlab_is_selected           => '',
	_immodpg_is_selected          => '',
	_sqlite_is_selected           => '',
	_line                         => '',
	_component                    => '',
	_stage                        => '',
	_process                      => '',
	_PROJECT_HOME                 => '',
	_subUser                      => '',
	_ANTELOPE                     => '',
	_DATA_GEOMAPS                 => '',
	_DATA_GEOMAPS_BIN             => '',
	_DATA_GEOMAPS_TEXT            => '',
	_DATA_GEOMAPS_TOPO            => '',
	_GEOMAPS_IMAGES               => '',
	_GEOMAPS_IMAGES_JPEG          => '',
	_GEOMAPS_IMAGES_TIF           => '',
	_GEOMAPS_IMAGES_PS            => '',
	_PROJECT_HOME                 => '',
	_DATA_GAMMA_WELL              => '',
	_DATA_GAMMA_WELL_TXT          => '',
	_DATA_RESISTIVITY_SURFACE     => '',
	_DATA_RESISTIVITY_SURFACE_TXT => '',
	_DATA_RESISTIVITY_WELL        => '',
	_DATA_RESISTIVITY_WELL_TXT    => '',
	_GMT_SEISMIC                  => '',
	_GMT_GEOMAPS                  => '',
	_GRASS_GEOMAPS                => '',
	_DATA_SEISMIC                 => '',
	_DATA_SEISMIC_BIN             => '',
	_DATA_SEISMIC_DAT             => '',
	_DATA_SEISMIC_ININT           => '',
	_DATA_SEISMIC_MATLAB          => '',
	_DATA_SEISMIC_PASSCAL_SEGY    => '',
	_DATA_SEISMIC_R               => '',
	_DATA_SEISMIC_RSEIS           => '',
	_DATA_SEISMIC_SAC             => '',
	_DATA_SEISMIC_SEG2            => '',
	_DATA_SEISMIC_SEGD            => '',
	_DATA_SEISMIC_SEGY            => '',
	_DATA_SEISMIC_SEGY_RAW        => '',
	_DATA_SEISMIC_SIERRA_SEGY     => '',
	_DATA_SEISMIC_SU              => '',
	_DATA_SEISMIC_SU_RAW          => '',
	_DATA_SEISMIC_TXT             => '',
	_DATA_SEISMIC_VEL             => '',
	_DATA_SEISMIC_WELL            => '',
	_DATABASE_SEISMIC_SQLITE      => '',
	_DATA_SEISMIC_WELL_SYNSEIS    => '',
	_DATA_WELL                    => '',
	_FAST_TOMO                    => '',
	_GEOPSY                       => '',
	_GEOPSY_PARAMS                => '',
	_GEOPSY_PICKS                 => '',
	_GEOPSY_PICKS_RAW             => '',
	_GEOPSY_PROFILES              => '',
	_GEOPSY_REPORTS               => '',
	_GEOPSY_TARGETS               => '',
	_GIF_SEISMIC                  => '',
	_ISOLA                        => '',
	_JPEG                         => '',
	_C_SEISMIC                    => '',
	_CPP_SEISMIC                  => '',
	_MATLAB_GEOMAPS               => '',
	_MATLAB_WELL                  => '',
	_MATLAB_SEISMIC               => '',
	_IMMODPG                      => '',
	_IMMODPG_INVISIBLE            => '',
	_MMODPG									=>'',
	_MOD2D_TOMO                   => '',
	_PL_SEISMIC                   => '',
	_PL_GEOMAPS                   => '',
	_PL_WELL                      => '',
	_RESISTIVITY_SURFACE          => '',
	_R_GAMMA_WELL                 => '',
	_R_RESISTIVITY_SURFACE        => '',
	_R_RESISTIVITY_WELL_R_SEISMIC => '',
	_R_WELL                       => '',
	_SH_SEISMIC                   => '',
	_PS_SEISMIC                   => '',
	_PS_WELL                      => '',
	_RAYINVR                      => '',
	_SQLITE                       => '',
	_SURFACE                      => '',
	_TEMP_DATA_GEOMAPS            => '',
	_TEMP_DATA_SEISMIC            => '',
	_TEMP_DATA_SEISMIC_SU         => '',
	_TEMP_FAST_TOMO               => '',
	_WELL                         => '',
};

=head2 definitions

=cut

sub _get_home {
	my ($self) = @_;
	my $home_directory;

	use Shell qw(echo);

	$home_directory = ` echo \$HOME`;
	chomp $home_directory;

	my $HOME = $home_directory;

	return ($HOME);

}

=head2 sub get_ACTIVE_PROJECT{

upper case ACTIVE_PROJECT 
PATH to the defatul Project.config

=cut

sub _get_ACTIVE_PROJECT {
	my ($self) = @_;
	my $ACTIVE_PROJECT;

	my $HOME = _get_home();

	$ACTIVE_PROJECT = $HOME . '/.L_SU/configuration/active';
	return ($ACTIVE_PROJECT);
}

=head2 sub _basic_dirs

    	e.g., $GLOBAL_CONFIG_LIB:  as /usr/local/pl/L_SU/configs/big_streams
    	first 2 cases should be deprecated
=cut

sub _basic_dirs {
	my ($self) = @_;

	my $ACTIVE_PROJECT = _get_ACTIVE_PROJECT();

	my $prog_name        = '';
	my $prog_name_new    = 'Project';
	my $prog_name_old    = 'Project_Variables';
	my $prog_name_config = '';

	if ( -e $prog_name_old . '.config' ) {

		# CASE 1 check local directory first LEGACY Project_Variables file
		print("1. Project_config,_basic_dirs,using local $prog_name_old.config\n");

		$prog_name = $prog_name_old;
		print("1a. Project_config,_basic_dirs,using local $prog_name_old.config \n");
		$prog_name_config = $prog_name_old . '.config';
		my ( $ref_DIR_FUNCTION, $ref_DIR )
			= $read->configs( ( $prog_name . '.config' ) );
		$Project->{_ref_DIR} = $ref_DIR;

		print(" 1. Project_config,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
		$Project->{_ref_DIR_FUNCTION} = $ref_DIR_FUNCTION;
		_change_basic_dirs();

	} elsif ( -e $prog_name_new . '.config' ) {

		# CASE2 check local directory for Project.config

		$prog_name        = $prog_name_new;                # system uses $GLOBAL_CONFIG_LIB.'/'.$prog_name_new
		$prog_name_config = $prog_name_new . '.config';    # i.e. Project.config

	} elsif ( -e $ACTIVE_PROJECT . '/' . $prog_name_new . '.config' ) {

		# CASE 3 check user configuration directory for Project.config

		# print("2. Project_config,_basic_dirs,using local $prog_name_new.config\n");
		# print("3. Project_config,_basic_dirs,using local $ACTIVE_PROJECT/$prog_name_new.config\n");
		$prog_name = $prog_name_new;    # system uses $GLOBAL_CONFIG_LIB.'/'.$prog_name_new
		$prog_name_config
			= $ACTIVE_PROJECT . '/'
			. $prog_name_new
			. '.config';                # i.e. /home/gom/.L_SU/configuration/active/Project.config
		my ( $ref_DIR_FUNCTION, $ref_DIR ) = $read->configs( ( $ACTIVE_PROJECT . '/' . $prog_name_new . '.config' ) );

		# parameter widget values
		$Project->{_ref_DIR} = $ref_DIR;

		# print(" 2. Project_config,_basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");

		# parameter widget labels/names
		$Project->{_ref_DIR_FUNCTION} = $ref_DIR_FUNCTION;

		# print(" 3. Project_config,_basic_dirs,ref_DIR:@{$Project->{_ref_DIR_FUNCTION}}\n");

		_change_basic_dirs();

	} else {

		# CASE 4 If nothing exists so you will have to
		# a. create the correct files and directories
		# B. set THE PATH NAME as the user configuration path
		# copy a default Project configuration file from
		# the GLOBAL_LIBS directory defined in
		# L_SU_global_constants.pm
		print("Project_config, _basic_dirs, no configuration files exist\n");

		use manage_dirs_by;
		use File::Copy;
		my $ACTIVE_PROJECT = _get_ACTIVE_PROJECT();

		# print(" Project_config, _basic_dirs, ACTIVE_PROJECT: $ACTIVE_PROJECT\n");
		my $PATH_N_file = $ACTIVE_PROJECT . '/Project.config';

		print("Project_config,PATH_N_file 	: $PATH_N_file\n");
		my $default_Project_config = $GLOBAL_CONFIG_LIB . '/Project.config';

		# make the default configuration directory for the user
		manage_dirs_by::make_dir($ACTIVE_PROJECT);
		copy( $default_Project_config, $PATH_N_file );
		print("Project_config, _basic_dirs, Project.config in ~user/.L_SU/configuration/active dir. created\n");

	}

	# print("1. Project_config,_basic_dirs, prog_name_config: $prog_name_config \n");

	if ( $prog_name ne '' ) {    # safe condition
								 # print("Project_config,_basic_dirs,reading $prog_name_config\n");
		my ( $ref_DIR_FUNCTION, $ref_DIR )
			= $read->configs( ($prog_name_config) );
		$Project->{_ref_DIR} = $ref_DIR;

		# print("4. Project_config,_basic_dirs,ref_DIR: @{$Project->{_ref_DIR}}\n");
		$Project->{_ref_DIR_FUNCTION} = $ref_DIR_FUNCTION;
		_change_basic_dirs();
	} else {                     # 4. If nothing exists so you will have to
								 # a. create the correct files and directories
								 # B. set THE PATH NAME as the user configuration path
								 # copy a default Project configuration file from
								 # the GLOBAL_LIBS directory defined in
								 # L_SU_global_constants.pm
								 # print ("Project_config, _basic_dirs, no configuration files exist\n");

		use manage_dirs_by;
		use File::Copy;
		my $ACTIVE_PROJECT = _get_ACTIVE_PROJECT();

		# print(" Project_config, _basic_dirs, ACTIVE_PROJECT: $ACTIVE_PROJECT\n");
		my $PATH_N_file = $ACTIVE_PROJECT . '/Project.config';

		# print("Project_config,PATH_N_file 	: $PATH_N_file\n");
		my $default_Project_config = $GLOBAL_CONFIG_LIB . '/Project.config';

		# make the default configuration directory for the user
		manage_dirs_by::make_dir($ACTIVE_PROJECT);
		copy( $default_Project_config, $PATH_N_file );

		# print ("Project_config, _basic_dirs, Project.config in user configuration dir. created\n");

		# print("3. Project_config,_basic_dirs,$prog_name_config is missing\n");
	}

	return ();
}

=head2 sub basic_dirs

    	e.g., $GLOBAL_CONFIG_LIB:  as /usr/local/pl/L_SU/configs/big_streams
=cut

sub basic_dirs {
	my ($self) = @_;

	# Find out HOME directory and configuration path for user
	my $ACTIVE_PROJECT = _get_ACTIVE_PROJECT();

	# print(" Project_config, _basic_dirs, ACTIVE_PROJECT: $ACTIVE_PROJECT\n");

	my $prog_name        = '';
	my $prog_name_new    = 'Project';
	my $prog_name_old    = 'Project_Variables';
	my $prog_name_config = '';

	# 1. check local directory first LEGACY Project_Variables file
	if ( -e $prog_name_old . '.config' ) {

		$prog_name = $prog_name_old;
		print("Project_config,basic_dirs,using local $prog_name.config\n");
		$prog_name_config = $prog_name_old . '.config';

		my ( $ref_DIR_FUNCTION, $ref_DIR )
			= $read->configs( ( $prog_name . '.config' ) );
		$Project->{_ref_DIR} = $ref_DIR;

		# print(" 1. Project_config,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
		$Project->{_ref_DIR_FUNCTION} = $ref_DIR_FUNCTION;
		_change_basic_dirs();

		# 2. then, check local directory for Project.config
	} elsif ( -e $prog_name_new . '.config' ) {

		$prog_name = $prog_name_new;
		my ( $ref_DIR_FUNCTION, $ref_DIR )
			= $read->configs( ( $prog_name . '.config' ) );
		$Project->{_ref_DIR} = $ref_DIR;
		print(" 3. Project_config,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
		$Project->{_ref_DIR_FUNCTION} = $ref_DIR_FUNCTION;
		_change_basic_dirs();

		# in local user configuration directory
	} elsif ( -e ( $ACTIVE_PROJECT . '/' . $prog_name_new . '.config' ) ) {

		$prog_name = $prog_name_new;

		# print("Project_config,basic_dirs,using $ACTIVE_PROJECT/$prog_name.config\n");
		my ( $ref_DIR_FUNCTION, $ref_DIR ) = $read->configs( ( $ACTIVE_PROJECT . '/' . $prog_name_new . '.config' ) );
		$Project->{_ref_DIR} = $ref_DIR;

		# print(" 2. Project_config,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
		$Project->{_ref_DIR_FUNCTION} = $ref_DIR_FUNCTION;
		_change_basic_dirs();

		# in user configuration directory : TODO incomplete
	} else {
		print("3. Project_config,_basic_dirs,$prog_name_config is missing\n");
	}
	return ();
}

=head2  Up-to-date
	
	 configuration file

=cut 

sub _change_basic_dirs {
	my ($self) = @_;
	use control;
	my $control = control->new();

	my @CFG;
	my ( $component,     $stage,        $process );
	my ( $date,          $line,         $subUser );
	my ( $HOME,          $PROJECT_HOME, $site, $spare_dir );
	my ( $geomaps_logic, $geopsy_logic, $matlab_logic );
	my ( $gmt_logic,     $grass_logic );
	my ( $immodpg_logic, $sqlite_logic, );

	# TODO my ()$matlab,$fast,$immodpg,gmt);
	# print(" 5. Project_config,_change_basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
	my $length = scalar @{ $Project->{_ref_DIR} };

	for ( my $i = 0, my $j = 0; $i < $length; $i++, $j = $j + 2 ) {

		# print(" 6. Project_config,make_local_dirs,ref_DIR:@{$Project->{_ref_DIR}}[$i]\n");
		$CFG[$j] = @{ $Project->{_ref_DIR_FUNCTION} }[$i];
		$CFG[ ( $j + 1 ) ] = @{ $Project->{_ref_DIR} }[$i];

		# print("$CFG[$j] = $CFG[($j+1)]\n");
	}

	$HOME         = $CFG[1];
	$PROJECT_HOME = $CFG[3];
	$site         = $CFG[5];

	# use scalar ref
	$spare_dir = $control->empty_directory( \$CFG[7] );
	$date      = $CFG[9];
	$component = $CFG[11];
	$line      = $CFG[13];
	$subUser   = $CFG[15];

	# for (my $i=0; $i < 21; $i++ ) {
	# print("Project_config,CFG[($i)],CFG[($i+1)]: $CFG[$i], $CFG[($i+1)]\n");
	# }
	$geomaps_logic = $control->set_str2logic( $CFG[17] );
	$geopsy_logic  = $control->set_str2logic( $CFG[19] );
	$gmt_logic     = $control->set_str2logic( $CFG[21] );
	$grass_logic   = $control->set_str2logic( $CFG[23] );
	$matlab_logic  = $control->set_str2logic( $CFG[25] );
	$immodpg_logic = $control->set_str2logic( $CFG[27] );
	$sqlite_logic  = $control->set_str2logic( $CFG[29] );

	# print("1. Project_config,_change_basic_dirs PROJECT_HOME=$Project->{_PROJECT_HOME}\n");
	# print("1. Project_config,_change_basic_dirs spare_dir=----$spare_dir----\n");

=head2

 a conversion  
 from hydraulic fracturing format
 into seismic format
 
=cut

	my $site_bck      = $site;
	my $date_bck      = $date;
	my $line_bck      = $line;
	my $component_bck = $component;
	my $spare_dir_bck = $spare_dir;

	# print("Project_config, change_basic_dirs, spare_dir_bck: $spare_dir\n\n");

	$date      = $site_bck;
	$stage     = $component_bck;
	$component = $date_bck;
	$process   = $line_bck;
	$line      = $spare_dir_bck;

=head3 for old-stype Project_Variable files 

 defaults in the local directory

=cut

	my $old_configuration_file = './Project_Variables.pm';

	if ( -e $old_configuration_file ) {

		# print ("Looking for old-style configuration file\n\n");
		# print("Using old-style configuration file\n\n");

		use Project_Variables;

		($date)         = Project_Variables::date();
		($line)         = Project_Variables::line();
		($component)    = Project_Variables::component();
		($stage)        = Project_Variables::stage();
		($process)      = Project_Variables::process();
		($PROJECT_HOME) = Project_Variables::PROJECT_HOME();
		$subUser = '';    #only in  new configuration files;

	}

	# assumes an up-to-date locally available
	# configuration file
	# print("Project_config, Using up-to-date locally available configuration file\n\n");
	# print("Project_config, HOME: $HOME\n\n");
	# print("Project_config, line: $line\n\n");

	$Project->{_HOME}                = $HOME;
	$Project->{_date}                = $date;
	$Project->{_line}                = $line;
	$Project->{_component}           = $component;
	$Project->{_stage}               = $stage;
	$Project->{_process}             = $process;
	$Project->{_PROJECT_HOME}        = $PROJECT_HOME;
	$Project->{_subUser}             = $subUser;
	$Project->{_geomaps_is_selected} = $geomaps_logic;
	$Project->{_geopsy_is_selected}  = $geopsy_logic;
	$Project->{_grass_is_selected}   = $grass_logic;
	$Project->{_gmt_is_selected}     = $gmt_logic;
	$Project->{_matlab_is_selected}  = $matlab_logic;
	$Project->{_immodpg_is_selected} = $immodpg_logic;
	$Project->{_sqlite_is_selected}  = $sqlite_logic;

	return ();
}

=head2 DIRECTORY DEFINITIONS

 Be careful in changing the following order
 clean ticks if needed

=cut

sub _system_dirs {

	my $HOME         = $Project->{_HOME};
	my $date         = $Project->{_date};
	my $line         = $Project->{_line};
	my $component    = $Project->{_component};
	my $stage        = $Project->{_stage};
	my $process      = $Project->{_process};
	my $PROJECT_HOME = $Project->{_PROJECT_HOME};
	my $subUser      = $Project->{_subUser};

	# print(" Project_config, _system_dirs, Before PROJECT_HOME $PROJECT_HOME\n");
	$PROJECT_HOME =~ s/\'//g;

	#  print(" Project_config, _system_dirs, After PROJECT_HOME $PROJECT_HOME\n");
	# print(" Project_config, _system_dirs, Before subUser: $subUser \n");

	if ($subUser) {
		$subUser =~ s/\'//g;

		# print(" Project_config, _system_dirs, After subUser: $subUser \n");
	} else {

		# print("New L_SU project detected: Project_config, _system_dirs\n");
	}

	# META-DATA FILE STRUCTRUE
	my $DATE_LINE_COMPONENT_STAGE_PROCESS = $date . '/' . $line . '/' . $component . '/' . $stage . '/' . $process;
	$DATE_LINE_COMPONENT_STAGE_PROCESS =~ s/\'//g;

	# BASE DATA TYPES : default is SURFACE
	my $GEOMAPS             = $PROJECT_HOME . '/geomaps';
	my $WELL                = $PROJECT_HOME . '/well';
	my $SEISMIC             = $PROJECT_HOME . '/seismics';
	my $SURFACE             = $PROJECT_HOME . '/surface';    # legacy
	my $GAMMA_WELL          = $WELL . '/gamma';
	my $RESISTIVITY_SURFACE = $SURFACE . '/resistivity';     # legacy
	my $RESISTIVITY_WELL    = $WELL . '/resistivity';
	my $SEISMIC_WELL        = $WELL . '/seismics';

	my $DATA_WELL                = $WELL . '/data';
	my $DATA_SEISMIC             = $SEISMIC . '/data';
	my $DATA_RESISTIVITY_SURFACE = $RESISTIVITY_SURFACE . '/data';    # legacy
	my $DATA_GEOMAPS             = $GEOMAPS . '/data';
	my $DATA_TYPE                = 'raw/text';

	# TOOL DATA TYPES
	my $DATA_GAMMA_WELL       = $GAMMA_WELL . '/data';
	my $DATA_RESISTIVITY_WELL = $RESISTIVITY_WELL . '/data';
	my $DATA_SEISMIC_WELL     = $SEISMIC_WELL . '/data';

	# database
	my $SEISMIC_SQLITE = $SEISMIC . '/sqlite';
	my $SQLITE_SEISMIC = $SEISMIC . '/sqlite';

	# SOFTWARE ANTELOPE
	my $ANTELOPE = $SEISMIC . '/antelope';

	# DATABASES
	my $DATABASE_SEISMIC_SQLITE = $SEISMIC_SQLITE . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $DATABASE_SQLITE_SEISMIC = $SQLITE_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# FAST DIRECTORY for TOMOGRAPHIC MODELING
	my $FAST_TOMO = $SEISMIC . '/fast_tomo/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GEOPSY DIRECTORY SURFACE WAVE MODELING
	my $GEOPSY           = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $GEOPSY_PARAMS    = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'params';
	my $GEOPSY_PICKS     = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'picks';
	my $GEOPSY_PICKS_RAW = $GEOPSY_PICKS . '/' . 'raw';
	my $GEOPSY_PROFILES
		= $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'profiles';
	my $GEOPSY_REPORTS = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'reports';
	my $GEOPSY_TARGETS = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'targets';

	# IMAGES
	my $IMAGES_SEISMIC = $SEISMIC . '/images';
	my $IMAGES_WELL    = $WELL . '/images';
	my $GIF_SEISMIC    = $IMAGES_SEISMIC . '/gif';
	my $PS_SEISMIC     = $IMAGES_SEISMIC . '/' . 'ps' . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $PS_WELL        = $IMAGES_WELL . '/' . 'ps' . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# JPEG IMAGE STORAGE DIRECTORY
	my $JPEG = $IMAGES_SEISMIC . '/jpeg/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# ISOLA DIRECTORY
	my $ISOLA = $SEISMIC . '/isola/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GMT SEISMIC
	my $GMT_SEISMIC = $SEISMIC . '/gmt/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GMT GEOMAPS
	my $GMT_GEOMAPS = $GEOMAPS . '/gmt/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GRASS GEOMAPS
	my $GRASS_GEOMAPS = $GEOMAPS . '/grass/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# PROGRAMMING LANGUAGES
	my $C_SEISMIC   = $SEISMIC . '/c/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $CPP_SEISMIC = $SEISMIC . '/cpp/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# MATLAB DIRECTORIES
	my $MATLAB_SEISMIC = $SEISMIC . '/matlab/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $MATLAB_WELL    = $WELL . '/matlab/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $MATLAB_GEOMAPS = $GEOMAPS . '/matlab/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# MMODPG DIRECTORY
	my $MMODPG = $SEISMIC . '/mmodpg/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# IMMODPG DIRECTORY
	my $IMMODPG = $SEISMIC . '/mmodpg/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# IMMODPG INVISIBLE sub DIRECTORY
	my $IMMODPG_INVISIBLE = ("$SEISMIC/mmodpg/$DATE_LINE_COMPONENT_STAGE_PROCESS/$subUser/.immodpg");

	# FAST DIRECTORY for 2D RAYTRACING
	my $MOD2D_TOMO = $SEISMIC . '/fast_tomo/All/mod2d';

	# PERL DIRECTOIES
	my $PL_SEISMIC = $SEISMIC . '/pl/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $PL_GEOMAPS = $GEOMAPS . '/pl/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $PL_WELL    = $WELL . '/pl/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# R DIRECTORIES
	my $R_RESISTIVITY_WELL    = $RESISTIVITY_WELL . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_RESISTIVITY_SURFACE = $RESISTIVITY_SURFACE . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_GAMMA_WELL          = $GAMMA_WELL . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_SEISMIC             = $SEISMIC . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_WELL                = $WELL . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# RAYGUI DIRECTORY for 2D RAYTRACING
	my $RAYGUI = $SEISMIC . '/raygui/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# RAYINVR DIRECTORY for 2D RAYTRACING
	my $RAYINVR = $SEISMIC . '/rayinvr/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# SH DIRECTORY
	my $SH_SEISMIC = $SEISMIC . '/sh/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# WELL RESITIVITY DATA in TXT format
	my $DATA_RESISTIVITY_WELL_TXT
		= $DATA_RESISTIVITY_WELL . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# SURFACE RESITIVITY
	my $DATA_RESISTIVITY_SURFACE_TXT
		= $DATA_RESISTIVITY_SURFACE . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# WELL RESITIVITY DATA in TXT format
	my $DATA_GAMMA_WELL_TXT = $DATA_GAMMA_WELL . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# SEISMIC DIRECTORY
	my $DATA_SEISMIC_BIN = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/bin' . '/' . $subUser;

	my $DATA_SEISMIC_DAT = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/dat' . '/' . $subUser;

	# INNOVATION INTEGRATION
	my $DATA_SEISMIC_ININT = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/inint' . '/' . $subUser;

	# MATLAB SEISMIC DIRECTORY
	my $DATA_SEISMIC_MATLAB = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/matlab' . '/' . $subUser;

	# PASSCAL SEGY DIRECTORY
	my $DATA_SEISMIC_PASSCAL_SEGY
		= $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/passcal_segy' . '/' . $subUser;

	# R DIRECTORY
	my $DATA_SEISMIC_R = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/r' . '/' . $subUser;

	# SAC DIRECTORY
	# RSEIS DIRECTORY
	my $DATA_SEISMIC_RSEIS = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/rseis' . '/' . $subUser;

	# SAC DIRECTORY
	my $DATA_SEISMIC_SAC = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/sac' . '/' . $subUser;

	# SEG2 DIRECTORY
	my $DATA_SEISMIC_SEG2 = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/seg2' . '/' . $subUser;

	# SEGD DIRECTORY
	my $DATA_SEISMIC_SEGD = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/segd' . '/' . $subUser;

	# SIERRA SEGY DIRECTORY
	my $DATA_SEISMIC_SIERRA_SEGY
		= $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/sierra_segy' . '/' . $subUser;

	# SU DIRECTORY
	my $DATA_SEISMIC_SU = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/su' . '/' . $subUser;

	# SU DIRECTORY
	my $DATA_SEISMIC_SU_RAW = $DATA_SEISMIC_SU . '/raw' . '/' . $subUser;

	# SEGY DIRECTORY
	my $DATA_SEISMIC_SEGY = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/segy' . '/' . $subUser;

	# SEGY DIRECTORY
	my $DATA_SEISMIC_SEGY_RAW = $DATA_SEISMIC_SEGY . '/raw' . '/' . $subUser;

	# SEISMIC VELOCITY DIRECTORY
	my $DATA_SEISMIC_VEL = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/vel' . '/' . $subUser;

	# SEISMIC WELL DATA TEXT DIRECTORY
	my $DATA_SEISMIC_WELL_SYNSEIS
		= $DATA_SEISMIC_WELL . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/synseis' . '/' . $subUser;

	# RAW TXT DIRECTORY
	my $DATA_SEISMIC_TXT = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# GEOMAPS TEXT DIRECTORY
	my $DATA_GEOMAPS_TEXT = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/text' . '/' . $subUser;

	# print("2. Project_config,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

	# GEOMAPS TOPOGRAPHY DIRECTORY
	my $DATA_GEOMAPS_TOPO = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/topo' . '/' . $subUser;

	# GEOMAPS BIN DIRECTORY
	my $DATA_GEOMAPS_BIN = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/bin' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES = $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES_JPEG
		= $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/jpeg' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES_TIF = $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/tif' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES_PS = $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/ps' . '/' . $subUser;

	# GEOMAPS TEMP DIRECTORY
	my $TEMP_DATA_GEOMAPS = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/temp' . '/' . $subUser;

	# TEMPORARY SEISMIC DATA DIRECTORY
	my $TEMP_DATA_SEISMIC = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/temp' . '/' . $subUser;

	# TEMPORARY SEISMIC DATA DIRECTORY
	my $TEMP_DATA_SEISMIC_SU = $DATA_SEISMIC_SU . '/.temp' . '/' . $subUser;

	# TOMO TEMP DIRECTORY
	my $TEMP_FAST_TOMO = $FAST_TOMO . '/temp' . '/' . $subUser;

	# WELL DATA DIRECTORY
	$DATA_WELL = $WELL . '/data' . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	$Project->{_ANTELOPE}            = $ANTELOPE;
	$Project->{_DATA_GEOMAPS}        = $DATA_GEOMAPS;
	$Project->{_DATA_GEOMAPS_BIN}    = $DATA_GEOMAPS_BIN;
	$Project->{_DATA_GEOMAPS_TOPO}   = $DATA_GEOMAPS_TOPO;
	$Project->{_GEOMAPS_IMAGES}      = $GEOMAPS_IMAGES;
	$Project->{_GEOMAPS_IMAGES_JPEG} = $GEOMAPS_IMAGES_JPEG;
	$Project->{_GEOMAPS_IMAGES_TIF}  = $GEOMAPS_IMAGES_TIF;
	$Project->{_GEOMAPS_IMAGES_PS}   = $GEOMAPS_IMAGES_PS;
	$Project->{_DATA_GEOMAPS_TEXT}   = $DATA_GEOMAPS_TEXT;

	#print("3. Project_config,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

	$Project->{_PROJECT_HOME}        = $PROJECT_HOME;
	$Project->{_DATA_GAMMA_WELL}     = $DATA_GAMMA_WELL;
	$Project->{_DATA_GAMMA_WELL_TXT} = $DATA_GAMMA_WELL_TXT;

	# $Project->{_DATA_RESISTIVITY_}		= $DATA_RESISTIVITY;
	# $Project->{_DATA_RESISTIVITY_TXT}		= $DATA_RESISTIVITY_TXT;
	$Project->{_DATA_RESISTIVITY_SURFACE}     = $DATA_RESISTIVITY_SURFACE;
	$Project->{_DATA_RESISTIVITY_SURFACE_TXT} = $DATA_RESISTIVITY_SURFACE_TXT;

	$Project->{_DATA_RESISTIVITY_WELL}     = $DATA_RESISTIVITY_WELL;
	$Project->{_DATA_RESISTIVITY_WELL_TXT} = $DATA_RESISTIVITY_WELL_TXT;

	$Project->{_DATA_SEISMIC_BIN}          = $DATA_SEISMIC_BIN;
	$Project->{_DATA_SEISMIC_DAT}          = $DATA_SEISMIC_DAT;
	$Project->{_DATA_SEISMIC_ININT}        = $DATA_SEISMIC_ININT;
	$Project->{_DATA_SEISMIC_MATLAB}       = $DATA_SEISMIC_MATLAB;
	$Project->{_DATA_SEISMIC_WELL}         = $DATA_SEISMIC_WELL;
	$Project->{_DATA_SEISMIC_WELL_TEXT}    = $DATA_SEISMIC_WELL_SYNSEIS;
	$Project->{_GMT_SEISMIC}               = $GMT_SEISMIC;
	$Project->{_GMT_GEOMAPS}               = $GMT_GEOMAPS;
	$Project->{_GRASS_GEOMAPS}             = $GRASS_GEOMAPS;
	$Project->{_DATA_SEISMIC}              = $DATA_SEISMIC;
	$Project->{_DATA_SEISMIC_PASSCAL_SEGY} = $DATA_SEISMIC_PASSCAL_SEGY;
	$Project->{_DATA_SEISMIC_R}            = $DATA_SEISMIC_R;
	$Project->{_DATA_SEISMIC_RSEIS}        = $DATA_SEISMIC_RSEIS;
	$Project->{_DATA_SEISMIC_SAC}          = $DATA_SEISMIC_SAC;
	$Project->{_DATA_SEISMIC_SEG2}         = $DATA_SEISMIC_SEG2;
	$Project->{_DATA_SEISMIC_SEGD}         = $DATA_SEISMIC_SEGD;
	$Project->{_DATA_SEISMIC_SEGY}         = $DATA_SEISMIC_SEGY;
	$Project->{_DATA_SEISMIC_SEGY_RAW}     = $DATA_SEISMIC_SEGY_RAW;
	$Project->{_DATA_SEISMIC_SIERRA_SEGY}  = $DATA_SEISMIC_SIERRA_SEGY;
	$Project->{_DATA_SEISMIC_SU}           = $DATA_SEISMIC_SU;
	$Project->{_DATA_SEISMIC_SU_RAW}       = $DATA_SEISMIC_SU_RAW;
	$Project->{_DATA_SEISMIC_TXT}          = $DATA_SEISMIC_TXT;
	$Project->{_DATA_SEISMIC_VEL}          = $DATA_SEISMIC_VEL;
	$Project->{_DATA_SEISMIC_WELL}         = $DATA_SEISMIC_WELL;
	$Project->{_DATA_SEISMIC_WELL_SYNSEIS} = $DATA_SEISMIC_WELL_SYNSEIS;
	$Project->{_DATABASE_SEISMIC_SQLITE}   = $DATABASE_SEISMIC_SQLITE;
	$Project->{_DATA_WELL}                 = $DATA_WELL;
	$Project->{_FAST_TOMO}                 = $FAST_TOMO;
	$Project->{_GEOPSY}                    = $GEOPSY;
	$Project->{_GEOPSY_PARAMS}             = $GEOPSY_PARAMS;
	$Project->{_GEOPSY_PICKS}              = $GEOPSY_PICKS;
	$Project->{_GEOPSY_PICKS_RAW}          = $GEOPSY_PICKS_RAW;
	$Project->{_GEOPSY_PROFILES}           = $GEOPSY_PROFILES;
	$Project->{_GEOPSY_REPORTS}            = $GEOPSY_REPORTS;
	$Project->{_GEOPSY_TARGETS}            = $GEOPSY_TARGETS;
	$Project->{_GIF_SEISMIC}               = $GIF_SEISMIC;
	$Project->{_IMMODPG}                   = $IMMODPG;
	$Project->{_IMMODPG_INVISIBLE}         = $IMMODPG_INVISIBLE;
	$Project->{_ISOLA}                     = $ISOLA;
	$Project->{_JPEG}                      = $JPEG;
	$Project->{_C_SEISMIC}                 = $C_SEISMIC;
	$Project->{_CPP_SEISMIC}               = $CPP_SEISMIC;
	$Project->{_MATLAB_GEOMAPS}            = $MATLAB_GEOMAPS;
	$Project->{_MATLAB_WELL}               = $MATLAB_WELL;
	$Project->{_MATLAB_SEISMIC}            = $MATLAB_SEISMIC;
	$Project->{_MMODPG}                    = $MMODPG;
	$Project->{_MOD2D_TOMO}                = $MOD2D_TOMO;
	$Project->{_PL_SEISMIC}                = $PL_SEISMIC;

	# print("Project_config,_system_dirs,PL_SEISMIC = $PL_SEISMIC\n");
	$Project->{_PL_GEOMAPS}            = $PL_GEOMAPS;
	$Project->{_PL_WELL}               = $PL_WELL;
	$Project->{_RESISTIVITY_SURFACE}   = $RESISTIVITY_SURFACE;
	$Project->{_R_GAMMA_WELL}          = $R_GAMMA_WELL;
	$Project->{_R_RESISTIVITY_SURFACE} = $R_RESISTIVITY_SURFACE;
	$Project->{_R_RESISTIVITY_WELL}    = $R_RESISTIVITY_WELL;
	$Project->{_R_SEISMIC}             = $R_SEISMIC;
	$Project->{_R_WELL}                = $R_WELL;
	$Project->{_SH_SEISMIC}            = $SH_SEISMIC;
	$Project->{_PS_SEISMIC}            = $PS_SEISMIC;
	$Project->{_PS_WELL}               = $PS_WELL;
	$Project->{_RAYINVR}               = $RAYINVR;
	$Project->{_SURFACE}               = $SURFACE;
	$Project->{_TEMP_DATA_GEOMAPS}     = $TEMP_DATA_GEOMAPS;
	$Project->{_TEMP_DATA_SEISMIC}     = $TEMP_DATA_SEISMIC;
	$Project->{_TEMP_DATA_SEISMIC_SU}  = $TEMP_DATA_SEISMIC_SU;
	$Project->{_TEMP_FAST_TOMO}        = $TEMP_FAST_TOMO;
	$Project->{_WELL}                  = $WELL;

	return ();
}

=head2 DIRECTORY DEFINITIONS

 Be careful in changing the following order

=cut

sub system_dirs {

	my $HOME         = $Project->{_HOME};
	my $date         = $Project->{_date};
	my $line         = $Project->{_line};
	my $component    = $Project->{_component};
	my $stage        = $Project->{_stage};
	my $process      = $Project->{_process};
	my $PROJECT_HOME = $Project->{_PROJECT_HOME};
	my $subUser      = $Project->{_subUser};

	# META-DATA FILE STRUCTRUE
	my $DATE_LINE_COMPONENT_STAGE_PROCESS = $date . '/' . $line . '/' . $component . '/' . $stage . '/' . $process;

	# GEOGRAPHIC DATA
	my $GEOMAPS      = $PROJECT_HOME . '/geomaps';
	my $DATA_GEOMAPS = $GEOMAPS . '/data';
	my $SURFACE      = $PROJECT_HOME . '/surface';    # legacy

	# DATA CATEGORIES BY TOOL collected at the surface (default)
	my $RESISTIVITY              = $PROJECT_HOME . '/resistivity';
	my $RESISTIVITY_SURFACE      = $PROJECT_HOME . '/resistivity_surface';    # legacy
	my $DATA_RESISTIVITY         = $RESISTIVITY . '/data';
	my $DATA_RESISTIVITY_SURFACE = $RESISTIVITY_SURFACE . '/data';            # legacy

	my $SEISMIC      = $PROJECT_HOME . '/seismics';
	my $DATA_SEISMIC = $SEISMIC . '/data';

	my $DATA_TYPE = 'raw/text';

	# DATA CATEGORIES by TOOL collected in a WELL
	my $WELL = $PROJECT_HOME . '/well';

	my $DATA_WELL        = $WELL . '/data';
	my $GAMMA_WELL       = $WELL . '/gamma';
	my $SEISMIC_WELL     = $WELL . '/seismics';
	my $RESISTIVITY_WELL = $WELL . '/resistivity';

	my $DATA_GAMMA_WELL       = $GAMMA_WELL . '/data';
	my $DATA_RESISTIVITY_WELL = $RESISTIVITY_WELL . '/data';
	my $DATA_SEISMIC_WELL     = $SEISMIC_WELL . '/data';

	# DATA CATEGORIES by TOOL collected over water

	# DATA CATEGORIES by TOOL collected by air

	# database
	my $SEISMIC_SQLITE = $SEISMIC . '/sqlite';
	my $SQLITE_SEISMIC = $SEISMIC . '/sqlite';

	# SOFTWARE ANTELOPE
	my $ANTELOPE = $SEISMIC . '/antelope';

	# DATABASES
	my $DATABASE_SEISMIC_SQLITE = $SEISMIC_SQLITE . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $DATABASE_SQLITE_SEISMIC = $SQLITE_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# FAST DIRECTORY for TOMOGRAPHIC MODELING
	my $FAST_TOMO = $SEISMIC . '/fast_tomo/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GEOPSY DIRECTORY SURFACE WAVE MODELING
	my $GEOPSY        = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $GEOPSY_PARAMS = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'params';
	my $GEOPSY_PICKS  = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'picks';
	my $GEOPSY_PICKS_RAW
		= $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'picks' . '/' . 'raw';
	my $GEOPSY_PROFILES
		= $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'profiles';
	my $GEOPSY_REPORTS = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'reports';
	my $GEOPSY_TARGETS = $SEISMIC . '/geopsy/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/' . 'targets';

	# IMAGES
	my $IMAGES_SEISMIC = $SEISMIC . '/images';
	my $IMAGES_WELL    = $WELL . '/images';
	my $GIF_SEISMIC    = $IMAGES_SEISMIC . '/gif';
	my $PS_SEISMIC     = $IMAGES_SEISMIC . '/' . 'ps' . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $PS_WELL        = $IMAGES_WELL . '/' . 'ps' . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# JPEG IMAGE STORAGE DIRECTORY
	my $JPEG         = $IMAGES_SEISMIC . '/jpeg/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $JPEG_SEISMIC = $JPEG;

	# ISOLA DIRECTORY
	my $ISOLA = $SEISMIC . '/isola/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GMT SEISMIC
	my $GMT_SEISMIC = $SEISMIC . '/gmt/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GMT GEOMAPS
	my $GMT_GEOMAPS = $GEOMAPS . '/gmt/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# GRASS GEOMAPS
	my $GRASS_GEOMAPS = $GEOMAPS . '/grass/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# PROGRAMMING LANGUAGES
	my $C_SEISMIC   = $SEISMIC . '/c/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $CPP_SEISMIC = $SEISMIC . '/cpp/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# MATLAB DIRECTORIES
	my $MATLAB_SEISMIC = $SEISMIC . '/matlab/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $MATLAB_WELL    = $WELL . '/matlab/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $MATLAB_GEOMAPS = $GEOMAPS . '/matlab/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# MMODPG DIRECTORY
	my $MMODPG = $SEISMIC . '/mmodpg/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# IMMODPG DIRECTORY
	my $IMMODPG = $SEISMIC . '/mmodpg/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# IMMODPG DIRECTORY
	my $IMMODPG_INVISIBLE = $SEISMIC . '/mmodpg/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser . '/.immodpg';

	# print("Project_config,system_dirs, IMMODPG_INVISIBLE: $IMMODPG_INVISIBLE\n");

	# FAST DIRECTORY for 2D RAYTRACING
	my $MOD2D_TOMO = $SEISMIC . '/fast_tomo/All/mod2d';

	# PERL DIRECTORIES
	my $PL_SEISMIC = $SEISMIC . '/pl/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $PL_GEOMAPS = $GEOMAPS . '/pl/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $PL_WELL    = $WELL . '/pl/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# R DIRECTORIES
	my $R_RESISTIVITY_WELL    = $RESISTIVITY_WELL . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_RESISTIVITY_SURFACE = $RESISTIVITY_SURFACE . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_GAMMA_WELL          = $GAMMA_WELL . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_SEISMIC             = $SEISMIC . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;
	my $R_WELL                = $WELL . '/r/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# RAYGUI DIRECTORY for 2D RAYTRACING
	my $RAYGUI = $SEISMIC . '/raygui/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# RAYINVR DIRECTORY for 2D RAYTRACING
	my $RAYINVR = $SEISMIC . '/rayinvr/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# SH DIRECTORY
	my $SH_SEISMIC = $SEISMIC . '/sh/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	# WELL RESITIVITY DATA in TXT format
	my $DATA_RESISTIVITY_WELL_TXT
		= $DATA_RESISTIVITY_WELL . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# SURFACE RESITIVITY
	my $DATA_RESISTIVITY_SURFACE_TXT
		= $DATA_RESISTIVITY_SURFACE . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# WELL RESITIVITY DATA in TXT format
	my $DATA_GAMMA_WELL_TXT = $DATA_GAMMA_WELL . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# SEISMIC DIRECTORY
	my $DATA_SEISMIC_BIN = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/bin' . '/' . $subUser;

	my $DATA_SEISMIC_DAT = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/dat' . '/' . $subUser;

	# INNOVATION INTEGRATION
	my $DATA_SEISMIC_ININT = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/inint' . '/' . $subUser;

	# MATLAB SEISMIC DIRECTORY
	my $DATA_SEISMIC_MATLAB = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/matlab' . '/' . $subUser;

	# PASSCAL SEGY DIRECTORY
	my $DATA_SEISMIC_PASSCAL_SEGY
		= $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/passcal_segy' . '/' . $subUser;

	# R DIRECTORY
	my $DATA_SEISMIC_R = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/r' . '/' . $subUser;

	# SAC DIRECTORY
	# RSEIS DIRECTORY
	my $DATA_SEISMIC_RSEIS = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/rseis' . '/' . $subUser;

	# SAC DIRECTORY
	my $DATA_SEISMIC_SAC = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/sac' . '/' . $subUser;

	# SEG2 DIRECTORY
	my $DATA_SEISMIC_SEG2 = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/seg2' . '/' . $subUser;

	# SEGD DIRECTORY
	my $DATA_SEISMIC_SEGD = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/segd' . '/' . $subUser;

	# SIERRA SEGY DIRECTORY
	my $DATA_SEISMIC_SIERRA_SEGY
		= $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/sierra_segy' . '/' . $subUser;

	# SU DIRECTORY
	my $DATA_SEISMIC_SU = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/su' . '/' . $subUser;

	# SU DIRECTORY
	my $DATA_SEISMIC_SU_RAW = $DATA_SEISMIC_SU . '/raw' . '/' . $subUser;

	# SEGY DIRECTORY
	my $DATA_SEISMIC_SEGY = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/segy' . '/' . $subUser;

	# SEGY DIRECTORY
	my $DATA_SEISMIC_SEGY_RAW = $DATA_SEISMIC_SEGY . '/raw' . '/' . $subUser;

	# SEISMIC VELOCITY DIRECTORY
	my $DATA_SEISMIC_VEL = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/vel' . '/' . $subUser;

	# RAW TXT DIRECTORY
	my $DATA_SEISMIC_TXT = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/txt' . '/' . $subUser;

	# WELL TEXT DIRECTORY
	my $DATA_SEISMIC_WELL_SYNSEIS
		= $DATA_SEISMIC_WELL . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/synseis' . '/' . $subUser;

	# GEOMAPS TEXT DIRECTORY
	my $DATA_GEOMAPS_TEXT = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/text' . '/' . $subUser;

	# print("2. Project_config,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

	# GEOMAPS TOPOGRAPHY DIRECTORY
	my $DATA_GEOMAPS_TOPO = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/topo' . '/' . $subUser;

	# GEOMAPS BIN DIRECTORY
	my $DATA_GEOMAPS_BIN = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/bin' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES = $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES_JPEG
		= $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/jpeg' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES_TIF = $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/tif' . '/' . $subUser;

	# GEOMAPS IMAGES DIRECTORY
	my $GEOMAPS_IMAGES_PS = $GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/images' . '/ps' . '/' . $subUser;

	# GEOMAPS TEMP DIRECTORY
	my $TEMP_DATA_GEOMAPS = $DATA_GEOMAPS . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/temp' . '/' . $subUser;

	# TEMPORARY SEISMIC DATA DIRECTORY
	my $TEMP_DATA_SEISMIC = $DATA_SEISMIC . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/temp' . '/' . $subUser;

	# TEMPORARY SEISMIC DATA DIRECTORY
	my $TEMP_DATA_SEISMIC_SU = $DATA_SEISMIC_SU . '/.temp' . '/' . $subUser;

	# TOMO TEMP DIRECTORY
	my $TEMP_FAST_TOMO = $FAST_TOMO . '/temp' . '/' . $subUser;

	# WELL DATA DIRECTORY
	$DATA_WELL = $WELL . '/data' . '/' . $DATE_LINE_COMPONENT_STAGE_PROCESS . '/' . $subUser;

	$Project->{_ANTELOPE}            = $ANTELOPE;
	$Project->{_DATA_GEOMAPS}        = $DATA_GEOMAPS;
	$Project->{_DATA_GEOMAPS_BIN}    = $DATA_GEOMAPS_BIN;
	$Project->{_DATA_GEOMAPS_TOPO}   = $DATA_GEOMAPS_TOPO;
	$Project->{_GEOMAPS_IMAGES}      = $GEOMAPS_IMAGES;
	$Project->{_GEOMAPS_IMAGES_JPEG} = $GEOMAPS_IMAGES_JPEG;
	$Project->{_GEOMAPS_IMAGES_TIF}  = $GEOMAPS_IMAGES_TIF;
	$Project->{_GEOMAPS_IMAGES_PS}   = $GEOMAPS_IMAGES_PS;
	$Project->{_DATA_GEOMAPS_TEXT}   = $DATA_GEOMAPS_TEXT;

	#print("3. Project_config,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

	$Project->{_PROJECT_HOME}                 = $PROJECT_HOME;
	$Project->{_DATA_GAMMA_WELL}              = $DATA_GAMMA_WELL;
	$Project->{_DATA_GAMMA_WELL_TXT}          = $DATA_GAMMA_WELL_TXT;
	$Project->{_DATA_RESISTIVITY_SURFACE}     = $DATA_RESISTIVITY_SURFACE;
	$Project->{_DATA_RESISTIVITY_SURFACE_TXT} = $DATA_RESISTIVITY_SURFACE_TXT;
	$Project->{_DATA_RESISTIVITY_WELL}        = $DATA_RESISTIVITY_WELL;
	$Project->{_DATA_RESISTIVITY_WELL_TXT}    = $DATA_RESISTIVITY_WELL_TXT;
	$Project->{_DATA_SEISMIC_BIN}             = $DATA_SEISMIC_BIN;
	$Project->{_DATA_SEISMIC_DAT}             = $DATA_SEISMIC_DAT;
	$Project->{_DATA_SEISMIC_ININT}           = $DATA_SEISMIC_ININT;
	$Project->{_DATA_SEISMIC_MATLAB}          = $DATA_SEISMIC_MATLAB;
	$Project->{_GMT_SEISMIC}                  = $GMT_SEISMIC;
	$Project->{_GMT_GEOMAPS}                  = $GMT_GEOMAPS;
	$Project->{_GRASS_GEOMAPS}                = $GRASS_GEOMAPS;
	$Project->{_DATA_SEISMIC}                 = $DATA_SEISMIC;
	$Project->{_DATA_SEISMIC_PASSCAL_SEGY}    = $DATA_SEISMIC_PASSCAL_SEGY;
	$Project->{_DATA_SEISMIC_R}               = $DATA_SEISMIC_R;
	$Project->{_DATA_SEISMIC_RSEIS}           = $DATA_SEISMIC_RSEIS;
	$Project->{_DATA_SEISMIC_SAC}             = $DATA_SEISMIC_SAC;
	$Project->{_DATA_SEISMIC_SEG2}            = $DATA_SEISMIC_SEG2;
	$Project->{_DATA_SEISMIC_SEGD}            = $DATA_SEISMIC_SEGD;
	$Project->{_DATA_SEISMIC_SEGY}            = $DATA_SEISMIC_SEGY;
	$Project->{_DATA_SEISMIC_SEGY_RAW}        = $DATA_SEISMIC_SEGY_RAW;
	$Project->{_DATA_SEISMIC_SIERRA_SEGY}     = $DATA_SEISMIC_SIERRA_SEGY;
	$Project->{_DATA_SEISMIC_SU}              = $DATA_SEISMIC_SU;
	$Project->{_DATA_SEISMIC_SU_RAW}          = $DATA_SEISMIC_SU_RAW;
	$Project->{_DATA_SEISMIC_TXT}             = $DATA_SEISMIC_TXT;
	$Project->{_DATA_SEISMIC_VEL}             = $DATA_SEISMIC_VEL;
	$Project->{_DATA_SEISMIC_WELL}            = $DATA_SEISMIC_WELL;
	$Project->{_DATA_SEISMIC_WELL_SYNSEIS}    = $DATA_SEISMIC_WELL_SYNSEIS;
	$Project->{_DATABASE_SEISMIC_SQLITE}      = $DATABASE_SEISMIC_SQLITE;
	$Project->{_DATA_WELL}                    = $DATA_WELL;
	$Project->{_FAST_TOMO}                    = $FAST_TOMO;
	$Project->{_GEOPSY}                       = $GEOPSY;
	$Project->{_GEOPSY_PARAMS}                = $GEOPSY_PARAMS;
	$Project->{_GEOPSY_PICKS}                 = $GEOPSY_PICKS;
	$Project->{_GEOPSY_PICKS_RAW}             = $GEOPSY_PICKS_RAW;
	$Project->{_GEOPSY_PROFILES}              = $GEOPSY_PROFILES;
	$Project->{_GEOPSY_REPORTS}               = $GEOPSY_REPORTS;
	$Project->{_GEOPSY_TARGETS}               = $GEOPSY_TARGETS;
	$Project->{_GIF_SEISMIC}                  = $GIF_SEISMIC;
	$Project->{_ISOLA}                        = $ISOLA;
	$Project->{_JPEG}                         = $JPEG;
	$Project->{_JPEG_SEISMIC}                 = $JPEG_SEISMIC;
	$Project->{_C_SEISMIC}                    = $C_SEISMIC;
	$Project->{_CPP_SEISMIC}                  = $CPP_SEISMIC;
	$Project->{_MATLAB_GEOMAPS}               = $MATLAB_GEOMAPS;
	$Project->{_MATLAB_WELL}                  = $MATLAB_WELL;
	$Project->{_MATLAB_SEISMIC}               = $MATLAB_SEISMIC;
	$Project->{_IMMODPG}                      = $IMMODPG;
	$Project->{_IMMODPG_INVISIBLE}            = $IMMODPG_INVISIBLE;
	$Project->{_MOD2D_TOMO}                   = $MOD2D_TOMO;
	$Project->{_PL_SEISMIC}                   = $PL_SEISMIC;
	$Project->{_PL_GEOMAPS}                   = $PL_GEOMAPS;
	$Project->{_PL_WELL}                      = $PL_WELL;
	$Project->{_RESISTIVITY_SURFACE}          = $RESISTIVITY_SURFACE;
	$Project->{_R_GAMMA_WELL}                 = $R_GAMMA_WELL;
	$Project->{_R_RESISTIVITY_SURFACE}        = $R_RESISTIVITY_SURFACE;
	$Project->{_R_RESISTIVITY_WELL}           = $R_RESISTIVITY_WELL;
	$Project->{_R_SEISMIC}                    = $R_SEISMIC;
	$Project->{_R_WELL}                       = $R_WELL;
	$Project->{_SH_SEISMIC}                   = $SH_SEISMIC;
	$Project->{_PS_SEISMIC}                   = $PS_SEISMIC;
	$Project->{_PS_WELL}                      = $PS_WELL;
	$Project->{_RAYINVR}                      = $RAYINVR;
	$Project->{_SURFACE}                      = $SURFACE;
	$Project->{_TEMP_DATA_GEOMAPS}            = $TEMP_DATA_GEOMAPS;
	$Project->{_TEMP_DATA_SEISMIC}            = $TEMP_DATA_SEISMIC;
	$Project->{_TEMP_DATA_SEISMIC_SU}         = $TEMP_DATA_SEISMIC_SU;
	$Project->{_TEMP_FAST_TOMO}               = $TEMP_FAST_TOMO;
	$Project->{_WELL}                         = $WELL;

	return ();
}

sub date {
	_basic_dirs();

	my $date = $Project->{_date};
	return ($date);
}

sub ANTELOPE {
	_basic_dirs();
	_system_dirs();

	my $ANTELOPE = $Project->{_ANTELOPE};
	return ($ANTELOPE);
}

sub CPP_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $CPP_SEISMIC = $Project->{_CPP_SEISMIC};
	return ($CPP_SEISMIC);
}

sub DATA_GAMMA_WELL {
	_basic_dirs();
	_system_dirs();

	my $DATA_GAMMA_WELL = $Project->{_DATA_GAMMA_WELL};
	return ($DATA_GAMMA_WELL);
}

sub DATA_GAMMA_WELL_TXT {
	_basic_dirs();
	_system_dirs();

	my $DATA_GAMMA_WELL_TXT = $Project->{_DATA_GAMMA_WELL_TXT};
	return ($DATA_GAMMA_WELL_TXT);
}

sub DATA_GEOMAPS {
	_basic_dirs();
	_system_dirs();

	my $DATA_GEOMAPS = $Project->{_DATA_GEOMAPS};
	return ($DATA_GEOMAPS);
}

sub DATA_GEOMAPS_BIN {
	_basic_dirs();
	_system_dirs();

	my $DATA_GEOMAPS_BIN = $Project->{_DATA_GEOMAPS_BIN};
	return ($DATA_GEOMAPS_BIN);
}

sub DATA_GEOMAPS_TEXT {
	_basic_dirs();
	_system_dirs();

	my $DATA_GEOMAPS_TEXT = $Project->{_DATA_GEOMAPS_TEXT};

	#print("4. Project_config,DATA_GEOMAPS_TEXT,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");
	return ($DATA_GEOMAPS_TEXT);
}

sub DATA_GEOMAPS_TOPO {
	_basic_dirs();
	_system_dirs();

	my $DATA_GEOMAPS_TOPO = $Project->{_DATA_GEOMAPS_TOPO};
	return ($DATA_GEOMAPS_TOPO);
}

sub DATA_RESISTIVITY_SURFACE {
	_basic_dirs();
	_system_dirs();

	my $DATA_RESISTIVITY_SURFACE = $Project->{_DATA_RESISTIVITY_SURFACE};
	return ($DATA_RESISTIVITY_SURFACE);
}

sub DATA_RESISTIVITY_SURFACE_TXT {
	_basic_dirs();
	_system_dirs();

	my $DATA_RESISTIVITY_SURFACE_TXT = $Project->{_DATA_RESISTIVITY_SURFACE_TXT};
	return ($DATA_RESISTIVITY_SURFACE_TXT);
}

sub DATA_RESISTIVITY_WELL {
	_basic_dirs();
	_system_dirs();

	my $DATA_RESISTIVITY_WELL = $Project->{_DATA_RESISTIVITY_WELL};
	return ($DATA_RESISTIVITY_WELL);
}

sub DATA_RESISTIVITY_WELL_TXT {
	_basic_dirs();
	_system_dirs();

	my $DATA_RESISTIVITY_WELL_TXT = $Project->{_DATA_RESISTIVITY_WELL_TXT};
	return ($DATA_RESISTIVITY_WELL_TXT);
}

sub DATA_SEISMIC_BIN {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_BIN = $Project->{_DATA_SEISMIC_BIN};
	return ($DATA_SEISMIC_BIN);
}

sub DATA_SEISMIC_DAT {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_DAT = $Project->{_DATA_SEISMIC_DAT};
	return ($DATA_SEISMIC_DAT);
}

sub DATA_SEISMIC_ININT {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_ININT = $Project->{_DATA_SEISMIC_ININT};
	return ($DATA_SEISMIC_ININT);
}

sub DATA_SEISMIC_MATLAB {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_MATLAB = $Project->{_DATA_SEISMIC_MATLAB};
	return ($DATA_SEISMIC_MATLAB);
}

sub GEOMAPS_IMAGES {
	_basic_dirs();
	_system_dirs();

	my $GEOMAPS_IMAGES = $Project->{_GEOMAPS_IMAGES};
	return ($GEOMAPS_IMAGES);
}

sub GEOMAPS_IMAGES_JPEG {
	_basic_dirs();
	_system_dirs();

	my $GEOMAPS_IMAGES_JPEG = $Project->{_GEOMAPS_IMAGES_JPEG};
	return ($GEOMAPS_IMAGES_JPEG);
}

sub GEOMAPS_IMAGES_TIF {
	_basic_dirs();
	_system_dirs();

	my $GEOMAPS_IMAGES_TIF = $Project->{_GEOMAPS_IMAGES_TIF};
	return ($GEOMAPS_IMAGES_TIF);
}

sub GEOMAPS_IMAGES_PS {
	_basic_dirs();
	_system_dirs();

	my $GEOMAPS_IMAGES_PS = $Project->{_GEOMAPS_IMAGES_PS};
	return ($GEOMAPS_IMAGES_PS);
}

sub HOME {
	_basic_dirs();
	_system_dirs();

	my $HOME = $Project->{_HOME};
	return ($HOME);
}

sub PROJECT_HOME {
	_basic_dirs();
	_system_dirs();

	my $PROJECT_HOME = $Project->{_PROJECT_HOME};
	return ($PROJECT_HOME);
}

sub GMT_SEISMIC {
	_basic_dirs();
	_system_dirs();

	my $GMT_SEISMIC = $Project->{_GMT_SEISMIC};
	return ($GMT_SEISMIC);
}

sub GMT_GEOMAPS {
	_basic_dirs();
	_system_dirs();

	my $GMT_GEOMAPS = $Project->{_GMT_GEOMAPS};
	return ($GMT_GEOMAPS);
}

sub GRASS_GEOMAPS {
	_basic_dirs();
	_system_dirs();

	my $GRASS_GEOMAPS = $Project->{_GRASS_GEOMAPS};
	return ($GRASS_GEOMAPS);
}

sub DATA_SEISMIC {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC = $Project->{_DATA_SEISMIC};
	return ($DATA_SEISMIC);
}

sub DATA_SEISMIC_PASSCAL_SEGY {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_PASSCAL_SEGY = $Project->{_DATA_SEISMIC_PASSCAL_SEGY};
	return ($DATA_SEISMIC_PASSCAL_SEGY);
}

sub DATA_SEISMIC_R {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_R = $Project->{_DATA_SEISMIC_R};
	return ($DATA_SEISMIC_R);
}

sub DATA_SEISMIC_RSEIS {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_RSEIS = $Project->{_DATA_SEISMIC_RSEIS};
	return ($DATA_SEISMIC_RSEIS);
}

sub DATA_SEISMIC_SAC {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_SAC = $Project->{_DATA_SEISMIC_SAC};
	return ($DATA_SEISMIC_SAC);
}

sub DATA_SEISMIC_SEG2 {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_SEG2 = $Project->{_DATA_SEISMIC_SEG2};
	return ($DATA_SEISMIC_SEG2);
}

sub DATA_SEISMIC_SEGD {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_SEGD = $Project->{_DATA_SEISMIC_SEGD};
	return ($DATA_SEISMIC_SEGD);
}

sub DATA_SEISMIC_SEGY {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_SEGY = $Project->{_DATA_SEISMIC_SEGY};
	return ($DATA_SEISMIC_SEGY);
}

sub DATA_SEISMIC_SEGY_RAW {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_SEGY_RAW = $Project->{_DATA_SEISMIC_SEGY_RAW};
	return ($DATA_SEISMIC_SEGY_RAW);
}

sub DATA_SEISMIC_SIERRA_SEGY {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_SIERRA_SEGY = $Project->{_DATA_SEISMIC_SIERRA_SEGY};
	return ($DATA_SEISMIC_SIERRA_SEGY);
}

sub DATA_SEISMIC_SU {
	_basic_dirs();
	_system_dirs();

	my $DATA_SEISMIC_SU = $Project->{_DATA_SEISMIC_SU};

	control->set_infection($DATA_SEISMIC_SU);
	$DATA_SEISMIC_SU = $control->get_ticksBgone;

	return ($DATA_SEISMIC_SU);
}

sub DATA_SEISMIC_SU_RAW {
	_basic_dirs();
	_system_dirs();
	my $DATA_SEISMIC_SU_RAW = $Project->{_DATA_SEISMIC_SU_RAW};
	return ($DATA_SEISMIC_SU_RAW);
}

sub DATA_SEISMIC_TXT {
	_basic_dirs();
	_system_dirs();
	my $DATA_SEISMIC_TXT = $Project->{_DATA_SEISMIC_TXT};
	return ($DATA_SEISMIC_TXT);
}

sub DATA_SEISMIC_VEL {
	_basic_dirs();
	_system_dirs();
	my $DATA_SEISMIC_VEL = $Project->{_DATA_SEISMIC_VEL};
	return ($DATA_SEISMIC_VEL);
}

sub DATABASE_SEISMIC_SQLITE {
	_basic_dirs();
	_system_dirs();
	my $DATABASE_SEISMIC_SQLITE = $Project->{_DATABASE_SEISMIC_SQLITE};
	return ($DATABASE_SEISMIC_SQLITE);
}

sub DATA_SEISMIC_WELL {
	_basic_dirs();
	_system_dirs();
	my $DATA_SEISMIC_WELL = $Project->{_DATA_SEISMIC_WELL};
	return ($DATA_SEISMIC_WELL);
}

sub DATA_SEISMIC_WELL_SYNSEIS {
	_basic_dirs();
	_system_dirs();
	my $DATA_SEISMIC_WELL_SYNSEIS = $Project->{_DATA_SEISMIC_WELL_SYNSEIS};
	return ($DATA_SEISMIC_WELL_SYNSEIS);
}

sub DATA_WELL {
	_basic_dirs();
	_system_dirs();
	my $DATA_WELL = $Project->{_DATA_WELL};
	return ($DATA_WELL);
}

sub FAST_TOMO {
	_basic_dirs();
	_system_dirs();
	my $FAST_TOMO = $Project->{_FAST_TOMO};

	# This subroutine returns the value of FAST_TOMO
	#print ("\n$FAST_TOMO\n");
	return ($FAST_TOMO);
}

sub GEOPSY {
	_basic_dirs();
	_system_dirs();
	my $GEOPSY = $Project->{_GEOPSY};
	return ($GEOPSY);
}

sub GEOPSY_PARAMS {
	_basic_dirs();
	_system_dirs();
	my $GEOPSY_PARAMS = $Project->{_GEOPSY_PARAMS};
	return ($GEOPSY_PARAMS);
}

sub GEOPSY_PICKS {
	_basic_dirs();
	_system_dirs();
	my $GEOPSY_PICKS = $Project->{_GEOPSY_PICKS};
	return ($GEOPSY_PICKS);
}

sub GEOPSY_PICKS_RAW {
	_basic_dirs();
	_system_dirs();
	my $GEOPSY_PICKS_RAW = $Project->{_GEOPSY_PICKS_RAW};
	return ($GEOPSY_PICKS_RAW);
}

sub GEOPSY_PROFILES {
	_basic_dirs();
	_system_dirs();
	my $GEOPSY_PROFILES = $Project->{_GEOPSY_PROFILES};
	return ($GEOPSY_PROFILES);
}

sub GEOPSY_REPORTS {
	_basic_dirs();
	_system_dirs();
	my $GEOPSY_REPORTS = $Project->{_GEOPSY_REPORTS};
	return ($GEOPSY_REPORTS);
}

sub GEOPSY_TARGETS {
	_basic_dirs();
	_system_dirs();
	my $GEOPSY_TARGETS = $Project->{_GEOPSY_TARGETS};
	return ($GEOPSY_TARGETS);
}

sub GIF_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $GIF_SEISMIC = $Project->{_GIF_SEISMIC};
	return ($GIF_SEISMIC);
}

sub ISOLA {
	_basic_dirs();
	_system_dirs();
	my $ISOLA = $Project->{_ISOLA};
	return ($ISOLA);
}

sub JPEG {
	_basic_dirs();
	_system_dirs();
	my $JPEG = $Project->{_JPEG};
	return ($JPEG);
}

sub JPEG_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $JPEG_SEISMIC = $Project->{_JPEG_SEISMIC};
	return ($JPEG_SEISMIC);
}

sub C_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $C_SEISMIC = $Project->{_C_SEISMIC};
	return ($C_SEISMIC);
}

sub MATLAB_GEOMAPS {
	_basic_dirs();
	_system_dirs();
	my $MATLAB_GEOMAPS = $Project->{_MATLAB_GEOMAPS};
	return ($MATLAB_GEOMAPS);
}

sub MATLAB_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $MATLAB_SEISMIC = $Project->{_MATLAB_SEISMIC};
	return ($MATLAB_SEISMIC);
}

sub MATLAB_WELL {
	_basic_dirs();
	_system_dirs();
	my $MATLAB_WELL = $Project->{_MATLAB_WELL};
	return ($MATLAB_WELL);
}

sub MMODPG {
	_basic_dirs();
	_system_dirs();

	my $MMODPG = $Project->{_MMODPG};
	return ($MMODPG);
}

sub IMMODPG  {
	_basic_dirs();
	_system_dirs();

	my $IMMODPG = $Project->{_IMMODPG};
#	print("Project_config, IMMODPG=$IMMODPG \n");
	return ($IMMODPG);
}

sub IMMODPG_INVISIBLE {
	_basic_dirs();
	_system_dirs();

	my $IMMODPG_INVISIBLE = $Project->{_IMMODPG_INVISIBLE};
	return ($IMMODPG_INVISIBLE);
	
}

sub MOD2D_TOMO {
	_basic_dirs();
	_system_dirs();
	my $MOD2D_TOMO = $Project->{_MOD2D_TOMO};
	return ($MOD2D_TOMO);
}

sub PL_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $PL_SEISMIC_h = $Project->{_PL_SEISMIC};
	control->set_infection($PL_SEISMIC_h);
	my $PL_SEISMIC = $control->get_ticksBgone;

	# This subroutine returns the value of PL_SEISMIC
	# print ("\nProject_config, PL_SEISMIC,PL_SEISMIC: $PL_SEISMIC\n");
	return ($PL_SEISMIC);
}

sub PL_GEOMAPS {
	_basic_dirs();
	_system_dirs();
	my $PL_GEOMAPS = $Project->{_PL_GEOMAPS};
	return ($PL_GEOMAPS);
}

sub PL_WELL {
	_basic_dirs();
	_system_dirs();
	my $PL_WELL = $Project->{_PL_WELL};
	return ($PL_WELL);
}

sub RESISTIVITY_SURFACE {
	_basic_dirs();
	_system_dirs();
	my $RESISTIVITY_SURFACE = $Project->{_RESISTIVITY_SURFACE};
	return ($RESISTIVITY_SURFACE);
}

sub R_GAMMA_WELL {
	_basic_dirs();
	_system_dirs();
	my $R_GAMMA_WELL = $Project->{_R_GAMMA_WELL};
	return ($R_GAMMA_WELL);
}

sub R_RESISTIVITY_SURFACE {
	_basic_dirs();
	_system_dirs();
	my $R_RESISTIVITY_SURFACE = $Project->{_R_RESISTIVITY_SURFACE};
	return ($R_RESISTIVITY_SURFACE);
}

sub R_RESISTIVITY_WELL {
	_basic_dirs();
	_system_dirs();
	my $R_RESISTIVITY_WELL = $Project->{_R_RESISTIVITY_WELL};
	return ($R_RESISTIVITY_WELL);
}

sub R_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $R_SEISMIC = $Project->{_R_SEISMIC};
	return ($R_SEISMIC);
}

sub R_WELL {
	_basic_dirs();
	_system_dirs();
	my $R_WELL = $Project->{_R_WELL};
	return ($R_WELL);
}

sub SH_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $SH_SEISMIC = $Project->{_SH_SEISMIC};
	return ($SH_SEISMIC);
}

sub PS_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $PS_SEISMIC = $Project->{_PS_SEISMIC};
	return ($PS_SEISMIC);
}

sub PS_WELL {
	_basic_dirs();
	_system_dirs();
	my $PS_WELL = $Project->{_PS_WELL};
	return ($PS_WELL);
}

sub RAYINVR {
	_basic_dirs();
	_system_dirs();
	my $RAYINVR = $Project->{_RAYINVR};

	# This subroutine returns the value of RAYINVR
	#print ("\n$RAYINVR\n");
	return ($RAYINVR);
}

sub SURFACE {
	_basic_dirs();
	_system_dirs();
	my $SURFACE = $Project->{_SURFACE};
	return ($SURFACE);
}

sub TEMP_DATA_GEOMAPS {
	_basic_dirs();
	_system_dirs();
	my $TEMP_DATA_GEOMAPS = $Project->{_TEMP_DATA_GEOMAPS};
	return ($TEMP_DATA_GEOMAPS);
}

sub TEMP_DATA_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $TEMP_DATA_SEISMIC = $Project->{_TEMP_DATA_SEISMIC};
	return ($TEMP_DATA_SEISMIC);
}

sub TEMP_DATA_SEISMIC_SU {
	_basic_dirs();
	_system_dirs();
	my $TEMP_DATA_SEISMIC_SU = $Project->{_TEMP_DATA_SEISMIC_SU};
	return ($TEMP_DATA_SEISMIC_SU);
}

sub TEMP_FAST_TOMO {
	_basic_dirs();
	_system_dirs();
	my $TEMP_FAST_TOMO = $Project->{_TEMP_FAST_TOMO};
	return ($TEMP_FAST_TOMO);
}

sub WELL {
	_basic_dirs();
	_system_dirs();
	my $WELL = $Project->{_WELL};
	return ($WELL);
}

=head2 Creates necessary directories
 
=cut

sub make_local_dirs {

	# Always create basic types
	my $PROJECT_HOME = $Project->{_PROJECT_HOME};
	my $HOME         = $Project->{_HOME};

	# manage_dirs_by::make_dir($HOME);
	manage_dirs_by::make_dir($PROJECT_HOME);

	# BY data type
	# CATEGORY GEOMAPS images and data
	my $DATA_GEOMAPS        = $Project->{_DATA_GEOMAPS};
	my $GEOMAPS_IMAGES      = $Project->{_GEOMAPS_IMAGES};
	my $GEOMAPS_IMAGES_JPEG = $Project->{_GEOMAPS_IMAGES_JPEG};
	my $GEOMAPS_BIN         = $Project->{_GEOMAPS_BIN};
	my $GEOMAPS_IMAGES_TIF  = $Project->{_GEOMAPS_IMAGES_TIF};
	my $GEOMAPS_IMAGES_PS   = $Project->{_GEOMAPS_IMAGES_PS};
	my $GEOPSY              = $Project->{_GEOPSY};
	my $GEOPSY_PARAMS       = $Project->{_GEOPSY_PARAMS};
	my $GEOPSY_PICKS        = $Project->{_GEOPSY_PICKS};
	my $GEOPSY_PICKS_RAW    = $Project->{_GEOPSY_PICKS_RAW};
	my $GEOPSY_PROFILES     = $Project->{_GEOPSY_PROFILES};
	my $GEOPSY_REPORTS      = $Project->{_GEOPSY_REPORTS};
	my $GEOPSY_TARGETS      = $Project->{_GEOPSY_TARGETS};
	my $DATA_GEOMAPS_TEXT   = $Project->{_DATA_GEOMAPS_TEXT};
	my $DATA_GEOMAPS_TOPO   = $Project->{_DATA_GEOMAPS_TOPO};
	my $TEMP_DATA_GEOMAPS   = $Project->{_TEMP_DATA_GEOMAPS};
	my $GMT_GEOMAPS         = $Project->{_GMT_GEOMAPS};
	my $GRASS_GEOMAPS       = $Project->{_GRASS_GEOMAPS};
	my $GMT_SEISMIC         = $Project->{_GMT_SEISMIC};

	#manage_dirs_by::make_dir($GEOMAPS_BIN);
	#manage_dirs_by::make_dir($GEOMAPS_IMAGES_TIF);
	# print("1. Project_configDATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");
	# manage_dirs_by::make_dir($DATA_GEOMAPS_TOPO);
	#manage_dirs_by::make_dir($TEMP_DATA_GEOMAPS);

	# pl programs and geomaps
	my $PL_GEOMAPS = $Project->{_PL_GEOMAPS};

	# matlab and geomaps
	my $MATLAB_GEOMAPS = $Project->{_MATLAB_GEOMAPS};

	# matlab and seismic is default
	my $MATLAB_SEISMIC = $Project->{_MATLAB_SEISMIC};

	# CATEGORY well data and R and Perl and Matlab
	my $MATLAB_WELL = $Project->{_MATLAB_WELL};

	if ( $Project->{_geomaps_is_selected} ) {
		manage_dirs_by::make_dir($DATA_GEOMAPS);
		manage_dirs_by::make_dir($GEOMAPS_IMAGES);
		manage_dirs_by::make_dir($GEOMAPS_IMAGES_JPEG);
		manage_dirs_by::make_dir($GEOMAPS_IMAGES_PS);
		manage_dirs_by::make_dir($DATA_GEOMAPS_TEXT);
		manage_dirs_by::make_dir($PL_GEOMAPS);
	}

	if ( $Project->{_geopsy_is_selected} ) {
		manage_dirs_by::make_dir($GEOPSY);
		manage_dirs_by::make_dir($GEOPSY_PARAMS);
		manage_dirs_by::make_dir($GEOPSY_PICKS);
		manage_dirs_by::make_dir($GEOPSY_PICKS_RAW);
		manage_dirs_by::make_dir($GEOPSY_PROFILES);
		manage_dirs_by::make_dir($GEOPSY_REPORTS);
		manage_dirs_by::make_dir($GEOPSY_TARGETS);
	}

	if ( $Project->{_grass_is_selected} ) {
		manage_dirs_by::make_dir($GEOMAPS_IMAGES);
		manage_dirs_by::make_dir($GEOMAPS_IMAGES_JPEG);
		manage_dirs_by::make_dir($GEOMAPS_IMAGES_PS);
		manage_dirs_by::make_dir($PL_GEOMAPS);
	}

	if ( $Project->{_matlab_is_selected} ) {
		manage_dirs_by::make_dir($MATLAB_SEISMIC);
	}

	if ( $Project->{_matlab_is_selected} && $Project->{_geomaps_is_selected} ) {
		manage_dirs_by::make_dir($MATLAB_GEOMAPS);
	}

	# sh scripts and seismic
	my $SH_SEISMIC = $Project->{_SH_SEISMIC};

	# Always create
	manage_dirs_by::make_dir($SH_SEISMIC);

	# CATEGORY well data and R and Perl and Matlab
	my $R_WELL  = $Project->{_R_WELL};
	my $WELL    = $Project->{_WELL};
	my $PL_WELL = $Project->{_PL_WELL};

	# my $MATLAB_WELL       			= $Project->{_MATLAB_WELL};
	# manage_dirs_by::make_dir($R_WELL)
	# manage_dirs_by::make_dir($WELL);
	# pl programs and wells
	# manage_dirs_by::make_dir($PL_WELL);
	# matlab programs and wells
	# manage_dirs_by::make_dir($MATLAB_WELL);

	# CATEGORY well and images
	my $PS_WELL = $Project->{_PS_WELL};

	# manage_dirs_by::make_dir($PS_WELL);

	# CATEGORY seismic data
	my $DATA_SEISMIC = $Project->{_DATA_SEISMIC};

	# CATEGORY seismics and images
	my $PS_SEISMIC   = $Project->{_PS_SEISMIC};
	my $GIF_SEISMIC  = $Project->{_GIF_SEISMIC};
	my $JPEG_SEISMIC = $Project->{_JPEG_SEISMIC};
	my $PL_SEISMIC   = $Project->{_PL_SEISMIC};

	# manage_dirs_by::make_dir($GIF_SEISMIC);

	# Always create imag efiles
	manage_dirs_by::make_dir($JPEG_SEISMIC);
	manage_dirs_by::make_dir($PS_SEISMIC);

	# manage_dirs_by::make_dir($TEMP_DATA_SEISMIC);

	my $DATA_SEISMIC_DAT  = $Project->{_DATA_SEISMIC_DAT};
	my $DATA_SEISMIC_SEG2 = $Project->{_DATA_SEISMIC_SEG2};

	# Always create
	# manage_dirs_by::make_dir($DATA_SEISMIC_DAT);
	manage_dirs_by::make_dir($DATA_SEISMIC_SEG2);

	# Format nint and seismic data
	my $DATA_SEISMIC_ININT = $Project->{_DATA_SEISMIC_ININT};

	# manage_dirs_by::make_dir($DATA_SEISMIC_ININT);

	# Format matlab and seismic data
	# manage_dirs_by::make_dir($DATA_SEISMIC_MATLAB);

	# gmt programs with map and seismic data
	if ( $Project->{_gmt_is_selected} ) {
		manage_dirs_by::make_dir($GMT_GEOMAPS);
	}

	# grass programs with map  data
	if ( $Project->{_grass_is_selected} ) {
		manage_dirs_by::make_dir($GRASS_GEOMAPS);
	}

	# By programs
	# sqlite
	my $DATABASE_SEISMIC_SQLITE = $Project->{_DATABASE_SEISMIC_SQLITE};

	if ( $Project->{_sqlite_is_selected} ) {
		manage_dirs_by::make_dir($DATABASE_SEISMIC_SQLITE);
	}

	# sioseis

	# mmodpg-deprecated
	my $MMODPG = $Project->{_MMODPG};
	my $IMMODPG_INVISIBLE = $Project->{_IMMODPG_INVISIBLE};
	
	if ( $Project->{_mmodpg_is_selected} ) {
		
		print("Project_config,IMMODPG= $MMODPG\n");
		manage_dirs_by::make_dir($MMODPG);
		manage_dirs_by::make_dir($IMMODPG_INVISIBLE);	
		
	}

	# immodpg
	my $IMMODPG = $Project->{_IMMODPG};
	
	if ( $Project->{_immodpg_is_selected} ) {
		
#		("Project_config,IMMODPG= $IMMODPG\n");
#		print("Project_config,IMMODPG_INVISIBLE= $IMMODPG_INVISIBLE\n");
		manage_dirs_by::make_dir($IMMODPG);
		manage_dirs_by::make_dir($IMMODPG_INVISIBLE);
		
	}

	# fast tomography
	my $TEMP_FAST_TOMO = $Project->{_TEMP_FAST_TOMO};

	# manage_dirs_by::make_dir($TEMP_FAST_TOMO);

	# isola
	my $ISOLA = $Project->{_ISOLA};

	# manage_dirs_by::make_dir($ISOLA);

	# antelope
	my $ANTELOPE = $Project->{_ANTELOPE};

	# manage_dirs_by::make_dir($ANTELOPE);

	# pl programs and seismic data
	# Always create
	manage_dirs_by::make_dir($PL_SEISMIC);

	# Format segy and seismic data
	my $DATA_SEISMIC_SEGY     = $Project->{_DATA_SEISMIC_SEGY};
	my $DATA_SEISMIC_SEGY_RAW = $Project->{_DATA_SEISMIC_SEGY_RAW};

	# Always create
	manage_dirs_by::make_dir($DATA_SEISMIC_SEGY);

	# manage_dirs_by::make_dir($DATA_SEISMIC_SEGY_RAW);

	# program R and format rseis seismic data
	my $DATA_SEISMIC_R     = $Project->{_DATA_SEISMIC_R};
	my $DATA_SEISMIC_RSEIS = $Project->{_DATA_SEISMIC_RSEIS};

	# manage_dirs_by::make_dir($DATA_SEISMIC_RSEIS);
	# manage_dirs_by::make_dir($DATA_SEISMIC_R);

	# program R and seismic data
	my $R_SEISMIC = $Project->{_R_SEISMIC};

	# manage_dirs_by::make_dir($R_SEISMIC);

	# Format passcal segy and seismic data
	my $DATA_SEISMIC_PASSCAL_SEGY = $Project->{_DATA_SEISMIC_PASSCAL_SEGY};

	# manage_dirs_by::make_dir($DATA_SEISMIC_PASSCAL_SEGY);

	# Format sierra segy and seismic data
	my $DATA_SEISMIC_SIERRA_SEGY = $Project->{_DATA_SEISMIC_SIERRA_SEGY};

	# manage_dirs_by::make_dir($DATA_SEISMIC_SIERRA_SEGY);

	# Format segd and seismic data
	my $DATA_SEISMIC_SEGD = $Project->{_DATA_SEISMIC_SEGD};

	# manage_dirs_by::make_dir($DATA_SEISMIC_SEGD);

	# Format sac and seismic data
	my $DATA_SEISMIC_SAC = $Project->{_DATA_SEISMIC_SAC};

	# manage_dirs_by::make_dir($DATA_SEISMIC_SAC);

	# Format su and seismic data
	my $DATA_SEISMIC_SU      = $Project->{_DATA_SEISMIC_SU};
	my $DATA_SEISMIC_SU_RAW  = $Project->{_DATA_SEISMIC_SU_RAW};
	my $TEMP_DATA_SEISMIC_SU = $Project->{_TEMP_DATA_SEISMIC_SU};

	# Always create
	manage_dirs_by::make_dir($DATA_SEISMIC_SU);

	#manage_dirs_by::make_dir($DATA_SEISMIC_SU_RAW);
	# manage_dirs_by::make_dir($TEMP_DATA_SEISMIC_SU);

	# Format txt and seismic data
	my $DATA_SEISMIC_TXT = $Project->{_DATA_SEISMIC_TXT};

	# Always create
	manage_dirs_by::make_dir($DATA_SEISMIC_TXT);

	#Format bin	 and seismic data
	my $DATA_SEISMIC_BIN = $Project->{_DATA_SEISMIC_BIN};

	# Always create
	manage_dirs_by::make_dir($DATA_SEISMIC_BIN);

	# CATEGORY resistivity data
	# location surface
	# and program R
	my $R_RESISTIVITY_SURFACE        = $Project->{_R_RESISTIVITY_SURFACE};
	my $DATA_RESISTIVITY_SURFACE     = $Project->{_DATA_RESISTIVITY_SURFACE};
	my $DATA_RESISTIVITY_SURFACE_TXT = $Project->{_DATA_RESISTIVITY_SURFACE_TXT};

	# manage_dirs_by::make_dir($R_RESISTIVITY_SURFACE);
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_SURFACE);
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_SURFACE_TXT);

	# CATEGORY resistivity data
	# location well
	# and program R
	my $R_RESISTIVITY_WELL        = $Project->{_R_RESISTIVITY_WELL};
	my $DATA_RESISTIVITY_WELL     = $Project->{_DATA_RESISTIVITY_WELL};
	my $DATA_RESISTIVITY_WELL_TXT = $Project->{_DATA_RESISTIVITY_WELL_TXT};

	# manage_dirs_by::make_dir($R_RESISTIVITY_WELL);
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_WELL);
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_WELL_TXT);

	#CATEGORY GAMMA data
	# location well
	# and program R
	# my $R_GAMMA_WELL  		 = $Project->{_R_GAMMA_WELL};
	# my $DATA_GAMMA_WELL_TXT  = $Project->{_DATA_GAMMA_WELL_TXT};
	# manage_dirs_by::make_dir($R_GAMMA_WELL);
	# manage_dirs_by::make_dir($DATA_GAMMA_WELL_TXT);

	# manage_dirs_by::make_dir($DATA_WELL);

	# Always create new wells and their data
	my $DATA_SEISMIC_WELL_SYNSEIS = $Project->{_DATA_SEISMIC_WELL_SYNSEIS};
	manage_dirs_by::make_dir($DATA_SEISMIC_WELL_SYNSEIS);

	# c PROGRAMS
	# manage_dirs_by::make_dir($C_SEISMIC);

	# C ++ PROGRAMS
	# manage_dirs_by::make_dir($CPP_SEISMIC);

	return ();
}

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
	my ($self) = @_;

	my $max_index = 14;

	return ($max_index);
}

=head2 sub update_configuration_files

	saves the configuration file to:
		./L_SU/configuration/active/Project.config
	saves the configuration file to:
		 ./L_SU/configuration/Project_name/Project.config

=cut

sub update_configuration_files {
	my ($self) = @_;

	use Shell qw(echo);

	my $home_directory = ` echo \$HOME`;
	chomp $home_directory;

	my $HOME = $home_directory;

	use File::Copy;
	use control;
	use dirs;
	use readfiles;

	my $ACTIVE_CONFIGURATION = $HOME . '/.L_SU/configuration/active';
	my $inbound              = $ACTIVE_CONFIGURATION . '/Project.config';

	my $readfiles = readfiles->new();
	my $dirs      = dirs->new();
	my $control   = control->new();

	my $project = {
		_names_aref         => '',
		_values_aref        => '',
		_check_buttons_aref => '',
	};

	my ( $names_aref, $values_aref ) = $readfiles->configs($inbound);

	$project->{_names_aref}  = $names_aref;
	$project->{_values_aref} = $values_aref;
	my $Project_site = @{ $project->{_values_aref} }[2];

	# print("Project_config, update_configuration_files,Project site= $Project_site\n");
	# print("Project_config, update_configuration_files,project->{_values_aref:@{$project->{_values_aref}}\n");

	my $PROJECT_PATH = @{ $project->{_values_aref} }[1];
	$dirs->set_path($Project_site);
	my $Project_name = $dirs->get_last_dirInpath();
	$control->set_infection($Project_name);
	$Project_name = $control->get_ticksBgone();

	# print("Project_config,update_configuration_file, PROJECT_PATH: $PROJECT_PATH\n");
	# print("Project_config,update_configuration_file, Project_name: $Project_name \n");

	my $FROM_project_config = $inbound;
	my $TO_project_config   = $HOME . '/.L_SU/configuration/' . $Project_name . '/Project.config';

	# print("Project_config,update_configuration_files copying from $FROM_project_config to $TO_project_config\n");
	copy( $FROM_project_config, $TO_project_config );

	return ();
}

1;
