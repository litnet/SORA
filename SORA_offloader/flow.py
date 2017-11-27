#===   Json flow generating functions 
#===   (c) Norbertas Kremeris 2017

import json

def toRouterPort(switchId, port, routerPort, pairVlan):
	vlan = pairVlan + 4096
	rule = {}
	rule['dpid'] = switchId[0]
	rule['table_id'] = 100
	rule['match'] = { 'in_port': port }
	rule['actions'] = []
	rule['actions'].append( { 'type':'SET_FIELD', 'field':'vlan_vid', 'value':vlan } )
	rule['actions'].append( { 'type':'OUTPUT', 'port':routerPort } )
	return rule

def fromRouterPort(switchId, port, routerPort, pairVlan):
	vlan = pairVlan + 4096
	rule = {}
	rule['dpid'] = switchId[0]
	rule['table_id'] = 100
	rule['match'] = { 'in_port': routerPort, 'dl_vlan':vlan }
	rule['actions'] = []
	rule['actions'].append( {'type':'POP_VLAN'} )
	rule['actions'].append( { 'type':'OUTPUT', 'port':port } )
	return rule

def offload(switchId,ipv4Prefix,nextHopMac,nextHopPort,timeout):
	rule = {}
	rule['dpid'] = switchId[0]
	rule['table_id'] = 100 
	rule['priority'] = 500 
	rule['hard_timeout'] = timeout  
	rule['match'] = { 'ipv4_dst':ipv4Prefix, 'eth_type':2048 }
	rule['actions'] = []
	rule['actions'].append ( { 'type':'POP_VLAN'   } ) 
	rule['actions'].append( { 'type':'SET_FIELD', 'field':'eth_dst', 'value':nextHopMac   } )
	rule['actions'].append( { 'type' : 'OUTPUT', 'port': nextHopPort  }  )
	return rule








"""
def toRouterPortARP(switchId, port, routerPort, pairVlan):
	vlan = pairVlan + 4096
	rule = {}
	rule['priority'] = 1000
	rule['dpid'] = switchId[0]
	rule['table_id'] = 100
	rule['match'] = { 'in_port': port, 'eth_type':2054 }
	rule['actions'] = []
	rule['actions'].append( { 'type':'SET_FIELD', 'field':'vlan_vid', 'value':vlan } )
	rule['actions'].append( { 'type':'OUTPUT', 'port':routerPort } )
	return rule

def fromRouterPortARP(switchId, port, routerPort, pairVlan):
	vlan = pairVlan + 4096
	rule = {}
	rule['priority'] = 1000
	rule['dpid'] = switchId[0]
	rule['table_id'] = 100
	rule['match'] = { 'in_port': routerPort, 'dl_vlan':vlan, 'eth_type':2054 }
	rule['actions'] = []
	rule['actions'].append( {'type':'POP_VLAN'} )
	rule['actions'].append( { 'type':'OUTPUT', 'port':port } )
	return rule
	"""
