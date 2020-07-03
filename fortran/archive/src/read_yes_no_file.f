      subroutine read_yes_no_file(result,inbound1)
         implicit none
!       read a configuration file

      logical :: result
      character*255 inbound1,inbound
      character (len=30) :: format1
      character (len=80)  :: change

      format1= "(A)"
!      in case definition in main is slightly different
      change = 'no'
      inbound=inbound1

      print *, 'read_yes_no_file,inbound=', inbound
!      in case inbound is of a different, but shorter length in main

      open(unit=1,file=inbound,status='old')
       read (1,format1) change

       if (change == 'yes') then
        result = .TRUE.
       else
        result = .FALSE.
       end if

       print *, 'read_yes_no_file, change:',change
       print *, 'read_yes_no_file, result',result
       close (unit=1)

      end subroutine read_yes_no_file
