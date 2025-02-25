#!/bin/bash

password="powin"
username="powin"

# A for loop to iterate from BMS 1 to n with increment 1
for i in {1..2};
do
  #Construct the full IP address
  ip="10.0.$i.1"
  
  echo "$ip"
  
  #ssh into the BMS(Phoenix) and restart tomcat8 service
  sshpass -p "$password" ssh $username@$ip "echo $password | sudo -S systemctl restart tomcat8"
  
  echo "done"
done
