//
//  PARWallpaperDetailController.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 12.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARWallpaperDetailController.h"
#import "PARWallpaper.h"
#import "PARAppDelegate.h"

@interface PARWallpaperDetailController ()

@end

@implementation PARWallpaperDetailController{
    UIActionSheet *sheet;
    NSString *urlToSave;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    sheet = [[UIActionSheet alloc] initWithTitle:@"Save wallpaper" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = _wallpaper.title;
    self.imageView.image = _wallpaper.image;
}

#pragma mark IBActions

- (IBAction)lowTouched:(id)sender
{
    if(![PARAppDelegate isOnline]){
        return;
    }
    urlToSave = _wallpaper.lowImageUrl;
    [sheet setTitle:@"Save wallpaper 320x240"];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

- (IBAction)normalTouched:(id)sender
{
    if(![PARAppDelegate isOnline]){
        return;
    }
    urlToSave = _wallpaper.normalImageUrl;
    [sheet setTitle:@"Save wallpaper 640x960"];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

- (IBAction)highTouched:(id)sender
{
    if(![PARAppDelegate isOnline]){
        return;
    }
    urlToSave = _wallpaper.highImageUrl;
    [sheet setTitle:@"Save wallpaper 640x1136"];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // cancel
    if(buttonIndex == 1){
        return;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlToSave]]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

@end
