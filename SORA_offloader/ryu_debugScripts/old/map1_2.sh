#!/bin/bash
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "in_port": 1
    },
    "actions":[
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
            "type": "OUTPUT",
            "port": 1
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add

