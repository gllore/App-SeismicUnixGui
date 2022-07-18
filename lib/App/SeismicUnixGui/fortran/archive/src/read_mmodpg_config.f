      subroutine read_mmodpg_config (results,inbound)
         implicit none
!       read a configuration file

      integer :: result
      character (len=80) :: inbound, name, answer
      character (len=30) :: format1,format2,format3
      character (len=30) :: format4,format5,format6
      character (len=30) :: format7,format8,format9
      character (len=30) :: format10,format11,format12,format13
      character (len=30) :: format14,format15,format16
      character (len=5)  :: equal,previous_model,new_model
      character (len=5)  :: pre_digitized_XT_pairs,data_traces
      real               :: clip,min_t_s,max_t_s,min_x_m,max_x_m
      real              :: x_increment_m,source_depth_m,receiver_depth_m
      real               :: reducing_vel_mps,plot_min_x_m,plot_max_x_m
      real               :: plot_min_t_s,plot_max_t_s
      real               :: results(30)
      integer            :: istarting_layer

!       in case definition in main is slightly different
       pre_digitized_XT_pairs = 'no'
       data_traces = 'no'
       previous_model = 'no'
       new_model = 'no'

      format1= "(A22,2X,A1,1X,A)"
      format2= "(A11,2X,A1,1X,A)"
      format3= "(A4,2X,A1,1X,F10.6)"
      format4= "(A7,2X,A1,1X,F10.6)"
      format5= "(A7,2X,A1,1X,F13.6)"
      format6= "(A13,2X,A1,1X,F12.6)"
      format7= "(A14,2X,A1,1X,F12.6)"
      format8= "(A16,2X,A1,1X,F12.6)"
      format9=format8
      format10="(A16,2X,A1,1X,F12.6)"
      format11=format10
      format12=format10
      format13=format10
      format14= "(A14,2X,A1,1X,A)"
      format15= "(A9,2X,A1,1X,A)"
      format16= "(A14,2X,A1,1X,I2)"

      print *, 'read_mmodpg_conf, inbound is:', inbound
!      in case inbound is of a different length in main
       inbound=inbound
      open(unit=1,file=inbound,status='old')
       read (1,format1) name,equal,pre_digitized_XT_pairs
       read (1,format2) name,equal,data_traces
       read (1,format3) name,equal,clip
       read (1,format4) name,equal,min_t_s
       read (1,format5) name,equal,min_x_m
       read (1,format6) name,equal,x_increment_m
       read (1,format7) name,equal,source_depth_m
       read (1,format8) name,equal,receiver_depth_m
       read (1,format9) name,equal,reducing_vel_mps
       read (1,format10) name,equal,plot_min_x_m
       read (1,format11) name,equal,plot_max_x_m
       read (1,format12) name,equal,plot_min_t_s
       read (1,format13) name,equal,plot_max_t_s
       read (1,format14) name,equal,previous_model
       read (1,format15) name,equal,new_model
       read (1,format16) name,equal,istarting_layer

       if (pre_digitized_XT_pairs == 'yes') then
        results(1) = 1.
       else
        results(1) = 0.
       end if

       if (data_traces == 'yes') then
        results(2) = 1.
       else
        results(2) = 0.
       end if

       results(3) = clip
       results(4) = min_t_s
       results(5) = min_x_m/1000.
       results(6) = x_increment_m/1000.
       results(7) = source_depth_m/1000.
       results(8) = receiver_depth_m/1000.
       results(9) = reducing_vel_mps/1000.
       results(10) = plot_min_x_m/1000.
       results(11) = plot_max_x_m/1000.
       results(12) = plot_min_t_s
       results(13) = plot_max_t_s

         if (previous_model == 'yes') then
        results(14) = 1.
       else
        results(14) = 0.
       end if

        if (new_model == 'yes') then
        results(15) = 1.
       else
        results(15) = 0.
       end if

       if (istarting_layer >= 0.0 ) then
        results(16) = real(istarting_layer)
       print *, '1. read_mmodpg_config, starting_layer:',istarting_layer
       else
        results(16) = -1.00
      print *, '2. read_mmodpg_config, istarting_layer:',istarting_layer
       end if

       print *, 'read_mmodpg_config, pre_digitized_XT_pairs:',
     +  pre_digitized_XT_pairs
       print *, 'read_mmodpg_config, data_traces:',data_traces
       print *, 'read_mmodpg_config, clip:',clip
       print *, 'read_mmodpg_config, min_t_s:',min_t_s
       print *, 'read_mmodpg_config, min_x_m:',min_x_m
       print *, 'read_mmodpg_config, x_increment_m:',x_increment_m
       print *, 'read_mmodpg_config, source_depth_m:',source_depth_m
       print *, 'read_mmodpg_config, receiver_depth_m:',receiver_depth_m
       print *, 'read_mmodpg_config, reducing_vel_mps:',reducing_vel_mps
       print *, 'read_mmodpg_config, plot_min_x_m:',plot_min_x_m
       print *, 'read_mmodpg_config, plot_max_x_m:',plot_max_x_m
       print *, 'read_mmodpg_config, plot_min_t_s:',plot_min_t_s
       print *, 'read_mmodpg_config, plot_max_t_s:',plot_max_t_s
       print *, 'read_mmodpg_config, previous_model:',previous_model
       print *, 'read_mmodpg_config, new_model:',new_model
       print *, 'read_mmodpg_config, istarting_layer:',istarting_layer
!       result = 1
       close (unit=1)
!      if (answer == 'yes')

!      print(*), 'bingo=',result
!      end if


      end subroutine read_mmodpg_config
