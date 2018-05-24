#!/bin/bash

DIR="/data"
LOG="${DIR}/json.log"
JSON="https://www.teamspeak.com/versions/server.json"
JSON_FILE="${DIR}/server.json"
CHECK_FILE="${DIR}/CHANGELOG"
TSVERSION=`cat $CHECK_FILE |grep "Server Release" | head -1 | awk '{print $4}'`

wget -q $JSON -P $DIR

cat $JSON_FILE | jq '.linux.x86_64.mirrors' >> $LOG

url=`cat $LOG | grep 4Netplayers.de`
url=${url##*\"4Netplayers.de\":}
url=${url%%,*}
url=$(echo "$url" | sed 's/\"//g')
NEWVERSION=${url##*-}
NEWVERSION=${NEWVERSION%.tar*}

rm $JSON_FILE $LOG

echo $NEWVERSION
