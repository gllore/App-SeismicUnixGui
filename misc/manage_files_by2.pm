package manage_files_by2;

use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 
 Contains methods/subroutines/functions to operate on directories

 PROGRAM NAME: manage_files_by  classIVA 
 AUTHOR: Juan Lorenzo
 DATE:   V 1. March 3 2008
 V 2 May 27 2014
         
 DESCRIPTION: 
 modified from
 manage_files_by 
 to stricts requirements using Moose
 manage_files_by  class

 =head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 NOTES  

=head4 CHANGES and their DATES


=cut

=pod

 head3= sub does_file_exist
 returns a 1 if the file does exist
 and returns a 0 if the file does not

=cut

sub does_file_exist {

    my ( $does_file_exist, $ref_file ) = @_;

    $does_file_exist->{ref_file} = $$ref_file if defined($ref_file);

    # print("file name is, $$ref_file\n");

    # default situation is to have a file non-existent
    my $answer = 0;

    # -e returns 1 or ''
    # verified by JL
    # print("plain file for test is $$ref_file\n\n");
    if ( -f $does_file_exist->{ref_file} ) {

        #print  ("file existence verified\n\n") ;
        $answer = 1;
    }

    #	answer=1 if existent and =0 if non-existent
    #verified by JL
    return ($answer);
}

sub does_file_exist_sref {

    my ($ref_file) = @_;

    if ($ref_file) {

        my $file = $$ref_file;

    # print("manage_files_by2,does_file_exist_sref,file name is, $$ref_file\n");

        # default situation is to have a file non-existent
        my $answer = 0;

        # -e returns 1 or ''
        # verified by JL
        # print("file for exist test is $$ref_file\n\n");
        # actually dies it exist and is it a plain file!!
        if ( -f $file ) {

            # print  ("file existence verified\n\n") ;
            $answer = 1;
        }

        #	answer=1 if existent and =0 if non-existent
        #verified by JL
        return ($answer);
    }
    else {
        print("does_file_exist_sref, ref_file is missing\n");
    }

}

=pod sub unique_elements

	filter out only unique elements from an array

=cut 

sub unique_elements {
    my ( $self, $array_ref ) = @_;

    my $results_ref;

    if ($array_ref) {

        my @unique_progs;
        my $total_num_progs4flow = scalar @{$array_ref};
        my $false                = 0;
        my $true                 = 1;
        my $num_unique_progs     = 1;

        my $seen = $true;
        $unique_progs[0] = @{$array_ref}[0];

        # print("manage_files_by2, program in flow: @{$array_ref}[0]\n");

        for ( my $i = 1 ; $i < $total_num_progs4flow ; $i++ ) {

        # print("manage_files_by2, program in flow: @{$array_ref}[$i]\n");
        # print ("1. manage_files_by2, num_unique_progs=$num_unique_progs\n\n");
            for ( my $j = 0 ; $j < $num_unique_progs ; $j++ ) {

                if ( $unique_progs[$j] eq @{$array_ref}[$i] ) {

            # print("program index in flow=$i\n");
            # print(" 1. manage_files_by2,repeated program detected \n");
            # print("manage_files_by2, prog_ repeated: @{$array_ref}[]$i]\n\n");
                    $seen = $true;

                    # exit if-loop and increment $j
                }
                else {
      # print("program index in flow=$i\n");
      # print("manage_files_by2, prog @{array_ref}[]$i] is unique\n\n");
      # print ("2. manage_files_by2,unique_prog detected=@{$array_ref}[$i] \n");
                    $seen = $false;
                }
            }

            if ($seen) {
                $seen = $false;    #reset for next check
            }
            else {
                push @unique_progs, @{$array_ref}[$i];

         # print(" 1. manage_files_by2,unique new program found for output \n");
                $num_unique_progs++;
            }

        }    # end all programs

        # print("3. manage_files_by2, unique_progs are: @unique_progs\n");
        # print ("3. manage_files_by2, num_unique_progs=$num_unique_progs\n\n");

        $results_ref = \@unique_progs;
        return ($results_ref);

    }
    else {
        print("manage_files_by2,unique_elements, missing array\n");
        return ();

    }    # end if
}

=pod

 read in a 2-columned file
 reads cols 1 and 2 in a text file


=cut

sub read_2cols {

    my ( $variable, $ref_origin ) = @_;

    #declare locally scoped variables
    my ( $i, $line, $t, $x, $num_rows );
    my ( @TIME, @TIME_OUT, @OFFSET, @OFFSET_OUT );
    print("In this subroutine $$ref_origin\n");

    # open the file of interest
    open( FILE, $$ref_origin ) || print("Can't open. $$ref_origin \n");

    #set the counter
    $i = 1;

    # read contents of shotpoint geometry file
    while ( $line = <FILE> ) {

        #print("\n$line");
        chomp($line);
        ( $t, $x ) = split( "  ", $line );
        $TIME[$i]   = $t;
        $OFFSET[$i] = $x;

        #print("\n $TIME[$i] $OFFSET[$i]\n");
        $i = $i + 1;

    }

    close(FILE);

    $num_rows = $i - 1;

    # print out the number of lines of data for the user
    #print ("\nThis file contains $num_rows row(s) of data\n");

    #   to prevent contaminating outside variables
    @TIME_OUT   = @TIME;
    @OFFSET_OUT = @OFFSET;

    return ( \@TIME_OUT, \@OFFSET_OUT, $num_rows );
}

=pod

  write out a 2-columned file

=cut

sub write_2cols {

    # open and write to output file
    my ( $variable, $ref_X, $ref_Y, $num_rows, $ref_file_name, $ref_fmt ) = @_;

    #declare locally scoped variables
    my $j;

    # $variable is an unused hash

    #print("\nThe subroutine has is called $variable\n");
    #print("\nThe output file contains $num_rows rows\n");
    #print("\nThe output file uses the following format: $$ref_fmt\n");
    open( OUT, ">$$ref_file_name" );

    for ( $j = 1 ; $j <= $num_rows ; $j++ ) {

        #print OUT  ("$$ref_X[$j] $$ref_Y[$j]\n");
        printf OUT "$$ref_fmt\n", $$ref_X[$j], $$ref_Y[$j];

        #print("$$ref_X[$j] $$ref_Y[$j]\n");
    }

    close(OUT);

}

1;
