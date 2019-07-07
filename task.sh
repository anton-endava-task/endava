#!/bin/bash

START=$(date +%s.%N)			    ## Get current time at start

FOLDER=task_downloads 			    ## Making a folder for downloaded files
COUNTER=0
mkdir $FOLDER
                                            ## Making a loop that read a file with 10 websites called weblist
while read p; do
                                            ## Write the content of each website index file to a file called "index_" + numer
  wget $p -O "$FOLDER"/"index"_"$COUNTER"
  COUNTER=$((COUNTER+1))
done <weblist                               ## The result is a list of files called "index_0", "index_1" ... All in my "task_downloads" folder
                                            ## Now I`ll read all files one by one and count the lines including "href=" text 
for f in "$FOLDER"/* ## Making for loop for all files in my folder
do
  grep -r "href=" $f | wc -l > "$f"_"count" ## count the lines with "href=" and write the result to a file named source file + "_count"
done                                        ## The result is new 10 files created in the same folder called "index_0_count", "index_1_count" ...
                                            ## Now its time to delete the newly created 10 files with results
                                            ## I enter the folder with all created files, sort the list by time creation and remove the newly 10 files
cd $FOLDER
rm -f $(ls -t | head -n10)                  ## Done

END=$(date +%s.%N)			    ## Get current time at the end ot the script
DIFF=$(echo "($END - $START)" | bc)         ## Calculating execution time

echo "Time for script execution: $DIFF seconds."
