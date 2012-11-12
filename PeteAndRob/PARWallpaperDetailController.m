//
//  PARWallpaperDetailController.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 12.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARWallpaperDetailController.h"
#import "PARWallpaper.h"
#import "PARWallpaperWebViewController.h"

@interface PARWallpaperDetailController ()

@end

@implementation PARWallpaperDetailController

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

    _lowImageButton.tintColor = UICOLOR_TINT;
    _normalImageButton.tintColor = UICOLOR_TINT;
    _highImageButton.tintColor = UICOLOR_TINT;
    
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 5;
    _imageView.layer.borderColor = [UIColor grayColor].CGColor;
    _imageView.layer.borderWidth = 1.5;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = _wallpaper.title;
    self.imageView.image = _wallpaper.image;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender == _lowImageButton){
        [[segue destinationViewController] setUrl:_wallpaper.lowImageUrl];
        return;
    }
    if(sender == _normalImageButton){
        [[segue destinationViewController] setUrl:_wallpaper.normalImageUrl];
        return;
    }
    if(sender == _highImageButton){
        [[segue destinationViewController] setUrl:_wallpaper.highImageUrl];
        return;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
