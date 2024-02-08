#! /bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <benchmark>"
    exit 1
fi

# Remove the log file if it exists
if [ -f ./logs/logis4.txt ]; then
    rm ./logs/logis4.txt
fi

# Define output file based on the benchmark
output_file=""
case "$1" in
    LU)
        output_file="LU_Output.txt"
        ;;
    BT)
        output_file="BT_Output.txt"
        ;;
    FT)
        output_file="FT_Output.txt"
        ;;
    *)
        echo "Invalid benchmark. Supported benchmarks: LU, BT, FT"
        exit 1
        ;;
esac

# Execute the benchmark 30 times
for ((i = 1; i <= 30; i++)); do
    echo "Execution $i" >> ./logs/logis4.txt
    SECONDS=0
    dmtcp_launch --join-coordinator mpirun -np 4 ./NPB3.4.2/NPB3.4-MPI/bin/"$1".C.x | tee -a "$output_file"
    time=$SECONDS
    echo "Time: $time" >> ./logs/logis4.txt
done
