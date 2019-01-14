import argparse
import asyncio
import _thread
import logging
import time
import json
import urllib.parse
import websocket

import numpy
from av import VideoFrame

from aiortc import sdp, RTCPeerConnection, RTCSessionDescription, VideoStreamTrack, RTCConfiguration, RTCIceServer, RTCIceCandidate
from aiortc.contrib.media import MediaBlackhole, MediaRecorder
from aiortc.contrib.signaling import add_signaling_arguments, create_signaling
from aiortc.contrib.media import MediaPlayer
from scaledrone import Scaledrone

isOfferer = False
announceWait = True
drone_client_id = False
messages = []

def drone_publish(ws,s):
    print("sending " + s)
    return ws.send('{"type":"publish","room":"observable-webrtc","message":' + s + '}')

def escape(s):
    if(isinstance(s, str)):
        return s.replace('"', '\\"')

def unescape(s):
    return s.replace('\\"', '"')

def on_message(ws, message):
    global drone_client_id
    global isOfferer
    global messages
    global announceWait
    decoded = urllib.parse.unquote(message)
    decoded = message
    obj = json.loads(decoded)
    # store owm client id
    if obj.get("callback") == 1000:
        drone_client_id = obj.get("client_id")
        print("my client id is " + drone_client_id)
    # from here on ignore our own ID
    if drone_client_id and obj.get("client_id") != drone_client_id:
        if obj.get("message"):
            message = obj.get("message")
            if(isinstance(message, str)):
                message = json.loads(unescape(message))
            print("recieved from " + obj.get("client_id"));
            print(message);
            messages.append(message) # Store it here, check_messages has to pick it up
            # Someone is waiting so we should offer. We only react on waiting events if we are not already offering
            if message.get("CustomSignalingStatus") == "waiting" and isOfferer == False:
                announceWait = False
                isOfferer = True
                print("we offer")
                webrtc_init(ws)
            # Someone offered so lets look at it - offer may online be recieved once or things become undefined!
            if message.get('sdp', {}).get('type') == 'offer':
                announceWait = False
                isOfferer = False #should still be false anyhow
                print('They offer')
                webrtc_init(ws)

async def check_messages():
    global messages
    global isOfferer
    for i in range(100):
        while messages:
            return messages.pop(0)
        await asyncio.sleep(1)
    return False

def webrtc_init(ws):
    print('logging')
    logging.basicConfig(level=logging.DEBUG)

    # create signaling and peer connection
    
    ice = RTCIceServer('stun:coturn.medigo.com:9444')
    # ice.urls = 'turn:coturn.medigo.com:9444'
    ice.username = 'miwyuser975'
    ice.credential = 'miwyuser975'
    rtc = RTCConfiguration()
    rtc.iceServers = [ice]
    pc = RTCPeerConnection(rtc)

    # create media sink
    recorder = MediaRecorder('video.mp4')
    #recorder = MediaBlackhole()

    # run event loop
    loop = asyncio.get_event_loop()
    print('got event loop')
    try:
        loop.run_until_complete(run(
            pc=pc,
            recorder=recorder,
            ws=ws))
    except KeyboardInterrupt:
        pass
    finally:
        # cleanup
        loop.run_until_complete(recorder.stop())
        # loop.run_until_complete(on_close(ws))
        loop.run_until_complete(pc.close())

def on_error(ws, error):
    print("error:" + error)

def on_close(ws):
    print("### closed ###")
    # Attemp to reconnect with 2 seconds interval
    time.sleep(1)
    # initiate()

def on_open(ws):
    global announceWait
    print("### Initiating new websocket connection ###")
    def run(*args):
        # handshake and subscribe
        for i in range(1):
            time.sleep(1)
            ws.send('{"type":"handshake","channel":"AVMWTdaXnSW1UdUV","version":2,"client_data":null,"callback":1000}')
            ws.send('{"type":"subscribe","room":"observable-webrtc","callback":1001}')
            time.sleep(1) 
        # repeat announcing that we are here and waiting
        for i in range(10):
            print("run {} value of announceWait: {}".format(i,announceWait))
            if(not announceWait):
                print('stopping to announce')
                i = 10
                return True # jump out
            drone_publish(ws, '{"CustomSignalingStatus":"waiting"}')
            time.sleep(5)
        print('Sleep 100 seconds, then will close websocket')
        time.sleep(3)
        ws.close()
        print("thread terminating...")
    _thread.start_new_thread(run, ())

def ws_initiate():
    websocket.enableTrace(False)
    ws = websocket.WebSocketApp("wss://api.scaledrone.com/v3/websocket",
        on_message = on_message,
        on_error = on_error,
        on_close = on_close)
    ws.on_open = on_open
    ws.run_forever()

def create_rectangle(width, height, color):
    data_bgr = numpy.zeros((height, width, 3), numpy.uint8)
    data_bgr[:, :] = color
    return data_bgr

async def run(pc, recorder, ws):
    @pc.on('track')
    def on_track(track):
        print('Receiving video')
        ### assert track.kind == 'video'
        recorder.addTrack(track)

    if isOfferer:
        # send offer
        ### pc.addTrack(FlagVideoStreamTrack())
        print('Adding my media streams');
        options = {'video_size': '640x480'}
        player = MediaPlayer('/dev/video0', format='v4l2', options=options)
        pc.addTrack(player.video)
        await pc.setLocalDescription(await pc.createOffer())
        drone_publish(ws, pc.localDescription)

    # consume signaling
    while True:
        print('Consume Signal, checking for messages')
        obj = await check_messages()
        print("Consume Signal, obj is:" + json.dumps(obj))

        # We recive a remote ICECandidate
        if(obj.get('candidate', {})):
            print('found candidate')
            candidate = candidate_from_sdp(obj.get('candidate').get('candidate'))
            print('adding ICECandidate ' + json.dumps(candidate))
            pc.addIceCandidate(candidate)

        # We receive a remote session description
        if(obj.get('sdp', {})):
            desc = RTCSessionDescription(obj.get('sdp').get('sdp'), type=obj.get('sdp').get('type') )
            print('Created desc')
        #if isinstance(obj, RTCSessionDescription):
            await pc.setRemoteDescription(desc)
            print('set desc')
            await recorder.start()
            print('started record')

            if desc.type == 'offer':
                # send answer
                print('its offer, lets add our video')
                #pc.addTrack(FlagVideoStreamTrack())
                options = {'video_size': '640x480'}
                player = MediaPlayer('/dev/video0', format='v4l2', options=options)
                pc.addTrack(player.video)
                print('track added')
                await pc.setLocalDescription(await pc.createAnswer())
                print('created answer')
                # send our response
                sdp = formatSDP(pc.localDescription.sdp, pc.localDescription.type)
                print('going to reply this: ' + sdp)
                drone_response = drone_publish(ws, sdp)
                print('sent our answer')
        else:
            print('Consumed signal is not an RTCSessionDescription so I am breaking')
            break

def formatSDP(s, type):
    return '{"sdp": {"type": "' + type + '", "sdp": "' + s.replace("\r\n","\\r\\n") + '"}}'

if __name__ == '__main__':
    global pc
    global recorder
    print('wsinit')
    ws_initiate()
