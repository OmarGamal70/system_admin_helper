#!/bin/bash

while :
do
  	GROUP=$(whiptail --inputbox "Enter the group name:" 8 78 --title "Add Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then . ./menu.sh; exit; fi
	awk -F: '{print $1}' /etc/group | grep -w $GROUP &>/dev/null
        if [ $? -eq 0 ]; then
                whiptail --title "Group Not valid" --msgbox "Group $GROUP already exists." 8 78
                continue
        else
            	groupadd $GROUP 
                whiptail --title "Add Group" --msgbox "Group $GROUP created successfully." 8 78
                . ./menu.sh

        fi
done

