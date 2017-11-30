#!/usr/bin/env python3

#===   SORA
#===   Software router accelerator
#===   PROOF OF CONCEPT
#===   (c) Norbertas Kremeris 2017

from time import sleep

# includes for (1)
import json
import requests

#includes for (2)
import sys
import subprocess

#includes for main
import time
import signal
import curses

#custom functions
import flow
from http.cookies import _LegalChars
#import switch




#PARAMETERS

#hp2920
#routerPort = 12  #multi vlan port on switch, connected to virtual router
#portList = [2, 4]    #ports used for routing
#vlanList = [6, 7]    #corresponding vlans of portList[] ports

#dell s3048-on
routerPort = 64  #multi vlan port on switch, connected to virtual router
portList = [54, 56]    #ports used for routing
vlanList = [6, 7]    #corresponding vlans of portList[] ports



sflowHostAddr = "localhost"
sflowHostPort = "8008"
ryuHostAddr = "localhost"
ryuHostPort = "8080"
routerAddr = "192.168.122.233"
topPrefixCount = 300
offloadValue = 0 #bytes per second
cooldownPeriod = 1
flowTimeout = 60
loopSleepTime = 20
tableIdForDefault = 40 #table id to use for default mapping (routed ports)
tableIdForOffload = 40 #table id to use for offload flows generated from bgp routes
sleepAfterFlowInstall = 0.05 #sleep in seconds after every flow installed

####FUNCTIONS

#===check if switch exists and is connected to ryu
#===returns false if no switch is connected
#===returns switch id otherwise

def getId(ryuHostAddr,ryuHostPort):
	url = "http://" + ryuHostAddr + ":" + ryuHostPort + "/stats/switches"
	data = requests.get(url)
	switchlist = json.loads(data.content.decode('utf-8'))
	if switchlist == []:
		return False
	else:
		return switchlist


#===checks if switch is online
def waitForSwitchOnline(ryuHostAddr, ryuHostPort):
	counter = 0
	print ( "\nWaiting for switch, timeout 60s" )
	
	while not (counter > 60 and getId(ryuHostAddr, ryuHostPort)):
		counter += 1
		print(".")
		time.sleep(1)
		print( "Switch found!" );
		return 1
	print( "Timed out waiting for switch, exiting...")
	return 0;


#=== returns table of vlans vs ports
def returnVlanTable(portList,vlanList):
	table = {}
	for i in range(0, len(portList)):
		table[str(vlanList[i])] = portList[i]
	return table

#===Receive top prefixes from sflow-rt
#===Returns 0 if no prefixes are found, returns prefix info array if otherwise
def returnPrefixList():
	url = "http://" + sflowHostAddr + ":" + sflowHostPort +"/bgp/topprefixes/" + routerAddr + "/json?direction=destination&maxPrefixes=" + str(topPrefixCount) + "&minValue=" + str(offloadValue)
	data = requests.get(url)
	topprefix = json.loads(data.content.decode('utf-8'))
	if len(topprefix['topPrefixes']) == 0:
		return []
	else:
		return topprefix['topPrefixes']
#===

#===Create a merged table of top prefixes with nexthop mac addresses and egress ifaces
def returnPrefixTable(prefixList,portList,vlanList):
	if len(prefixList) == 0:
		return []
	vlanTable = returnVlanTable(portList,vlanList)
	HOST="root@192.168.122.233"  #virtual router ip address, needs root access. Set up with ssh-copy-id.
	COMMAND="arp"
	ssh = subprocess.Popen(["ssh", "%s" % HOST, COMMAND],
	                       shell=False,
	                       stdout=subprocess.PIPE,
	                       stderr=subprocess.PIPE)
	result = ssh.stdout.readlines()
	if result == []:
		return 0

	else:
		newPrefixList = []
		result = list(map(lambda s: s.strip(), result))
		#print(result);
		del result[0]
		for i in result:
			for z in prefixList: # add nexthopmac and egress iface values to prefixlist
				if z['nexthop'] == i.split()[0].decode('utf-8'): 
					z['nexthopmac'] = i.split()[2].decode('utf-8')
					#print((i.split()[2].decode('utf-8')))
					#z['vlan'] = (i.split()[4].decode('utf-8')).split('.')[-1]
					z['vlan'] = (i.split()[4].decode('utf-8')).split('.')[-1]
					z['port'] = vlanTable[z['vlan']]
					newPrefixList.append(z);
		return newPrefixList
#===


#===default port mapping after cold boot
def defaultMapping(routerPortNumber,portList,vlanList):
	switchId=getId(ryuHostAddr, ryuHostPort)
	data = []
	for i in range(0,len(portList)):
		data.append(flow.toRouterPort(switchId,portList[i],routerPortNumber,vlanList[i],tableIdForDefault))
		data.append(flow.fromRouterPort(switchId,portList[i],routerPortNumber,vlanList[i],tableIdForDefault))
	headers = {'content-type': 'application/json'} 
	url = 'http://localhost:8080/stats/flowentry/add'
	for i in range(0,len(data)):
		response = requests.post(url, data=json.dumps(data[i]), headers=headers)

#=== offloads topN prefixes ;)
def offloadTopN(topN,prefixTable):
	offloaded = []
	switchId = getId(ryuHostAddr, ryuHostPort)
	if len(prefixTable) == 0:
		return False
	else:
		print("Offloading:")
#		print (json.dumps(prefixTable, ensure_ascii=False, sort_keys=True, indent=4))
								#why was this here?
		topN = len(prefixTable) #% topN
		headers = {'content-type': 'application/json'}
		url = 'http://localhost:8080/stats/flowentry/add'
		for i in range(0,topN):
			sleep(sleepAfterFlowInstall)
			data = flow.offload(switchId,prefixTable[i]['prefix'], prefixTable[i]['nexthopmac'], prefixTable[i]['port'], flowTimeout,tableIdForOffload)
			response = requests.post(url, data=json.dumps(data), headers=headers)
			print("offloaded -> " + prefixTable[i]['prefix'])
		print("Offloading complete.")
		return str(json.dumps(prefixTable, ensure_ascii=False, sort_keys=True, indent=4))


def signal_handler(signal, frame):
		sys.exit(0)



def main():
	while True:
		if(not waitForSwitchOnline(ryuHostAddr, ryuHostPort)):
			return 0
		
		defaultMapping(routerPort,portList,vlanList)
		time.sleep(cooldownPeriod)
		while not (getId(ryuHostAddr, ryuHostPort) == False):
			prefixList = returnPrefixList()
			prefixTable = returnPrefixTable(prefixList,portList,vlanList)
			offloaded = offloadTopN(topPrefixCount,prefixTable)
			defaultMapping(routerPort,portList,vlanList)
			#print (offloaded)
			print("sleeping")			
			print("============================================")
			time.sleep(loopSleepTime)
			print("\n\n\n\n\n")



signal.signal(signal.SIGINT, signal_handler)
main()
signal.pause()
