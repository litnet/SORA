#!/bin/bash
./del_table_100_only.sh
# send data from port 4 tagged with vlan 6 to port 12
curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
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
    "dpid": 497204398532800,
    "table_id": 100,
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
 

 curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "match":{
		"dl_vlan": "0x1006",
        "in_port": 12

    },
    "actions":[
		{
			 "type": "POP_VLAN"
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
		"dl_vlan": "0x1007",
        "in_port": 12

    },
    "actions":[
		{
			 "type": "POP_VLAN"
		},

        {
            "type": "OUTPUT",
            "port": 4
        }
    ]
 }' http://localhost:8080/stats/flowentry/add




#=================================================
#NEVER OFFLOAD ARP

curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "priority": 1000,
    "match":{
        "in_port": 2,
        "eth_type":2054
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
    "dpid": 497204398532800,
    "table_id": 100,
    "priority": 1000,
    "match":{
        "in_port": 4,
        "eth_type":2054
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
 

 curl -i -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
    "priority": 1000,
    "match":{
		"dl_vlan": "0x1006",
        "in_port": 12,
        "eth_type":2054

    },
    "actions":[
		{
			 "type": "POP_VLAN"
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
    "priority": 1000,
    "match":{
		"dl_vlan": "0x1007",
        "in_port": 12,
        "eth_type":2054

    },
    "actions":[
		{
			 "type": "POP_VLAN"
		},

        {
            "type": "OUTPUT",
            "port": 4
        }
    ]
 }' http://localhost:8080/stats/flowentry/add
