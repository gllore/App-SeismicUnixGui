package swapbytes;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SWAPBYTES - SWAP the BYTES of various  data types			
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SWAPBYTES - SWAP the BYTES of various  data types			

 swapbytes <stdin [optional parameters]  >stdout 			

 Required parameters:							
 	none								

 Optional parameters:							
 in=float	input type	(float)					
 		=double		(double)				
 		=short		(short)					
 		=ushort		(unsigned short)			
 		=long		(long)					
 		=ulong		(unsigned long)				
 		=int		(int)					

 outpar=/dev/tty		output parameter file, contains the	
				number of values (n1=)			
 			other choices for outpar are: /dev/tty,		
 			/dev/stderr, or a name of a disk file		

 Notes:								
 The byte order of the mantissa of binary data values on PC's and DEC's
 is the reverse of so called "big endian" machines (IBM RS6000, SUN,etc.)
 hence the need for byte-swapping capability. The subroutines in this code
 have been tested for swapping between PCs and	big endian machines, but
 have not been tested for DEC products.				

 Caveat:								
 2 byte short, 4 byte long, 4 byte float, 4 byte int,			
 and 8 bit double assumed.						


 Credits:
	CWP: John Stockwell (Jan 1994)
 Institut fur Geophysik, Hamburg: Jens Hartmann supplied byte swapping
					subroutines



=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

my $swapbytes = {
    _in     => '',
    _outpar => '',
    _Step   => '',
    _note   => '',
};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

sub Step {

    $swapbytes->{_Step} = 'swapbytes' . $swapbytes->{_Step};
    return ( $swapbytes->{_Step} );

}

=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

sub note {

    $swapbytes->{_note} = 'swapbytes' . $swapbytes->{_note};
    return ( $swapbytes->{_note} );

}

=head2 sub clear

=cut

sub clear {

    $swapbytes->{_in}     = '';
    $swapbytes->{_outpar} = '';
    $swapbytes->{_Step}   = '';
    $swapbytes->{_note}   = '';
}

=head2 sub in 


=cut

sub in {

    my ( $self, $in ) = @_;
    if ($in) {

        $swapbytes->{_in} = $in;
        $swapbytes->{_note} =
          $swapbytes->{_note} . ' in=' . $swapbytes->{_in};
        $swapbytes->{_Step} =
          $swapbytes->{_Step} . ' in=' . $swapbytes->{_in};

    }
    else {
        print("swapbytes, in, missing in,\n");
    }
}

=head2 sub outpar 


=cut

sub outpar {

    my ( $self, $outpar ) = @_;
    if ($outpar) {

        $swapbytes->{_outpar} = $outpar;
        $swapbytes->{_note} =
          $swapbytes->{_note} . ' outpar=' . $swapbytes->{_outpar};
        $swapbytes->{_Step} =
          $swapbytes->{_Step} . ' outpar=' . $swapbytes->{_outpar};

    }
    else {
        print("swapbytes, outpar, missing outpar,\n");
    }
}

=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut

sub get_max_index {
    my ($self) = @_;

    #index=1
    my $max_index = 1;

    return ($max_index);
}

1;
