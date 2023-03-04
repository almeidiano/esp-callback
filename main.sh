#!/bin/bash

show_all_options() {
clear
PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}

check_http_code () {
	echo "Loading..."
	CURL_RESPONSE=$(curl -s -o /dev/null -s -w "%{http_code}\n" $1)
	
	if [[ $CURL_RESPONSE == 200 ]]; then
		echo "Type your usernick"
		read -p "nick: " nick
		echo "Now type your password"
		read -p "pass: " pass

		JSON_DATA="{\"nick\": \"$nick\", \"pass\": $pass}"
		curl -X POST $url -H "Content-Type: application/json" -d "$JSON_DATA"
	else
		 echo "Unable to connect to the entered URL. HTTP RESPONSE CODE ${CURL_RESPONSE}"
	fi
}

echo Type the webserver URL to connect to:
read url
if [[ $url == *"http://"* || $url == *"https://"* ]]; then 
	check_http_code $url
else
	new_url="http://"$url
	check_http_code $url
fi	
