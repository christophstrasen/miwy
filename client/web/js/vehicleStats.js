//vehicleStats.js

export class vehicleStats {
  constructor() {
    this.position_neutral()
    this.incr_step = 10
    this.hasUnsentChanges = false
  }

  position_neutral() {
    this.throttle = 0
    this.throttle_delta_left = 50 //even percent
    this.throttle_delta_right = 50 //even percent
    this.thrust_vector_vertical = 180
    this.center_of_mass_slider_position = 0 //all the way down
    this.hasUnsentChanges = true
  }

  correct_all_out_of_bounds() {

    if(this.throttle_delta_left > 100) {
      this.throttle_delta_left = 100
    }
    else if(this.throttle_delta_left < 0) {
      this.throttle_delta_left = 0
    }

    if(this.throttle_delta_right > 100) {
      this.throttle_delta_right = 100
    }
    else if(this.throttle_delta_right < 0) {
      this.throttle_delta_right = 0
    }

    if(this.throttle > 100) {
      this.throttle = 100
    }
    else if(this.throttle < 0) {
      this.throttle = 0
    }

    if(this.thrust_vector_vertical > 360) {
      this.thrust_vector_vertical = 360
    }
    else if(this.thrust_vector_vertical < 0) {
      this.thrust_vector_vertical = 0
    }

    if(this.center_of_mass_slider_position > 100) {
      this.center_of_mass_slider_position = 100
    }
    else if(this.center_of_mass_slider_position < 0) {
      this.center_of_mass_slider_position = 0
    }
  }
  
  incr_throttle_delta_left() {
    this.throttle_delta_left += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_left
  }
  
  incr_throttle_delta_right() {
    this.throttle_delta_right += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_right
  }
  
  incr_throttle() {
    this.throttle += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle
  }
 
  incr_thrust_vector_vertical() {
    this.thrust_vector_vertical += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.thrust_vector_vertical
  }

  incr_center_of_mass_slider_position() {
    this.center_of_mass_slider_position += this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.center_of_mass_slider_position
  }

  decr_throttle_delta_left() {
    this.throttle_delta_left -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_left
  }
  
  decr_throttle_delta_right() {
    this.throttle_delta_right -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle_delta_right
  }
  
  decr_throttle() {
    this.throttle -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.throttle
  }
 
  decr_thrust_vector_vertical() {
    this.thrust_vector_vertical -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.thrust_vector_vertical
  }

  decr_center_of_mass_slider_position() {
    this.center_of_mass_slider_position -= this.incr_step
    this.correct_all_out_of_bounds()
    this.hasUnsentChanges = false
    return this.center_of_mass_slider_position
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
