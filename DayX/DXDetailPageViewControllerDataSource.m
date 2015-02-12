//
//  DXDetailPageViewControllerDataSource.m
//  DayX
//
//  Created by Joshua Howland on 2/12/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DXDetailPageViewControllerDataSource.h"

#import "DXDetailViewController.h"

#import "EntryController.h"

@implementation DXDetailPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger beforeIndex = ((DXDetailViewController *)viewController).index - 1;
    return [self viewControllerAtIndex:beforeIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger afterIndex = ((DXDetailViewController *)viewController).index + 1;
    return [self viewControllerAtIndex:afterIndex];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    
    // Returning nil is how the pageViewController knows it has reached the end of the paging. We need to see if the current index is 0 or if the index is beyond the content.
    
    if (index < 0 || index >= [EntryController sharedInstance].entries.count) {
        return nil;
    }
    
    DXDetailViewController *viewController = [DXDetailViewController new];
    viewController.index = index;
    [viewController updateWithEntry:[EntryController sharedInstance].entries[index]];
    
    return viewController;
}

- (NSInteger)pageCount {
    return [EntryController sharedInstance].entries.count;
}

@end
