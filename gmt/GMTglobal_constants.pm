package GMTglobal_constants;

use Moose;
extends 'L_SU_global_constants';

my $gmt_var = {
    _on        => 'on',
    _off       => 'off',
    _true      => 'true',
    _false     => 'false',
    _go        => ' & ',
    _to        => ' | ',
    _in        => ' < ',
    _out       => ' > ',
    _append_to => ' >> ',
    _no_head   => ' -O ',
    _no_tail   => ' -K ',
};

sub gmt_var {
    return ($gmt_var);
}

1;
