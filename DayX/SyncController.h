//
//  SyncController.h
//  DayX
//
//  Created by Joshua Howland on 3/9/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncController : NSObject

+ (SyncController *)sharedInstance;

- (void)syncEntriesWithCloudKit;

@end
