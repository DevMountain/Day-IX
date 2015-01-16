//
//  DXDetailViewController.m
//  DayX
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXDetailViewController.h"

@interface DXDetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *clearButton;

@property (nonatomic, strong) Entry *entry;

@end

@implementation DXDetailViewController

- (void)updateWithEntry:(Entry *)entry {
    self.entry = entry;
    
    self.textField.text = entry.title;
    self.textView.text = entry.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textField.delegate = self;
    self.textView.delegate = self;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self save:textView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self save:textField];
}

- (IBAction)clear:(id)sender {
    self.textField.text = @"";
    self.textView.text = @"";
    
    [self save:sender];
}

- (IBAction)save:(id)sender {
    
    if (!self.entry) {
        self.entry = [[Entry alloc] init];
        self.entry.title = self.textField.text;
        self.entry.text = self.textView.text;
    }
    
    NSMutableArray *entries = [Entry loadEntriesFromDefaults];
    [entries addObject:self.entry];
    
    [Entry storeEntriesInDefaults:entries];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
