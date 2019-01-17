#! /bin/bash
git clone https://github.com/vincentarelbundock/Rdatasets
rsync -arcv  Rdatasets/csv/ ./
rm -rf Rdatasets
