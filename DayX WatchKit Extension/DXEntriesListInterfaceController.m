//
//  InterfaceController.m
//  DayX WatchKit Extension
//
//  Created by Ben Norris on 3/3/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DXEntriesListInterfaceController.h"


@interface DXEntriesListInterfaceController()

@property (strong, nonatomic) IBOutlet WKInterfaceTable *entriesTable;

@end


@implementation DXEntriesListInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
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



