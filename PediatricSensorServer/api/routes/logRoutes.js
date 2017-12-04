'use strict';
module.exports = function(app) {
  var logController = require('../controllers/logController');

  app.route('/logs')
    .get(logController.get_all_logs)
    
    app.route('/saveLog')
    .post(logController.save_a_log)
    
    app.route('/logsByName')
    .post(logController.get_logs_by_name)
    
    app.route('/lastLogByName')
    .post(logController.get_last_log_by_name)
    
    app.route('/lastLogForDevices')
    .post(logController.get_last_log_for_devices)
    
     app.route('/uploadAllData')
    .post(logController.upload_all_data)
     
     app.route('/downloadAllDataByName')
    .post(logController.get_all_data_by_name)
    
    app.route('/downloadAllDataForDevices')
    .post(logController.get_all_data_for_devices)
};
