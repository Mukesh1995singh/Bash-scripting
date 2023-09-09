#!/bin/bash

which wget 1>/dev/null 2>/dev/null

if [$? -ne 0 ]
then
   echo "Please install wget and retry"
   exit 1
fi
if [ -e "index.html" ]
then
   echo "removing old index.html"
   rm -rf index.html
fi

url="https://mirrors.edge.kernel.org/pub/software/scm/git/"
wget $url
if [ $? -ne 0 ]
then
   echo "Unable to download git info from $url"
   exit 2
fi

line="<a href="git-0.01.tar.gz">git-0.01.tar.gz</a>"
declare -a git_vers
echo "**************** Please wait collecting all git version from official website git-scm *****************"
while read line
do
  git_vers+=($(echo $line | sed -n '/git-\([0-9]\+\.\)\+tar.gz/p' | awk -F '"' '{ print $2 }' | cut -c 5- | awk -F '.tar.gz' '{ print $1 }'))
  #sleep 1
done < index.html

echo "The all available git versions are:"
cnt=0
no_vers=${#git_vers[*]}
WIDTH=20
for each_var in ${git_vers[*]}
do
   #echo -e "\t\t ${git_vers[$cnt]} \\t ${git_vers[$((cnt+1))]} \\t ${git_vers[$((cnt+2))]}"
   printf "%-*s %-*s %-*s\n" $WIDTH ${git_vers[$cnt]} $WIDTH ${git_vers[$((cnt+1))]} $WIDTH ${git_vers[$((cnt+2))]}
   cnt=$((cnt+3))
   if [ $cnt -ge $no_vers ]
   then
      break
   fi
done

