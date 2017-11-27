import json
import requests

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
