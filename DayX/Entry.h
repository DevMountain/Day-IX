//
//  Entry.h
//  Entries
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSDate *timestamp;

- (NSDictionary *)entryDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
