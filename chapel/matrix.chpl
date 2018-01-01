
  integer(kind=4)::n=2000
  real(kind=8),allocatable::a(:,:),b(:,:),c(:,:),d(:,:),e(:,:)
  real(kind=8)::alpha,beta
  integer(kind=4)::i,j,k,lda,ldb,lde
  real(kind=8)::start,finish
  
var A = Matrix(2000, 2000),
    B = Matrix(2000, 2000);
// matPlus will create a new array with an explicit type
var C = matPlus(A, B);
// Works as expected
C += A;

  allocate(a(n,n),b(n,n),c(n,n),d(n,n),e(n,n))
  alpha=1.0;beta=1.0
  lda=n;ldb=n;lde=n

  call cpu_time(start)
  call random_seed()
  do j=1, n
     do i=1, n
        call random_number(a(i,j))
        call random_number(b(i,j))
     end do
  end do
  call cpu_time(finish)
  write(unit=6,fmt=100) "The generation of two matrices takes ",finish-start," seconds."

  call cpu_time(start)
  d=0.0D0
  d=matmul(a,b)
  call cpu_time(finish)
  writeln(finish-start)
  print *,d(1000,1000)

  deallocate(a,b,c,d,e)
