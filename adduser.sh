#!/bin/bash

while :
do
	NEW_USER=$(whiptail --title "Create New User" --inputbox "Enter username you want to create" 8 40 3>&1 1>&2 2>&3)
	if [ $? != 0 ]
	 then
	  . ./menu.sh; exit;
	fi
	id $NEW_USER &>/dev/null
	if [ $? -eq 0 ]
	 then
	  whiptail --title "User Exist" --msgbox "User already exists try to enter another user." 8 40 
	  continue
	 else
	  break
	fi
done
#PASSWORD=$(whiptail --passwordbox "Set the password:" 8 40 --title "Create New User" 3>&1 1>&2 2>&3)
useradd $NEW_USER
PASSWORD=$(whiptail --title "SET PASSWORD" --passwordbox "Choose a strong password" 8 40 3>&1 1>&2 2>&3)
echo $PASSWORD | passwd $NEW_USER --stdin &>/dev/null
whiptail --msgbox "User $NEW_USER created successfully!" 8 40
. ./menu.sh
