// main.js
'use strict'
import { initScaledrone, streamprocessor }  from './streamEvents.js'
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

  globStateObj.drone = initScaledrone(
    new streamprocessor(globStateObj)
  ) // registers the stream listeners
  globStateObj.vStats = new vehicleStats(data)
  console.log('hello')
  console.log(globStateObj.vStats)
  globStateObj.commandOut = new command() 

  registerInputListeners(globStateObj)
})
