//
//  SCHelper.m
//  PediatricSensor
//
//  Created by Mohab Gabal on 11/28/17.
//  Copyright © 2017 Mohab Gabal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCHelper.h"

#define kMaxLogoSize CGSizeMake(50.,50.)

#define kFontNameSemiBold @""

@implementation SCHelper

+ (BOOL)isNilOrEmpty:(NSString*)string {
    
    if ([string isKindOfClass:[NSNumber class]]) {
        return string ? NO : YES;
    }
    
    if (string == nil || [string isEqual:[NSNull null]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [string isEqualToString:@"<null>"]) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
