//
//  BluetoothConnectorObjC.h
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/8/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

#ifndef BluetoothConnectorObjC_h
#define BluetoothConnectorObjC_h


#endif /* BluetoothConnectorObjC_h */

#import <Foundation/Foundation.h>

@interface BluetoothConnectorObjC : NSObject

@property (strong, nonatomic) id someProperty;

+ (BOOL)isBlueMaestroDeviceWithAdvertisementData:(NSDictionary*)data;

@end
