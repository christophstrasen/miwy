// uiActions.js

export function updateVehicleStatsBox(obj) {
  var tbody = document.getElementById('telemetry')
  //while (typeof tbody.firstChild !== undefined) {
  //  tbody.removeChild(tbody.firstChild)
  //}
  var text = JSON.stringify(obj.data).replace(/,/gi,',\n')
  tbody.innerText = text
}

export function logToConsole(str, inout) {
  var node = document.createElement('li')
  var textnode = document.createTextNode(str)
  var console = document.getElementById('console' + inout)
  node.appendChild(textnode)
  console.appendChild(node)
}

