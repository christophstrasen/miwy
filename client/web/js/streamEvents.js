// streamEvents.js
import { updateVehicleStatsBox, logToConsole }  from './uiActions.js'

export async function initControlStream(globStateObj) {
  let streamproc = new streamprocessor(globStateObj)
  //@TODO implement a custom connection timeout so that connections can recover faster
  let socket = new WebSocket("wss://craft.miwy.local:8081")
  socket.onopen = async function(e) {
    console.log("initControlStream: [open] Connection established")
    while (socket.readyState === WebSocket.OPEN) {
      // heartbeat
      await Promise.all([
          socket.send("client: heartbeat"),
          timeout(10000)
      ]).then(data => {
        console.log('initControlStream: sending heartbeat')
      })
    }
  };

  socket.onmessage = function(event) {
    console.log(`[message] Data received from server: ${event.data}`)
    streamproc.parseDownstream(event.data)
  }

  socket.onclose = function(event) {
    if (event.wasClean) {
      console.log(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`)
    } else {
      console.log(`[close] Connection closed NOT clean, code=${event.code} reason=${event.reason}`)
      // e.g. server process killed or network down
      // event.code is usually 1006 in this case
      setTimeout(function() {
        initControlStream(globStateObj);
      }, 1000);
      console.log('InitControlStream: [close] Connection died')
    }
  }

  socket.onerror = function(error) {
    console.log(`[error] ${error.message}`)
  }
  window.websocket = socket
  return socket
  
  //streamprocessor.parseDownstream(data)
}


export function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
}

export class streamprocessor {
  constructor(globStateObj) {
    this.globStateObj = globStateObj
  }

  parseDownstream(msg) {
    let { vStats } = this.globStateObj
    var json = JSON.parse(msg)
    if(json.hasOwnProperty('data')) {
      vStats.fromJSON(json) // updates global vehicle stats
      /*
      if(! vStatsDesired.hasUnsentChanges) { // if state wasnt changed manually we can overwrite
        vStatsDesired.fromJSON(data.vehicleStats)
        updateVehicleStatsBox(vStatsDesired, 'desired')
      }
        print('handle: all tasks done result is {}'.format(res));
      */
      logToConsole('parsDownstream: found vehicleStats ' + msg,'in')
      updateVehicleStatsBox(vStats)
    } 
  }
}
