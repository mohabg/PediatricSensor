//
//  ViewController.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/2/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     //   BluetoothConnector.scanForSensor()
        ServerConnector.uploadDataToServer("iOS Upload Test", temperature: 100, humidity: 100, pressure: 100, dewPoint: 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

