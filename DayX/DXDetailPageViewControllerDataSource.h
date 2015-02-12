//
//  DXDetailPageViewControllerDataSource.h
//  DayX
//
//  Created by Joshua Howland on 2/12/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDetailPageViewControllerDataSource : NSObject <UIPageViewControllerDataSource>

- (UIViewController *)viewControllerAtIndex:(NSInteger)index;

- (NSInteger)pageCount;

@end
