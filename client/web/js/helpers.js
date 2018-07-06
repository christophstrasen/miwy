// helpers.js

export function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max))
}

export function simulateDownstreamVehicleStats(simStats, drone) {
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
