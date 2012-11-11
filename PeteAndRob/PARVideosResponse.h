//
//  PARVideosRequest.h
//  PeteAndRob
//
//  Created by Elmar Kretzer on 10.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PARAbstractResponse.h"

@interface PARVideosResponse : PARAbstractResponse

- (id)initWithJson:(id)object;

@property (strong, nonatomic) NSArray *videos;

@end
