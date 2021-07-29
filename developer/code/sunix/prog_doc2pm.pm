package prog_doc2pm;

=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  prog_doc2pm.pm						

 AUTHOR: Juan Lorenzo
 DATE:   Nov 14 2018 
 DESCRIPTION: 
 			package of to access programs
 			for which a module is to be made
 
 Version: 1.0.0

=head2 USE

=head3 NOTES

=head4 Examples
my $selected_program_name = 'sugetgthr';
=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut

use Moose;

our $VERSION = '0.0.1';
use L_SU_global_constants();

my $get = new L_SU_global_constants();

my $var          = $get->var();
my $empty_string = $var->{_empty_string};

my $prog_doc2pm = {
	_list_length     => '',
	_list_names_aref => '',
	_group_directory => '',
	_path            => '',
};

=head2 declaration of local variables

=cut

my ( @file_in, @pm_file_out, @package_name, @program_name );
my (@config_file_out);
my ( @spec_file_out, @program_group, $group_no );
my ( @inbound,       @path_out,      $path );

=head2 definitions

=cut

# a local copy of the documentation
$program_group[0]  = 'data';
$program_group[1]  = 'datuming';
$program_group[2]  = 'display';
$program_group[3]  = 'filter';
$program_group[4]  = 'inversion';
$program_group[5]  = 'metadata';
$program_group[6]  = 'migration';
$program_group[7]  = 'misc';
$program_group[8]  = 'model';
$program_group[9]  = 'NMO_Vel_Stk';
$program_group[10] = 'par';
$program_group[11] = 'picking';
$program_group[12] = 'shapeNcut';
$program_group[13] = 'shell';
$program_group[14] = 'statsMath';
$program_group[15] = 'transform';
$program_group[16] = 'well';

#  	$program_name[0] 		= 'suxgraph';
# 	$program_name[1] 		= 'xgraph';
# 	$program_name[2]		= 'supef';
# 	$program_name[3]		= 'suacor';
# 	$program_name[4]		= 'sugain';
#  	$program_name[5]		= 'xwigb';
# 	$program_name[6]		= 'suxwigb';
# 	$program_name[7]		= 'sufilter';
#  	$program_name[8]		= 'sufft';
#   	$program_name[9]		= 'suamp';
#   	$program_name[10]		= 'surange';
#   	$program_name[11]		= 'sustolt';
# 	$program_name[12] 		= 'a2b';
#  	$program_name[13] 		= 'sustrip';
#   	$program_name[14] 		= 'ximage';
#   	$program_name[15] 		= 'suximage';
#  	$program_name[16] 		= 'b2a';
#   	$program_name[17] 		= 'sustrip';
#   	$program_name[18] 		= 'sugethw';
#   	$program_name[19] 		= 'swapbytes';
#   	$program_name[20] 		= 'sushw';
#   	$program_name[21] 		= 'suwind';
#   	$program_name[22]		= 'suop';
#   	$program_name[23]		= 'suop2';
#    $program_name[24]		= 'data_in';
#    $program_name[25]		= 'data_out';
#    $program_name[26] 		= 'suchw';
#    $program_name[27]       = 'sudipfilt';
#    $program_name[28]       = 'suspecfk';
#    $program_name[29]       = 'suinterp';
#    $program_name[30]       = 'suvelan';
#    $program_name[31]       = 'susort';
#    $program_name[32]       = 'sustack';
#    $program_name[33]       = 'sunmo';
#    $program_name[34]       = 'sumute';
#    $program_name[35]       = 'mkparfile';
#    $program_name[36]       = 'makevel';
#    $program_name[37]		= 'a2i';
#    $program_name[38]		= 'sugetgthr';
#
# 	$file_in[0] 			= 'suxgraph.su.graphics.xplot';
# 	$file_in[1] 			= 'xgraph.Xtcwp.main';
# 	$file_in[2] 			= 'supef.su.main.decon_shaping';
# 	$file_in[3]				= 'suacor.su.main.convolution_correlation';
#	$file_in[4]				= 'sugain.su.main.amplitudes';
#	$file_in[5]				= 'xwigb.xplot.main';
#	$file_in[6]				= 'suxwigb.su.graphics.xplot';
#	$file_in[7]				= 'sufilter.su.main.filters';
#	$file_in[8]				= 'sufft.su.main.transforms';
#	$file_in[9]				= 'suamp.su.main.transforms';
#	$file_in[10]			= 'surange.su.main.headers';
#	$file_in[11]			= 'sustolt.su.main.migration_inversion';
# 	$file_in[12] 			= 'a2b.par.main';
# 	$file_in[13] 			= 'sustrip.su.main.headers';
# 	$file_in[14]			= 'ximage.xplot.main';
#  	$file_in[15]			= 'suximage.su.graphics.xplot';
#  	$file_in[16] 			= 'b2a.par.main';
#  	$file_in[17]			= 'sustrip.su.main.headers';
#  	$file_in[18]			= 'sugethw.su.main.headers';
#  	$file_in[19]			= 'swapbytes.par.main';
#   	$file_in[20]			= 'sushw.su.main.headers';
#   	$file_in[21]			= 'suwind.su.main.windowing_sorting_muting';
#   	$file_in[22]			= 'suop.su.main.operations';
#   	$file_in[23]			= 'suop2.su.main.operations';
#    $file_in[24]			= '';
#    $file_in[25]			= '';
#    $file_in[26]			= 'suchw.su.main.headers';
#    $file_in[27]			= 'sudipfilt.su.main.filters';
#    $file_in[28]			= 'suspecfk.su.main.transforms';
#    $file_in[29] 			= 'suinterp.su.main.interp_extrap';
#    $file_in[30] 			= 'suvelan.su.main.velocity_analysis';
#    $file_in[31] 			= 'susort.su.main.windowing_sorting_muting';
#    $file_in[32] 			= 'sustack.su.main.stacking';
#    $file_in[33] 			= 'sunmo.su.main.stretching_moveout_resamp';
#    $file_in[34]            = 'sumute.su.main.windowing_sorting_muting';
#    $file_in[35]			= 'mkparfile.par.main';
#    $file_in[36]			= 'makevel.par.main';
#    $file_in[37]			= 'a2i.par.main';
#    $file_in[38]		    = 'sugetgthr.su.main.windowing_sorting_muting';

# which program number do you want to use to create
# *.pm, *.config, and *_spec.pm files ?
#	my $first_idx 	 					= 38;
#	my $last_idx						= 38;

#
#		$file[0] 				= $file_in[$i];
#		print("sudoc2pm.pl, reading $path/$file[0]\n");

=head2 sub _get_list_aref 
List of file names from within a directory
	
=cut

sub _get_list_aref {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		my $list_aref;
		my $path_in   = _get_path_in();
		my $directory = $prog_doc2pm->{_group_directory};
		$prog_doc2pm->{_path} = $path_in . '/Stripped/' . $directory;
		my $path = $prog_doc2pm->{_path};

		# print("prog_doc2pm,_get_list_aref, PATH:$prog_doc2pm->{_path}\n");

		opendir my $dh, $path or die "Could not open '$path' for reading: $!\n";
		
		my @file_name;
		my $thing;
		my @name;
		
		while ( defined( $thing = readdir $dh) ) {

			$thing =~ s/\///;
#			print("prog_doc2pm,count=$count; file_name=$thing\___\n");

			 if (not($thing =~ /^\.\.?$/)) { 
				
			    (@name) = split( /\./, $thing);
				push @file_name, $name[0];
#				print("prog_doc2pm,file_name=$name[0]\___\n");
				
			} else { # skip . and ..
#				print("prog_doc2pm, skipping\___\n");
			}

			$list_aref = \@file_name;
		}
		closedir $dh;

		# print("prog_doc2pm,_get_list_aref,file_names=@file_name\n");
		return ($list_aref);

	} else {
		print("prog_doc2pm, _get_list_aref, missing group no,\n");
		return ();
	}

}

=head2 sub _get_path_in


=cut

sub _get_path_in {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		# my $path 	= '/usr/local/cwp_su_all_48/src/doc/Stripped';
		my $L_SU_env = $ENV{'L_SU'};

		# print "prog_doc2pm, $L_SU_env\n";
		my $path_in = $L_SU_env . '/developer';

		# print("prog_doc2pm,_get_path_in = $path_in\n");
		return ($path_in);

	} else {
		print("prog_doc2pm, _get_path_in, missing directory,\n");
		return ();
	}
}

=head2 sub get_group_directory 


=cut

sub get_group_directory {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		$prog_doc2pm->{_group_directory} = $program_group[$group_no];

		#print("prog_doc2pm, get_group_directory,$prog_doc2pm->{_group_directory}\n");

	} else {
		print("prog_doc2pm, get_group_directory, missing group no,\n");
	}
}

=head2 sub get_list_aref 


=cut

sub get_list_aref {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		my $list_aref;
		my $path_in = _get_path_in();

		my $directory = $prog_doc2pm->{_group_directory};
		$prog_doc2pm->{_path} = $path_in . '/Stripped/' . $directory;
		my $path = $prog_doc2pm->{_path};
		# print("prog_doc2pm,get_list_aref, PATH:$prog_doc2pm->{_path}\n");

		opendir my $dh, $path or die "Could not open '$path' for reading: $!\n";

		my @file_name;
		my @name;
		my $thing;
		
		while ( defined( $thing = readdir $dh) ) {

			$thing =~ s/\///;

			 if ( not($thing =~ /^\.\.?$/)) {
				
				push @file_name, $thing;
#				print("prog_doc2pm,ile_name=$thing\___\n");
				
			} else { # skip . and ..
#				print("prog_doc2pm, skipping\___\n");
			}
			$list_aref = \@file_name;
		}
		closedir $dh;

		# print("prog_doc2pm,get_list_aref,file_names=@file_name\n");
		return ($list_aref);

	} else {
		print("prog_doc2pm, get_list_aref, missing group no,\n");
		return ();
	}
}

=head2 sub get_list_length 

=cut

sub get_list_length {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		my $length = ( scalar @{ _get_list_aref() } );

#		print("prog_doc2pm,get_list_length,length= $length \n");
		return ($length);

	} else {
		print("prog_doc2pm, get_list_length, missing group no,\n");
		return ();
	}
}

=head2 sub get_path_in


=cut

sub get_path_in {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		# my $path 	= '/usr/local/cwp_su_all_48/src/doc/Stripped';
		my $dir = $prog_doc2pm->{_group_directory};

		my $L_SU_env = $ENV{'L_SU'};

		# print "prog_doc2pm,get_path_in, $L_SU_env\n";
		my $path_in = $L_SU_env . '/developer/Stripped' . '/' . $dir;

		# print("prog_doc2pm,get_path_in = $path_in\n");
		return ($path_in);

	} else {
		print("prog_doc2pm, get_,path_in missing directory,\n");
		return ();
	}
}

=head2 sub get_config_path_out


=cut

sub get_config_path_out {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		# my $path 	= '/usr/local/pl/L_SU/configs';
		my $dir      = $prog_doc2pm->{_group_directory};
		my $L_SU_env = $ENV{'L_SU'};

		# print "prog_doc2pm, $L_SU_env\n";
		my $path_out = $L_SU_env . '/configs' . '/' . $dir;

		# print("prog_doc2pm,get_path_out = $path_out\n");
		return ($path_out);

	} else {
		print("prog_doc2pm, get_config_path_out missing directory,\n");
		return ();
	}
}

=head2 sub get_path_out


=cut

sub get_path_out {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		# my $path 	= '/usr/local/cwp_su_all_48/src/doc/Stripped';
		my $dir      = $prog_doc2pm->{_group_directory};
		my $L_SU_env = $ENV{'L_SU'};

		# print "prog_doc2pm, $L_SU_env\n";
		my $path_out = $L_SU_env . '/developer/Stripped' . '/' . $dir;

		# print("prog_doc2pm,get_path_out = $path_out\n");
		return ($path_out);

	} else {
		print("prog_doc2pm, get_,path_out missing directory,\n");
		return ();
	}
}

=head2 sub get_program_aref 

=cut

sub get_program_aref {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		my $list_aref;
		my $path_in   = _get_path_in();
		my $directory = $prog_doc2pm->{_group_directory};
		$prog_doc2pm->{_path} = $path_in . '/Stripped/' . $directory;
		my $path = $prog_doc2pm->{_path};

		#		print("prog_doc2pm,get_program_aref, PATH:$prog_doc2pm->{_path}\n");

		opendir my $dh, $path or die "Could not open '$path' for reading: $!\n";
        
		#		print("prog_doc2pm,_get_program_aref, DIR=$path\n");
		my @file_name;
		my $thing;
		my @name;
		
		while ( defined( $thing = readdir $dh) ) {

			$thing =~ s/\///;

			 if (not($thing =~ /^\.\.?$/)) { 
				
	           (@name) = split( /\./, $thing);
				push @file_name, $name[0];
#				print("prog_doc2pm,file_name=$name[0] \___\n");
				
			} else { # skip . and ..
#				print("prog_doc2pm, skipping $thing\n");
			}

			$list_aref = \@file_name;

		}    # end while
		closedir $dh;

		#		print("prog_doc2pm,get_program_aref,file_names=@file_name\n");
		return ($list_aref);

	} else {
		print("prog_doc2pm, get_program_aref, missing group no,\n");
		return ();
	}

}

=head2 sub get_spec_path_out


=cut

sub get_spec_path_out {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		# my $path 	= '/usr/local/pl/L_SU/specs';
		my $dir      = $prog_doc2pm->{_group_directory};
		my $L_SU_env = $ENV{'L_SU'};

		# print "prog_doc2pm, $L_SU_env\n";
		my $path_out = $L_SU_env . '/specs' . '/' . $dir;

		# print("prog_doc2pm,get_path_out = $path_out\n");
		return ($path_out);

	} else {
		print("prog_doc2pm, get_spec_path_out missing directory,\n");
		return ();
	}

}

=head2 sub get_sunix_path_out


=cut

sub get_sunix_path_out {

	my ($self) = @_;

	if ( $prog_doc2pm->{_group_directory} ne $empty_string ) {

		# my $path 	= '/usr/local/pl/L_SU/sunix';
		my $dir      = $prog_doc2pm->{_group_directory};
		my $L_SU_env = $ENV{'L_SU'};

		# print "prog_doc2pm, $L_SU_env\n";
		my $path_out = $L_SU_env . '/sunix' . '/' . $dir;

		# print("prog_doc2pm,get_path_out = $path_out\n");
		return ($path_out);

	} else {
		print("prog_doc2pm, get_sunix_path_out missing directory,\n");
		return ();
	}
}

=head2 sub set_group_directory 


=cut

sub set_group_directory {

	my ( $self, $group_no ) = @_;

	if ( $group_no ne $empty_string ) {

		$prog_doc2pm->{_group_directory} = $program_group[$group_no];

		#print("prog_doc2pm, set_group_directory,$prog_doc2pm->{_group_directory}\n");

	} else {
		print("prog_doc2pm, set_group_directory, missing group no,\n");
	}
}

1;
