---


---

<h1 id="endava-junior-devops-challenge">Endava Junior Devops Challenge</h1>
<h2 id="task-description">Task description</h2>
<ol>
<li>Create public git repository</li>
<li>Chose your favorite scripting language and create script that will do the following</li>
</ol>
<ul>
<li>Save the content of 10 random websites index pages to 10 files</li>
<li>Count number of matching lines with the string “href=” in each of the 10 files</li>
<li>Save result of “href=” matches in new 10 files, using logical naming convention</li>
<li>Delete the newly created 10 files with results</li>
<li>Measure execution time</li>
</ul>
<ol start="3">
<li>Commit the code in the repository</li>
<li>Send us link to it!</li>
</ol>
<p>Dont forget to document it properly!</p>
<h1 id="slution">Slution</h1>
<p>In this repository you can see two files:</p>
<ul>
<li>a text file <strong>weblist</strong></li>
<li>a bash script <strong><a href="http://task.sh">task.sh</a></strong></li>
</ul>
<p><strong>weblist</strong> is a file that contains a list of 10 random websites</p>
<pre><code>https://linuxacademy.com
https://docs.ansible.com
https://github.com
https://bitbucket.org
https://lucidchart.com
https://jenkins.io
https://aws.amazon.com
https://kubernetes.io
https://docker.com
https://apache.org
</code></pre>
<p><strong><a href="http://task.sh">task.sh</a></strong> is the script that complete point 2 from the <strong>Endava Junior Devops Challenge</strong></p>
<pre><code>#!/bin/bash

start_timer=$(date +%s.%2N)

folder=task_downloads
counter=0
mkdir $folder
while read line; do
  wget $line -O "$folder"/"index"_"$counter"
  counter=$((counter+1))
done &lt;weblist
                                            		 
for file in "$folder"/*
do
  grep -r "href=" $file | wc -l &gt; "$file"_"count"
done
export PATH="$PATH":"$PWD"

cd $folder                                  		
rm -f $(ls -t | head -n10)                  		

end_timer=$(date +%s.%2N)			    	
diff=$(echo "($end_timer - $start_timer)" | bc)     	

echo "Time for script execution: $diff seconds."
</code></pre>
<h3 id="what-we-need-to-do-to-run-the-scrip-correctly">What we need to do to run the scrip correctly?</h3>
<ul>
<li>We need root privilege</li>
<li>We need <strong><a href="http://task.sh">task.sh</a></strong> and <strong>weblist</strong> in the same folder</li>
<li><code>export PATH="$PATH":"$PWD"</code> If your current dirrectory is not a part of $PATH</li>
</ul>
<h3 id="what-we-expect-as-output">What we expect as output?</h3>
<p>You can watch web content downloading:<br>
<img src="https://lh3.googleusercontent.com/w7zJcw5ubw6jWnnvZqWEY6y9-2Y8pu7dtdh4hWpbJo8bS8wFppIonyhnwdoV2-8aPm-BCu7MilKG" alt="enter image description here" title="task-BASH output"></p>
<p>After the script finish the job you can see measured execution time<br>
<img src="https://lh3.googleusercontent.com/9I1UR7qPtvSZKGrdfogH5WiP0-QQ1BZBYNyXvFts9IU6ZtZ56WnHXbqrwqFoQakg-afrDEYBCdDv" alt="enter image description here"></p>
<p>If you list the current directory you can see a new folder <strong>“task_downloads”</strong> appeared.</p>
<pre><code>ls -al
</code></pre>
<p><img src="https://lh3.googleusercontent.com/0PYz0PMNTLz_iuaa9NHpixHyq5n8oLTdMekYoe50xxwdaTy5EST10zPGUqVJotggxwOdYzltXMkc" alt="enter image description here"></p>
<p>If you list that directory you can see 10 files named <strong>“index_0 - index_9”</strong>.<br>
ls -al task_downloads/</p>
<p><img src="https://lh3.googleusercontent.com/dhl9_fCuSTw24ey76QZ7j3jYrPEir-2-5FGRM7hLdgRwj52ymG3nTGzbVawazhCaiTMr9jJSNpvN" alt="enter image description here"></p>
<p>If you skip the part of the script that delete newer 10 files created,</p>
<pre><code>#rm -f $(ls -t | head -n10)
</code></pre>
<p>you can see 10 more files named <strong>“index_0_count - index_9_count”</strong> that store the count of lines included the text <strong>"href="</strong><br>
<img src="https://lh3.googleusercontent.com/0Y36tjG7KLNILCiZrNbM2oR_2oSx6QlYVUBWtbYLQJUvwCyh1cwG1q0b3tIL-yq-XSKlhR0RiyuB" alt="enter image description here"></p>

