#!/bin/bash


while :
do
	USERNAME=$(whiptail --inputbox "Enter the username: " 8 39  --title "Disable User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi
	id $USERNAME &>/dev/null
	if [ $? -eq 0 ]; then
		usermod -L $USERNAME
		whiptail --title "Disable User" --msgbox "User $USERNAME Disabled successfully." 8 78
		. ./menu.sh
	else
		whiptail --title "Error" --msgbox "User is not exist\nPlease enter a valid username." 8 78
		. ./menu.sh
	fi
done
