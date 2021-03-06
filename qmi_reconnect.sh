#!/bin/bash

#qmi_reconnect.sh

while true; do

	ping -I wwan0 -c 1 -s 0 8.8.8.8 1> /dev/null

	if [ $? -gt 0 ]; then
		echo "Connection down, reconnecting..."
        sudo ./qmi_connect.sh
	fi

	sleep 30
done
