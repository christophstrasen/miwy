// command.js
import { logToConsole } from './uiActions.js'

export class command {
  constructor(destination = 'craft') {
    this.destination = destination
    this.createTime = new Date()
    this.data = null
  }
  toJSON() {
    let { createTime, destination, data } = this
    return { createTime, destination, data }
  }
  send(drone) {
    logToConsole(JSON.stringify(this),'out')
    ws.publish({
      room: 'upstream',
      message: this
    })
    this.strCommand = ''
    return true
  }
}
