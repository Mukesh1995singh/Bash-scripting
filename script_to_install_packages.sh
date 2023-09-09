#!/bin/bash
#Auther=Mukesh
#Installing multiple packages
# $# stores the total number of arguments

if [[ $# -eq o ]]
then
    echo "usage; $0 pkg1 pkg2 ...."
    exit 1
fi

if [[ $(id -u) -ne 0 ]]
then
       echo "Please run with root user or root privilages"
       exit 2
fi

# $@ and $* all command line arguments

for each_pkg in $@
do
     if which $each_pkg &> /dev/null
     then
        echo "Already $each_pkg is installed"
else
        echo "Installing $each_pkg ..."
        yum install $each_pkg -y &> /dev/null
     if [[ $? -eq 0 ]]
then
       echo "Successfully installed $each_pkg pkg"
else
       echo "Unable to install $each_pkg"
     fi

  fi


done

