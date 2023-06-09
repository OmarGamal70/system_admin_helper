#!/bin/bash


GRP=$(awk -F: '{print $1}' /etc/group )
echo "Groups:\n$GRP" > groups.txt
whiptail --scrolltext --textbox groups.txt 30 80 
. ./menu.sh
