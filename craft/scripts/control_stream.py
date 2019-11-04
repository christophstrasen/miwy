import json
import asyncio
import websockets
import ssl
import time
import json
import vehicle_stats

async def test():
    print('enter test')
    print('sleep 5s blocking')
    await asyncio.sleep(5)
    print('sleep 10s non blocking')
    await asyncio.sleep(10)
    print('done test')
    return false

class ControlStream:
    def __init__(self, vstats):
       print('init ControlStream')
       self.vstats = vstats
    #def publish(self, msg):
    
    def parseCommand(self, msg):
        try:
            command = json.loads(msg)
            print(json.dumps(command, indent=4, sort_keys=True))
            #self.vstats['default'].loadFromJson(command.data)
            self.vstats.loadFromJson(command)
            
        except ValueError:  # includes simplejson.decoder.JSONDecodeError
            print(f"Decoding JSON has failed. String given was {msg}")

    def sendTelemetryUpdate(self, vstats):
        return self.publish({
            'category':'telemetryUpdate',
            'level':'info',
            'sender':'craft',
            'data':self.generateTelemetryUpdateJson(vstats)
            })

    def generateTelemetryJSON(self):
        self.vstats.throttle['actual'] = 99 #mock change
        #@todo later send only vales that changed
        tdict = {}
        for attr, value in self.vstats.__dict__.items():
            value = value.strftime('%Y%m%d %H:%M:%S') if attr == 'scriptStart' else value
            tdict[attr] = value
            print(attr, value)

        telemetry = {
            'category':'telemetryUpdate',
            'level':'info',
            'sender':'craft',
            'data':tdict
        }
        return json.dumps(telemetry)

    def test(self):
        print("test")

