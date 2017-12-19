#!/bin/sh

# Variables
MYPATH="/Users/jon_michelson/projects/pinger"
IP="8.8.8.8"
COUNT="5"

# Ping server, write avg roundtrip latency to file
RNDTRIP_MS=`/sbin/ping -c $COUNT $IP | tail -1 | awk '{print $4}' | cut -d '/' -f 2`

# Compute Mbps
BYTES_PER_PACKET="64"
PACKETS_PER_SEC=`awk "BEGIN {print 1/($RNDTRIP_MS/2)}"`
MBPS=`awk "BEGIN {print 8*$BYTES_PER_PACKET*$PACKETS_PER_SEC}"`

# Append speed (Mbps) to text file
TIMESTAMP=`date "+%Y-%m-%d-%H-%M"`
echo "$TIMESTAMP, $MBPS," >> $MYPATH/history.csv

# Optional print-out
# echo $TIMESTAMP: $MBPS Mbps
