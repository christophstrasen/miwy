import vehicle_stats
import control_stream
import json
import asyncio
import websockets
import ssl
import time
import random


async def test():

    n = 0
    while n <= 1:
        n += 1
        print("task: loop {}:".format(n))
        time.sleep(n)
        await asyncio.sleep(n)
    return 'task: result'

async def handleMessage(websocket, path):
    while True:
        res = await test()
        print('handle: all tasks done result is {}'.format(res));
        await websocket.send('all tasks done result is {}'.format(res));
        try:
            print('handle: checking for new messages')
            while True:
                msg = await asyncio.wait_for(websocket.recv(), 0.2)
                print(f"<{msg}")
                greeting = f">{msg}!"
        except asyncio.TimeoutError:
            print('handle: ws recv timeout.')
        except websockets.ConnectionClosed:
            print(f"handle: ws Terminated!")
            break
        except Exception as e:
            print('handle: generic exception')
            break

        print(f"<{msg}")
        greeting = f">{msg}!"

        await websocket.send(greeting)
        print(greeting)

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
