//
//  PebbleUtilitiesObjC.m
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/15/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PebbleUtilitiesObjC.h"
#import "TDUARTDownloader.h"

// From https://github.com/BlueMaestro/IOS-Tempo-Utility-App-SDK

@implementation PebbleUtilitiesObjC 

+ (int)intValueLsb:(char)lsb msb:(char)msb {

    return (((int) lsb) & 0xFF) | (((int) msb) << 8);
}

+ (uint)uintValueLsb:(uint8_t)lsb msb:(uint8_t)msb {
    uint x = (uint) lsb;
    uint y = (uint) msb;
    uint z = y << 8;
    uint a = x & 0xFF;
    uint b = a | z;
    return (((uint) lsb) & 0xFF) | (((uint) msb) << 8);
}

+ (BOOL)isFahrenheitFromAdvertisementData:(NSDictionary *)data {
    unsigned char * manuData = (unsigned char*) [data[@"kCBAdvDataManufacturerData"] bytes];
    NSNumber * mode = @(manuData[14]);
    
    return mode.integerValue > 100;
}

+ (NSNumber *)temperatureFromAdvertisementData: (NSDictionary *)data {
    unsigned char * manuData = (unsigned char*) [data[@"kCBAdvDataManufacturerData"] bytes];
    
    return @([self intValueLsb:manuData[9] msb:manuData[8]] / 10.f);
}

+ (NSNumber *)avgTemperatureFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;

    return @([self intValueLsb:manuData[manufacturerDataLength-8] msb:manuData[manufacturerDataLength-9]] / 10.f);
}

+ (NSNumber *)highestTemperatureFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;

    return @([self intValueLsb:manuData[manufacturerDataLength-16] msb:manuData[manufacturerDataLength-17]] / 10.f);
}

+ (NSNumber *)lowestTemperatureFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;

    return@([self intValueLsb:manuData[manufacturerDataLength-12] msb:manuData[manufacturerDataLength-13]] / 10.f);
}

+ (NSNumber *)humidityFromAdvertisementData: (NSDictionary *)data {
    unsigned char * manuData = (unsigned char*) [data[@"kCBAdvDataManufacturerData"] bytes];
    return @([self intValueLsb:manuData[11] msb:manuData[10]] / 10.f);
}

+ (NSNumber *)avgHumidityFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;
    
    return @([self intValueLsb:manuData[manufacturerDataLength-6] msb:manuData[manufacturerDataLength-7]] / 10.f);
}

+ (NSNumber *)highestHumidityFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;
    
    return @([self intValueLsb:manuData[manufacturerDataLength-14] msb:manuData[manufacturerDataLength-15]] / 10.f);
}

+ (NSNumber *)lowestHumidityFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;
    
    return @([self intValueLsb:manuData[manufacturerDataLength-10] msb:manuData[manufacturerDataLength-11]] / 10.f);
}

+ (NSNumber *)pressureFromAdvertisementData: (NSDictionary *)data {
    unsigned char * manuData = (unsigned char*) [data[@"kCBAdvDataManufacturerData"] bytes];
    return @([self intValueLsb:manuData[13] msb:manuData[12]] / 10.f);
}

+ (NSNumber *)avgPressureFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;
    
    return @([self intValueLsb:manuData[manufacturerDataLength-22] msb:manuData[manufacturerDataLength-23]] / 10.f);
}

+ (NSNumber *)highestPressureFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;
    
    return @([self intValueLsb:manuData[manufacturerDataLength-24] msb:manuData[manufacturerDataLength-25]] / 10.f);
}

+ (NSNumber *)lowestPressureFromAdvertisementData: (NSDictionary *)data {
    NSData * advManuData = data[@"kCBAdvDataManufacturerData"];
    unsigned char * manuData = (unsigned char*) [advManuData bytes];
    NSUInteger manufacturerDataLength = advManuData.length;
    
    return @([self intValueLsb:manuData[manufacturerDataLength-20] msb:manuData[manufacturerDataLength-21]] / 10.f);
}

    
    
+ (void)downloadLogsFromDevice: (TDTempoDisc*)device {
        __weak typeof(self) weakself = self;
    
//        [_timerRefresh invalidate];
//        _timerRefresh = nil;
//        if (!weakself.uartAllDataDownloader) {
//            weakself.uartAllDataDownloader = [[TDUARTAllDataDownloader alloc] init];
//        }
//
//        weakself.hudDownloadData = [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
//        weakself.hudDownloadData.mode = MBProgressHUDModeDeterminateHorizontalBar;
//        weakself.hudDownloadData.labelText = NSLocalizedString(@"Downloading data...", nil);

    [[TDUARTDownloader shared] downloadDataForDevice:device withUpdate:^(float progress) {
        
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                if (fabs(weakself.hudDownloadData.progress - progress) > 0.02) {
        //                    weakself.hudDownloadData.progress = progress;
        //                }
        //            });
    } withCompletion:^(BOOL success) {
        //            [weakself.hudDownloadData hide:YES];
        //            weakself.uartAllDataDownloader = nil;
//        if (!success) {
////            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Cannot download at this time. Try scanning for the device again in the Device List screen", nil) preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", nil) style:UIAlertActionStyleCancel handler:nil]];
//            [weakself presentViewController:alert animated:YES completion:nil];
//        }
        
       // [weakself refreshCurrentDevice];
      //  [weakself fillData];
        
        // weakself.timerRefresh = [NSTimer timerWithTimeInterval:kDeviceRefreshInterval target:weakself selector:@selector(refreshCurrentDevice) userInfo:nil repeats:YES];
        // [[NSRunLoop mainRunLoop] addTimer:weakself.timerRefresh forMode:NSDefaultRunLoopMode];
    }] ;
    }
    
@end
