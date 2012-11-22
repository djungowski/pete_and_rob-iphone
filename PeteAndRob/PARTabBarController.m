//
//  PARTabBarController.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 22.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARTabBarController.h"

@interface PARTabBarController ()

@end

@implementation PARTabBarController

void setStatusBar(UIInterfaceOrientation orientation){
    [[UIApplication sharedApplication] setStatusBarHidden:UIInterfaceOrientationIsLandscape(orientation)
                                            withAnimation:UIStatusBarAnimationNone];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    setStatusBar([[UIApplication sharedApplication] statusBarOrientation]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    setStatusBar(toInterfaceOrientation);
}

@end
