//
//  PARVideosRequest.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 10.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARVideosResponse.h"
#import "NSObject+JsonMappable.h"
#import "PARVideo.h"

@implementation PARVideosResponse

- (id)initWithJson:(id)object
{
    self = [super init];
    if(self){
        [self transformFromJson:object extractPayload:^(NSDictionary *payload) {
            __block NSMutableArray* videos = [NSMutableArray new];
           [payload[@"videos"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
               [videos addObject:[[PARVideo alloc] initWithJson:obj]];
           }];
            self.videos = videos;
        }];
    }
    return self;
}

@end
