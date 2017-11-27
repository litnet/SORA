var reflectorIP  = '192.168.122.233';
var myAS         = '65001';
var myID         = '3.3.3.3';
var sFlowAgentIP = '192.168.99.2';

// allow BGP connection from reflectorIP
bgpAddNeighbor(reflectorIP,myAS,myID);

// direct sFlow from sFlowAgentIP to reflectorIP routing table
// calculate a 200 second moving average byte rate for each route
bgpAddSource(sFlowAgentIP,reflectorIP,60,'bytes');
