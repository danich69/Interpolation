module interpolate
	implicit none
	contains
	
		subroutine interpolation(arg,func,x,y,n)
		
			integer :: n
			integer :: i, j, k
			real, dimension (n) :: arg, func							! interpolation grid
			real :: x,y													! input x, y=L(x)
			real :: basis_pol											! basis polynoms of Lagrange method
			y=0
			
			do i=1,n
				basis_pol=1
				do j=1,n
					if(i /= j) then
						basis_pol=basis_pol*(x-arg(j))/(arg(i)-arg(j))	! calcilation of basis ploynoms
					endif
				enddo
			y=y+func(i)*basis_pol										! calcilation of Langrange ploynom for x
			enddo
			
		end subroutine interpolation
		
end module interpolate
