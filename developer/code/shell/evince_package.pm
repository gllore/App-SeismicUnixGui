package evince_package;

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
extends 'sunix_package';

my $package = sunix_package->new;

=head2 sunix_package extends sunix_pl
 which shares many similar attributes to current 
 class in that files are examined for patterns
 However, the current class uses evince_doc files
 rather than sunix perl scripts

=cut

=head2 initialize shared anonymous hash 

  key/value pairs

=cut

my $evince_package = {
	_config_file_out   => '',
	_evince_doc_aref   => '',
	_file_in           => '',
	_file_out          => '',
	_length            => '',
	_name              => '',
	_num_lines         => '',
	_path_out          => '',
	_evince_doc        => '',
	_outbound          => '',
	_package_name      => '',
	_package_name_aref => '',
};

=pod declare local variables

=cut

my @param_names;
my @param_symbol;
my @param_option;

=head2 sub get_file_out

  		 
=cut

sub get_file_out {
	my ($self) = @_;
	my $file_out = $evince_package->{_file_out};

	# print("1. evince_package,get_file_out is $evince_package->{_file_out}\n");
	return ($file_out);
}

=head2 sub set_config_file_out


=cut

sub set_config_file_out {
	my ( $self, $file_aref ) = @_;
	$evince_package->{_config_file_out} = @$file_aref[0];
	print("evince_package,config_file_out,_config_file_out:  $evince_package->{_config_file_out}\n");

}

=head2 sub set_evince_doc


=cut

sub set_evince_doc_aref {
	my ( $self, $evince_doc_aref ) = @_;

	if ($evince_doc_aref) {
		$evince_package->{_evince_doc_aref} = $evince_doc_aref;
		$evince_package->{_num_lines}       = scalar @$evince_doc_aref;

		# print("evince_package,set_evince_doc @{$evince_package->{_evince_doc}}\n");
	}
	return ();
}

=head2 sub set_evince_xtra_param_names

  	add conventional note and Step to sequence

=cut

sub set_evince_xtra_param_names {
	my ($self) = @_;

	if ( $evince_package->{_param_names} ) {

		my $length = scalar @{ $evince_package->{_param_names} };

		if ( $length > 0 ) {

			my @names = @{ $evince_package->{_param_names} };
			$names[ ( $length++ ) ] = 'Step';
			$names[ ( $length++ ) ] = 'note';

			$evince_package->{_length}      = $length;
			$evince_package->{_param_names} = \@names;
			print("evince_package,set_evince_xtra_param_names  @{$evince_package->{_param_names}}\n");
			print("evince_package,set_evince_xtra_param_names,length:  $evince_package->{_length}\n");
		}
		else {
			print("evince_package,set_evince_xtra_param_names , no names in evince_package->{_param_names}\n");
		}
	}
	else {
		print("evince_package,set_evince_xtra_param_names , missing evince_package->{_param_names}\n");
	}
}

=head2 sub set_file_out

print("1. evince_package,file_out is $evince_package->{_file_out}\n");

=cut

sub set_file_out {
	my ( $self, $file_aref ) = @_;
	$evince_package->{_file_out} = @$file_aref[0];

	# print("1. evince_package,file_out is $evince_package->{_file_out}\n");
}

=head2 sub set_name
  print("name is $evince_package->{_name}\n");

=cut

sub set_name {
	my ( $self, $file_aref ) = @_;
	$evince_package->{_name} = @$file_aref[0];

	# print("evince_package,set_name,name:$evince_package->{_name}\n");
}

=head2 sub set_package_name_aref


=cut

sub set_package_name_aref {
	my ( $self, $file_aref ) = @_;

	if ($file_aref) {

		$evince_package->{_package_name}      = @$file_aref[0];
		$evince_package->{_package_name_aref} = $file_aref;

		# print("evince_package, set_package_name is $evince_package->{_package_name}\n");
	}
	else {
		print("evince_package,set_package name, missing package name\n");
	}
}

=head2 sub set_param_names

  	add conventional note and Step to sequence

=cut

sub set_param_names {
	my ( $self, $names_aref ) = @_;

	if ($names_aref) {
		$evince_package->{_param_names} = $names_aref;
	}
	else {
		print("evince_package, set_param_names, missing param_names \n");

	}
}

=head2 sub set_param_values

  				 

=cut

sub set_param_values {

	my ( $self, $values_aref ) = @_;

	if ($values_aref) {

		$evince_package->{_param_values} = $values_aref;
		$evince_package->{_length}       = scalar @$values_aref;
		print("evince_package,param_values @{$evince_package->{_param_values}}\n");

	}
	else {
		print("evince_package,set_param_values,param_values are missing\n");
	}
}

=head2 sub set_path_out

  
=cut

sub set_path_out {
	my ( $self, $file_aref ) = @_;

	$evince_package->{_path_out} = @$file_aref[0];

	# print("evince_package,set_path_out,path_out is $evince_package->{_path_out}\n");
}

=head2 sub set_spec_file_out



=cut

sub set_spec_file_out {
	my ( $self, $file_aref ) = @_;
	$evince_package->{_spec_file_out} = @$file_aref[0];

	print("evince_package,set_spec_file_out,_spec_file_out:  $evince_package->{_spec_file_out}\n");
}


=pod sub write_config 

 open and write configuration 
 file

=cut

sub write_config {

	my ($self) = shift;

	if ( $evince_package->{_config_file_out} && 
		$evince_package->{_length} ) {    # avoids errors

		my $OUT;
		my $outbound = $evince_package->{_path_out} . '/' . $evince_package->{_config_file_out};

		print("evince_package,write_config $outbound\n");

		# fall short by 2 so as to avoid replication of
		#  Step and note subroutines
		open $OUT, '>', $outbound or die;

		for ( my $i = 0; $i < ( $evince_package->{_length} - 2 ); $i++ ) {
			printf $OUT "    %-35s%1s%-20s\n", @{ $evince_package->{_param_names} }[$i], '= ', @{ $evince_package->{_param_values} }[$i];
		}
		close($OUT);
	}
}

=pod sub write_pm 

 open  and write 
 to the file

=cut

sub write_pm {
	my ($self) = shift;

	if (   $evince_package->{_file_out}
		&& $evince_package->{_length} )
	{    # avoids errors

		my $OUT;
		use sunix_package_header;
		use sunix_package_pod_header;
		use sunix_package_declaration;
		use sunix_package_instantiation;
		use sunix_package_pod;
		use sunix_package_encapsulated;
		use sunix_package_subroutine;
		use sunix_package_use;
		use sunix_package_Step;
		use sunix_package_note;
		use sunix_package_clear;
		use sunix_package_tail;

		my $header      = sunix_package_header->new();
		my $pod_header  = sunix_package_pod_header->new();
		my $declaration = sunix_package_declaration->new();

		# TODO following 2 are both instantiations
		my $encapsulated  = sunix_package_encapsulated->new();
		my $instantiation = sunix_package_instantiation->new();
		my $pod           = sunix_package_pod->new();
		my $use           = sunix_package_use->new();
		my $Step          = sunix_package_Step->new();
		my $note          = sunix_package_note->new();
		my $clear         = sunix_package_clear->new();
		my $subroutine    = sunix_package_subroutine->new();
		my $tail          = sunix_package_tail->new();

		# set up header
		$header->set_package_name( $evince_package->{_package_name} );
		$use->make_section();

		# set up pod_header
		$pod_header->set_prog_docs_aref( $evince_package->{_evince_doc_aref} );
		$pod_header->set_header();

		# set up declaration
		$declaration->make_section();

		# set up encapsulated
		$encapsulated->set_package_name_href( $evince_package->{_package_name} );
		$encapsulated->set_param_names( $evince_package->{_param_names} );

		# set up Step
		$Step->set_package_name( $evince_package->{_package_name} );
		$Step->set_sub_Step();

		# set up note
		$note->set_package_name( $evince_package->{_package_name} );
		$note->set_sub_note();

		# set up clear
		$clear->set_package_name( $evince_package->{_package_name} );
		$clear->set_param_names( $evince_package->{_param_names} );

		# set up pod
		# $pod->set_package_name( $evince_package->{_name} );
		# $pod->set_evince_doc( $evince_package->{_evince_doc} );

		# set up subroutine package_name
		$subroutine->set_package_name( $evince_package->{_package_name} );

		# HERE starts THE output PRODUCT!!!!!!!!!!!!
		# print ("evince_package outbound $evince_package->{_outbound}\n");;
		# print ("evince_package  package name: $evince_package->{_package_name}\n");
		$evince_package->{_outbound} = $evince_package->{_path_out} . $evince_package->{_file_out};
		open $OUT, '>', $evince_package->{_outbound} or die;

		# prints out to file: package name
		print $OUT @{ $header->get_package_name_section() };

		# print(@{ $header->get_package_name_section() });

		# prints out to file: documentation and developer header
		print $OUT @{ $pod_header->get_section() };

		# print(@{ $pod_header->get_section() });

		# prints out to file: call to Moose
		print $OUT @{ $header->get_Moose_section() };

		# prints out to file: Version
		print $OUT @{ $header->get_version_section() };

		# prints out 'use...' (import packages)
		print $OUT @{ $pod->get_use };
		print $OUT @{ $use->get_section() };

		# prints out pod and more declared variables ("my ..$empty_string ")
		print $OUT @{ $pod->get_instantiation };
		print $OUT @{ $declaration->get_section() };

		# prints out a private hash
		print $OUT @{ $pod->get_encapsulated() };
		print $OUT @{ $encapsulated->get_section() };

		# prints out Step subroutine and pod
		print $OUT @{ $Step->get_section() };

		# prints out note subroutine and pod
		print $OUT @{ $note->get_section() };

		# prints out clear subroutine and pod
		print $OUT @{ $pod->get_clear() };
		print $OUT @{ $clear->get_section() };

		# prints subroutines containing names of switches
		# fall short by 2 so as to avoid replication of
		#  Step and note subroutines
		for ( my $i = 0; $i < ( $evince_package->{_length} - 2 ); $i++ ) {

			$subroutine->set_param_name_aref( \@{ $evince_package->{_param_names} }[$i] );
			$pod->subroutine_name( \@{ $evince_package->{_param_names} }[$i] );

			print $OUT @{ $pod->section };
			print $OUT @{ $subroutine->section };
		}

		# prints out  sub get_max_index and '1;'
		print $OUT @{ $tail->section };

		close($OUT);

	}
	else {
		print("evince_package,write_pm,missing file_out name or number of parameters\n");
	}

}


=pod sub write_spec

 open and write specification file 
 file
 
 TODO

=cut

sub write_spec {
	my ($self) = shift;
	use sunix_spec;
	my $sunix_spec = sunix_spec->new();
	my $name       = $evince_package->{_package_name};
	$sunix_spec->set_package_name($name);
	my $header 		= $sunix_spec->get_header_section();
	my $body   		= $sunix_spec->get_body_section();
	my $subs   		= $sunix_spec->get_subroutine_section();
	my $tail   		= $sunix_spec->get_tail_section();

	if ( $evince_package->{_spec_file_out} ) {    # avoids errors

		my $outbound_spec = $evince_package->{_path_out} . '/' . $evince_package->{_spec_file_out};

		print ("evince_package,write_spec outbound_spec= $outbound_spec \n");
		# print ("evince_package,write_spec, header=\n @{$header}\n");
		# print ("evince_package,write_spec, body=\n @{$body}\n");
		open( my $OUT, '>', $outbound_spec ) or die "Could not open file '$outbound_spec' $!";

		# print out the header
		print $OUT @{$header};
		print $OUT @{ $sunix_spec->get_body_section() };
		print $OUT @{ $sunix_spec->get_subroutine_section() };
		print $OUT @{$tail};
		close $OUT;
	}
}


1;
