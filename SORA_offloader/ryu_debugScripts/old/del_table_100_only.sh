#!/bin/bash
 curl -X POST -d '{
    "dpid": 497204398532800,
    "table_id": 100,
 }' http://localhost:8080/stats/flowentry/delete
