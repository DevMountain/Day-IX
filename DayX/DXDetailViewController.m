//
//  DXDetailViewController.m
//  DayX
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXDetailViewController.h"
#import "EntryController.h"

@interface DXDetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) DBRecord *entry;

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *clearButton;

@end

@implementation DXDetailViewController

- (void)updateWithEntryDBRecord:(DBRecord *)record
{
    self.entry = record;
    self.textField.text = self.entry[kTITLE];
    self.textView.text = self.entry[kTEXT];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textField.delegate = self;
    self.textView.delegate = self;
 
    self.textField.text = self.entry[kTITLE];
    self.textView.text = self.entry[kTEXT];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)clear:(id)sender {
    self.textField.text = @"";
    self.textView.text = @"";
}

- (IBAction)save:(id)sender {

    if (self.entry) {

        self.entry[kTITLE] = self.textField.text;
        self.entry[kTEXT] = self.textView.text;
        self.entry[kDATE] = [NSDate date];
        
        [[EntryController sharedInstance] update];
        
    } else {
        [[EntryController sharedInstance] addEntryWithTitle:self.textField.text text:self.textView.text date:[NSDate date]];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
