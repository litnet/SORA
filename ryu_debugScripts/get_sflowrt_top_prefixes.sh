#!/bin/bash 

curl "http://localhost:8008/bgp/topprefixes/192.168.122.233/json?direction=destination&maxPrefixes=5"

#echo
#curl "http://localhost:8008/bgp/topprefixes/192.168.122.233/json?direction=source&maxPrefixes=5"
