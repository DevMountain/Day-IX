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

@interface DXListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DXListTableViewDataSource *dataSource;

@property (nonatomic, assign) BOOL registeredForNotifications;

@end

@implementation DXListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForNotifications];

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

# pragma mark - update notification

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)registerForNotifications {
    if (!self.registeredForNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:EntryListUpdated object:nil];
        self.registeredForNotifications = YES;
    }
}

- (void)unregisterForNotifications {
    if (self.registeredForNotifications) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:EntryListUpdated object:nil];
        self.registeredForNotifications = NO;
    }
}

- (void)dealloc {
    [self unregisterForNotifications];
}

@end
