//
//  DXDetailPageViewController.m
//  DayX
//
//  Created by Joshua Howland on 2/12/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DXDetailPageViewController.h"
#import "DXDetailPageViewControllerDataSource.h"

@interface DXDetailPageViewController () <UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) DXDetailPageViewControllerDataSource *dataSource;

@end

@implementation DXDetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    self.dataSource = [DXDetailPageViewControllerDataSource new];
    self.pageViewController.dataSource = self.dataSource;
    [self.pageViewController setViewControllers:@[[self.dataSource viewControllerAtIndex:self.initialIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    // We need to add the pageViewController as a childViewController (so that the lifecycle methods get called together. And then we can add the main view of the pageViewController to this viewController's main view.
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

@end
