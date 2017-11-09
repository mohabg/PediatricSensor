var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000,
  mongoose = require('mongoose'),
  Log = require('./api/models/logModel'), 
  bodyParser = require('body-parser');
  
// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost/PediatricSensorDB'); 

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var routes = require('./api/routes/logRoutes'); //importing route
routes(app); //register the route

app.listen(port);

console.log('Pediatric Sensor RESTful API server started on: ' + port);

