#!/bin/bash

while :
do
	USERNAME=$(whiptail --inputbox "Enter the username:" 8 78 --title "Delete User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then . ./menu.sh; exit; fi
	id $USERNAME &>/dev/null
	if [ $? -eq 0 ]; then
		CHOOSE=$(whiptail --title "Delete User" --menu "Choose an option for deleting user $USERNAME" 25 78 16 \
		"Delete" "Delete the user & it's home directory but user must be logged out first" \
		"Force Delete" "Delete the user & it's home directory even if the user is still logged in." 3>&1 1>&2 2>&3)

		if [ $? != 0 ]; then . ./menu.sh; exit; fi

		case $CHOOSE in
		"Delete")
	 		userdel -r $USERNAME &>/dev/null ;;
		"Force Delete")
			userdel -f $USERNAME &>/dev/null ;;
		esac
		whiptail --msgbox "User $USERNAME was deleted successfully!" 8 78
		. ./menu.sh
	else
		whiptail --title "Error" --msgbox "This User is't exist\nPlease enter username correctly." 8 78
		. ./menu.sh
	fi

done
