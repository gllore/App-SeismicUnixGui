      subroutine read_1col (result,inbound)
         implicit none

      real :: result
      character (len=80) :: inbound

!      print *, 'read_1col, inbound is: ', inbound

      open (1,file=inbound,status='old')
      read (1,*) result
      close (1)

!      print *, 'result',result

      end subroutine read_1col
