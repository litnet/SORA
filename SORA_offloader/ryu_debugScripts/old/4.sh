#!/bin/bash

curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "in_port": 2
    },
    "actions":[


        {
            "type": "SET_FIELD",
            "field": "eth_dst", 
            "value": "00:1d:72:8a:b7:84"
        },
        {
            "type": "OUTPUT",
            "port": 1
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add

