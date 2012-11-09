//
//  PARDataVideos.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 09.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PARVideo.h";

@interface PARDataVideos : NSObject {
    PARVideo *currentVideo;
}

@property (strong, nonatomic) NSMutableArray *videos;
@property int offset;
@property int total;

- (void)load:(int)loadingStart;
- (NSMutableArray *)parse:(NSData *)responseData;
- (void)parsingFinished:(NSNotification *)parsedVideos;
- (void)addParsingObserver:(id)observer;

@end
