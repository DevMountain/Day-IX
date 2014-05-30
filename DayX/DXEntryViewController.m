//
//  DXEntryViewController.m
//  DayX
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXEntryViewController.h"

#import "Entry.h"

@interface DXEntryViewController () <UITextFieldDelegate, UITextViewDelegate>


@property (nonatomic, strong) IBOutlet UITextView *noteView;
@property (nonatomic, strong) IBOutlet UITextField *titleField;

@end

@implementation DXEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleField.text = self.entry.title;
    self.noteView.text = self.entry.note;

}

- (void)textViewDidChange:(UITextView *)textView {
    self.entry.note = textView.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    self.entry.title = textField.text;
    return YES;
}

@end
