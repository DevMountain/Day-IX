//
//  DXListViewController.m
//  DayX
//
//  Created by Joshua Howland on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListViewController.h"
#import "DXListTableViewDataSource.h"
#import "DXDetailViewController.h"

#import "EntryController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface DXListViewController () <UITableViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DXListTableViewDataSource *dataSource;

@end

@implementation DXListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    PFUser *user = [PFUser currentUser];
    if (!user.email) {
        [self signIn:nil];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.dataSource = [DXListTableViewDataSource new];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.dataSource registerTableView:self.tableView];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DXDetailViewController *detailViewController = [DXDetailViewController new];
    [detailViewController updateWithEntry:[EntryController sharedInstance].entries[indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];

}

- (void)add:(id)sender {

    DXDetailViewController *detailViewController = [DXDetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction)signIn:(id)sender {
    
    PFLogInViewController *logIn = [PFLogInViewController new];
    logIn.delegate = self;
    [self presentViewController:logIn animated:YES completion:nil];
    
}

// Delegate methods for authentication view controllers

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
