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
