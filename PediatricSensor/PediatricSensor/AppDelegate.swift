//
//  AppDelegate.swift
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/2/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications
import PushKit
import LGBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    //    let types: UNAuthorizationOptions = [.alert, .badge, .sound]
    //    application.registerForRemoteNotifications(matching: )
        
       print(LGCentralManager.sharedInstance().centralNotReadyReason)

        //output what state the app is in. This will be used to see when the app is started in the background
        NSLog("app launched with state \(application.applicationState)")
        
        return true
    }
    
    func pushKitRegistration()
    {
        
        let mainQueue = DispatchQueue.main
        // Create a push registry object
        if #available(iOS 8.0, *) {
            
            let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
            
            // Set the registry's delegate to self
            
            voipRegistry.delegate = self
            
            // Set the push type to VoIP
            
            voipRegistry.desiredPushTypes = [PKPushType.voIP]
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        BluetoothConnector.startScanningForSensor()
    }
}

extension AppDelegate: PKPushRegistryDelegate {
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        // Register VoIP push token (a property of PKPushCredentials) with server
        
        let deviceToken = pushCredentials.token
        let nsdataStr = NSData.init(data: deviceToken)
        let deviceStr = nsdataStr.description.replacingOccurrences(of: " ", with: "")
        
        print("voip: " + deviceStr)
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        let data = payload.dictionaryPayload
        print("%@", data)
        completion()
    }
}
