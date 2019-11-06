package developer;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: developer.pm 
 AUTHOR: 	Juan Lorenzo
 DATE: 		August 6 2019
  

 DESCRIPTION 
     

 BASED ON:
 Version 0.0.1 August 6 2019



=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES


=cut 

=head2 Notes from bash
 
=cut 

use Moose;
our $VERSION = '0.0.1';

my (@file_in);
my ( @sudeveloper, @inbound );

=head2 private hash

=cut

my $developer = {

	_program_category => '',
	_program_name     => '',
	_Step             => '',
	_note             => '',

};

=head2 subroutine _program_categeory
	
=cut

sub _program_category {
	my ($self) = @_;

	my @all_programs_category_ref;

	if ( $developer->{_program_name} ) {

		use L_SU_global_constants;

		my ( $category, $index );

		my $program_name = $developer->{_program_name};

		# print("developer, _program_category, program_name: $program_name\n");

		my $L_SU_global_constants =
			new L_SU_global_constants();

		my $default_categories_ref =
			$L_SU_global_constants->developer_categories();

		my $Tools_aref =
			$L_SU_global_constants->alias_superflow_names_aref();

		my $var = $L_SU_global_constants->var;

		$all_programs_category_ref[0]  = $var->{_sunix_data_programs};
		$all_programs_category_ref[1]  = $var->{_sunix_datum_programs};
		$all_programs_category_ref[2]  = $var->{_sunix_plot_programs};
		$all_programs_category_ref[3]  = $var->{_sunix_filter_programs};
		$all_programs_category_ref[4]  = $var->{_sunix_header_programs};
		$all_programs_category_ref[5]  = $var->{_sunix_inversion_programs};
		$all_programs_category_ref[6]  = $var->{_sunix_migration_programs};
		$all_programs_category_ref[7]  = $var->{_sunix_model_programs};
		$all_programs_category_ref[8]  = $var->{_sunix_NMO_Vel_Stk_programs};
		$all_programs_category_ref[9]  = $var->{_sunix_par_programs};
		$all_programs_category_ref[10] = $var->{_sunix_picks_programs};
		$all_programs_category_ref[11] = $var->{_sunix_shapeNcut_programs};
		$all_programs_category_ref[12] = $var->{_sunix_shell_programs};
		$all_programs_category_ref[13] = $var->{_sunix_statsMath_programs};
		$all_programs_category_ref[14] = $var->{_sunix_transform_programs};
		$all_programs_category_ref[15] = $var->{_sunix_well_programs};
		$all_programs_category_ref[16] = $Tools_aref;

		my $num_categories = scalar @all_programs_category_ref;

	# print ("developer, _program_category, num_categories: $num_categories\n");
		my $num_superflow_alias_names = scalar @$Tools_aref;

		# find index of matching element in array
		for ( my $i = 0; $i < $num_categories; $i++ ) {

# 	print(
# 		"developer, _program_category, programs in category[$i]: @{$all_programs_category_ref[$i]}\n"
# 	);

			my $num_programs_in_each_category =
				scalar @{ $all_programs_category_ref[$i] };
			my $num_progs = $num_programs_in_each_category;

			for ( my $j = 0; $j < $num_progs; $j++ ) {

				my $test = @{ $all_programs_category_ref[$i] }[$j];

				if ( $test =~ m/$program_name/ ) {

					my $category =
						@$default_categories_ref[$i];

					# print(
					# 	"1. developer, _program_category sucess, category= $category\n"
					# );
					
					$developer->{_program_category} = $category;
					# print(
					# 	"2. developer, _program_category sucess, category= $developer->{_program_category} \n"
					# );

		 # print("developer, _program_category, test: $test\n");
		 # print("developer, _program_category, program_name: $program_name\n");
		 # print "developer, _program_category sucess, prog. index = $j\n";

				}
				else {
			  # print "developer, _program_category no match, index =$j NADA\n";
				}
			}
		}

		return ();

	}
	else {

		print("developer, missing developer->{_program_name}\n");
	}
}

=head2 subroutine get_program_categeory
	
 
=cut

sub get_program_category {
	my ($self) = @_;

	if ( $developer->{_program_name} ) {

		_program_category;

		my $result = $developer->{_program_category};
		# print("developer, get_program_category: $result\n");

		return ($result);

	}
	else {
		print("developer, get_program_category, program_name missing \n");
	}
}

=head2 subroutine set_program_name
	
  
=cut

sub set_program_name {
	my ( $self, $program ) = @_;

	if ($program) {

		$developer->{_program_name} = $program;

	}
	else {
		print("developer, set_program, missing program\n");
	}
}

1;
