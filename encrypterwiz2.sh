#!/bin/bash
################################
##This program has no warrenty
##Author has no responsability
##Use at own risk
##@uthor Soul
##GPLv2
################################

##Creates Form GUI with YAD (Yet Another Dialogue)
frmdata=$(yad --title "Password Entry Form" --form --field="Password:H")

##extract strings from the form and set them to vars 
PASSWORD=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $1 }')

##set variables
score=0
charCount=0

##sets regular expressions to static variables
readonly re_digit='[[:digit:]]'
readonly re_lower='[[:lower:]]'
readonly re_punct='[[:punct:]]'
readonly re_space='[[:space:]]'
readonly re_upper='[[:upper:]]'

##checks password for requirements and increases score if met
for re in "$re_digit" "$re_lower" "$re_punct" "$re_space" "$re_upper"
do
    [[ ${PASSWORD} =~ $re ]] && let score++
done

##check is password is more that 8 characters
charCount=$(echo ${PASSWORD} | wc -m)

##creates $finalScore if $score met min of 8 chars is met
if [ ${charCount} -ge 9 ]; then
	finalScore=`expr $score + 3`
fi

##recommend more than 8 characters
if [ ${charCount} -le 8 ]; then
	zenity --info --text="Password to short to provide good encryption".
fi

##output rating of the score.
##Had to declare variables in this way as YAD's documentation sucks>_>
if [ ${finalScore} -ge 8 ]; then
woot=$(yad --title "Password Rating" \
--text='Good Password'\
  --button="New Password":0 --button="Continue":1)
choice="$?" 
        if [ ${choice} == 1 ] ;then
                cryptsetup luksFormat /dev/sdb1 -c aes -s 256 -h sha256 $PASSWORD
        elif [ ${choice} == 0 ]; then
                ./encrypterwiz2.sh
        fi
elif [ ${finalScore} -ge 7 ]; then
woot=$(yad --title "Password Rating" \
--text='Okay Password'\
  --button="New Password":0 --button="Continue":1)
choice="$?"
        if [ ${choice} == 1 ] ;then
                cryptsetup luksFormat /dev/sdb1 -c aes -s 256 -h sha256 $PASSWORD
        elif [ ${choice} == 0 ]; then
                ./encrypterwiz2.sh
        fi
elif [ ${finalScore} -ge 6 ]; then
woot=$(yad --title "Password Rating" \
--text='Weak Password'\
  --button="New Password":0 --button="Continue":1)
choice="$?"
        if [ ${choice} == 1 ] ;then
                cryptsetup luksFormat /dev/sdb1 -c aes -s 256 -h sha256 $PASSWORD
        elif [ ${choice} == 0 ]; then
                ./encrypterwiz2.sh
        fi
elif [ ${finalScore} -ge 5 ]; then
woot=$(yad --title "Password Rating" \
--text='Poor Password'\
  --button="New Password":0 --button="Continue":1)
choice="$?"
        if [ ${choice} == 1 ] ;then
                cryptsetup luksFormat /dev/sdb1 -c aes -s 256 -h sha256 $PASSWORD
        elif [ ${choice} == 0 ]; then
                ./encrypterwiz2.sh
        fi
elif [ ${finalScore} -le 4 ]; then
woot=$(yad --title "Password Rating" \
--text='Abysmal Password'\
  --button="New Password":0 --button="Continue":1)
choice="$?"
        if [ ${choice} == 1 ] ;then
                cryptsetup luksFormat /dev/sdb1 -c aes -s 256 -h sha256 $PASSWORD
        elif [ ${choice} == 0 ]; then
                ./encrypterwiz2.sh
        fi
fi
