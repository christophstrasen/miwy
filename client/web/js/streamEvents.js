// streamEvents.js
import { updateVehicleStatsBox, logToConsole }  from './uiActions.js'

export async function initControlStream(streamprocessor) {

  let socket = new WebSocket("wss://craft.miwy.local:8081")
  socket.onopen = async function(e) {
    console.log("initControlStream: [open] Connection established")
    while (socket.readyState === WebSocket.OPEN) {
      // other code
      await Promise.all([
          socket.send("client: heartbeat"),
          timeout(1000)
      ]).then(data => {
        console.log('initControlStream: sending heartbeat')
      })
      // other code
    }
  };

  socket.onmessage = function(event) {
    console.log(`[message] Data received from server: ${event.data}`)
  }

  socket.onclose = function(event) {
    if (event.wasClean) {
      console.log(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`)
    } else {
      // e.g. server process killed or network down
      // event.code is usually 1006 in this case
      setTimeout(function() {
        initControlStream();
      }, 1000);
      console.log('InitControlStream: [close] Connection died')
    }
  }

  socket.onerror = function(error) {
    console.log(`[error] ${error.message}`)
  }
  
  return socket
  
  //streamprocessor.parseDownstream(data)
}

async function heartbeatGenerator() {

  while (true) {
    // other code
    var [heartbeatresult] = await Promise.all([
        listFiles(nextPageToken).then(requestParents),
        timeout(5000)
    ]);
    // other code
  }
}

function wsheartbeat(ws) {
  socket.send("client: heartbeat")
  return true
}

function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
}

export class streamprocessor {
  constructor(globStateObj) {
    this.globStateObj = globStateObj
  }

  parseDownstream(data) {
    let { vStats } = this.globStateObj
    if(data.hasOwnProperty('data')) {
      vStats.fromJSON(data.vehicleStats) // updates global vehicle stats
      if(! vStatsDesired.hasUnsentChanges) { // if state wasnte changed manuallz we can overwrite
        vStatsDesired.fromJSON(data.vehicleStats)
        updateVehicleStatsBox(vStatsDesired, 'desired')
      }
      logToConsole('parsDownstream: found vehicleStats' + JSON.stringify(vStatsInLatest),'in')
      updateVehicleStatsBox(vStatsInLatest, 'actual')
    } 
  }
}
