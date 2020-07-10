#!/bin/sh
PATH=/usr/bin

# Ensure xmllint/libxml2-utils is installed
# Change permissions of this script to make executable - chmod +x <file_path>
# On macOS Mojava/Catalina, you will need to allow Full Disk Access to the 
# Terminal AND Cron AND (possibly) rsync in System Prefs under the Privacy Tab
# Set crontab -e job with this schedule: */1 8-18 * * 1-5



# exit when any command fails
set -e

# Log in if the sessionId is not set
if [ -z $sessionId ]
then
# Login to get session-id token
sessionId=$(curl -s 'http://demo.adcon.at/addUPI?function=login&user=playground&passwd=playground' |\
    xmllint --xpath "//response/result/string/text()" - )
echo $sessionId
else
echo "sessionId already set"
fi

# Get weather data with sessionId
resXML=$(curl -s "http://demo.adcon.at:8080/addUPI?function=getdata&session-id=${sessionId}&depth=1&id=21294")

# Check response is not empty
if [[ -z $resXML ]];
then
echo "$(date '+%Y/%m/%d %H:%M:%S'): Returned response is empty." >> error_log.txt
exit 1
fi

# Check if response contains an error, then log in again and retry, otherwise get the data values in response
if [[ $resXML == *"error"* ]];
then
echo "$(date '+%Y/%m/%d %H:%M:%S'): Server response returned an error: \n$resXML" >> error_log.txt
exit 1
fi

# Output selected data values into weather.txt file.
temp=$(echo $resXML | xmllint --xpath "/response/node/v/text()" -)
echo "weather" > weather.txt
echo "$(/bin/date '+%Y/%m/%d %H:%M:%S'): \nTemp: $temp" > /Users/raymond/Documents/personal_projects/crontab_weather/weather.txt



