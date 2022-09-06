#!/bin/bash
PATH=/bin:/usr/bin ; export PATH
umask 022

#echo "input: $#: $*"

if [ "$#" -ne 2 -a "$#" -ne 3 ] ; then
	echo 1>&2 "$0: Argument Error: the number of argument should be 2 or 3!"
	exit 1;
elif [ "$#" -eq 2 ] ; then
	sign='*'
else
	sign="$3"
fi	
#echo "$sign"
if [ "$2" -gt 80 ] ; then
	echo 1>&2 "$0: Shanpe would exceed the width of the terminal"
	exit 1;
fi
case "$1" in 
	's' | 'square')
		for ((i=0;i<$2;i++))
		do
		for ((j=0;j<$2;j++))
			do
			echo -n "$sign"
			done
			echo
		done 
		;;
	'l' | 'line')
		for ((i=0;i<=$2;i++))
		do
			echo -n "$sign"
		done
		echo
		;;
	't' | 'tripple')
		for ((i=1;i<=$2;i++))
		do
			for ((j=1;j<=$i;j++))
			do
				echo -n "$sign"
			done
			echo
		done
		;;
	*)
		echo 1>&2 "$0:Error: unknown shape!"
		exit 1;

esac
