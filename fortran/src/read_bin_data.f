      subroutine read_bin_data(inbound_bin,ntrmax,nsmax,ntr,ns,Amp)
         implicit none
!       read a configuration file

      character (len=255) :: inbound_bin, inbound, inbound_locked
      integer*4      :: ntrmax,nsmax,ntr,ns,k,i
      real*4         :: Amp(ntrmax,nsmax)
      integer        :: err_message, counter, ready

!      trim end and adjustl start of empty spaces
      inbound=trim(adjustl(inbound_bin))
!      print *, 'read_bin_data, inbound is:',inbound,'--'
       inbound_locked=trim(inbound)//"_locked"
!       print *, 'read_bin_data, inbound_locked is:',inbound_locked,'--'
!      create a temporary, new, lock file
10     open(status='new',unit=19,file=inbound_locked,iostat=ready)
!       print *, 'read_bin_data.f,inbound_locked iostat:',ready
!       if (ready.eq.17) print *, 'locked, try again'
       if (ready.eq.0) then
        open(UNIT=20,FILE=inbound_bin,STATUS='OLD',IOSTAT=err_message,
     +   FORM='UNFORMATTED')
!        counter = counter +1
         err_message =0
!       check whether file opens data file
        if (err_message.eq.0) then
         k=1
!        ns=1 ! temp tbd
 120     read (unit=20) (Amp(k,i), i=1,ns)
!          write(*,*)'k, i,ntr, ns,Amp(k,i)',k,i,ntr,ns,Amp(k-1,i-1)

!        ntr=1 ! temp tbd
         if(k.GE.ntr) go to 125
          k=k+1
         go to 120
!        print *, 'read_bin_data.f, result',result
 125     close (unit=20)

        else
!         print *, 'read_bin_data.f, err_message=',err_message
!         print *, 'read_bin_data.f, counter=',counter

!         rest a little before trying again
!         call sleep(1)
           go to 10
        end if
       else
         print *, 'read_bin_data.f,locked, try again,read =',ready
         go to 10
       end if
!       remove lock file
11     close (status='delete',unit=19,iostat=err_message)
!          print *, 'read_bin_data.f, err_messg=',err_message
        if (err_message.ne.0) then
         go to 11
         print *, 'read_bin_data.f, err_messg=',err_message
        end if
!       print *, 'read_bin_data, finished'

      end subroutine read_bin_data
