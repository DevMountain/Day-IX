//
//  InterfaceController.m
//  DayX WatchKit Extension
//
//  Created by Ben Norris on 3/3/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DXEntriesListInterfaceController.h"
#import <DayXKit/DayXKit.h>
#import "DXEntryRowController.h"

@interface DXEntriesListInterfaceController()

@property (strong, nonatomic) IBOutlet WKInterfaceTable *entriesTable;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *errorMessage;

@end


@implementation DXEntriesListInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    if ([EntryController sharedInstance].entries.count > 0) {
        [self.errorMessage setHidden:YES];
        [self.entriesTable setNumberOfRows:[EntryController sharedInstance].entries.count withRowType:@"entryRow"];
        
        for (NSInteger index = 0; index < [EntryController sharedInstance].entries.count; index++) {
            Entry *entry = [EntryController sharedInstance].entries[index];
            DXEntryRowController *rowController = [self.entriesTable rowControllerAtIndex:index];
            [rowController setEntryTitleWithString:entry.title];
        }

    } else {
        [self.entriesTable setHidden:YES];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



