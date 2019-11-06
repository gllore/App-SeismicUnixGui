 package utmconv;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  UTMCONV - CONVert longitude and latitude to UTM, and vice versa       
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 UTMCONV - CONVert longitude and latitude to UTM, and vice versa       

 utmconv <stdin >stdout [optional parameters]                          

 Optional parameters:                                                  
    idx=23          reference ellipsoid index (default is WGS 1984)    
    format=%.3f     output number format (printf style for one float)  
    a=(from idx)    user-specified semimajor axis of ellipsoid         
    f=(from idx)    user-specified flattening of ellipsoid             
    letter=0        =1: use UTM letter designator for latitude/Northing
    invert=0        =0: convert latitude and longitude to UTM          
                    =1: convert UTM to latitude and longitude          
    verbose=0       =1: echo parameters and number of converted coords 

    lon0=           central meridian for TM projection in degrees      
                    (default uses the 60 standard UTM longitude zones) 
    xoff=500000     false Easting (default: UTM)                       
    ysoff=10000000  false Northing, southern hemisphere (default: UTM) 
    ynoff=0         false Northing, northern hemisphere (default: UTM) 

 Notes:                                                                
    Universal Transverse Mercator (UTM) coordinates are defined between
    latitudes 80S (-80) and 84N (84). Longitude values must be between 
    -180 degrees (west) and 179.999... degrees (east).                 

    Input and output is in ASCII format. For a conversion from lon/lat 
    to UTM (invert=0), input is a two-column table of longitude and    
    latitude in decimal degrees. Output is a three-column table of     
    UTM Easting, UTM Northing, and UTM zone. The zone is given either  
    by the zone number only (default, negative on southern hemisphere) 
    or by the positive zone number plus a letter designator (letter=1).

 Example:                                                              
    Convert 40.822N, 14.125E to UTM with zone number and letter,       
    output values rounded to nearest integer:                          
        echo 14.125 40.822 | utmconv letter=1 format=%.0f              
    The output is "426213 4519366 33T" (Easting, Northing, UTM zone).

 Reference ellipsoids:                                                 
    An ellipsoid may be specified by its semimajor axis a and its      
    flattening f, or one of the following ellipsoids may be selected   
    by its index idx (semimajor axes in meters):                       
     0  Sphere with radius of 6371000 m                                
     1  Airy 1830                                                      
     2  Australian National 1965                                       
     3  Bessel 1841 (Ethiopia, Indonesia, Japan, Korea)                
     4  Bessel 1841 (Namibia)                                          
     5  Clarke 1866                                                    
     6  Clarke 1880                                                    
     7  Everest (Brunei, E. Malaysia)                                  
     8  Everest (India 1830)                                           
     9  Everest (India 1956)                                           
    10  Everest (Pakistan)                                             
    11  Everest (W. Malaysia, Singapore 1948)                          
    12  Everest (W. Malaysia 1969)                                     
    13  Geodetic Reference System 1980 (GRS 1980)                      
    14  Helmert 1906                                                   
    15  Hough 1960                                                     
    16  Indonesian 1974                                                
    17  International 1924 / Hayford 1909                              
    18  Krassovsky 1940                                                
    19  Modified Airy                                                  
    20  Modified Fischer 1960                                          
    21  South American 1969                                            
    22  World Geodetic System 1972 (WGS 1972)                          
    23  World Geodetic System 1984 (WGS 1984) / NAD 1983               


 UTM grid:
 The Universal Transverse Mercator (UTM) system is a world wide
 coordinate system defined between 80S and 84N. It divides the
 Earth into 60 six-degree zones. Zone number 1 has its central
 meridian at 177W (-177 degrees), and numbers increase eastward.

 Within each zone, an Easting of 500,000 m is assigned to its 
 central meridian to avoid negative coordinates. On the northern
 hemisphere, Northings start at 0 m at the equator and increase 
 northward. On the southern hemisphere a false Northing of 
 10,000,000 m is applied, i.e. Northings start at 10,000,000 m at 
 the equator and decrease southward. Letters are sometimes used
 to identify different zones of latitude. The letters C-M 
 indicate zones on the southern and the letters N-X zones on 
 the northern hemisphere.

 Author: 
    Nils Maercklin, RISSC, University of Naples, Italy, March 2007

 References:
 NIMA (2000). Department of Defense World Geodetic System 1984 - 
    its definition and relationships with local geodetic systems.
    Technical Report TR8350.2. National Imagery and Mapping Agency, 
    Geodesy and Geophysics Department, St. Louis, MO. 3rd edition.
 J. P. Snyder (1987). Map Projections - A Working Manual. 
    U.S. Geological Survey Professional Paper 1395, 383 pages.
    U.S. Government Printing Office.

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $utmconv		= {
		_a					=> '',
		_f					=> '',
		_format					=> '',
		_idx					=> '',
		_invert					=> '',
		_letter					=> '',
		_lon0					=> '',
		_verbose					=> '',
		_xoff					=> '',
		_ynoff					=> '',
		_ysoff					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$utmconv->{_Step}     = 'utmconv'.$utmconv->{_Step};
	return ( $utmconv->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$utmconv->{_note}     = 'utmconv'.$utmconv->{_note};
	return ( $utmconv->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$utmconv->{_a}			= '';
		$utmconv->{_f}			= '';
		$utmconv->{_format}			= '';
		$utmconv->{_idx}			= '';
		$utmconv->{_invert}			= '';
		$utmconv->{_letter}			= '';
		$utmconv->{_lon0}			= '';
		$utmconv->{_verbose}			= '';
		$utmconv->{_xoff}			= '';
		$utmconv->{_ynoff}			= '';
		$utmconv->{_ysoff}			= '';
		$utmconv->{_Step}			= '';
		$utmconv->{_note}			= '';
 }


=head2 sub a 


=cut

 sub a {

	my ( $self,$a )		= @_;
	if ( $a ne $empty_string ) {

		$utmconv->{_a}		= $a;
		$utmconv->{_note}		= $utmconv->{_note}.' a='.$utmconv->{_a};
		$utmconv->{_Step}		= $utmconv->{_Step}.' a='.$utmconv->{_a};

	} else { 
		print("utmconv, a, missing a,\n");
	 }
 }


=head2 sub f 


=cut

 sub f {

	my ( $self,$f )		= @_;
	if ( $f ne $empty_string ) {

		$utmconv->{_f}		= $f;
		$utmconv->{_note}		= $utmconv->{_note}.' f='.$utmconv->{_f};
		$utmconv->{_Step}		= $utmconv->{_Step}.' f='.$utmconv->{_f};

	} else { 
		print("utmconv, f, missing f,\n");
	 }
 }


=head2 sub format 


=cut

 sub format {

	my ( $self,$format )		= @_;
	if ( $format ne $empty_string ) {

		$utmconv->{_format}		= $format;
		$utmconv->{_note}		= $utmconv->{_note}.' format='.$utmconv->{_format};
		$utmconv->{_Step}		= $utmconv->{_Step}.' format='.$utmconv->{_format};

	} else { 
		print("utmconv, format, missing format,\n");
	 }
 }


=head2 sub idx 


=cut

 sub idx {

	my ( $self,$idx )		= @_;
	if ( $idx ne $empty_string ) {

		$utmconv->{_idx}		= $idx;
		$utmconv->{_note}		= $utmconv->{_note}.' idx='.$utmconv->{_idx};
		$utmconv->{_Step}		= $utmconv->{_Step}.' idx='.$utmconv->{_idx};

	} else { 
		print("utmconv, idx, missing idx,\n");
	 }
 }


=head2 sub invert 


=cut

 sub invert {

	my ( $self,$invert )		= @_;
	if ( $invert ne $empty_string ) {

		$utmconv->{_invert}		= $invert;
		$utmconv->{_note}		= $utmconv->{_note}.' invert='.$utmconv->{_invert};
		$utmconv->{_Step}		= $utmconv->{_Step}.' invert='.$utmconv->{_invert};

	} else { 
		print("utmconv, invert, missing invert,\n");
	 }
 }


=head2 sub letter 


=cut

 sub letter {

	my ( $self,$letter )		= @_;
	if ( $letter ne $empty_string ) {

		$utmconv->{_letter}		= $letter;
		$utmconv->{_note}		= $utmconv->{_note}.' letter='.$utmconv->{_letter};
		$utmconv->{_Step}		= $utmconv->{_Step}.' letter='.$utmconv->{_letter};

	} else { 
		print("utmconv, letter, missing letter,\n");
	 }
 }


=head2 sub lon0 


=cut

 sub lon0 {

	my ( $self,$lon0 )		= @_;
	if ( $lon0 ne $empty_string ) {

		$utmconv->{_lon0}		= $lon0;
		$utmconv->{_note}		= $utmconv->{_note}.' lon0='.$utmconv->{_lon0};
		$utmconv->{_Step}		= $utmconv->{_Step}.' lon0='.$utmconv->{_lon0};

	} else { 
		print("utmconv, lon0, missing lon0,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$utmconv->{_verbose}		= $verbose;
		$utmconv->{_note}		= $utmconv->{_note}.' verbose='.$utmconv->{_verbose};
		$utmconv->{_Step}		= $utmconv->{_Step}.' verbose='.$utmconv->{_verbose};

	} else { 
		print("utmconv, verbose, missing verbose,\n");
	 }
 }


=head2 sub xoff 


=cut

 sub xoff {

	my ( $self,$xoff )		= @_;
	if ( $xoff ne $empty_string ) {

		$utmconv->{_xoff}		= $xoff;
		$utmconv->{_note}		= $utmconv->{_note}.' xoff='.$utmconv->{_xoff};
		$utmconv->{_Step}		= $utmconv->{_Step}.' xoff='.$utmconv->{_xoff};

	} else { 
		print("utmconv, xoff, missing xoff,\n");
	 }
 }


=head2 sub ynoff 


=cut

 sub ynoff {

	my ( $self,$ynoff )		= @_;
	if ( $ynoff ne $empty_string ) {

		$utmconv->{_ynoff}		= $ynoff;
		$utmconv->{_note}		= $utmconv->{_note}.' ynoff='.$utmconv->{_ynoff};
		$utmconv->{_Step}		= $utmconv->{_Step}.' ynoff='.$utmconv->{_ynoff};

	} else { 
		print("utmconv, ynoff, missing ynoff,\n");
	 }
 }


=head2 sub ysoff 


=cut

 sub ysoff {

	my ( $self,$ysoff )		= @_;
	if ( $ysoff ne $empty_string ) {

		$utmconv->{_ysoff}		= $ysoff;
		$utmconv->{_note}		= $utmconv->{_note}.' ysoff='.$utmconv->{_ysoff};
		$utmconv->{_Step}		= $utmconv->{_Step}.' ysoff='.$utmconv->{_ysoff};

	} else { 
		print("utmconv, ysoff, missing ysoff,\n");
	 }
 }


=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 