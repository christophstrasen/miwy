// inputEvents.js
import { updateVehicleStatsBox }                        from './uiActions.js'
import { simulateDownstreamVehicleStats, getRandomInt } from './helpers.js'
import { vehicleStats }                                 from './vehicleStats.js'

export function registerInputListeners(globStateObj) {
  let { vStats, commandOut, websocket } = globStateObj
  window.addEventListener(
    'keydown',
    function(event) {
      switch (event.code) {
      case 'KeyW': {
        parse_command(vStats,'desired,throttle,inc,10')
        break
      }
      case 'KeyS': {
        parse_command(vStats,'desired,throttle,dec,10')
        console.log(vStats)
        break
      }
      case 'KeyA': {
        parse_command(vStats,'desired,throttle_delta_right,inc,10')
        parse_command(vStats,'desired,throttle_delta_left,dec,10')
        break
      }
      case 'KeyD': {
        parse_command(vStats,'desired,throttle_delta_right,dec,10')
        parse_command(vStats,'desired,throttle_delta_left,inc,10')
        break
      }
      case 'Space': {
        //later neutral position
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
        simulateDownstreamVehicleStats(simStats, websocket)
        break
      }
      case 'Enter': {
        console.log(vStats)
        //commandOut.data = vStats.data
        commandOut.data = vStats.exportDesired()
        commandOut.send(websocket)
        vStats.hasUnsentCHanges = false
        // simulate that the vehicle sends back vehicle stats same as we just requested
        // simulateDownstreamVehicleStats(commandOutNext.vStatsDesired, websocket)
        break
      }
      }
      //crude but yes we update the UI on every key-press :P
      updateVehicleStatsBox(vStats)
    },
    true
  )
}

//parses the string and updates vStats accordingly
function parse_command(vStats,command) {
  console.log(vStats)
  let pieces = command.split(',')
  console.log(pieces)
  switch (pieces[0]) {
    case 'desired':
      switch (pieces[2]) {
        case 'inc': vStats.inc(pieces[1],pieces[3])
          break
        case 'dec': vStats.dec(pieces[1],pieces[3])
          break
        default:
          console.log('Error: No inc or dec found fo top level "desired" command namespace found. Command string malformed?')
          return false
      }
      break
    default:
      console.log('Error: No top level command namespace found. Command string malformed?')
      return false
  }
  return true
}
