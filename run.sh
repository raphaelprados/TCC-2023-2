#! /bin/sh

if test -f ./logs/logis4.txt; then
	rm ./logs/logis4.txt
fi

for i in {1..16}
do
	if test "$1" = "LU"; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4.2-MPI/bin/lu.C.x | tee -a LU
	else if "$1" = "FT"; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4.2-MPI/bin/lu.C.x | tee -a LU		
	else if "$1" = "BT"; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4.2-MPI/bin/lu.C.x | tee -a LU			
	wait
done
