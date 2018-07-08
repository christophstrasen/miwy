// streamEvents.js
import { updateVehicleStatsBox, logToConsole }  from './uiActions.js'

export function initScaledrone(streamprocessor) {
  // eslint-disable-next-line no-undef
  var drone = new Scaledrone('AVMWTdaXnSW1UdUV') //miwy dev or prod channel 
  drone.on('open', function(error) {
    if (error) {
      logToConsole(error)
      return
    }
    var downstream = drone.subscribe('downstream')
    downstream.on('open', function(error) {
      if (error) {
        logToConsole(error, 'out')
      } else {
        logToConsole('Connected to room downstream','in')
      }
    })
    downstream.on('data', function(data) {
      logToConsole('Received data:' + JSON.stringify(data), 'in')
      streamprocessor.parseDownstream(data)
    })
  })

  drone.on('close', function(event) {
    logToConsole('Connection was closed', event)
  })

  drone.on('error', function(error) {
    logToConsole(error)
  })

  return drone
}

export class streamprocessor {
  constructor(globStateObj) {
    this.globStateObj = globStateObj
  }

  parseDownstream(data) {
    let { vStatsInLatest, vStatsDesired } = this.globStateObj
    if(data.hasOwnProperty('vehicleStats')) {
      vStatsInLatest.fromJSON(data.vehicleStats) // updates global vehicle stats
      if(! vStatsDesired.hasUnsentChanges) { // if state wasnte changed manuallz we can overwrite
        vStatsDesired.fromJSON(data.vehicleStats)
        updateVehicleStatsBox(vStatsDesired, 'desired')
      }
      logToConsole('found vehicleStats' + JSON.stringify(vStatsInLatest),'in')
      updateVehicleStatsBox(vStatsInLatest, 'actual')
    } 
  }
}
