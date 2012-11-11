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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)setWallpaper:(PARWallpaper*)wallpaper
{
    self.titleLabel.text = wallpaper.title;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.imageView.image = wallpaper.image;
    
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.imageView.layer.borderWidth = 1.5;
    
    if (!self.imageView.image) {
        self.imageView.image = [UIImage imageNamed:@"pete-and-rob-logo.png"];
        __weak PARWallpaperCell *weakSelf = self;
        [wallpaper onLowImageLoaded:^(UIImage *image) {
            // cell can be dequeued
            if(![weakSelf.titleLabel.text isEqualToString:wallpaper.title]){
                return;
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.imageView.alpha = 0;
            } completion:^(BOOL finished) {
                weakSelf.imageView.image = wallpaper.image;
                [UIView animateWithDuration:0.3 animations:^{
                    weakSelf.imageView.alpha = 1;
                }];
            }];
        }];
    }
}
@end
