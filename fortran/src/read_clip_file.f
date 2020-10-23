      subroutine read_clip_file(result,inbound)
         implicit none
!       read a configuration file

      real*4              :: result
      character (len=255) :: inbound, inbound_locked
      character (len=30)  :: format1
      integer             :: err_message, counter, ready

      inbound_locked=trim(inbound)//"_locked"
      format1= "(F5.1)"

!      print *, 'read_clip_file, inbound is:', trim(inbound)
!      in case inbound is of a different, but shorter length in main

10     open(status='new',unit=30,file=inbound_locked,iostat=ready)

        if (ready.eq.0) then
         open(unit=31,file=trim(inbound),status='old',
     +    iostat=err_message)

!       check whether file opens data file
         if (err_message.eq.0) then

           read (31,format1) result
!           print *, 'read_clip_file.f, result',result
           close (unit=31)

         else
          print *, 'read_clip_file.f, err_message=',err_message
!          print *, 'read_clip_file.f, counter=',counter
!         rest a little before trying again
          call sleep(1)
          go to 10
         end if
       else
!         print *, 'read_clip_file.f, locked, try again,read =',ready
         go to 10
       end if
!       remove lock file
11      close (status='delete',unit=30,iostat=err_message)
        if (err_message.ne.0) then
         go to 11
!         print *, 'read_clip_file.f, err_messg=',err_message
        end if
!       print *, 'read_clip_file, result',result

      end subroutine read_clip_file
