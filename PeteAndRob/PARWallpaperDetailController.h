//
//  PARWallpaperDetailController.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 12.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PARWallpaper;

@interface PARWallpaperDetailController : UIViewController

@property (strong, nonatomic) PARWallpaper* wallpaper;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *lowImageButton;
@property (weak, nonatomic) IBOutlet UIButton *normalImageButton;
@property (weak, nonatomic) IBOutlet UIButton *highImageButton;

@end
