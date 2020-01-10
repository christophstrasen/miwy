//vehicleStats.js

export class vehicleStats {
  constructor(data) {
    this.data = data
    this.hasUnsentChanges = false
  }

  inc(what,by) {
    this.data[what].desired += parseInt(by)
    this.ensure_property_range(what)
    this.hasUnsentChanges = true
  }
  
  dec(what,by) {
    this.data[what].desired -= parseInt(by)
    this.ensure_property_range(what)
    this.hasUnsentChanges = true
  }

  ensure_property_range(what) {
    if(this.data[what].desired < this.data[what].range.from) {
      this.data[what].desired = this.data[what].range.from
    }
    if(this.data[what].desired > this.data[what].range.to) {
      this.data[what].desired = this.data[what].range.to
    }
  }

  exportDesired() {
    var data = {}
    for (let [key, value] of Object.entries(this.data)) {
      if(typeof value.desired != 'undefined') {
        data[key] = {'desired' : value.desired}
      }
    }
    return data
  }

  fromJSON(recvData) {
    this.data['throttle_left'].actual = recvData.data['throttle_left'].actual 
    this.data['throttle_right'].actual = recvData.data['throttle_right'].actual 
    this.data['thrust_vector_vertical'].actual = recvData.data['thrust_vector_vertical'].actual 
  }

  toJSON() {
    let {
      throttle, throttle_delta_left, throttle_delta_right,
      thrust_vector_vertical, center_of_mass_slider_position
    } = this
    return { 
      throttle, throttle_delta_left, throttle_delta_right,
      thrust_vector_vertical, center_of_mass_slider_position
    }
  }
}
