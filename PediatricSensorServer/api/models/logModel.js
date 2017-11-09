'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var LogSchema = new Schema({
  name: {
  	type: String,
  	required: 'Device name is required'
  },
  temperature: {
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
  date: {
  	type: Date,
  	default: Date.now
  }
 //  Created_date: {
//     type: Date,
//     default: Date.now
//   },
//   status: {
//     type: [{
//       type: String,
//       enum: ['pending', 'ongoing', 'completed']
//     }],
//     default: ['pending']
//   }
});

module.exports = mongoose.model('Logs', LogSchema);