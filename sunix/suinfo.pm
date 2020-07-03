package suinfo;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  suinfo - get variety of information from seismic unix files
 AUTHOR: Juan Lorenzo
 DATE:   June 14 2019
 DESCRIPTION: adaptation of multiple sunix programs
 Version: 

=head2 USE

=head3 NOTES

 suinfo - can obe run 
 (1) from a perl script 
 		This case has the following method(s)
 		get_first
 		get_last
 		set_inbound_base_file_name (assumed *su file)
 		set_type
 		set_unit
 		set_first
 		set_last
 		
 (2) may be created by L_SU; However for the time being
 	this option is yet to be implemented because
 	the output would create a string of informational values
 	These are best observed by using surange directly

 
 For future use with L_SU, current optional parameters:						
	first =			
	last  = 
	type  = Header type e.g. time, dt, or ns
	unit = 

=head4 Example perl scripts when used outside of L_SU:
	
	use suinfo;
	my $suinfo 						= suinfo ->new();
    $suinfo							-> clear();
	$suinfo							-> set_inbound_base_file_name($inbound_base_file_name);
	$suinfo							-> set_type('time');
	$suinfo							-> set_unit('second');
	$suinfo							-> set_first();
	$suinfo							-> set_last();
	my $first_t_s4data				= suinfo->get_first();	
	my $last_t_s4data				= suinfo->get_last();
	# print("first time-s = $first_t_s4data s \n");
	# print("last time -s = $last_t_s4data s \n");
	
		$suinfo							-> clear();
	$suinfo							-> set_inbound_base_file_name($inbound_base_file_name);
	$suinfo							-> set_first();
	$suinfo							-> set_type('tracl');
	my $first_tracl					= suinfo->get_first();
	# print("Lsu_plot, first_tracl:$first_tracl \n");
	
	$suinfo							-> clear();
	$suinfo							-> set_inbound_base_file_name($inbound_base_file_name);
	$suinfo							-> set_last();
	$suinfo							-> set_type('tracl');
	my $last_tracl					= suinfo->get_last();
	# print("Lsu_plot, first_tracl:$last_tracl \n");

	
=head3 SEISMIC UNIX NOTES

	Adapted from surange
	Credits for surange are available via help within L_SU (<MB3>)
	or, by typing the command-line instruction:   surange


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

use SeismicUnix qw($true $false $suffix_su $us2s $ms2s);
use L_SU_global_constants();
use surange;

my $get     = new L_SU_global_constants();
my $surange = surange->new();

my $var          = $get->var();
my $empty_string = $var->{_empty_string};

my $suinfo =  {
    _CONFIG	 				=> $PL_SEISMIC,
    _DATA_DIR_IN                    => '',
    _first                          => '',
    _inbound_base_file_name         => '',
    _set_first                      => $false,
    _set_set_inbound_base_file_name => '',
    _set_last                       => $false,
    _set_type                       => $false,
    _set_unit                       => $false,
    _last                           => '',
    _type                           => '',
    _unit                           => '',
    _Step                           => '',
    _note                           => '',
};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name
	use w/ L_SU

=cut

sub Step {

    $suinfo->{_Step} = 'surange' . $suinfo->{_Step};
    return ( $suinfo->{_Step} );

}

=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

sub note {

    $suinfo->{_note} = 'surange' . $suinfo->{_note};
    return ( $suinfo->{_note} );

}

=head2 sub clear

=cut

sub clear {

    $suinfo->{_DATA_DIR_IN} = '', $suinfo->{_first} = '';
    $suinfo->{_inbound_base_file_name}     = '';
    $suinfo->{_last}                       = '';
    $suinfo->{_set_first}                  = $false;
    $suinfo->{_set_inbound_base_file_name} = $false;
    $suinfo->{_set_last}                   = $false;
    $suinfo->{_set_type}                   = $false;
    $suinfo->{_set_unit}                   = $false;
    $suinfo->{_type}                       = '';
    $suinfo->{_unit}                       = '';
    $suinfo->{_Step}                       = '';
    $suinfo->{_note}                       = '';
}

=head2 sub _first 

	use outside L_SU
	retrieves the first value of type and unit from
	the seismic unix file

=cut

sub _get_first {

    my ($self) = @_;

    if ( $suinfo->{_set_unit} && $suinfo->{_set_type} ) {

        if ( $suinfo->{_type} eq 'time' && $suinfo->{_unit} eq 'second' ) {

            my $inbound =
                $suinfo->{_DATA_DIR_IN} . '/'
              . $suinfo->{_inbound_base_file_name}
              . $suffix_su;
            my @cmd = ` surange key=ns <$inbound`;
            $cmd[1] =~ s/ns\ \ \ \ \ \ \ //;

            my $number_of_samples = $cmd[1];

            # print ("number_of_samples = $number_of_samples \n");

            my $dt = `sugethw key=dt output=geom < $inbound| sed 1q`;

            # print ("dt microseconds= $dt \n");

            my $delay = `sugethw key=delrt output=geom < $inbound| sed 1q`;

            # print ("delay = $delay \n");

            my $first_time = -$delay / $ms2s;

            # print ("delay = $delay \n");
            # print ("fist_time = $first_time\n");

            my $result = $first_time;
            return ($result);

        }
        else {
            print(
"suinfo,_get_first,units or type are not time and seconds respectively\n"
            );
            return ();
        }

    }
    elsif ( $suinfo->{_set_type} && !$suinfo->{_set_unit} ) {

        my $inbound =
            $suinfo->{_DATA_DIR_IN} . '/'
          . $suinfo->{_inbound_base_file_name}
          . $suffix_su;

        my $type = $suinfo->{_type};

        my @cmd = ` surange key=$type <$inbound`;

        # print ("cmd[1]=----$cmd[1]----\n");
        my @vals = $cmd[1] =~ m/(\d+)/g;    #match any digit one or more times

        my $first_value4type = $vals[0];

        # print("first type value=---$first_value4type--\n");

        my $result = $first_value4type;
        return ($result);

    }
    else {
        print("suinfo,_get_first,units or type not set\n");
        return ();
    }

}

=head2 sub _get_last

	use outside L_SU
	retrieves the lastvalue of type and unit from
	the seismic unix file

=cut

sub _get_last {

    my ($self) = @_;

    if ( $suinfo->{_set_unit} && $suinfo->{_set_type} ) {

        if ( $suinfo->{_type} eq 'time' && $suinfo->{_unit} eq 'second' ) {

            my $inbound =
                $suinfo->{_DATA_DIR_IN} . '/'
              . $suinfo->{_inbound_base_file_name}
              . $suffix_su;
            my @cmd = ` surange key=ns <$inbound`;
            $cmd[1] =~ s/ns\ \ \ \ \ \ \ //;

            my $number_of_samples = $cmd[1];

            # print ("number_of_samples = $number_of_samples \n");

            my $dt = `sugethw key=dt output=geom < $inbound| sed 1q`;

            # print ("dt microseconds= $dt \n");

            my $delay = `sugethw key=delrt output=geom < $inbound| sed 1q`;

            # print ("delay = $delay \n");

            my $last_time =
              ( -$delay / $ms2s ) +
              ( ( $number_of_samples - 1 ) * $dt ) / $us2s;

            # print ("delay = $delay \n");
            # print ("last_time = $last_time\n");

            my $result = $last_time;
            return ($result);

        }
        else {
            print(
"suinfo,_get_last,units or type are not time and seconds respectively\n"
            );
            return ();
        }

    }
    elsif ( $suinfo->{_set_type} && !$suinfo->{_set_unit} ) {

        my $inbound =
            $suinfo->{_DATA_DIR_IN} . '/'
          . $suinfo->{_inbound_base_file_name}
          . $suffix_su;

        my $type = $suinfo->{_type};

        my @cmd = ` surange key=$type <$inbound`;

        # print ("cmd[1]=----$cmd[1]----\n");
        my @vals = $cmd[1] =~ m/(\d+)/g;    #match any digit one or more times

        my $last_value4type = $vals[1];

        # print("last type value=---$last_value4type--\n");

        my $result = $last_value4type;
        return ($result);

    }
    else {
        print("suinfo,_get_last,units or type not set\n");
        return ();
    }

}

=head2 sub first 

	use w/ L_SU

=cut

sub first {

    my ( $self, $first ) = @_;

    if ( $first ne $empty_string ) {

        use control;
        my $control = control->new();

        my $reply = $control->set_str2logic($first);

        if ($reply) {

            $control->{_set_first} = $true;

            # $suinfo-> {_first} 		= _get_first();

        }
        elsif ( !$reply ) {

            $control->{_set_first} = $false;

        }
        else {
            print("suinfo, first, unexpected result,\n");
        }

    }
    else {
        print("suinfo, first, missing first,\n");
    }
}

=head2 sub get_first 

	use outside L_SU

=cut

sub get_first {

    my ($self) = @_;

    if ( $suinfo->{_set_first} ne $empty_string ) {

        $suinfo->{_first} = _get_first();
        my $result = $suinfo->{_first};

        return ($result);

    }
    else {
        print("suinfo, get_first, missing first,\n");
        return ();
    }
}

=head2 sub get_last 

	use outside L_SU

=cut

sub get_last {

    my ($self) = @_;

    if ( $suinfo->{_set_last} ne $empty_string ) {

        $suinfo->{_last} = _get_last();
        my $result = $suinfo->{_last};

        return ($result);

    }
    else {
        print("suinfo, get_last, missing get_last,\n");
        return ();
    }

}

=head2 sub last 

 	use w/ L_SU

=cut

sub last {

    my ( $self, $last ) = @_;

    if ( $last ne $empty_string ) {

        use control;
        my $control = control->new();

        my $reply = $control->set_str2logic($last);

        if ($reply) {

            $control->{_set_last} = $true;

        }
        elsif ( !$reply ) {
            $control->{_set_last} = $false;

        }
        else {
            print("suinfo, last, unexpected result,\n");
        }

    }
    else {
        print("suinfo, last, missing last,\n");
    }
}

=head2 sub set_first

	for use w/o L_SU


=cut

sub set_first {

    my ($self) = @_;

    $suinfo->{_set_first} = $true;

    return ();

}

=head2 sub set_last

	for use w/o L_SU


=cut

sub set_last {

    my ($self) = @_;

    $suinfo->{_set_last} = $true;
    return ();

}

=head2 sub set_inbound_base_file_name

	use outside L_SU
	assume that path is DATA_SEISMIC_SU

=cut

sub set_inbound_base_file_name {

    my ( $self, $inbound_base_file_name ) = @_;

    if ( $inbound_base_file_name ne $empty_string ) {
        use surange_spec;
        my $surange_spec = surange_spec->new();
        my $hash_ref     = $surange_spec->variables();
        my $PATH         = $hash_ref->{_DATA_DIR_IN};
        $suinfo->{_DATA_DIR_IN} = $PATH;

        $suinfo->{_inbound_base_file_name}     = $inbound_base_file_name;
        $suinfo->{_set_inbound_base_file_name} = $true;

     # print("suinfo, set_inbound_base_file_name = $inbound_base_file_name,\n");
     # print("suinfo, set_inbound_base_file_name INPUT PATH=$PATH\n");

    }
    else {
        print(
"suinfo, set_inbound_base_file_name, missing inbound_base_file_name,\n"
        );
    }
    return ();
}

=head2 sub set_type 

	use outside L_SU

=cut

sub set_type {

    my ( $self, $type ) = @_;
    if ( $type ne $empty_string ) {

        $suinfo->{_type}     = $type;
        $suinfo->{_set_type} = $true;

        # print("suinfo, set_type, type = $type,\n");

    }
    else {
        print("suinfo, set_type, missing set_type,\n");
    }

    return ();
}

=head2 sub set_unit

	use outside L_SU

=cut

sub set_unit {

    my ( $self, $unit ) = @_;

    if ( $unit ne $empty_string ) {

        $suinfo->{_unit}     = $unit;
        $suinfo->{_set_unit} = $true;

        # print("suinfo, set_unit, unit=$unit\n");

    }
    else {
        print("suinfo, unit, missing unit,\n");
    }
    return ();
}

=head2 sub type 

	use w/ L_SU

=cut

sub type {

    my ( $self, $type ) = @_;
    if ( $type ne $empty_string ) {

        $suinfo->{_type}     = $type;
        $suinfo->{_set_type} = $true;

        $suinfo->{_note} = $suinfo->{_note} . ' key=' . $suinfo->{_type};
        $suinfo->{_Step} = $suinfo->{_Step} . ' key=' . $suinfo->{_type};

    }
    else {
        print("suinfo, type, missing type,\n");
    }
}

=head2 sub unit

		use w/ L_SU

=cut

sub unit {

    my ( $self, $unit ) = @_;

    if ( $unit ne $empty_string ) {

        if ( $unit eq 'second' ) {

            $suinfo->{_unit}     = $unit;
            $suinfo->{_set_unit} = $true;

        }
        else {
            print(
"suinfo, unit, unit is not defined. An example of a unit is 'second',\n"
            );
        }
    }
    else {
        print("suinfo, unit, missing unit,\n");
    }
    return ();
}

=head2 sub get_max_index

   max index = number of input variables - 1
 
=cut

sub get_max_index {

    my ($self) = @_;
    my $max_index = 3;

    return ($max_index);
}

1;
