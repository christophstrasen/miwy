// main.js
'use strict'
import { initControlStream, streamprocessor, timeout }  from './streamEvents.js'
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
  streamProc().then(websocket => {
    globStateObj.websocket = websocket //init
    console.log('main: websocket initializing')
    globStateObj.vStats = new vehicleStats(data)
    //console.log(globStateObj.vStats)
    globStateObj.commandOut = new command(websocket) //prepare exactlty one command to send next
    registerInputListeners(globStateObj)
  })
})

const set = (obj, path, val) => { 
    const keys = path.split('.');
    const lastKey = keys.pop();
    const lastObj = keys.reduce((obj, key) => 
        obj[key] = obj[key] || {}, 
        obj); 
    lastObj[lastKey] = val;
};
