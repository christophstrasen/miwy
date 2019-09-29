from scaledrone import Scaledrone
import json

class ControlStream:
    def __init__(self):
        self.drone = Scaledrone('AVMWTdaXnSW1UdUV','bge2O1bBhZZmtNWxHiDF7Wzotn57FD5K')
        self.room = 'downstream'
        
    def publish(self, msg):
        return self.drone.publish(self.room, msg)

    def sendTelemetryUpdate(self, vstats):
        return self.publish({
            'category':'telemetryUpdate',
            'level':'info',
            'data':self.generateTelemetryUpdateJson(vstats)
            })

    def generateTelemetryUpdateJson(self, vstats):
        #@todo later send only vales that changed
        tdict = {}
        for attr, value in vstats.__dict__.items():
            value = value.strftime('%Y%m%d %H:%M:%S') if attr == 'scriptStart' else value
            tdict[attr] = value
            print(attr, value)

        return tdict
