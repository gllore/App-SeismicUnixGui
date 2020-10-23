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

      open(unit=19,FILE=inbound,STATUS='OLD',FORM='UNFORMATTED')
       k=1
!       ns=1 ! temp tbd
 120   read (unit=19) (Amp(k,i), i=1,ns)
!          write(*,*)'k, i,ntr, ns,Amp(k,i)',k,i,ntr,ns,Amp(k-1,i-1)

!       ntr=1 ! temp tbd
        if(k.GE.ntr) go to 125
          k=k+1
        go to 120

125   close (unit=19)
!       print *, 'read_bin_data, finished'

      end subroutine read_bin_data
