//
//  PARVideo.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PARVideo : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSString *imageString;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *description;

- (UIImage *)getImage;

@end
