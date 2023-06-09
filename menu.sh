#!/bin/bash


action=$(whiptail --title "Menu" --menu "Choose an option" \
25 100 11 \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"Delete User" "Delete an existing user." \
"Disable User" "Lock the user account." \
"Enable User" "Unlock the user account." \
"Change Password" "Change passsword of a user." \
"List Users" "List all users on the system." \
"Add Group" "Add a user group to the system." \
"Modify Group" "Modify a group and its list of members." \
"Delete Group" "Delete an existing group." \
"List Groups" "List all groups on the system." \
3>&1 1>&2 2>&3)

case $action in
"Add User")  ./adduser.sh; exit ;;
"Modify User")  ./moduser.sh; exit ;;
"Delete User")  ./deluser.sh; exit ;;
"Enable User")  ./enableuser.sh; exit ;;
"Disable User")  ./disableuser.sh; exit ;;
"Change Password")  ./chpass.sh; exit ;;
"List Users")  ./lstusers.sh; exit ;;
"Add Group")  ./addgrp.sh; exit ;;
"Modify Group")  ./modgrp.sh; exit ;;
"Delete Group")  ./delgrp.sh; exit ;;
"List Groups")  ./lstgrps.sh; exit ;;
*) whiptail --title "Error!!" --msgbox "Thank you for using our program\nCreated by Omar Gamal." 8 78 ;;
esac
