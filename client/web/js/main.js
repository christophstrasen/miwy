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
