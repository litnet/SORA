#!/bin/bash
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "in_port": 1
    },
    "actions":[


	{
            "type": "SET_FIELD",
            "field": "eth_dst", 
            "value": "18:67:b0:4e:3c:e4"
        },
	{
            "type": "OUTPUT",
            "port": 2
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add

