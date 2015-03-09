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

        // NOTE: Without a sync engine to pull and update entries on first launch, this app will assume that the server starts out in the same place as the app: empty. This may not be true if the user has multiple devices, or has to uninstall and reinstall.
        
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

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date {
    
    CKRecord *cloudKitEntry = [[CKRecord alloc] initWithRecordType:EntryRecordKey];
    
    cloudKitEntry[EntryIdentifierKey] = [[NSUUID UUID] UUIDString];
    cloudKitEntry[EntryTitleKey] = title;
    cloudKitEntry[EntryTextKey] = text;
    cloudKitEntry[EntryTimeStampKey] = date;
    
    [[EntryController privateDB] saveRecord:cloudKitEntry completionHandler:^(CKRecord *record, NSError *error) {
        if (!error) {
            
            NSLog(@"Saved Entry to CloudKit");
            [self storeRecordToCoreData:cloudKitEntry uploaded:YES];
            
        } else {

            NSLog(@"NOT Saved Entry to CloudKit");
            [self storeRecordToCoreData:cloudKitEntry uploaded:NO];

        }
    }];

}

- (void)storeRecordToCoreData:(CKRecord *)record uploaded:(BOOL)uploaded {

    Entry *coreDataEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
                                                         inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    coreDataEntry.identifier = record[EntryIdentifierKey];
    coreDataEntry.title = record[EntryTitleKey];
    coreDataEntry.text = record[EntryTextKey];
    coreDataEntry.timestamp = record[EntryTimeStampKey];
    coreDataEntry.uploaded = [NSNumber numberWithBool:uploaded];
    
    [self synchronize];

}

- (void)updateEntry:(Entry *)entry {
    
    CKRecordID *entryRecordId = [[CKRecordID alloc] initWithRecordName:entry.identifier];

    [[EntryController privateDB] fetchRecordWithID:entryRecordId completionHandler:^(CKRecord *record, NSError *error) {
        
        if (!error) {

            CKRecord *cloudKitEntry = record;
            
            cloudKitEntry[EntryTitleKey] = entry.title;
            cloudKitEntry[EntryTextKey] = entry.text;
            cloudKitEntry[EntryTimeStampKey] = entry.timestamp;
            
            [[EntryController privateDB] saveRecord:cloudKitEntry completionHandler:nil];
        
        }
    }];
}

- (void)removeEntry:(Entry *)entry {

    CKRecordID *entryRecordId = [[CKRecordID alloc] initWithRecordName:entry.identifier];
    
    [[EntryController privateDB] deleteRecordWithID:entryRecordId completionHandler:^(CKRecordID *recordID, NSError *error) {
        if (!error) {
            NSLog(@"Deleted Entry from CloudKit");
        } else {
            NSLog(@"Did NOT delete Entry from CloudKit");
        }
    }];
    
    [entry.managedObjectContext deleteObject:entry];
    [self synchronize];

}

- (void)synchronize {
    [[Stack sharedInstance].managedObjectContext save:NULL];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EntryListUpdated object:nil];
}


#pragma mark - Debugging Methods

- (void)retrieveEntriesFromCloudKit {
    
    // Simple request to check to see what is on CloudKit
    
    NSPredicate *truePredicate = [NSPredicate predicateWithValue:YES];
    
    CKQuery *query = [[CKQuery alloc] initWithRecordType:EntryRecordKey predicate:truePredicate];
    
    [[EntryController privateDB] performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error) {
        
        if (!error) {
            for (CKRecord *entry in results) {
                
                NSLog(@"%@", entry);
            }
        }
    }];
}


@end
