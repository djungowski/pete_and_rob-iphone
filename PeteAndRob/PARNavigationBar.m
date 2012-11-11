//
//  PARNavigationBar.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 07.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARNavigationBar.h"

@implementation PARNavigationBar

// init from storyboard
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIImage *background = [UIImage imageNamed:@"navigation-bar.png"];
        UIImage *backgroundLandscape = [UIImage imageNamed:@"navigation-bar-landscape.png"];
        [self setBackgroundImage:background forBarMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:backgroundLandscape forBarMetrics:UIBarMetricsLandscapePhone];
        
        self.titleTextAttributes = @{ UITextAttributeFont: FONT_BOLD(FONTSIZE_DEFAULT) };
    }
    return self;
}

@end
