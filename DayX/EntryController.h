//
//  EntryControler.h
//  Entries
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import "Entry.h"

static NSString * const EntryListUpdated = @"EntryListUpdated";

@interface EntryController : NSObject

@property (nonatomic, strong, readonly) NSArray *entries;

+ (EntryController *)sharedInstance;
+ (CKDatabase *)privateDB;

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date;
- (void)updateEntry:(Entry *)entry;
- (void)removeEntry:(Entry *)entry;

- (void)synchronize;

@end
