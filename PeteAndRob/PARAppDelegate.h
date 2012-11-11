//
//  PARAppDelegate.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 10.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

- (BOOL)isLowPerformanceDevice;

@end
