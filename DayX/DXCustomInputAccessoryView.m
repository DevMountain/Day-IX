//
//  DXCustomInputAccessoryView.m
//  DayX
//
//  Created by Ben Norris on 3/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DXCustomInputAccessoryView.h"

@interface DXCustomInputAccessoryView()

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@end

@implementation DXCustomInputAccessoryView

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, 40.0)];
    if (self) {
        self.toolbar = [UIToolbar new];
        CGSize toolbarSize = [self.toolbar sizeThatFits:self.toolbar.frame.size];
        self.toolbar.frame = CGRectMake(0, 0, toolbarSize.width, toolbarSize.height);
        self.toolbar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.frame = self.toolbar.frame;
        
        self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [self.toolbar setItems:@[flexibleSpace,self.doneButton]];
        
        [self.toolbar setBarTintColor:[UIColor colorWithRed:37/255.0 green:170/255.0 blue:225/255.0 alpha:1]];
        self.doneButton.tintColor = [UIColor whiteColor];
        
        [self addSubview:self.toolbar];
    }
    return self;
}

- (void)doneTouched {
    [self.delegate donePressed];
}

@end
