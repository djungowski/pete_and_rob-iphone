//
//  NSObject+JsonMappable.h
//
//  Created by Elmar Kretzer on 15.12.11.
//  Copyright (c) 2011 symentis. All rights reserved.
//
#import "Blocks.h"

@interface NSObject (JsonMappable)

- (id)toJson;
- (id)initWithJson:(id)object;

- (NSDictionary*)jsonMapping;
- (NSString*)jsonRootElement;

- (void)transformFromJson:(id)response;
- (void)transformFromJson:(id)response extractPayload:(NSDictionaryBlock) block;

@end
