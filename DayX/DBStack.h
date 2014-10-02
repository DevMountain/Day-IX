//
//  DBStack.h
//  Core Data Bank
//
//  Created by Joshua Howland on 6/12/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBStack : NSObject

+ (DBStack *)sharedInstance;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end
