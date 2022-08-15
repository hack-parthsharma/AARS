#!/bin/bash


if [[ -z "$1" ]] 
then
    echo "Usage: bash A.A.R.S <IP>"
    exit 1

fi


if [[ $EUID -eq 0 ]];then

      echo "------------------------------------------------------------------------------------------"
      echo "------------------------------------------------------------------------------------------"

      printf "Doing checks......COMPLETED\n\n"
      printf "\nLoading Programs.....COMPLETED\n\n"
      printf "\nTargetting the IP....COMPLETED\n\n"
      printf "\nFinishing up.....COMPLETED\n"
      
    
    echo "------------------------------------------------------------------------------------------"
    echo "------------------------------------------------------------------------------------------"
    printf "\n"
    
else
    echo "Please run me with sudo"
    exit
fi

echo "A.A.R.S" | figlet -f slant 
echo "============================================"
echo "The Advanced Automated Reconnaissance Script"
echo "============================================"

printf "\n\n"
echo "-------------------------------"
echo "-------------------------------"
echo "STARTING A.A.R.S"
echo "-------------------------------"
echo "-------------------------------"

printf "\n\n"

echo "-------------------------------"
echo "-------------------------------"
echo "$1 - IP TARGETED"
echo "-------------------------------"
echo "-------------------------------"

printf "\n\n\n"


echo "Do you wish to run nmap? y\n"
read nmap

if [[ "$nmap" == "y" ]]; then

     printf "\n===========NMAP===========\n\n" >> results


     echo "------------------------------------------------------------------------------------------"
     echo "------------------------------------------------------------------------------------------"
     echo "RUNNING NMAP....." 
     echo "------------------------------------------------------------------------------------------"
     echo "------------------------------------------------------------------------------------------"

     nmap -sS -sC -A -O -sV  $1 >> results

else 
   printf "\nSkipping Nmap\n\n"
   

fi

printf "\n\n\n"

echo "Do you wish to run GoBuster? y/n"
read gb

if [[ "$gb" == "y" ]]
then
echo "------------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------------------------------"
echo "Gobuster is running"
echo "------------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------------------------------"

printf "\n\n\n"

echo "------------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------------------------------"
echo "This process might take some time, if you feel like it is running long enough, press CTRL+C"
echo "------------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------------------------------"

printf "\n============The search begins===============\n\n"
 

gobuster dir -u $1 -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -qz > temp1

printf "\n============The search is over==============\n\n"


 else 
     printf "\n"
     echo "Skipping GoBuster"
     printf "\n"

fi

echo "Do you wish do run WhatWeb? y/n"
read WhatWeb

  if [[ "$WhatWeb" == "y" ]]
  then
     
     printf "\n"
     
     echo "------------------------------------------------------------------------------------------"
     echo "------------------------------------------------------------------------------------------"
     echo "RUNNING WHATWEB...."
     echo "------------------------------------------------------------------------------------------"
     echo "------------------------------------------------------------------------------------------"
     
     printf"\n"
     
     whatweb $1 -v > temp2
     
     
      else 
      printf "\n"
       echo "Skipping WhatWeb"
      printf "\n"
  fi
  
  
  echo "Do you wish do run ENUM4LINUX? y/n"
read enum4linux

  if [[ "$enum4linux" == "y" ]]
  then
    
     printf "\n"
     
     echo "------------------------------------------------------------------------------------------"
     echo "------------------------------------------------------------------------------------------"
     echo "RUNNING ENUM4LINUX...."
     echo "------------------------------------------------------------------------------------------"
     echo "------------------------------------------------------------------------------------------"
     
     printf "\n"
     
     enum4linux -U $1 > temp3
     
     
      else 
      printf "\n"
       echo "Skipping ENUM4LINUX"
      printf "\n"
  fi
  


if [ -e temp1 ]
then
        printf "\n==========OPEN DIRECTORIES==========\n\n" >> results
        cat temp1 >> results
        rm temp1
fi

if [ -e temp2 ]
then
    printf "\n==============WEB-INFO==================\n\n" >> results
        cat temp2 >> results
        rm temp2
fi

if [ -e temp3 ]
then 
    printf "\n==============ENUM4LINUX===============\n\n" >> results
       cat temp3 >> results
       rm temp3
       
fi

cat results

rm results

