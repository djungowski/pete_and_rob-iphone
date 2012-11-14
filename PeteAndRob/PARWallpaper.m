//
//  PARWallpaper.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARWallpaper.h"
#import "NSObject+JsonMappable.h"
#import "PARAppDelegate.h"

@implementation PARWallpaper

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
            @"lowImageUrl":@"low",
            @"normalImageUrl":@"normal",
            @"highImageUrl":@"high"
    };
}

- (NSString*)description
{
    return _title;
}

- (void)onLowImageLoaded:(UIImageBlock)handler
{
    if(!handler) return;
    if(_image){
        dispatch_sync(dispatch_get_main_queue(), ^{
            handler(_image);
        });
    }
    if([PARAppDelegate isOnline] == NO){
        return;
    }
    __weak id weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *imageURL = [NSURL URLWithString:_lowImageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        if(!imageData){
            return;
        }
        [weakSelf setImage:[UIImage imageWithData:imageData]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            handler([weakSelf image]);
        });
    });
}

@end
