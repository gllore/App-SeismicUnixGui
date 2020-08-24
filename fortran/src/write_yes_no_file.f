      subroutine write_yes_no_file(yes_or_no,outbound)
         implicit none
      character*5 yes_or_no
      character (len=255) :: outbound
      character (len=30)  :: format1
      integer :: err_message

!      print *, 'write_yes_or_no_file, outbound is: ', outbound


      format1= "(A)"
      open (2,file=outbound,status='old',iostat=err_message)

 !       check whether file opens
       if (err_message == 0) then
        write (2,format1) trim(yes_or_no)
!        print *, 'write_yes_or_no_file, yes_or_no: ',trim(yes_or_no)
        close (2)
       else
        print *, 'write_yes_no_file.f, err_message=',err_message
       end if
!      print *, 'yes_or_no:',trim(yes_or_no)

      end subroutine write_yes_no_file
