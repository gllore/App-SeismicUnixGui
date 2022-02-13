package evince_doc;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: evince_doc.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		Septemeber 3 2019
		
 DESCRIPTION 
 BASED ON: gmt_soc.pm

=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3  NOTES

=head2 CHANGES and their DATES


=head2 Notes from bash
 
=cut 

use Moose;
our $VERSION = '0.0.1';

=head2

=cut

=head2 sunix_pl

 shares many similar attributes to current 
 class in that files are examined for patterns
 However, the current class uses evince_doc files
 rather than sunix perl scripts

=cut

extends 'sunix_pl';

=head2 hash of encapsulted variables


=cut

my $evince_doc = { _names => '', };

=head2 sub parse variable names

    from among selected lines

=cut

sub parameters {
	my ( $self, $hash_ref ) = @_;
	my $idx_num     	= 0;
	my $op_line_idx 	= 0;
	my $repeated        = 0;
	
	my $line_text;
	my @default_names;
	my ($parse_names);
	my $parse_names_ref = $hash_ref;

	foreach ( @{ $parse_names_ref->{_line_contents} } ) {
		
		# print("line index $idx_num comprises: @{$parse_names_ref->{_line_contents}}[$idx_num] ");
		$line_text = @{ $parse_names_ref->{_line_contents} }[$idx_num];

		#  match regex (m//) to string ($line_text)
		#  and assign/parse out (=~) to array @fields
		#  look for  '--'
		#  followed by one or more word characters (\w+)
		#  or, look for  '--'
		#  followed by one or more word characters (\w+)
		#  followed by one '-'
		# followed by  one or more word characters (\w+)
		
		my @fields = $line_text =~ m/(--\w+|--\w+-\w+)/;

		my $length = scalar @fields;

		# print ("gmt_doc length=$length\n");
		# print("gmt_doc, line_num=$idx_num fields[0]: $fields[0]\n");
		# for ( my $i = 0; $i < $length; $i++ ) {
		# 	print("line index:$idx_num, field[$i]:---->$fields[$i]<---\n");
		# }
		
		# remove suffix '--'
		for ( my $i = 0; $i < $length; $i++ ) {
			
			# print("1. line index:$i, field:***$fields[$i]***\n");
			$fields[$i] 	=~ s/--//;
			# print("2. line index:$i, field:***$fields[$i]***\n");
			
		}
		
		if ( $fields[0] ) {

			# do not allow duplicate names to pass by
			my $lines_so_far = scalar(@default_names);

			# print("gmt_doc,parameters,names read so far= $lines_so_far at index 0\n");

			# test for repeated name at another index
			# review if an identical paramter name has already been recorded
			for ( my $index = 0; $index < $lines_so_far; $index++ ) {
				my $current_index = $idx_num;
				# print("evince_doc 1. current index=$current_index\n");
				if ( $fields[0] eq $default_names[$index] ) {
					# print("evince_doc,parameters,current name: $fields[0] ");
					# print("at current index=$current_index was found previously at index=$index \n");
					$repeated = 1;
				}
			}

			# use test results
			if ($repeated) {

				# do nothing
				my $current_index = $idx_num;
				# print("evince_doc,paramters,repeated at current index=$current_index\n");
				$repeated = 0;    # initialize repeated to NO
			}
			else {
				my $current_index = $idx_num;
				# print("evince_doc,paramters,not repeated at current index=$current_index\n");
				$default_names[$op_line_idx] = $fields[0];
				# print("evince_doc, op_line_idx $op_line_idx param_name: $default_names[$op_line_idx]\n");
				$op_line_idx++;
			}
		}
		$idx_num++;
	}
	$evince_doc->{_names} = \@default_names;
	return ($evince_doc);
}

1;
