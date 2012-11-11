//
//  PARWallpapersResponse.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARAbstractResponse.h"

@interface PARWallpapersResponse : PARAbstractResponse

- (id)initWithJson:(id)object;

@property (strong, nonatomic) NSArray *wallpapers;


@end
