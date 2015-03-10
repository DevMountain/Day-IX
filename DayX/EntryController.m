//
//  EntryControler.m
//  Entries
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "EntryController.h"

@interface EntryController ()

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EntryController alloc] init];
        [sharedInstance loadEntriesFromParse];
    });
    return sharedInstance;
}

- (void)loadEntriesFromParse {
    
    PFQuery *query = [Entry query];
    
    // Without notifications to update the tableview we'll need to restart the app to get the tableview to load
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (Entry *entry in objects) {
            [entry pin];
        }
    }];
}

- (NSArray *)entries {
    
    PFQuery *query = [Entry query];
    [query fromLocalDatastore];
    return [query findObjects];
    
}

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date {

    Entry *entry = [Entry object];
    
    entry.title = title;
    entry.text = text;
    entry.timestamp = date;
    
    [entry pinInBackground];
    [entry save];
    
}

- (void)removeEntry:(Entry *)entry {

    [entry unpinInBackground];
    [entry deleteInBackground];
}

- (void)updateEntry:(Entry *)entry {

    [entry pinInBackground];
    [entry save];
    
}

@end
