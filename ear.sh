#!/bin/bash

DEVICE_MAC="AC:12:2F:DF:1C:8D"

if ! command -v bluetoothctl >/dev/null 2>&1; then
    echo "You have no bluez."
    exit 1
fi

{
    echo "power on"
    sleep 1
    echo "scan on"
    sleep 5
    echo "trust $DEVICE_MAC"
    sleep 1
    echo "pair $DEVICE_MAC"
    sleep 2
    echo "connect $DEVICE_MAC"
    sleep 2
    echo "scan off"
    echo "exit"
} | bluetoothctl

if bluetoothctl info "$DEVICE_MAC" | grep -q "Connected: yes"; then
    echo "Connected to: ($DEVICE_MAC)"
else
    echo "Failed to connect to: ($DEVICE_MAC)"
    exit 1
fi
