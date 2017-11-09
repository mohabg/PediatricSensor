//
//  BluetoothConnectorObjC.m
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/8/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluetoothConnectorObjC.h"
#define MANUF_ID_BLUE_MAESTRO 0x0133

@implementation BluetoothConnectorObjC

//From https://github.com/BlueMaestro/IOS-Tempo-Utility-App-SDK
+ (BOOL)isBlueMaestroDeviceWithAdvertisementData:(NSDictionary*)data {
    NSData *custom = [data objectForKey:@"kCBAdvDataManufacturerData"];
    //BlueMaestro device
    if (custom != nil)
    {
        unsigned char * d = (unsigned char*)[custom bytes];
        unsigned int manuf = d[1] << 8 | d[0];
        
        //Is this one of ours?
        if (manuf == MANUF_ID_BLUE_MAESTRO) {
            return YES;
        }
    }
    return NO;
}

@end
