//
//  TDTempoDiscListViewController.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/12/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import ANLoader

class TDTempoDiscListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var logs: [PebbleLogModel] = []
    
    var logsToDisks: [PebbleLogModel: TDTempoDisc] = [:]
    
    var parser = DownloadParser()
    
    static let LIST_CELL_IDENTIFIER = "ListCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForPebbleNotifications()
        
        lookForDevices()
        
        setUpTableView()

        setUpNavigationBar()
        
        BluetoothConnector.downloadDataFromSensor(parser)
    }
    
    func setUpTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: TDTempoDiscListViewController.LIST_CELL_IDENTIFIER)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //removes empty table cells
        self.tableView.tableFooterView = UIView()
    }
    
    func lookForDevices() {
        ANLoader.showLoading()
       
        BluetoothConnector.startScanningForSensor()
        ServerConnector.requestDataFromServerForDevice("test")
    }
    
    func registerForPebbleNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.pebbleFound(_:)), name: NSNotification.Name(rawValue:"pebbleFound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.pebbleLogFound(_:)), name: NSNotification.Name(rawValue:"pebbleLogFound"), object: nil)
    }
    
    @objc func pebbleFound(_ notification: NSNotification) {
        let log = notification.userInfo!["log"] as! PebbleLogModel
        let disc = notification.userInfo!["disc"] as! TDTempoDisc

        //scan for peripheral may get called multiple times
        //keep only unique logs
        //TODO add refresh timer or something
        if(logs.filter{$0.deviceName.contains(log.deviceName)}.count == 0) {
            logsToDisks[log] = disc
            logs.append(log)
        }
        ANLoader.hide()
        print("stopped")
        self.tableView.reloadData()
    }
    
    @objc func pebbleLogFound(_ notification: NSNotification) {
        let log = notification.userInfo!["log"] as! PebbleLogModel
        logs.append(log)
        
        ANLoader.hide()
        print("stopped")

        self.tableView.reloadData()
    }
    
    func setUpNavigationBar() {
        
        self.navigationItem.title = "Devices"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(self.searchForDevice(_:)))
    }
    
    @objc func searchForDevice(_ sender: UIButton!) {
        
    }
}

extension TDTempoDiscListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TDTempoDiscListViewController.LIST_CELL_IDENTIFIER)!
        cell.textLabel?.text = logs[indexPath.row].deviceName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = storyboard?.instantiateViewController(withIdentifier: "TDTempoDiscInfoViewController") as! TDTempoDiscInfoViewController
        let disc = logsToDisks[logs[indexPath.row]]
        infoVC.disc = disc
        infoVC.parser = parser
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.show(infoVC, sender: self)
    }
}




