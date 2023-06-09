#!/bin/bash

while :
do
	GROUP=$(whiptail --inputbox "Enter the group name:" 8 78 --title "Delete Group" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
	awk -F: '{print $1}' /etc/group | grep -w $GROUP &>/dev/null
	if [ $? -eq 0 ]; then
		groupdel "$GROUP"
		whiptail --msgbox "Group $GROUP deleted successfully" 8 78
		. ./menu.sh
	else
		whiptail --msgbox "The group you entered is not exist!" 8 78
		. ./menu.sh
	fi
done
