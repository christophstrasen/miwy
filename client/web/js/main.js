'use strict'
import { initScaledrone, streamprocessor }  from './streamEvents.js'
import { vehicleStats }                     from './vehicleStats.js'
import { command }                          from './command.js'
import { registerInputListeners }           from './inputEvents.js'
import { globState }                        from './globState.js'
import { startWebRTC }                      from './webrtc.js'

// initialise global state obj
let globStateObj = new globState()

globStateObj.drone = initScaledrone(
  new streamprocessor(globStateObj)
) // registers the stream listeners

globStateObj.vStatsInLatest = new vehicleStats() // updates later w. incoming data with the help of above streamEvents

globStateObj.vStatsDesired = new vehicleStats() // updates later via inputEvents

globStateObj.commandOutNext = new command() // command can be modified, values incremented etc. before sendingi

registerInputListeners(globStateObj)
