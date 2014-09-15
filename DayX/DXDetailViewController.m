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

@end

@implementation DXDetailViewController

- (void)updateWithDictionary:(NSDictionary *)dictionary {

    self.textField.text = dictionary[TitleKey];
    self.textView.text = dictionary[TextKey];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textField.delegate = self;
    self.textView.delegate = self;
    
    NSDictionary *entry = [[NSUserDefaults standardUserDefaults] objectForKey:EntryKey];
    [self updateWithDictionary:entry];
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

- (void)save:(id)sender {
    
    NSDictionary *entry = @{TitleKey: self.textField.text, TextKey: self.textView.text};
    [[NSUserDefaults standardUserDefaults] setObject:entry forKey:EntryKey];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
