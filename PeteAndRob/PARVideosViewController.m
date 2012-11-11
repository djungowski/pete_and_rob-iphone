//
//  PARVideosViewController.m
//  Pete & Rob
//
//  Created by Dominik Jungowski on 09.11.12.
//  Copyright (c) 2012 Dominik Jungowski. All rights reserved.
//

#import "PARVideosViewController.h"
#import "PARAppDelegate.h"
#import "PARVideo.h"
#import "PARVideoDetailViewController.h"
#import "PARVideosTableViewCell.h"
#import "PARWebServiceManager.h"
#import "PARVideosResponse.h"
#import "PARVideoDetailViewController.h"

@interface PARVideosViewController ()

@end

static NSString* CELL_VIDEOS  = @"cell_videos";

@implementation PARVideosViewController{
    __block BOOL didLoadCompleteList;
    __block BOOL isRequestingVideos;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Adventures";
    _videos = @[];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshView];
    [[self tableView] deselectRowAtIndexPath:[[self tableView] indexPathForSelectedRow] animated:YES];
}

#pragma mark private

- (void)refreshView
{
    [self.refreshControl endRefreshing];
    if(isRequestingVideos) return;
    
    if(!didLoadCompleteList){
        isRequestingVideos = YES;
        __weak id weakSelf = self;
        __block int count = [_videos count];
        __block NSMutableArray *videosAfterUpdate = [_videos mutableCopy];
        [[PARWebServiceManager sharedInstance] videosStartingAtIndex:count completion:^(PARVideosResponse *response) {
            NSArray* videosToBeAdded = response.videos;
            if([videosToBeAdded count] < 1){
                return;
            }
            if([videosToBeAdded count] < NUMBER_RSS_ITEMS){
                didLoadCompleteList = YES;
            }
            
            // update videos 
            [videosAfterUpdate addObjectsFromArray:videosToBeAdded];
            [weakSelf setVideos:videosAfterUpdate];
            
            __block NSMutableArray* paths = [@[] mutableCopy];
            [videosToBeAdded enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [paths addObject:[NSIndexPath indexPathForRow:(count + idx) inSection:0]];
            }];
            [[weakSelf tableView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            isRequestingVideos = NO;
        }];
    }
}

#pragma mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id video = [_videos objectAtIndex:[[self tableView] indexPathForSelectedRow].row];
    [[segue destinationViewController] setVideo:video];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_videos count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_ROW_VIDEO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_VIDEOS];
    [(PARVideosTableViewCell*)cell setVideo:_videos[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!didLoadCompleteList && indexPath.row + 1 == [_videos count]){
      [self refreshView];
    }
}


@end
