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

use L_SU_global_constants;

my $get       = L_SU_global_constants->new();

my $var 		 = $get->var();
my $empty_string = $var->{_empty_string};

my (@file_in);
my ( @sudeveloper, @inbound );

=head2 private hash

=cut

my $developer = {
	_flow_type        => '',
	_program_category => '',
	_program_name     => '',
	_Step             => '',
	_note             => '',

};



=head2 subroutine _program_categeory
	
=cut

sub _program_category {
	my ($self) = @_;

	if (  (defined $developer->{_program_name})
		&& (defined $developer->{_flow_type})
		&&  $developer->{_program_name} ne $empty_string 
		&& $developer->{_flow_type} ne $empty_string ) {

		use L_SU_global_constants;

		my $flow_type             = $get->flow_type_href();
		my $program_name          = $developer->{_program_name};
		my ( $category, $index );

		if ( $developer->{_flow_type} eq $flow_type->{_user_built} ) {

			my @sunix_programs_category_ref;
			# for sunix programs
			# print("developer, _program_category, program_name: $program_name\n");
			my $developer_sunix_categories_aref = $get->developer_sunix_categories_aref();

			$sunix_programs_category_ref[0]  = $var->{_sunix_data_programs};
			$sunix_programs_category_ref[1]  = $var->{_sunix_datum_programs};
			$sunix_programs_category_ref[2]  = $var->{_sunix_plot_programs};
			$sunix_programs_category_ref[3]  = $var->{_sunix_filter_programs};
			$sunix_programs_category_ref[4]  = $var->{_sunix_header_programs};
			$sunix_programs_category_ref[5]  = $var->{_sunix_inversion_programs};
			$sunix_programs_category_ref[6]  = $var->{_sunix_migration_programs};
			$sunix_programs_category_ref[7]  = $var->{_sunix_model_programs};
			$sunix_programs_category_ref[8]  = $var->{_sunix_NMO_Vel_Stk_programs};
			$sunix_programs_category_ref[9]  = $var->{_sunix_par_programs};
			$sunix_programs_category_ref[10] = $var->{_sunix_picks_programs};
			$sunix_programs_category_ref[11] = $var->{_sunix_shapeNcut_programs};
			$sunix_programs_category_ref[12] = $var->{_sunix_shell_programs};
			$sunix_programs_category_ref[13] = $var->{_sunix_statsMath_programs};
			$sunix_programs_category_ref[14] = $var->{_sunix_transform_programs};
			$sunix_programs_category_ref[15] = $var->{_sunix_well_programs};

			my $num_sunix_categories = scalar @sunix_programs_category_ref;    # =16

			# print ("developer, _program_category, num_sunix_categories: $num_sunix_categories\n");
			# my $num_superflow_alias_names = scalar @$Tools_aref;
			# print ("developer, _program_category, num_superflow_alias_names: $num_superflow_alias_names\n");

			# find index of matching element in array
			for ( my $i = 0; $i < $num_sunix_categories; $i++ ) {

				# 	print(
				# 		"developer, _program_category, programs in category[$i]: @{$sunix_programs_category_ref[$i]}\n"
				# 	);
				my $num_programs_in_each_category = scalar @{ $sunix_programs_category_ref[$i] };
				my $num_progs                     = $num_programs_in_each_category;

				# print ("developer, _program_category, num_superflow_alias_names: $num_progs JL\n");
				for ( my $j = 0; $j < $num_progs; $j++ ) {

					my $test = @{ $sunix_programs_category_ref[$i] }[$j];

					if ( $test =~ m/$program_name/ ) {

						my $category = @$developer_sunix_categories_aref[$i];

						# print(
						# 	"1. developer, _program_category sucess, category= $category\n"
						# );
						$developer->{_program_category} = $category;

						# print("2. developer, _program_category sucess, category= $developer->{_program_category} \n"
						# );
						# print("developer, _program_category, test: $test\n");
						# print("developer, _program_category, program_name: $program_name\n");
						# print "developer, _program_category sucess, prog. index = $j\n";

					} else {

						# print "developer, _program_category no match, index =$j NADA\n";
					}
				}
			}
		} elsif ( $developer->{_flow_type} eq $flow_type->{_pre_built_superflow} ) {

			my $Tools_category_aref = $get->developer_Tools_categories_aref();
			my $Tools_aref     		= $get->alias_superflow_names_aref();
			my $num_tools      		= scalar @$Tools_aref;                                     # =14

			for ( my $j = 0; $j < $num_tools; $j++ ) {

				my $test = @{ $Tools_aref }[$j];

				if ( $test =~ m/$program_name/ ) {

					# print("1. developer, _program_category sucess, superflow program= $test\n");
					$developer->{_program_category} = @$Tools_category_aref[$j];

					# print("2. developer, _program_category sucess, category= $developer->{_program_category} \n");
					# print("developer, _program_category, test: $test\n");
					# print("developer, _program_category, program_name: $program_name\n");
					# print "developer, _program_category sucess, prog. index = $j\n";
					
				} else {
					# print "developer, _program_category no match, index =$j NADA\n";
				}
			}

		} else {
			print "developer, _program_category, missing flow_type NADA\n";
		}

	} else {
		print("developer, _program_category, either missing developer->{_program_name} or flow type\n");
	}
	
	return ();
} # end sub

=head2 subroutine get_program_categeory
	
 $developer->{_program_name}
=cut

sub get_program_sub_category {
	my ($self) = @_;

	if ( defined $developer->{_program_name} 
		&& $developer->{_program_name} ne $empty_string) {

		# print("developer, get_program_sub_category: program_name=$developer->{_program_name} \n");
		_program_category();

		my $result = $developer->{_program_category};

		# print("developer, get_program_sub_category: $result\n");

		return ($result);

	} else {
		print("developer, get_program_sub_category, program_name missing \n");
	}
}

sub set_flow_type {

	my ( $self, $flow_type ) = @_;

	my $result;

	if ( defined $flow_type 
		&& $flow_type ne $empty_string ) {

		$developer->{_flow_type} = $flow_type;

	} else {
		print("developer,  set_flow_type , missing value\n");
	}

	return ();
}

=head2 subroutine set_program_name
	
  
=cut

sub set_program_name {
	my ( $self, $program ) = @_;

	if (defined $program 
		&& $program ne $empty_string ) {

		$developer->{_program_name} = $program;

	} else {
		print("developer, set_program, missing program\n");
	}
}

1;
