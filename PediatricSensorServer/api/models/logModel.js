'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var LogSchema = new Schema({
  name: {
  	type: String,
  	required: 'Device name is required'
  },
  isFahrenheit: {
  	type: Boolean,
  	required: 'Log temperature in fahrenheit or celsius is required'
  },
  temp: {
    type: Number,
    required: 'Log temperature is required'
  },
  humidity: {
  	type: Number,
  	required: 'Log humidity is required'
  },
  pressure: {
  	type: Number,
  	required: 'Log pressure is required'
  },
  dewPoint: {
  	type: Number,
  	required: 'Log dew point is required'
  },
  avgTemp: {
  	type: Number,
  	required: 'Average temperature is required'
  },
  avgHumidity: {
  	type: Number,
  	required: 'Average humidity is required'
  },
  avgPressure: {
  	type: Number,
  	required: 'Average pressure is required'
  },
  avgDewPoint: {
  	type: Number,
  	required: 'Average dew point is required'
  },
  highestTemp: {
  	type: Number,
  	required: '24 hour highest temperature is required'
  },
  highestHumidity: {
  	type: Number,
  	required: '24 hour highest humidity is required'
  },
  highestPressure: {
  	type: Number,
  	required: '24 hour highest pressure is required'
  },
  highestDewPoint: {
  	type: Number,
  	required: '24 hour highest dew point is required'
  },
  lowestTemp: {
  	type: Number,
  	required: '24 hour lowest temperature is required'
  },
  lowestHumidity: {
  	type: Number,
  	required: '24 hour lowest humidity is required'
  },
  lowestPressure: {
  	type: Number,
  	required: '24 hour lowest pressure is required'
  },
  lowestDewPoint: {
  	type: Number,
  	required: '24 hour lowest dew point is required'
  },
  date: {
  	type: Date,
  	default: Date.now
  }
});

module.exports = mongoose.model('Logs', LogSchema);