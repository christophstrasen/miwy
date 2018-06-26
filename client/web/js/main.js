"use strict";
var drone = initScaledrone();

/* eslint-disable */
function initScaledrone() {
  var drone = new Scaledrone("AVMWTdaXnSW1UdUV"); //miwy dev or prod channel 
  /* eslint-enable */
  drone.on("open", function(error) {
    if (error) {
      console.error(error);
      return;
    }
    var downstream = drone.subscribe("downstream");
    downstream.on("open", function(error) {
      if (error) {
        console.error(error);
        logToConsole(error, "out");
      } else {
        console.log("Connected to room downstream");
        logToConsole("Connected to room downstream","in");
      }
    });
    downstream.on("data", function(data) {
      console.log("Received data:", data);
      logToConsole("Received data:" + JSON.stringify(data), "in");
      parseDownstream(data);
    });
  });

  drone.on("close", function(event) {
    console.log("Connection was closed", event);
  });

  drone.on("error", function(error) {
    console.error(error);
  });

  return drone;
}

function parseDownstream(data) {
  if(data.hasOwnProperty("vehicleStats")) {
    var vStatsIn = new vehicleStats();
    vStatsIn.fromJSON(data.vehicleStats);
    logToConsole("found vehicleStats" + JSON.stringify(vStatsIn),"in");
    updateVehicleStatsBox(vStatsIn, "actual");
  } 
}

function updateVehicleStatsBox(obj, type) {
  var tbody = document.getElementById('telemetry');
  while (tbody.firstChild) {
    tbody.removeChild(tbody.firstChild);
  }
  var textnode = document.createTextNode(JSON.stringify(obj).replace(/\,/gi,",\n"));
  tbody.appendChild(textnode);
}

class Command {
  constructor(strCommand, destination = "vehicle") {
    this.strCommand = strCommand;
    this.destination = destination;
    this.createTime = new Date();
  }
  toJSON() {
    let { createTime, strCommand, destination } = this;
    return { createTime, strCommand, destination };
  }
  send() {
    logToConsole(JSON.stringify(this),"out");
    drone.publish({
      room: "upstream",
      message: this
    });
    return null;
  }
}

function logToConsole(str, inout) {
  var node = document.createElement("li");
  var textnode = document.createTextNode(str);
  var console = document.getElementById("console" + inout);
  node.appendChild(textnode);
  console.appendChild(node);
  node.scrollIntoView();
}

class vehicleStats {
  constructor() {
    this.position_neutral();
  }

  position_neutral() {
    this.throttle = 0;
    this.thrust_vector_horizontal = 0;
    this.thrust_vector_vertical = 0;
    this.motor_left_direction = 1; //forward
    this.motor_left_direction = 1; //forward
    this.center_of_mass_slider_position = 0; //all the way down
  }

  fromJSON(data) {
    Object.assign(this, data);
  }

  toJSON() {
    let {
      throttle, thrust_vector_horizontal, thrust_vector_vertical,
      motor_left_direction, motor_right_direction, center_of_mass_slider_position
    } = this;
    return { 
      throttle, thrust_vector_horizontal, thrust_vector_vertical,
      motor_left_direction, motor_right_direction, center_of_mass_slider_position
    };
  }
}

// global event listeners
window.addEventListener(
  "keydown",
  function(event) {
    switch (event.code) {
      case "KeyW": {
        let cmd = new Command("throttle_up");
        cmd.send();
        break;
      }
      case "KeyS": {
        let cmd = new Command("throttle_down");
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
      case "KeyL": {
        var simStats = new vehicleStats();
        simStats.throttle = 50;
        drone.publish({
          room: "downstream",
          message: {
            category: "telemetryUpdate",
            level: "info",
            note: "client-side injected for development",
            vehicleStats: simStats
          }
        });
      }
    }
  },
  true
);
