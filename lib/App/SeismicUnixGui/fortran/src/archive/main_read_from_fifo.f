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
              print *, 'file created'
       end if

       if (file_exists) then

          call read_1col(ans,inbound)
          print *, 'main, ans=', ans

          if (ans .eq. error) then

              print *, 'ignoring the answer... NADA, ans=', ans

          else
           print *, ' main, NO error OK'
          end if

       else
              print *, 'main,unexpected--file is missing'
       end if

       open(1,file=inbound,status='old')
             write(1,*) error
       close(1)
            print *, 'main,write error'

      end program main
