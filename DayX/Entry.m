//
//  Entry.m
//  DayX
//
//  Created by Joshua Howland on 10/2/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "Entry.h"

static NSString * const EntryClassName = @"Entry";

@implementation Entry

@dynamic title;
@dynamic text;
@dynamic timestamp;

+ (NSString *)parseClassName {
    return EntryClassName;
}

@end
