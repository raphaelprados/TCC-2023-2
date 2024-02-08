#! /bin/sh

if test -f ./logs/logis4.txt; then
	rm ./logs/logis4.txt
fi

output_file=""

case "$1" in
	lu)
		output_file = "Lu_output.txt"
		;;
	bt)
		output_file = "Bt_output.txt"
		;;
	ft)
		output_file = "Ft_output.txt"
		;;
	*)
		echo "No valid parameter was found! Can't run benchmark. You must tell which NPB benchmark you want to run (LU, BT, FT)"
		exit 1
		;;
esac

for((i = 1; i <= 32; i++)); do
	echo execucao $i >> ./logs/log"$1".txt
	SECONDS=0
	dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/"$1".C.x | tee -a "$output_file"
	time=$SECONDS
	echo time: $time >> ./logs/log"$1".txt
done
