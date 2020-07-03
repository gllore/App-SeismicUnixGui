      subroutine read_1col (result,inbound)
         implicit none

      integer :: result
      character (len=80) :: inbound

!      print *, 'read_1col, inbound is:', inbound

!      in case inbound is of a different length in main
       inbound=inbound
      open(unit=1,file=inbound,status='old')
      read (1,*) result
!        print *, 'result',result
!      all small numbers are considered numerical inaccuracies
      if (result .LT. 1) then
       result =0
       print *, 'result',result
      end if
      close (unit=1)

      end subroutine read_1col
