//
//  PARWallpaper.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PARWallpaper : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *lowImageUrl;
@property (strong, nonatomic) NSString *normalImageUrl;
@property (strong, nonatomic) NSString *highImageUrl;
@property (strong, nonatomic) UIImage *image;

- (id)initWithJson:(id)json;
- (void)onLowImageLoaded:(UIImageBlock)handler;

@end
