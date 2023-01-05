#!/bin/sh
wget https://github.com/vincentarelbundock/Rdatasets/archive/master.zip
unzip master.zip
rm master.zip
rsync -avr --delete Rdatasets-master/csv/ data/
cp -f Rdatasets-master/datasets.csv data/datasets.csv
rm -rf Rdatasets-master
find data -name *.csv | xargs gzip
