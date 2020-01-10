// uiActions.js

export function updateVehicleStatsBox(obj) {
  console.log('update stats')
  var tbody = document.getElementById('telemetry')

  var gLeft = document.gauges.get('left')
  gLeft.value = obj.data.throttle_left.actual
  gLeft.update({
    highlights: [ {from: 0, to: obj.data.throttle_left.desired, color: 'rgba(200, 50, 50, .75)'} ]
  })
  
  var gRight = document.gauges.get('right')
  gRight.value = obj.data.throttle_right.actual
  gRight.update({
    highlights: [ {from: 0, to: obj.data.throttle_right.desired, color: 'rgba(200, 50, 50, .75)'} ]
  })
  
  var gVertical = document.gauges.get('vertical') 
  gVertical.value = obj.data.thrust_vector_vertical.actual
  gVertical.update({
    highlights: [ {from: 0, to: obj.data.thrust_vector_vertical.desired, color: 'rgba(200, 50, 50, .75)'} ]
  })
  
  var text = JSON.stringify(obj.data).replace(/,/gi,',\n') //line breaks for html-pre
  tbody.innerText = text
}

export function logToConsole(str, inout) {
  var node = document.createElement('li')
  var textnode = document.createTextNode(str)
  var console = document.getElementById('console' + inout)
  node.appendChild(textnode)
  console.appendChild(node)
}

