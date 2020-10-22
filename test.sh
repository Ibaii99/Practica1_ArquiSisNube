#!/bin/bash 
	 for N in 100 500 1000 5000 10000 50000
	 do
		for C in 1 5 10 50 100 500 1000
		do
			echo "Testing -n $N -c $C..."
			ab -n $N -c $C http://192.168.0.160/ &> test-$N-$C.log
		done
	done
