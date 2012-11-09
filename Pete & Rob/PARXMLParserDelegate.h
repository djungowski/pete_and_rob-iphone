//
//  PARXMLParserDelegate.h
//  Pete & Rob
//
//  Created by Dominik Jungowski on 06.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PARVideo.h"

@interface PARXMLParserDelegate : NSObject <NSXMLParserDelegate> {
    NSMutableString *currentProperty;
    PARVideo *currentVideo;
}

@property (strong, nonatomic) NSMutableArray *videos;
@property int offset;
@property int total;

- (NSMutableArray *)parse:(NSData *)responseData;

@end
