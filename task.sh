#!/bin/bash

start_timer=$(date +%s.%2N)		    		## Get current time at start

folder=task_downloads 			    		## Making a folder for downloaded files
counter=0
mkdir $folder 		   			        ## Making a loop that read a file with 10 websites called "weblist"
while read line; do			    		## Write the content of each website index file to a file called "index_" + numer
  wget $line -O "$folder"/"index"_"$counter"
  counter=$((counter+1))
done <weblist                               		## The result is a list of files called "index_0", "index_1" ... All in my "task_downloads" folder
                                            		## Now I`ll read all files one by one and count the lines including "href=" text 
for file in "$folder"/* 		    		## Making for loop for all files in my folder
do
  grep -r "href=" $file | wc -l > "$file"_"count"	## Count the lines with "href=" and write the result to a file named "source file name" + "_count"
done							## The result is new 10 files created in the same folder called "index_0_count", "index_1_count" ...
                                            		## Now its time to delete the newly created 10 files with results
cd $folder                                  		## I enter the folder with all created files, sort the list by time creation and remove the newly 10 files
rm -f $(ls -t | head -n10)                  		## Done

end_timer=$(date +%s.%2N)			    	## Get current time at the end ot the script
diff=$(echo "($end_timer - $start_timer)" | bc)     	## Calculating execution time

echo "Time for script execution: $diff seconds."
