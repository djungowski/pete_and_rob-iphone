//
//  PARWallpapersResponse.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARWallpapersResponse.h"
#import "NSObject+JsonMappable.h"
#import "PARWallpaper.h"

@implementation PARWallpapersResponse

- (id)initWithJson:(id)object
{
    self = [super init];
    if(self){
        [self transformFromJson:object extractPayload:^(NSDictionary *payload) {
            __block NSMutableArray* wallpapers = [NSMutableArray new];
            [payload[@"wallpaper"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [wallpapers addObject:[[PARWallpaper alloc] initWithJson:obj]];
            }];
            self.wallpapers = wallpapers;
        }];
    }
    return self;
}

@end
