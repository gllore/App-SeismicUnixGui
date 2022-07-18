package gmt_package_encapsulated;
use Moose;

my $path;
my $SeismicUnixGui;
use Shell qw(echo);

BEGIN {

$SeismicUnixGui = ` echo \$SeismicUnixGui`;
chomp $SeismicUnixGui;
$path = $SeismicUnixGui.'/'.'developer/code/sunix';

}
use lib "$path";
extends 'sunix_package_encapsulated';

=head2 encapsulated variables

=cut

1;
