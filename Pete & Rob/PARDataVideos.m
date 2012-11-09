//
//  PARDataVideos.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 09.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARDataVideos.h"

@implementation PARDataVideos

@synthesize videos;

- (void)load:(int)loadingStart
{
    self.videos = [[NSMutableArray alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@%d", @"http://www.peteandrob.com/rss/videos.php?start=", loadingStart];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self parse:data];
}

- (id)init
{
    self = [super init];
    self.videos = [[NSMutableArray alloc] init];
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
