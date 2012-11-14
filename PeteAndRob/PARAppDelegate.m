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
#import "Reachability.h"
#import "PARWebServiceManager.h"

@implementation PARAppDelegate{
    BOOL lowPerformance;
    Reachability* internetReach;
    BOOL isOnline;
}

- (BOOL)isLowPerformanceDevice
{
    return lowPerformance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _tabBarController = (UITabBarController *)self.window.rootViewController;

    [[UIBarButtonItem appearanceWhenContainedIn:[PARNavigationBar class], nil] setTintColor:UICOLOR_TINT];
    
    lowPerformance = [@[@"iPhone3,1", @"iPhone2,1", @"iPod3,1"] containsObject:machineName()];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    // init for notifications
    [PARWebServiceManager sharedInstance];
    
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
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    [self updateInterfaceWithReachability:internetReach];
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

//Called by Reachability whenever status changes.
- (void)reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

- (void)updateInterfaceWithReachability: (Reachability*) curReach
{
    BOOL notify = NO;
    if(NotReachable != [curReach currentReachabilityStatus]){
        if(!isOnline){
            notify = YES; 
        }
        isOnline = YES;
    } else {
        if(isOnline){
            notify = YES;
        }
        isOnline = NO;
    }
    if(notify){
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NOTIFICATION_REACHABILITY_CHANGED object:nil userInfo:@{KEY_REACHABILITY:@(isOnline)}]];
    }
        
}

-(BOOL)isOnline
{
   return isOnline;  
}

+(BOOL)isOnline
{
    return [(PARAppDelegate*)[[UIApplication sharedApplication] delegate] isOnline];
}

@end
