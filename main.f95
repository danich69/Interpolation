program in_out
	use interpolate
	implicit none

	real(4), dimension(:), allocatable :: argument_value, function_value! x(i) and f(x(i))
	real(4) :: a, b, h 													! main interval
	real(4) :: t, pi
	real(4) :: x, y														! x - current argument, y - L(x)
	integer :: N, i, j, k 												! N - number of intervals
	character*9 :: data_type
	
	
	call getarg(1, data_type)
	
	if(data_type=='chebyshev') then
		open ( unit=1, file='chebyshev.dat')
		open ( unit=2, file='res_chebyshev.dat',status='REPLACE')
	else
		if(data_type=='uniform') then
				open ( unit=1, file='uniform.dat')
				open ( unit=2, file='res_uniform.dat',status='REPLACE')
		else
			write(*,*) 'Wrong input format! Try again!'
			call abort
		endif
	endif
	
	read(1,'(2x,I6)') N	    	                            			!read number of intervals
	read(1,*) a,b	
	
	allocate( argument_value(N+1), function_value(N+1))
	
	
	do i=1,N+1
		read(1,*) function_value(i)										!read input function values
	enddo
	
	if(data_type=='uniform') then										!generating uniform grid
		h=(b-a)/(N)
		do i=1,N+1
			argument_value(i)=a+h*(i-1)
		enddo
	else																!generating chebyshev grid
		
		pi=4*ATAN(1.d0)
		
		do i=1,N+1
		    t=real(2.0*i-1.0)/real((2.0*N+2))*pi
			argument_value(i)=(a+b)/2-cos(t)*(b-a)/2
		enddo
	endif
	
	
	h=(b-a)/(100*N)
	
	do i=1, 100*N+1
	
		x=a+h*(i-1)
		call interpolation(argument_value,function_value,x,y,N+1)		!call interpolation subroutine
		write(2,*) x, y
		
	enddo
	
	
	deallocate(argument_value,function_value)
	
	close(1)
	close(2)

end program in_out
