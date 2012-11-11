//
//  NSObject+Hardware.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "NSObject+Hardware.h"
#import "PARAppDelegate.h"

@implementation NSObject (Hardware)

- (BOOL)isLowPerformanceDevice
{
    return [(PARAppDelegate*)[[UIApplication sharedApplication] delegate] isLowPerformanceDevice];
}

@end
