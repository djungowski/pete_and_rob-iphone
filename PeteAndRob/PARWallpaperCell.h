//
//  PARWallpaperCell.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PARWallpaper;

@interface PARWallpaperCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setWallpaper:(PARWallpaper*)wallpaper;

@end
