#!/bin/bash


UID_MIN=`cat /etc/login.defs | grep "^UID_MIN" | awk '{print $2}'`
UID_MAX=`cat /etc/login.defs | grep "^UID_MAX" | awk '{print $2}'`



# Print users
for i in $(getent passwd | cut -d ":" -f1,3)
do
    #echo $i
    uid=$(echo $i | cut -d ":" -f 2)
    # UID_MIN <= userID < UID_MAX
    if [ $uid -ge $UID_MIN ] && [ $uid -lt $UID_MAX ]
    then
        echo $i
    fi
done