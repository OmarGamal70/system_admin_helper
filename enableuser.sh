#!/bin/bash

while :
do
	USERNAME=$(whiptail --inputbox "Enter the username:" 10 60 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then . ./menu.sh; exit; fi
        id $USERNAME &>/dev/null
        if [ $? -eq 0 ]; then
		usermod -U $USERNAME
                whiptail --title "Enable User" --msgbox "User $USERNAME was enabled successfully." 10 60
                . ./menu.sh
        else
            	whiptail --title "Error" --msgbox "The user is't exist\nPlease enter a valid username." 8 78
        	. ./menu.sh
	fi

done
