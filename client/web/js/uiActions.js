// uiActions.js

export function updateVehicleStatsBox(obj) {
  var tbody = document.getElementById('telemetry')
  while (tbody.firstChild) {
    tbody.removeChild(tbody.firstChild)
  }
  var textnode = document.createTextNode(JSON.stringify(obj.data).replace(/,/gi,',\n'))
  tbody.appendChild(textnode)
}

export function logToConsole(str, inout) {
  var node = document.createElement('li')
  var textnode = document.createTextNode(str)
  var console = document.getElementById('console' + inout)
  node.appendChild(textnode)
  console.appendChild(node)
}

