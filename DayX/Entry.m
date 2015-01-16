//
//  Entry.m
//  Entries
//
//  Created by Joshua Howland on 9/19/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "Entry.h"

static NSString * const entriesKey = @"entries";

@implementation Entry

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[titleKey];
        self.text = dictionary[textKey];
        self.timestamp = dictionary[timestampKey];
    }
    return self;
}

- (NSDictionary *)entryDictionary {

    NSMutableDictionary *entryDictionary = [NSMutableDictionary new];
    if (self.title) {
        [entryDictionary setObject:self.title forKey:titleKey];
    }
    if (self.text) {
        [entryDictionary setObject:self.text forKey:textKey];
    }
    if (self.timestamp) {
        [entryDictionary setObject:self.timestamp forKey:timestampKey];
    }
    
    return entryDictionary;

}

- (NSString *)description {
    return self.title;
}

+ (NSMutableArray *)loadEntriesFromDefaults {
    
    NSArray *entryDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:entriesKey];
    
    NSMutableArray *entries = [NSMutableArray new];
    
    for (NSDictionary *entryDictionary in entryDictionaries) {
        Entry *entry = [[Entry alloc] initWithDictionary:entryDictionary];
        [entries addObject:entry];
    }
    
    return entries;
}

+ (void)storeEntriesInDefaults:(NSArray *)entries {
    
    NSMutableArray *entryDictionaries = [NSMutableArray new];
    
    for (Entry *entry in entries) {
        [entryDictionaries addObject:[entry entryDictionary]];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:entryDictionaries forKey:entriesKey];
    
}


@end
