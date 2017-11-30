//
//  DownloadParser.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/29/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class DownloadParser: NSObject {
    
    enum DownloadType {
        case Temperature
        case Humidity
        case Pressure
        case DewPoint
    }
    //temp data gets sent first
    var downloadType = DownloadType.Temperature
    var temp = [Double]()
    var humidity = [Double]()
    var pressure = [Double]()
    var dewPoint: [Double] {
        var dews = [Double]()
        for i in 0...temp.count-1 {
            dews.append(Double(PebbleUtilities.dewPointCalculation(Float(temp[i]), humidity: Float(humidity[i]))))
        }
        return dews
    }
    
    func parseData(_ data: Data) {
        if(data.count == 15) {
            parseHeader(data)
            return
        }
        var i = 0
        while (i < data.count) {
            let arr = Array(data)
            if(arr[i] == BluetoothConnector.DOWNLOAD_DATA_TERMINATION_BETWEEN_VALUE && arr[i+1] == BluetoothConnector.DOWNLOAD_DATA_TERMINATION_BETWEEN_VALUE) {
                
                switch downloadType {
                case .Temperature: downloadType = .Humidity
                case .Humidity: downloadType = .Pressure
                case .Pressure: downloadType = .DewPoint
                case .DewPoint: print("ERROR: Should only be three codes for type separation")
                }
                return
            }
            if(arr[i] == BluetoothConnector.DOWNLOAD_DATA_TERMINATION_VALUE && arr[i+1] == 0) {
                return
            }
            let value = Double(PebbleUtilitiesObjC.uintValueLsb(arr[i + 1], msb: arr[i])) / 10.0
            switch downloadType {
            case .Temperature: temp.append(PebbleUtilities.fahrenheitFromCelsius(Float(value)).doubleValue)
            case .Humidity: humidity.append(value)
            case .Pressure: pressure.append(value)
            case .DewPoint: print("ERROR: Dew point is computed from temperature and humidity")
            }
            i += 2
        }
    }
    
    func parseHeader(_ data: Data) {
        
    }
}
