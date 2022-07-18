bsr : bsr.for readpar.o
	gfortran bsr.for readpar.o -o bsr
	mv bsr /home/evera/bin

crm : crm.for gtocake.o readvmod3.o denfvp.o thi.o wrimod2.o readpar.o
	gfortran crm.for gtocake.o readvmod3.o denfvp.o thi.o wrimod2.o readpar.o -o /home/evera/bin/crm

vivrms : vivrms.for messa.o readpar.o
	gfortran vivrms.for messa.o readpar.o -o vivrms

rtr2dcir : rtr2dcir.for readpar.o runge.o voglcurve.o
	gfortran rtr2dcir.for readpar.o runge.o voglcurve.o -lvogl -lX11 -o raytr2d.e

rtr2drec : rtr2drec.for readpar.o runge.o voglcurve.o
	gfortran rtr2drec.for readpar.o runge.o voglcurve.o -lvogl -lX11 -o raytr2d2.e

raytrp : raytrp.for readpar.o runge.o
	gfortran raytrp.for readpar.o runge.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o raytrp

ftomo2d : ftomo2d.for readpar.o runge.o
	gfortran ftomo2d.for readpar.o runge.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o ftomo2d

igrf10 : igrf10.for
	gfortran igrf10.for -o /home/evera/bin/igrf10

itomo : itomo.for stray.o readpar.o
	gfortran itomo.for stray.o readpar.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o itomo

itomolsqr.e : itomolsqr.for stray.o readpar.o lsqral.o
	gfortran itomolsqr.for stray.o readpar.o lsqral.o -lvogl -lX11 -o itomolsqr.e

tprt2d.e : tprt2d.for readpar.o runge.o voglcurve.o
	gfortran tprt2d.for readpar.o runge.o voglcurve.o -lvogl -lX11 -o tprt2d.e

edaplot : edaplot.for readpar.o
	gfortran edaplot.for readpar.o -lvogl -lX11 -o edaplot
	mv edaplot /usr/users/evera/bin

edaplotmu : edaplotmu.for readpar.o
	gfortran edaplotmu.for readpar.o -lvogl -lX11 -o edaplotmu
	mv edaplotmu /usr/users/evera/bin

prueba.e : prueba.for stray.o readpar.o
	gfortran prueba.for stray.o readpar.o -o prueba.e
	#gfortran prueba.for stray.o readpar.o -o prueba.e

testfft.e : testfft.for readpar.o fft.o
	gfortran testfft.for readpar.o fft.o -o testfft.e

fxttpm	: fxttpm.for fread2.o readpar.o sortxy.o xttau2.o simq.o xypl.o linreg.o tsumin.o grdinv.o e.o regular2.o wrimod.o invplo.o strip.o txgrd.o
	gfortran fxttpm.for fread2.o readpar.o sortxy.o xttau2.o simq.o xypl.o linreg.o tsumin.o grdinv.o e.o regular2.o wrimod.o invplo.o strip.o txgrd.o  -L/usr/local/pgplot_gfortran -lpgplot -L/usr/X11/lib -lX11 -o /usr/local/bin/fxttpm

ifxttpm	: ifxttpm.for fread2.o readpar.o sortxy.o xttau2.o simq.o xypl.o linreg.o tsumin.o grdinv.o e.o regular2.o wrimod.o invplo.o strip.o txgrd.o
	gfortran ifxttpm.for fread2.o readpar.o sortxy.o xttau2.o simq.o xypl.o linreg.o tsumin.o grdinv.o e.o regular2.o wrimod.o invplo.o strip.o txgrd.o  -L/usr/local/pgplot_gfortran -lpgplot -L/usr/X11/lib -lX11 -o /usr/local/bin/fxttpm

mmodpg_XT : mmodpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o
	gfortran  mmodpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o -L/usr/local/pgplot -lpgplot  -L/usr/lib64 -lX11 -L/opt/intel/lib/intel64 -lifcore -lifcoremt -lifcoremt_pic -limf -lintlc -lsvml -o /usr/local/bin/mmodpg_XT

mmodpg1.1 : mmodpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o
	gfortran  mmodpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o -L/usr/local/pgplot -lpgplot  -L/usr/lib64 -lX11 -o /usr/local/bin/mmodpg1.1
#	gfortran mmodpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o /usr/local/pub/bin/mmodpg

mmodpg2 : mmodpg2.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o pgpolyev.o
	gfortran mmodpg2.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o pgpolyev.o -L/usr/local/pgplot -lpgplot -L/usr/lib64 -lX11 -o /usr/local/bin/mmodpg2


#gfortran mmodpg2.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o pgpolyev.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o /usr/local/pub/bin/mmodpg2

mmodhpg : mmodhpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr3.o txgrd.o pgzoom.o
	gfortran mmodhpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr3.o txgrd.o pgzoom.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o mmodhpg

mdifpg : mdifpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o
	gfortran mdifpg.for messa.o readpar.o readmmod.o denfvp.o thi.o wrimod2.o txpr.o txgrd.o pgzoom.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o /home/evera/bin/mdifpg

nincsyn : nincsyn.for readpar.o normab.o bpass.o fft.o conj2.o readvmod3.o denfvp.o thi.o wrimod2.o sphdiv.o getfname.o
	gfortran nincsyn.for readpar.o normab.o bpass.o fft.o conj2.o readvmod3.o denfvp.o thi.o wrimod2.o sphdiv.o getfname.o -o nincsyn

mcssynac : mcssynac.for readpar.o readvmod3.o denfvp.o thi.o wrimod2.o getfname.o bpass.o taupsis.o xtsis.o conj2.o fft.o
	gfortran mcssynac.for readpar.o readvmod3.o denfvp.o thi.o wrimod2.o getfname.o bpass.o taupsis.o xtsis.o conj2.o fft.o -o mcssynac

mcssyn2 : mcssyn2.for readpar.o bpass.o taupsis.o xtsis.o conj2.o fft.o
	gfortran mcssyn2.for readpar.o bpass.o taupsis.o xtsis.o conj2.o fft.o -o /home/evera/bin/mcssyn2

raydrawpg : raydrawpg.for messa.o readpar.o readvmod2.o thi.o wrimod2.o xzabcd.o comlay.o
	gfortran raydrawpg.for messa.o readpar.o readvmod2.o thi.o wrimod2.o xzabcd.o comlay.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o /home/evera/bin/raydrawpg

taxscpg : taxscpg.for messa.o readpar.o readvmod3.o denfvp.o thi.o wrimod2.o star2nw.o txgrd3.o starnw.o rtcoef.o versl.o coeff.o
	gfortran taxscpg.for messa.o readpar.o readvmod3.o denfvp.o thi.o wrimod2.o star2nw.o txgrd3.o starnw.o rtcoef.o versl.o coeff.o -L/usr/local/pub/bin/pgplot/ -lpgplot -L/usr/X11R6/lib -lX11 -o /home/evera/bin/taxscpg

pgtest1 : pgtest1.for
	gfortran pgtest1.for -L/usr/local/pgplot -lpgplot -L/usr/X11/lib -lX11 -o /usr/local/bin/pgtest1

alumysa : alumysa.for readpar.o voglcurve.o
	gfortran alumysa.for readpar.o voglcurve.o -lvogl -lX11 -o alumysa
	mv alumysa /usr/users/evera/bin

bandpa.o : bandpa.for
	gfortran -c bandpa.for

bpass.o : bpass.for
	gfortran -c bpass.for

coeff.o : coeff.for
	gfortran -c coeff.for

comlay.o : comlay.for
	gfortran -c comlay.for

conj2.o : conj2.for
	gfortran -c conj2.for

denfvp.o : denfvp.for
	gfortran -c denfvp.for

e.o : e.for
	gfortran -c e.for

fft.o : fft.for
	gfortran -c fft.for

fread2.o : fread2.for
	gfortran -c fread2.for

getfname.o : getfname.for
	gfortran -c getfname.for

grdinv.o : grdinv.for
	gfortran -c grdinv.for

gtocake.o : gtocake.for
	gfortran -c gtocake.for

invplo.o : invplo.for
	gfortran -c invplo.for

linreg.o : linreg.for
	gfortran -c linreg.for

lsqral.o : lsqral.for
	gfortran -c lsqral.for

messa.o : messa.for
	gfortran -c messa.for

normab.o : normab.for
	gfortran -c normab.for

normab2.o : normab2.for
	gfortran -c normab2.for

pgpolyev.o : pgpolyev.for
	gfortran -c pgpolyev.for

pgzoom.o : pgzoom.for
	gfortran -c pgzoom.for

readpar.o : readpar.for
	gfortran -c readpar.for

readvmod2.o : readvmod2.for
	gfortran -c readvmod2.for

readvmod3.o : readvmod3.for
	gfortran -c readvmod3.for

readmmod.o : readmmod.for
	gfortran -c readmmod.for

regular2.o : regular2.for
	gfortran -c regular2.for

rtcoef.o : rtcoef.for
	gfortran -c rtcoef.for

runge.o : runge.for
	gfortran -c runge.for

simq.o : simq.for
	gfortran -c simq.for

sortxy.o : sortxy.for
	gfortran -c sortxy.for

sphdiv.o : sphdiv.for
	gfortran -c sphdiv.for

srfile.o : srfile.for
	gfortran -c srfile.for

starnw.o : starnw.for
	gfortran -c starnw.for

star2nw.o : star2nw.for
	gfortran -c star2nw.for

stray.o : stray.for
	gfortran -c stray.for

strip.o : strip.for
	gfortran -c strip.for

thi.o : thi.for
	gfortran -c thi.for

taupsis.o : taupsis.for
	gfortran -c taupsis.for

tsumin.o : tsumin.for
	gfortran -c tsumin.for

txgrd.o : txgrd.for
	gfortran -c txgrd.for

txgrd3.o : txgrd3.for
	gfortran -c txgrd3.for

txpr.o : txpr.for
	gfortran -c txpr.for

txpr3.o : txpr3.for
	gfortran -c txpr3.for

versl.o : versl.for
	gfortran -c versl.for

wrimod.o : wrimod.for
	gfortran -c wrimod.for

wrimod2.o : wrimod2.for
	gfortran -c wrimod2.for

xttau2.o : xttau2.for
	gfortran -c xttau2.for

xtsis.o : xtsis.for
	gfortran -c xtsis.for

xypl.o : xypl.for
	gfortran -c xypl.for
		
xzabcd.o : xzabcd.for
	gfortran -c xzabcd.for
