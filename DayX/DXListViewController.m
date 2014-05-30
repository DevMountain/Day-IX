//
//  DXListViewController.m
//  DayX
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListViewController.h"
#import "DXListTableViewDataSource.h"

#import "DXEntryViewController.h"

#import "EntryController.h"

@interface DXListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DXListTableViewDataSource *datasource;

@end

@implementation DXListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.datasource = [DXListTableViewDataSource new];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    self.tableView.dataSource = self.datasource;
    [self.datasource registerTableView:self.tableView];
    
    
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newEntry)];
    self.navigationItem.rightBarButtonItem = plusButton;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[EntryController sharedInstance] synchronize];
    [self.tableView reloadData];
}

- (void)newEntry {
    Entry *entry = [Entry new];
    
    [[EntryController sharedInstance] addEntry:entry];

    DXEntryViewController *viewController = [DXEntryViewController new];
    viewController.entry = entry;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DXEntryViewController *entryViewController = [DXEntryViewController new];
    
    Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
    entryViewController.entry = entry;
    
    [self.navigationController pushViewController:entryViewController animated:YES];
}


@end
