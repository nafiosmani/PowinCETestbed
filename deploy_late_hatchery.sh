#sshpass -p moxa scp -oStrictHostKeyChecking=no -r moxa@10.0.2.20:~/hatchery/ ./
sshpass -p moxa scp -oStrictHostKeyChecking=no -r ./hatchery/ moxa@$1:~/
newIologikIp=$(echo $1 | awk -F. '{print $1}').$(echo $1 | awk -F. '{print $2}').$(echo $1 | awk -F. '{print $3}').$(($(echo $1 | awk -F. '{print $4}') +1))
sshpass -p moxa ssh -t moxa@$1 "cd hatchery; sed -i \"s/401/$2/\" fourbaidentity.json"
sshpass -p moxa ssh -t moxa@$1 "cd hatchery; sed -i \"s/401/$2/\" feather.json"
sshpass -p moxa ssh -t moxa@$1 "cd hatchery; sed -i \"s/10.0.4.4/$newIologikIp/\" feather.xml"
sshpass -p moxa ssh -t moxa@$1 "cd hatchery; echo moxa | sudo -S ./hatchery_configure_feather_powin.sh"
sshpass -p moxa ssh -t moxa@$1 "cd hatchery; echo moxa | sudo -S ./hatchery_install_war.sh feather.war feather.xml"
sshpass -p moxa ssh -t moxa@$1 "echo moxa | sudo -S service tomcat8 restart"
