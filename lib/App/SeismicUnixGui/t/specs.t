use Test::More;
use Test::Compile;


=head1 Test for specs modules

require_ok tests if a module or file loads successfully

=cut


=head2 Important definitions

301 test for specs

=cut


my $SeismicUnixGui;
use Shell qw(echo);

BEGIN {

$SeismicUnixGui = ` echo \$SeismicUnixGui`;
chomp $SeismicUnixGui;

}

=head2 import modules

=cut

use strict;
use warnings;
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';

=head2 Instantiation 

=cut

my $L_SU_global_constants = L_SU_global_constants->new();
my $test = Test::Compile->new();

my @dirs = ("$SeismicUnixGui/specs");
#print @dirs;
$test->all_files_ok(@dirs);
done_testing();
