#!/bin/bash

while :
do
	USERNAME=$(whiptail --inputbox "Enter Username:" 8 39  --title "Change Password" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then . ./menu.sh; exit; fi
	id $USERNAME &>/dev/null
	if [ $? -eq 0 ]; then
		PASS=$(whiptail --passwordbox "please enter the new password for user $USERNAME:" 8 78 --title "Chnage Password" 3>&1 1>&2 2>&3)
		echo $PASS | passwd --stdin $USERNAME &>/dev/null
		whiptail --msgbox "Password of user $USERNAME was changed successfully!" 8 78
		. ./menu.sh
	else
		whiptail --title "Error" --msgbox "The user is't exist\nPlease enter username correctly." 8 78
		. ./menu.sh
	fi

done
