wget https://github.com/vincentarelbundock/Rdatasets/archive/master.zip
unzip master.zip
rm master.zip
rsync -avr Rdatasets-master/csv/ data/
# symlink can cause a error in Windows
rm data/car
cp -f Rdatasets-master/datasets.csv data/datasets.csv
rm -rf Rdatasets-master
