use Moose;

use evince_doc;

use evince_package;

my $evince_doc = evince_doc->new();

my $package = evince_package->new();

my ( @file_in, @pm_file_out, @package_name );
my (@config_file_out, @spec_file_out);
my ( @inbound, @path_out, @path_in );
my ($i);

my $evince_doc2pm = {
	_names         => '',
	_values        => '',
	_line_contents => '',
};

=head2 SET UP sunix package to build


=cut

$package_name[0] 	= 'evince';

$file_in[0] 		= $package_name[0] . '.par';
$inbound[0] 		= './' . $file_in[0];
# print("evince_doc2pm, reading $file_in[0]\n");
$pm_file_out[0]     = $package_name[0] . '.pm';
$config_file_out[0] = $package_name[0] . '.config';
$spec_file_out[0]   = $package_name[0] . '_spec.pm';
$path_out[0]        = './';
my $path_in 		= './';

# print("evince_doc2pm.pl, reading $inbound[0]\n");
# print("evince_doc2pm.pl, writing $path_out[0]$pm_file_out[0]\n");
# print("evince_doc2pm.pl, writing $path_out[0]$config_file_out[0]\n");

=head2 Read in evince documentation


=cut

$evince_doc->set_file_in( \@inbound );
$evince_doc->set_path_in_sref( \$path_in );
$evince_doc->whole();
my $whole_aref						= $evince_doc->get_whole();
# print("evince_doc2pm,whole @$whole_aref\n");
my $lines							= $evince_doc->lines_with('--');
$evince_doc2pm->{_line_contents}	= $lines->{_line_contents};

# print("evince_doc2pm,line_contents_with('--'),@{$evince_doc2pm->{_line_contents}} \n");
my $parameter = $evince_doc->parameters($evince_doc2pm);
my $length    = scalar @{ $parameter->{_names} };

# Because there are no values in this case
for ( my $i = 0; $i < $length; $i++ ) {
	@{ $parameter->{_values} }[$i] = '';
	# print(
	#	"\n3. evince_doc2pm,values,
	# line#$i @{$parameter->{_values}}[$i] "
	# );
}

$package->set_file_out( \@pm_file_out );
$package->set_path_out( \@path_out );
$package->set_config_file_out( \@config_file_out );
$package->set_package_name_aref( \@package_name );
$package->set_param_names( $parameter->{_names} );
$package->set_param_values($parameter->{_values});
$package->set_evince_xtra_param_names();
$package->set_evince_doc_aref($whole_aref);
$package->write_pm();
$package->write_config();
$package->set_spec_file_out(\@spec_file_out);
$package->write_spec();
