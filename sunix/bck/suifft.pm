package suifft;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: suifft
  AUTHOR: Juan Lorenzo 
  DATE:  July 7 2016
  DESCRIPTION:  A package that transforms real time traces
		into complex frequency traces
  VERSION: 1.0

=head2 Use

=head2 Notes

	'_note' keeps track of actions for use in graphics
	'_Step' keeps track of actions for execution in the system

=head2 Seismic Unix Notes

 SUIFFT - fft complex frequency traces to real time traces
 
 suiftt <stdin >sdout sign=-1
 
 Required parameters:
        none
 
 Optional parameter:
        sign=-1         sign in exponent of inverse fft
 
 Output traces are normalized by 1/N where N is the fft size.
 
 Note: suifft | suifft is not quite a no-op since the trace
        length will usually be longer due to fft padding.

=cut

my $suifft = {
    _Step    => '',
    _note    => '',
    _sign    => '',
    _dt      => '',
    _verbose => ''
};

=pod

=head1 Description of Subroutines

=head2 Subroutine clear
	
	Sets all variable strings to '' (nothing) 

=cut

sub clear {
    $suifft->{_Step}    = '';
    $suifft->{_note}    = '';
    $suifft->{_sign}    = '';
    $suifft->{_dt}      = '';
    $suifft->{_verbose} = '';
}

=pod

=head2 Subroutine sign
	
	sign in exponent of inverse fft
	!!Should be left undefined or at '-1'!!

=cut

sub sign {
    my ( $sub, $sign ) = @_;
    $suifft->{_sign} = $sign if defined($sign);
    $suifft->{_note} = $suifft->{_note} . ' sign=' . $suifft->{_sign};
    $suifft->{_Step} = $suifft->{_Step} . ' sign=' . $suifft->{_sign};
}

=head2 Subroutine dt
	
	dt 

=cut

sub dt {
    my ( $sub, $dt ) = @_;
    $suifft->{_dt}   = $dt if defined($dt);
    $suifft->{_note} = $suifft->{_note} . ' dt=' . $suifft->{_dt};
    $suifft->{_Step} = $suifft->{_Step} . ' dt=' . $suifft->{_dt};
}

=head2 Subroutine verbose
	
	verbose 

=cut

sub verbose {
    my ( $sub, $verbose ) = @_;
    $suifft->{_verbose} = $verbose if defined($verbose);
    $suifft->{_note}    = $suifft->{_note} . ' verbose=' . $suifft->{_verbose};
    $suifft->{_Step}    = $suifft->{_Step} . ' verbose=' . $suifft->{_verbose};
}

=pod

=head2 Subroutine Step

	Keeps track of actions for execution in the system

=cut

sub Step {
    $suifft->{_Step} = 'suifft' . $suifft->{_Step};
    return $suifft->{_Step};
}

=pod

=head2 Subroutine note

	Keeps track of actions for possible use in graphics

=cut

sub note {
    $suifft->{_note} = $suifft->{_note};
    return $suifft->{_note};
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
