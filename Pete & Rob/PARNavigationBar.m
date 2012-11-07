//
//  PARNavigationBar.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 07.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARNavigationBar.h"

@implementation PARNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *background = [UIImage imageNamed:@"navigation-bar.png"];
        UIImage *backgroundLandscape = [UIImage imageNamed:@"navigation-bar-landscape.png"];
        [self setBackgroundImage:background forBarMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:backgroundLandscape forBarMetrics:UIBarMetricsLandscapePhone];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
