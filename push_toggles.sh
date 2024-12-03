read -s -p "What is the password to use: " password
push () {
echo -e "\n"
sshpass -p powin ssh -oStrictHostKeyChecking=accept-new powin@10.0.$2.1 echo -e "host key checking okay for phnx $2 \n"
sshpass -p powin scp /etc/powin/toggles.csv powin@10.0.$2.1:/home/powin/toggles.csv; echo -e "pushed toggles from dragon for $2"
sshpass -p powin ssh powin@10.0.$2.1 "echo $1 | sudo -S mv ~/toggles.csv /etc/powin/toggles.csv; sudo chown tomcat8: /etc/powin/toggles.csv; sudo service tomcat8 restart"
echo -e "Done with $2"
}

export -f push
parallel -j0 -k push $password {} ::: {1..25}

password=""