#!/bin/bash
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 200,
    "actions":[
	{
            "type": "OUTPUT",
            "port": "All"
        }       
     ]
 }' http://localhost:8080/stats/flowentry/add

