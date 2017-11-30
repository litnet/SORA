#dell s3048-on



#in port 12, out port 13, table - route (l3)

 curl -i -X POST -d '{
    "dpid": 410009975832960,
    "table_id": 40,
    "match":{
        "in_port": 64

    },
    "actions":[

        {
            "type": "OUTPUT",
            "port": 65
        }
    ]
 }' http://localhost:8080/stats/flowentry/add

