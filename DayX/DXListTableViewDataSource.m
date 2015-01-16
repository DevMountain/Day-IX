//
//  DXListTableViewDataSource.m
//  DayX
//
//  Created by Joshua Howland on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListTableViewDataSource.h"
#import "Entry.h"

@implementation DXListTableViewDataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *entries = [Entry loadEntriesFromDefaults];
    return entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *entries = [Entry loadEntriesFromDefaults];
    Entry *entry = entries[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = entry.title;
    return cell;
}

@end
