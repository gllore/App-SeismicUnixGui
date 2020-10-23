! Calculo de curvas camino-tiempo para modelos formados por una
! combinacion de capas planas homogeneas o con gradiente de
! velocidad constante. Fuente y receptor en 1ra capa; default
! es que ambos esten en superficie.
!
       integer*4  nlmax,npmax,npamax,ntrmax,nsmax,ntr,ns
       integer*2  how_many
       parameter (nlmax=25,npmax=960000,npamax=4000000)
       parameter (ntrmax=1000,nsmax=32768)
       parameter (nxymax=1000)
       real*4    Amp(ntrmax,nsmax)
       real*4    Amp_min,Amp_max,tr(6),result(20)
       dimension IR(nlmax-1),VT(nlmax),VB(nlmax),DZ(nlmax)
       dimension VST(nlmax),VSB(nlmax),RHOT(nlmax),RHOB(nlmax)
       dimension va(2*nlmax),za(2*nlmax)
       dimension va_prior(2*nlmax), za_prior(2*nlmax)
       dimension multin(nlmax)
       dimension ILA(npmax),P(npmax),X(npmax),T(npmax)
       dimension xa1(npamax),xa2(npamax),xa3(npamax),xa4(npamax)
       real   a1,a2,a1_prior,a2_prior
!      next line added on Aug 20 2013
       dimension xout(npmax,nlmax)
       dimension tout(npmax,nlmax),array_ntp(npmax)

       dimension xdig(nxymax),tdig(nxymax)
       character*255 set_DIR, get_DIR
       character*300 inboundVincrement, inboundVbotNtop_factor
       character*300 inbound_change, inbound_config, inbound_option
       character*300 inbound_layer, inbound_par, inbound_clip
        character*300 inbound_thickness_m
       character*300 inboundVbot,inboundVtop
       character*300 inboundVbot_upper,inboundVtop_lower
       character*300 outbound_option, outbound_model_txt
       character*300  outbound_model_bin, outbound_model_bin_bck
       character val,finxy*40
       character*40 change_file,config_file,no,option_file,layer_file
       character*40 clip_file, model_file_text, thickness_m_file
       character*40 model_file_bin, model_file_bin_bck
       character*40 Vbot_file,Vbot_upper_file,Vtop_file,Vtop_lower_file
       character*40 Vincrement_file, VbotNtop_factor_file
       character*40 par_file, moveNzoom_file
       logical   flag, is_change, base_file,ans
       integer   sleep_time_s, upper_layer_number,lower_layer_number
       integer   option,layer,option_default
       integer   VtopNVot_upper_layer_opt
       integer   VbotNVtop_lower_layer_opt
       integer   Vtop_plus_opt, Vtop_minus_opt
       integer   Vbot_plus_opt, Vbot_minus_opt
       integer   VbotNVtop_plus_opt, VbotNVtop_minus_opt
       integer   VtopNVbot_upper_layer_plus_opt
       integer   VtopNVbot_upper_layer_minus_opt
       integer   VbotNVtop_lower_layer_plus_opt
       integer   VbotNVtop_lower_layer_minus_opt
       integer   change_VbotNtop_factor_opt,zoom_plus_opt
       integer    zoom_minus_opt
       integer   VbotNtop_multiply_opt
       integer    changeVtop_lower_layer_opt,  changeVbot_upper_layer_opt
       integer    changeVbot_opt, changeVtop_opt
       integer   move_image_down_opt, move_image_left_opt
       integer   move_image_up_opt,move_image_right_opt
       integer   change_velocity_opt
       integer   change_thickness_increment_opt
       integer   changeVincrement_opt, exit_opt, change_clip4plot_opt
       integer   change_layer_number_opt,new_layer_number
       integer   change_thickness_m_opt
       integer   thickness_m_minus_opt, thickness_m_plus_opt
       integer   current_layer_number,prior_layer_number
       integer   current_moveNzoom
       integer   prior_moveNzoom
       integer   new_moveNzoom
       real     new_thickness_m, current_thickness_m,prior_thickness_m
       real      Vtop_mps,Vbot_mps,Vtop_lower_mps,Vbot_upper_mps
       real      Vtop_kmps,Vbot_kmps,Vtop_lower_kmps,Vbot_upper_kmps
       real*4  thickness_increment_m, Vincrement_mps
       real*4  thickness_increment_km
       real*4 VbotNtop_factor, Vincrement_kmps, m2km
       real      current_clip,prior_clip,new_clip, clip_max, clip_min
       real      priorVincrement_mps, currentVincrement_mps
       real      newVincrement_mps
       real      prior_thickness_increment_msub setVtopNVbot_upper_laye
       real   current_thickness_increment_m,new_thickness_increment_m
       real      priorVbotNtop_factor, currentVbotNtop_factor
       real      newVbotNtop_factor
       real      priorVtop, currentVtop, newVtop
       real      priorVbot, currentVbot, newVbot
       real      priorVtop_lower, currentVtop_lower, newVtop_lower
       real      priorVbot_upper, currentVbot_upper, newVbot_upper
       real      start, finish, cpu_duration
!       Modified: Juan Lorenzo LSU
!       Date: June 17 2004
!       Purpose: explanation of parameters
!       Increased memory range
!
!       DICTIONARY AND DEFINITIONS
!       array_npt       number of total calcualted points in each layer
!       change_file     a messaging file contining either yes or no

        Vbot_file            = "Vbot"
        Vbot_upper_file      = "Vbot_upper_layer"
        Vincrement_file      = "Vincrement"
        Vtop_file            = "Vtop"
        Vtop_lower_file      = "Vtop_lower_layer"
        VbotNtop_factor_file = "VbotNtop_factor"
        change_file         = "change"
        clip_file           = "clip"
        config_file         = "immodpg.config"
        model_file_text     = "model.txt"
        model_file_bin       = "immodpg.out"
        model_file_bin_bck       = ".immodpg.out"
        is_change           = .FALSE.
        layer_file          = "layer"
        no                  = "no"
        option_file         = "option"
        par_file            = "parmmod"
        new_layer_number    = -1
        current_layer_number =-1
        prior_layer_number  =-2
        thickness_m_file       = "thickness_m"

!      Coded user options
       changeVbot_opt                           = 20
       Vbot_minus_opt                     = 21
       Vbot_plus_opt                      = 22
       changeVbot_upper_layer_opt                     = 23

       VbotNVtop_lower_layer_minus_opt    = 61
       VbotNVtop_lower_layer_plus_opt     = 62
       VbotNVtop_minus_opt                = 41
       VbotNVtop_plus_opt                 = 42

       changeVtop_opt                           = 10
       changeVtop_lower_layer_opt                     = 11
       Vtop_minus_opt                     = 12
       Vtop_plus_opt                      = 13

       VbotNtop_multiply_opt              = 16

       VtopNVbot_upper_layer_minus_opt    = 51
       VtopNVbot_upper_layer_plus_opt     = 52
       change_layer_number_opt            = 0
       change_thickness_m_opt               = 14 ! do not forget todo
       change_thickness_increment_opt     = 15
       changeVincrement_opt               = 7
       changeVbotNtop_factor_opt          = 68
       change_clip4plot_opt               = 9
       thickness_m_minus_opt            = 140
       thickness_m_plus_opt               = 141
       exit_opt                           = 99

       option_default                     = -1
       option                             = option_default
!       datax1          nearest offset (km)
!       datadx          trace offset increment (km)
!       datadt
!       datat1          time value of first sample (s)
!       inbound_bin    full path to stripped su file
!       inbound_par     path to the parameter file
!       dp              increment of p for each ray
!       nlmax           maximum number of layers allowed
!       npmax           maximum number of  allowded
!       npamax          maximum number of  allowded
!       ns              number of samples per trace
!       ntp             total number of computed points
!       ntr             numer of traces in file
!       ntrmax          maximum number of traces allowed
!       nsmax           maximum number of samples allowed
!       par_file        contains no. traces, no. samples, SI (usec)
!       Amp_min            minimum amplitude
!       Amp_max            maximum amplitude
!       multin
!       rv 		reducing velocity km/s
!
!       how often user calls immodpg via a click in the  gui
       sleep_time_s         = 1
       thickness increment_m = 10.
       Vincrement_mps       = 10.
!       tout            cal! time output, Aug 2013 by Juan
!       va and va_prior, za and za_prior are velocity  and depth
!       vectors for plotting the velocity-versus-depth model om
!       far right side
!       xa1
!       xa2
!       xa3
!       xa4
!       xout
!      output distance of distance,time calculated pairs
!       Aug 2013 by Juan
!       va
!       za
!      xmax            maximum plotting distance
!               Should be greater than maximum offset in
!               order to allow V-Z plot to show on black
!               background ; in km
!       tmax            maximum time of data
!       tmin            minimum time of data
!       xinc    increment for km/s in modeling or thickness in modelign

! DEFAULT PARAMETERS
       m2km =.001
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
       current_layer_number    = 1
	icolor = 0
	xinc   = 0.1
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

! define the different needed directories
        set_DIR = "IMMODPG"
       call Project_config(set_DIR,get_DIR)
   !     define needed files
       inbound_config = trim(get_DIR)//"/"//config_file
!      print*, 'immodpg.for, inbound_config:',trim(inbound_config),'--'
       outbound_model_txt = trim(get_DIR)//"/"//model_file_text
       outbound_model_bin = trim(get_DIR)//"/"//model_file_bin
       outbound_model_bin_bck = trim(get_DIR)//"/"//model_file_bin_bck
! define the different needed directories
       set_DIR = "IMMODPG_INVISIBLE"
       call Project_config(set_DIR,get_DIR)
!      print*, '1. immodpg.for, get_DIR:',trim(get_DIR),'--'
!      print*, '1. immodpg.for, change_file:',change_file,'--'
!      inbound_change = trim(get_DIR)//"/"//change_file
       inbound_layer  = trim(get_DIR)//"/"//layer_file
       inbound_option = trim(get_DIR)//"/"//option_file
       outbound_option=inbound_option

! define the different needed directories
       set_DIR = "IMMODPG_INVISIBLE"
       call Project_config(set_DIR,get_DIR)
       inboundVtop_lower = trim(get_DIR)//"/"//Vtop_lower_file

! define the different needed directories
       set_DIR = "IMMODPG_INVISIBLE"
       call Project_config(set_DIR,get_DIR)
       inboundVbot = trim(get_DIR)//"/"//Vbot_file

! define the different needed directories
       set_DIR = "IMMODPG_INVISIBLE"
       call Project_config(set_DIR,get_DIR)
       inboundVtop = trim(get_DIR)//"/"//Vtop_file

! define the different needed directories
       set_DIR = "IMMODPG_INVISIBLE"
       call Project_config(set_DIR,get_DIR)
       inboundVbot_upper = trim(get_DIR)//"/"//Vbot_upper_file

! define the different needed directories
       set_DIR = "IMMODPG_INVISIBLE"
       call Project_config(set_DIR,get_DIR)
!      print*, '1. immodpg.for, get_DIR:',trim(get_DIR),'--'
!      print*, '1. immodpg.for, change_file:',change_file,'--'
       inboundVincrement  = trim(get_DIR)//"/"//Vincrement_file
!      print*,'inboundVIncrement=',inboundVincrement
       inboundVbotNtop_factor  =
     +trim(get_DIR)//"/"//VbotNtop_factor_file
        inbound_thickness_m =trim(get_DIR)//"/"//thickness_m_file
! read all the configuration parameters for immodpg
! i/p inbound_config
! o/p base_file, result,
       call read_immodpg_config(base_file, result, inbound_config)
!       print*, 'L 260, base_file=',base_file
 ! Read digitized X-T pairs, 0- No',idrxy
       idrxy=int(result(1))
 !  Read data traces, 0- No',idrdtr
      idrdtr=int(result(2))
      datat1    =result(4)
      datax1    =result(5)
      datadx    =result(6)
!SOURCE AND RECEIVER DEPTH DEFINITION (KM)
      SDEPTH  = result(7)
      RDEPTH  = result(8)
! DEFINE PLOTTING AREA ENTER
! linear reduction velocity in mps
      rv = result(9)
      xmin = result(10)
      xmax = result(11)
      tmin = result(12)
      tmax = result(13)
! result16 is the starting layer from the settings file
      starting_layer       = result(16)
      current_layer_number = int(starting_layer)
      VbotNtop_factor      = result(17)
      Vincrement_kmps       = result(18)
      thickness_increment_km =result(19)

!      print*, 'immodpg.for,read pre_digitized_XT_pairs (y/n)=',idrxy
!      print*, 'immodpg.for,reading data_traces(y/n)=',idrdtr
!      print*, 'immodpg.for,datat1 (S)=',datat1
!      print*, 'immodpg.for,datax1 (KM)=',datax1
!      print*, 'immodpg.for,datadx (X)=',datadx
!      print*, 'immodpg.for,SDEPTH (KM)=',SDEPTH
!      print*, 'immodpg.for,RDEPTH (KM)=',RDEPTH
!
!      print*, 'immodpg.for,PLOTTING LAYOUT'new_clip
!      print*, 'immodpg.for,rv (KM/S)=',rv
!      print*, 'immodpg.for,MINIMUN DISTANCE (KM)xmin=',xmin
!      print*, 'L300 immodpg.for,MAXIMUN DISTANCE (KM)=',xmax
!      print*, 'immodpg.for,tmin (s)=',tmin
!      print*, 'immodpg.for,tmax (s)=',tmax
!      print *, "immodpg.for,starting layer:", current_layer_number
!      print*, 'immodpg.for,VbotNtop_factor=',VbotNtop_factor
!      print*, 'immodpg.for,Vincrement_kmps=',Vincrement_kmps
! Read digitized X-T pairs, 0- No',idrxy
      if(idrxy.eq.1) then
         finxy = '???'
         call read_datxy(xdig,tdig,ndxy,finxy,21,1)
      endif

! READ BINARY SU FILES STRIPPED of ALL HEADERS
      if(idrdtr.eq.1) then
!         print*, 'immodpg.for,reading data_traces=',idrdtr
! datadt is returned
! Read data parameters
! retufns ntr, ns and idtusec
! define the different needed directories
       set_DIR = "IMMODPG"
       call Project_config(set_DIR,get_DIR)
       inbound_par    = trim(get_DIR)//"/"//par_file
!       print*,'immodpg.for,inbound_par:',trim(inbound_par),'--'
       call read_parmmod_file(inbound_par,ntr,ns,idtusec)
       datadt = float(idtusec) * 1e-6
!       print*,'immodpg.for,inbound_par:datadt',datadt,'--'
	call rdata(Amp,ntrmax,nsmax,ntr,ns,Amp_min,Amp_max)
!
! Clips for gray scale (pggray)
         current_clip   = Amp_max/100

! User override of clips for gray scale (pggray)
         current_clip   = result(3)
         clip_min    = -current_clip
         clip_max    =  current_clip
!         print*, '330 immodpg.for,clip_min=',clip_min
!         print*, '331 immodpg.for,current_clip=',current_clip

       endif ! end read bin data file

!15    continue

! **** PARAMETERS FOR THE X-T PLOT  ****
!      DEFINE  PLOTTING AREA
! reduction velocity
	rvinv=0.

	if (rv.eq.0.) go to 40
	  rvinv=1./rv
	  idred=1 ! 1-yes 0-No JML 3-30-2020
40	continue

!       if(idrdtr.eq.1) then
!	 call read_par_i4('1-Traces are red. by this vel., 0-No',idred)
!       endif

! Transformation Matrix between data array and world coordinates
        rvinvd = 0.0
! if no velocity reduction (idred=0)
        if(idred.eq.0) rvinvd = rvinv
! *******************
	tr(1)  =  datax1 - datadx
	tr(2)  =  datadx
	tr(3)  =  0.0
	tr(4)  =  datat1 - datadt - tr(1)*rvinvd
	tr(5)  = -datadx*rvinvd
	tr(6)  =  datadt

! READ VELOCITY DEPTH MODEL
	call READMMOD(VT,VB,DZ,VST,VSB,RHOT,RHOB,nl)
!       print*, '2. immodpg.for,readmod'

! error check the working layer number
	if(current_layer_number.lt.1)   current_layer_number = 1
	if(current_layer_number.gt.nl)  current_layer_number = nl

! Open X-T Window ****************
!       print *,' 1. start '
!       call pgbegin(0,'?',1,1)  !ask what device to use

	call pgbegin(0,' ',1,1)  ! use default device

!      width_in,aspect
	call pgpaper(10.0,0.45)
! (XLEFT, XRIGHT, YBOT, YTOP)
!	call pgvport(-5.,1.,0.,1.)
!       call pgsvp(0.0,0.5,0.5,1.0)
       call pgask(flag)

!      default velocity model
       a1_prior =  0.0
       a2_prior = -1.0
       do 8  i = 1,current_layer_number
              k = 2*i - 1
              va_prior(k) = vt(i)
              if(vt(i).gt.a2_prior) a2=vt(i)
              za_prior(k) = a1_prior
              va_prior(k+1) = vb(i)
              if(vb(i).gt.a2) a2=vb(i)
              a1_prior = a1_prior + dz(i)
              za_prior(k+1) = a1_prior
8     continue
! End of setup
! user sees an EMPTY BLACkKSCREEN
!       print *,' 1. start of principal input loop'
10	continue

************************************
! START OF ALL INTERACTIONS WITH THE USER
!       print *,' L317 start of interaction with the user'

! Check for Vtop-Vbottom too small.
!	A3 = 0.001
	A3 = 0.00001
!       print*, '1D. immodpg.for,made it, current_layer_number=',
!     +  current_layer_number

       do 20 i = 1, current_layer_number

20	if(ABS(VT(i)-VB(i)).le.A3) vb(i) = vt(i)

!      Reflections at the bottom of layers decided automatically
!      based on velocity discontinuities
	do 34 I=1,nl-1
         IR(i)=0
34	if(ABS(VT(i+1)-VB(i)).GT.A3) IR(i)=1

	IR(nl) = 0  !** No reflection at the bottom of model

!      COMPUTATIONS ***
	DZ1TEM=DZ(1)

!      Correct only if 1st layer is a constant vel. layer.
	DZ(1)=DZ(1)-(SDEPTH+RDEPTH)/2.

	call txpr(nl,VT,VB,DZ,PMIN,PMAX,DP,IR,multin,ntp,ILA,P,X,T)
	DZ(1)=DZ1TEM

55	continue

!      PLOTTING and REPLOTTING when correct option turns
       call pgpage ! clear screen
!       left_bottom_X, right_top_X,left_bottom_Y,right_top_Y
       call pgvport(0.075,1.0,0.08,0.925)
	call pgwindow(xmin,xmax,tmax,tmin)
	call pgbox('BCTN',0.0,0,'BCTN',0.0,0)
	call pglabel('X(km)','Tred (sec)',
     + 'Primary P-wave T-X Curves, 1-D Model')
!
!      plot seismic image in a window
       if(idrdtr.eq.1) then
!        print *, 'L435, clip_max=',clip_max
!        print *, 'L436, clip_min=',clip_min
!        clip_min = -1.00000
!        clip_max = 1.00000
	  call pggray(Amp,ntrmax,nsmax,1,ntr,1,ns,clip_max,clip_min,tr)
!	  print *, 'plot seismic image in window'

       endif
!
!      plot modelled arrivals by layer
       do 140 j=1,current_layer_number
         nplj = 0
         array_ntp(j) = ntp

!        plot first breaks in a layer
	  do 120 i=1,ntp

! ** SELECT LAYER J **
!            nplj - number of points in layer j
	    if(ABS(ILA(i)).NE.J) go to 120
	       nplj = nplj+1
	       xa1(nplj)  =   X(i)
	       xa2(nplj)  =   T(i) - X(i) * rvinv !** RED. TIME
	       xa3(nplj)  =   P(i)
              xa4(nplj)  =   T(i) - X(i) *  P(i) !** TAU
!             get ready to output all the data
              xout(nplj,j) = X(i)
              tout(nplj,j) = T(i)

!        write(*,*)'*** test output *****************************'
!        write(*,*)'nplj=',nplj,' layer is ',j
!        write(*,*) xout(nplj,j),tout(nplj,j)
!	  write(*,*) 'L 374 total # of computed points ',ntp

120	continue ! points in each layer

	if(nplj.eq.0) go to 140 ! new layer
!
!      PLOT LAYER J **
	icolor = icolor + 1

!      pick a different color for arrivals that travel
!      through a new deeper layer
       if(icolor.gt.15) icolor = 1

	call pgsci(icolor)
!      print*, 'immodpg.for,read pre_digitized_XT_pairs (y/n)=',idrxy
!      print*, 'immodpg.for,reading data_traces(y/n)=',idrdtr
!      print*, 'immodpg.for,datat1 (S)=',datat1
!      print*, 'immodpg.for,datax1 (KM)=',datax1
!      print*, 'immodpg.for,datadx (X)=',datadx
!      print*, 'immodpg.for,SDEPTH (KM)=',SDEPTH
!       print*, 'l 393 immodpg.for,RDEPTH (KM)=',RDEPTH
!
!      print*, 'immodpg.for,PLOTTING LAYOUT'
!      print*, 'immodpg.for,rv (KM/S)=',rv
!      print*, 'immodpg.for,MINIMUN DISTANCE (KM)xmin=',xmin
!      print*, 'L 491 immodpg.for,MAXIMUN DISTANCE (KM)=',xmax
!      print*, 'immodpg.for,tmin (s)=',tmin
!      print*, 'immodpg.for,tmax (s)=',tmax
!      print *, "immodpg.for,starting layer:", current_layer_number

!	call pgsci(3)
!
! X - T Plot of first arrival points for a fixed layer
!
       call pgline(nplj,xa1, xa2)
!       print *, 'L424,plot first arrival points for a fixed layer'

! TAU - P Plot **
!
!       call gks$polyline(nplj, xa3, xa4)
!
140   continue ! go to a new layer
!
! Draw digitized X-T data if it exists
!
      if(idrxy.eq.1) then

         do ixy = 1,ndxy
             xa2(ixy) = tdig(ixy) - xdig(ixy) * rvinv
         enddo

	  call pgsci(3)
         call pgpoint(ndxy,xdig,xa2,9)  ! TODO perhaps
         print *, 'L 423 Draw digitized X-T data if it exists'

      endif
!
!      Draw velocity vs. depth plot at far right
!      STEP 1: Erase previous model
!       0 = black (erase)

       call pgsci(0)
       call pgvport(0.88,0.98,0.2,0.8)
       call pgwindow(0.0,a2_prior,a1_prior,0.0)
       call pgbox('BCTN',0.0,0,'BCNST',0.0,0)
       call pglabel('V(km/s)','Z(km)','')
       call pgline(2*current_layer_number,va_prior,za_prior)
!       print *, 'L 555 current layer number is ', current_layer_number
!       print *, 'L 556 end of draw velocity model'

!      STEP 2: Calcualte the current model
! ****** descomentar para trabajo con OBS  ***
!       dz(1) = 2.0 * dz(1)
! ***********************
      a1 =  0.0
      a2 = -1.0
      do 145 i = 1,current_layer_number
              k = 2*i - 1
              va(k) = vt(i)
              if(vt(i).gt.a2) a2=vt(i)
              za(k) = a1
              va(k+1) = vb(i)
              if(vb(i).gt.a2) a2=vb(i)
              a1 = a1 + dz(i)
              za(k+1) = a1
145   continue

!      STEP 3: Save the current model as the "prior"
       a1_prior = a1
       a2_prior = a2
       va_prior = va
       za_prior = za

!            STEP 4: Draw the current model
! ****** descomentar para trabajo con OBS  ***
!       dz(1) = dz(1)/2.0
! ***********************
!      set color index: 3 = green
!       white on black background =1
       call pgsci(3)
       call pgvport(0.88,0.98,0.2,0.8)
	call pgwindow(0.0,a2,a1,0.0)
	call pgbox('BCTN',0.0,0,'BCNST',0.0,0)
	call pglabel('V(km/s)','Z(km)','')
!	call pgslw(5)
	call pgline(2*current_layer_number,va,za)
!       print *, 'L 594 current layer number is ', current_layer_number
!	call pgslw(1)
!       print *, 'L 596 end of draw velocity model'

150    continue

!     define the different needed directories
      set_DIR = "IMMODPG_INVISIBLE"
      call Project_config(set_DIR,get_DIR)
!      print*, '1. immodpg.for, get_DIR:',trim(get_DIR),'--'
!      print*, '1. immodpg.for, change_file:',change_file,'--'
      inbound_change = trim(get_DIR)//"/"//change_file
      inbound_clip   = trim(get_DIR)//"/"//clip_file
!      print*, '1.immodpg.for,inbound_change:',inbound_change,'--'

       ans = .TRUE.
       icount=0;

       do while (ans)

!       slow fortran for Perl i/o to .001 s
        call cpu_time(start)
!        print '("Time = ",f6.3," seconds.")',start
 151    call cpu_time(finish)
!        print*,'slowing'
        cpu_duration = finish-start
!        print '("Time = ",f6.3," seconds.")',cpu_duration
        if (cpu_duration .lt. .001) go to 151
!        print '("Time = ",f6.3," seconds.")',cpu_duration

!           call sleep(sleep_time_s)
           icount=icount+1
!           print *, 'L 551 do loop: immodpg,icount=',icount
!          Detect for change:  "yes"
!          print*, '2. immodpg.for,inbound_change:',inbound_change,'--'

           call read_yes_no_file(is_change,inbound_change)
!          print*, '659.immodpg.for,is_change:',is_change,'--'

           if (is_change ) then
!             Restore change to "no"
              call write_yes_no_file(no,inbound_change)
!             read option number
              call read_option_file(option,inbound_option)
!              print *, 'L666 immodpg.for,is_change=',is_change
!              print *, '667 immodpg.for,option#=',option
!              print *,'L 41 immodpg.for,clnopt=',
!     +        change_layer_number_opt

              if(option.eq.change_layer_number_opt) then
!                CASE change layer option YES
                 call read_layer_file(new_layer_number,inbound_layer)
                 prior_layer_number   = current_layer_number
                 current_layer_number = new_layer_number
!                 print *,'L 517 current layer #:',current_layer_number

!                is layer number new or old?
!                if old, do nothing
                 if (current_layer_number .ne. prior_layer_number)then
!                  CASE 1: new layer detected
                   if(new_layer_number.lt.1) then
                      current_layer_number = 1
!                      print *, 'L516 new current layer_number'
                   endif

                   if(new_layer_number.gt.nl)  then
                      current_layer_number = nl
!                       print *, 'L526. current layer_number'
                   endif

! write modified model to terminal before
!                   changing layer
!
                   write(*,*) ' '
                    write(*,*) 'modified model prior to layer change:'
                   call WRIMOD2(nl,VT,VB,DZ,VST,VSB,RHOT,RHOB)
!
! write modified model to file immodpg.out
!
!                   write(*,*) ' '
!                    write(*,*) 'Binary file: immodpg.out'

                   OPEN(UNIT=IOUT,FILE=outbound_model_bin,
     +               STATUS='UNKNOWN',
     +               FORM='UNFORMATTED')
                      do K=1,NL+1
                            write(IOUT) VT(K),VB(K),DZ(K),
     +                      VST(K),VSB(K),RHOT(K),RHOB(K)
                      enddo
                      CLOSE(UNIT=IOUT)

! write modified text file out
!                     write(*,*) ' '
!                    write(*,*) 'Text file: model.txt'
             call write_model_file_text(nl,VT,VB,DZ,VST,VSB,RHOT,RHOB,
     +         outbound_model_txt);
!
!                   print *,'L 703 current layer #:',current_layer_number
                   go to 10 ! start of all interactions with user

                 elseif(current_layer_number.eq.prior_layer_number) then
!                 CASE 2: Stay in the layer
!                 print *, 'L528 NADA layer does not change'

                 else
!                 print *, 'L 531 immodpg.for unexpected case'
                 endif

              endif ! end check for change in layer

              if(option.eq.change_clip4plot_opt) then
!               print *, 'L 733 immodpg.for,change_clip4plot_opt=',
!     +         change_clip4plot_opt
!              print *, 'L 735 immodpg.for,option=',option
                   call read_clip_file(new_clip,inbound_clip)
!                   print*,'L 737 new clip is',new_clip
                   prior_clip         = current_clip
                   current_clip       = new_clip
                   clip_min           = -current_clip
                   clip_max           =  current_clip
!                   print*,'L 742 new clip is',clip_max
                   go to 10 ! start of all interactions with user

              endif

!             zoom option
!             read_moveNzoom_amount
             if( (option.ge.80)
     +            .and. (option.lt.90) ) then

!                  print *, 'L 564 immodpg.for,zoom,option=',option
                  prior_moveNzoom     = current_moveNzoom
                  current_moveNzoom   = option

                  call moveNzoom(xmin,xmax,tmin,tmax,current_moveNzoom)
                  icolor = 0
                  call pgpage
                  call pgsci(1)
                  go to 55

             endif

!            set velocity increment
!            set thickness increment
             if(option.eq.change_thickness_increment_opt) then
!              read new thickness increment value
!              call read_thickness_increment
!              print*,'L 644 new thickness_increment_m is',
!     +         new_thickness_increment_m
              prior_thickness_increment_= current_thickness_increment_m
              current_thickness_increment_m= new_thickness_increment_m
              thickness_increment_m    = current_thickness_increment_m
              thickness_increment_km  = thickness_increment_m * m2km
              go to 150  ! start of this do loop
              option = option_default
             endif

             if(option.eq.changeVincrement_opt) then
!             read new velocity increment value
               call readVincrement_file(newVincrement_mps,
     +              inboundVincrement)
!               print*,'L 655 new VIncrement is',newVincrement_mps
               priorVincrement_mps         = currentVincrement_mps
               currentVincrement_mps       = newVincrement_mps
               Vincrement_mps          = currentVincrement_mps
               VIncrement_kmps        = Vincrement_mps * m2km
               go to 150 ! start of this do loop
               option = option_default

             endif

             if(option.eq.changeVbotNtop_factor_opt) then
!             read new velocity factor value
              call readVbotNtop_factor_file(
     +               newVbotNtop_factor,inboundVbotNtop_factor)
!               print*,'L 655 new VbotNtop_factor:',newVbotNtop_factor
               priorVbotNtop_factor     = currentVbotNtop_factor
               currentVbotNtop_factor   = newVbotNtop_factor
               VbotNtop_factor          = currentVbotNtop_factor
               go to 150 ! start of this do loop
               option = option_default

             endif

!
! *** Options that require recompute
!     recomputation and replot of  X-T curves

             if(option.eq.changeVbot_upper_layer_opt) then
!             read new bottom velocity  value
               call readVbot_upper_file(newVbot_upper,inboundVbot_upper)

               priorVbot_upper         = currentVbot_upper
               currentVbot_upper       = newVbot_upper
               Vbot_upper_mps          = currentVbot_upper
               Vbot_upper_kmps       = currentVbot_upper * m2km
               VB(current_layer_number-1) = Vbot_upper_kmps
!               print*,'L786 new Vbot_upper', VB(current_layer_number-1)
!               go to 150 ! start of this do loop
               option = option_default

             endif

             if(option.eq.changeVtop_lower_layer_opt) then
!             read new bottom velocity  value
!               print*,'L794,changing Vtop_lower_layer'
               call readVtop_lower_file(newVtop_lower,inboundVtop_lower)
!               print*,'L 797 new Vtop_lower is',newVtop_lower
               priorVtop_lower         = currentVtop_lower
               currentVtop_lower       = newVtop_lower
               Vtop_lower_mps          = currentVtop_lower
                Vtop_lower_kmps          = currentVtop_lower * m2km
               VT(current_layer_number+1) = Vtop_lower_kmps
!                print*,'L803 new Vtop_lower',VT(current_layer_number+1)
!               go to 150 ! start of this do loop
               option = option_default

             endif

             if(option.eq.changeVbot_opt) then
             !             read new bottom velocity  value
               call readVbot_file(newVbot,inboundVbot)
!               print*,'L 655 new Vbot is',newVbot
               priorVbot         = currentVbot
               currentVbot       = newVbot
               Vbot_mps          = currentVbot
               Vbot_kmps          = currentVbot  * km2m
               VB(current_layer_number) = Vbot_kmps
!               go to 150 ! start of this do loop
               option = option_default

             endif

             if(option.eq.changeVtop_opt) then
!             read new bottom velocity  value
               call readVtop_file(newVtop,inboundVtop)
!               print*,'L 655 new Vtop is',newVtop
               priorVtop         = currentVtop
               currentVtop       = newVtop
               Vtop_mps          = currentVtop
               Vtop_kmps          = currentVtop * km2m
               VT(current_layer_number) = Vtop_kmps
!               go to 150 ! start of this do loop
               option = option_default

             endif
             if(option.eq.Vbot_minus_opt) then
                VB(current_layer_number) =
     +          VB(current_layer_number) - Vincrement_kmps
!                print*,'mmodpg.for,option=',Vbot_minus_opt
             endif

             if(option.eq.Vbot_plus_opt) then
                VB(current_layer_number) =
     +          VB(current_layer_number) + Vincrement_kmps
!                print*,'mmodpg.for,option=',Vbot_plus_opt
             endif

             if(option.eq.Vtop_minus_opt) then
                VT(current_layer_number) =
     +          VT(current_layer_number) - Vincrement_kmps
!                 print*,'mmodpg.for,option=',Vtop_minus_opt
             endif

             if(option.eq.Vtop_plus_opt) then
                 VT(current_layer_number) =
     +           VT(current_layer_number) + Vincrement_kmps
!                 print*,'mmodpg.for,option=',Vtop_plus_opt
             endif
!             if(option.eq.3) DZ(current_layer_number) =
!     + DZ(current_layer_number) + a1
!
             if(option.eq.VbotNVtop_minus_opt) then
                     VT(current_layer_number) =
     +         VT(current_layer_number) - Vincrement_kmps
                     VB(current_layer_number) =
     +         VB(current_layer_number) - Vincrement_kmps

!               print*,'mmodpg.for,option=',VbotNVtop_minus_opt
             endif

             if(option.eq.VbotNVtop_plus_opt) then
                     VT(current_layer_number) =
     +         VT(current_layer_number) + Vincrement_kmps
                     VB(current_layer_number) =
     +         VB(current_layer_number) + Vincrement_kmps
!               print*,'mmodpg.for,option=',VbotNVtop_plus_opt
!               print*,'mmodpg.for,option=VT',VT(current_layer_number)
!               print*,'mmodpg.for,option=VB',VB(current_layer_number)
             endif

             if(option.eq.VtopNVbot_upper_layer_minus_opt
     +         .and. current_layer_number.gt.1) then

               upper_layer_number = current_layer_number -1

               VT(current_layer_number) =
     +         VT(current_layer_number) - Vincrement_kmps

               VB(upper_layer_number) =
     +         VB(upper_layer_number) - Vincrement_kmps

              print*,'mmodpg.for,option=',VtopNVbot_upper_layer_minus_opt
              print*,'mmodpg.for,VT=',VT(current_layer_number)
              print*,'mmodpg.for,VB_upper=',VB(upper_layer_number)
              print*,'mmodpg.for,Vincrement_kmps=',Vincrement_kmps
             endif

             if(option.eq.VtopNVbot_upper_layer_plus_opt
     +         .and. current_layer_number.gt.1) then

              VT(current_layer_number) =
     +        VT(current_layer_number) + Vincrement_kmps

              VB(current_layer_number-1) =
     +        VB(current_layer_number-1) + Vincrement_kmps
!              print*,'mmodpg.for,option=',VtopNVbot_upper_layer_plus_opt
!              print*,'mmodpg.for,VT=',VT(current_layer_number)
!              print*,'mmodpg.for,VB_upper=',VB(current_layer_number-1)
!              print*,'mmodpg.for,Vincrement_kmps=',Vincrement_kmps
             endif

             if(option.eq.VbotNVtop_lower_layer_minus_opt
     +         .and. current_layer_number.lt.nl) then

              VT(current_layer_number) =
     +        VT(current_layer_number) - Vincrement_kmps

              VB(current_layer_number+1) =
     +        VB(current_layer_number+1) - Vincrement_kmps
!             print*,'mmodpg.for,option=',VbotNVtop_lower_layer_minus_opt
             endif

             if(option.eq.VbotNVtop_lower_layer_plus_opt
     +         .and. current_layer_number.lt.nl) then

              VT(current_layer_number) =
     +        VT(current_layer_number) + Vincrement_kmps

              VB(current_layer_number+1) =
     +        VB(current_layer_number+1) + Vincrement_kmps
!              print*,'mmodpg.for,option=',VbotNVtop_lower_layer_plus_opt
             endif

             if(option.eq.VbotNtop_multiply_opt) then
               VT(current_layer_number) =
     +             VbotNtop_factor * VT(current_layer_number)
               VB(current_layer_number) =
     +             VbotNtop_factor * VB(current_layer_number)
!                print*,'mmodpg.for,option=',VbotNtop_multiply_opt

             endif

             if(option.eq.change_thickness_m_opt) then
!                 print*,'mmodpg.for,option=', change_thickness_m_opt
                call read_thickness_m_file(
     +                    new_thickness_m,inbound_thickness_m)
                prior_thickness_m   = current_thickness_m
                current_thickness_m = new_thickness_m
                DZ(current_layer_number) = new_thickness_m
                go to 150 ! start of this do loop
                option = option_default
             endif

             if(option.eq.thickness_m_plus_opt) then
!                print*,'mmodpg.for,option=', thickness_m_plus_opt
               DZ(current_layer_number) =
     +         DZ(current_layer_number) + thickness_increment_km
             endif

               if(option.eq.thickness_m_minus_opt) then
!                print*,'mmodpg.for,option=', thickness_m_minus_opt
!                print*,'mmodpg.for,th_inc_km=', thickness_increment_km
               DZ(current_layer_number) =
     +         DZ(current_layer_number) - thickness_increment_km

             endif

!             if(option.eq.3) DZ(current_layer_number) =
!     +        DZ(current_layer_number) + a1

!             exit do loop + all interaction
             if(option.eq.exit_opt) then
!               print*,'exiting from immodpg.for'
!              return option file to default (= -1)
!              print*,'mmodpg.for,option=', exit_opt
              go to 255
           endif
      go to 10 ! start of all interactions with user
!          stay in do loop
           else
!              print *, 'L 528 read_yes_no_file.f,is_change=',is_change
           endif

       end do ! end of loop that detects changes in GUI

!
!	if(option.eq.10) then
!		call read_par_r4('New dp (s/km) ??',dp)
!       endif
!

!
! **************************

!     START of loop that detects changes in the GUI
!     END of first plot that will be repeated

!        if option is good then carry out the instruction
!          instruction
!             e.g., read what layer we should work on
!             read layer number
!             replot the layer in question
!             make sure instruction is complete before a new change is implemented
!        go and check to see if there is another change
!      end the loop


      icolor = 0
      call pgpage   ! clear screen
      call pgsci(1) ! set color index
!      print *, 'L 576 clear screen'

      go to 10 ! START of ALL interactions with USER

255   continue  ! leave if option_exit
!          print*,'L1047 Vtop_lower',VT(current_layer_number+1)
!          print*,'L1048 VB_upper=',VB(current_layer_number-1)
!       write modified file to a text file
       call write_model_file_text(nl,VT,VB,DZ,VST,VSB,RHOT,RHOB,
     + outbound_model_txt);
!
! write modified model to terminal
!
	write(*,*) ' '
	write(*,*) 'MODIFIED MODEL:'
	call WRIMOD2(nl,VT,VB,DZ,VST,VSB,RHOT,RHOB)
!
! write modified model to file immodpg.out
!
        OPEN(UNIT=IOUT,FILE=outbound_model_bin,STATUS='UNKNOWN',
     +  FORM='UNFORMATTED')
        do K=1,NL+1
        	write(IOUT) VT(K),VB(K),DZ(K),
     +  	VST(K),VSB(K),RHOT(K),RHOB(K)
        enddo
        CLOSE(UNIT=IOUT)
!
! write backup modified model to file immodpg.out
!
        OPEN(UNIT=IOUT,FILE=outbound_model_bin_bck,
     +  STATUS='UNKNOWN', FORM='UNFORMATTED')
        do K=1,NL+1
              write(IOUT) VT(K),VB(K),DZ(K),
     +        VST(K),VSB(K),RHOT(K),RHOB(K)
        enddo
        CLOSE(UNIT=IOUT)


! write first breaks out
!
!        OPEN(UNIT=IOUT,FILE='immodpg.XT',STATUS='UNKNOWN',
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
        write(*,*) '***     immodpg.out     ***'
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
	SUBROUTINE rdata(Amp, ntrmax, nsmax, ntr, ns,
     + Amp_min, Amp_max)
	INTEGER*4 ntrmax,n,ntr,ns
	REAL*4 Amp(ntrmax,nsmax), Amp_min, Amp_max
       character*255 inbound_bin, inbound_config
       character*40 base_file
       character*40 config_file
       character*255 set_DIR,get_DIR

      config_file  = "immodpg.config"

! define the different needed directories
      set_DIR = "IMMODPG"
      call Project_config(set_DIR,get_DIR)

!  define needed files
      inbound_config = trim(get_DIR)//"/"//config_file

!      print*,'immodpg.for,rdata,inbound_config:',inbound_config
!   read all the configuration parameters for immodpg
      call read_immodpg_config(base_file,result,inbound_config)
! define the different needed directories
      set_DIR        = "DATA_SEISMIC_BIN"
      call Project_config(set_DIR,get_DIR)
      inbound_bin    = trim(get_DIR)//"/"//trim(base_file)//".bin"
!            print*,'996immodpg.for,rdata,base_file:',trim(base_file)
!      print*,'997-immodpg.for,rdata,inbound_bin:',trim(inbound_bin)

! Read data File
      call read_bin_data (inbound_bin,ntrmax,nsmax,ntr,ns,Amp)

      Amp_min = 1e30
      Amp_max = -1e30
      do 20 i=1,ntr
         do 11 j=1,ns
            Amp_min = min(Amp(i,j),Amp_min)
            Amp_max = max(Amp(i,j),Amp_max)
 11      continue

 20   continue
!	write(*,*) 'immodpg.for,rdata, Data min,max=',Amp_min,Amp_max
!	write(*,*)
!	print*, 'immodpg.for, L 1037, rdata, finished reading data'

      END ! of subroutine
!
! ************************************************
!
	subroutine read_datxy(x,y,n,fin,iin,iwrit)
!
! Reads file containing (x,y) pairs and an arbitrary number of
! comment lines
! before these pairs. The (x,y) pairs are returned in arrays x and y.
! The
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
! Check for default file "fin".  If file does not exist, then
! ask for a file name
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
