//
//  EntryControler.h
//  Entries
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Dropbox/Dropbox.h>

static NSString *kTITLE = @"title";
static NSString *kTEXT = @"text";
static NSString *kDATE = @"date";

@interface EntryController : NSObject

@property (nonatomic, strong, readonly) NSArray *entries;

+ (EntryController *)sharedInstance;
+ (void)updateSharedInstance;

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date;
- (void)removeEntry:(NSString *)entryID;
- (void)update;

@end
