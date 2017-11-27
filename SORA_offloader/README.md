This is the folder of the Software Router Acellerator main script. 
==================================================================

Instructions:
---------------
Before starting, ensure that the software router is both running 
and fully configured. It is recommended to only start the flow of 
traffic after the bgp tables have fully converged.

1. Start Ryu OpenFlow controller
The script to launch Ryu with necesary modules is 
located at '(root)/Ryu/startryu.sh'.

2. Start Sflow-RT 
The script to launch Sflow-RT with BGP statistics support is located 
at '(root)/sflow-rt/start.sh'. NOTE: script must be started as ROOT.

3. Launch the offloading script 'acellerator.py', and after the BGP tables have
finished converging, start the trafic flow and observe the load on the router's
network interfaces versus the total amount of traffic passing through the switch.
