#!/bin/bash

FIRST_RUN_CHECK="NOT_FIRST_RUN"
if [ ! -e $FIRST_RUN_CHECK ]; then
    echo "-- First start - Installing Monitor --"
    # YOUR_JUST_ONCE_LOGIC_HERE
    cd /
    git clone git://github.com/andrewjfreyer/monitor
    chmod +x /monitor/monitor.sh
    touch $FIRST_RUN_CHECK
fi

# Use volume-mounted config files if present.
# Use -v /your/config/dir:/config to map in files like known_static_addresses
cp /config/address_blacklist /monitor/address_blacklist 2> /dev/null
cp /config/behavior_preferences /monitor/behavior_preferences 2> /dev/null
cp /config/known_beacon_addresses /monitor/known_beacon_addresses 2> /dev/null
cp /config/known_static_addresses /monitor/known_static_addresses 2> /dev/null
cp /config/mqtt_preferences /monitor/mqtt_preferences 2> /dev/null

echo "-- Starting Monitor --"
cd monitor
( echo n ) | ./monitor.sh $MON_OPT
