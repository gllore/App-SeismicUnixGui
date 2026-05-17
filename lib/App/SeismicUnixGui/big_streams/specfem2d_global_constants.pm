package App::SeismicUnixGui::big_streams::specfem2d_global_constants;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PERL PROGRAM NAME: specfem2d_global_constants.pm 
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 2026

 DESCRIPTION

     Exports global variables used in specfem2d packages. 

 BASED ON:



=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 

=head2 CHANGES and their DATES

    
=cut 

use Moose;
our $VERSION = '0.0.1';
use Exporter;  # Gain export capability

=head2 declare

Global variables

=cut

our (@EXPORT_OK, @ISA); # Global variables
@ISA    = 'Exporter';  # Take advantage of Exporter's capabilities

# export all; import at will
@EXPORT_OK = qw($elastic $acoustic $anisotropic $poroelastic $tomo); 

# material types for specfem2d
our $acoustic    = 1;
our $elastic     = 1;
our $anisotropic = 2;
our $poroelastic = 3;
our $tomo        = -1;

1;
