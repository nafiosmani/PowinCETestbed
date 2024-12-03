# ~Forward~
#
# 1) Purpose
# This script is used by ___ in order to ____ on the ___
#
# 2) Parameters (in order)
#
# Standard Use
# $1 
#
# 3) Resulting actions
#
# 4) Outputs
#

for $1 in {1..2}; do for $2 in {1..18}; do for $3 in {1..14}; do for $4 in {1..30}; do curl http://10.0.1.1:8080/turtle/tools/controls/bms/array/$1/string/$2/bp/$3/cg/$4/ignorecellgrouptemp/on; done; done; done; done
