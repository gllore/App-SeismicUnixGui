! ============================================================================
! Name        : read.f
! Author      :
! Version     :
! Copyright   : Your copyright notice
! Description :read a single number from a text file
! ============================================================================


      program read
          implicit none
        real :: a, c, result, line
        real,  dimension(100) :: x, y
        real,  dimension(100) :: p, q
        integer :: i

! create data
        do i=1,2
        x(i) = i * 0.1
        y(i) = i * 0.2
        end do

! output data into a file
        open(1, file = 'data1.dat', status = 'old')

            do i=1,2
                write(1,*) x(i), y(i)
            end do

        close(1)

! read data from a file
      open (unit = 2, file = "data1.dat")

      do i=1,2

      read(2,*) p(i), q(i)

      end do
      close(2)

! write data to the screen (UNIT=6)
      do i=1,2
      write(6,*) 'Line is: ', p(i), q(i)

      end do



        a = 12.0
        c = 15.0
!        result = a + c
!        print *, 'The total is ', result

      end program read

      call read_1col (a,c, sum,sumsq)
!
!      print *, 'sum is ', sum
!      print *, 'sumsq is ', sumsq
