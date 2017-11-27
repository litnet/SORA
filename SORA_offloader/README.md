#This is the folder of the Software Router Acellerator main script. 

##Instructions:
Before starting, ensure that the software router is both running and fully configured.

###1. Start Ryu OpenFlow controller
The script to launch Ryu with necesary modules is named 'startryu.sh' and is located 
at (root)/Ryu/startryu.sh

###2. Start Sflow-RT 
////FIXTHIS

###3. Launch offloading script 'acellerator.py', and after the BGP tables have
stoped updating, observe the load on the router's network interfaces versus
the total amount of traffic passing through the switch.
