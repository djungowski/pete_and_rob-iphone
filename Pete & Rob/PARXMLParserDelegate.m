//
//  PARXMLParserDelegate.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARXMLParserDelegate.h"

@implementation PARXMLParserDelegate

@synthesize videos;

- (id)init
{
    self = [super init];
    self.videos = [[NSMutableArray alloc] init];
//    [self addParsingObserver:self];

    return self;
}

- (void)addParsingObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(parsingFinished:) name:@"parsingFinished" object:nil];
}

- (void)parsingFinished:(NSNotification *)parsedVideos
{
    // Implement in your class that observates
}

- (NSMutableArray *)parse:(NSData *)responseData
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    NSDictionary *videosInfo = [json objectForKey:@"videos"];
    
    NSEnumerator *e = [videosInfo objectEnumerator];
    id movieObject;
    
    while (movieObject = [e nextObject]) {
        PARVideo *video = [[PARVideo alloc] init];
        video.title = [movieObject objectForKey:@"title"];
        video.description = [movieObject objectForKey:@"description"];
        video.url = [movieObject objectForKey:@"video"];
        video.imageString = [movieObject objectForKey:@"image"];
        [self.videos addObject:video];
    }
    
    // Jetzt noch den Offset berechnen
    NSDictionary *info = [json objectForKey:@"info"];
    NSString *start = [info objectForKey:@"start"];
    NSString *limit = [info objectForKey:@"limit"];
    
    self.offset = [start intValue] + [limit intValue];
    self.total = [[info objectForKey:@"total"] intValue];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"parsingFinished" object:self.videos];
    return self.videos;
}

@end
