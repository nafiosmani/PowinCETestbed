#!/bin/bash
password="powin"
username="powin"
for i in {1..17}; do
  # Construct the full IP address
  ip="10.0.$i.1"
  # Use sshpass to run the command on the remote host
echo "$ip"
sshpass -p "$password" scp -o StrictHostKeyChecking=no /etc/powin/configuration.json $username@$ip:~/
sshpass -p "$password" ssh $username@$ip "echo $password | sudo -S mv ~/configuration.json /etc/powin/ && echo $password | sudo -S systemctl restart tomcat8"
echo "done"
done