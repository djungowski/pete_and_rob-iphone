//
//  PARAppDelegate.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARVideo.h"

@class PARVideosViewController;

@interface PARAppDelegate : UIResponder <UIApplicationDelegate, NSXMLParserDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PARVideosViewController *viewController;

@property (strong, nonatomic) NSMutableArray *videos;

@property (strong, nonatomic) UINavigationController *navController;

@end
