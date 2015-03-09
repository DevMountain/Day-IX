//
//  EntryControler.m
//  Entries
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "EntryController.h"
#import <CloudKit/CloudKit.h>

static NSString * const EntryRecordKey = @"Entry";
static NSString * const EntryTitleKey = @"title";
static NSString * const EntryTextKey = @"text";
static NSString * const EntryTimeStampKey = @"timestamp";

@interface EntryController ()

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EntryController alloc] init];
        
        [sharedInstance retrieveEntriesFromCloudKit];
    });
    return sharedInstance;
}

+ (CKDatabase *)privateDB {
    CKDatabase *database = [[CKContainer defaultContainer] privateCloudDatabase];
    
    return database;
}

- (NSArray *)entries {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:NULL];
    return objects;

}

- (void)retrieveEntriesFromCloudKit {
    
    NSPredicate *truePredicate = [NSPredicate predicateWithValue:YES];
    
    CKQuery *query = [[CKQuery alloc] initWithRecordType:EntryRecordKey predicate:truePredicate];

    [[EntryController privateDB] performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error) {
        
        if (!error) {
            for (CKRecord *entry in results) {
                // convert record to core data object, compare to other core data objects, if unique, save it
                NSLog(@"%@", entry);
            }
        }
    }];
}


- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date {

    CKRecord *cloudKitEntry = [[CKRecord alloc] initWithRecordType:EntryRecordKey];
    
    cloudKitEntry[EntryTitleKey] = title;
    cloudKitEntry[EntryTextKey] = text;
    cloudKitEntry[EntryTimeStampKey] = date;
    
    [[EntryController privateDB] saveRecord:cloudKitEntry completionHandler:^(CKRecord *record, NSError *error) {
        if (!error) {
            
            NSLog(@"Saved Entry to CloudKit");
            
            CKRecord *savedEntryRecord = record;
            
            Entry *coreDataEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
                                                                 inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
            coreDataEntry.title = savedEntryRecord[EntryTitleKey];
            coreDataEntry.text = savedEntryRecord[EntryTextKey];
            coreDataEntry.timestamp = savedEntryRecord[EntryTimeStampKey];
            
            [self synchronize];
        } else {
            
            Entry *coreDataEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
                                                                 inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
            coreDataEntry.title = title;
            coreDataEntry.text = text;
            coreDataEntry.timestamp = date;
            
            // todo: add core data property to mark successful save no cloudkit so i can handle unsynced changes later
            
            [self synchronize];
        }
    }];
    
}

- (void)removeEntry:(Entry *)entry {

    [entry.managedObjectContext deleteObject:entry];
    [self synchronize];

}

- (void)synchronize {
    [[Stack sharedInstance].managedObjectContext save:NULL];
    
}

@end
