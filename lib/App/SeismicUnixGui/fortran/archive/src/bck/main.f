      program main

      implicit none

      real :: ans,error
      character(len=80) :: inbound
      logical :: file_exists

!     definitions
      inbound = 'data1.dat'
      error = 99999.

!      does file exist
       inquire(file=inbound,exist=file_exists)

       print *, 'file_exists=',file_exists

      if (.not.file_exists) then
             open(1,file=inbound,status='new')
             write(1,*) error
             close(1)
             file_exists=.TRUE.
       end if

       if (file_exists) then

          call read_1col(ans,inbound)
          print *, 'main, ans=', ans

          if (ans .eq. error) then

              print *, 'ignoring. NADA ans=', ans

          else if (ans .eq. 1) then

          else
           print *, ' main unexpected value in file'
          end if

       else
             print *, 'main,unexpected file_exists'
       end if

       open(1,file=inbound,status='old')
             write(1,*) 1
       close(1)

      end program main
