//
//  SyncController.m
//  DayX
//
//  Created by Joshua Howland on 3/9/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "SyncController.h"
#import "EntryController.h"
#import <CloudKit/CloudKit.h>

@implementation SyncController

#pragma mark - Simple Sync Code

/* In order to sync we need 3 things:
 
 1) an identifier to keep track of each new Entry
 2) a method to look up entry by identifier
 3) a data comparator function to check which verison is newer
 
 */

typedef NS_ENUM(NSInteger, EntryCompare) {
    EntryCompareSame,
    EntryCompareCoreDataNewer,
    EntryCompareCloudKitNewer,
};

+ (SyncController *)sharedInstance {
    
    static SyncController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SyncController alloc] init];

    });
    return sharedInstance;
    
}

- (void)syncEntriesWithCloudKit {
    
    // In order to retrieve all records
    NSPredicate *truePredicate = [NSPredicate predicateWithValue:YES];
    
    CKQuery *query = [[CKQuery alloc] initWithRecordType:EntryRecordKey predicate:truePredicate];
    
    [[EntryController privateDB] performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error) {
        
        if (!error) {
            for (CKRecord *record in results) {
                
                Entry *entry = [self entryWithIdentifier:record[EntryIdentifierKey]];
                
                if (!entry) {

                    entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
                                                                         inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
                    
                    entry.identifier = [NSString stringWithFormat:@"%@", record[EntryIdentifierKey]];
                    entry.title = record[EntryTitleKey];
                    entry.text = record[EntryTextKey];
                    entry.timestamp = record[EntryTimeStampKey];
                    entry.uploaded = [NSNumber numberWithBool:YES];
                
                }
                
                EntryCompare comparison = [self compare:record entry:entry];
                
                switch (comparison) {
                    case EntryCompareCloudKitNewer: {
                        
                        entry.title = record[EntryTitleKey];
                        entry.text = record[EntryTextKey];
                        entry.timestamp = record[EntryTimeStampKey];
                        
                        break;
                    }
                    case EntryCompareCoreDataNewer: {
                        
                        record[EntryTitleKey] = entry.title;
                        record[EntryTextKey] = entry.text;
                        record[EntryTimeStampKey] = entry.timestamp;
                        
                        // Save each record update individually
                        [[EntryController privateDB] saveRecord:record completionHandler:nil];
                        
                        break;
                    }
                    case EntryCompareSame:
                        break;
                }
                
            }
            
            // Save all of the core data changes at once
            [[EntryController sharedInstance] synchronize];
            
        }
        
    }];
    
    // TODO: Go through every core data entry with uploaded == NO and push them to CloudKit
    
}

- (EntryCompare)compare:(CKRecord *)record entry:(Entry *)entry {
    
    NSDate *recordDate = record[EntryTimeStampKey];
    if ([recordDate compare:entry.timestamp] == NSOrderedSame) {
        return EntryCompareSame;
        
    } else if ([recordDate compare:entry.timestamp] == NSOrderedAscending) {
        return EntryCompareCoreDataNewer;
        
    } else {
        return EntryCompareCloudKitNewer;
    }
    
}

- (Entry *)entryWithIdentifier:(NSString *)identifier {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier]];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:NULL];
    
    return objects.count > 0 ? objects.firstObject : nil;
    
}

@end
