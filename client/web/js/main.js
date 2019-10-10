// main.js
'use strict'
import { initControlStream, streamprocessor }  from './streamEvents.js'
import { vehicleStats }                     from './vehicleStats.js'
import { command }                          from './command.js'
import { registerInputListeners }           from './inputEvents.js'
import { globState }                        from './globState.js'


let fetchVehicleDefaults = async () => {
  let response = await fetch('vehicle_stats.json');
  let result = await response.json()
  return result
}
fetchVehicleDefaults().then(data => {
  // initialise global state obj
  var globStateObj = new globState()

  let streamProc = async () => {
    return await initControlStream(new streamprocessor(globStateObj))
  }
  streamProc().then(streamProc => {
    globState.streamProc = streamProc //init
    console.log('main: streamProc initialized')
  })
    // registers the stream listeners
  //globStateObj.vStats = new vehicleStats(data)
  //console.log('hello')
  //console.log(globStateObj.vStats)
  //globStateObj.commandOut = new command() 

  //registerInputListeners(globStateObj)
})
