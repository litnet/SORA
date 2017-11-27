#!/bin/bash
./del_table_100_only.sh
./full_mapping.sh
#thinkpad b8:88:e3:f8:d9:4e
#samsung 18:67:b0:4e:3c:e4
#router debian 52:54:00:ed:98:5a

#thinkpad to samsung
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "priority": 1500,
    "match":{
        "ipv4_dst":"192.168.2.2",
        "eth_type":2048
    },
    "actions":[
    	{
			 "type": "POP_VLAN"
		},
        {
            "type": "SET_FIELD",
            "field": "eth_dst", 
            "value": "18:67:b0:4e:3c:e4"
        },
        {
            "type": "SET_FIELD",
            "field": "eth_src", 
            "value": "52:54:00:ed:98:5a"
        },
		{
            "type": "OUTPUT",
            "port": 4
        }  
  
     ]
 }' http://localhost:8080/stats/flowentry/add
 
 
 #samsung to thinkpad
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "priority": 500,
    "match":{
        "ipv4_dst":"192.168.1.2",
        "eth_type":2048
    },
    "actions":[
    	{
			 "type": "POP_VLAN"
		},
	    {
            "type": "SET_FIELD",
            "field": "eth_dst", 
            "value": "b8:88:e3:f8:d9:4e"
        },
        {
            "type": "SET_FIELD",
            "field": "eth_src", 
            "value": "52:54:00:ed:98:5a"
        },
		{
            "type": "OUTPUT",
            "port": 2
        }   


     ]
 }' http://localhost:8080/stats/flowentry/add


