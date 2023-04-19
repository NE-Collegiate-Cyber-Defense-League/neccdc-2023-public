#!/bin/bash

echo ${team_number} > /team_number.txt
chmod +r /team_number.txt

hostnamectl set-hostname ${ec2_hostname}
