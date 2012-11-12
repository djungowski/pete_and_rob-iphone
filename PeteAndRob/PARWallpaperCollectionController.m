//
//  PARWallpaperCollectionController.m
//  PeteAndRob
//
//  Created by Elmar Kretzer on 11.11.12.
//  Copyright (c) 2012 PeteAndRob. All rights reserved.
//

#import "PARWallpaperCollectionController.h"
#import "PARWebServiceManager.h"
#import "PARWallpapersResponse.h"
#import "PARWallpaperCell.h"
#import "PARWallpaper.h"

@interface PARWallpaperCollectionController ()

@end

@implementation PARWallpaperCollectionController{
    __block BOOL didLoadCompleteList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _wallpapers = @[];
    self.title = @"Wallpapers";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshAndClear];
    [[self collectionView] flashScrollIndicators];
}

#pragma mark private

- (void)refreshAndClear
{
    [self refresh:0];
}

- (void)refreshAndAdd
{
    [self refresh:[_wallpapers count]];
}

- (void)refresh:(int)startingIndex
{
    BOOL startAtIndexZero = startingIndex == 0;
    if(!didLoadCompleteList || startAtIndexZero){
        __weak id weakSelf = self;
        __block int count = startingIndex;
        __block NSMutableArray *videosAfterUpdate = startAtIndexZero ? [@[] mutableCopy] : [_wallpapers mutableCopy];
        NSString *firstVideoTitle = [_wallpapers count] > 0 ? [_wallpapers[0] title] : nil;
        //
        [[PARWebServiceManager sharedInstance] wallpapersStartingAtIndex:count completion:^(PARWallpapersResponse *response) {
            didLoadCompleteList = [response.wallpapers count] < NUMBER_RSS_ITEMS;
            // 1. no response
            if([response.wallpapers count] < 1){
                [[weakSelf tableView] deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
                return;
            }
            // 2. no new videos after pull
            if([firstVideoTitle isEqualToString:[response.wallpapers[0] title]]){
                return;
            }
            [videosAfterUpdate addObjectsFromArray:response.wallpapers];
            [weakSelf setWallpapers:videosAfterUpdate];
            
            // 3. reload after startAtIndexZero
            if(startAtIndexZero){
                [[weakSelf collectionView] reloadData];
                return;
            }
            
            // 4. add new videos
            __block NSMutableArray* paths = [@[] mutableCopy];
            [response.wallpapers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [paths addObject:[NSIndexPath indexPathForRow:(count + idx) inSection:0]];
            }];
            [[weakSelf collectionView] insertItemsAtIndexPaths:paths];
        }];
    }
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_wallpapers count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160,200);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PARWallpaperCell * cell = [[self collectionView] dequeueReusableCellWithReuseIdentifier:@"wallpaper_cell" forIndexPath:indexPath];
    [cell setWallpaper:_wallpapers[indexPath.row]];
    return cell;
}

@end
