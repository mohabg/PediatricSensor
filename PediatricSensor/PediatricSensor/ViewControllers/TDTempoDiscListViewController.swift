//
//  TDTempoDiscListViewController.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/12/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import ANLoader

class TDTempoDiscListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    //should be called devices
    var logs: [PebbleLogModel] = []
    
    var logsToDisks: [PebbleLogModel: TDTempoDisc] = [:]
    
    var parser = DownloadParser()
    
    var expandSectionButtonClicked: [Int: Bool] = [:]

    static let LIST_CELL_IDENTIFIER = "ListCellIdentifier"
    static let HEADER_CELL_IDENTIFIER = "HeaderCellIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "GillSans-Light", size: 25)! ]
        
        registerForNotifications()
        
        lookForDevices()
        
        setUpTableView()

        setUpNavigationBar()
        
        BluetoothConnector.downloadDataFromSensor(parser)
    }
    
    func setUpTableView() {

        self.tableView.register(UINib.init(nibName: "PebbleDataTypeTableViewCell", bundle: nil), forCellReuseIdentifier: TDTempoDiscListViewController.LIST_CELL_IDENTIFIER)
         self.tableView.register(UINib.init(nibName: "PebbleDataTypeTableViewHeaderCell", bundle: nil), forCellReuseIdentifier: TDTempoDiscListViewController.HEADER_CELL_IDENTIFIER)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //removes empty table sections/cells
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none

     //   setBackgroundGradient(from: UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0), to: UIColor.init(red: 67.0/225.0, green: 67.0/225.0, blue: 67.0/225.0, alpha: 1.0))
    }
    
    func lookForDevices() {
        ANLoader.showLoading()
       
        BluetoothConnector.startScanningForSensor()
        ServerConnector.requestDataFromServerForDevice("test")
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.pebbleFound(_:)), name: NSNotification.Name(rawValue:"pebbleFound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.pebbleLogFound(_:)), name: NSNotification.Name(rawValue:"pebbleLogFound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.expandSectionClicked(_:)), name: NSNotification.Name(rawValue:"expandSectionButtonClicked"), object: nil)
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
    
    @objc func expandSectionClicked(_ sender: UIButton) {
        let section = sender.tag
        var indexPaths = [IndexPath]()
        for i in 0...3 {
            indexPaths.append(IndexPath.init(row: i, section: section))
        }
        switch self.expandSectionButtonClicked[section] {
        case nil:
            self.expandSectionButtonClicked[section] = true
            self.tableView.insertRows(at: indexPaths, with: .fade)
        case true?:
            self.expandSectionButtonClicked[section] = !self.expandSectionButtonClicked[section]!

            self.tableView.deleteRows(at: indexPaths, with: .fade)

        case false?:
            self.expandSectionButtonClicked[section] = !self.expandSectionButtonClicked[section]!

            self.tableView.insertRows(at: indexPaths, with: .fade)
        }
        
    //    self.tableView.beginUpdates()
    //    self.tableView.endUpdates()
        self.tableView.reloadData()
    }
    
    func setUpNavigationBar() {
        
        self.navigationItem.title = "Device List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(self.searchForDevice(_:)))
    }

    @objc func searchForDevice(_ sender: UIButton!) {
        let alertController = UIAlertController(title: "Coming Soon", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension TDTempoDiscListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.expandSectionButtonClicked[section] == nil) { return 0 }
        return self.expandSectionButtonClicked[section]! ? 4 : 0
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
        case 1:
            cell.fillWithDataType(.Humidity, usingDisc: disc)
        case 2:
            cell.fillWithDataType(.Pressure, usingDisc: disc)
        case 3:
            cell.fillWithDataType(.DewPoint, usingDisc: disc)
        default: break
    }
     
        return cell
}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dataTypeCell = cell as! PebbleDataTypeTableViewCell
        switch indexPath.row {
        case 0:
              dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 244.0/255.0, green: 67.0/255.0, blue: 54.0/255.0, alpha: 1.0), to: UIColor.white)
        case 1:
               dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 41.0/255.0, green: 98.0/255.0, blue: 255.0/255.0, alpha: 1.0), to: UIColor.white)
        case 2:
              dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 98.0/255.0, green: 0.0/255.0, blue: 234.0/255.0, alpha: 1.0), to: UIColor.white)
        case 3:
            dataTypeCell.setBackgroundGradient(from: UIColor.init(red: 0.0/255.0, green: 200.0/255.0, blue: 83.0/255.0, alpha: 1.0), to: UIColor.white)
        default: break
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.0
//    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: TDTempoDiscListViewController.HEADER_CELL_IDENTIFIER) as! PebbleDataTypeTableViewHeaderCell
        cell.sectionTitleLabel.text = logs[section].deviceName
        cell.expandSectionButton.addTarget(self, action: #selector(self.expandSectionClicked(_:)), for: .touchUpInside)
        cell.expandSectionButton.tag = section
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let infoVC = storyboard?.instantiateViewController(withIdentifier: "TDTempoDiscInfoViewController") as! TDTempoDiscInfoViewController
//        let disc = logsToDisks[logs[indexPath.row]]
//        infoVC.disc = disc
//        infoVC.parser = parser
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        self.show(infoVC, sender: self)
            let graphVC = storyboard?.instantiateViewController(withIdentifier: "PebbleLogGraphViewController") as! PebbleLogGraphViewController
            switch indexPath.row {
            case 0:
                graphVC.graphData = parser.temp
                graphVC.identifier = .Temperature
            case 1:
                graphVC.graphData = parser.humidity
                graphVC.identifier = .Humidity
            case 2:
                graphVC.graphData = parser.pressure
                graphVC.identifier = .Pressure
            case 3:
                graphVC.graphData = parser.dewPoint
                graphVC.identifier = .DewPoint
            default:
                break
            }
            tableView.deselectRow(at: indexPath, animated: true)
            self.show(graphVC, sender: self)
    }
}




