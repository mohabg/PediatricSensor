var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000,
  mongoose = require('mongoose'),
  Log = require('./api/models/logModel'), 
  LogHistory = require('./api/models/logHistoryModel'),
  bodyParser = require('body-parser');
  
// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost/PediatricSensorDB'); 

app.use(bodyParser.urlencoded({ extended: true, limit: '5mb', parameterLimit: 1000000}));
app.use(bodyParser.json({limit: '5mb'}));

var routes = require('./api/routes/logRoutes'); //importing route
routes(app); //register the route

app.listen(port);

console.log('Pediatric Sensor REST API server started on port: ' + port);

