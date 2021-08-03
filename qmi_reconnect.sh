#!/bin/bash

#qmi_reconnect.sh

while true; do

	ping -I wwan0 -c 1 -s 0 8.8.8.8

	if [ $? -eq 0 ]; then
		echo "Connection up, reconnect not required..."
	else
		echo "Connection down, reconnecting..."
		## Now configure the network interface for the raw-ip protocol.
        sudo ip link set wwan0 down

        echo 'Y' | sudo tee /sys/class/net/wwan0/qmi/raw_ip

        sudo ip link set wwan0 up

        ## One can confirm the data format using
        sudo qmicli -d /dev/cdc-wdm0 --wda-get-data-format

        sudo qmicli -p -d /dev/cdc-wdm0 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="apn='#APN',ip-type=4" --client-no-release-cid

        # Lastly, configure the IP address and the default route with udhcpc.
        sudo udhcpc -q -f -i wwan0
	fi

	sleep 10
done
