#! /bin/sh

if test -f ./logs/logis4.txt; then
	rm ./logs/logis4.txt
fi

for i in {1..30}
do
	echo execucao $i >> ./logs/logis4.txt
	SECONDS=0
	dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/lu.C.x | tee -a Lu_output.txt
	wait
	time=$SECONDS
	echo time: $time >> ./logs/logis4.txt
	
done
