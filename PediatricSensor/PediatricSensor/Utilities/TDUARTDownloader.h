//  TDUARTDownloader.h
//  TempoDisc
//
//  Created by Nikola Misic on 10/5/16.
//  Copyright © 2016 BlueMaestro. All rights reserved.
//

#ifndef TDUARTDownloader_h
#define TDUARTDownloader_h

#endif /* TDUARTDownloader_h */

#import <Foundation/Foundation.h>
#import "TDTempoDisc.h"
//#import "TempoDiscDevice+CoreDataProperties.h"

typedef void(^DataDownloadCompletion)(BOOL);

typedef void(^DataProgressUpdate)(float progress);

@interface TDUARTDownloader : NSObject
    
+ (TDUARTDownloader*)shared;
    
- (void)downloadDataForDevice:(TDTempoDisc*)device withUpdate:(DataProgressUpdate)update withCompletion:(DataDownloadCompletion)completion;
    
- (void)downloadDataForDevice:(TDTempoDisc*)device withCompletion:(DataDownloadCompletion)completion;
//
//- (void)setNewTimeStamp: (NSInteger)sendRecordsNeeded;
//
- (void)notifyUpdateForProgress:(float)progress;
    
@end

