//
//  TDTempoDiscListViewController.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/12/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import RATreeView
import ANLoader

class TDTempoDiscListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    //should be called devices
    var logs: [PebbleLogModel] = []
    
    var logsToDisks: [PebbleLogModel: TDTempoDisc] = [:]
    
    var parser = DownloadParser()
    
    static let LIST_CELL_IDENTIFIER = "ListCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let treeView = RATreeView.init(frame: self.view.frame)
        
        registerForPebbleNotifications()
        
        lookForDevices()
        
        setUpTableView()

        setUpNavigationBar()
        
        BluetoothConnector.downloadDataFromSensor(parser)
    }
    
    func setUpTableView() {
     //   self.tableView.register(PebbleDataTypeTableViewCell.self, forCellReuseIdentifier: TDTempoDiscListViewController.LIST_CELL_IDENTIFIER)
        self.tableView.register(UINib.init(nibName: "PebbleDataTypeTableViewCell", bundle: nil), forCellReuseIdentifier: TDTempoDiscListViewController.LIST_CELL_IDENTIFIER)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //removes empty table cells
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.backgroundView = nil
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
        
        self.navigationItem.title = "Device List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(self.searchForDevice(_:)))
    }
    
    @objc func searchForDevice(_ sender: UIButton!) {
        
    }
}

extension TDTempoDiscListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return logs[section].deviceName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TDTempoDiscListViewController.LIST_CELL_IDENTIFIER)! as! PebbleDataTypeTableViewCell
        let disc = logsToDisks[logs[indexPath.section]]
        switch indexPath.row {
        case 0:
            cell.fillWithDataType(.Temperature, usingDisc: disc)
        //    cell.backgroundColor = UIColor.init(red: 244, green: 67, blue: 54, alpha: 1.0)
        case 1:
            cell.fillWithDataType(.Humidity, usingDisc: disc)
        //    cell.contentView.backgroundColor = UIColor.init(red: 244, green: 67, blue: 54, alpha: 1.0)
        case 2:
            cell.fillWithDataType(.Pressure, usingDisc: disc)
        case 3:
            cell.fillWithDataType(.DewPoint, usingDisc: disc)
        default: break
    }
     //   cell.textLabel?.text = logs[indexPath.row].deviceName
    //    cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//        cell.frame = tableView.bounds;
//        cell.layoutIfNeeded()
//        cell.collectionView.reloadData()
//        cell.collectionViewHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dataTypeCell = cell as! PebbleDataTypeTableViewCell
        switch indexPath.row {
        case 0:
          //  dataTypeCell.background.backgroundColor = UIColor.init(red: 213.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//            dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 213.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0), to: UIColor.init(red: 41.0/255.0, green: 98.0/255.0, blue: 255.0/255.0, alpha: 1.0))
              dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 244.0/255.0, green: 67.0/255.0, blue: 54.0/255.0, alpha: 1.0), to: UIColor.white)
        case 1:
          //  dataTypeCell.background.backgroundColor = UIColor.init(red: 41.0/255.0, green: 98.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//           dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 41.0/255.0, green: 98.0/255.0, blue: 255.0/255.0, alpha: 1.0), to: UIColor.init(red: 98.0/255.0, green: 0.0/255.0, blue: 234.0/255.0, alpha: 1.0))
               dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 41.0/255.0, green: 98.0/255.0, blue: 255.0/255.0, alpha: 1.0), to: UIColor.white)
        case 2:
          //  dataTypeCell.background.backgroundColor = UIColor.init(red: 98.0/255.0, green: 0.0/255.0, blue: 234.0/255.0, alpha: 1.0)

//            dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 98.0/255.0, green: 0.0/255.0, blue: 234.0/255.0, alpha: 1.0), to: UIColor.init(red: 0.0/255.0, green: 200.0/255.0, blue: 83.0/255.0, alpha: 1.0))
              dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 98.0/255.0, green: 0.0/255.0, blue: 234.0/255.0, alpha: 1.0), to: UIColor.white)
        case 3:
          //  dataTypeCell.background.backgroundColor = UIColor.init(red: 0.0/255.0, green: 200.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            
            dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 0.0/255.0, green: 200.0/255.0, blue: 83.0/255.0, alpha: 1.0), to: UIColor.white)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
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

extension TDTempoDiscListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TDTempoDiscInfoViewController.INFO_CELL_IDENTIFIER, for: indexPath) as! TDTempoDiscInfoCell
        cell.frame = CGRect.init(x: cell.frame.origin.x, y: cell.frame.origin.y, width: 100.0, height: 150.0)
        
        return cell
    }
}




