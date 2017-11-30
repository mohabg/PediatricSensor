//
//  PebbleLogModel.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/15/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class PebbleLogModel: NSObject {
    
    let deviceName: String
    
    let isFahrenheit: Bool
    let temperature: Float
    let avgTemperature: Float
    let lowestTemperature: Float
    let highestTemperature: Float
    
    let humidity: Float
    let avgHumidity: Float
    let lowestHumidity: Float
    let highestHumidity: Float
    
    let pressure: Float
    let avgPressure: Float
    let lowestPressure: Float
    let highestPressure: Float
    
    let dewPoint: Float
    let avgDewPoint: Float
    let lowestDewPoint: Float
    let highestDewPoint: Float
    
    init(_ name: String, isFahrenheit: Bool, temp: Float, avgTemp: Float, lowestTemp: Float, highestTemp: Float, humidity: Float, avgHumidity: Float, lowestHumidity: Float, highestHumidity: Float, pressure: Float, avgPressure: Float, lowestPressure: Float, highestPressure: Float, dewPoint: Float, avgDewPoint: Float, lowestDewPoint: Float, highestDewPoint: Float) {
        
        self.deviceName = name
        
        self.isFahrenheit = isFahrenheit
        self.temperature = temp
        self.avgTemperature = avgTemp
        self.lowestTemperature = lowestTemp
        self.highestTemperature = highestTemp
        
        self.humidity = humidity
        self.avgHumidity = avgHumidity
        self.highestHumidity = highestHumidity
        self.lowestHumidity = lowestHumidity
        
        self.pressure = pressure
        self.avgPressure = avgPressure
        self.highestPressure = highestPressure
        self.lowestPressure = lowestPressure
        
        self.dewPoint = dewPoint
        self.avgDewPoint = avgDewPoint
        self.highestDewPoint = highestDewPoint
        self.lowestDewPoint = lowestDewPoint
    }
}
