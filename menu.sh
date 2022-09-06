#!/bin/bash
#Chunxia Pang 041061913 pang0064@algonquinlive.com


function line() {
	for ((i=0; i<$1; i++))
	do
		echo -n '*'
	done
	echo
}

function pause() {
	echo
	read -p 'Press enter to continue'
}

clear
line 40
echo
choice=Start

while [[ ${choice::1} != 'Q' ]]
do
#Display our menu list
	echo 'Enter your choice'
	echo '(P)rint your user information'
	echo '(F)ind the information'
	echo "(C)opy a readme file to a user's home"
	echo "(L)ist the files in a directory for a specific group"
	echo "(Q)uit the program"

	read choice
	choice=${choice^^}

	echo
	line 40

	# echo "Your choice is $choice"
	case ${choice::1} in
		Q) echo "Have a great day! $username" ;;
		P) grep $name /ect/passwd
		   pause
		   ;;

		F) read -p 'Enter a user name:' targetname
		   echo
		   
		   if [[ $(grep -iw $targetname /etc/passwd) ]]
		   then
			   echo "The entry for ${targetname,,} is:"
			   grep -iw $targetname /etc/passwd
		   else
			   echo "${targetname,,} does not live here, try another house."
		   fi

		   echo
		   pause
		   ;;

		C) read -p 'Enter a user name: ' targetname
		   echo

		   if [[ $(grep -iw $targetname /etc/passwd) ]]
		   then

			   read targetdirectory < <(grep -iw $targetname /etc/passwd | cut -d':' -f 6)

			   echo "Target Directory: $targetdirectory/."
			   echo "Copying file......"

			   sudo cp ./readme.txt "$targetdirectory/."
		   else
			   echo "${targetname,,} does not live here, sorry about that."
		   fi

		   echo
		   pause
		   ;;

		 L) read -p 'Enter the group name: ' groupname
		    echo

		    if [[ ! $(grep -i $groupname /etc/group) ]]
		    then
			    echo "Sorry $groupname is not a group."
		    else
			    read -p 'Enter the path to check:' targetdirectory
			    echo
			    if [[ ! -e $targetdirectory ]]
			    then
				    echo "$targetdirectory does not exist???"
			    else
				    echo "Checking..."
				    echo

				    while read -a listingline
				    do
					    if [[ ${listingline[3]} == $groupname ]]
					    then
						    echo ${listingline[@]}
					    fi

				    done < <(ls -l)
			    fi
		    fi

		    echo
		    pause
		    ;;
    esac
done




