// command.js
import { logToConsole } from './uiActions.js'

export class command {
  constructor(websocket) {
    this.websocket = websocket
    this.sender = 'client'
    this.createTime = new Date()
    this.data = null
  }
  toJSON() {
    let { createTime, sender, data } = this
    return { createTime, sender, data }
  }
  send() {
    //@TODO: Add error handling for if the socket is not OPEN
    logToConsole(JSON.stringify(this),'out')
    //this.websocket.send(
    window.websocket.send(
        JSON.stringify(this)
    )
    this.strCommand = ''
    return true
  }
}
