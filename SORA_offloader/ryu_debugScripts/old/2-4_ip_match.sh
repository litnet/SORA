#!/bin/bash
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "ipv4_dst":"192.168.1.2",
        "eth_type":2048
    },
    "actions":[
	{
            "type": "SET_FIELD",
            "field": "eth_dst", 
            "value": "b8:88:e3:f8:d9:4e"
        },
	{
            "type": "OUTPUT",
            "port": 2
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add

curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "ipv4_dst":"192.168.2.2",
        "eth_type":2048
    },
    "actions":[
	{
            "type": "SET_FIELD",
            "field": "eth_dst", 
            "value": "18:67:b0:4e:3c:e4"
        },
	{
            "type": "OUTPUT",
            "port": 4
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add
