//
//  Entry.m
//  Entries
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "Entry.h"

static NSString * const titleKey = @"title";
static NSString * const noteKey = @"note";
static NSString * const timestampKey = @"timestamp";

@interface Entry ()

@end

@implementation Entry

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[titleKey];
        self.note = dictionary[noteKey];
        self.timestamp = dictionary[timestampKey];
    }
    return self;
}

- (NSDictionary *)entryDictionary {

    NSMutableDictionary *entryDictionary = [NSMutableDictionary new];
    if (self.title) {
        [entryDictionary setObject:self.title forKey:titleKey];
    }
    if (self.note) {
        [entryDictionary setObject:self.note forKey:noteKey];
    }
    if (self.timestamp) {
        [entryDictionary setObject:self.timestamp forKey:timestampKey];
    }

    return entryDictionary;
}

@end
