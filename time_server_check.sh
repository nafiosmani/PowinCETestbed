#!/bin/bash

read -p "Enter the Number of ES per Line Up : " energy_seg 

ES_IP=$((($energy_seg - 1) * 5 + 10))
sequence=(3 $(seq 10 5 $ES_IP))
 
for i in ${sequence[@]}; do
    lineup="10.0.$1.$i"
    echo "Checking $lineup..."
    
    # Get the remote date
    remote_date=$(sshpass -p moxa ssh -o StrictHostKeyChecking=no "moxa@$lineup" "date")

    # Get the local date
    local_date=$(date)

    # Compare the dates and make necessary changes
    if [ "$remote_date" != "$local_date" ]; then
        echo "Dates do not match on $lineup:"
        echo "Feather Date : $remote_date"
        echo "EMS Date     : $local_date"
        echo "Modifying /etc/resolv.conf..."
        sshpass -p moxa ssh -o StrictHostKeyChecking=no "moxa@$lineup" "echo moxa | sudo -S sed -i 's/nameserver.*/nameserver 10.0.0.1/' /etc/resolv.conf" 
        echo ""
        echo "Starting ntpd"
        sshpass -p moxa ssh -o StrictHostKeyChecking=no "moxa@$lineup" "echo moxa | sudo -S ntpd"
        echo ""
        #Reboot the feather
        echo "Rebooting $lineup..."
        sshpass -p moxa ssh -o StrictHostKeyChecking=no "moxa@$lineup" "echo moxa | sudo -S reboot"
    fi
done

