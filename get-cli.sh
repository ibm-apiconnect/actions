#!/bin/bash

OS_TYPE=`uname -s`

case $OS_TYPE in

  Darwin*)
    FILENAME=toolkit-mac.zip
    curl -sLO https://api-manager.us-east-a.apiconnect.automation.ibm.com/client-downloads/$FILENAME
    unzip $FILENAME
  ;;
  Linux*)
    FILENAME=toolkit-linux.tgz
    curl -sLO https://api-manager.us-east-a.apiconnect.automation.ibm.com/client-downloads/$FILENAME
    tar -zxf $FILENAME
  ;;
esac
chmod +x apic-slim
