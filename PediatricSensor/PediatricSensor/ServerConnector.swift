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
    
    class func uploadDataToServer(_ name: String?, temperature: Int?, humidity: Int?, pressure: Int?, dewPoint: Int?) -> Bool {
        if(name == nil || temperature == nil || humidity == nil || pressure == nil || dewPoint == nil) {
            print("Cannot upload nil data to sensor")
            return false
        }

        Alamofire.request("http://localhost:3000/logs").responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
            
            if let json = response.result.value as? [Dictionary<String, Any>]{
                print("JSON:") // serialized json response
                for var dict in json {
                    print(dict)
                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        return true
    }
    
    class func getDataFromServerForSensor(_ sensorName: String) {
        
    }
}
