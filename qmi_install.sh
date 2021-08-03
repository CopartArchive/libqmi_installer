#!/bin/bash

# Updated Aug 2nd 2021
# Created by Lizhang Xie

WORK_PATH="/opt/copart"

REPO_PATH="https://raw.githubusercontent.com/copartit/libqmi_installer"
BRANCH=master
RECONNECT_SCRIPT_NAME="qmi_reconnect.sh"
SERVICE_NAME="qmi_reconnect.service"


YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[1;34m'
GREEN='\033[0;32m'
SET='\033[0m'

function colored_echo
{
	COLOR=${2:-$YELLOW}
	echo -e "$COLOR$1 ${SET}"
}

# Check Copart path 
if [[ -e $WORK_PATH ]]; then
    colored_echo "Copart path already exist!" ${SET}
else
    sudo mkdir $WORK_PATH
    colored_echo "Copart path is created." ${SET}
fi

colored_echo "What is your carrier APN?"
read carrierapn 

colored_echo "Your Input is : $carrierapn" ${GREEN} 

## First, install the required packages.
## libqmi-utils installs two main utilities (qmi-cli tool and qmi-network helper script)
## These are used for interaction with the modem (for more details check man qmi-cli)
sudo apt update && sudo apt install libqmi-utils udhcpc -y

sudo qmicli -d /dev/cdc-wdm0 --dms-set-operating-mode='online'

wget --no-check-certificate $REPO_PATH/$RECONNECT_SCRIPT_NAME
if [[ $? -ne 0 ]]; then colored_echo "Download failed" ${RED}; exit 1; fi

wget --no-check-certificate $REPO_PATH/$SERVICE_NAME
if [[ $? -ne 0 ]]; then colored_echo "Download failed" ${RED}; exit 1; fi

sed -i "s/#APN/$carrierapn/" $RECONNECT_SCRIPT_NAME

mv $RECONNECT_SCRIPT_NAME $WORK_PATH

sudo .$WORK_PATH/$RECONNECT_SCRIPT_NAME

systemctl daemon-reload
systemctl enable $SERVICE_NAME
			  
read -p "Press ENTER key to reboot" ENTER

colored_echo "Rebooting..." ${GREEN}
reboot