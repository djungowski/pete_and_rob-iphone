//
//  PARAppDelegate.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARAppDelegate.h"
#import "PARViewController.h"
#import "PARVideo.h"
#import "PARXMLParserDelegate.h"
#import "PARNavigationBar.h"

@implementation PARAppDelegate

@synthesize videos;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[PARViewController alloc] initWithNibName:@"PARViewController" bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithNavigationBarClass:[PARNavigationBar class] toolbarClass:nil];
    [self.navController pushViewController:self.viewController animated:YES];
    
    self.window.rootViewController = self.navController;
    
    self.videos = [[NSMutableArray alloc] init];
    
    NSURL* url = [NSURL URLWithString:@"http://www.peteandrob.com/rss/podcast.php"];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    PARXMLParserDelegate *parserDelegate = [[PARXMLParserDelegate alloc] init];
    [parser setDelegate:parserDelegate];
//    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
//    [parser setShouldReportNamespacePrefixes:NO]; //
//    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
    [parser parse];
    
    self.videos = parserDelegate.videos;
    
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