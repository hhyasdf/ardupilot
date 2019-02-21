#!/bin/sh

if [ "$#" -eq "2"  ];then
    NEW_SYSTEM_ID=$1
    DEST_IP=$2

    cd /ardupilot/APMrover2/

    CONTENT=$(grep -Eo "MAV_SYSTEM_ID.+" ./config.h)
    sed -i "s/$CONTENT/MAV_SYSTEM_ID    $NEW_SYSTEM_ID/g" ./config.h

    sim_vehicle.py --out=udp:$DEST_IP:14550
else
    echo "two parameters (a mavlink system id and a dest ip) are required!"
fi

