//
//  DXDetailViewController.m
//  DayX
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXDetailViewController.h"

@interface DXDetailViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;

@end

@implementation DXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
