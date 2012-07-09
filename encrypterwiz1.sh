#!/bin/bash
################################
##This program has no warrenty
##Author has no responsability
##Use at own risk
##@uthor Soul
##GPLv2
################################

##Overview to user
frmdata=$(yad --title "Encrypted USB Agreement" --width=600 --height=40 --text='By using this software you agree and understand that there is absolutely no warrenty given with this, and the author excepts no responsibility and you angree to indemnify the said authors and provider of this software from any and all issues, legal or otherwise that may come from your use of this software.

This software is intended to create an encrypted USB stick for your private data using the Linux Unified Key System, 256 bit AES Encryption, with a 256bit Hash.

You will be asked to provide a secure and strong password with a minimum of 8 characters, and to increase its strength it is recommended to use special characters as well.

If you wish to continue, and agree to the terms above, press continue.' \
 --button="Cancel":0 --button="Continue":1
)
choice="$?"

if [ ${choice} == 1 ]; then
	./encrypterwiz2.sh
else
	exit
fi
