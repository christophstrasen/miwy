import asyncio
import json
import os
import sys

from aiortc import RTCIceCandidate, RTCSessionDescription
from aiortc.sdp import candidate_from_sdp, candidate_to_sdp


def object_from_string(message_str):
    message = json.loads(message_str)
    if message['type'] in ['answer', 'offer']:
        return RTCSessionDescription(**message)
    elif message['type'] == 'candidate':
        candidate = candidate_from_sdp(message['candidate'].split(':', 1)[1])
        candidate.sdpMid = message['id']
        candidate.sdpMLineIndex = message['label']
        return candidate


def object_to_string(obj):
    if isinstance(obj, RTCSessionDescription):
        message = {
            'sdp': obj.sdp,
            'type': obj.type
        }
    elif isinstance(obj, RTCIceCandidate):
        message = {
            'candidate': 'candidate:' + candidate_to_sdp(obj),
            'id': obj.sdpMid,
            'label': obj.sdpMLineIndex,
            'type': 'candidate',
        }
    else:
        message = {'type': 'bye'}
    return json.dumps(message, sort_keys=True)


class CopyAndPasteSignaling:
    def __init__(self):
        websocket.enableTrace(True)
        self.ws = websocket.WebSocketApp("wss://api.scaledrone.com/v3/websocket",
            on_message = self.receive,
            on_error = self.on_error,
            on_close = self.on_close)
        self.ws.on_open = self.open
        self.ws.run_forever()

    def on_close(ws):
        print("### closed ###")
        # Attemp to reconnect with 2 seconds interval
        # time.sleep(2)
        # initiate()

    async def connect(self):
        print("### Initiating new websocket connection ###")
        def run(*args):
            # handshake and subscribe
            for i in range(1):
                time.sleep(1)
                self.ws.send('{"type":"handshake","channel":"AVMWTdaXnSW1UdUV","version":2,"client_data":null,"callback":0}')
                self.ws.send('{"type":"subscribe","room":"observable-webrtc","callback":1}')
                time.sleep(1) 
            # repeat announcing that we are here and waiting
            for i in range(10):
                self.ws.send('{"type":"publish","room":"observable-webrtc","message":"' + urllib.parse.quote(json.dumps({'CustomSignalingStatus': 'waiting'})) + '"}')
                time.sleep(5)
            time.sleep(100)
            self.close()
        _thread.start_new_thread(run, ())

    async def close(self):
        self.ws.close()

    async def receive(self):
        print("receive:" + urllib.parse.unquote(message))
        return object_from_string(data.decode(self._read_pipe.encoding))

    async def send(self, descr):
        print('-- Please send this message to the remote party --')
        self._write_pipe.write(object_to_string(descr) + '\n')
        print()

def add_signaling_arguments(parser):
    """
    Add signaling method arguments to an argparse.ArgumentParser.
    """
    parser.add_argument('--signaling-host', default='127.0.0.1',
                        help='Signaling host')
    parser.add_argument('--signaling-port', default=1234,
                        help='Signaling port')
    parser.add_argument('--signaling-username', default='username',
                        help='Signaling socket username')
    parser.add_argument('--signaling-password', default='passwordr',
                        help='Signaling socket password')

def create_signaling(args):
        return WebsocketSignaling(args.signaling_host, args.signaling_port, args.signaling_username, args.signaling_password)
