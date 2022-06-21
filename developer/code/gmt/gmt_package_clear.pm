package gmt_package_clear;
use Moose;

my $path;
my $LSeismicUnix;
use Shell qw(echo);

BEGIN {

$LSeismicUnix = ` echo \$LSeismicUnix`;
chomp $LSeismicUnix;
$path = $LSeismicUnix.'/'.'developer/code/sunix';

}
use lib "$path";
extends 'sunix_package_clear';

1;
