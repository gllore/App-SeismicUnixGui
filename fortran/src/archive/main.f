      program main

      implicit none

      real :: ans,error
      character(len=80) :: inbound
      logical :: file_exists
      integer :: sleep_time_s, i=0

!     definitions
      inbound = '.mmodpg_switch'
      error = 99999.
      sleep_time_s =1 

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


           do while (file_exists)

               call sleep(sleep_time_s)
                i=i+1
                print *, 'count=',i
                   call read_1col(ans,inbound)
                   print *, 'main, ans=', ans

                   if (ans .eq. error) then

                      print *, 'ignoring the answer... NADA, ans=', ans

                   else
                         print *, ' main, NADA'
                   end if

!               open(1,file=inbound,status='old')
!                     write(1,*) error
!               close(1)
!                    print *, 'main,write error'
          end do

      end program main
