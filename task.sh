#!/bin/bash

start_timer=$(date +%s.%2N)		    		              ## Starting StopWatch

folder=task_downloads 			    		
counter=0
mkdir $folder 		   			       
while read line; do			    		                    ## Reading website names from the file
  wget $line -O "$folder"/"index"_"$counter"        ## Create a file storing web content
  counter=$((counter+1))
done <weblist                               		
                                            		
for file in "$folder"/* 		    		                ## Create a file storing the number of matches found
do
  grep "href=" $file | wc -l > "$file"_"count"	
done							
                                            		
cd $folder                                  		
rm $(ls -t | head -n10)                     		    ## Remove newer 10 files

end_timer=$(date +%s.%2N)			    	
diff=$(echo "($end_timer - $start_timer)" | bc)     	

echo "Time for script execution: $diff seconds."    ## Printing execution time
