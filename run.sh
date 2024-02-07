#! /bin/sh

for i in {1..16}
do
	if test "$1" = "LU"; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/lu.C.x | tee -a LU
	elif "$1" = "FT"; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/ft.C.x | tee -a FT		
	elif "$1" = "BT"; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/bt.C.x | tee -a BT			
	else
 		echo "Condition missing: benchmarkd not identified (LU, BT, FT)
 	fi
done
