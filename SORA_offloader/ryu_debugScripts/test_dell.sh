#/bin/bash
#./del_table_100_only.sh
 curl -i -X POST -d '{
    "dpid": 410009975832960,
    "table_id": 10,
    "match":{
		"dl_vlan": 4102

    },
    "actions":[
{
"type": "POP_VLAN"
},

        {
            "type": "OUTPUT",
            "port": 53
        }
    ]
 }' http://localhost:8080/stats/flowentry/add


