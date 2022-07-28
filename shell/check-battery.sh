#! /bin/bash
# Cron sends email if there is echo print.
# need to comment out ehco parts.

# SSMTP File Path: /etc/ssmtp/ssmtp.conf
# configuration 
# UseSTARTTLS=YES
# FromLineOverride=YES
# root={EMAIL}@gmail.com
# mailhub=smtp.gmail.com:587
# AuthUser={EMAIL}@gmail.com
# AuthPass=[GMAIL_ACCESS_PASSWORD]
# hostname=[HOSTNAME]
# UseTLS=yes
OS=$(cat /etc/*-release)
if [[ $OS =~ "Ubuntu" ]]; then
        echo "Ubuntu OS"
        BATTERY_CHECK=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | cut -d ":" -f 2 | tr -d ' ' | tr -d '%')
else
        echo "somthing else"
fi

echo $BATTERY_CHECK

if [ 20 -gt $BATTERY_CHECK ]; then
        echo "There is still battery.."
else
        echo "NEED TO CHARGE!"
        sendmail { YOUR_EMAIL }  < { EMAIL_CONTENT_TXT_FILE }
fi