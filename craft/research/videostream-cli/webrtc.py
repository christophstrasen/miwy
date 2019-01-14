#!/usr/bin/python
import websocket
import _thread
import time
import json
import urllib.parse

def on_message(ws, message):
    print("receive:" + urllib.parse.unquote(message))

def on_error(ws, error):
    print("error:" + error)

def on_close(ws):
    print("### closed ###")
    # Attemp to reconnect with 2 seconds interval
    time.sleep(2)
    initiate()

def on_open(ws):
    print("### Initiating new websocket connection ###")
    def run(*args):
        # handshake and subscribe
        for i in range(1):
            time.sleep(1)
            ws.send('{"type":"handshake","channel":"AVMWTdaXnSW1UdUV","version":2,"client_data":null,"callback":0}')
            ws.send('{"type":"subscribe","room":"observable-webrtc","callback":1}')
            time.sleep(1) 
        # repeat announcing that we are here and waiting
        for i in range(10):
            ws.send('{"type":"publish","room":"observable-webrtc","message":"' + urllib.parse.quote(json.dumps({'CustomSignalingStatus':'waiting'})) + '"}')
            time.sleep(5)
        time.sleep(100)
        ws.close()
        print("thread terminating...")
    _thread.start_new_thread(run, ())

def initiate():
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp("wss://api.scaledrone.com/v3/websocket",
        on_message = on_message,
        on_error = on_error,
        on_close = on_close)
    ws.on_open = on_open

    ws.run_forever()

if __name__ == "__main__":
    initiate()


