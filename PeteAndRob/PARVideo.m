//
//  PARVideo.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARVideo.h"
#import "NSObject+JsonMappable.h"

@implementation PARVideo

- (id)initWithJson:(id)object
{
    self = [super init];
    if(self){
        [self transformFromJson:object];
    }
    return self;
}

- (NSDictionary*)jsonMapping
{
    return @{ @"title":@"title",
              @"imageString":@"image",
              @"detail":@"description",
              @"url":@"video"
            };
}

- (NSString*)description
{
    return _title;
}

- (void)onImageLoaded:(UIImageBlock)handler
{
    if(!handler) return;
    if(_image){
        dispatch_sync(dispatch_get_main_queue(), ^{
            handler(_image);
        });
    }
    __weak id weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *imageURL = [NSURL URLWithString:_imageString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if(!imageData){
            return;
        }
        [weakSelf setImage:[UIImage imageWithData:imageData]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            handler(_image);
        });
    });
}

@end
