#!/bin/bash

# send data from port 1 to port 2
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

# send data from port 2 to port 1
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

# send data from port 3 to port 4
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "in_port": 3
    },
    "actions":[
	{
            "type": "OUTPUT",
            "port": 4
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add

# send data from port 4 to port 3
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
        "in_port": 4
    },
    "actions":[
	{
            "type": "OUTPUT",
            "port": 3
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add

