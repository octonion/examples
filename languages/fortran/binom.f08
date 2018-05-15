module binom
  implicit none

  integer, parameter :: iknd = selected_int_kind(36)
  ! 36 is necessary for very large n and k, integer(kind=8) wasn't enough!

  integer(iknd) :: mm(100,100)

contains

  recursive function combo(n,k) result(cmb)
    integer(kind=iknd) :: cmb
    integer(kind=iknd), intent(in) :: n,k

    if (k == n) then
        cmb = 1
    else if (k == 1) then
        cmb = n
    else if (mm(n,k) /=0)  then
        cmb = mm(n,k)
    else if ((k /= 1) .and. (k /= n)) then
        cmb = combo(n-1,k-1) + combo(n-1,k)
        mm(n,k) = cmb
    end if      
  end function

end module

program fctrecur
  use binom

  implicit none

  integer(kind=iknd) i,j

  print *, "What is n?"
  read *, i

  print *, "What is k?"
  read *, j

  print *,combo(i,j)
  print *,combo(i,j)

end program fctrecur
