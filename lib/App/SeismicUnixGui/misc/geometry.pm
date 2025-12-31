package App::SeismicUnixGui::misc::geometry;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PERL PROGRAM NAME: geometry.pm 
 AUTHOR: 	Juan Lorenzo
 DATE: 		

=cut

=head2 USE

=head3 NOTES

Contains functions to do math 
with text files 
that describe seismic experiment geometries

=head4 Examples

=head3 

=head2 CHANGES and their DATES

V 1. Nov 30  2007
V 1.1 Dec 24 2025
    
=cut  

use Moose;
our $VERSION = '0.1.1';
# use PDL;
# use PDL::NiceSlice;   # optional, but makes slicing readable

=head 2 sub offset

 Estimate offsets between shotpoints and geophones
 within a shot gather,
 INPUT:
  references to arrays with X,Y,Z coordinates of shotpoints and geophones
OUTPUT:
  reference to 2D array of offsets
  The first index is the shotpoint number
  The second index is the geophone number

  SPECIAL NOTE: reverse sign to follow convention: negative offset if geophone is left of shotpoint

=cut

sub offset {
    my (
        $self, $ref_X_SP,   $ref_Y_SP,   $ref_Z_SP,   $num_SP,
        $ref_X_GEOP, $ref_Y_GEOP, $ref_Z_GEOP, $num_GEOP
    ) = @_;

    my @offset;
    my ($dx, $dy, $dz, $distance, $sign);

    for ( my $sp = 0 ; $sp < $num_SP ; $sp++ ) {

        for ( my $geo = 0 ; $geo < $num_GEOP ; $geo++ ) {

          $dx = $$ref_X_SP[$sp] - $$ref_X_GEOP[$geo] ;
          $dy = $$ref_Y_SP[$sp] - $$ref_Y_GEOP[$geo] ;
          $dz = $$ref_Z_SP[$sp] - $$ref_Z_GEOP[$geo] ;

          $distance = sqrt( $dx * $dx + $dy * $dy + $dz * $dz);
    
          $sign = _signed_offset_x($$ref_X_SP[$sp],$$ref_X_GEOP[$geo]); 

          $offset[$sp][$geo] =  $sign * $distance;
        }

    }
    return ( \@offset);
}


=head2 sub _signed_offset_x

 Determine the sign of the offset based on relative X positions
 of shotpoint and geophone
 INPUT:
  X coordinate of shotpoint
  X coordinate of geophone
  OUTPUT:
   +1 if geophone is to the right of shotpoint
   -1 if geophone is to the left of shotpoint
    0 if they are at the same X position
=cut

sub _signed_offset_x {
    my ($x_sp,$x_geophone) = @_;

    my $xc = 0;  # default cross-over at x=0
    my $dx = $x_geophone - $x_sp;
    my $sgn = ($x_geophone > $x_sp) ? 1 : ($x_geophone < $x_sp) ? -1 : 0;   # right/left of cross-over

    return ($sgn);
}



# sub offset_pdl {
#     my (
#         $ref_X_SP,   $ref_Y_SP,   $ref_Z_SP,   $num_SP,   $ref_SP,
#         $ref_X_GEOP, $ref_Y_GEOP, $ref_Z_GEOP, $num_GEOP, $ref_GEOP
#     ) = @_;

#     # 1) Convert Perl arrays -> PDL vectors
#     my $xsp = pdl($ref_X_SP);   # (num_SP)
#     my $ysp = pdl($ref_Y_SP);
#     my $zsp = pdl($ref_Z_SP);

#     my $xg  = pdl($ref_X_GEOP); # (num_GEOP)
#     my $yg  = pdl($ref_Y_GEOP);
#     my $zg  = pdl($ref_Z_GEOP);

#     # 2) Sanity checks (optional but helps avoid silent shape issues)
#     die "num_SP mismatch"   unless $xsp->nelem == $num_SP && $ysp->nelem == $num_SP && $zsp->nelem == $num_SP;
#     die "num_GEOP mismatch" unless $xg->nelem  == $num_GEOP && $yg->nelem  == $num_GEOP && $zg->nelem  == $num_GEOP;

#     # 3) Broadcast to 2D:
#     #    SP vectors become (num_SP, 1), GEOP vectors become (1, num_GEOP)
#     my $dx = $xsp->dummy(1,1) - $xg->dummy(0,1);  # (num_SP, num_GEOP)
#     my $dy = $ysp->dummy(1,1) - $yg->dummy(0,1);
#     my $dz = $zsp->dummy(1,1) - $zg->dummy(0,1);

#     my $dist = sqrt($dx*$dx + $dy*$dy + $dz*$dz); # (num_SP, num_GEOP)

#     # 4) If you still want debug printing similar to your original:
#     #    (This is the slow part; keep it optional.)
#     my $do_print = 0;
#     if ($do_print) {
#         for my $sp (0 .. $num_SP-1) {
#             for my $geo (0 .. $num_GEOP-1) {
#                 printf "\n X of SP [%d] is %g \n", $sp, $xsp->at($sp);
#                 printf "\n X of GEOPHONE %d is %g \n", $geo, $xg->at($geo);
#                 printf "\n SOURCE-to-GEOPHONE offset is %g \n", $dist->at($sp,$geo);
#             }
#         }
#     }

#     # 5) Return as Perl array-of-arrays like your original code
#     #    (PDL is native; AoA is for compatibility)
#     my @dist_aoa;
#     for my $sp (0 .. $num_SP-1) {
#         my @row = list( $dist($sp, :) );   # NiceSlice: row extraction
#         $dist_aoa[$sp] = \@row;
#     }

#     return \@dist_aoa;
# }


=head2 sub offset_single

 Estimate offsets between shotpoints and geophones
 within a shot gather,
 INPUT:
  references to arrays with X,Y,Z coordinates of shotpoints and geophones
OUTPUT: 
  reference to 1D array of offsets
  for a single shotpoint number 

=cut

sub offset_single {

    my ($ref_X_SP)   = shift @_;
    my ($ref_Y_SP)   = shift @_;
    my ($ref_Z_SP)   = shift @_;
    my ($ref_X_GEOP) = shift @_;
    my ($ref_Y_GEOP) = shift @_;
    my ($ref_Z_GEOP) = shift @_;
    my ($num_rows)   = shift @_;

    # for each shotpoint estimate geophone-toshotpoint offsets WITHIN a SP gather
    print("Number of rows is $num_rows\n");

    my @dist;

    #		print("\n Z of GEOPHONE [1] is $$ref_Z_GEOP[1] \n");
    #		print("\n Z of SP [1] is $$ref_Z_SP[1] \n");

    #		print("\n Z of GEOPHONE [2] is $$ref_Z_GEOP[2] \n");
    #		print("\n Z of SP [2] is $$ref_Z_SP[2] \n");
    for ( my $geo = 0 ; $geo <$num_rows ; $geo++ ) {

        #		print("\n Z of GEOPHONE [$geo] is $$ref_Z_GEOP[$geo] \n");
        #		print("\n Z of SP [$geo] is $$ref_Z_SP[$geo] \n");

        $dist[$geo] =
          sqrt( ( $$ref_X_SP[$geo] - $$ref_X_GEOP[$geo] ) *
              ( $$ref_X_SP[$geo] - $$ref_X_GEOP[$geo] ) +
              ( $$ref_Y_SP[$geo] - $$ref_Y_GEOP[$geo] ) *
              ( $$ref_Y_SP[$geo] - $$ref_Y_GEOP[$geo] ) +
              ( $$ref_Z_SP[$geo] - $$ref_Z_GEOP[$geo] ) *
              ( $$ref_Z_SP[$geo] - $$ref_Z_GEOP[$geo] ) );

        #print("\n X of SP [$geo] is $$ref_X_SP[$geo] \n");
        #		print("\n X of GEOPHONE [$geo] is $$ref_X_GEOP[$geo] \n");
        #print("\n SOURCE-to-GEOPHONE offset is $dist[$geo]\n");
        #print ("Number of rows is $geo\n");
    }

    return ( \@dist );
}

1;
