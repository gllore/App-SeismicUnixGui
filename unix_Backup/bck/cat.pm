package cat;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: cat
 AUTHOR: Juan Lorenzo
 DATE: Oct 10 2012
 DESCRIPTION concatenates lists of file names
 Version 1

 STEPS ARE:
=cut

$newline = '
';

sub new {
    my $class = shift;
    my $cat   = {
        _list
        , => shift,
        _note
        , => shift,
        _start
        , => shift,
        _end
        ,      => shift,
        _Step, => shift,
    };
    init();
    bless $cat, $class;
    return $cat;
}

sub init {
    $cat->{_note} = ' cat ';
    $cat->{_step} = ' cat ';
}

sub clear {
    $cat->{_list}  = '';
    $cat->{_note}  = '';
    $cat->{_start} = '';
    $cat->{_end}   = '';
    $cat->{_Step}  = '';
}

sub first {
    my ( $first, $start ) = @_;
    $cat->{_note} = ' from file # ' . $start;
    $cat{_start} = $start if defined($start);
}

sub last {
    my ( $last, $end ) = @_;
    $cat->{_note} = ' to # ' . $end;
    $cat{_end} = $end if defined($end);
}

sub list {
    my ( $list, $DIR, $ref_array ) = @_;
    @list = @$ref_array if defined($ref_array);
    $cat->{_DIR} = $DIR if defined($DIR);
    $cat->{_step} = $cat->{_step};

    my $start = $cat{_start};
    my $end   = $cat{_end};

    for ( $i = $start ; $i <= $end ; $i++ ) {

        #print("i=$i\n\n");
        $cat->{_step} =
          $cat->{_step} . $cat->{_DIR} . '/' . $list[$i] . ' \\' . $newline;
    }
}

sub Step {
    my ($Step) = @_;
    $cat->{_Step} = $cat->{_step};
    return $cat->{_Step};
}

1;
