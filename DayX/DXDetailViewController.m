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

@property (nonatomic, strong) NSDictionary *dictionary;

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *clearButton;

@end

@implementation DXDetailViewController

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.dictionary = dictionary;
    
    self.textField.text = dictionary[TitleKey];
    self.textView.text = dictionary[TextKey];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textField.delegate = self;
    self.textView.delegate = self;
    
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

    NSDictionary *entry = @{TitleKey: self.textField.text, TextKey: self.textView.text};
    
    if (self.dictionary) {
        [[EntryController sharedInstance] replaceEntry:self.dictionary withEntry:entry];
    } else {
        [[EntryController sharedInstance] addEntry:entry];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
