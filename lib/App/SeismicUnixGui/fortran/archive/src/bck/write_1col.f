      subroutine write_1col(result,outbound)
         implicit none

      real :: result
      character (len=80) :: outbound

!      print *, 'read_1col, outbound is: ', outbound

      open (1,file=outbound,status='old')
      read (1,*) result
      close (1)

!      print *, 'result',result

      end subroutine write_1col
