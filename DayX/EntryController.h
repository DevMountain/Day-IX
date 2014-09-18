//
//  EntryControler.h
//  Entries
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const TitleKey = @"title";
static NSString * const TextKey = @"text";

@interface EntryController : NSObject

@property (nonatomic, strong, readonly) NSArray *entries;

+ (EntryController *)sharedInstance;

- (void)addEntry:(NSDictionary *)entry;
- (void)removeEntry:(NSDictionary *)entry;
- (void)replaceEntry:(NSDictionary *)oldEntry withEntry:(NSDictionary *)newEntry;

@end
