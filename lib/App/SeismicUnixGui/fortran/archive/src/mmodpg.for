! Calculo de curvas camino-tiempo para modelos formados por una
! combinacion de capas planas homogeneas o con gradiente de
! velocidad constante. Fuente y receptor en 1ra capa; default
! es que ambos esten en superficie.
!
       integer*4   nlmax,npmax,npamax,ntrmax,nsmax,ntr,ns
       parameter (nlmax=25,npmax=960000,npamax=4000000)
       parameter (ntrmax=1000,nsmax=32768)
       parameter (nxymax=1000)
       real*4    f(ntrmax,nsmax)
       real*4    fmin,fmax,tr(6),result(20)
       dimension IR(nlmax-1),VT(nlmax),VB(nlmax),DZ(nlmax)
       dimension VST(nlmax),VSB(nlmax),RHOT(nlmax),RHOB(nlmax)
       dimension va(2*nlmax),za(2*nlmax)
       dimension multin(nlmax)
       dimension ILA(npmax),P(npmax),X(npmax),T(npmax)
       dimension xa1(npamax),xa2(npamax),xa3(npamax),xa4(npamax)

! next line added on Aug 20 2013
      dimension xout(npmax,nlmax),tout(npmax,nlmax),array_ntp(npmax)

       dimension xdig(nxymax),tdig(nxymax)
       character val,finxy*40,inbound*80, change_file*80
       logical   flag, is_change
       real*4      sleep_time_s

!
!       Modified: Juan Lorenzo LSU
!       Date: June 17 2004
!       Purpose: explanation of parameters
!       Increased memory range
!
!
!       DICTIONARY
!       array_npt       number of total calcualted points in each layer
!        change_file     a messaging fail contining either yes or no
        change_file  = ".mmodpg/change"
!       datax1          nearest offset (km)
!       datadx          trace offset increment (km)
!       datadt
!       datat1          time value of first sample (s)
!       dp              increment of p for each ray
!       nlmax           maximum number of layers allowed
!       npmax           maximum number of  allowded
!       npamax          maximum number of  allowded
!       ns              number of samples per trace
!       ntp             total number of computed points
!       ntr             numer of traces in file
!       ntrmax          maximum number of traces allowed
!       nsmax           maximum number of samples allowed
!       fmin            minimum amplitude
!       fmax            maximum amplitude
!       multin
!       rv 		reducing velocity km/s
!       how often user calls mmodpg via a click in the  gui
        sleep_time_s    = 1.0
!       tout            cal! time output, Aug 2013 by Juan
!       xa1
!       xa2
!       xa3
!       xa4
!       xout            output distance of distance,time calculated pairs Aug 2013 by Juan
!       va
!       za
!       rv              reducing velocity (km/s)
!      xmax            maximum plotting distance
!               Should be greater than maximum offset in
!               order to allow V-Z plot to show on black
!               background ; in km
!       tmax            maximum time of data
!       tmin            minimum time of data
!       xin!           increment for km/s in modeling or thickness in modelign

! DEFAULT PARAMETERS
!
	 sdepth = 0.0
	 rdepth = 0.0
! 	pmin   = 0.0
! 	pmax   = 3.0
! 	pmax   = .6
!
! pmax = 20 s/km   V= 50 m/s
! pmin = 5   s/km  V= 200 m/s
!
	 pmin   = 0
        pmax   = 20
! 	dp     = 0.0005
! 	dp     = 0.001
	 dp     = 0.0001
        vmf    = 1./sqrt(3.)
! 	rv     = 1.0
	rv     = .0
	xmin   = 0.0
	xmax   = 0.120
! 	xmax   = 20.
! 	delt   = -10 ms
! 	tmin   = -0.010
	 tmin   = 0.0
! 	tmax   = 6
	 tmax   = 1.
	lch    = 1
	icolor = 0

!	general settings from user via gui
!       read (1,format1) name,equal,yes_no1
!       read (1,format2) name,equal,yes_no2
!       read (1,format3) name,equal,clip
!       read (1,format4) name,equal,min_t_s
!       read (1,format5) name,equal,min_x_m
!       read (1,format6) name,equal,x_increment_m
!       read (1,format7) name,equal,source_depth_m
!       read (1,format8) name,equal,receiver_depth_m
!       read (1,format9) name,equal,reducing_vel_mps
!       read (1,format10) name,equal,plot_min_x_m
!       read (1,format11) name,equal,plot_max_x_m
!       read (1,format12) name,equal,plot_min_t_s
!       read (1,format13) name,equal,plot_max_t_s
	inbound = "mmodpg.config"
	xinc   = 0.1
	iac    = 0
	iout   = 35
	datadx = 0.001
! 	datadx = 0.2
        datax1 = 0.001
!        datax1 = 0
! 	datadt = 0.005
        datat1 = 0.0
        flag   = .false.
	idred  = 0
        idrdtr = 0
        idrxy  = 0
!
	  do i=1,nlmax
		multin(i) = 1
	  enddo
!
! ********  Program Message *********
!
!	  call messa
!
! Read digitized X-T pairs
!
!	call read_par_i4('1- Read digitized X-T pairs, 0- No',idrxy)
!        if(idrxy.eq.1) then
!           finxy = '???'
!           call read_datxy(xdig,tdig,ndxy,finxy,21,1)
!        endif


! read all the configuration parameters for mmodpg
      call read_mmodpg_config(result,inbound)

 ! 1- Read digitized X-T pairs, 0- No',idrxy
      idrxy=result(1)
      print*, 'mmodpg,pre_digitized_XT_pairs=',idrxy
        if(idrxy.eq.1) then
           finxy = '???'
           call read_datxy(xdig,tdig,ndxy,finxy,21,1)
        endif

!
! Read data traces
!        
!      call read_par_i4('1- Read data traces, 0- No',idrdtr)
      idrtr=result(2)
      print*, 'mmodpg,data_traces=',idrtr
        if(idrdtr.eq.1) then
	  call rdata(f,ntrmax,nsmax,ntr,ns,datadt,fmin,fmax)
!
! Clips for gray scale (pggray)
!
          dclip   = fmax/100

          idrtr=result(3)
!	  call read_par_r4('Clip for data?',dclip)
          cmin    = -dclip
          cmax    =  dclip
!
!	  call read_par_r4('Time of 1st data sample (sec) ?',datat1)
!	  call read_par_r4('Dist. of 1st data trace (km) ?',datax1)
!	  call read_par_r4('Dist. between data traces (km) ?',datadx)
          datat1    =result(4)
          datax1    =result(5)
          datadx    =result(6)
!
        endif
!
15	continue
!
! ***** SOURCE AND RECEIVER DEPTH DEFINITION *****
!
!	call read_par_r4('SOURCE DEPTH (KM) ?',SDEPTH)
!	call read_par_r4('RECEIVER DEPTH (KM) ?',RDEPTH)
       SDEPTH  = result(7)
       RDERpth = result(8)
!
! **** PARAMETERS FOR THE X-T PLOT  ****
!
!   	write(*,*) 'TO DEFINE  PLOTTING AREA ENTER : '
!	write(*,*) ' '
	rvinv=0.
!	call read_par_r4('Reducing Velocity (km/s),(0-For none)',rv)
       rv = result(9)
	if (rv.eq.0.) go to 40
	  rvinv=1./rv
40	continue

!       if(idrdtr.eq.1) then
!	 call read_par_i4('1-Traces are red. by this vel., 0-No',idred)
!       endif
!
!	call read_par_r4('MINIMUN DISTANCE (KM)?',xmin)
!	call read_par_r4('MAXIMUN DISTANCE (KM)?',xmax)
!	call read_par_r4('MINIMUN TIME (SEC)?',tmin)
!	call read_par_r4('MAXIMUN TIME (SEC)?',tmax)

       xmin = result(10)
       xmax = result(11)
       tmin = result(12)
       tmax = result(13)
! **** RE-CHECK PARAMETERS ****
!  	ID=0
!	call read_par_i4('1- RECHECK PARAMETERS,0- NO',ID)
!	if(ID.eq.1) go to 15
!
! Transformation Matrix between data array and world coordinates
!
        rvinvd = 0.0
        if(idred.eq.0) rvinvd = rvinv
! *******************
	tr(1)  =  datax1 - datadx
	tr(2)  =  datadx
	tr(3)  =  0.0
	tr(4)  =  datat1 - datadt - tr(1)*rvinvd
	tr(5)  = -datadx*rvinvd
	tr(6)  =  datadt
!
! *****    READ VELOCITY DEPTH MODEL  ******
!
	call READMMOD(VT,VB,DZ,VST,VSB,RHOT,RHOB,nl)

! result16 is the starting layer from the settings file
       print *, "mmodpg.for, starting layer:", result(16)
       starting_layer = result(16)
       lch = int(starting_layer)
      print *, "mmodpg.for, int of starting layer:", lch
	call read_par_i4('Working layer number ?',lch)
		if(lch.lt.1)   lch = 1
		if(lch.gt.nl)  lch = nl
!
! ***************** Open X-T Window ****************
!
	call pgbegin(0,'?',1,1)
!	call pgpaper(12.0,8.5/11.0)
	call pgpaper(13.0,0.4)
!       call pgpaper(10.0,0.5)
        call pgask(flag)
************************************
!
10	continue
!
! Check for vt-vb too small.
!
!
!	A3 = 0.001
	A3 = 0.00001
!
	do 20 i = 1, nl
20	if(ABS(VT(I)-VB(I)).le.A3) vb(i) = vt(i)
!
! Reflections at the bottom of layers decided automatically
! based on velocity discontinuities
!
	do 34 I=1,nl-1
        IR(I)=0
34	if(ABS(VT(I+1)-VB(I)).GT.A3) IR(I)=1
	IR(nl) = 0  !** No reflection at the bottom of model
!
! *** COMPUTATIONS ***
!
	DZ1TEM=DZ(1)
	DZ(1)=DZ(1)-(SDEPTH+RDEPTH)/2. ! Correct only if 1rst layer
!					 is a constant vel. layer.
	call txpr(nl,VT,VB,DZ,PMIN,PMAX,DP,IR,multin,ntp,ILA,P,X,T)
	DZ(1)=DZ1TEM

!
! *** PLOTTING ***
!
55	continue
!       call pgvport(0.1,0.9,0.1,0.9)
        call pgvport(0.075,1.0,0.08,0.925)
	call pgwindow(xmin,xmax,tmax,tmin)
	call pgbox('BCTN',0.0,0,'BCTN',0.0,0)
	call pglabel('X(km)','Tred (sec)',
     +  'Primary P-wave T-X Curves, 1-D Model')
!
        if(idrdtr.eq.1) then
	   call pggray(f,ntrmax,nsmax,1,ntr,1,ns,cmax,cmin,tr)
        endif
!
	do 140 j=1,lch
        nplj = 0
        array_ntp(j) = ntp
	do 120 i=1,ntp
! ** SELECT LAYER J **
! nplj - number of points in layer j
	if(ABS(ILA(I)).NE.J) go to 120
	nplj = nplj+1
	xa1(nplj)  =   X(I)
	xa2(nplj)  =   T(I) - X(I) * rvinv !** RED. TIME
	xa3(nplj)  =   P(I)
        xa4(nplj)  =   T(I) - X(I) *  P(I) !** TAU
!######## get ready to output all the data
        xout(nplj,j) = X(I)
        tout(nplj,j) = T(I)

!        write(*,*)'*** test output *****************************'
!        write(*,*)'nplj=',nplj,' layer is ',j
!        write(*,*) xout(nplj,j),tout(nplj,j)
!	write(*,*) 'total # of computed points ',ntp

120	continue
	if(nplj.eq.0) go to 140
!
! ** PLOT LAYER J **
!
	icolor = icolor + 1
        if(icolor.gt.15) icolor = 1
	call pgsci(icolor)
!	call pgsci(3)
!
! ** X - T Plot **
!
        call pgline(nplj,xa1, xa2)
!
! ** TAU - P Plot **
!
!       call gks$polyline(nplj, xa3, xa4)
!
140	continue
!
! Draw digitized X-T data
!
        if(idrxy.eq.1) then
           do ixy = 1,ndxy 
             xa2(ixy) = tdig(ixy) - xdig(ixy) * rvinv
           enddo
	   call pgsci(3)
           call pgpoint(ndxy,xdig,xa2,9)
        endif
!
! Draw velocity model
!
! ****** descomentar para trabajo con OBS  ***
!       dz(1) = 2.0 * dz(1)
! ***********************
	a1 =  0.0
        a2 = -1.0
	do 145 i = 1,lch
		k = 2*i - 1
		va(k) = vt(i)
                if(vt(i).gt.a2) a2=vt(i)
		za(k) = a1
		va(k+1) = vb(i)
                if(vb(i).gt.a2) a2=vb(i)
		a1 = a1 + dz(i)
		za(k+1) = a1
145	continue
! ****** descomentar para trabajo con OBS  ***
!       dz(1) = dz(1)/2.0
! ***********************
!
	call pgsci(3)
	call pgvport(0.88,0.98,0.2,0.8)
	call pgwindow(0.0,a2,a1,0.0)
	call pgbox('BCTN',0.0,0,'BCNST',0.0,0)
	call pglabel('V(km/s)','Z(km)','')
!
!	call pgslw(5)
	call pgline(2*lch,va,za)
!	call pgslw(1)
!
150     continue

!      beginning of loop that detects changes in the gui
!      do while (.TRUE.)
!               call sleep(sleep_time_s)
!                i=i+1
!                print *, 'count=',i
        call read_yes_no_file(is_change,change_file)
          if (is_change ) then

              print *, 'is_change=',is_change


          end if
!       end do

!             change    = new_layer
!             change    = VtopNVbot
!             change    = zoom
!             change    = multiply_velocities_by_constant
!             change    = VtopNVot_upper_layer
!             chaneg    = VbotNVtop_lower_layer
!             change    =
!        call write_no_change
!        if (is_change) then read_option ()
!        if option is good then carry out the instruction
!          instruction
!             e.g., read what layer we should work on
!             read layer number
!             replot the layer in question
!             make sure instruction is complete before a new change is implemented
!        go and check to see if there is another change
!      end the loop
        write(*,*)''
        write(*,*)'*** CHANGE : *****************************'
        write(*,*)'0-  Working layer (Now is LAYER ',lch,')'
        write(*,500) VT(lch),VB(lch)
        write(*,502) DZ(lch)
        write(*,*)'5-  VTOP and overlying VBOT,  6-  VBOT and underlying
     + VTOP'
!        write(*,504) DP
        write(*,503) xin
        write(*,*)'******************************************'
        write(*,*)'8-  Zoom and move image, 11- Multiply all Velocities
     + by a constant'   
        write(*,*)'12- or larger to END'
!
        call read_par_i4('Option number ?',iac)
!
        if(iac.gt.11) go to 255
!
        if(iac.eq.7) then
!                call read_xinc
                call read_par_r4('New increment (km or km/s) ??',xinc)
                go to 150
        endif
!
        if(iac.eq.8) then
!               call read_zoom_amount
                call pgzoom(xmin,xmax,tmin,tmax)
                icolor = 0
                call pgpage
                call pgsci(1)
                go to 55
        endif
!
! *** Options that require recompute X-T curves ***
!
!      read layer number
!      is layer number new
!      is layer number old
!      if old do nothing
        if(iac.eq.0) then
!               call read_layer_number
                lch = lch + 1
                call read_par_i4('Layer Number ??',lch)
                if(lch.lt.1)   lch = 1
                if(lch.gt.nl)  lch = nl
        endif
!
        if(iac.ge.1.and.iac.le.6) then
                write(*,*) ''
                write(*,*) 'RETURN to increase,  - to decrease'
                read(*,'(a)') val
!
                a1 = xin!
                if (val.eq.'-') a1 = -xin!
!
                if(iac.eq.1) VT(lch) = VT(lch) + a1
                if(iac.eq.2) VB(lch) = VB(lch) + a1
                if(iac.eq.3) DZ(lch) = DZ(lch) + a1
!
                if(iac.eq.4) then
                        VT(lch) = VT(lch) + a1
                        VB(lch) = VB(lch) + a1
                endif
!
                if(iac.eq.5) then
                        VT(lch) = VT(lch) + a1
                        if(lch.gt.1) VB(lch-1) = VB(lch-1) + a1
                endif
!
                if(iac.eq.6) then
                        if(lch.lt.nl) VT(lch+1) = VT(lch+1) + a1
                        VB(lch) = VB(lch) + a1
                endif
        endif
!
        if(iac.eq.9) then
		call read_par_r4('New clip ??',dclip)
		cmin = -dclip
		cmax =  dclip 
	endif
!
	if(iac.eq.10) then
		call read_par_r4('New dp (s/km) ??',dp)
        endif
!
	if(iac.eq.11) then
		call read_par_r4('Multiplicative constant ??',vmf)
                do i = 1,nl
                        VT(i) = vmf * VT(i)
                        VB(i) = vmf * VB(i)
                enddo 
        endif
!
! **************************
!
	icolor = 0
	call pgpage
	call pgsci(1)
	go to  10
!
255	continue
!
! write modified model to terminal
!
! the gui will automatically update
! comment out the following
	write(*,*) ' '
	write(*,*) 'MODIFIED MODEL:'
	call WRIMOD2(nl,VT,VB,DZ,VST,VSB,RHOT,RHOB)
!
! write modified model to file mmodpg.out
!
        OPEN(UNIT=IOUT,FILE='mmodpg.out',STATUS='UNKNOWN',
     +  FORM='UNFORMATTED')
        do K=1,NL+1
        	write(IOUT) VT(K),VB(K),DZ(K),
     +  	VST(K),VSB(K),RHOT(K),RHOB(K)
        enddo
        CLOSE(UNIT=IOUT)

! write first breaks out
!
!        OPEN(UNIT=IOUT,FILE='mmodpg.XT',STATUS='UNKNOWN',
!     +  FORM='UNFORMATTED')
!        do K=1,NL+1
! for each layer write out pairs of x and t
!           do J = 1,array_npt(K)
!        	write(IOUT) xout(J,K),tout(J,K)
!          enddo
!        enddo
!        CLOSE(UNIT=IOUT)

! write out the TX pairs for all the layers
!
        write(*,*) 'This model has been written to file:'
        write(*,*) '***     mmodpg.out     ***'
!
        call pgend
500     format(' 1-  VTOP = ',f7.5,',            2-  VBOT = ',f7.5,' (km
     +/s)')
502     format(' 3-  DZ   = ',f7.5,' (km)',',       4-  VTOP and VBOT')
503     format(' 7-  Increment = ',f7.5,' (km or km/s)')
504     format(' 9-  Clip for data,            10- DP = ',f9.6,
     +' (s/km)')
        end

! ****************************************************
!
	SUBROUTINE rdata(f, m, n, ntr, ns, datadt, fmin, fmax)
	INTEGER*4 m,n,ntr,ns,idtuse!
	REAL*4 f(m,m), fmin, fmax
	CHARACTER*40 FIN
	LOGICAL EX
!
! Read data parameters
!
	iin=26
	OPEN(UNIT=iin,FILE='parmmod',STATUS='OLD')
	read(iin,*) ntr,ns,idtuse!
	close(iin)
	datadt = float(idtusec) * 1e-6
!
!115    write(*,*) 'INPUT DATA FILE NAME ?? '
!	READ(5,'(A)') FIN
!       INQUIRE(FILE=FIN,EXIST=EX)
!	if(.NOT.EX) then
!	write(*,*)'FILE DOES NOT EXIST, TRY AGAIN WITH A NEW NAME'
!	go to 115
!	endif
!
!	OPEN(UNIT=iin,FILE=FIN,STATUS='OLD',FORM='UNFORMATTED')
!
! Read data File
!
	OPEN(UNIT=iin,FILE='datammod',STATUS='OLD',FORM='UNFORMATTED')
        k=1
120     READ(iin) (f(k,i), i=1,ns)
!        write(*,*)'k, i,ntr, ns,f(k,i)',k,i,ntr,ns,f(k-1,i-1)
        if(k.GE.ntr) go to 125
        k=k+1
        go to 120
125	CLOSE(UNIT=iin)
!
      fmin = 1e30
      fmax = -1e30
      do 20 i=1,ntr
         do 10 j=1,ns
            fmin = min(f(i,j),fmin)
            fmax = max(f(i,j),fmax)
 10      continue
 20   continue
!
	write(*,*) 'Data min, max  = ',fmin,fmax
	write(*,*)
!
      END
!
! ************************************************
!
	subroutine read_datxy(x,y,n,fin,iin,iwrit)
!
! Reads file containing (x,y) pairs and an arbitrary number of comment lines
! before these pairs. The (x,y) pairs are returned in arrays x and y. The
! comment lines are written on the terminal.
!
! n     = number of (x,y) pairs in the file (output).
!
! fin   = Default input file name (input)
! iin   = reading input unit (input).
! iwrit = if iwrit.eq.1, (x,y) pairs are written on screen (input).
!
	dimension x(*),y(*)
	character*40 fin
	character*40 comment
	LOGICAL EX
!
!  ********* read input file *********
!
! Check for default file "fin".  If file does not exist, then ask for
! a file name
!
!       write(*,*) fin
	go to 117
115     write(*,*) 'Input File Name ?? '
	READ(*,'(A)') fin
117	INQUIRE(FILE=fin,EXIST=EX)
	IF(.NOT.EX) THEN
	write(*,*) 'There is no trace defined'
	GO TO 115
	ENDIF
	OPEN(UNIT=iin,FILE=fin,STATUS='OLD')
!
	n = 1
	write(*,*)
120	continue
	READ(iin,'(a)',end=170,err = 150) comment
	read(comment,*,err = 150) xa,ya
	x(n) = xa
	y(n) = ya
	n = n + 1
	go to 120
150	continue
!       write(*,'(a)') comment
	go to 120
170	continue
	close(iin)
	n = n - 1
! ************************************************************
	if(n.ge.1) then
	   if(iwrit.eq.1) then
		write(*,*) '** Digitized traveltime data ** '
		write(*,*) ' '
		write(*,*) '            X(km)          T(sec)'
		write(*,*) ' '
		do 180 i = 1,n
180		write(*,300) i,x(i),y(i)
		write(*,*) ' '
	   endif
	else
		write(*,*) '** There is no line containing data in this file **'
	endif
300	format(i5,2f15.6)
	return
	end
! ******************************************
