#!/bin/bash

##  Menu for CE CLI  tools

DELAY=15

while [[ "$REPLY" != 0 ]]; do

    clear

    cat << EOM
    Please select one:

    	1. Display Lineup Feather Status
	    2. Deploy Late baseline
    	3. Deploy Late Hatchery
        4. Set Fan Speed
        5. Time Server Check
        6. UPS Config
        7. Cell Temp Ignore
        8. ATHD
        9. Swap Feather RS485 Driver
        0. Quit

EOM

read -p "Enter Selection > "
if [[ "$REPLY" =~ [0-3]$ ]]; then

    if [[ "$REPLY" == 0 ]]; then
        sleep 3
        break
    fi
    if [[ "$REPLY" == 1 ]]; then
        read -p "Which LN? > " __LN
        echo __LN | ./new_feather_test.sh
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
        echo "Deploy Late hatchery"
        sleep "$DELAY"
        continue
    fi
    if [[ "$REPLY" == 4 ]]; then
        echo "Set Fan Speed"
        sleep "$DELAY"
        break
    fi
    if [[ "$REPLY" == 5 ]]; then
        echo "Time Server Check"
        sleep "$DELAY"
        continue
    fi
    if [[ "$REPLY" == 6 ]]; then
        echo "UPS Config"
        sleep "$DELAY"
        continue
    fi
    if [[ "$REPLY" == 7 ]]; then
        echo "Cell Temp Ignore"
        sleep "$DELAY"
        continue
    fi    
    if [[ "$REPLY" == 8 ]]; then
        echo "ATHD"
        sleep "$DELAY"
        break
    fi
    if [[ "$REPLY" == 9 ]]; then
        echo "Swap Feather RS485 Drive"
        sleep "$DELAY"
        continue
    fi
else
    echo "invalid  entry." >&2
    sleep "$DELAY"
fi
done
echo "Audi 5000"
