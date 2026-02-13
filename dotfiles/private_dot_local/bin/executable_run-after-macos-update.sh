#!/usr/bin/env bash
#

UUID=$(uuidgen)
TEMP_FILE="/tmp/$UUID.tmp"
touch "$TEMP_FILE"

echo "Applying sudo_local pam file allowing Touch ID for sudo."
echo "Please provide your password for sudo."
cat /etc/pam.d/sudo_local.template | sed 's/#auth/auth/g' > $TEMP_FILE
sudo cp $TEMP_FILE /etc/pam.d/sudo_local

rm $TEMP_FILE
