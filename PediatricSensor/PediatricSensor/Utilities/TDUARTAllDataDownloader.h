//
//  TDUARTAllDataDownloader.h
//  Tempo Utility
//
//  Created by Nikola Misic on 10/13/16.
//  Copyright © 2016 BlueMaestro. All rights reserved.
//

#ifndef TDUARTAllDataDownloader_h
#define TDUARTAllDataDownloader_h

#endif /* TDUARTAllDataDownloader_h */

#import "TDUARTDownloader.h"
#import "TDTempoDisc.h"

@interface TDUARTAllDataDownloader : TDUARTDownloader

- (void)writeData:(NSString*)data toDevice:(TDTempoDisc*)device withCompletion:(DataDownloadCompletion)completion;

@end
