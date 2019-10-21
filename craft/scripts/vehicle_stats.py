import json
from collections import namedtuple
from datetime import datetime
class VehicleStats:

    def __init__(self):
        self.scriptStart = datetime.utcnow()
        
        # load vehicle defaults from file
        with open('vehicle_stats.json', 'r') as f:
            vs = json.load(f)
        for key, value in vs.items():
            # populate self from the json
            setattr(self, key, value)

    def loadFromJson(self, vsDesired):
        for key, value in vsDesired['data'].items():
            # populate only update the desired values
            original = getattr(self, key)
            original['desired'] = value['desired']
            setattr(self, key, original)
