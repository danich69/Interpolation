do: prog
	./prog
chebyshev: prog
	./prog chebyshev
uniform: prog
	./prog uniform
prog: main.o interpol.o
	gfortran -O2 $^ -o $@
main.o: main.f95 interpolate.mod
	gfortran -O2 -c $^
interpolate.mod interpol.o: interpol.f95
	gfortran -O2 -c $^
create: cr
	./cr
cr: create.f95
	gfortran -O2 $^ -o $@
uni:
	gnuplot plot_un.gnu
che:
	gnuplot plot_ch.gnu
clean:
	rm -f *.o *mod cr prog
