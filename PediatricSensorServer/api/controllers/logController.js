'use strict';

var mongoose = require('mongoose'),
  Logs = mongoose.model('Logs'),
  LogHistory = mongoose.model('LogHistory');

exports.get_all_logs = function(req, res) {
  Logs.find({}, function(err, log) {
    if (err) 
    	return res.send(err);
    console.log("Sent all logs for " + req.body.name);
    return res.json(log);
  });
};

exports.save_a_log = function(req, res) {
  var newLog = new Logs(req.body);
  newLog.save(function(err, log) {
    if (err) 
    	return res.send(err);
    console.log("Saved a log for " + req.body.name);
    return res.json(log);
  });
};

exports.get_logs_by_name = function(req, res) {
  Logs.find({'name': req.body.name}, function(err, log) {
    if (err) 
    	return res.send(err);
    console.log("Sent all logs for " + req.body.name);
    return res.json(log);
  });
};

exports.get_last_log_by_name = function(req, res) {
  Logs.find({'name': req.body.name}).sort({'date': -1}).limit(1).exec(function(err, log) {
    if (err)
    	return res.send(err);
    console.log("Sent last log for " + req.body.name);
    return res.json(log);
  });
};

exports.get_last_log_for_devices = function(req, res) {
	var names = req.body.names
	if(typeof names !== 'undefined' && names !== null){
	for (var i = 0; i < names.length; i++) {
	var name = names[i];
		Logs.find({'name': name}).sort({'date': -1}).limit(1).exec(function(err, log) {
			if (err) 
				return res.send(err);
			console.log("Sent last log for device " + name);
			return res.json(log);
		});
	}
	}
	else{
	console.log("Log " + names);
	return res.status(404).send();
	}
};

exports.upload_all_data = function(req, res) {
	var logHistory = new LogHistory(req.body);
	logHistory.save(function(err, log) {
    	if (err) 
    		return res.send(err);
    	console.log("Saved all data for device " + logHistory.name);
    	return res.json(log);
  });
}

exports.get_all_data_by_name = function(req, res) {
  LogHistory.find({"name" : req.body.name}, function(err, logs) {
    if (err) 
    	return res.send(err);
     console.log("Sent all data for " + req.body.name);
    return res.json(logs);
  });
};

exports.get_all_data_for_devices = function(req, res) {
	var names = req.body.names
	if(typeof names !== 'undefined' && names !== null){
	for (var i = 0; i < names.length; i++) {
	var name = names[i];
		LogHistory.find({'name': name}).sort({'date': -1}).limit(1).exec(function(err, logs) {
    		if (err) 
    			return res.send(err);
    		console.log("Sent all data for devices " + req.body.names); 
    		return res.json(logs);
 		 });
	}
	}
	else{
	console.log("Device " + names);
	return res.status(404).send();
	}
};
