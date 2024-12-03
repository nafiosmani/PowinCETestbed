header="IP SpaceT SupplyT OutsideT CellT Stage MIO HVAC1 HVAC2 FSS batteryDoor topcapDoor dcDoor acDoor"
for i in 3 {10..65..5}; do
  cached=$(curl -s 10.0.$1.$i:8080/feather/status/report.json)
  header="${header} \n $(echo -n 10.0.$1.$i)" 
  header="${header} $(echo -n $cached | jq -r .thermalData.spaceTemperature | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.supplyAirTemp | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(if [ $i -gt 3 ]; then echo -n n/a; else echo -n $cached | jq -r .thermalData.outsideTemperature; fi | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(if [ $i -lt 4 ]; then echo -n n/a; else echo -n $cached | jq -r .thermalData.avgCellTemperature; fi | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.thermostatStage | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.HVAC1Controls.valid | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.HVAC1Data.hvacCurrent | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.HVAC2Data.hvacCurrent | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .thermalData.fssSignals.valid | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(if [ $i -lt 4 ]; then echo -n n/a; else echo -n $cached | jq -r .doors.batteryDoorsClosed; fi | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(echo -n $cached | jq -r .doors.lowerTopcapClosed | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(if [ $i -gt 3 ]; then echo -n n/a; else echo -n $cached | jq -r .doors.dcDoorsClosed; fi | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
  header="${header} $(if [ $i -gt 3 ]; then echo -n n/a; else echo -n $cached | jq -r .doors.acDoorsClosed; fi | tr '\n' ' ' | grep --color=always -e "^" -e Dsbl_DoorChk -e Init_WaitForFirstData -e 99.9 -e 150 -e false -e EV_VentChk)"
done

echo -e $header | column -t -s' '

