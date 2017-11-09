//
//  BluetoothConnector.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/2/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import SwiftyBluetooth

class BluetoothConnector: NSObject {
    let MANUFACTURER_DATA_KEY = "kCBAdvDataManufacturerData"
    
    class func scanForSensor() {
        SwiftyBluetooth.scanForPeripherals(withServiceUUIDs: nil, timeoutAfter: 15) { scanResult in
            switch scanResult {
            case .scanStarted: print("Scan started")
            // The scan started meaning CBCentralManager scanForPeripherals(...) was called
            case .scanResult(let peripheral, let advertisementData, let RSSI):
                let isBlueMaestro = BluetoothConnectorObjC.isBlueMaestroDevice(withAdvertisementData: advertisementData)
                print(isBlueMaestro)
                if(isBlueMaestro) {
                    print(advertisementData)
                    let tempoDisc = TDTempoDisc()
                    tempoDisc.fill(withData: advertisementData, name: peripheral.name, uuid: peripheral.identifier.uuidString)
                    ServerConnector.uploadDataToServer(peripheral.name, temperature: tempoDisc.currentTemperature as? Int, humidity: tempoDisc.currentHumidity as? Int, pressure: tempoDisc.currentPressure as? Int, dewPoint: tempoDisc.dewPoint as? Int)
                }
                // A peripheral was found, your closure may be called multiple time with a .ScanResult enum case.
            // You can save that peripheral for future use, or call some of its functions directly in this closure.
            case .scanStopped(let error): print(error)
                // The scan stopped, an error is passed if the scan stopped unexpectedly
            }
        }
    }
    
//    @IBAction func convertToJSON(_ sender: Any) {
//        do {
//            let jsonOutput = try JSONSerialization.data(withJSONObject: savePost, options: JSONSerialization.WritingOptions.prettyPrinted)
//            textView.text = String(data: jsonOutput, encoding: String.Encoding.utf8)! as String
//        } catch let error {
//            print("json error: \(error)")
//        }
//    }
}
