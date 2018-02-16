module MOD
contains
  subroutine SUB(a,b)
    implicit none
    integer :: a
    integer, optional :: b
    integer :: b_aux
    
    if (.NOT. present(b)) then
       b_aux=0
    else
       b_aux=b
    end if
    print*, a,b_aux
  end subroutine SUB
end module MOD

program TEST
  use MOD
  implicit none

  integer :: i=2, j=1

  call SUB(i,j)
  call SUB(i)
  call SUB(j)

end program TEST
