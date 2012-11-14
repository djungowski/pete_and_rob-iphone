//
//  PARWebServiceManager.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 10.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARWebServiceManager.h"
#import "PARVideosResponse.h"
#import "PARAppDelegate.h"
#import "PARWallpapersResponse.h"

@implementation PARWebServiceManager{
    __block BOOL isRequestingVideos;
    __block BOOL isRequestingWallpapers;
}

+ (id)sharedInstance
{
    static dispatch_once_t pred;
    static PARWebServiceManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[PARWebServiceManager alloc] initShared];
    });
    return shared;
}

-(id)init
{
    return nil;
}

-(id)initShared
{
    self = [super init];
    if(self){

    }
    return self;
}

#pragma mark webservice methods

- (void)videosStartingAtIndex:(int)start completion:(PARVideosResponseBlock)completion
{
    if(isRequestingVideos) return;
    if(![PARAppDelegate isOnline]) return;
    isRequestingVideos = YES;
    
    IdBlock callback = ^(id json){
        PARVideosResponse* response = nil;
        if(json){
            response = [[PARVideosResponse alloc] initWithJson:json];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(response);
            isRequestingVideos = NO;
        });
    };
    int limit = NUMBER_RSS_ITEMS;
    NSString *urlString = [NSString stringWithFormat:@"%@?start=%d&limit=%d", URL_VIDEOS, start, limit];
    NSURL *url = [NSURL URLWithString:urlString];
    [self getJSONFromURL:url callback:callback];
}


- (void)wallpapersStartingAtIndex:(int)start completion:(PARWallpapersResponseBlock)completion
{
    if(isRequestingWallpapers) return;
    if(![PARAppDelegate isOnline]) return;
    isRequestingWallpapers = YES;
    
    IdBlock callback = ^(id json){
        PARWallpapersResponse* response = nil;
        if(json){
            response = [[PARWallpapersResponse alloc] initWithJson:json];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(response);
            isRequestingWallpapers = NO;
        });
    };
    int limit = NUMBER_RSS_ITEMS;
    NSString *urlString = [NSString stringWithFormat:@"%@?start=%d&limit=%d", URL_WALLPAPERS, start, limit];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self getJSONFromURL:url callback:callback];
}

- (void)getJSONFromURL:(NSURL*)url callback:(IdBlock)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError* error = nil;
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if(!data){
            callback(nil);
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        callback(error ? nil : json);
    });
}

@end
