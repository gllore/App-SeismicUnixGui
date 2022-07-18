package gmt_package_header;
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
extends 'sunix_package_header';

=head2 sub get_use_package_section

 a small section of the file
 print ("use_package_header,section:name $name\n");

=cut

sub get_use_package_section {
 	my ($self,$name) = @_;
	my @head;
 	$head[0] = (" use GMTglobal_constants;\n");

 	return (\@head);
}


1;
