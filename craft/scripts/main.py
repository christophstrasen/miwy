import vehicle_stats
import control_stream
import scheduler
import json
import asyncio
import websockets
import ssl
import time
import random
import copy

async def test():

    n = 0
    while n <= 0:
        n += 1
        print("task: loop {}:".format(n))
        time.sleep(n)
        await asyncio.sleep(n)
    return 'task: result'

async def handleMessage(websocket, path):
    sched = scheduler.scheduler(control)
    while True:
        #res = await test()
        await sched.run()
        #msgstr = 'handle: all tasks done result is {}'.format(res)
        msgstr = 'handle: sched done'
        await websocket.send('{"msg": "' + msgstr + '"}')
        try:
            print('handle: checking for new messages')
            numrcv = 0
            while True:
                msg = await asyncio.wait_for(websocket.recv(), 0.2)
                numrcv += 1
                if(msg != 'client: heartbeat'): #if not a heartbeat, we parse the supposed command and echo back all telemetry
                    control.parseCommand(msg)
                    await websocket.send(control.generateTelemetryJSON())
        except asyncio.TimeoutError:
            print('handle: ws recv timeout.')
        except websockets.ConnectionClosed:
            print(f"handle: ws Terminated!")
            break
        except Exception as e:
            print('handle: generic exception:', e)
            break
        #print(f"<{msg}")
        #greeting = f">{msg}!"

vstats = vehicle_stats.VehicleStats()
control = control_stream.ControlStream(vstats)

def main():
    ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ssl_context.load_cert_chain(
            '/opt/miwy-craft/secrets/cert.pem',
            '/opt/miwy-craft/secrets/key.pem'
            )
    print('main: server SSL context loaded.')
    server = websockets.serve(
            handleMessage,
            '0.0.0.0',
            8081,
            ssl=ssl_context
            )

    asyncio.get_event_loop().run_until_complete(server)
    asyncio.get_event_loop().run_forever()

    #control = control_stream.ControlStream()
    #vstats = vehicle_stats.VehicleStats()
    #control.sendTelemetryUpdate(vstats)

if __name__ == "__main__":
    main()
