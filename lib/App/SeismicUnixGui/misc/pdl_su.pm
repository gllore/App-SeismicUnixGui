package App::SeismicUnixGui::misc::pdl_su;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: pdl_su 
 AUTHOR: 	Juan Lorenzo
 DATE: 		March 19 2018 

 DESCRIPTION 
     Plot image and graphics files 

 BASED ON:
 	Inspired by suximage and suxgraph

=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut 

=head2 Notes from bash
 

=cut

use Moose;
use PDL::Core;
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';
our $VERSION = '0.0.2';

=head2 Assign Global Variables

		instantiate packages
=cut

my $get          = L_SU_global_constants->new();
my $var          = $get->var();
my $empty_string = $var->{_empty_string};

=head2 private hash containing
	imporant variables

=cut

my $pdl_su = {
    _bytes_per_sample            => 4,
    _canvas_width_pix            => '',
    _canvas_height_pix           => '',
    _canvas_min_x_m              => '',
    _canvas_max_x_m              => '',
    _canvas_min_trace            => '',
    _canvas_max_trace_num        => '',
    _ctab                        => '',
    _data                        => '',
    _dpi                         => '',
    _inbound_base_file_name      => '',
    _inbound_binary_format       => '',
    _inbound_file_path           => '',
    _inbound_parameter_file_name => '',
    _inbound_parameter_file_path => '',
    _inbound_suffix_type         => '',
    _gain                        => '',
    _number_of_traces            => '',
    _pdl                         => '',
    _png_data                    => '',
    _png_file                    => '',
    _resize_x                    => 1,
    _resize_y                    => 1,
    _samples_per_trace           => '',
    _seismic_page_width          => '',
    _seismic_page_height         => '',
    _sample_interval_ms          => '',
    _sample_interval_us          => '',
    _suffix_type                 => '',
    _viewport_top                => '',
    _viewport_bottom             => '',
    _viewport_left_min           => '',
    _viewport_right_max          => '',
    _write_format                => '',
};

=head3 Definition of an sustripped binary header format

C-type IBM 4-byte-Floating Point binary amplitudes


	 # anonymous list
	 my $header 	= [
        				{ Type  => 'float',
        		  		  NDims => 2, 
        		  		  Dims  => [1,2] 
        				}
    				  ];
=cut

=head2 sub _set_inbound_file_path

=cut

sub _set_inbound_file_path {
    my ($self) = @_;

    if ( $pdl_su->{_inbound_suffix_type} ne $empty_string ) {

        use App::SeismicUnixGui::configs::big_streams::Project_config;
        my $Project = Project_config->new();

        my $inbound_suffix_type = $pdl_su->{_inbound_suffix_type};

        if ( $inbound_suffix_type eq 'su' ) {

            my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
            $pdl_su->{_inbound_file_path} = $DATA_SEISMIC_SU;

            # print("pdl_su,_set_inbound_file_path: $path \n");
            return ();

        }
        else {
            print("pdl_su,_set_inbound_file_path is missing suffix type \n");
        }

    }
    else {
        print(
            "pdl_su,_set_inbound_file_path, missing parameter for file path\n");
    }

}

=head2 sub get_bytes_per_sample

=cut

sub get_bytes_per_sample {
    my ($self) = @_;

    if ( $pdl_su->{_bytes_per_sample} ne $empty_string ) {

        my $bytes = $pdl_su->{_bytes_per_sample};

        # print("pdl_su,get_bytes_per_sample: $bytes \n");
        return ($bytes);

    }
    else {
        print("pdl_su,get_bytes_per_sample,missing bytes \n");
        return ();
    }
}

=head3 sub get_formatted_bytes

=cut

sub get_formatted_bytes {

    my ($self) = @_;

    if (   $pdl_su->{_number_of_traces} ne $empty_string
        && $pdl_su->{_samples_per_trace} ne $empty_string
        && $pdl_su->{_bytes_per_sample} ne $empty_string )
    {

        my $bytes = $pdl_su->{_data};

        my (@numbers) = unpack( "f", $bytes );
        my $size = scalar @numbers;

        # print("number samples = $size \n");

        #	my $dimX                = $num_samples/1999;
        #	my $dimY                = $num_samples/64;
##    	print("pdl_su,get_formatted_bytes, no.samples= $num_samples\n");
##    	print("pdl_su,_get_formatted_bytes, dimX= $dimX, dimY= $dimY\n");
        #
        #		if ( )   {
        #			my $release				=  $pdl_su->{_pdl};
        #			return($release);
        #
        #		} else {
        #			print("pdl_su, get_formatted_bytes, missing pdl_su->{_pdl} \n");
        #			return();
    }
}

=head2 sub get_number_of_traces

=cut

sub get_number_of_traces {
    my ($self) = @_;

    if ( $pdl_su->{_number_of_traces} ne $empty_string ) {

        my $num_traces = $pdl_su->{_number_of_traces};

        # print("pdl_su,get_number_of_traces: $num_traces \n");
        return ($num_traces);

    }
    else {
        print("pdl_su,missing number_of_traces \n");
    }

}

=head3 sub get_pdl

=cut

sub get_pdl {

    my ($self) = @_;

    _set_inbound_file_path();
    $pdl_su->{_pdl} = _su2pdl();
    my $total_num_samples = nelem( $pdl_su->{_pdl} );

    # print("pdl_su,get_pdl, total no.samples= $total_num_samples\n");

    if ( $total_num_samples != 0 ) {

##		my $num_samples 		= nelem($pdl_su->{_pdl});
##		my $dimX                = $num_samples/1999;
##		my $dimY                = $num_samples/64;
##    	print("pdl_su,get_pdl, no.samples= $num_samples\n");
##    	print("pdl_su,_get_pdl, dimX= $dimX, dimY= $dimY\n");
        #		# my @dims				= dims ($pdl_su->{_pdl});
        #		# print (" my piddle dims = @dims \n");
        my $release = $pdl_su->{_pdl};
        return ($release);

    }
    else {
        print("pdl_su, get_pdl, missing pdl_su->{_pdl} \n");
        return ();
    }
}

=head2 sub get_sample_interval_us

=cut

sub get_sample_interval_us {
    my ($self) = @_;

    if ( $pdl_su->{_sample_interval_us} ne $empty_string ) {

        my $sample_interval_us = $pdl_su->{_sample_interval_us};

        # print("pdl_su,get_sample_interval_us: $sample_interval_us \n");
        return ($sample_interval_us);

    }
    else {
        print("pdl_su,missing sample_interval_us \n");
    }

}

=head2 sub get_samples_per_trace

=cut

sub get_samples_per_trace {
    my ($self) = @_;

    if ( $pdl_su->{_samples_per_trace} ne $empty_string ) {

        my $samples_per_trace = $pdl_su->{_samples_per_trace};

        # print("pdl_su,get_samples_per_trace: $samples_per_trace\n");
        return ($samples_per_trace);

    }
    else {
        print("pdl_su,missing samples_per_trace\n");
    }

}

=head2 sub get_seismic_plot_offset

=cut

sub get_seismic_plot_x_offset {

    my ($self) = @_;

    if (   $pdl_su->{_seismic_page_width} ne $empty_string
        && $pdl_su->{_seismic_page_height} ne $empty_string )
    {

        my $seismic_page_width  = $pdl_su->{_seismic_page_width};
        my $seismic_page_height = $pdl_su->{_seismic_page_height};
        my $seismic_plot_height = $pdl_su->{_seismic_page_height};  # assumption

        my $seismic_plot_width =
          $seismic_page_height * $seismic_page_height / $seismic_page_width;
        my $seismic_plot_x_offset =
          0.5 * ( $seismic_plot_width - $seismic_page_width );

        print("pdl_su,get_seismic_plot_x_offset: $seismic_plot_x_offset\n");
        return ($seismic_plot_x_offset);

    }
    else {
        print("pdl_su,get_seismic_plot_x_offset missing parameters \n");
    }

}

sub read_bytes {

    my ($self) = @_;

    if (   $pdl_su->{_inbound_base_file_name} ne $empty_string
        && $pdl_su->{_inbound_file_path} ne $empty_string
        && $pdl_su->{_number_of_traces} ne $empty_string
        && $pdl_su->{_samples_per_trace} ne $empty_string
        && $pdl_su->{_bytes_per_sample} ne $empty_string )
    {

        use autodie;
        my $num_samples = 1;    # $pdl_su->{_samples_per_trace};

        # Open the file
        my $file = $pdl_su->{_inbound_file_path} . '/'
          . $pdl_su->{_inbound_base_file_name};

        # set stream to binary mode
        open my $fh, '<:raw', $file;

        my $sample;             # read buffer
        my ( $ampl, $nbytes );
        my $Bite_size = $pdl_su->{_bytes_per_sample};

        while ( ( $nbytes = read $fh, $sample, $Bite_size ) ) {

            #		while (<$fh>) {
            #			($a) = sscanf("0+0 0.000000-", $input);

            # ...and unpack() them as a single float
            $ampl = unpack( "c", $sample );

            # print "sample = $ampl\n";

        }
        close $fh;
        print "DONE\n";
        $pdl_su->{_data} = $ampl;

    }
    else {
        print("pdl_su, read_bytes, missing hash values \n");
    }
}

=head2 sub set_bytes_per_sample

=cut

sub set_bytes_per_sample {
    my ( $self, $bytes ) = @_;

    if ( $bytes ne $empty_string ) {

        $pdl_su->{_bytes_per_sample} = $bytes;

        # print("pdl_su,set_bytes_per_sample: $bytes \n");
        return ();

    }
    else {
        print("pdl_su,missing $bytes \n");
    }

}

=head2 sub set_suffix_type

=cut

sub set_suffix_type {
    my ( $self, $suffix_type ) = @_;

    if ( $suffix_type ne $empty_string ) {

        $pdl_su->{_suffix_type} = $suffix_type;

        # print("pdl_su,set_suffix_type: $suffix_type \n");
        return ();

    }
    else {
        print("pdl_su,missing $suffix_type \n");
    }

}

=head2 sub set_inbound_base_file_name

=cut

sub set_inbound_base_file_name {
    my ( $self, $file_name ) = @_;

    if ( $file_name ne $empty_string ) {

        $pdl_su->{_inbound_base_file_name} = $file_name;

        # print("pdl_su,set_inbound_base_file_name: $file_name \n");
        return ();

    }
    else {
        print("pdl_su,missing $file_name \n");
    }

}

=head2 set_inbound_binary_format

=cut

sub set_inbound_binary_format {
    my ( $self, $inbound_binary_format ) = @_;

    if ( $inbound_binary_format ne $empty_string ) {

        $pdl_su->{_inbound_binary_format} = $inbound_binary_format;

        # print("pdl_su,set_inbound_binary_format: $inbound_binary_format\n");

    }
    else {
        print("pdl_su, missing inbound_binary_format\n");
    }
    return ();
}

=head2 sub set_inbound_file_path

=cut

sub set_inbound_file_path {
    my ( $self, $path ) = @_;

    if ( $path ne $empty_string ) {

        $pdl_su->{_inbound_file_path} = $path;

        # print("pdl_su,set_inbound_file_path: $path \n");
        return ();

    }
    else {
        print("pdl_su,missing $path \n");
    }

}

=head2 sub set_inbound_parameter_file_name

=cut

sub set_inbound_parameter_file_name {
    my ( $self, $parameter_file_name ) = @_;

    if ( $parameter_file_name ne $empty_string ) {

        $pdl_su->{_inbound_parameter_file_name} = $parameter_file_name;

     # print("pdl_su,set_inbound_parameter_file_name: $parameter_file_name \n");
        return ();

    }
    else {
        print("pdl_su,missing $parameter_file_name \n");
    }

}

=head2 sub set_inbound_parameter_file_path

=cut

sub set_inbound_parameter_file_path {
    my ( $self, $parameter_file_path ) = @_;

    if ( $parameter_file_path ne $empty_string ) {

        $pdl_su->{_inbound_parameter_file_path} = $parameter_file_path;

     # print("pdl_su,set_inbound_parameter_file_path: $parameter_file_path \n");
        return ();

    }
    else {
        print("pdl_su,missing $parameter_file_path \n");
    }

}

=head2 sub set_inbound_suffix_type

=cut

sub set_inbound_suffix_type {
    my ( $self, $suffix_type ) = @_;

    if ( $suffix_type ne $empty_string ) {

        $pdl_su->{_inbound_suffix_type} = $suffix_type;

        # print("pdl_su,set_inbound_suffix_type: $suffix_type \n");
        return ();

    }
    else {
        print("pdl_su,missing $suffix_type \n");
    }

}

=head2 sub set_number_of_traces

=cut

sub set_number_of_traces {
    my ( $self, $num_traces ) = @_;

    if ( $num_traces ne $empty_string ) {

        $pdl_su->{_number_of_traces} = $num_traces;

        # print("pdl_su,set_number_of_traces: $num_traces \n");
        return ();

    }
    else {
        print("pdl_su,missing $num_traces \n");
    }
}

=head2 sub set_sample_interval_us

=cut

sub set_sample_interval_us {
    my ( $self, $sample_interval_us ) = @_;

    if ( $sample_interval_us ne $empty_string ) {

        $pdl_su->{_sample_interval_us} = $sample_interval_us;

        # print("pdl_su,set_sample_interval_us: $sample_interval_us \n");
        return ();

    }
    else {
        print("pdl_su,missing $sample_interval_us \n");
    }

}

=head2 sub set_samples_per_trace

=cut

sub set_samples_per_trace {
    my ( $self, $num_samples ) = @_;

    if ( $num_samples ne $empty_string ) {

        $pdl_su->{_samples_per_trace} = $num_samples;

        # print("pdl_su,set_samples_per_trace: $num_samples \n");
        return ();

    }
    else {
        print("pdl_su,missing $num_samples \n");
    }

}

=head2 sub set_seismic_page_height

=cut

sub set_seismic_page_height {
    my ( $self, $seismic_page_height ) = @_;

    if ( $seismic_page_height ne $empty_string ) {

        $pdl_su->{_seismic_page_height} = $seismic_page_height;

        # print("pdl_su,set_seismic_page_height: $seismic_page_height \n");
        return ();

    }
    else {
        print("pdl_su,missing seismic_page_height \n");
    }

}

=head2 sub set_seismic_page_width

=cut

sub set_seismic_page_width {
    my ( $self, $seismic_page_width ) = @_;

    if ( $seismic_page_width ne $empty_string ) {

        $pdl_su->{_seismic_page_width} = $seismic_page_width;

        # print("pdl_su,set_seismic_page_width: $seismic_page_width \n");
        return ();

    }
    else {
        print("pdl_su,missing seismic_page_width \n");
    }

}

=head3 sub _su2pdl

    fill columns first
    actual pdl structure is built here

=cut

sub _su2pdl {
    my ($self) = @_;

    if (   $pdl_su->{_inbound_suffix_type} eq 'su'
        && $pdl_su->{_inbound_base_file_name} ne $empty_string
        && $pdl_su->{_inbound_file_path} ne $empty_string )
    {

        use PDL::Core;
        use PDL::IO::FlexRaw;

        my $path    = $pdl_su->{_inbound_file_path};
        my $name    = $pdl_su->{_inbound_base_file_name};
        my $suffix  = $pdl_su->{_inbound_suffix_type};
        my $inbound = $path . '/' . $name . '.' . $suffix;

        # get file size from sufile and some metadata from su headers
        # and generate a binary file
        my $cmd              = "sustrip < $inbound ftn=0 outpar=/dev/null |";
        my $size             = `wc -c  $inbound| awk '{print \$1}'`;
        my $ns               = `sugethw key=ns output=geom < $inbound| sed 1q`;
        my $dt               = `sugethw key=dt output=geom < $inbound| sed 1q`;
        my $bytes_per_sample = $pdl_su->{_bytes_per_sample};
        my $ntr              = $size / ( $ns * $bytes_per_sample + 240 );

        $pdl_su->{_sample_interval_ms}   = $dt,
          $pdl_su->{_sample_interval_us} = $dt * 1000;

        (
            $pdl_su->{_number_of_traces},
            $pdl_su->{_sample_interval_us},
            $pdl_su->{_samples_per_trace}
        ) = ( $ntr, $dt, $ns );

# get the su data size internally
# print("pdl_su,_su2pdl,inbound= $inbound \n");
# print("pdl_su,_su2pdl,size=$size Bytes,ntr=$ntr dt=$dt ns=$ns bytes_per_sample=$bytes_per_sample\n");
# anonymous list
# build a trace - X and time -vertical array
        my $header = [
            {
                Type  => 'float',
                NDims => 2,
                Dims  => [ $ns, $ntr ]
            }
        ];
        open( SUSTRIP, $cmd );

        # capture of filehandle via pdl
        # and formatting the piddle
        my $pdl_su->{_pdl} = readflex( \*SUSTRIP, $header );
        my $release = $pdl_su->{_pdl};

        my $total_num_samples = nelem( $pdl_su->{_pdl} );
        my $dimX              = $total_num_samples / $ns;
        my $dimY              = $total_num_samples / $ntr;

        # print("pdl_su,bin2pdl, total no.samples= $total_num_samples\n");
        # print("pdl_su,_bin2pdl, dimX= $dimX, dimY= $dimY\n");

        close(SUSTRIP);
        return ($release);

    }
    else {
        print(
            "pdl_su,_su2pdl,bin2pdl, missing file name, path or suffix type\n");
    }

    return ();
}

1;
