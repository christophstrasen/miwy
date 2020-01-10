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
        parse_command(vStats,'desired,throttle_left,inc,10')
        parse_command(vStats,'desired,throttle_right,inc,10')
        send_command(vStats, commandOut, websocket)
        break
      }
      case 'KeyS': {
        parse_command(vStats,'desired,throttle_left,dec,10')
        parse_command(vStats,'desired,throttle_right,dec,10')
        send_command(vStats, commandOut, websocket)
        break
      }
      case 'KeyA': {
        parse_command(vStats,'desired,throttle_right,inc,10')
        parse_command(vStats,'desired,throttle_left,dec,10')
        send_command(vStats, commandOut, websocket)
        break
      }
      case 'KeyD': {
        parse_command(vStats,'desired,throttle_right,dec,10')
        parse_command(vStats,'desired,throttle_left,inc,10')
        send_command(vStats, commandOut, websocket)
        break
      }
      case 'KeyX': {
        parse_command(vStats,'desired,thrust_vector_vertical,inc,10')
        send_command(vStats, commandOut, websocket)
        break
      }
      case 'KeyZ': {
        parse_command(vStats,'desired,thrust_vector_vertical,dec,10')
        send_command(vStats, commandOut, websocket)
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
        break
      }
      case 'Enter': {
        send_command(vStats, commandOut, websocket)
        break
      }
      }
      //crude but yes we update the UI on every key-press :P
      console.log('update ui')
      updateVehicleStatsBox(vStats)
    },
    true
  )
}

function send_command(vStats, commandOut, websocket) {
  commandOut.data = vStats.exportDesired()
        commandOut.data = vStats.exportDesired()
        commandOut.send(websocket)
        vStats.hasUnsentCHanges = false
  commandOut.send(websocket)
  vStats.hasUnsentCHanges = false
}

//parses the string and updates vStats accordingly
function parse_command(vStats,command) {
  let pieces = command.split(',')
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
