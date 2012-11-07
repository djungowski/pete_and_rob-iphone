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
        currentVideo = [[PARVideo alloc] init];
    }
    else if ([elementName isEqualToString:@"itunes:image"]) {
        NSString *imageString = [[attributeDict objectForKey:@"href"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSURL *imageURL = [NSURL URLWithString:imageString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        currentVideo.image = [UIImage imageWithData:imageData];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString: @"title"]) {
        currentVideo.title = [currentProperty stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    else if ([elementName isEqualToString: @"guid"]) {
        currentVideo.url = [currentProperty stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    else if ([elementName isEqualToString: @"item"] && currentVideo) {
        [self.videos addObject:currentVideo];
        currentVideo = nil;
    }
    currentProperty = nil;
}

@end
