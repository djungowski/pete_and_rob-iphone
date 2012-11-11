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
    __block BOOL isRequestingWallpapers;
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
    [self refreshView];
}

- (void)refreshView
{
    if(isRequestingWallpapers) return;
    
    if(!didLoadCompleteList){
        isRequestingWallpapers = YES;
        __weak id weakSelf = self;
        __block int count = [_wallpapers count];
        __block NSMutableArray *videosAfterUpdate = [_wallpapers mutableCopy];
        [[PARWebServiceManager sharedInstance] wallpapersStartingAtIndex:count completion:^(PARWallpapersResponse *response) {
            NSArray* wallpapersToBeAdded = response.wallpapers;
            if([wallpapersToBeAdded count] < 1){
                return;
            }
            if([wallpapersToBeAdded count] < NUMBER_RSS_ITEMS){
                didLoadCompleteList = YES;
            }
            
            // update wallapers
            [videosAfterUpdate addObjectsFromArray:wallpapersToBeAdded];
            [weakSelf setWallpapers:videosAfterUpdate];
            
            __block NSMutableArray* paths = [@[] mutableCopy];
            [wallpapersToBeAdded enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [paths addObject:[NSIndexPath indexPathForRow:(count + idx) inSection:0]];
            }];
            
            [[weakSelf collectionView] insertItemsAtIndexPaths:paths];
            isRequestingWallpapers = NO;
        }];
    }
}

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
