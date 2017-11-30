//
//  BluetoothConnector.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/2/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import CoreBluetooth
import SwiftyBluetooth
import LGBluetooth

class BluetoothConnector: NSObject {
    
    static let MANUFACTURER_DATA_KEY = "kCBAdvDataManufacturerData"
    static let DOWNLOAD_LOGS_COMMAND = "*logall"
    static let DOWNLOAD_BUR_COMMAND = "*bur"
    static let PEBBLE_UART_SERVICE = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    static let PEBBLE_RX_CHARACTERISTIC = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
    static let PEBBLE_TX_CHARACTERISTIC = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
    static let DOWNLOAD_DATA_TERMINATION_BETWEEN_VALUE = 44
    static let DOWNLOAD_DATA_TERMINATION_VALUE = 46

    class func startScanningForSensor() {
                SwiftyBluetooth.scanForPeripherals(withServiceUUIDs: nil, timeoutAfter: 15) { scanResult in
                    switch scanResult {
                    case .scanStarted: print("Scanning for advertisement data")
                    // The scan started meaning CBCentralManager scanForPeripherals(...) was called
                    case .scanResult(let peripheral, let advertisementData, let RSSI):
        
                        let isBlueMaestro = BluetoothConnectorObjC.isBlueMaestroDevice(withAdvertisementData: advertisementData)
        
                        if(isBlueMaestro) {
        //                    var data = advertisementData[BluetoothConnector.MANUFACTURER_DATA_KEY] as! Data
        //                    let size8 = MemoryLayout<Int8>.stride
        //                    let size16 = MemoryLayout<Int16>.stride
        //                    let bytes3 = data.withUnsafeBytes {
        //                        Array(UnsafeBufferPointer<Int8>(start: $0, count: data.count / size8))
        //                    }
        //                    let dataArr = Array(data)
        //                    print(dataArr)
        
        
        
        
                         //   PebbleUtilities.parseAdvertisementData(advertisementData)
        
                            let tempoDisc = TDTempoDisc()
                            if(!tempoDisc.fill(withData: advertisementData, name: peripheral.name, uuid: peripheral.identifier.uuidString)) {
                                print("Failed to fill disc, data not long enough")
                                return
                            }
        
                            let pebbleLog = PebbleUtilities.parseLogFromTempoDisc(tempoDisc)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pebbleFound"), object: nil, userInfo: ["log": pebbleLog, "disc": tempoDisc])
                        }
                        // A peripheral was found, your closure may be called multiple time with a .ScanResult enum case.
                    // You can save that peripheral for future use, or call some of its functions directly in this closure.
                    case .scanStopped(let error): print(error)
                        // The scan stopped, an error is passed if the scan stopped unexpectedly
                    }
                }
        
//        LGCentralManager.sharedInstance().scanForPeripherals(byInterval: 5) { peripherals in
//            for res in peripherals! {
//                let peripheral = res as? LGPeripheral
//                let advertisementData = peripheral?.advertisingData
//                let isBlueMaestro = BluetoothConnectorObjC.isBlueMaestroDevice(withAdvertisementData: advertisementData)
//                if(isBlueMaestro) {
//                //    PebbleUtilities.parseAdvertisementData(advertisementData as! [String: Any])
//
//                    let tempoDisc = TDTempoDisc()
//                    tempoDisc.fill(withData: advertisementData, name: peripheral?.name as String!, uuid: peripheral?.uuidString as String!)
//
//                    let pebbleLog = PebbleUtilities.parseLogFromTempoDisc(tempoDisc)
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pebbleFound"), object: nil, userInfo: ["log": pebbleLog, "disc": tempoDisc])
//
//                }
//            }
//        }
    }
    
    class func downloadDataFromSensor(_ parser: DownloadParser) {
        
        LGCentralManager.sharedInstance().scanForPeripherals(byInterval: 2) { peripherals in
            for res in peripherals! {
                let peripheral = res as? LGPeripheral
                print("FOUND PERIPHERAL: \(peripheral!.name)")
                let advertisementData = peripheral?.advertisingData
                let isBlueMaestro = BluetoothConnectorObjC.isBlueMaestroDevice(withAdvertisementData: advertisementData)
                if(isBlueMaestro) {
                    peripheral?.connect(withTimeout: 15, completion: { error in
                        if(error != nil) {
                            print(error?.localizedDescription)
                        }
                        peripheral?.discoverServices(completion: { (result, error2) in
                            if((error2) != nil) {
                                print(error2?.localizedDescription)
                            }
                            for res in result! {
                                let service = res as? LGService
                                
                                service?.discoverCharacteristics(completion: { (result2, error3) in
                                    if(error3 != nil) {
                                        print(error3?.localizedDescription)
                                    }
                                    for res in result2! {
                                        let characteristic = res as? LGCharacteristic
                                        
//
                                        //TODO register somewhere else, only write here
                                        characteristic?.setNotifyValue(true, completion: { error4 in
                                            if(error4 != nil) {
                                                print(error4?.localizedDescription)
                                            }
                                            characteristic?.writeValue(BluetoothConnector.DOWNLOAD_LOGS_COMMAND.data(using: String.Encoding.utf8)!, completion: { err in
                                                if(err != nil) {
                                                    print(err?.localizedDescription)
                                                }
                                            })
                                        }, onUpdate: { data, error5 in
                                            if(error5 != nil) {
                                                print(error5?.localizedDescription)
                                            }
                                            let dataArr = Array(data!)
                                            print(dataArr)
                                            parser.parseData(data!)
                                        })
                                    }
                                })
                            }
                        })
                    })
                }
            }
        }
        
        //        SwiftyBluetooth.scanForPeripherals(withServiceUUIDs: nil, timeoutAfter: 15) { scanResult in
        //            switch scanResult {
        //            case .scanStarted: print("Scanning for advertisement data")
        //            // The scan started meaning CBCentralManager scanForPeripherals(...) was called
        //            case .scanResult(let peripheral, let advertisementData, let RSSI):
        //
        //                let isBlueMaestro = BluetoothConnectorObjC.isBlueMaestroDevice(withAdvertisementData: advertisementData)
        //
        //                if(isBlueMaestro) {
        //                    peripheral.writeValue(ofCharacWithUUID: BluetoothConnector.PEBBLE_RX_CHARACTERISTIC, fromServiceWithUUID: BluetoothConnector.PEBBLE_UART_SERVICE, value: BluetoothConnector.DOWNLOAD_LOGS_COMMAND.data(using: String.Encoding.utf8)!, completion: { result in
        //                        switch result {
        //                        case .failure: print("ERROR writing to RX characteristic")
        //                        case .success: print("Wrote to RX characteristic")
        //                        }
        //                    })
        //
        ////                    peripheral.connect(withTimeout: 10, completion: { result in
        ////                        switch result {
        ////                        case .failure: print("Error connecting to peripheral")
        ////                        case .success: print("Connected to peripheral")
        ////                        peripheral.setNotifyValue(toEnabled: true, forCharacWithUUID: BluetoothConnector.PEBBLE_TX_CHARACTERISTIC, ofServiceWithUUID: BluetoothConnector.PEBBLE_UART_SERVICE) { (error) in
        ////                            switch error {
        ////                            case .failure: print("ERROR Subscribing for TX notifications")
        ////                            case .success: print("Subscribed for TX notifications")
        ////
        ////                            peripheral.writeValue(ofCharacWithUUID: BluetoothConnector.PEBBLE_RX_CHARACTERISTIC, fromServiceWithUUID: BluetoothConnector.PEBBLE_UART_SERVICE, value: BluetoothConnector.DOWNLOAD_LOGS_COMMAND.data(using: String.Encoding.utf8)!, completion: { result in
        ////                                switch result {
        ////                                case .failure: print("ERROR writing to RX characteristic")
        ////                                case .success: print("Wrote to RX characteristic")
        ////                                }
        ////                            })
        ////                            }
        ////                        }
        ////                        }
        ////                    })
        //                }
        //
        //                    //                    var data = advertisementData[BluetoothConnector.MANUFACTURER_DATA_KEY] as! Data
        //                    //                    let size8 = MemoryLayout<Int8>.stride
        //                    //                    let size16 = MemoryLayout<Int16>.stride
        //                    //                    let bytes3 = data.withUnsafeBytes {
        //                    //                        Array(UnsafeBufferPointer<Int8>(start: $0, count: data.count / size8))
        //                    //                    }
        //                    //                    let dataArr = Array(data)
        //                    //                    print(dataArr)
        ////                    let tempoDisc = TDTempoDisc()
        ////                    tempoDisc.fill(withData: advertisementData, name: peripheral.name, uuid: peripheral.identifier.uuidString)
        ////
        ////                    let pebbleLog = PebbleUtilities.parseLogFromTempoDisc(tempoDisc)
        ////                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pebbleFound"), object: nil, userInfo: ["log": pebbleLog, "disc": tempoDisc])
        //                //}
        //                // A peripheral was found, your closure may be called multiple time with a .ScanResult enum case.
        //            // You can save that peripheral for future use, or call some of its functions directly in this closure.
        //            case .scanStopped(let error): print(error)
        //                // The scan stopped, an error is passed if the scan stopped unexpectedly
        //            }
        //        }
    }
}
