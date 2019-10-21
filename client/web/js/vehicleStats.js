//vehicleStats.js

export class vehicleStats {
  constructor(data) {
    this.data = data
    //this.position_neutral()
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
    //this.data.forEach(function(value, key){
      if(typeof value.desired != 'undefined') {
        data[key] = {'desired' : value.desired}
      }
    }
    return data
  }

  fromJSON(data) {
    Object.assign(this, data)
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
