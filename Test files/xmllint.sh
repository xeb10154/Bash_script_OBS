# Login to get session-id
res=$(curl -s 'http://demo.adcon.at/addUPI?function=login&user=playground&passwd=playground
')

# XML response test - url must be in quotes if contains ampersands
# This url has function=getconfig
res=$(curl -s 'http://demo.adcon.at:8080/addUPI?function=getconfig&session-id=da22c215-8cfd-4695-b2c9-ad1a6d50a037&depth=1&id=142')

# This url has function=getdata - this returns the actual values
res=$(curl -s 'http://demo.adcon.at:8080/addUPI?function=getdata&session-id=da22c215-8cfd-4695-b2c9-ad1a6d50a037&depth=1&id=21294')


# Breakdown of curl command
first=$(echo $res | xmllint --xpath "//response/node/nodes/node[1]" -)
second=$(echo $res | xmllint --xpath "//response/node/nodes/node[2]" -)

echo $first
echo $second

# echo $res | xmllint --xpath "//response/node/nodes[last()]/text()"


# Now use xmllint to break down the response $res
# install lib on mac - brew install libxml2 (should already be installed on mac)
# install lib on linux - sudo apt-get install libxml2-utils