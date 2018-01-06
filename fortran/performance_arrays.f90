! performance_arrays.f90 --
!
!     Example belonging to "Modern Fortran in Practice" by Arjen Markus
!
!     This work is licensed under the Creative Commons Attribution 3.0 Unported License.
!     To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/
!     or send a letter to:
!     Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
!
!     Simple program to determine the performance differences between
!     using array-valued functions and ordinary do-loops
!
program performance_arrays
    implicit none

    real, dimension(:), allocatable :: data
    real                            :: threshold, mean1, mean2, difference
    real                            :: meansum
    integer                         :: i, j, nodata, norepeat
    integer                         :: time1, time2, time3
    integer, dimension(6)           :: time_pack
    integer, dimension(6)           :: time_do

    threshold  = 0.1
    nodata     = 1
    norepeat   = 1000
    do i = 1,6
        nodata = nodata * 10
        allocate( data(1:nodata) )

        call random_number( data )

        difference = 0.0
        meansum    = 0.0
        call system_clock( time1 )
        do j = 1,norepeat
            call mean_pack( pack( data, data > threshold ), mean1 )
            meansum = meansum + mean1
        enddo

        call system_clock( time2 )
        do j = 1,norepeat
            call mean_do_loop( data, threshold, mean2 )
            meansum = meansum + mean2
        enddo
        call system_clock( time3 )

        time_pack(i) = time_pack(i) + (time2-time1)
        time_do(i)   = time_do(i)   + (time3-time2)

        difference   = difference + abs(mean1-mean2)

        deallocate( data )
    enddo

    write( *, '(i10,2i10)' ) ( 10**i, time_do(i), time_pack(i), i = 1,6 )
    write( *, '(a,e12.4)' )    'Mean difference: ', difference / 600.0
contains
subroutine mean_pack( data, mean )
    real, dimension(:) :: data

    real               :: mean

    mean = sum(data)/max(1,size(data))

end subroutine mean_pack

subroutine mean_do_loop( data, threshold, mean )
    real, dimension(:) :: data
    real               :: threshold
    real               :: mean

    integer            :: i
    integer            :: count

    mean  = 0.0
    count = 0
    do i = 1,size(data)
        if ( data(i) > threshold ) then
            mean  = mean  + data(i)
            count = count + 1
        endif
    enddo

    mean = mean / max(1,count)

end subroutine mean_do_loop
end program
