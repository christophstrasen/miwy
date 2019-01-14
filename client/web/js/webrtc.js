//webrtc.js

const drone = new ScaleDrone('AVMWTdaXnSW1UdUV')
// Room name needs to be prefixed with 'observable-'
const roomName = 'observable-webrtc'
const configuration = {
  iceServers: [{
    urls: 'turn:coturn.medigo.com:9444',
    username: 'miwyuser975',
    credential: 'miwyuser975'
  }]
}
var room
var pc
var isOfferer = false
var announceWait = true
var messages = []

function keepAnnouncingWait(i) {
  setTimeout(function() {
    if(!announceWait) { return true } // If in the meantime somebody else showed up and we decided to assume the offerer role
    sendMessage({'CustomSignalingStatus':'waiting'})
    if (--i) {          // If i > 0, keep going
      keepAnnouncingWait(i)       // Call the loop again, and pass it the current value of i
    }
    else { //nobody came within the timeframe
      return false
    }
  }, 5000) //delay by 5 seconds
}

/*
// todo don't need this?
async function checkMessages(i) {
  setTimeout(function() {
		// messages is global
		while(messages.length){
   		message=messages.pop();

		}
    if (--i) {         
      checkMessages(i)  // Call the loop again, and pass it the current value of i
    }
    else { // looped the max ammount
      return false
    }
  }, 5000) //delay by 5 seconds
}
*/

function onSuccess() {}
function onError(error) {
  console.error(error)
}

drone.on('open', error => {
  if (error) {
    return console.error(error)
  }
  // room is global
  room = drone.subscribe('observable-webrtc')
  room.on('open', error => {
    if (error) {
      onError(error)
    }
  })
  
  // Listen to signaling data from Scaledrone
  room.on('data', (message, client) => {
    if(!announceWait) { return true } // we dont want to listen any more
    // Message was sent by us
    if (client.id === drone.clientId) {
      return
    }
    console.log('receive:' + message)
    console.log(message)
    //message = JSON.parse(message)
    if (typeof message !== 'undefined') {
      console.log('is not undefined')
      if(message.CustomSignalingStatus) { // yey, somebody else is waiting, lets offerb
        announceWait = false
        console.log('Somebody is waiting, lets offer.')
        isOfferer = true //global signal that will stop us announcing that WE wait.
        startWebRTC(true)
      }
      if (message.sdp) { // seems we got an offer
        announceWait = false
        console.log('We got an offer')
        isOfferer = false //global signal that will stop us announcing that WE wait.
        startWebRTC(false, message) //It needs this message to extract the offer
      }
    }
  })

  // We are in the room and keep announce that we are active and would receive an offer 
  keepAnnouncingWait(10)
})

// Send signaling data via Scaledrone
function sendMessage(message) {
  console.log('sending: ' + JSON.stringify(message))
  drone.publish({
    room: roomName,
    message
  })
}

export function startWebRTC(isOfferer, initMessage = false) {
  pc = new RTCPeerConnection(configuration)

  // 'onicecandidate' notifies us whenever an ICE agent needs to deliver a
  // message to the other peer through the signaling server
  pc.onicecandidate = event => {
    if (event.candidate) {
      sendMessage({'candidate': event.candidate})
    }
  }

  // If user is offerer let the 'negotiationneeded' event create the offer
  if (isOfferer) {
    pc.onnegotiationneeded = () => {
      pc.createOffer().then(localDescCreated).catch(onError)
    }
  }
  else {
    // we NEED the initMessage because we need to load the remote SDP from it
    // this code is a DUPLICATE from further down. yeah smelly smelly
    pc.setRemoteDescription(new RTCSessionDescription(initMessage.sdp), () => {
      // When receiving an offer lets answer it
      if (pc.remoteDescription.type === 'offer') {
        pc.createAnswer().then(localDescCreated).catch(onError)
      }
    }, onError)
  }

  // When a remote stream arrives display it in the #remoteVideo element
  pc.ontrack = event => {
    const stream = event.streams[0]
    if (!remoteVideo.srcObject || remoteVideo.srcObject.id !== stream.id) {
      remoteVideo.srcObject = stream
    }
  }

  let video_constraints = {
    mandatory: {
      maxHeight: 240,
      maxWidth: 320 
    },
    optional: []
  }

  navigator.mediaDevices.getUserMedia({
    audio: false,
    video: video_constraints,
  }).then(stream => {
    
    // DISABLED the local video for now. The web controller does not need to see his face      
    // Display your local video in #localVideo element
    localVideo.srcObject = stream;
    // Add your stream to be sent to the conneting peer
    // TODO: Only send the audio
    stream.getTracks().forEach(track => pc.addTrack(track, stream))
  }, onError)

  // Listen to signaling data from Scaledrone
  // This takes over from the listener we had defined before.
  // room is global
  room.on('data', (message, client) => {
    // Message was sent by us
    if (client.id === drone.clientId) {
      return
    }

    console.log('got data:' + JSON.stringify(message))
    if (message.sdp) {
      console.log('is sdp')
      // This is called after receiving an offer or answer from another peer
      pc.setRemoteDescription(new RTCSessionDescription(message.sdp), () => {
        // When receiving an offer lets answer it
        if (pc.remoteDescription.type === 'offer') {
          pc.createAnswer().then(localDescCreated).catch(onError)
        }
      }, onError)
    } else if (message.candidate) {
      // Add the new ICE candidate to our connections remote description
      pc.addIceCandidate(
        new RTCIceCandidate(message.candidate), onSuccess, onError
      )
    }
  })
}

function localDescCreated(desc) {
  console.log('localDescCreated');
  console.log(desc);
  pc.setLocalDescription(
    desc,
    () => sendMessage({'sdp': pc.localDescription}),
    onError
  )
}
