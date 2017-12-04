'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var LogHistorySchema = new Schema({
	name: {
  		type: String,
  		required: 'Device name is required'
  },
  	temp: {
  		type: [Number],
  		required: 'Temperature data is required'
  	},
  	humidity: {
  		type: [Number],
  		required: 'Humidity data is required'
  	},
  	pressure: {
  		type: [Number],
  		required: "Pressure data is required"
  	},
  	dewPoint: {
  		type: [Number],
  		required: "Dew Point data is required"
  	},
  	date: {
  		type: Date,
  		default: Date.now
  	}
});

module.exports = mongoose.model('LogHistory', LogHistorySchema);