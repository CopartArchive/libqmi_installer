#!/bin/bash

## Configure the network interface for the raw-ip protocol.
sudo ip link set wwan0 down

echo 'Y' | sudo tee /sys/class/net/wwan0/qmi/raw_ip

sudo ip link set wwan0 up

## One can confirm the data format using
sudo qmicli -d /dev/cdc-wdm0 --wda-get-data-format

sudo qmicli -p -d /dev/cdc-wdm0 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="apn='#APN',ip-type=4" --client-no-release-cid

# Lastly, configure the IP address and the default route with udhcpc.
sudo udhcpc -q -f -i wwan0