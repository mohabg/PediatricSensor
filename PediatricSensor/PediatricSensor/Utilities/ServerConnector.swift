//
//  ServerConnector.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/8/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import Alamofire

class ServerConnector: NSObject {
    
    class func uploadAdvertisementData(_ data: [String: Any]) {
        
    }
    
    class func requestDataFromServerForDevice(_ name: String?) {
        if(name == nil) {
            print("Cannot use nil device name")
            return
        }
        
        let parameters = ["name" : name! as Any] as Parameters
       // let url = "http://localhost:3000/lastLogByName"
        let url = ""
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            if let json = response.result.value as? [Dictionary<String, Any>]{
                let pebbleLog = PebbleUtilities.parseLogFromJson(json[0])
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pebbleFound"), object: nil, userInfo: ["log": pebbleLog])
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    class func uploadDataToServer(_ url: String, method: HTTPMethod, name: String, temp: Float, humidity: Float, pressure: Float, dewPoint: Float, avgTemp: Float, avgHumidity: Float, avgPressure: Float, avgDewPoint: Float, highestTemp: Float, highestHumidity: Float, highestPressure:Float, highestDewPoint: Float, lowestTemp: Float, lowestHumidity: Float, lowestPressure: Float, lowestDewPoint: Float) -> Bool {
        
        let parameters = ["name" : name as Any,
                          "temp": temp as Any,
                          "humidity": humidity as Any,
                          "pressure": pressure as Any,
                          "dewPoint": dewPoint as Any,
                          "avgTemp": avgTemp as Any,
                          "avgHumidity": avgHumidity as Any,
                          "avgPressure": avgPressure as Any,
                          "avgDewPoint": avgDewPoint as Any,
                          "highestTemp": highestTemp as Any,
                          "highestHumidity": highestHumidity as Any,
                          "highestPressure": highestPressure as Any,
                          "highestDewPoint": highestDewPoint as Any,
                          "lowestTemp" : lowestTemp as Any,
                          "lowestHumidity": lowestHumidity as Any,
                          "lowestPressure": lowestPressure as Any,
                          "lowestDewPoint": lowestDewPoint as Any] as Parameters

        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            if let json = response.result.value as? [Dictionary<String, Any>]{
                print("JSON:") // serialized json response
                for dict in json {
                    print(dict)
                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        return true
    }
}
