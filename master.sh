#!/bin/bash

##  Menu for CE CLI  tools

DELAY=15

while [[ "$REPLY" != 0 ]]; do

    clear

    cat << EOM
    Please select one:

        0. Quit
    	1. Display Lineup Feather Status
	2. Deploy Late baseline
    	3. Datanab
        4. 
EOM

read -p "Enter Selection > "
if [[ "$REPLY" =~ [0-3]$ ]]; then

    if [[ "$REPLY" == 0 ]]; then
        sleep "$DELAY"
        break
    fi
    if [[ "$REPLY" == 1 ]]; then
        ./new_feather_test.sh
        sleep "$DELAY"
        continue
    fi
    if [[ "$REPLY" == 2 ]]; then
        read -p "What is the IP address of the feather? > " _feather_ip
        echo $_feather_ip | ./deploy_late_baseline.sh
        sleep "$DELAY"
        continue
    fi
    if [[ "$REPLY" == 3 ]]; then
        echo "do some other stuff"
        sleep "$DELAY"
        continue
    fi
else
    echo "invalid  entry." >&2
    sleep "$DELAY"
fi
done
echo "Audi 5000"
