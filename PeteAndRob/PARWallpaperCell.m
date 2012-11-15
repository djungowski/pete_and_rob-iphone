//
//  PARWallpaperCell.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARWallpaperCell.h"
#import "PARWallpaper.h"

@implementation PARWallpaperCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib
{
    self.imageView.layer.masksToBounds = YES;
       
    self.titleLabel.font = FONT_DEFAULT(FONTSIZE_DEFAULT);
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setWallpaper:(PARWallpaper*)wallpaper
{
    self.titleLabel.text = wallpaper.title;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.imageView.layer.borderWidth = 1.5;
    self.imageView.image = wallpaper.image;
    
    if (!self.imageView.image) {
        self.imageView.layer.borderWidth = 0;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.image = [UIImage imageNamed:@"pete-and-rob-logo.png"];
        __weak PARWallpaperCell *weakSelf = self;
        [wallpaper onLowImageLoaded:^(UIImage *image) {
            // cell can be dequeued
            if(![weakSelf.titleLabel.text isEqualToString:wallpaper.title]){
                return;
            }
            weakSelf.imageView.contentMode = UIViewContentModeScaleAspectFill;
            weakSelf.imageView.layer.borderWidth = 1.5;
            if([self isLowPerformanceDevice]){
                weakSelf.imageView.image = wallpaper.image;
                return;
            } 
            weakSelf.imageView.alpha = 0;
            weakSelf.imageView.image = wallpaper.image;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.imageView.alpha = 1;
            }];
        }];
    }
}

@end
