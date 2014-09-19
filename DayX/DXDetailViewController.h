//
//  DXDetailViewController.h
//  DayX
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Entry;

static NSString * const EntryKey = @"entry";

@interface DXDetailViewController : UIViewController

- (void)updateWithEntry:(Entry *)entry;

@end
