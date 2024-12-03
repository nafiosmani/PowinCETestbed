#!/bin/bash
lineup=$1
for i in 3 {10..95..5}; 
do
  sshpass -p moxa scp -o StrictHostKeyChecking=no ./modpoll/arm-linux-gnueabihf/modpoll moxa@10.0.$lineup.$i:~/
  sshpass -p moxa ssh -o StrictHostKeyChecking=no -t moxa@10.0.$lineup.$i "echo moxa | sudo -S service tomcat8 stop"
  sshpass -p moxa ssh -o StrictHostKeyChecking=no -t moxa@10.0.$lineup.$i "echo moxa | sudo -S sed -i 's#value=\"\"#value=\"10.0.'$lineup'.'$((i+1))'\"#' /var/lib/tomcat8/conf/Catalina/localhost/feather.xml" 
  sshpass -p moxa ssh -o StrictHostKeyChecking=no -t moxa@10.0.$lineup.$i "echo moxa | sudo -S /home/moxa/modpoll -b 9600 -p none -a 51 -r 6 -c 1 -1 -0 /dev/ttyUSB0 21"
  sshpass -p moxa ssh -o StrictHostKeyChecking=no -t moxa@10.0.$lineup.$i "echo moxa | sudo -S service tomcat8 start"
done
