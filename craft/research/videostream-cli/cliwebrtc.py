import argparse
import asyncio
import _thread
import logging
import time
import json
import urllib.parse
import websocket
import sys
import threading

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
countsrflx = 0
offerMessage = False
signalingRecieved = False

def is_jsonable(x):
    try:
        json.dumps(x)
        return True
    except:
        return False

def drone_publish(ws,s):
    if(is_jsonable(s)):
        print("sending " + json.dumps(s))
    else:
        print("Sending not serializable")
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
    global countsrflx
    global signalingRecieved
    global offerMessage
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
            signalingRecieved = True
            # Someone is waiting so we should offer. We only react on waiting events if we are not already offering
            
            # we will for now NOT offer
            ## if message.get("CustomSignalingStatus") == "waiting" and isOfferer == False:
            ##    announceWait = False
            ##    isOfferer = True
            ##    print("we offer")
            ##    webrtc_init(ws)
            # Someone offered so lets look at it - offer may online be recieved once or things become undefined!
            if message.get('sdp', {}).get('type') == 'offer':
                offerMessage = message.get('sdp')
                announceWait = False
                isOfferer = False #should still be false anyhow
                print('They offer')

async def check_messages():
    global messages
    global isOfferer
    for i in range(100):
        while messages:
            msg = messages.pop(0)
            print('popped from list:' + json.dumps(msg))
            return msg
        await asyncio.sleep(1)
    return False

def webrtc_init(ws): # 3
    global messages
    global offerMessage
    print('logging')
    logging.basicConfig(level=logging.DEBUG)

    # create signaling and peer connection
    
    ice = RTCIceServer('turn:coturn.medigo.com:9081')
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
            ws=ws,
            messages=messages,
            offerMessage=offerMessage))
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

def ws_initiate(): # 2
    global signalingRecieved 
    websocket.enableTrace(False)
    ws = websocket.WebSocketApp("wss://api.scaledrone.com/v3/websocket",
        on_message = on_message,
        on_error = on_error,
        on_close = on_close)
    ws.on_open = on_open
    wst = threading.Thread(target=ws.run_forever)
    wst.daemon = True
    wst.start()

    conn_timeout = 5
    while not ws.sock.connected and conn_timeout:
        print('checking ws connection')
        time.sleep(1)
        conn_timeout -= 1

    print('WebSocket connected, now I will wait until we receive the first signaling.')
    while ws.sock.connected and not signalingRecieved:
        print('Waiting for signaling' )
        time.sleep(1)

    if ws.sock.connected and signalingRecieved:
        print('Received first signaling. Will now give a moment for the data to arrive before starting our webrtc. We are waiting blind ..' )
        time.sleep(5)
        print('Waited enough, starting webrtc_init')
        webrtc_init(ws) # 3
    else:
        print('Error in blind signal waiting. We either lost websocket connection or something weird happened.')

    print('webrtc_init was started. I will sleep here')
    time.sleep(100)

def create_rectangle(width, height, color):
    data_bgr = numpy.zeros((height, width, 3), numpy.uint8)
    data_bgr[:, :] = color
    return data_bgr

def extractCandidates(messages,pc):
    while messages:
        obj = messages.pop()
        print('popped from list:' + json.dumps(obj))
        if obj.get('candidate', {}):
            print('found candidate' + obj.get('candidate').get('candidate'))
            candidate = sdp.candidate_from_sdp(obj.get('candidate').get('candidate'))
            if obj.get('candidate').get('sdpMid'):
                candidate.sdpMid = obj.get('candidate').get('sdpMid')
            if obj.get('candidate').get('sdpMLineIndex'):
                candidate.sdpMLineIndex = obj.get('candidate').get('sdpMLineIndex')
            print('adding ICECandidate ')
    return pc

async def run(pc, recorder, ws, messages, offerMessage):
    @pc.on('track')
    def on_track(track):
        print('Receiving video')
        ### assert track.kind == 'video'
        recorder.addTrack(track)

    if isOfferer:
        # send offer
        ### pc.addTrack(FlagVideoStreamTrack())
        print('Adding my media streams');
        options = {'video_size': '640x480','input_format': 'h264', '-c:v': 'copy'}
        player = MediaPlayer('/dev/video0', format='v4l2', options=options)
        pc.addTrack(player.video)
        await pc.setLocalDescription(await pc.createOffer())
        drone_publish(ws, pc.localDescription)


    messages.reverse()
    while messages:
        print('Consume Signal, checking for messages')
        
        msg = messages.pop()
        # We receive a remote session description, now this can only be an offer here
        if(offerMessage): 
            desc = RTCSessionDescription(offerMessage.get('sdp'), type=offerMessage.get('type') )
            # print('enter now')
            # sdp = sys.stdin.readline()
            # sdp = sdp.replace("\\r\\n","\r\n")
            # desc = RTCSessionDescription(sdp, type='offer')
            print('start recorder')
            await recorder.start()

            print('Created desc, now setting it')
            await pc.setRemoteDescription(desc)
            
            print('add all candidates')
            pc = extractCandidates(messages,pc)
            if desc.type == 'offer':
                print('its offer, lets add our video')
                options = {'video_size': '640x480'}
                player = MediaPlayer('/dev/video0', format='v4l2', options=options)
                pc.addTrack(player.video)
                print('track added')
                await pc.setLocalDescription(await pc.createAnswer())
                print('created answer')
                print(pc.getTransceivers())
                # send our response
                sdp = formatSDP(pc.localDescription.sdp, pc.localDescription.type)
                print('going to reply this: ' + sdp)
                drone_response = drone_publish(ws, sdp)
                print('answer has been sent')
        else:
            print('Something is wromg, the offerMessage should be not false')
            break

def formatSDP(s, type):
    return '{"sdp": {"type": "' + type + '", "sdp": "' + s.replace("\r\n","\\r\\n") + '"}}'

if __name__ == '__main__': # 1
    global pc
    global recorder
    print('wsinit')
    ws_initiate()
