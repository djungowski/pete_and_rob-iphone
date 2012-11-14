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
static NSString* CELL_LOADING  = @"cell_loading";

@implementation PARVideosViewController{
    __block BOOL didLoadCompleteList;
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
    self.title = @"Stop Motion Films";
    _videos = @[];
    
    // Pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh..."];
    [self.refreshControl addTarget:self action:@selector(refreshAndClear) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:NOTIFICATION_REACHABILITY_CHANGED
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    if([PARAppDelegate isOnline]){
        [self refreshAndAdd];
    } else {
        didLoadCompleteList = YES;
        [self.refreshControl endRefreshing];
        [self.refreshControl setEnabled:NO];
        // TODO add View
    }
    [[self tableView] deselectRowAtIndexPath:[[self tableView] indexPathForSelectedRow] animated:YES];
}

-(void)reachabilityChanged:(NSNotification*)notification
{
    BOOL isOnline = [[notification userInfo][KEY_REACHABILITY] boolValue];
    if(isOnline){
        if([_videos count] < 1){
            [self refreshAndAdd];
        }
        [self.refreshControl setEnabled:YES];
    } else {
        [self.refreshControl setEnabled:NO];
    }
}

#pragma mark private

- (void)refreshAndClear
{
    [self refreshVideos:0];
}

- (void)refreshAndAdd
{
    [self refreshVideos:[_videos count]];    
}

- (void)refreshVideos:(int)startingIndex
{
    [self.refreshControl endRefreshing];
    BOOL startAtIndexZero = startingIndex == 0;
    if(!didLoadCompleteList || startAtIndexZero){
        __weak id weakSelf = self;
        __block int count = startingIndex;
        __block NSMutableArray *videosAfterUpdate = startAtIndexZero ? [@[] mutableCopy] : [_videos mutableCopy];
        NSString *firstVideoTitle = [_videos count] > 0 ? [_videos[0] title] : nil;
        //
        [[PARWebServiceManager sharedInstance] videosStartingAtIndex:count completion:^(PARVideosResponse *response) {
            didLoadCompleteList = [response.videos count] < NUMBER_RSS_ITEMS;
            // 1. no response 
            if([response.videos count] < 1){
                [[weakSelf tableView] deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
                return;
            }
            // 2. no new videos after pull
            if([firstVideoTitle isEqualToString:[response.videos[0] title]]){
                return;
            }
            [videosAfterUpdate addObjectsFromArray:response.videos];
            [weakSelf setVideos:videosAfterUpdate];
            
            // 3. reload after startAtIndexZero
            if(startAtIndexZero){
                [[weakSelf tableView] reloadData];
                return;
            }
            
            // 4. add new videos
            __block NSMutableArray* paths = [@[] mutableCopy];
            [response.videos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [paths addObject:[NSIndexPath indexPathForRow:(count + idx) inSection:0]];
            }];
            [[weakSelf tableView] beginUpdates];
            if(didLoadCompleteList){
                [[weakSelf tableView] deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
            }
            [[weakSelf tableView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [[weakSelf tableView] endUpdates];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return didLoadCompleteList ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [_videos count];
        default:
            return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_ROW_VIDEO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_VIDEOS];
            [(PARVideosTableViewCell*)cell setVideo:_videos[indexPath.row]];
            return cell;
        }
            
        default:{
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_LOADING];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!didLoadCompleteList && indexPath.section == 1){
      [self refreshAndAdd];
    }
}


@end
