//
//  PARVideo.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PARVideo : NSObject

- (id)initWithJson:(id)json;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *imageString;
@property (strong, nonatomic) UIImage *image;

- (void)onImageLoaded:(UIImageBlock)handler;

@end
