//
//  EntryControler.m
//  Entries
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "EntryController.h"

static NSString * const entryListKey = @"entryList";

@interface EntryController ()

@property (nonatomic, strong) NSArray *entries;

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EntryController alloc] init];
        
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)addEntry:(NSDictionary *)entry {

    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
    [self synchronize];
}

- (void)removeEntry:(NSDictionary *)entry {

    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    [mutableEntries removeObject:entry];
    
    self.entries = mutableEntries;
    [self synchronize];

}

- (void)replaceEntry:(NSDictionary *)oldEntry withEntry:(NSDictionary *)newEntry {

    if (!oldEntry || !newEntry) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    
    if ([mutableEntries containsObject:oldEntry]) {
        NSInteger index = [mutableEntries indexOfObject:oldEntry];
        [mutableEntries replaceObjectAtIndex:index withObject:newEntry];
    }
    
    self.entries = mutableEntries;
    [self synchronize];

    
    
}

- (void)loadFromDefaults {
    
    NSArray *entryDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:entryListKey];
    self.entries = entryDictionaries;
    
}

- (void)synchronize {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.entries forKey:entryListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
