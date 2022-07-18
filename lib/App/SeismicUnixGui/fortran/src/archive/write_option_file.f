      subroutine write_option_file(result,outbound)
         implicit none

      integer :: result
      character (len=300) :: outbound
      character (len=80) :: format

      format = "(I2)"

!      print *, 'write_option_file, outbound is: ', outbound

      open (1,file=outbound,status='old')
      write (1,*) result
      close (1)

!      print *, 'result',result

      end subroutine write_option_file
