#! /vendor/bin/sh

MACADDRESS=/persist/wlan_mac.bin
MACADDRESSVENDOR=/data/vendor/wifi/wlan_mac.bin

# Read out WiFi Mac Address
macaddr=$(printf "%b" | od -An -t x1 -w6 -N6  $MACADDRESS | tr -d '\n ')

# Write new Mac Adress in Vendor
echo -e "Intf0MacAddress=$macaddr" "\nEND" > $MACADDRESSVENDOR
