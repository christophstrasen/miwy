import json
import asyncio
import websockets
import ssl
import time

async def test():
    print('enter test')
    print('sleep 5s blocking')
    await asyncio.sleep(5)
    print('sleep 10s non blocking')
    await asyncio.sleep(10)
    print('done test')
    return false

class ControlStream:
    def __init__(self):
       print('init ControlStream') 
    #def publish(self, msg):


    async def handleMessage(self,websocket, path):
        msg = await websocket.recv()
        print(f"<{msg}")

        response = f"{msg}"

        await websocket.send(response)
        print(f">{response}")

    def startLoopWS(self,bindaddr,port,secretsdir):
        ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
        ssl_context.load_cert_chain(secretsdir + 'cert.pem', secretsdir + 'key.pem')

        start_server = websockets.serve(
            self.handleMessage, bindaddr, port, ssl=ssl_context
        )
        asyncio.get_event_loop().run_until_complete(start_server)
        asyncio.run(test)
        print('EL complete: start_server')
        asyncio.get_event_loop().run_forever()
        print('EL complete: run_forever')
    
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
