package LSeismicUnix::developer::code::tests::My_SeismicUnix; 

use Exporter;            # Gain export capabilities 
our (@ISA, @EXPORT_OK);     # Global variables 

@ISA = 'Exporter';      # Take advantage of Exporter's capabilities
@EXPORT_OK = qw($a @b);      # Export $a and @b by default

our $a = 5;                  # Assign some values our @b = (1, 2, 3); 
our @b =(1,2);

1;                       # Always return a true value 