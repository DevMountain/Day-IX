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
#import <ChimpKit/ChimpKit.h>
#import <ChimpKit/CKSubscribeAlertView.h>

#import "EntryController.h"

@interface DXListViewController () <UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DXListTableViewDataSource *dataSource;

@end

@implementation DXListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	self.screenName = @"Entries List";
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"HasShownEmailSignup"]) {
		CKSubscribeAlertView *subscribeAlert = [[CKSubscribeAlertView alloc] initWithTitle:@"Join Our Newsletter!"
																				   message:@"We won't spam you, promise."
																					listId:@"738a11f363"
																		 cancelButtonTitle:@"Cancel"
																	  subscribeButtonTitle:@"Subscribe"];
		[subscribeAlert show];
		[userDefaults setBool:YES forKey:@"HasShownEmailSignup"];
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

@end
