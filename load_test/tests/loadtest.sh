#!/bin/bash
TIP_FILE=/var/www/load_test_in_progress

touch $TIP_FILE

# Warm up the server
ab -t 10 http://web/

# Run the benchmark
ab -c 5 -t 50 -g /var/www/benchmark.tsv http://web/

cd /var/www
gnuplot < /tests/gnuplot_script

rm $TIP_FILE
