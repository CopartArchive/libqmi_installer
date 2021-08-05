# libqmi_installer
libqmi installer for Sixfab hat <br />
https://docs.sixfab.com/page/qmi-interface-internet-connection-setup-using-sixfab-shield-hat


# How to run?

Pre-requisite:
**Before running the below, please make sure the ppp and reconnect service are stopped and disabled!**
```
sudo systemctl stop ppp_connection_manager.service
sudo systemctl disable ppp_connection_manager.service
sudo systemctl stop reconnect.service
sudo systemctl disable reconnect.service
```

Do below command to make sure no ppp is left running.
```
ps -ef | grep ppp
```

Paste the below commands and provide the APN on prompt
``` bash
wget https://raw.githubusercontent.com/copartit/libqmi_installer/master/qmi_install.sh 
sudo chmod +x qmi_install.sh
sudo ./qmi_install.sh
```

<br />
<br />
**Uninstall** 
<br />
To uninstall
```
sudo systemctl stop qmi_reconnect.service
sudo systemctl disable qmi_reconnect.service
```
