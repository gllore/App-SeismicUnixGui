use strict;
use warnings;

use 5.26.1;
use ExtUtils::MakeMaker;
#use File::ShareDir ':ALL';
#use File::ShareDir::Install;

#my $my_distribution_directory =  'dist';
#install_share $my_distribution_directory;
#install_share dist => $my_distribution_directory;


WriteMakefile(
	NAME          => 'App::SeismicUnixGui',
	AUTHOR        => 'Juan Lorenzo <gllore@lsu.edu>',
	VERSION_FROM  => 'lib/App/SeismicUnixGui.pm',
	ABSTRACT_FROM => 'lib/App/SeismicUnixGui.pm',
	LICENSE       => 'perl',
	PREREQ_PM     => {
		'Clone'           => '0.45',
		'File::Slurp'     => '9999.32',
		'MIME::Base64'    => '3.16',
		'Moose'           => '2.2015',
		'PDL::Core'       => '2.028',
		'Module::Refresh' => '0.17',
		'Shell'           => '0.73.1',
		'Time::HiRes'     => '1.9764',
		'Tk'              => '804.036',
		'Tk::JFileDialog' => '2.20',
		'aliased'         => '0.34',
	},

	TEST_REQUIRES => {
		#          'Test::More' => '0.47'
	},

	# only needed during build but not later
	BUILD_REQUIRES => {
		#		'Other::Module' => '0'
	},

	# required scripts
	PL_FILES => {
		'./lib/App/SeismicUnixGui/script/post_install_env.pl' => 'SeismicUnixGui',
#		'./lib/SeismicUnixGui/script/post_installation_c_compile.pl' => 'SeismicUnixGui',
	},

	# Documentation accessible within the GUI with Mouse-button-3 click
	# So separate file files are not used
	MAN3PODS => {},

	dist => {
		COMPRESS => 'gzip -9f',
		SUFFIX   => 'gz',

	}

);
 
## Where are distribution-level shared data files kept
#my $system_distribution_directory = dist_dir('App-SeismicUnixGui');
#print("my system_distribution_directory= $system_distribution_directory\n");
#system ("perl $system_distribution_directory/post_installation.pl");
