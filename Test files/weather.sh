#!/bin/bash

# Return silinced response
res=$(curl -s https://api.punkapi.com/v2/beers?per_page=1)
# This line extracts json key values using the jq package
status=$(curl -s https://api.punkapi.com/v2/be | jq -r '.statusCode')
echo $res
echo $status

# # Example of conditinals
# Return true if a bash variable is unset or set to the empty string: if [ -z "$var" ];

# # This if statement checks for nulls and a matching number
# if [[ -n $res ]] || [[ $status == 404 ]]
# then
# echo "404 or null"
# fi


# # This if statement compares string variables to static strings
# if [[ $name =~ "Raymond" ]];
# then
# echo $name
# echo "Within IF"
# fi

# echo $name
# echo "Not in IF"