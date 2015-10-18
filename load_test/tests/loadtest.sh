#!/bin/bash
ab -t 60 -g /var/www/benchmark.tsv http://web/

cd /var/www
gnuplot < /tests/gnuplot_script 
