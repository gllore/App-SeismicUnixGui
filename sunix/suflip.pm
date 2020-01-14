package suflip;
use Moose;

=pod

=head1 Documentation

=head2 Synopsis

  PROGRAM NAME: suflip
  AUTHOR:  Derek Goff
  DATE:  JAN 14 2014
  DESCRIPTION:  A package that rotates, flips, or transposes data 
  VERSION: 1.1

=head2 Use

=head3 Notes

SUFLIP - flip a data set in various ways
 
 suflip <data1 >data2 flip=1 verbose=0
 
 Required parameters:
        none
 
 Optional parameters:
        flip=1  rotational sense of flip
                        +1  = flip 90 deg clockwise
                        -1  = flip 90 deg counter-clockwise
                         0  = transpose data
                         2  = flip right-to-left
                         3  = flip top-to-bottom
        tmpdir=  if non-empty, use the value as a directory path
                 prefix for storing temporary files; else if
                 the CWP_TMPDIR environment variable is set use
                 its value for the path; else use tmpfile()
 
        verbose=0       verbose = 1 echoes flip info
 
 NOTE:  tr.dt header field is lost if flip=-1,+1.  It can be
        reset using sushw.
 
 EXAMPLE PROCESSING SEQUENCES:
   1.   suflip flip=-1 <data1 | sushw key=dt a=4000 >data2
 
   2.   suflip flip=2 <data1 | suflip flip=2 >data1_again
 
   3.   suflip tmpdir=/scratch <data1 | ...
 
 Caveat:  may fail on large files.

=cut

my $suflip = {
    _Step      => '',
    _note      => '',
    _flip      => '',
    _transpose => ''
};

=head1 Description of Subroutines

=head2 Subroutine clear
	
	Sets all variable strings to '' (nothing) 

=cut

sub clear {
    $suflip->{_Step}      = '';
    $suflip->{_note}      = '';
    $suflip->{_flip}      = '';
    $suflip->{_transpose} = '';
}

=head2 Subroutine flip

	Flips the data

	flip=           +1  = flip 90 deg clockwise
                        -1  = flip 90 deg counter-clockwise
                         0  = transpose data
                         2  = flip right-to-left
                         3  = flip top-to-bottom
=cut

sub flip {
    my ( $sub, $flip ) = @_;
    $suflip->{_flip} = $flip if defined($flip);
    $suflip->{_note} = $suflip->{_note} . ' flip=' . $suflip->{_flip};
    $suflip->{_Step} = $suflip->{_Step} . ' flip=' . $suflip->{_flip};
}

=head2 tanspose

=cut

sub transpose {
    my ( $variable, $transpose ) = @_;
    if ( $transpose == 1 ) {
        $suflip->{_Step} = $suflip->{_Step} . ' flip=0';
        $suflip->{_note} = $suflip->{_note} . ' flip=transpose';
    }
}

=head2 Subroutine Step

	Keeps track of actions for execution in the system

=cut

sub Step {
    $suflip->{_Step} = 'suflip' . $suflip->{_Step};
    return $suflip->{_Step};
}

=head2 Subroutine note

	Keeps track of actions for possible use in graphics

=cut

sub note {
    $suflip->{_note} = $suflip->{_note};
    return $suflip->{_note};
}

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
    my ($self) = @_;

    # only file_name : index=6
    my $max_index = 6;

    return ($max_index);
}

1;

