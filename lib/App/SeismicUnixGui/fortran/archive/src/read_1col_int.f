      subroutine read_1col_int (result,inbound)
         implicit none

      integer :: result
      character (len=80) :: inbound

!      print *, 'read_1col_int, inbound is:', inbound
!      in case inbound is of a different length in main
       inbound=inbound
      open(unit=1,file=inbound,status='old')
      read (1,*) result
!              print *, 'read_1col_int, result',result
      close (unit=1)

      end subroutine read_1col_int
