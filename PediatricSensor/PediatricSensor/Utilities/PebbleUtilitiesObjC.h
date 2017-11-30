//
//  PebbleUtilitiesObjC.h
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/15/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

#ifndef PebbleUtilitiesObjC_h
#define PebbleUtilitiesObjC_h

#endif /* PebbleUtilitiesObjC_h */

#import "TDTempoDisc.h"

@interface PebbleUtilitiesObjC : NSObject

+(BOOL)isFahrenheitFromAdvertisementData:(NSDictionary *)data;

+(NSNumber *)temperatureFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)avgTemperatureFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)lowestTemperatureFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)highestTemperatureFromAdvertisementData: (NSDictionary *)data;

+(NSNumber *)humidityFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)avgHumidityFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)lowestHumidityFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)highestHumidityFromAdvertisementData: (NSDictionary *)data;

+(NSNumber *)pressureFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)avgPressureFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)lowestPressureFromAdvertisementData: (NSDictionary *)data;
+(NSNumber *)highestPressureFromAdvertisementData: (NSDictionary *)data;

+(void)downloadLogsFromDevice: (TDTempoDisc *)device;

+(int)intValueLsb:(char)lsb msb:(char)msb;
+(uint)uintValueLsb:(uint8_t)lsb msb:(uint8_t)msb;

@end
