#!/bin/bash

# send data from port 4 tagged with vlan 40 to port 12
curl -i -X POST -d '{
    "dpid": 410009975832960,
    "table_id": 10,
    "match":{
        "in_port": 2
    },
    "actions":[

        {
            "type": "SET_FIELD",
            "field": "vlan_vid",     
            "value": 4102         
        },
        {
            "type": "OUTPUT",
            "port": 12
        }
    ]
 }' http://localhost:8080/stats/flowentry/add
 
 curl -i -X POST -d '{
    "dpid": 410009975832960,
    "table_id": 10,
    "match":{
        "in_port": 4
    },
    "actions":[

        {
            "type": "SET_FIELD",
            "field": "vlan_vid",     
            "value": 4103         
        },
        {
            "type": "OUTPUT",
            "port": 12
        }
    ]
 }' http://localhost:8080/stats/flowentry/add
 



