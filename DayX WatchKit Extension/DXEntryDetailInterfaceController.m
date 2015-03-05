//
//  DXEntryDetailInterfaceController.m
//  DayX
//
//  Created by Ben Norris on 3/5/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DXEntryDetailInterfaceController.h"


@interface DXEntryDetailInterfaceController()

@property (strong, nonatomic) IBOutlet WKInterfaceLabel *entryTitle;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *entryContent;

@end


@implementation DXEntryDetailInterfaceController

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



