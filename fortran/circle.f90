MODULE Circle
  !---------------------------------------------------------------------
  !
  !  Module containing definitions of variables needed to
  !  compute the area of a circle of radius r
  !
  !---------------------------------------------------------------------
  REAL, PARAMETER :: Pi = 3.1415927
  REAL :: radius
END MODULE Circle

PROGRAM Area
  !---------------------------------------------------------------------
  !
  !  This program computes the area of a circle given the input radius
  !
  !  Uses:  MODULE Circle
  !         FUNCTION Area_Circle (r)
  !
  !---------------------------------------------------------------------
  USE Circle, ONLY : radius
  IMPLICIT NONE

  INTERFACE 
     FUNCTION Area_Circle (r)
       REAL, INTENT(IN) :: r
     END FUNCTION Area_Circle
  END INTERFACE

  !  Prompt user for radius of circle
  write(*, '(A)', ADVANCE = "NO") "Enter the radius of the circle:  "
  read(*,*) radius

  ! Write out area of circle using function call
  write(*,100) "Area of circle with radius", radius, " is", &
       Area_Circle(radius)
100 format (A, 2x, F6.2, A, 2x, F11.2)

END PROGRAM Area

!-----Area_Circle----------------------------------------------------
!
!  Function to compute the area of a circle of given radius
!
!---------------------------------------------------------------------
FUNCTION Area_Circle(r)
  USE Circle, ONLY : Pi

  IMPLICIT NONE
  REAL :: Area_Circle
  REAL, INTENT(IN) :: r

  Area_Circle = Pi * r * r

END FUNCTION Area_Circle
