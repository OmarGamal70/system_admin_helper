#!/bin/bash

. ./functions.sh

while :
do
	GROUPNAME=$(whiptail --inputbox "Enter the group name:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then . ./menu.sh; exit; fi
	cut -d : -f1 /etc/group | grep $GROUPNAME  &>/dev/null
	if [ $? -eq 0 ]; then
		MOD=$(whiptail --title "Modify options for group $GROUPNAME " --ok-button "Select" \
       		 --cancel-button "Exit" --menu "Choose an option" \
       		 15 100 8 \
       		 "Add User" "Add a user to the group." \
       		 "Remove User" "Remove a user from the group." \
       		 "Chg Members" "Change whole Memberlist of the group." \
       		 3>&1 1>&2 2>&3)

		 if [ $? != 0 ]; then . ./scripts/main-menu.sh; exit; fi

        	 case $MOD in
        	 "Add User")  adduser; modifyg; exit ;;
        	 "Remove User")  rmuser; modifyg; exit ;;
        	 "Chg Members")  chmember; modifyg; exit ;;
       		 *) whiptail --title "Strange Error!!" --msgbox "Please Re-run the program." 8 78
        	esac
	else
		whiptail --title "Error" --msgbox "There is no such Group!!\nPlease enter group name correctly." 8 78
		continue
	fi
done
