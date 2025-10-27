
package App::SeismicUnixGui::misc::param_flow;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 Perl package: param_flow.pm 
 AUTHOR: Juan Lorenzo
 DATE: Aug 3 2017 

 DESCRIPTION: 
 V 0.1 Aug 3 2017

 USED FOR: 

 BASED ON:
  param_flow.pm

=cut

use Moose;
our $VERSION = '0.0.1';
use Clone 'clone';

=pod

 private hash_ref
 w  for widgets

=cut

# arrays of arrays
my @program_names;
my @num_good_values;
my @num_good_labels;
my @good_labels;
my @good_values;

my @names;
my @values;
my @checkbuttons;

my $param_flow = {
    _checkbuttons_aref       => '',
    _checkbuttons_aref2      => '',
    _destination_index       => '',
    _end                     => '',
    _first_idx               => 0,    # not a string
    _good_checkbuttons_aref2 => '',
    _good_labels_aref2       => '',
    _good_values_aref2       => '',
    _index2move              => '',
    _index4flow              => -1,
    _index4checkbuttons      => -1,
    _index4names             => -1,
    _index4values            => -1,
    _indices                 => -1,
    _label_boxes_w           => '',
    _length                  => '',
    _names_aref              => '',
    _names_aref2             => '',
    _num_good_values_aref    => 0,
    _num_good_labels_aref    => 0,
    _num_items               => 0,
    _num_items4flow          => 0,
    _num_items4checkbuttons  => 0,
    _num_items4names         => 0,
    _num_items4values        => 0,
    _prog_names_aref         => '',
    _prog_version_aref       => 0,
    _selection_index         => '',
    _start                   => 0,
    _values_aref             => '',
    _values_aref2            => '',
};

use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';
my $get = L_SU_global_constants->new();
my $var = $get->var();
my $on  = $var->{_on};
my $off = $var->{_off};
my $nu  = $var->{_nu};

# =========================
# Centralized helpers
# =========================

# guard for nonnegative, defined index
sub _valid_index {
    my ($idx) = @_;
    return defined $idx && $idx =~ /^-?\d+$/ && $idx >= 0;
}

# guard for existing AoA slot
sub _slot_exists {
    my ($aref, $idx) = @_;
    return ref($aref) eq 'ARRAY' && _valid_index($idx) && $idx <= $#$aref;
}

# business rule: a "good" value is defined, not "'nu'", not empty
sub _is_good_value {
    my ($v) = @_;
    return defined $v && $v ne "'nu'" && $v ne '';
}

# extract an item (aligned) across all parallel arrays
sub _extract_item {
    my ($idx) = @_;
    my $pn  = splice( @{ $param_flow->{_prog_names_aref} },    $idx, 1 );
    my $nm  = splice( @{ $param_flow->{_names_aref2} },        $idx, 1 );
    my $val = splice( @{ $param_flow->{_values_aref2} },       $idx, 1 );
    my $chk = splice( @{ $param_flow->{_checkbuttons_aref2} }, $idx, 1 );
    return ($pn, $nm, $val, $chk);
}

# insert an item (aligned) across all parallel arrays
sub _insert_item {
    my ($idx, $pn, $nm, $val, $chk) = @_;
    splice( @{ $param_flow->{_prog_names_aref} },    $idx, 0, $pn );
    splice( @{ $param_flow->{_names_aref2} },        $idx, 0, $nm );
    splice( @{ $param_flow->{_values_aref2} },       $idx, 0, $val );
    splice( @{ $param_flow->{_checkbuttons_aref2} }, $idx, 0, $chk );
    return;
}

# recompute the trailing “indices” counters after a structural change
sub _after_mutation_recount {
    my $n = scalar @{ $param_flow->{_prog_names_aref} // [] } - 1;

    $param_flow->{_indices}             = $n;
    $param_flow->{_num_items}           = ($n >= 0) ? $n + 1 : 0;
    $param_flow->{_num_items4flow}      = $param_flow->{_num_items};
    $param_flow->{_num_items4values}    = $param_flow->{_num_items};
    $param_flow->{_num_items4names}     = $param_flow->{_num_items};
    $param_flow->{_num_items4checkbuttons} = $param_flow->{_num_items};

    $param_flow->{_index4flow}          = $n;
    $param_flow->{_index4values}        = $n;
    $param_flow->{_index4names}         = $n;
    $param_flow->{_index4checkbuttons}  = $n;
}

# generic setter for “good” items (labels or values) for a single flow item
# kind: 'labels' or 'values'
sub _set_good_items_for_item {
    my ($kind, $idx) = @_;
    return unless _valid_index($idx);

    my $vals_aref = $param_flow->{_values_aref2}[$idx];
    return unless ref($vals_aref) eq 'ARRAY';

    my @good;
    for my $i (0 .. $#$vals_aref) {
        my $v = $vals_aref->[$i];
        next unless _is_good_value($v);

        my $picked = ($kind eq 'labels')
            ? $param_flow->{_names_aref2}[$idx][$i]
            : $param_flow->{_values_aref2}[$idx][$i];

        push @good, $picked;
    }

    if ($kind eq 'labels') {
        $num_good_labels[$idx]              = scalar @good;
        $good_labels[$idx]                  = \@good;
        $param_flow->{_num_good_labels_aref}= \@num_good_labels;
        $param_flow->{_good_labels_aref2}   = \@good_labels;
    } else {
        $num_good_values[$idx]              = scalar @good;
        $good_values[$idx]                  = \@good;
        $param_flow->{_num_good_values_aref}= \@num_good_values;
        $param_flow->{_good_values_aref2}   = \@good_values;
    }
    return;
}

# run kind over all items
sub _set_good_items_for_all {
    my ($kind) = @_;
    my $n = $param_flow->{_num_items4flow} || 0;
    for my $i (0 .. $n-1) {
        _set_good_items_for_item($kind, $i);
    }
    return;
}

# =========================
# Public API (unchanged signatures)
# =========================

=head2 sub first_idx

 first usable index is set to 0

=cut 

sub first_idx {
    my ($self) = @_;
    $param_flow->{_first_idx} = 0;
    return $param_flow->{_first_idx};
}

=head2 sub get_num_good_values_aref

=cut 

sub get_num_good_values_aref {
    my ($self) = @_;
    return $param_flow->{_num_good_values_aref} || ();
}

=head2 sub get_num_good_labels_aref 

=cut 

sub get_num_good_labels_aref {
    my ($self) = @_;
    return $param_flow->{_num_good_labels_aref} || ();
}

=head2 sub insert_selection

 Move one selected item to a destination index (stable, aligned across arrays)

=cut

sub insert_selection {
    my ($self)    = @_;
    my $from      = $param_flow->{_index2move};
    my $to        = $param_flow->{_destination_index};

    return () unless _valid_index($from) && _valid_index($to);
    return () if $from == $to;

    my $end = $param_flow->{_indices};
    return () unless _slot_exists($param_flow->{_prog_names_aref}, $from);
    return () if $to > $end + 1;   # allow insertion at end+1 as “append”

    # extract “mobile” item from all arrays (aligned)
    my ($pn, $nm, $val, $chk) = _extract_item($from);

    # adjust destination if it was after the removed slot
    $to-- if $to > $from;

    # insert back at destination
    _insert_item($to, $pn, $nm, $val, $chk);

    # recount indices and counters
    _after_mutation_recount();
    return ();
}

=head2 sub delete_selection

 delete parameter names and values
 of on one  selected item

=cut

sub delete_selection {
    my ( $self, $index2delete ) = @_;
    return () unless _valid_index($index2delete);

    my $end = $param_flow->{_indices};
    return () unless _slot_exists($param_flow->{_prog_names_aref}, $index2delete);

    # Single splice across all arrays keeps them aligned
    _extract_item($index2delete);

    # Recount all index trackers and counters
    _after_mutation_recount();
    return ();
}

=head2 sub get_check_buttons_settings 

 Return current item's checkbutton settings (as stored)

=cut

sub get_check_buttons_settings {
    my $self  = @_;
    my $index = $param_flow->{_selection_index};
    return () unless _valid_index($index);
    return () unless _slot_exists($param_flow->{_checkbuttons_aref2}, $index);

    my @on_off = @{ $param_flow->{_checkbuttons_aref2}[$index] };
    # print("param_flow,get_check_buttons_settings: @on_off\n");
    return \@on_off;
}

=head2 sub get_flow_index 

 get current program index 
  
=cut 

sub get_flow_index {
    my ($self) = @_;
    return $param_flow->{_index4flow};
}

=head2 sub get_flow_prog_names_aref 

  extract sequential program names in flow 
  
=cut 

sub get_flow_prog_names_aref {
    my ($self) = @_;
    return $param_flow->{_prog_names_aref};
}

=head2 sub get_good_labels_aref2

=cut

sub get_good_labels_aref2 {
    my ($self) = @_;
    return $param_flow->{_good_labels_aref2} || ();
}

=head2  sub get_good_values_aref2

=cut

sub get_good_values_aref2 {
    my ($self) = @_;
    return $param_flow->{_good_values_aref2} || ();
}

=head2 sub get_names_aref

=cut

sub get_names_aref {
    my ($self) = @_;
    my $index = $param_flow->{_selection_index};
    return () unless _valid_index($index);
    return () unless _slot_exists($param_flow->{_names_aref2}, $index);

    my @names_aref = @{ $param_flow->{_names_aref2}[$index] };
    return \@names_aref;
}

=head2 sub get_num_items

=cut

sub get_num_items {
    my ($self) = @_;
    return $param_flow->{_num_items};
}

=head2 sub get_values_aref

=cut

sub get_values_aref {
    my ($self) = @_;
    my $index = $param_flow->{_selection_index};
    return () unless _valid_index($index);
    return () unless _slot_exists($param_flow->{_values_aref2}, $index);

    my @values_aref = @{ $param_flow->{_values_aref2}[$index] };
    return \@values_aref;
}

=head2 sub get_flow_items_version_aref 

 o/p is array ref of the version of each program name

=cut 

sub get_flow_items_version_aref {
    my ($self) = @_;
    return $param_flow->{_prog_version_aref};
}

=head2 sub length 

 last item number (not last index) 
 last item number is equivalent to length

=cut 

sub length {
    my ($self) = @_;
    my $index = $param_flow->{_selection_index};
    return () unless _valid_index($index);
    return () unless _slot_exists($param_flow->{_values_aref2}, $index);

    my $length = scalar @{ $param_flow->{_values_aref2}[$index] };
    return $length;
}

=head2 sub private_get_good_length4item 

=cut

sub private_get_good_length4item {
    my ( $self, $index4flow ) = @_;
    my $idx = $index4flow;
    return 0 unless _valid_index($idx);
    my $aref = $param_flow->{_good_values_aref2}[$idx] // [];
    return scalar @$aref;
}

=head2 sub private_get_names_aref

=cut

sub private_get_names_aref {
    my ($item_index) = @_;
    return () unless _valid_index($item_index);
    return () unless _slot_exists($param_flow->{_names_aref2}, $item_index);

    my @names_aref = @{ $param_flow->{_names_aref2}[$item_index] };
    return \@names_aref;
}

=head2 sub private_get_values_aref

=cut

sub private_get_values_aref {
    my ($item_index) = @_;
    return () unless _valid_index($item_index);
    return () unless _slot_exists($param_flow->{_values_aref2}, $item_index);

    my @values_aref = @{ $param_flow->{_values_aref2}[$item_index] };
    return \@values_aref;
}

=head2 sub private_set_good_labels4item 

=cut

sub private_set_good_labels4item {
    my ($index4flow) = @_;
    _set_good_items_for_item('labels', $index4flow);
    return;
}

=head2 sub private_set_good_values4item 

	Set good values privately for a single item (program name)
	within a flow

=cut

sub private_set_good_values4item {
    my ($index4flow) = @_;
    _set_good_items_for_item('values', $index4flow);
    return;
}

=head2 sub set_flow_items_version_aref 

 i/p is array ref of the version of each program name

=cut 

sub set_flow_items_version_aref {
    my ( $self, $program_version_aref ) = @_;
    return unless $program_version_aref;
    $param_flow->{_prog_version_aref} = $program_version_aref;
    return;
}

=head2 sub  set_insert_start 

 move parameter names and values
 of one selected item into another space

=cut

sub set_insert_start {
    my ( $self, $start ) = @_;
    $param_flow->{_index2move} = $start;
    return ();
}

=head2 sub set_insert_end

 move parameter names and values
 of one selected item into another space

=cut

sub set_insert_end {
    my ( $self, $end ) = @_;
    $param_flow->{_destination_index} = $end;
    return ();
}

=head2 sub set_flow_index 

 select an item for which to extract data
  
=cut 

sub set_flow_index {
    my ( $self, $index ) = @_;
    if ( _valid_index($index) ) {
        $param_flow->{_selection_index} = $index;
    } else {
        print("param_flow, set_flow_index: invalid index: $index\n");
    }
    return ();
}

=head2 sub set_names_aref

=cut

sub set_names_aref {
    my ( $self, $names_aref ) = @_;
    my $index = $param_flow->{_selection_index};
    return () unless _valid_index($index);

    $param_flow->{_names_aref2}[$index] = $names_aref;
    return ();
}

=head2 sub set_good_labels 

	select names with values

=cut

sub set_good_labels {
    my ($self) = @_;
    _set_good_items_for_all('labels');
    return ();
}

=head2 sub set_good_values

	find good values for ALL programs in flow

=cut

sub set_good_values {
    my ($self) = @_;
    _set_good_items_for_all('values');
    return ();
}

=head2 sub set_good_labels4item 

=cut

sub set_good_labels4item {
    my ( $self, $index4flow ) = @_;
    _set_good_items_for_item('labels', $index4flow);
    return ();
}

=head2 sub set_good_values4item 

 work on finding good values for one item

=cut

sub set_good_values4item {
    my ( $self, $index4flow ) = @_;
    _set_good_items_for_item('values', $index4flow);
    return ();
}

=head2 sub set_values_aref

=cut

sub set_values_aref {
    my ( $self, $values_aref ) = @_;
    my $index = $param_flow->{_selection_index};
    return () unless _valid_index($index);

    $param_flow->{_values_aref2}[$index] = $values_aref;
    return ();
}

=head2 sub set_check_buttons_settings_aref 

 set check_buttons by user from outside

=cut

sub set_check_buttons_settings_aref {
    my ( $self, $check_buttons_settings_aref ) = @_;
    my $index = $param_flow->{_selection_index};
    return () unless _valid_index($index);

    $param_flow->{_checkbuttons_aref2}[$index] = $check_buttons_settings_aref;
    return ();
}

=head2 sub stack_checkbuttons_aref2

  array of arrays
  One array of checkbuttons for each item

=cut

sub stack_checkbuttons_aref2 {
    my ( $self, $checkbuttons_aref ) = @_;
    my $index = $param_flow->{_index4checkbuttons} + 1;

    $checkbuttons[$index]                   = $checkbuttons_aref;
    $param_flow->{_checkbuttons_aref2}      = \@checkbuttons;

    $param_flow->{_indices}                 = $index;
    $param_flow->{_index4checkbuttons}      = $index;
    $param_flow->{_num_items4checkbuttons}++;
    $param_flow->{_num_items}               = $param_flow->{_num_items4checkbuttons};
    return ();
}

=head2 sub stack_flow_item 

 i/p is scalar ref to a program name
 keep count and increment the number of items

=cut 

sub stack_flow_item {
    my ( $self, $program_name_sref ) = @_;
    return () unless $program_name_sref;

    my $index = $param_flow->{_index4flow} + 1;

    $program_names[$index]            = $$program_name_sref;
    $param_flow->{_prog_names_aref}   = \@program_names;

    $param_flow->{_indices}           = $index;
    $param_flow->{_index4flow}        = $index;
    $param_flow->{_num_items4flow}++;
    $param_flow->{_num_items}++;
    return ();
}

=head2 sub stack_names_aref2 

 i/p array ref for names in a program
 an array of arrays is created, one array for each item

=cut

sub stack_names_aref2 {
    my ( $self, $names_aref ) = @_;
    my $index = $param_flow->{_index4names} + 1;

    $names[$index]                  = $names_aref;
    $param_flow->{_names_aref2}     = \@names;

    $param_flow->{_indices}         = $index;
    $param_flow->{_index4names}     = $index;
    $param_flow->{_num_items4names}++;
    $param_flow->{_num_items}       = $param_flow->{_num_items4names};
    return ();
}

=head2 sub stack_values_aref2 

 i/p array ref for values in a program
 an array of arrays is created, one array for each item

=cut

sub stack_values_aref2 {
    my ( $self, $values_aref ) = @_;
    my $index = $param_flow->{_index4values} + 1;

    $values[$index]                 = $values_aref;
    $param_flow->{_values_aref2}    = \@values;

    $param_flow->{_indices}         = $index;
    $param_flow->{_index4values}    = $index;
    $param_flow->{_num_items4values}++;
    $param_flow->{_num_items}       = $param_flow->{_num_items4values};
    return ();
}

=head2 sub view_data

 Data viewer for debugging

=cut

sub view_data {
    my ( $self, $index2delete ) = @_;
    my @num_progs;

    my $indices = $param_flow->{_indices};
    $num_progs[0] = $param_flow->{_num_items};

    $num_progs[1] = scalar( @{ $param_flow->{_names_aref2} // [] } );
    $num_progs[3] = scalar( @{ $param_flow->{_values_aref2} // [] } );
    $num_progs[4] = scalar( @{ $param_flow->{_checkbuttons_aref2} // [] } );
    $num_progs[5] = scalar( @{ $param_flow->{_prog_names_aref} // [] } );

# print("\nparam_flow,view_data:number of items in list in 4-5 different ways  @num_progs \n");
# print("param_flow,view_data:max index = $indices  \n\n");

    print("param_flow,view_data:  prog_names:   @{$param_flow->{_prog_names_aref}}\n");
    for ( my $i = 0 ; $i <= $indices ; $i++ ) {
        print("param_flow,view_data: names:        @{@{$param_flow->{_names_aref2}}[$i]}\n");
#       print("param_flow,view_data: values:       @{@{$param_flow->{_values_aref2}}[$i]}\n");
#       print("param_flow,view_data: checkbuttons: @{@{$param_flow->{_checkbuttons_aref2}}[$i]}\n\n");
    }
}

1;
