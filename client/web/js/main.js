'use strict'
var drone = initScaledrone()

function initScaledrone() {
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
      parseDownstream(data)
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

function parseDownstream(data) {
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

function updateVehicleStatsBox(obj, subbox) {
  var tbody = document.getElementById('telemetry_' + subbox)
  while (tbody.firstChild) {
    tbody.removeChild(tbody.firstChild)
  }
  var textnode = document.createTextNode(JSON.stringify(obj).replace(/,/gi,',\n'))
  tbody.appendChild(textnode)
}

class Command {
  constructor(strCommand = '', destination = 'vehicle') {
    this.strCommand = strCommand
    this.destination = destination
    this.createTime = new Date()
    this.vStatsDesired = null
  }
  toJSON() {
    let { createTime, strCommand, destination, vStatsDesired } = this
    return { createTime, strCommand, destination, vStatsDesired }
  }
  send() {
    if(this.strCommand == '') {
      logToConsole('Client Critical Error: Not allowed to send empty strCommand.','out') //TODO to error console
      return false
    }
    logToConsole(JSON.stringify(this),'out')
    drone.publish({
      room: 'upstream',
      message: this
    })
    this.strCommand = ''
    this.vStatsDesired.hasUnsentChanges = false
    return true
  }
}

function logToConsole(str, inout) {
  var node = document.createElement('li')
  var textnode = document.createTextNode(str)
  var console = document.getElementById('console' + inout)
  node.appendChild(textnode)
  console.appendChild(node)
  node.scrollIntoView()
}
class vehicleStats {
  constructor() {
    this.position_neutral()
    this.incr_step = 10
    this.hasUnsentChanges = false
  }

  position_neutral() {
    this.throttle = 0
    this.throttle_delta_left = 50 //even percent
    this.throttle_delta_right = 50 //even percent
    this.thrust_vector_vertical = 180
    this.center_of_mass_slider_position = 0 //all the way down
    this.hasUnsentChanges = true
  }

  correct_all_out_of_bounds() {

    if(this.throttle_delta_left > 100) {
      this.throttle_delta_left = 100
    }
    else if(this.throttle_delta_left < 0) {
      this.throttle_delta_left = 0
    }

    if(this.throttle_delta_right > 100) {
      this.throttle_delta_right = 100
    }
    else if(this.throttle_delta_right < 0) {
      this.throttle_delta_right = 0
    }

    if(this.throttle > 100) {
      this.throttle = 100
    }
    else if(this.throttle < 0) {
      this.throttle = 0
    }

    if(this.thrust_vector_vertical > 360) {
      this.thrust_vector_vertical = 360
    }
    else if(this.thrust_vector_vertical < 0) {
      this.thrust_vector_vertical = 0
    }

    if(this.center_of_mass_slider_position > 100) {
      this.center_of_mass_slider_position = 100
    }
    else if(this.center_of_mass_slider_position < 0) {
      this.center_of_mass_slider_position = 0
    }
  }
  
  incr_throttle_delta_left() {
    this.throttle_delta_left += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_left
  }
  
  incr_throttle_delta_right() {
    this.throttle_delta_right += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_right
  }
  
  incr_throttle() {
    this.throttle += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle
  }
 
  incr_thrust_vector_vertical() {
    this.thrust_vector_vertical += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.thrust_vector_vertical
  }

  incr_center_of_mass_slider_position() {
    this.center_of_mass_slider_position += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.center_of_mass_slider_position
  }

  decr_throttle_delta_left() {
    this.throttle_delta_left -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_left
  }
  
  decr_throttle_delta_right() {
    this.throttle_delta_right -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_right
  }
  
  decr_throttle() {
    this.throttle -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle
  }
 
  decr_thrust_vector_vertical() {
    this.thrust_vector_vertical -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.thrust_vector_vertical
  }

  decr_center_of_mass_slider_position() {
    this.center_of_mass_slider_position -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.center_of_mass_slider_position
  }

  fromJSON(data) {
    Object.assign(this, data)
  }

  toJSON() {
    let {
      throttle, throttle_delta_left, throttle_delta_right,
      thrust_vector_vertical, center_of_mass_slider_position
    } = this
    return { 
      throttle, throttle_delta_left, throttle_delta_right,
      thrust_vector_vertical, center_of_mass_slider_position
    }
  }
}


function simulateDownstreamVehicleStats(simStats) {
  drone.publish({
    room: 'downstream',
    message: {
      category: 'telemetryUpdate',
      level: 'info',
      note: 'client-side injected for development',
      vehicleStats: simStats
    }
  })
}

function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max))
}

var vStatsInLatest = new vehicleStats() // will be updated automatically on new incoming data
var vStatsDesired = new vehicleStats()
var commandOutNext = new Command()

// global event listeners
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
      commandOutNext.send()
      // simulate
      simulateDownstreamVehicleStats(commandOutNext.vStatsDesired)
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
      let simStats = new vehicleStats()
      simStats.throttle = getRandomInt(100)
      simulateDownstreamVehicleStats(simStats)
    }
    }
  },
  true
)
