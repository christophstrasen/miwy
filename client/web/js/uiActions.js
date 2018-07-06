// uiActions.js

export function updateVehicleStatsBox(obj, subbox) {
  var tbody = document.getElementById('telemetry_' + subbox)
  while (tbody.firstChild) {
    tbody.removeChild(tbody.firstChild)
  }
  var textnode = document.createTextNode(JSON.stringify(obj).replace(/,/gi,',\n'))
  tbody.appendChild(textnode)
}

export function logToConsole(str, inout) {
  var node = document.createElement('li')
  var textnode = document.createTextNode(str)
  var console = document.getElementById('console' + inout)
  node.appendChild(textnode)
  console.appendChild(node)
  node.scrollIntoView()
}

