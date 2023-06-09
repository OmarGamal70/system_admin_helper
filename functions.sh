#!/bin/bash

#You can find the functions that run the program here.

#################################### functions for modify user ###########################################################
function chid {
while :
do
	ID=$(whiptail --inputbox "Enter the new UID:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
	awk -F ":" '{print $3}' /etc/passwd | grep -w $ID $>/dev/null

	if [ $? -eq 0 ]; then
		whiptail --title "Duplicated" --msgbox "This UID already exists." 8 78
                continue
	elif [ $(($ID)) -lt 1000 ]; then
		whiptail --title "Not Valid" --msgbox "Enter id grater than 1000." 8 78
                continue
	else
		usermod -u $ID $USERNAME
		whiptail --msgbox "User ID of user $USERNAME was changed successfully." 8 78
		break
	fi
done
. ./menu.sh
}


function chusername {
while :
do

	NEW_USER=$(whiptail --inputbox "Enter the New Username:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	awk -F ":" '{print $1}' /etc/passwd | grep -w $NEW_USER &>/dev/null
	if [ $? != 0 ]; then
                usermod -l $NEW_USER $USERNAME
			if [ $? -eq 0 ];then
				whiptail --msgbox "$USERNAME changed to $NEW_USER successfully." 8 78
			else
				whiptail --msgbox "Operation Not Done." 8 78
			fi
                break

        else
		whiptail --title "Not Exist" --msgbox "This Username is already exist enter another one." 8 78
                continue

        fi
done
. ./menu.sh
}


function comment {
while :
do
	COMMENT=$(whiptail --inputbox "Enter the comment you want to add:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        if [ -z $COMMENT ]; then

                whiptail  --msgbox "Please Enter a Comment." 8 78
                continue
        else
                usermod -c $COMMENT $USERNAME
                whiptail  --msgbox "Comment Changed Successfully." 8 78
                break
        fi

done
. ./menu.sh
}


function chhome {
while :
do
	LOC=$(whiptail --inputbox "Enter The New Path Home Directory" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
	if [[ $LOC == /* ]]; then
		usermod -d $LOC $USERNAME &>/dev/null
		whiptail --msgbox "Home directory of user $USERNAME was changed successfully." 8 78
		break
	else
		whiptail --msgbox "Enter a Valied absolute path." 8 78
		continue
	fi
done

. ./menu.sh
}


function chgrep {
while :
do
	if [ $? != 0 ]; then break; exit; fi
	GROUP=$(whiptail --inputbox "Enter The Group you want to add the user to" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	awk -F ":" '{print $1}' /etc/group | grep -w $GROUP &>/dev/null
	if [ $? != 0 ]; then
		whiptail --msgbox "The Group not Found, Enter a Valid Group." 8 78
                continue
	else
		usermod -g $GROUP $USERNAME
		whiptail --msgbox "The Group of user $USERNAME is changed successfully to $GROUP." 8 78
		break
	fi

done

. ./menu.sh
}


function expiry {
while :
do
	DATE=$(whiptail --inputbox "Enter The expire date sparated by - like 2020-05-29:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
	date -d $DATE >/dev/null 2>&1;
	if [ $? != 0 ]; then
		whiptail --msgbox "Please enter a valid date." 8 78
		continue
	else
		usermod -e $DATE $USERNAME
		if [ $? != 0 ]; then
			whiptail --msgbox "this date not vaild enter another valid date." 8 78
                        continue

		else
			whiptail --msgbox "Expiry date of user $USERNAME updated successfully." 8 78
                        break

		fi
	fi
done

. ./menu.sh
}


function shell {
while :
do
	SHEL=$(whiptail --inputbox "Enter The shell you want to change to user $USERNAME:" 8 78 --title "Modify User" 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then break; exit; fi
	awk -F ":" '{print $1}' /etc/shells | grep -w $SHEL &>/dev/null
	if [ $? -eq 0 ]; then
		usermod -s $SHEL $USERNAME &>/dev/null
		whiptail --msgbox "The Shell of user $USERNAME changed successfully." 8 78
		break
	else
		whiptail --msgbox "This is not a valid shell.\nIt must start with'/'." 8 78
		continue
	fi
done

. ./menu.sh
}
################################### _End_of_modify_user_function_ #####################################################
#modify groups functions

function adduser
{
while :
do 
        user=$(whiptail --inputbox "Enter the user name you want to add to group:" 8 78 --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        id $user &>/dev/null
        if [ $? != 0 ]; then
                whiptail --title "Error" --msgbox "The User you entered ($user) does not exist!!" 8 78
                continue
        else
            	gpasswd $GROUPNAME -a $user &>/dev/null
                if [ $? != 0 ]; then
                        whiptail --title "Error" --msgbox "The User you entered ($user) can't be added!!\nNote it must be one user at a time!!" 8 78
                        continue
                else
                    	whiptail --msgbox "User ($user) was added to group ($GROUPNAME) successfully." 8 78
                        break
                fi
        fi
done
}


function rmuser
{
while :
do 
        user=$(whiptail --inputbox "Enter the user name you want to remove from group:" 8 78 --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
    	id $user &>/dev/null
        if [ $? != 0 ]; then
                whiptail --title "Error" --msgbox "The User you entered ($user) does not exist!!" 8 78
                continue
        else
            	gpasswd $GROUPNAME -d $user &>/dev/null
		if [ $? != 0 ]; then
			whiptail --title "Error" --msgbox "The User you entered ($user) is not a member of this group ($GROUPNAME)!!" 8 78
                	continue
		else
			whiptail --msgbox "User ($user) was removed from group ($GROUPNAME) successfully." 8 78
                        break
		fi
        fi
done

}


function chmember
{
while :
do 
        members=$(whiptail --inputbox "Enter the new list of members of group $GROUPNAME (comma seperated):" 8 78 --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then break; exit; fi
        gpasswd $GROUPNAME -M $members &>/dev/null
        if [ $? != 0 ]; then
                whiptail --title "Error" --msgbox "Make sure user/users you entered all exist!!\nMake sure users are comma seperated!!" 8 78
                continue
        else
                whiptail --msgbox "Memberlist of group ($GROUPNAME) was changed successfully to ($members)." 8 78
                break
        fi
done
}
