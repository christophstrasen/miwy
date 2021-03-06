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
        taskResults = await sched.run()
        for res in taskResults :
            print(res)
            await websocket.send(control.generateTelemetryJSON())
        msgstr = 'handle: sched done'
        await websocket.send('{"msg": "' + msgstr + '"}')
        try:
            print('handle: checking for new messages')
            numrcv = 0
            while True:
                msg = await asyncio.wait_for(websocket.recv(), 0.20)
                numrcv += 1
                if(msg != 'client: heartbeat'): #no hearbeat means look for command
                    #if we loop through multiple messages, the last one counts
                    control.parseCommand(msg)
        except asyncio.TimeoutError:
            print('handle: ws recv timeout.')
        except websockets.ConnectionClosed:
            print(f"handle: ws Terminated!")
            break
        except Exception as e:
            print('handle: generic exception:', e)
            break

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

if __name__ == "__main__":
    main()
