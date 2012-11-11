//
//  NSObject+JsonMappable.m
//
//  Created by Elmar Kretzer on 15.12.11.
//  Copyright (c) 2011 symentis. All rights reserved.
//

#import "NSObject+JsonMappable.h"

@implementation NSObject (JsonMappable)

- (id)toJson
{
    return nil;
}

- (id)initWithJson:(id)object{
    return nil;
}

- (NSDictionary*)jsonMapping
{
    return nil;    
}

- (NSString*)jsonRootElement
{
    return nil;
}

#pragma mark - MappableResponse

- (void)transformFromJson:(id)response
{
	[self transformFromJson:response extractPayload:nil];
}

- (void)transformFromJson:(id)response extractPayload:(NSDictionaryBlock) block
{
    // handle direct properties of object
    [[self jsonMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setValue:[response objectForKey:obj] forKeyPath:key];
    }];
    // perform customization for e.g. nested objects
    if(block != nil){
        // perform changes on dict
        block(response);
    }
}

@end
