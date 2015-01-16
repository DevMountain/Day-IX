//
//  DXDetailViewController.h
//  DayX
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface DXDetailViewController : UIViewController

- (void)updateWithEntry:(Entry *)entry;

@end
