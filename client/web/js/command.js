// command.js
import { logToConsole } from './uiActions.js'

export class command {
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
  send(drone) {
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
