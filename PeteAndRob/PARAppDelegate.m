//
//  PARAppDelegate.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 10.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARAppDelegate.h"
#import "PARNavigationBar.h"
#import <sys/utsname.h>




@implementation PARAppDelegate{
    BOOL lowPerformance;
}

- (BOOL)isLowPerformanceDevice
{
    return lowPerformance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _tabBarController = (UITabBarController *)self.window.rootViewController;

    [[UIBarButtonItem appearanceWhenContainedIn:[PARNavigationBar class], nil] setTintColor:UICOLOR_TINT];

    NSLog(@"[[UIDevice currentDevice] platformString]  %@", [[UIDevice currentDevice] localizedModel] );
    
    lowPerformance = [@[@"iPhone3,1", @"iPhone2,1", @"iPod3,1"] containsObject:machineName()];
    
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


NSString* machineName(){
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

@end
