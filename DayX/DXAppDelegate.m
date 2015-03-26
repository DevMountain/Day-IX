//
//  DXAppDelegate.m
//  DayX
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXAppDelegate.h"
#import "DXListViewController.h"
#import <GoogleAnalytics-iOS-SDK/GAI.h>
#import <ChimpKit/ChimpKit.h>

@implementation DXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	GAI *googleAnalytics = [GAI sharedInstance];
	googleAnalytics.trackUncaughtExceptions = YES;
	googleAnalytics.dispatchInterval = 20;
	[[googleAnalytics logger] setLogLevel:kGAILogLevelVerbose];
	[googleAnalytics trackerWithTrackingId:@"UA-61164730-1"];
	
	[[ChimpKit sharedKit] setApiKey:@"ba3c3fcc67c9d1493639300206207cbe-us5"];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    DXListViewController *viewContorller = [DXListViewController new];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:viewContorller];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
