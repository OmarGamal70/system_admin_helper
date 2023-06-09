#!/bin/bash

#the function used here is in functions.sh

. ./functions.sh

MOD=$(whiptail --title "Modify options for user $USERNAME " --ok-button "Select" \
 --cancel-button "Exit" --menu "Choose an option" \
 15 100 8 \
"UID" "The unique ID of the user." \
"Login Name" "The username of the user." \
"Comment" "The comment added to the user." \
"Change Home" "The User's login directory." \
"Change Group" "The Group of the user." \
"Expire Date" "The date on which the user acount will be disabled." \
"Shell" "The path of the user's new login shell." \
3>&1 1>&2 2>&3)

if [ $? != 0 ]; then . ./menu.sh; exit; fi

while :
do
	USERNAME=$(whiptail --inputbox "Enter the username:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then . ./menu.sh; exit; fi
	id $USERNAME &>/dev/null
	if [ $? -eq 0 ] 
	then
		case $MOD in
		"UID")  chid; exit ;;
                "Login Name")  chusername; exit ;;
		"Comment")  comment; exit ;;
		"Change Home")  chhome; exit ;;
		"Change Group")  chgrep; exit ;;
		"Expire Date")  expiry; exit ;;
		"Shell")  shell; exit ;;
		*) whiptail --title "Error" --msgbox "Please run the program agin" 8 78
		esac
			. ./menu.sh
	else
		whiptail --title "NOT FOUND!!" --msgbox "There is no such user\nPlease enter username correctly." 8 78
	fi
done



