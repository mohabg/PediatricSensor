'use strict';
module.exports = function(app) {
  var logController = require('../controllers/logController');

  app.route('/logs')
    .get(logController.get_all_logs)
    .post(logController.post_a_log);
    
    app.route('/logsByName')
    .post(logController.get_logs_by_name)
    
    app.route('/lastLogByName')
    .post(logController.get_last_log_by_name)
};
