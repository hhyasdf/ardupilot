#!/bin/sh

NEW_SYSTEM_ID=$1
DEST_IP=$2

cd /ardupilot/APMrover2/

CONTENT=$(grep -Eo "MAV_SYSTEM_ID.+" ./config.h)
sed -i "s/$CONTENT/MAV_SYSTEM_ID    $NEW_SYSTEM_ID/g" ./config.h

if [ "$#" -eq "2" ];then
    sim_vehicle.py --out=udp:$DEST_IP:14550
elif [ "$#" -eq "1" ];then
    echo "mavproxy will not start, the UAV will listen to tcp:127.0.0.1:5760"
    echo "<<<<<<<<<<<<<<<<<<<<<<<"
    sim_vehicle.py --no-mavproxy
else
    echo "two parameters (a mavlink system id and a dest ip) are required!"
fi

