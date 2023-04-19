#!/bin/bash

TEAM_COUNT=18
OFFSET=1 # Set to 1 when team zero not setup

for (( i=0+$OFFSET ; i<$TEAM_COUNT ; i++ ));  do
  echo $i
  sed "s/XXXX/$i/g" example.ini > inventory.txt
  # sleep 3
  ansible-playbook linux_box.yaml
done
