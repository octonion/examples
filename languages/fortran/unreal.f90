program unreal
  real, external :: f

  print *,f(1,1,0.5)
  print *,f(2,2,0.5)
  print *,f(3,3,0.5)
  print *,f(4,4,0.5)
  print *,f(5,5,0.5)
  print *,f(10,2,0.70)
  print *,1-f(2,10,0.30)
  print *,f(10,10,0.70)
  
end program unreal

recursive real function f(i,j,p) result(w)
  integer :: i,j
  real :: p
  
  if (i==0) then
     w = 0.0
  else if (j==0) then
     w = 1.0
  else
     w = p*f(i-1,j,p)+(1-p)*f(i,j-1,p)
  end if

end function f
