use Test::Simple tests => 20;
use Moose;

use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';
my $L_SU_global_constants = L_SU_global_constants->new();

=head2 Important definitions 

of directory structure

=cut 

my $SeismicUnixGui;
my $GRANDPARENT_DIR;
use Shell qw(echo);

BEGIN {

	$SeismicUnixGui = ` echo \$SeismicUnixGui`;
	chomp $SeismicUnixGui;
	$GRANDPARENT_DIR = $SeismicUnixGui;

}

=head2 Get all the files and their paths

from the SU category

=cut

#$L_SU_global_constants->set_CHILD_DIR_type('SU');
#$L_SU_global_constants->set_PARENT_DIR_type('SU');
#$L_SU_global_constants->set_GRANDPARENT_DIR($GRANDPARENT_DIR);
#my ( $su_pathNfile_aref, $su_dimension_aref ) =
# $L_SU_global_constants->get_pathNfile2search();

#=head2 privately shared hash
#
#=cut
#
#my $test = {
#	_child_directory_su_number_of  => '',
#	_file_name                     => '',
#	_line_of_interest_aref         => '',
#	_parent_directory_su_number_of => '',
#	_pathNfile_aref                => '',
#};
#
#=head2 search for files to test
#
#=cut 
#
#my @dimension_su                  = @$su_dimension_aref;
#my $parent_directory_su_number_of = $dimension_su[0];
#my $child_directory_su_number_of  = $dimension_su[1];
#
#_set_parent_directory_number_of($parent_directory_su_number_of);
#_set_child_directory_number_of($child_directory_su_number_of);
#_set_pathNfile_aref($su_pathNfile_aref);

#print("parent_directory_su_number_of=$parent_directory_su_number_of\n");
#print("child_directory_su_number_of=$child_directory_su_number_of\n");
#
#=head test here
#
#=cut 
#
#sub test {
#
#	my ($self) = @_;
#
#	my $child_directory_number_of =
#	  $test->{_child_directory_number_of};
#	  
#	my $parent_directory_number_of =
#	  $test->{_parent_directory_number_of};
#	  
#	my @pathNfile             = @{ $test->{_pathNfile_aref} };
#	
#	my @line_of_interest_aref = @{ $test->{_line_of_interest_aref} };
#	for ( my $parent = 0 ; $parent < $parent_directory_number_of ; $parent++ ) {
#
#		for ( my $child = 0 ; $child < $child_directory_number_of ; $child++ ) {
#
#			my @pathNfile_list        = @{ $pathNfile[$parent][$child] };
#			my $pathNfile_list_length = scalar @pathNfile_list;
#			$pathNfile_list_length=1;
#			
#			my $file;
#			for ( my $i = 0 ; $i < $pathNfile_list_length ; $i++ ) {
#						
#							$file = $pathNfile_list[$i];
#							my $catch = `perl $file`;
#							print ("--$file--\n");
#	
#			}    # for files in a list
#
#		}    # for each child directory
#
#	}    #for each parent directory
#
#}    # sub test
#
##use lib ".";
##use Sucat_spec;  # What you're testing.
##
my @files = `ls`;

foreach my $file (@files) {

	my $catch = `perl $file`;
	print ("--$file--\n");
	ok( $catch eq '');

}

#}

#=head2 sub _set_child_directory_number_of 
#
#=cut
#
#sub _set_child_directory_number_of {
#
#	my ($self) = @_;
#
#	$test->{_child_directory_number_of} = $self;
#
#	#	print ("_set_child_directory_number_of=$self\n");
#
#	return ();
#}
#
#=head2 sub _set_parent_directory_number_of 
#
#=cut
#
#sub _set_parent_directory_number_of {
#
#	my ($self) = @_;
#
#	$test->{_parent_directory_number_of} = $self;
#
#	#    print ("_set_parent_directory_number_of=$self\n");
#	return ();
#}
#
#=head2 sub _set_pathNfile_aref 
#
#=cut
#
#sub _set_pathNfile_aref {
#	my ($self) = @_;
#
#	$test->{_pathNfile_aref} = $self;
#	return ();
#}
