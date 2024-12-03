mainHeader="IP SpaceT SupplyT OutsideT CellT Stage MIO HVAC1 HVAC2 FSS_Alarm FSS_Trouble batteryDoor topcapDoor dcDoor acDoor"
check_cs () {
  header=""
  cached=$(curl -s 10.0.$1.3:8080/feather/status/report.json)
  header="${header} \n $(echo -n 10.0.$1.3)" 
  header="${header} $(echo -n $cached | jq -r .thermalData.spaceTemperature | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.supplyAirTemp | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.outsideTemperature | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n n/a | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.thermostatStage | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.HVAC1Controls.valid | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.HVAC1Data.hvacCurrent | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99\.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.HVAC2Data.hvacCurrent | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99\.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.fssSignals.fssAlarm | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e true -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.fssSignals.fssTrouble | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e true -e EV_VentChk)"
  header="${header} $(echo -n n/a | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .doors.lowerTopcapClosed | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .doors.dcDoorsClosed | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .doors.acDoorsClosed | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  echo $header
}

export -f check_cs


echo -e $(echo $mainHeader) $(parallel -j0 -k check_cs {} ::: {1..3}) | column -t -s' '
