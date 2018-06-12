"use strict";
/* eslint-disable */
function initScaledrone() {
  var drone = new Scaledrone("evz2wEE7dGgA4cQ7");
  /* eslint-enable */

  drone.on("open", function(error) {
    if (error) {
      console.error(error);
      return;
    }
    var room = drone.subscribe("my-room");
    room.on("open", function(error) {
      if (error) {
        console.error(error);
      } else {
        console.log("Connected to room");
      }
    });
    room.on("data", function(data) {
      console.log("Received data:", data);
    });
    drone.publish({
      room: "my-room",
      message: {
        name: "Bob",
        age: 42
      }
    });
  });

  drone.on("close", function(event) {
    console.log("Connection was closed", event);
  });

  drone.on("error", function(error) {
    console.error(error);
  });
}

class Command {
  constructor(strCommand, destination = "vehicle") {
    this.strCommand = strCommand;
    this.destination = destination;
  }
  toJSON() {
    let { strCommand, destination } = this;
    console.log({ strCommand, destination });
    return { strCommand, destination };
  }
  send() {
    logToConsoleIn(JSON.stringify(this));
    return null;
  }
}

function logToConsoleIn(str) {
  var node = document.createElement("li");
  var textnode = document.createTextNode(str);
  node.appendChild(textnode);
  document.getElementById("console").appendChild(node);
}

// global event listeners
window.addEventListener(
  "keydown",
  function(event) {
    switch (event.code) {
      case "KeyW": {
        let cmd = new Command("pitch_up");
        cmd.send();
        break;
      }
      case "KeyS": {
        let cmd = new Command("pitch_down");
        cmd.send();
        break;
      }
      case "KeyA": {
        let cmd = new Command("yaw_left");
        cmd.send();
        break;
      }
      case "KeyD": {
        let cmd = new Command("yaw_right");
        cmd.send();
        break;
      }
      case "Space": {
        let cmd = new Command("position_neutral");
        cmd.send();
        break;
      }
    }
  },
  true
);
