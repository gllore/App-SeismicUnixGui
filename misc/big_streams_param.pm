package big_streams_param;
use Moose;

my $path;
my $LSeismicUnix;
use Shell qw(echo);

BEGIN {

$LSeismicUnix = ` echo \$LSeismicUnix`;
chomp $LSeismicUnix;
$path = $LSeismicUnix.'/'.'misc';

}
use lib "$path";
extends 'su_param' => { -version => 0.0.2 };

1;