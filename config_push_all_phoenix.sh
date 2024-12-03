#!/bin/bash
password="powin"

for i in {1..20}; do

ip="10.0.$i.1"

echo $ip

sshpass -p powin scp -o StrictHostKeyChecking=no /etc/powin/configuration.json powin@$ip:/home/powin/
sshpass -p powin ssh -o StrictHostKeyChecking=no -t $ip "echo $password | sudo chown tomcat8:tomcat8 configuration.json && sudo mv configuration.json /etc/powin/configuration.json &&  sudo systemctl restart tomcat8"

echo "done"

done
