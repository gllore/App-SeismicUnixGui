package gmt_package_tail;
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
extends 'sunix_package_tail';

1;
