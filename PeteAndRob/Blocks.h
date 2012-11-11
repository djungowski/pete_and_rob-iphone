//
//  Blocks.h
//
//  Created by Elmar Kretzer on 14.12.11.
//  Copyright (c) 2011 symentis. All rights reserved.
//

#ifndef PAR_Blocks_h
#define PAR_Blocks_h
@class PARVideosResponse;
@class PARAbstractResponse;
@class PARWallpapersResponse;

// type definition for a Block
typedef void (^BasicBlock)(void);

// type definition for a Block with UILabel Param
typedef void(^UILabelBlock)(UILabel* label);

// type definition for a Block with UILabel Param
typedef void(^UIButtonBlock)(UIButton* button);

// type definition for a Block with NSMutableDictionary Param
typedef void(^NSMutableDictionaryBlock)(NSMutableDictionary* dict);

// type definition for a Block with NSDictionary Param
typedef void(^NSDictionaryBlock)(NSDictionary* dict);

// type definition for a Block with NSArray Param
typedef void(^NSArrayBlock)(NSArray* array);

// type definition for a Block with UIImage Param
typedef void(^UIImageBlock)(UIImage* image);

// type definition for a Block with NSString Param
typedef void(^NSStringBlock)(NSString* string);

// type definition for a Block with id  Param
typedef void(^IdBlock)(id object);

// type definition for a Block with UIView Param
typedef void(^UIViewBlock)(UIView *view);

//type definition for a Block with PARVideosResponse Param
typedef void(^PARVideosResponseBlock)(PARVideosResponse* response);

typedef void(^PARWallpapersResponseBlock)(PARWallpapersResponse* response);


#endif
