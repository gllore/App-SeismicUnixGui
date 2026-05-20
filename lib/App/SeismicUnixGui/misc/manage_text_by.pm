package App::SeismicUnixGui::misc::manage_text_by;

=head1 DOCUMENTATION

=head2 SYNOPSIS 
 Contains methods/subroutines/functions to operate on 
 slurped bodies of text

 PROGRAM NAME: manage_text_by 
 AUTHOR: Juan Lorenzo
 DATE:   V 0.0.1
May 2026
         
 DESCRIPTION: 


 =head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 NOTES  

=head4 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

use Carp qw(confess);

=head2 Instantiate

modules

=cut



=head2 define private hash
to share

=cut

my @array1;
my @array2;

my $manage_text_by = {
	_all_lines_aref         => '',
};

=head2 sub clear

Clear all memory

=cut

sub clear {
	my $self = @_;
	$manage_text_by->{_all_lines_aref}         = '';

}


# =head2 sub insert_block_after_position

#     This subroutine inserts a block of lines into an array of lines after a specified position
#     The position is defined as the index after which the lines will be inserted
#     The lines to insert are defined as an array reference

# =cut

# sub insert_block_after_position {

#     my ($self,$complete_text_aref, $lines_to_insert_aref, $insert_after_index) = @_;

#     confess "complete text array reference is undefined"
#         unless defined $complete_text_aref;

#     confess "lines-to-insert array reference is undefined"
#         unless defined $lines_to_insert_aref;

#     confess "insert position is undefined"
#         unless defined $insert_after_index;

#     my @complete_text    = @$complete_text_aref;
#     my @lines_to_insert  = @$lines_to_insert_aref;

#     # print("insert_after_index=$insert_after_index\n");

#     confess "insert position $insert_after_index is out of bounds"
#         if $insert_after_index < 0 || $insert_after_index > $#complete_text;

#     my @lines_before = @complete_text[0 .. $insert_after_index];
#     my @lines_after  = @complete_text[$insert_after_index + 1 .. $#complete_text];

#     my @new_text = (
#         @lines_before,
#         @lines_to_insert,
#         @lines_after,
#     );

#     return \@new_text;
# }


=head2 sub append_block

=cut

sub append_block {

my ($self,$slurp_aref,$block_appendix_aref) = @_;

	confess "Input array reference is undefined" unless defined $slurp_aref;
	confess "block_appendix array reference is undefined" unless defined $block_appendix_aref;

	my @slurp             = @$slurp_aref;
	my @block_appendix    = @$block_appendix_aref;
	my $length_of_block   = scalar @block_appendix;
	my $length_of_slurp   = scalar @slurp;

	push @slurp, @block_appendix;

	my $new_length_of_slurp = scalar @slurp;
	# print("length of block is $new_length_of_slurp\n");

	return \@slurp;
}

=head2 sub find_index_for_lines2replace

    This subroutine searches for the indices of the lines in a text block
     that need to be replaced with other values

=cut 

sub find_index_for_lines2replace {

    my ($self,$slurp_aref, $line2find) = @_;

    confess "Input array reference is undefined"
        unless defined $slurp_aref;
    # search terms
    confess "Line to find is undefined"
        unless defined $line2find;

    my @slurp           = @$slurp_aref;
    my $length_of_slurp = scalar(@slurp);

    # OUTPUT INDICES
    my $line2find_index;

    for (my $i = 0 ; $i < $length_of_slurp ; $i++) {

        confess "slurp is undefined\n" unless defined $slurp[$i];

        my $string = $slurp[$i];
        # print("line is is $string\n");

        if ($string =~ /$line2find/) {

            $line2find_index = $i;
            # print("line2find:$line2find_index\n");
            # print("$slurp[$i]\n");

            # error checking
            unless (defined $line2find_index) {
                print("line2find: $line2find\n");
                confess "Could not find line";
            }
        }
    }

    return ($line2find_index);

}


=head2 sub insert_block_after_position

    This subroutine inserts a block of lines into an array of lines after a specified position
    The position is defined as the index after which the lines will be inserted
    The lines to insert are defined as an array reference

=cut

sub insert_block_after_position {

    my ($self,$complete_text_aref, $lines_to_insert_aref, $insert_after_index) = @_;

    confess "complete text array reference is undefined"
        unless defined $complete_text_aref;

    confess "lines-to-insert array reference is undefined"
        unless defined $lines_to_insert_aref;

    confess "insert position is undefined"
        unless defined $insert_after_index;

    my @complete_text    = @$complete_text_aref;
    my @lines_to_insert  = @$lines_to_insert_aref;

    # print("insert_after_index=$insert_after_index\n");

    confess "insert position $insert_after_index is out of bounds"
        if $insert_after_index < 0 || $insert_after_index > $#complete_text;

    my @lines_before = @complete_text[0 .. $insert_after_index];
    my @lines_after  = @complete_text[$insert_after_index + 1 .. $#complete_text];

    my @new_text = (
        @lines_before,
        @lines_to_insert,
        @lines_after,
    );

    return \@new_text;
}


=head2 sub replace_block

=cut

sub replace_block {

my ($self,$slurp_aref, $from_idx, $to_idx,$block_replacement_aref) = @_;

	confess "Input array reference is undefined" unless defined $slurp_aref;
	confess "line2replace_idx is undefined" unless defined $from_idx;
	confess "text_replacement is undefined" unless defined $to_idx;
	confess "text_replacement is undefined" unless defined $block_replacement_aref;

	my @slurp             = @$slurp_aref;
	my @block_replacement = @$block_replacement_aref;

    @slurp[$from_idx .. $to_idx] = @block_replacement;

	return \@slurp;
}

=head2 sub replace_line

=cut

sub replace_line {

my ($self,$slurp_aref, $line2replace_idx, $text_replacement) = @_;

	my @slurp = @$slurp_aref;
	confess "Input array reference is undefined" unless defined $slurp_aref;
	confess "line2replace_idx is undefined" unless defined $line2replace_idx;
	confess "text_replacement is undefined" unless defined $text_replacement;

    $slurp[$line2replace_idx] = $text_replacement;

	return \@slurp;
}


1;