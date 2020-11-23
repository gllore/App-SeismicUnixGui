package header_values;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: header_values 
 AUTHOR: Daniel Lopez
 DATE:   Jan 14 2020
 DESCRIPTION: Extract segy header values
 Version: 0.0.1

=head2 USE

=head3 NOTES 

=head4 
 Examples


=head4 CHANGES and their DATES


=cut

use Moose;
our $VERSION = '0.0.1';
use L_SU_global_constants();

my $get = new L_SU_global_constants();

my $var          = $get->var();
my $empty_string = $var->{_empty_string};

=head2 Create prheader_valueste hash

=cut

my $header_values = {
	_key            => '',
	_base_file_name => '',
	_header_name    => '',
};

=head2 sub clear

=cut

sub clear {

	$header_values->{_key}            = '';
	$header_values->{_base_file_name} = '';
	$header_values->{_header_name}    = '';
}

=head2 sub set_base_file_name

=cut

sub set_base_file_name {

	my ( $self, $base_file_name ) = @_;

	if ( $base_file_name ne $empty_string ) {

		$header_values->{_base_file_name} = $base_file_name;

	}
	else {

		print("header_values,set_base_file_name, missing base file name\n");
	}

	return ();

}

=head2 sub set_header_name

=cut

sub set_header_name {

	my ( $self, $header_name ) = @_;

	if ( $header_name ne $empty_string ) {

		$header_values->{_header_name} = $header_name;

	}
	else {

		print("header_values,set_header_name, missing header name\n");
	}

	return ();
}

=head2 sub get_number

=cut

sub get_number() {

	my ($self) = @_;

	if (   defined $header_values->{_base_file_name}
		&& $header_values->{_base_file_name} ne $empty_string
		&& defined $header_values->{_header_name}
		&& $header_values->{_header_name} ne $empty_string )
	{

=head2 Declare

	import and instantiate classes

=cut

		use Project_config;
		use message;
		use flow;
		use surange;
		use SeismicUnix
		  qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);

		my $log     = new message;
		my $run     = flow->new();
		my $surange = surange->new();

=head2 Declare

	local variables

=cut

		my (@flow);
		my (@items);
		my (@data_in);
		my (@surange);
		my $Project         = new Project_config();
		my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;

=head2 Set up

	data_in parameter values

=cut

		$data_in[1] =
		    $DATA_SEISMIC_SU . '/'
		  . $header_values->{_base_file_name}
		  . $suffix_su;

=head2 Set up

	surange parameter values

=cut

		$surange->clear();
		$surange->key( quotemeta( $header_values->{_header_name} ) );
		$surange[1] = $surange->Step();

=head2 DEFINE FLOW(s) 

=cut

		@items = ( $surange[1], $in, $data_in[1], $go );

=head2 RUN FLOW(s) and Capture output (with backticks) from the system

=cut
		my @values = `@items`;
		# print("header_values, @values \n");

=head2 LOG FLOW(s)

	to screen

=cut

		# print ("@items \n");

=head2 parse output to obtain header value

=cut 		

		my $result;
		my $scale = $values[1];

#		print ("header_values, get_number,values[0]:$values[0]...\n");
#		print ("header_values, get_number,values[1]:$values[1]\n");
		my $length = scalar @values;

#		print ("header_values, get_number,length=$length\n");

		if ( defined $scale ) {
			# print("header_values,get_number, values[1]:$values[1]\n");

			if (   $scale eq 0
				or $scale eq $empty_string )
			{
				$result = 1;
				# print("header_values, get_number, scale=$result... \n");
				return ($result);

			}
			else {

				$scale =~ s/scalel\s*//;
				chomp($scale);

				# print("scale:$scale....\n");

				if ( $scale > 0 ) {

					# 10, 100 stays as 10, 100
					$result = $scale;
					# print("header_values, get_number, scale=$result... \n");
					return ($result);

				}
				elsif ( ( $scale < 0 ) ) {

					# -10, -100 becomes .1, .01
					$result = -1 / $scale;
					# print("header_values, get_number, scale=$result... \n");
					return ($result);

				}

			}

		}
		else {
			$result = 1;
			# print("header_values, get_number, data_scale = 1:1\n");
			return ($result);
		}
		return ($result);

	} else {
		print("header_values, get_number, missing base file name and/or header name\n");
}
	} # end sub get_number
1;
