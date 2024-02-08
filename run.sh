#! /bin/sh

if test -f ./logs/logis4.txt; then
	rm ./logs/logis4.txt
fi

for i in {1..30}
do
	echo execucao $i >> ./logs/logis4.txt
	SECONDS=0
	if [ "$1" = "LU" ]; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/lu.C.x | tee -a LU_Ouptut
	elif [ "$1" = "BT" ]; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/bt.C.x | tee -a LU_Ouptut
	elif [ "$1" = "FT" ]; then
		dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/ft.C.x | tee -a LU_Ouptut
	else 
		echo "No valid parameter was found! Can't run benchmark. You must tell which NPB benchmark you want to run (LU, BT, FT)"
	fi
	wait
	time=$SECONDS
	echo time: $time >> ./logs/logis4.txt
	
done
