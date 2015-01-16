//
//  Entry.h
//  Entries
//
//  Created by Joshua Howland on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const titleKey = @"title";
static NSString * const textKey = @"text";
static NSString * const timestampKey = @"timestamp";

@interface Entry : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *timestamp;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)entryDictionary;

// To be moved to a controller class later

+ (NSMutableArray *)loadEntriesFromDefaults;
+ (void)storeEntriesInDefaults:(NSArray *)entries;

@end
