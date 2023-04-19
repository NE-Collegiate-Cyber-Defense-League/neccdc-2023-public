#!/bin/bash

echo ${team_number} > /team_number.txt
chmod +r /team_number.txt

sed -i 's/XXXX/${team_number}/g' /templates/inventory
