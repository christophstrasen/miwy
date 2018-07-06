// inputEvents.js
import { updateVehicleStatsBox }                        from './uiActions.js'
import { simulateDownstreamVehicleStats, getRandomInt } from './helpers.js'
import { vehicleStats }                                 from './vehicleStats.js'

export function registerInputListeners(globStateObj) {
  let { vStatsDesired, commandOutNext, drone } = globStateObj
  window.addEventListener(
    'keydown',
    function(event) {
      switch (event.code) {
      case 'KeyW': {

        commandOutNext.strCommand = 'throttle_up'
        vStatsDesired.incr_throttle()
        commandOutNext.vStatsDesired = vStatsDesired
        updateVehicleStatsBox(vStatsDesired, 'desired')
        break
      }
      case 'KeyS': {
        commandOutNext.strCommand = 'throttle_down'
        vStatsDesired.decr_throttle()
        commandOutNext.vStatsDesired = vStatsDesired
        updateVehicleStatsBox(vStatsDesired, 'desired')
        break
      }
      case 'KeyA': {
        commandOutNext.strCommand = 'yaw_left'
        vStatsDesired.incr_throttle_delta_right()
        commandOutNext.vStatsDesired = vStatsDesired
        updateVehicleStatsBox(vStatsDesired, 'desired')
        break
      }
      case 'KeyD': {
        commandOutNext.strCommand = 'yaw_right'
        vStatsDesired.incr_throttle_delta_left()
        commandOutNext.vStatsDesired = vStatsDesired
        updateVehicleStatsBox(vStatsDesired, 'desired')
        break
      }
      case 'Space': {
        commandOutNext.strCommand = 'position_neutral'
        vStatsDesired.position_neutral()
        commandOutNext.vStatsDesired = vStatsDesired
        updateVehicleStatsBox(vStatsDesired, 'desired')
        break
      }
      case 'Enter': {
        commandOutNext.send(drone)
        // simulate that the vehicle sends back vehicle stats same as we just requested
        simulateDownstreamVehicleStats(commandOutNext.vStatsDesired, drone)
        break
      }
      case 'Digit0':
      case 'Digit1':
      case 'Digit2':
      case 'Digit3':
      case 'Digit4':
      case 'Digit5':
      case 'Digit6':
      case 'Digit7':
      case 'Digit8':
      case 'Digit9': {
        // let cmd = new Command('throttle')
        break
      }
      case 'KeyL': {
        // simulate random incoming vehicle stats
        let simStats = new vehicleStats()
        simStats.throttle = getRandomInt(100)
        simulateDownstreamVehicleStats(simStats, drone)
      }
      }
    },
    true
  )
}

