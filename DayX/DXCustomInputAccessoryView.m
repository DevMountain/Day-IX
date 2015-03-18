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
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.toolbar = [UIToolbar new];
        CGSize toolbarSize = [self.toolbar sizeThatFits:self.toolbar.frame.size];
        self.toolbar.frame = CGRectMake(0, 0, toolbarSize.width, toolbarSize.height);
        self.toolbar.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
        self.frame = self.toolbar.frame;
        
        self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTouched)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"◀︎" style:UIBarButtonItemStylePlain target:self action:@selector(previousButtonPressed)];
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"▶︎" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonPressed)];
        [self.toolbar setItems:@[prevButton, nextButton, flexibleSpace,self.doneButton]];
        
        [self.toolbar setBarTintColor:[UIColor colorWithRed:37/255.0 green:170/255.0 blue:225/255.0 alpha:1]];
        [self.toolbar setTintColor:[UIColor whiteColor]];
//        self.doneButton.tintColor = [UIColor whiteColor];
        
        [self addSubview:self.toolbar];
    }
    return self;
}

- (void)doneButtonTouched {
    [self.delegate donePressed];
}

- (void)previousButtonPressed {
    [self.delegate previousPressed];
}

- (void)nextButtonPressed {
    [self.delegate nextPressed];
}

@end
