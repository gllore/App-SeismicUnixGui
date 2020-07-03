=head1 loma blanca 

  IRIS 2018 survey May 30 2018 
  on S bank of Rio Salado
  along same line as pseudo-walkaway taken on 032618
  shoot-through

=head2 Acquisition paramters
 
Date                  053018 
SI 			1000 S/s
delrt                   -11 ms
rec. length 		2 s
num tracr               64
Live channels           1-64
Channel 1               closest to recorder-- toward SE
Channel 64              farthest from recorder-- toward NW
geophones: Geospace	28 Hz L-4 3 component
geophone spacing: 	1 m 
line orientation: 	NW-SE later shots more toward NW
Number of Geophones	60
Shotpoint Spacing 	1 m
GPS is available (etrex garmin +/- 10 m)

			 (sx-m)	   NOMINAL offset-m        ACTUAL (m)
Raw SP 1		0       	1-60               0.5 - 59.5
Raw SP 2		1  		0-59		  -0.5 - 58.5	
Raw SP 3		2		-1-58		  -1.5 - 57.5	
Raw SP 4		3		-2-57             -2.5 - 56.5
Raw SP 60		59		-58-1	          -58.5 - 0.5
Striker plate 	I-beam
Hammer 		10 lb sledge 
No. blows             3 per side

  Noise sources:        5 - 10 mph from SE 
  I-25 			to  E 

=cut

=head2 Processing Steps, May 30 2018
=cut


=head2 STEP 1. Convert Seg2 to Seismic Unix format
Seg2su:

Convert dat to su files
1 to 120.dat

=cut 

=head2 STEP 2. Concatenate files
Sucat:

cat all files 

1_clean.su to 120_clean.su > 1_120_clean.su

=head2 Window the shotpoint gathers
Suwind.pl

0-1 secs and tracr 1-60

i/p 1_120_clean.su
o/p All.su


=head2  STEP 3. Negative stack
i/p All.su
o/p L28Hz_Ibeam


Sudiff.pl

Subract 'from-NE_shotgathers' from 'from-SW-gathers'


=head2   STEP 4. Create Header files 
Suclean_geom.pl:

=over 3

=item 

B<i/p L28Hz_Ibeam>

=item 

C<o/p L28Hz_Ibeam_geom>

A. Modify the geometry headers for shoot-through survey
by wiping certain headers and populating new ones

=cut

=head2 STEP 5. Modify Header files
SuGeom2.pl

B. add gx, ep and sx to headers

i/p L28Hz_Ibeam_geom
o/p L28Hz_Ibeam_geom_geom

Visually verify new header parameters using SuPlotHeader.pl
Visually verify new header parameters using suxedit 

=cut


=head2  STEP 6. Modify Header files--offsets
Make_offset

Add offsets to headers

i/p L28Hz_Ibeam_geom
o/p L28Hz_Ibeam_geom_geom_geom

Graphically verify new header parameters using SuPlotHeader.pl
Numerically verify new header parameters using suxedit 

Convention: Positive offets are when geophones lie N of shot
 			Negative offsets are when shot lies N geophone


=cut


=head2  STEP 7. Modify Header files--Make CMP's
Make_CMP.pl

Put cdp value in the header

i/p L28Hz_Ibeam_geom_geom_geom
o/p All_cmp(.su)

=cut


=head2 Dip filter
Sudipfilt2

N/A  for separation  of reflections from
surface waves


=cut

=head2  Mute surface waves and refracted waves

iBM (Interactive Bottom Mute) SP 1- 49

bottom_sumute.pl
Using bottom_mute_list

No reflections seen. Everything seems to be a refraction


=head2 Semblance Analysis
iVA:

Interactive velocity anaylsis


=cuto


=head2 concatentate
    par files into one single velocity,time file for the nmo
    suCatpar.pl
=cut


=head2 Normal Moveout and Stacking

 $sunmo     	-> vnmo('500,600,700,800');
 $sunmo     	-> tnmo('0,.05,.1,.15');


=cut


