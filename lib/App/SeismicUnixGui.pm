package SeismicUnixGui;

use strict;
use warnings;

=head1 NAME

App::SeismicUnixGui - A graphical user interface for Seismic Unix

=head1 DESCRIPTION

SeismicUnixGui (alpha) is a graphical user interface (GUI) 
to select parameters for Seismic Unix (SU) modules. 
Seismic Unix (Stockwell, 1999) is a widely distributed 
free software package for processing seismic reflection 
and signal processing. 
Perl/Tk is a mature, well-documented and free, 
object-oriented graphical user interface for Perl. 


=head1 INTERACTIVE SHELL

The PDL package includes an interactive shell. You can learn about it,
run C<perldoc perldl>, or run the shell C<perldl> or C<pdl2> and type
C<help>.

=head1 LOOKING FOR A FUNCTION?

If you want to search for a function name, you should use the PDL
shell along with the "help" or "apropos" command (to do a fuzzy search).
For example:

 pdl> apropos xval
 xlinvals        X axis values between endpoints (see xvals).
 xlogvals        X axis values logarithmicly spaced...
 xvals           Fills an ndarray with X index values...
 yvals           Fills an ndarray with Y index values. See the CAVEAT for xvals.
 zvals           Fills an ndarray with Z index values. See the CAVEAT for xvals.

To learn more about the PDL shell, see L<perldl> or L<pdl2>.

=head1 MODULE DOCUMENTATION

Hover with the mose over the prgram name either in the main menu
or in the four,colored work areas (grey,pink,green,blue). Then,
click with MB3. A click of the third mouse button provokes
a display of the traditional Seismic Unix documentation.


=over 5

=item L<PDL::FAQ>

Frequently asked questions about PDL. This page covers a lot of
questions that do not fall neatly into any of the documentation
categories.

=item L<PDL::Tutorials>

A guide to PDL's tutorial-style documentation. With topics from beginner
to advanced, these pages teach you various aspects of PDL step by step.

=item L<PDL::Modules>

A guide to PDL's module reference. Modules are organized by level
(foundation to advanced) and by category (graphics, numerical methods,
etc) to help you find the module you need as quickly as possible.

=item L<PDL::Course>

This page compiles PDL's tutorial and reference pages into a comprehensive
course that takes you from a complete beginner level to expert.

=item L<PDL::Index>

List of all available documentation, sorted alphabetically. If you
cannot find what you are looking for, try here.

=back

=head1 DATA TYPES

PDL comes with support for most native numeric data types available in C.
2.027 added support for C99 complex numbers.  See
L<PDL::Core>, L<PDL::Ops> and L<PDL::Math> for details on usage and
behaviour.

=head1 MODULES

PDL includes about a dozen perl modules that form the core of the
language, plus additional modules that add further functionality.
The perl module "PDL" loads all of the core modules automatically,
making their functions available in the current perl namespace.
Some notes:

=over 5

=item Modules loaded by default

See the SYNOPSIS section at the end of this document for a list of
modules loaded by default.

=item L<PDL::Lite> and L<PDL::LiteF>

These are lighter-weight alternatives to the standard PDL module.
Consider using these modules if startup time becomes an issue.

=item Exports

C<use PDL;> exports a large number of routines into the calling
namespace.  If you want to avoid namespace pollution, you must instead 
C<use PDL::Lite>, and include any additional modules explicitly.

=item L<PDL::NiceSlice>

Note that the L<PDL::NiceSlice> syntax is NOT automatically
loaded by C<use PDL;>.  If you want to use the extended slicing syntax in 
a standalone script, you must also say C<use PDL::NiceSlice;>.

=item L<PDL::Math>

The L<PDL::Math> module has been added to the list of modules
for versions later than 2.3.1. Note that PDL::Math is still
I<not> included in the L<PDL::Lite> and L<PDL::LiteF>
start-up modules.

=back

=head1 SYNOPSIS

 use PDL; # Is equivalent to the following:

   use PDL::Core;
   use PDL::Ops;
   use PDL::Primitive;
   use PDL::Ufunc;
   use PDL::Basic;
   use PDL::Slices;
   use PDL::Bad;
   use PDL::MatrixOps;
   use PDL::Math;
   use PDL::IO::Misc;
   use PDL::IO::FITS;
   use PDL::IO::Pic;
   use PDL::IO::Storable;
   use PDL::Lvalue;

=cut

# set the version:
our $VERSION = '0.70.60';

# Main loader of standard PDL package

1;
