package sunix_package_use;
use Moose;

my @use;

=head2 use variables

=cut

my $sunix_package_use = {
	_package_name    => '',
	_subroutine_name => '',
	_param_names     => '',
};

=head2 sub make_section 

 print("sunix_package_use,get_section,@lines\n");
 =use2 Default perl lines for start of instantiation
       of imported packages 

=cut

sub make_section {

	my ($self) = @_;

	$use[0] = 'use App::SeismicUnixGui::misc::L_SU_global_constants();' . "\n\n";	
	$use[1] = 'use SeismicUnix qw ($go $in $off $on $out $ps $to $suffix_ascii $suffix_bin $suffix_ps $suffix_segy $suffix_su);' . "\n";
	$use[2] = 'use App::SeismicUnixGui::configs::big_streams::Project_config;' . "\n\n";
	return ( \@use );
}

=head2 sub get_section 

 print("sunix_package_use,get_section,@lines\n");

=cut

sub get_section {
	my ($self) = @_;
	return ( \@use );
}

1;
