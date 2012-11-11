//
//  PARWebServiceManager.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 10.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PARWebServiceManager : NSObject

+ (id)sharedInstance;

- (void)videosStartingAtIndex:(int)start completion:(PARVideosResponseBlock)completion;
- (void)wallpapersStartingAtIndex:(int)start completion:(PARWallpapersResponseBlock)completion;

@end
