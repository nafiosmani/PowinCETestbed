!/bin/bash
pcb=$1
lineup=$2

for i in {1..36..1};
do
    curl http://10.0.0.3:8080/turtle/tools/controls/ems/array/$lineup/string/$i/reset/pcb/$pcb
    sleep 0.1
done
