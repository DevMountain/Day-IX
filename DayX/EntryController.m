//
//  EntryControler.m
//  Entries
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "EntryController.h"

@interface EntryController ()

@property (strong, nonatomic) DBDatastore *datastore;
@property (strong, nonatomic) DBTable *entriesTable;

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EntryController alloc] init];
        sharedInstance.datastore = [[DBDatastoreManager sharedManager] openDefaultDatastore:nil];
        sharedInstance.entriesTable = [sharedInstance.datastore getTable:@"Entries"];
    });
    return sharedInstance;
}

+ (void)updateSharedInstance
{
    [EntryController sharedInstance].datastore = [[DBDatastoreManager sharedManager] openDefaultDatastore:nil];
    [EntryController sharedInstance].entriesTable = [[self sharedInstance].datastore getTable:@"Entries"];
}

- (NSArray *)entries {
    

    return [self.entriesTable query:nil error:nil];
    
}

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date {

    DBRecord *record = [self.entriesTable insert:@{ kTITLE : title,
                                                    kTEXT : text,
                                                    kDATE : date }];
    [self.datastore sync:nil];
}

- (void)removeEntry:(NSString *)entryID
{
    DBRecord *recordToDelete = [self.entriesTable getRecord:entryID error:nil];
    [recordToDelete deleteRecord];
    [self.datastore sync:nil];
}

- (void)update
{
    [self.datastore sync:nil];
}

- (void)updateEntry:(NSString *)entryID withTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date
{
    DBRecord *recordToUpdate = [self.entriesTable getRecord:entryID error:nil];
    recordToUpdate[kTITLE] = title;
    recordToUpdate[kTEXT] = text;
    recordToUpdate[kDATE] = date;
    [self.datastore sync:nil];
}

@end
