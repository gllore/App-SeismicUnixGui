      subroutine read_layer_file(result,inbound)
         implicit none
!       read a configuration file

      logical :: result
      character (len=255) :: inbound
      character (len=30) :: format1
      character (len=80)  :: change

      format1= "(A)"
!      in case definition in main is slightly different
       change = 'no'

!      print *, 'read_layer_file, inbound is:', inbound
!      in case inbound is of a different, but shorter length in main
      inbound=inbound
      open(unit=1,file=inbound,status='old')
       read (1,format1) change

       if (change == 'yes') then
        result = .TRUE.
       else
        result = .FALSE.
       end if

!       print *, 'read_layer_file, change:',change
!       print *, 'read_layer_file, result',result
       close (unit=1)

      end subroutine read_layer_file
