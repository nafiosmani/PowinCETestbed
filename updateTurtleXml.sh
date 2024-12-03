#!/bin/bash

password="powin"

for i in {1..21}; do

ip="10.0.$i.1"

echo "$ip"

# ssh 10.0.$1.1 "echo powin | sudo -S cp ~/turtle.xml /var/lib/tomcat8/conf/Catalina/localhost/"

sshpass -p $password scp -o StrictHostKeyChecking=no turtle.xml powin@$ip:~/
sshpass -p $password ssh -o StrictHostKeyChecking=no -t $ip "echo $password | sudo -S  chown tomcat8:tomcat8 turtle.xml && echo $password | sudo -S mv turtle.xml /var/lib/tomcat8/conf/Catalina/localhost/ && echo $password | sudo -S systemctl restart tomcat8"

echo "done"

done

