#! /bin/bash
OS=$(cat /etc/*-release)
if [[ $OS =~ "Ubuntu" ]]; then
        echo "Ubuntu OS"
        BATTERY_CHECK=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | cut -d ":" -f 2 | tr -d ' ' | tr -d '%')
else
        echo "somthing else"
fi

echo $BATTERY_CHECK

if [ 20 -gt $BATTERY_CHECK ]; then
        echo "NEED TO CHARGE!"
else
        echo "There is still battery.."
        sendmail { YOUR_EMAIL }  < { EMAIL_CONTENT_TXT_FILE }
fi