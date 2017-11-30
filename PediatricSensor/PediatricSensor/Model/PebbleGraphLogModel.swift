//
//  PebbleGraphLogModel.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/23/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class PebbleGraphLogModel: NSObject {
    
    var dates = [Date]()
    var temperature = [Double]()
    var humidity = [Double]()
    var pressure = [Double]()
    var dewPoint = [Double]()
    
    init(_ temperature: [Double], humidity: [Double], pressure: [Double], dewPoint: [Double], dates: [Date]) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.dewPoint = dewPoint
        self.dates = dates
    }
}
