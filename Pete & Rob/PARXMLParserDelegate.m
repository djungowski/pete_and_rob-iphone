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
    return self;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!currentProperty) {
        currentProperty = [[NSMutableString alloc] initWithString:string];
    } else {
        [currentProperty appendString:string];
    }
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString: @"item"]) {
//        NSLog(@"Started Element: %@", elementName);
        currentVideo = [[PARVideo alloc] init];
//        NSLog(@"%@", currentVideo);
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString: @"title"]) {
//        NSLog(@"%@", currentProperty);
        //        NSLog(@"%@", currentVideo);
        currentVideo.title = currentProperty;
        currentVideo.title = [currentVideo.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    else if ([elementName isEqualToString: @"guid"]) {
//        NSLog(@"GUID: %@", currentProperty);
        //        NSLog(@"%@", currentVideo);
        currentVideo.url = currentProperty;
        currentVideo.url = [currentVideo.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    else if ([elementName isEqualToString: @"item"] && currentVideo) {
//        NSLog(@"%@", currentVideo);
        [self.videos addObject:currentVideo];
        currentVideo = nil;
    }
    //    self.currentProperty = nil;
    //    NSLog(@"Ended Element: %@", elementName);
    currentProperty = nil;
}

@end
