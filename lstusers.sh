#!/bin/bash


USERS=$( cat /etc/passwd | cut -d: -f1 )
echo "Users:\n$USERS" > users.txt
whiptail --scrolltext --textbox users.txt 30 80
. ./menu.sh

