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

@property (nonatomic, strong) Entry *entry;

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *clearButton;

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
 
    self.textField.text = self.entry.title;
    self.textView.text = self.entry.text;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.screenName = @"Entry Detail Screen";
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

        self.entry.title = self.textField.text;
        self.entry.text = self.textView.text;
        self.entry.timestamp = [NSDate date];
        
        [[EntryController sharedInstance] synchronize];
        
    } else {
        [[EntryController sharedInstance] addEntryWithTitle:self.textField.text text:self.textView.text date:[NSDate date]];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
