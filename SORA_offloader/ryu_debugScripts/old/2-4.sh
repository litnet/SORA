#!/bin/bash
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "in_port": 4
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
        "in_port": 2
    },
    "actions":[


	{
            "type": "SET_FIELD",
            "field": "eth_dst", 
            "value": "20:47:47:df:b1:f4"
        },
	{
            "type": "OUTPUT",
            "port": 4
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add
