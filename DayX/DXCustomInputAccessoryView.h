//
//  DXCustomInputAccessoryView.h
//  DayX
//
//  Created by Ben Norris on 3/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DXCustomInputAccessoryViewDelegate;

@interface DXCustomInputAccessoryView : UIView

@property (nonatomic, weak) id<DXCustomInputAccessoryViewDelegate> delegate;

@end

@protocol DXCustomInputAccessoryViewDelegate <NSObject>

- (void)donePressed;
- (void)previousPressed;
- (void)nextPressed;

@end