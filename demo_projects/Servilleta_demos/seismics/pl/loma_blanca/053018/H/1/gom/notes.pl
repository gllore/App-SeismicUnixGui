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
Tool Seg2su:

Convert dat to su files
1 to 120.dat

=cut 

=head2 STEP 2. Concatenate files
Tool Sucat:

cat all files 

1.su to 120.su > 1_120.su

=head2 STEP3. clean headers
flow: Suclean_geom.pl

i/p 1_120.su

o/p 1_120_clean.su

A. Modify the geometry headers for shoot-through survey
by wiping certain headers and populating new ones

=head2 STEP4. Window the shotpoint gathers
Suwind.pl

0-1 secs for all traces
and only traces 1-60 (exclude last 4 in each gather)

i/p 1_120_clean.su
o/p All.su

view the data: view_All.pl

=head2 STEP 5. Negative stack
suop2.pl
i/p L28HzHit_fromNE.su and L28HzHit_fromSW.su 
o/p L28Hz_Ibeam.su

Subract 'from-NE_shotgathers' from 'from-SW-gathers'

view the data:view_L28Hz_Ibeam.pl 

=head2 STEP 6. Modify Header files
SuGeom2.pl
B. add gx, ep and sx to headers

i/p L28Hz_Ibeam
o/p L28Hz_Ibeam_geom2

Visually verify new header parameters using SuPlotHeader.pl
Visually verify new header parameters using suxedit 

=cut


=head2  STEP 7. Modify Header files--offsets
SuGeom3.pl

Add offsets to headers

i/p L28Hz_Ibeam_geom2
o/p L28Hz_Ibeam_geom3

Graphically verify new header parameters using view_traclVsoffset.pl
Numerically verify new header parameters using suxedit 

Convention: Positive offets are when geophones lie N of shot
 	    Negative offsets are when shot lies N geophone


=cut


=head2  STEP 8. Modify Header files--Make CMP's
make_cmp.pl

Put cdp value in the header

i/p L28Hz_Ibeam_geom3
o/p All_cmp(.su)


=cut

=head2 
plot_traclVsoffset.pl

=head2 STEp 9. Dip filter
Sudipfilt2

Useful  for separation  of reflections from
surface waves


=cut

=head2  STEP 10. Test Muting of surface waves and refracted waves

iBM (Interactive Top Bottom Mute) SP 1

Testing- not used in this flow


=head2 STEP 11. Test Semblance Analysis
iVA:

Interactive velocity anaylsis


=cut


=head2 STEP 12. Normal Moveout and Stacking and Migration


using two velocity-time points from the iVA above

 $sunmo     	-> vnmo('500,600,700,800');
 $sunmo     	-> tnmo('0,.05,.1,.15');


=cut


