'use strict';

var mongoose = require('mongoose'),
  Logs = mongoose.model('Logs');


exports.get_all_logs = function(req, res) {
  Logs.find({}, function(err, log) {
    if (err)
      res.send(err);
    res.json(log);
  });
};


exports.get_logs_by_name = function(req, res) {
console.log("Request: " + req.body.name)
  Logs.find({'name': req.body.name}, function(err, log) {
    if (err)
      res.send(err);
    res.json(log);
  });
};

exports.get_last_log_by_name = function(req, res) {
  Logs.find({'name': req.body.name}).sort({'date': -1}).limit(1).exec(function(err, log) {
    if (err)
      res.send(err);
    res.json(log);
  });
};

exports.post_a_log = function(req, res) {
  var newLog = new Logs(req.body);
  newLog.save(function(err, log) {
    if (err)
      res.send(err);
    res.json(log);
  });
};


// exports.read_a_task = function(req, res) {
//   Logs.findById(req.params.taskId, function(err, task) {
//     if (err)
//       res.send(err);
//     res.json(task);
//   });
// };

// 
// exports.update_a_task = function(req, res) {
//   Logs.findOneAndUpdate({_id: req.params.taskId}, req.body, {new: true}, function(err, task) {
//     if (err)
//       res.send(err);
//     res.json(task);
//   });
// };
// 

// exports.delete_a_task = function(req, res) {
//   Logs.remove({
//     _id: req.params.taskId
//   }, function(err, task) {
//     if (err)
//       res.send(err);
//     res.json({ message: 'Task successfully deleted' });
//   });
// };