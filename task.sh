#!/bin/bash

FOLDER=task_downloads
COUNTER=0

mkdir $FOLDER

while read p; do

  wget $p -O "$FOLDER"/"index"_"$COUNTER"
  COUNTER=$((COUNTER+1))

done <weblist

for f in "$FOLDER"/*
do
  grep -r "href=" $f | wc -l > "$f"_"count"
done


##$(ls -t | head -n1)
cd $FOLDER
ls -alt
rm -f $(ls -t | head -n10)

##rm $(ls -Art /"$FOLDER"/ | tail -n +5)
