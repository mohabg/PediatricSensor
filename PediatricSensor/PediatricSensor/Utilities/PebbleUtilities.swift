//
//  TDTempoDiscUtilities.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/12/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit

class PebbleUtilities: NSObject {
    
    class func parseAdvertisementData(_ data: [String: Any]) -> PebbleLogModel {
       
        let deviceName = data["kCBAdvDataLocalName"] as! String

        let isFahrenheit = PebbleUtilitiesObjC.isFahrenheit(fromAdvertisementData: data)
        
        let temp = PebbleUtilitiesObjC.temperature(fromAdvertisementData: data) as! Float
        let avgTemp = PebbleUtilitiesObjC.avgTemperature(fromAdvertisementData: data) as! Float
        let highestTemp = PebbleUtilitiesObjC.highestTemperature(fromAdvertisementData: data) as! Float
        let lowestTemp = PebbleUtilitiesObjC.lowestTemperature(fromAdvertisementData: data) as! Float
        
        let humidity = PebbleUtilitiesObjC.humidity(fromAdvertisementData: data) as! Float
        let avgHumidity = PebbleUtilitiesObjC.avgHumidity(fromAdvertisementData: data) as! Float
        let highestHumidity = PebbleUtilitiesObjC.highestHumidity(fromAdvertisementData: data) as! Float
        let lowestHumidity = PebbleUtilitiesObjC.lowestHumidity(fromAdvertisementData: data) as! Float
        
        let pressure = PebbleUtilitiesObjC.pressure(fromAdvertisementData: data) as! Float
        let avgPressure = PebbleUtilitiesObjC.avgPressure(fromAdvertisementData: data) as! Float
        let highestPressure = PebbleUtilitiesObjC.highestPressure(fromAdvertisementData: data) as! Float
        let lowestPressure = PebbleUtilitiesObjC.lowestPressure(fromAdvertisementData: data) as! Float
        
        let dewPoint = dewPointCalculation(temp, humidity: humidity)
        let avgDewPoint = dewPointCalculation(avgTemp, humidity: avgHumidity)
        let highestDewPoint = dewPointCalculation(highestTemp, humidity: highestHumidity)
        let lowestDewPoint = dewPointCalculation(lowestTemp, humidity: lowestHumidity)
        
        let pebbleLog = PebbleLogModel.init(deviceName, isFahrenheit: isFahrenheit, temp: temp, avgTemp: avgTemp, lowestTemp: lowestTemp, highestTemp: highestTemp, humidity: humidity, avgHumidity: avgHumidity, lowestHumidity: lowestHumidity, highestHumidity: highestHumidity, pressure: pressure, avgPressure: avgPressure, lowestPressure: lowestPressure, highestPressure: highestPressure, dewPoint: dewPoint, avgDewPoint: avgDewPoint, lowestDewPoint: lowestDewPoint, highestDewPoint: highestDewPoint)
        
        return pebbleLog
    }
    
    class func dewPointCalculation(_ temp: Float, humidity: Float) -> Float {
        return temp - ((100 - humidity) / 5)
    }
    
    class func fahrenheitFromCelsius(_ temp: Float) -> NSNumber {
        return NSNumber.init(value: temp * 1.8 + 32)
    }
    
    class func parseLogFromTempoDisc(_ disc: TDTempoDisc) -> PebbleLogModel {
        
        return PebbleLogModel.init(disc.name!, isFahrenheit: disc.isFahrenheit != nil, temp: disc.currentTemperature as! Float, avgTemp: disc.averageDayTemperature as! Float, lowestTemp: disc.lowestDayTemperature as! Float, highestTemp: disc.highestDayTemperature as! Float, humidity: disc.currentHumidity as! Float, avgHumidity: disc.averageDayHumidity as! Float, lowestHumidity: disc.lowestDayHumidity as! Float, highestHumidity: disc.highestDayHumidity as! Float, pressure: disc.currentPressure as! Float, avgPressure: disc.averageDayPressure as! Float, lowestPressure: disc.lowestDayPressure as! Float, highestPressure: disc.highestDayPressure as! Float, dewPoint: disc.dewPoint as! Float, avgDewPoint: disc.averageDayDew as! Float, lowestDewPoint: disc.lowestDayDew as! Float, highestDewPoint: disc.highestDayDew as! Float)
    }
    
    class func parseLogFromJson(_ json: [String: Any]) -> PebbleLogModel {
        
        return PebbleLogModel.init(json["name"] as! String, isFahrenheit: (json["isFahrenheit"] != nil), temp: json["temp"] as! Float, avgTemp: json["avgTemp"] as! Float, lowestTemp: json["lowestTemp"] as! Float, highestTemp: json["highestTemp"] as! Float, humidity: json["humidity"] as! Float, avgHumidity: json["avgHumidity"] as! Float, lowestHumidity: json["lowestHumidity"] as! Float, highestHumidity: json["highestHumidity"] as! Float, pressure: json["pressure"] as! Float, avgPressure: json["avgPressure"] as! Float, lowestPressure: json["lowestPressure"] as! Float, highestPressure: json["highestPressure"] as! Float, dewPoint: json["dewPoint"] as! Float, avgDewPoint: json["avgDewPoint"] as! Float, lowestDewPoint: json["lowestDewPoint"] as! Float, highestDewPoint: json["highestDewPoint"] as! Float)
    }
}
